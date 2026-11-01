/* Saved transaction replay shares the production plot renderer, but only
 * supplies original words belonging to the selected transaction. */
static void render_saved_trace(const PlatformUiStatus *s,const TestHistoryEntry *r)
{
    static CaptureDemoCache cache;
    const CaptureDemoCache *previous=g_event_cache;
    PlatformUiStatus view=*s;
    u32 i,n=saved_error_transactions(r,g_saved_txn);
    if(g_saved_id!=r->id){g_saved_id=r->id;g_saved_selected=0U;}
    if(!n)g_saved_selected=0U;
    else if(g_saved_selected>=n)g_saved_selected=n-1U;
    memset(&cache,0,sizeof(cache));cache.valid=1U;
    if(n){SavedErrorTxn *chosen=&g_saved_txn[g_saved_selected];
        for(i=chosen->first;i<=chosen->last;++i){EventView e=event_view_decode(r->words[i]);
            if(e.protocol==ui_protocol_event_id((UiProtocol)r->protocol)&&e.transaction_id==chosen->txn)
                memcpy(cache.event_word[cache.count++],r->words[i],sizeof(r->words[i]));}}
    view.selected_protocol=(UiProtocol)r->protocol;view.test_running=0U;
    view.capture_source=2U;view.test_failed=0U;
    g_event_cache=&cache;
    render_home_page(&view,0);
    draw_home_fault_notice(&view);
    if(n){char labels[3][8];u32 k=0U,j,data=0U;
        fill(466U,190U,773U,211U,C_PANEL);text(466U,193U,"!",C_WARN,C_PANEL);
        for(i=0U;i<cache.count;++i){char label[8];EventView e=event_view_decode(cache.event_word[i]);
            if(e.event_type==1U||(e.protocol==1U&&e.event_type==0x3fU&&(e.flags>>8)==1U))++data;
            if(!event_diagnostic_label(&cache.event_word[0][0],cache.count,i,label))continue;
            for(j=0U;j<k&&strcmp(label,labels[j]);++j){}
            if(j==k&&k<3U){memcpy(labels[k],label,8U);text((u16)(482U+96U*k),193U,label,C_WARN,C_PANEL);++k;}
        }
        if(!data){fill(122U,230U,773U,437U,C_PANEL);
            text(146U,252U,"已保存异常，未保留可绘制的数据字节。",C_TEXT,C_PANEL);
            text(146U,292U,"不补画缺失的电平或错误位。",C_MUTED,C_PANEL);
            text(146U,332U,"可切换其他异常，或返回事件列表查看。",C_MUTED,C_PANEL);}
    }
    g_event_cache=previous;
    fill(108U,54U,786U,94U,C_BG);
    if(g_requested_page==PLATFORM_UI_PAGE_HISTORY)button(108U,310U,"返回列表",1U,0U);
    else draw_protocol_tabs(&view);
    if(g_requested_page==PLATFORM_UI_PAGE_HISTORY){button(414U,610U,"返回事件列表",1U,0U);button(626U,786U,"查看错误",1U,0U);}
    else {button(414U,610U,"返回单次捕获",1U,0U);button(626U,786U,"重新捕获",1U,1U);}
    fill(108U,106U,786U,171U,C_BG);
    metric(108U,326U,"保存测试",r->id,1U,C_TEXT);
    metric(338U,556U,"异常事务",n,1U,n?C_WARN:C_GREEN);
    metric(568U,786U,"选中事务错误项",n?g_saved_txn[g_saved_selected].errors:0U,1U,C_WARN);
    fill(632U,10U,786U,33U,C_ACTIVE);text(647U,13U,"历史波形回看",C_CYAN,C_ACTIVE);
    if(!n){fill(122U,230U,773U,437U,C_PANEL);
        text(144U,257U,"保存明细中没有可定位的错误事务。",C_TEXT,C_PANEL);
        text(144U,294U,r->error_count?"本轮有错误计数，但对应事件可能未保留。":"本轮未发现已保存的错误事件。",C_MUTED,C_PANEL);
        text(144U,331U,"选择其他历史测试，或开始新测试后保存。",C_MUTED,C_PANEL);
    }
    fill(108U,449U,799U,479U,C_BG);
    card(108U,451U,296U,478U,C_BUTTON);text(133U,455U,"上一异常",g_saved_selected?C_CYAN:C_MUTED,C_BUTTON);
    card(598U,451U,786U,478U,C_BUTTON);text(623U,455U,"下一异常",g_saved_selected+1U<n?C_CYAN:C_MUTED,C_BUTTON);
    text(310U,455U,"事务",C_MUTED,C_BG);dec32(350U,455U,n?g_saved_txn[g_saved_selected].txn:0U,C_TEXT,C_BG);
    text(430U,455U,"项",C_MUTED,C_BG);dec32(454U,455U,n?g_saved_selected+1U:0U,C_CYAN,C_BG);
    text(494U,455U,"/",C_MUTED,C_BG);dec32(510U,455U,n,C_MUTED,C_BG);
    if(r->overwritten)text(330U,77U,"异常存档已满",C_WARN,C_BG);
}
