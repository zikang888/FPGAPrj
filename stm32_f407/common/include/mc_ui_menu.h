#ifndef MC_UI_MENU_H
#define MC_UI_MENU_H

#include "mc_faults.h"

typedef enum { MC_UI_SPI, MC_UI_UART, MC_UI_I2C, MC_UI_CAN, MC_UI_PROTOCOL_COUNT } mc_ui_protocol_t;
typedef enum {
    MC_UI_NAVIGATE, MC_UI_FAULT, MC_UI_SPI_JEDEC, MC_UI_SPI_PATTERN,
    MC_UI_UART_ECHO, MC_UI_I2C_EEPROM, MC_UI_CAN_TX, MC_UI_CAN_ECHO, MC_UI_BACK
} mc_ui_action_t;
typedef struct {
    const char *label;
    mc_ui_action_t action;
    mc_fault_id_t fault;
} mc_ui_entry_t;
typedef struct {
    mc_ui_protocol_t protocol;
    unsigned int item;
    unsigned int in_submenu;
} mc_ui_menu_t;

void mc_ui_menu_init(mc_ui_menu_t *menu);
const char *mc_ui_protocol_name(mc_ui_protocol_t protocol);
unsigned int mc_ui_menu_count(mc_ui_protocol_t protocol);
mc_ui_entry_t mc_ui_menu_entry(mc_ui_protocol_t protocol, unsigned int index);
void mc_ui_menu_next(mc_ui_menu_t *menu);
/* Navigation returns NAVIGATE, never a transmission action. One call per hold. */
mc_ui_entry_t mc_ui_menu_confirm(mc_ui_menu_t *menu);
/* Hidden, valid CLI cases return UNSUPPORTED and show their protocol parent. */
int mc_ui_menu_select_fault(mc_ui_menu_t *menu, mc_fault_id_t fault);

#endif
