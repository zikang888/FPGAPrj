#ifndef SAVED_ERROR_TRACE_H
#define SAVED_ERROR_TRACE_H
#include "event_diagnostics.h"
#include "test_history.h"
#include "ui_protocol_select.h"
/* Index one entry per abnormal transaction, even if it has several reasons.
 * The original saved words are never modified or supplemented. */
typedef struct {uint32_t txn, first, last, errors; char label[8];} SavedErrorTxn;
static inline uint32_t saved_error_transactions(const TestHistoryEntry *r,
                                                SavedErrorTxn *out)
{
    uint32_t i,j,n=0U;
    if(!r||!r->snapshot_valid)return 0U;
    for(i=0;i<r->count;++i){char label[8];EventView e=event_view_decode(r->words[i]);
        /* EEPROM write-cycle busy is informational, not an abnormal transaction. */
        if(e.protocol==3U&&e.event_type==0x3fU&&(e.flags>>8)==2U)continue;
        if(e.protocol!=ui_protocol_event_id((UiProtocol)r->protocol) ||
           !event_diagnostic_label(&r->words[0][0],r->count,i,label))continue;
        for(j=0;j<n&&out[j].txn!=e.transaction_id;++j){}
        if(j==n){memset(&out[n],0,sizeof(out[n]));out[n].txn=e.transaction_id;
            out[n].first=i;out[n].last=i;memcpy(out[n].label,label,8U);++n;}
        ++out[j].errors;
    }
    for(j=0;j<n;++j)for(i=0;i<r->count;++i){EventView e=event_view_decode(r->words[i]);
        if(e.protocol==ui_protocol_event_id((UiProtocol)r->protocol)&&e.transaction_id==out[j].txn){
            if(i<out[j].first)out[j].first=i;
            if(i>out[j].last)out[j].last=i;}}
    return n;
}
#endif
