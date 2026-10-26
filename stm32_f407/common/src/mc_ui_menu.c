#include "mc_ui_menu.h"

static const unsigned int k_first[] = {0U, 4U, 9U, 14U};
/* Display whitelist only. All 20 backend/CLI fault IDs remain unchanged. */
static const unsigned int k_fault_count[] = {3U, 2U, 2U, 3U};
static const mc_fault_id_t k_visible_faults[][3] = {
    {MC_FAULT_SPI_PARTIAL, MC_FAULT_SPI_SHORT, MC_FAULT_SPI_EXTRA},
    {MC_FAULT_UART_BAD_STOP, MC_FAULT_UART_BREAK, MC_FAULT_COUNT},
    {MC_FAULT_I2C_ADDRESS_NACK, MC_FAULT_I2C_NO_STOP, MC_FAULT_COUNT},
    {MC_FAULT_CAN_STUFF, MC_FAULT_CAN_CRC, MC_FAULT_CAN_FORM}
};
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
        entry.fault = k_visible_faults[protocol][index - k_normal_count[protocol]];
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
    unsigned int p, i;
    if (menu == 0 || (unsigned int)fault >= MC_FAULT_COUNT) { return MC_ERR_ARGUMENT; }
    for (p = 0U; p < MC_UI_PROTOCOL_COUNT; ++p) {
        for (i = 0U; i < k_fault_count[p]; ++i) {
            if (fault == k_visible_faults[p][i]) {
                menu->protocol = (mc_ui_protocol_t)p;
                menu->item = k_normal_count[p] + i;
                menu->in_submenu = 1U;
                return MC_OK;
            }
        }
    }
    /* A CLI-only selection must not reveal a hidden row or highlight a
       different test. Return to that protocol's parent instead. */
    for (p = MC_UI_PROTOCOL_COUNT; p > 0U; --p) {
        if ((unsigned int)fault >= k_first[p - 1U]) {
            menu->protocol = (mc_ui_protocol_t)(p - 1U);
            menu->item = 0U;
            menu->in_submenu = 0U;
            break;
        }
    }
    return MC_ERR_UNSUPPORTED;
}
