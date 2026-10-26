#include "mc_ui_menu.h"

static const unsigned int k_first[] = {0U, 4U, 9U, 14U};
static const unsigned int k_fault_count[] = {4U, 5U, 5U, 6U};
static const unsigned int k_normal_count[] = {2U, 1U, 1U, 2U};
static const mc_ui_entry_t k_normals[][2] = {
    {{"NORMAL JEDEC", MC_UI_SPI_JEDEC, MC_FAULT_COUNT},
     {"NORMAL PATTERN", MC_UI_SPI_PATTERN, MC_FAULT_COUNT}},
    {{"NORMAL ECHO", MC_UI_UART_ECHO, MC_FAULT_COUNT},
     {0, MC_UI_NAVIGATE, MC_FAULT_COUNT}},
    {{"NORMAL EEPROM", MC_UI_I2C_EEPROM, MC_FAULT_COUNT},
     {0, MC_UI_NAVIGATE, MC_FAULT_COUNT}},
    {{"NORMAL TX", MC_UI_CAN_TX, MC_FAULT_COUNT},
     {"NORMAL ECHO", MC_UI_CAN_ECHO, MC_FAULT_COUNT}}
};

void mc_ui_menu_init(mc_ui_menu_t *menu)
{
    if (menu != 0) {
        menu->protocol = MC_UI_SPI;
        menu->item = 0U;
        menu->in_submenu = 0U;
    }
}

const char *mc_ui_protocol_name(mc_ui_protocol_t protocol)
{
    static const char *const names[] = {"SPI", "UART", "I2C", "CAN"};
    return (unsigned int)protocol < MC_UI_PROTOCOL_COUNT ? names[protocol] : "INVALID";
}

unsigned int mc_ui_menu_count(mc_ui_protocol_t protocol)
{
    if ((unsigned int)protocol >= MC_UI_PROTOCOL_COUNT) { return 0U; }
    return k_normal_count[protocol] + k_fault_count[protocol] + 1U;
}

mc_ui_entry_t mc_ui_menu_entry(mc_ui_protocol_t protocol, unsigned int index)
{
    mc_ui_entry_t entry = {"INVALID", MC_UI_NAVIGATE, MC_FAULT_COUNT};
    unsigned int count = mc_ui_menu_count(protocol);
    if (index >= count) { return entry; }
    if (index < k_normal_count[protocol]) { return k_normals[protocol][index]; }
    if (index == count - 1U) {
        entry.label = "BACK";
        entry.action = MC_UI_BACK;
    } else {
        entry.fault = (mc_fault_id_t)(k_first[protocol] + index - k_normal_count[protocol]);
        entry.label = mc_fault_get(entry.fault)->label;
        entry.action = MC_UI_FAULT;
    }
    return entry;
}

void mc_ui_menu_next(mc_ui_menu_t *menu)
{
    if (menu == 0 || (unsigned int)menu->protocol >= MC_UI_PROTOCOL_COUNT) { return; }
    if (menu->in_submenu) {
        menu->item = (menu->item + 1U) % mc_ui_menu_count(menu->protocol);
    } else {
        menu->protocol = (mc_ui_protocol_t)(((unsigned int)menu->protocol + 1U) % MC_UI_PROTOCOL_COUNT);
    }
}

mc_ui_entry_t mc_ui_menu_confirm(mc_ui_menu_t *menu)
{
    mc_ui_entry_t entry = {"NAVIGATE", MC_UI_NAVIGATE, MC_FAULT_COUNT};
    if (menu == 0 || (unsigned int)menu->protocol >= MC_UI_PROTOCOL_COUNT) { return entry; }
    if (!menu->in_submenu) {
        menu->in_submenu = 1U;
        menu->item = 0U;
        return entry;
    }
    entry = mc_ui_menu_entry(menu->protocol, menu->item);
    if (entry.action == MC_UI_BACK) {
        menu->in_submenu = 0U;
        menu->item = 0U;
        entry.action = MC_UI_NAVIGATE;
    }
    return entry;
}

int mc_ui_menu_select_fault(mc_ui_menu_t *menu, mc_fault_id_t fault)
{
    unsigned int p;
    if (menu == 0 || (unsigned int)fault >= MC_FAULT_COUNT) { return MC_ERR_ARGUMENT; }
    for (p = 0U; p < MC_UI_PROTOCOL_COUNT; ++p) {
        if ((unsigned int)fault >= k_first[p] && (unsigned int)fault < k_first[p] + k_fault_count[p]) {
            menu->protocol = (mc_ui_protocol_t)p;
            menu->item = k_normal_count[p] + (unsigned int)fault - k_first[p];
            menu->in_submenu = 1U;
            return MC_OK;
        }
    }
    return MC_ERR_ARGUMENT;
}
