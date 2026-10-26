#include "mc_ui_menu.h"
#include <stdio.h>
#include <string.h>

#define CHECK(c) do { if (!(c)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #c); return 1; } } while (0)

int main(void)
{
    mc_ui_menu_t menu;
    mc_ui_entry_t entry;
    unsigned int p, i, normals = 0U;
    unsigned int seen[MC_FAULT_COUNT] = {0};
    const unsigned int expected[MC_FAULT_COUNT] = {
        1U, 1U, 1U, 0U, 1U, 1U, 0U, 0U, 0U, 1U,
        0U, 0U, 0U, 1U, 0U, 0U, 1U, 1U, 1U, 0U
    };
    const unsigned int counts[] = {6U, 4U, 4U, 6U};
    mc_ui_menu_init(&menu);
    CHECK(menu.protocol == MC_UI_SPI && !menu.in_submenu);
    /* Parent navigation is always output-free, including wraparound. */
    for (p = 0U; p < MC_UI_PROTOCOL_COUNT; ++p) {
        CHECK(menu.protocol == (mc_ui_protocol_t)p);
        CHECK(mc_ui_menu_count(menu.protocol) == counts[p]);
        entry = mc_ui_menu_confirm(&menu);
        CHECK(entry.action == MC_UI_NAVIGATE && menu.in_submenu && menu.item == 0U);
        for (i = 0U; i < mc_ui_menu_count(menu.protocol); ++i) {
            CHECK(menu.item == i);
            entry = mc_ui_menu_entry(menu.protocol, i);
            if (entry.action == MC_UI_FAULT) {
                CHECK((unsigned int)entry.fault < MC_FAULT_COUNT);
                ++seen[entry.fault];
                CHECK(strcmp(mc_fault_get(entry.fault)->protocol, mc_ui_protocol_name(menu.protocol)) == 0);
                CHECK(mc_ui_menu_confirm(&menu).fault == entry.fault);
            } else if (entry.action != MC_UI_BACK) {
                ++normals;
                CHECK(entry.action >= MC_UI_SPI_JEDEC && entry.action <= MC_UI_CAN_ECHO);
                CHECK(mc_ui_menu_confirm(&menu).action == entry.action);
            }
            mc_ui_menu_next(&menu);
        }
        CHECK(menu.item == 0U && menu.in_submenu);
        menu.item = mc_ui_menu_count(menu.protocol) - 1U;
        CHECK(mc_ui_menu_confirm(&menu).action == MC_UI_NAVIGATE);
        CHECK(!menu.in_submenu && menu.protocol == (mc_ui_protocol_t)p);
        mc_ui_menu_next(&menu);
    }
    CHECK(menu.protocol == MC_UI_SPI && normals == 6U);
    for (i = 0U; i < MC_FAULT_COUNT; ++i) {
        CHECK(seen[i] == expected[i]);
        if (expected[i]) {
            CHECK(mc_ui_menu_select_fault(&menu, (mc_fault_id_t)i) == MC_OK);
            CHECK(mc_ui_menu_confirm(&menu).fault == (mc_fault_id_t)i);
            CHECK(mc_ui_menu_entry(menu.protocol, menu.item).action == MC_UI_FAULT);
        } else {
            CHECK(mc_ui_menu_select_fault(&menu, (mc_fault_id_t)i) == MC_ERR_UNSUPPORTED);
            CHECK(!menu.in_submenu && menu.item == 0U);
            CHECK(strcmp(mc_ui_protocol_name(menu.protocol), mc_fault_get((mc_fault_id_t)i)->protocol) == 0);
            CHECK(mc_ui_menu_confirm(&menu).action == MC_UI_NAVIGATE);
        }
    }
    CHECK(mc_ui_menu_select_fault(&menu, MC_FAULT_COUNT) == MC_ERR_ARGUMENT);
    CHECK(mc_ui_menu_select_fault(0, MC_FAULT_SPI_PARTIAL) == MC_ERR_ARGUMENT);
    CHECK(mc_ui_menu_entry(MC_UI_PROTOCOL_COUNT, 0U).action == MC_UI_NAVIGATE);
    CHECK(mc_ui_menu_entry(MC_UI_SPI, 999U).action == MC_UI_NAVIGATE);
    CHECK(mc_ui_menu_confirm(0).action == MC_UI_NAVIGATE);
    /* Explicit normal mapping: never aliases the last CLI-selected fault. */
    CHECK(mc_ui_menu_entry(MC_UI_SPI, 0U).action == MC_UI_SPI_JEDEC);
    CHECK(mc_ui_menu_entry(MC_UI_SPI, 1U).action == MC_UI_SPI_PATTERN);
    CHECK(mc_ui_menu_entry(MC_UI_UART, 0U).action == MC_UI_UART_ECHO);
    CHECK(mc_ui_menu_entry(MC_UI_I2C, 0U).action == MC_UI_I2C_EEPROM);
    CHECK(mc_ui_menu_entry(MC_UI_CAN, 0U).action == MC_UI_CAN_TX);
    CHECK(mc_ui_menu_entry(MC_UI_CAN, 1U).action == MC_UI_CAN_ECHO);
    puts("UI menu: four parents, six normal actions, exactly 10 visible faults, hidden CLI mapping and BACK PASS");
    return 0;
}
