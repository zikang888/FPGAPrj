/* Compact workbench, 800x480. Drawing and hit regions use physical pixels.
 * This file is included after drawing primitives, not compiled separately. */
static u32 selected_event_count(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap);
static u16 plot_x(u32 bit,u32 total) { return (u16)(192U+(total?576U*bit/total:0U)); }
static void card(u16 x,u16 y,u16 right,u16 bottom,u32 bg)
{
    fill(x+3U,y,right-3U,bottom,bg);fill(x,y+3U,right,bottom-3U,bg);
    hline(x+3U,right-3U,y,C_BORDER);hline(x+3U,right-3U,bottom,C_BORDER);
    vline(x,y+3U,bottom-3U,C_BORDER);vline(right,y+3U,bottom-3U,C_BORDER);
}
static void button(u16 x,u16 right,const char *label,u8 enabled,u8 primary)
{
    u32 bg=primary&&enabled?C_CYAN:C_BUTTON;
    card(x,54U,right,94U,bg);
    text(x+13U,65U,label,!enabled?C_MUTED:primary?C_BG:C_TEXT,bg);
}
static const char *capture_state(const PlatformUiStatus *s)
{
    if(s->test_failed) return "捕获失败";
    if(!ui_protocol_live(s->selected_protocol,s->capabilities)) return "未支持";
    if(s->test_running) return "测试进行中";
    if(s->capture_source==1U) return "等待新数据";
    if(s->capture_source==2U) return "快照已保存";
    return "尚未捕获";
}
static void draw_header(const char *title,const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    (void)title;(void)snap;
    fill(0U,0U,799U,43U,C_HEADER);hline(0U,799U,43U,C_BORDER);
    text(16U,13U,"MPA-7020",C_CYAN,C_HEADER);
    text(112U,12U,"多协议通信分析",C_TEXT,C_HEADER);
    text(420U,13U,"SPI / UART / I2C / CAN",C_MUTED,C_HEADER);
    fill(632U,10U,786U,33U,C_ACTIVE);
    text(647U,13U,capture_state(s),s->test_failed?C_RED:C_CYAN,C_ACTIVE);
}
static void draw_navigation(PlatformUiPage page)
{
    static const PlatformUiPage pages[5]={PLATFORM_UI_PAGE_HOME,PLATFORM_UI_PAGE_EVENTS,
        PLATFORM_UI_PAGE_ERRORS,PLATFORM_UI_PAGE_HISTORY,PLATFORM_UI_PAGE_SELF_TEST};
    static const char *const labels[5]={"波形","测试","错误","历史","状态"};
    u32 i;
    fill(0U,44U,93U,479U,C_HEADER);vline(93U,44U,479U,C_BORDER);
    for(i=0U;i<5U;++i){u16 y=(u16)(58U+i*66U);u32 bg=page==pages[i]?C_ACTIVE:C_HEADER;
        fill(7U,y,85U,y+56U,bg);
        if(page==pages[i]) fill(7U,y+7U,9U,y+49U,C_CYAN);
        text(20U,y+6U,"0",C_MUTED,bg);dec32(28U,y+6U,i+1U,C_MUTED,bg);
        text(20U,y+28U,labels[i],page==pages[i]?C_CYAN:C_MUTED,bg);
    }
    text(14U,424U,"ZYNQ",C_MUTED,C_HEADER);text(14U,447U,"7020",C_CYAN,C_HEADER);
}
static void draw_protocol_tabs(const PlatformUiStatus *s)
{
    u32 i;
    for(i=0U;i<UI_PROTOCOL_COUNT;++i){u16 x=ui_protocol_tab_left((UiProtocol)i);
        u16 r=ui_protocol_tab_right((UiProtocol)i);u8 active=s->selected_protocol==(UiProtocol)i;
        u32 bg=active?C_ACTIVE:C_BUTTON;
        card(x,54U,r,94U,bg);
        text(x+13U,66U,ui_protocol_name((UiProtocol)i),active?C_CYAN:C_MUTED,bg);
        if(active) hline(x+8U,r-8U,94U,C_CYAN);
    }
}
static int home_trace_available(const PlatformUiStatus *s)
{return !s->test_running&&(s->capture_source==1U||s->capture_source==2U)&&g_event_cache&&g_event_cache->valid;}
static void metric(u16 x,u16 r,const char *label,u32 value,u8 known,u32 color)
{
    card(x,106U,r,171U,C_PANEL);text(x+14U,114U,label,C_MUTED,C_PANEL);
    if(known) large_dec(x+14U,137U,value,color,C_PANEL);
    else text(x+14U,142U,"--",C_MUTED,C_PANEL);
}
static void draw_home_status(const PlatformUiStatus *s)
{
    u32 events=s->test_running?s->test_events:home_trace_available(s)?g_event_cache->count:0U;
    card(108U,106U,326U,171U,C_PANEL);
    text(122U,114U,"捕获状态",C_MUTED,C_PANEL);text(122U,141U,capture_state(s),C_CYAN,C_PANEL);
    metric(338U,556U,s->test_running?"本轮事件":"快照事件",events,
           s->test_running||home_trace_available(s),C_CYAN);
    /* A HOME snapshot is independent of a manual test: never show an old test's
     * error count beside a new HOME waveform. */
    metric(568U,786U,"快照错误事件",g_event_audit.errors,
           home_trace_available(s)&&g_event_audit_valid,g_event_audit.errors?C_RED:C_GREEN);
    button(626U,786U,s->test_running?"测试进行中":s->capture_source==1U?"等待数据":"重新捕获",
           !s->test_running&&s->capture_source!=1U&&ui_protocol_live(s->selected_protocol,s->capabilities),1U);
}
static void test_metrics(const PlatformUiStatus *s)
{
    metric(108U,326U,"当前测试",s->test_id,s->test_id!=0U,C_TEXT);
    metric(338U,556U,"本轮事件",s->test_events,s->test_id!=0U,C_CYAN);
    metric(568U,786U,"本轮错误",s->test_errors,s->test_id!=0U,s->test_errors?C_RED:C_GREEN);
}
static void hex8(u16 x,u16 y,u8 v,u32 fg,u32 bg)
{static const char d[]="0123456789ABCDEF";glyph(x,y,d[v>>4],fg,bg);glyph(x+8U,y,d[v&15U],fg,bg);}
static void lane(u16 y,const char *name,u32 bits,u32 color)
{
    u32 i,j; text(123U,y+4U,name,color,C_PANEL);
    for(i=0;i<=4U;++i){u16 x=plot_x(bits*i/4U,bits);
        for(j=y;j<=y+30U;j+=8U)vline(x,(u16)j,(u16)(j+2U),C_GRID);}
    for(i=192U;i<768U;i+=10U)hline((u16)i,(u16)(i+2U),y+28U,C_GRID);
}
static void bit_lane(const u8 *data,u32 n,u16 y,u32 color)
{
    u32 i;u8 last=0U;
    for(i=0;i<n*8U;++i){u8 b=(u8)((data[i/8U]>>(7U-i%8U))&1U);u16 x=plot_x(i,n*8U);
        if(i&&b!=last)vline(x,y,y+24U,color);
        hline(x,plot_x(i+1U,n*8U),b?y:y+24U,color);last=b;}
}
static void axis(u32 bits)
{
    u32 i;hline(192U,768U,367U,C_BORDER);
    for(i=0;i<=4U;++i)dec32(plot_x(bits*i/4U,bits)-4U,371U,bits*i/4U,C_MUTED,C_PANEL);
    text(122U,371U,"BIT",C_MUTED,C_PANEL);
}
static int home_fault_label(const PlatformUiStatus *s,char label[8])
{
    u32 i;if(!home_trace_available(s))return 0;
    for(i=0U;i<g_event_cache->count;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);
        if(e.protocol!=ui_protocol_event_id(s->selected_protocol))continue;
        if(event_diagnostic_label(&g_event_cache->event_word[0][0],g_event_cache->count,i,label))return 1;}
    return 0;
}
static void draw_home_fault_notice(const PlatformUiStatus *s)
{
    char label[8];if(!home_fault_label(s,label))return;
    fill(466U,190U,773U,211U,C_PANEL);
    text(466U,193U,"!",C_WARN,C_PANEL);text(482U,193U,label,C_WARN,C_PANEL);
    text(554U,193U,"解码异常 / 查看错误",C_WARN,C_PANEL);
}
static void plot_empty(const PlatformUiStatus *s)
{
    char label[8];
    text(146U,245U,home_fault_label(s,label)?"已捕获异常事件":"等待可显示的数据",C_TEXT,C_PANEL);
    text(146U,280U,s->test_running?"结束并保存测试后，可查看解码结果。":
         "点击重新捕获，再从 STM32 发送一组数据。",C_MUTED,C_PANEL);
    text(146U,318U,"无完整字节时不推测电平；事件详情见测试页。",C_MUTED,C_PANEL);
    if(home_fault_label(s,label))text(146U,356U,label,C_WARN,C_PANEL);
}
static void render_home_page(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    WaveSpi spi;I2cTrace i2c;CanTrace can;u32 i,b,n=0U,first=0U;int have=0;
    draw_header("",s,snap);draw_protocol_tabs(s);draw_home_status(s);
    card(108U,182U,786U,447U,C_PANEL);
    text(122U,194U,ui_protocol_name(s->selected_protocol),C_CYAN,C_PANEL);
    text(170U,193U,"解码轨迹",C_TEXT,C_PANEL);
    text(596U,193U,"非原始采样",C_MUTED,C_PANEL);hline(122U,773U,219U,C_BORDER);
    if(home_trace_available(s)){
        if(s->selected_protocol==UI_PROTOCOL_SPI)have=wave_spi_extract(&g_event_cache->event_word[0][0],g_event_cache->count,&spi);
        else if(s->selected_protocol==UI_PROTOCOL_I2C){
            for(i=0;i<g_event_cache->count;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);u32 j;
                if(e.protocol!=3U||e.event_type!=1U||!(e.flags&0x8000U))continue;
                for(j=i;j>0U;--j){EventView start=event_view_decode(g_event_cache->event_word[j-1U]);
                    if(start.protocol==3U&&start.event_type==0U&&start.transaction_id==e.transaction_id){first=j-1U;break;}}
                break;}
            have=i2c_trace_extract(&g_event_cache->event_word[first][0],g_event_cache->count-first,&i2c);
        }else if(s->selected_protocol==UI_PROTOCOL_CAN)have=can_trace_extract(&g_event_cache->event_word[0][0],g_event_cache->count,&can);
        else {for(i=0;i<g_event_cache->count&&n<4U;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);
                if(e.protocol==1U&&(e.event_type==1U||(e.event_type==0x3FU&&(e.flags>>8)==1U)))++n;}have=n!=0U;}
    }
    if(!have){plot_empty(s);return;}
    if(s->selected_protocol==UI_PROTOCOL_SPI){
        if(!spi.count){plot_empty(s);return;}n=spi.count;
        lane(242U,"MOSI",n*8U,C_CYAN);lane(314U,"MISO",n*8U,C_BLUE);
        bit_lane(spi.mosi,n,242U,C_CYAN);bit_lane(spi.miso,n,314U,C_BLUE);axis(n*8U);
        text(122U,397U,"TX",C_CYAN,C_PANEL);text(122U,421U,"RX",C_BLUE,C_PANEL);
        for(i=0;i<n;++i){u16 x=plot_x(i*8U+4U,n*8U)-8U;hex8(x,397U,spi.mosi[i],C_CYAN,C_PANEL);hex8(x,421U,spi.miso[i],C_BLUE,C_PANEL);}
    }else if(s->selected_protocol==UI_PROTOCOL_I2C){u8 prev=1U;n=i2c.count;lane(242U,"SCL",n*9U,C_CYAN);lane(314U,"SDA",n*9U,C_BLUE);
        for(i=0;i<n;++i){for(b=0;b<9U;++b){u16 x=plot_x(i*9U+b,n*9U),r=plot_x(i*9U+b+1U,n*9U),m=(x+r)/2U;
            u8 level=b==8U?i2c.nack[i]:(u8)((i2c.data[i]>>(7U-b))&1U);
            hline(x,m,266U,C_CYAN);vline(m,242U,266U,C_CYAN);hline(m,r,242U,C_CYAN);vline(r,242U,266U,C_CYAN);
            if(level!=prev)vline(x,314U,338U,C_BLUE);
            hline(x,r,level?314U:338U,C_BLUE);prev=level;}
            hex8(plot_x(i*9U+4U,n*9U)-8U,397U,i2c.data[i],C_TEXT,C_PANEL);
            text(plot_x(i*9U+4U,n*9U)-16U,421U,i2c.nack[i]?"NACK":"ACK",i2c.nack[i]?C_WARN:C_GREEN,C_PANEL);
            if(i2c.nack[i])outline(plot_x(i*9U+8U,n*9U)-1U,309U,plot_x((i+1U)*9U,n*9U),343U,C_WARN);
        }axis(n*9U);
    }else if(s->selected_protocol==UI_PROTOCOL_CAN){n=can.count;lane(242U,"DATA",n*8U,C_CYAN);bit_lane(can.data,n,242U,C_CYAN);
        text(122U,303U,"ID",C_MUTED,C_PANEL);hex32(156U,303U,can.identifier,C_TEXT,C_PANEL);
        text(304U,303U,"DLC",C_MUTED,C_PANEL);dec32(344U,303U,can.dlc,C_TEXT,C_PANEL);axis(n*8U);
        for(i=0;i<n;++i)hex8(plot_x(i*8U+4U,n*8U)-8U,397U,can.data[i],C_CYAN,C_PANEL);
        text(122U,423U,"仅显示负载位；不重建填充位、CRC 或 ACK。",C_MUTED,C_PANEL);
    }else{u32 f=0U;lane(242U,"RX",n*10U,C_CYAN);
        for(i=0;i<g_event_cache->count&&f<n;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);u8 last=1U;
            u8 bad=e.event_type==0x3FU&&(e.flags>>8)==1U;
            if(e.protocol!=1U||(e.event_type!=1U&&!bad))continue;
            for(b=0;b<10U;++b){u8 v=b==0U?0U:b==9U?(bad?0U:1U):(u8)((e.flags>>(b-1U))&1U);u16 x=plot_x(f*10U+b,n*10U);
                if(v!=last)vline(x,242U,266U,C_CYAN);
                hline(x,plot_x(f*10U+b+1U,n*10U),v?242U:266U,C_CYAN);last=v;}
            if(bad)outline(plot_x(f*10U+9U,n*10U),237U,plot_x((f+1U)*10U,n*10U),271U,C_WARN);
            hex8(plot_x(f*10U+5U,n*10U)-8U,310U,(u8)e.flags,C_TEXT,C_PANEL);
            text(plot_x(f*10U+5U,n*10U)-16U,397U,bad?"STOP!":"8N1",bad?C_WARN:C_GREEN,C_PANEL);++f;
        }axis(n*10U);
    }
    text(108U,457U,"按协议位序展示",C_MUTED,C_BG);text(568U,457U,"波形点按不会清除",C_MUTED,C_BG);
}
static const char *error_cn(ErrorCode code)
{
    switch(code){
    case ERROR_SPI_PARTIAL_BYTE:return "不完整字节";case ERROR_SPI_SHORT_TRANSACTION:return "事务过短";
    case ERROR_SPI_EXTRA_BYTES:return "额外字节";case ERROR_SPI_RESPONSE_MISMATCH:return "响应不匹配";
    case ERROR_UART_STOP_BIT:return "停止位错误";case ERROR_UART_BREAK:return "持续低电平";
    case ERROR_UART_SHORT_TRANSACTION:return "事务过短";case ERROR_UART_PARITY:return "奇偶校验 / 未启用";
    case ERROR_UART_BAUD_MISMATCH:return "波特率 / 未测量";case ERROR_I2C_ADDRESS_NACK:return "地址无应答";
    case ERROR_I2C_BUSY_NACK:return "忙响应 / 提示";case ERROR_I2C_MISSING_STOP:return "缺少停止条件";
    case ERROR_CAN_ACK:return "缺少应答";case ERROR_CAN_STUFF:return "位填充错误";
    case ERROR_CAN_CRC:return "CRC 校验错误";case ERROR_CAN_BUS_OFF:return "总线关闭 / 需 STM32";
    default:return "未分类";}
}
static void error_list(const ErrorModel *model,UiProtocol protocol,u16 y0)
{
    ErrorCode codes[6];const char *labels[6];u32 i,n=ui_error_catalog(protocol,codes,labels);
    card(108U,y0,556U,447U,C_PANEL);text(122U,y0+11U,"错误明细",C_TEXT,C_PANEL);
    for(i=0;i<n;++i){u16 y=(u16)(y0+38U+i*44U);ErrorObservation o=error_model_get(model,codes[i]);
        u32 c=o.origin==ERROR_ORIGIN_NONE?C_MUTED:codes[i]==ERROR_I2C_BUSY_NACK?C_CYAN:o.count?C_RED:C_GREEN;
        fill(122U,y+8U,125U,y+30U,c);text(137U,y+3U,error_cn(codes[i]),C_TEXT,C_PANEL);
        text(137U,y+23U,labels[i],C_MUTED,C_PANEL);
        if(o.origin==ERROR_ORIGIN_NONE)text(508U,y+9U,"--",C_MUTED,C_PANEL);
        else dec32(462U,y+9U,o.count,c,C_PANEL);
        hline(122U,542U,y+42U,C_GRID);
    }
}
static void render_errors_page(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    draw_header("",s,snap);draw_protocol_tabs(s);test_metrics(s);
    text(626U,65U,"当前测试结果",C_MUTED,C_BG);
    error_list(&s->error_model,s->selected_protocol,182U);
    card(568U,182U,786U,447U,C_PANEL);text(582U,194U,"结果说明",C_TEXT,C_PANEL);
    text(582U,230U,s->test_failed?"捕获失败":s->test_id==0U?"尚未开始测试":
         s->test_running?"正在接收数据":s->test_events==0U?"未收到事件":s->test_errors?"检测到异常":"未检出协议错误",
         s->test_id==0U?C_MUTED:s->test_errors||s->test_failed?C_RED:C_GREEN,C_PANEL);
    hline(582U,772U,263U,C_BORDER);text(582U,278U,"外部事件丢失",C_MUTED,C_PANEL);
    dec32(582U,304U,s->external_loss_count,s->external_loss_count?C_RED:C_GREEN,C_PANEL);
    if(s->selected_protocol==UI_PROTOCOL_SPI){
        text(582U,341U,"边界 / BND",C_MUTED,C_PANEL);dec32(700U,341U,s->spi_boundary_errors,s->spi_boundary_errors?C_RED:C_MUTED,C_PANEL);
        text(582U,365U,"重复 / DUP",C_MUTED,C_PANEL);dec32(700U,365U,s->spi_duplicates,s->spi_duplicates?C_RED:C_MUTED,C_PANEL);
        text(582U,389U,"顺序 / SEQ",C_MUTED,C_PANEL);dec32(700U,389U,s->spi_sequence_errors,s->spi_sequence_errors?C_RED:C_MUTED,C_PANEL);
    }else{
        text(582U,341U,"-- 表示尚无测量",C_MUTED,C_PANEL);
        text(582U,365U,"新测试重置本轮计数",C_MUTED,C_PANEL);
        text(582U,389U,"历史结果独立保留",C_MUTED,C_PANEL);
    }
    text(582U,420U,s->selected_protocol==UI_PROTOCOL_I2C?"忙响应不计入错误":"详情请查看测试事件",C_CYAN,C_PANEL);
}
static void render_self_test_page(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    static const char *const labels[]={"PL 系统标识","PL 版本","AXI 读写","触摸控制器","事件捕获"};
    u32 values[5]={s->id,s->version,s->scratch,s->touch_ok,s->capture_ok};
    u8 ok[5]={s->id_ok,s->version_ok,s->scratch_ok,s->touch_ok,s->capture_ok};u32 i;
    draw_header("",s,snap);draw_protocol_tabs(s);text(626U,65U,"系统状态",C_MUTED,C_BG);
    card(108U,106U,556U,447U,C_PANEL);text(122U,119U,"检查项目",C_TEXT,C_PANEL);
    for(i=0;i<5U;++i){u16 y=(u16)(154U+42U*i);text(122U,y,labels[i],C_TEXT,C_PANEL);
        hex32(310U,y,values[i],C_MUTED,C_PANEL);text(477U,y,ok[i]?"通过":"失败",ok[i]?C_GREEN:C_RED,C_PANEL);hline(122U,542U,y+30U,C_GRID);}
    text(122U,376U,"核心拒收 / 提示",C_MUTED,C_PANEL);dec32(374U,376U,s->core_rejected_count,C_CYAN,C_PANEL);
    text(122U,413U,"外部事件丢失",C_MUTED,C_PANEL);dec32(374U,413U,s->external_loss_count,s->external_loss_count?C_RED:C_GREEN,C_PANEL);
    card(568U,106U,786U,447U,C_PANEL);text(582U,120U,"系统检查",C_MUTED,C_PANEL);
    text(582U,158U,all_checks_passed(s)?"检查通过":"请检查异常项目",all_checks_passed(s)?C_GREEN:C_WARN,C_PANEL);
    text(582U,215U,"功能位图",C_MUTED,C_PANEL);hex32(582U,243U,s->capabilities,C_TEXT,C_PANEL);
    text(582U,291U,"当前协议",C_MUTED,C_PANEL);text(582U,318U,ui_protocol_name(s->selected_protocol),C_CYAN,C_PANEL);
    text(582U,368U,"功能支持不代表",C_MUTED,C_PANEL);text(582U,392U,"外部接线已验证",C_MUTED,C_PANEL);
}
static u32 selected_event_count(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    u32 i,n=0U;if(!snap||!g_event_cache||!g_event_cache->valid||g_event_cache->snapshot_id!=snap->snapshot_id)return 0U;
    for(i=0;i<g_event_cache->count;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);
        if(ui_protocol_event_matches(s->selected_protocol,e.protocol,s->capture_source!=2U))++n;}
    return n;
}
static u32 max_scroll_px(u32 n){return pixel_scroll_max(n,EVENT_ROW_PX,EVENTS_Y1-EVENTS_Y0+1U);}
static u32 history_list_max_scroll(void){return pixel_scroll_max(g_history?g_history->count:0U,HISTORY_ROW_PX,HISTORY_LIST_Y1-HISTORY_LIST_Y0+1U);}
static void draw_scroll_indicator_region(u32 n,u32 row,u16 y0,u16 y1,u32 scroll)
{
    u32 height=y1-y0+1U,max=pixel_scroll_max(n,row,height),thumb,y;
    if(!max)return;
    thumb=height*height/(n*row);if(thumb<20U)thumb=20U;
    y=y0+(height-thumb)*scroll/max;fill(779U,y0,785U,y1,C_GRID);fill(780U,(u16)y,784U,(u16)(y+thumb-1U),C_CYAN);
}
static void table_header(void)
{
    fill(108U,182U,786U,211U,C_HEADER);text(122U,188U,"序号",C_MUTED,C_HEADER);
    text(184U,188U,"协议",C_MUTED,C_HEADER);text(243U,188U,"事件",C_MUTED,C_HEADER);
    text(332U,188U,"数据 / 详情",C_MUTED,C_HEADER);text(474U,188U,"事务",C_MUTED,C_HEADER);text(606U,188U,"时间 us",C_MUTED,C_HEADER);
}
static void draw_event_row_at(const u32 *w,u32 index,u32 trigger,int pos,const u32 *all,u32 n)
{
    EventView e=event_view_decode(w),first=event_view_decode(all);char label[8];u32 bg,c;u16 y=(u16)pos;
    int bad=event_diagnostic_label(all,n,index,label);uint64_t dt=e.timestamp>=first.timestamp?(e.timestamp-first.timestamp)/100U:0U;
    if(pos>(int)EVENTS_Y1||pos+36<(int)EVENTS_Y0)return;
    bg=index==trigger?C_ACTIVE:(index&1U)?C_BG:C_PANEL;c=bad?C_WARN:C_TEXT;
    fill(108U,y,786U,y+36U,bg);dec32(122U,y+9U,index,C_MUTED,bg);
    text(184U,y+9U,event_view_protocol_name(e.protocol),C_CYAN,bg);text(243U,y+9U,label,c,bg);
    if(e.protocol==2U&&e.event_type==1U){hex8(332U,y+9U,(u8)e.flags,C_CYAN,bg);text(354U,y+9U,"/",C_MUTED,bg);hex8(370U,y+9U,(u8)(e.flags>>8),C_BLUE,bg);}
    else if(e.protocol==3U&&e.event_type==1U){hex8(332U,y+9U,(u8)e.flags,C_TEXT,bg);text(362U,y+9U,e.flags&0x8000U?"NACK":"ACK",c,bg);}
    else if(e.event_type==1U||(e.protocol==1U&&e.event_type==0x3FU&&(e.flags>>8)==1U))hex8(332U,y+9U,(u8)e.flags,c,bg);
    else hex32(332U,y+9U,e.flags,c,bg);
    dec32(474U,y+9U,e.transaction_id,C_TEXT,bg);dec32(606U,y+9U,dt>0xffffffffU?0xffffffffU:(u32)dt,C_MUTED,bg);hline(108U,778U,y+36U,C_GRID);
}
static void draw_events_region(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    u32 i,visible=0U;int y=(int)EVENTS_Y0-(int)(g_scroll_px%EVENT_ROW_PX);u32 n=selected_event_count(s,snap);
    fill(108U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);if(!n){text(164U,282U,"没有匹配的协议事件",C_MUTED,C_PANEL);return;}
    set_clip(108U,EVENTS_Y0,786U,EVENTS_Y1);
    for(i=0;i<g_event_cache->count&&y<=(int)EVENTS_Y1;++i){EventView e=event_view_decode(g_event_cache->event_word[i]);
        if(!ui_protocol_event_matches(s->selected_protocol,e.protocol,s->capture_source!=2U))continue;
        if(visible++<g_scroll_px/EVENT_ROW_PX)continue;
        draw_event_row_at(g_event_cache->event_word[i],i,snap->trigger_index,y,&g_event_cache->event_word[0][0],g_event_cache->count);y+=EVENT_ROW_PX;}
    clear_clip();draw_scroll_indicator_region(n,EVENT_ROW_PX,EVENTS_Y0,EVENTS_Y1,g_scroll_px);
}
static void render_events_page(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    draw_header("",s,snap);draw_protocol_tabs(s);test_metrics(s);
    button(626U,786U,s->test_running?"结束并保存":"开始新测试",
           ui_protocol_live(s->selected_protocol,s->capabilities),1U);table_header();
    fill(108U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
    if(s->test_failed)text(146U,260U,"捕获失败，请检查系统状态后重新测试。",C_RED,C_PANEL);
    else if(s->test_running){text(146U,247U,"正在记录本轮测试",C_CYAN,C_PANEL);text(146U,285U,"1. 从 STM32 发送测试数据",C_TEXT,C_PANEL);
        text(146U,321U,"2. 完成后点击结束并保存",C_TEXT,C_PANEL);text(146U,357U,"3. 查看事件、错误或历史结果",C_TEXT,C_PANEL);}
    else if(!s->test_id){text(146U,247U,"开始新测试后，从 STM32 发送数据。",C_TEXT,C_PANEL);
        text(146U,289U,"本轮计数会重置，历史结果保留。",C_MUTED,C_PANEL);}
    else draw_events_region(s,snap);
    text(108U,457U,s->retained_tail?"仅保留最近 256 条事件":"上下拖动查看事件",C_MUTED,C_BG);
    text(568U,457U,"历史记录见左侧导航",C_MUTED,C_BG);
}
static void render_history_page(const PlatformUiStatus *s,const CaptureDemoSnapshot *snap)
{
    const TestHistoryEntry *r;u32 i;
    draw_header("",s,snap);button(108U,274U,g_history_detail?"返回列表":"查看当前测试",1U,0U);
    text(302U,66U,"最近 8 轮 / RAM 保存",C_MUTED,C_BG);
    if(!g_history_detail){
        card(108U,106U,786U,145U,C_PANEL);text(122U,117U,"测试",C_MUTED,C_PANEL);text(197U,117U,"协议",C_MUTED,C_PANEL);
        text(281U,117U,"事件",C_MUTED,C_PANEL);text(392U,117U,"错误",C_MUTED,C_PANEL);text(490U,117U,"保留",C_MUTED,C_PANEL);text(594U,117U,"耗时 ms",C_MUTED,C_PANEL);
        fill(108U,HISTORY_LIST_Y0,786U,HISTORY_LIST_Y1,C_PANEL);
        if(g_history_list_scroll>history_list_max_scroll())g_history_list_scroll=history_list_max_scroll();
        if(!g_history||!g_history->count){text(146U,252U,"暂无完成的测试",C_MUTED,C_PANEL);return;}
        set_clip(108U,HISTORY_LIST_Y0,786U,HISTORY_LIST_Y1);
        for(i=g_history_list_scroll/HISTORY_ROW_PX;i<g_history->count;++i){u16 y=(u16)(HISTORY_LIST_Y0+i*HISTORY_ROW_PX-g_history_list_scroll);u32 bg=(i&1U)?C_BG:C_PANEL;
            if(y>HISTORY_LIST_Y1)break;
            r=test_history_get(g_history,i);
            fill(108U,y,786U,y+HISTORY_ROW_PX-2U,bg);dec32(122U,y+12U,r->id,C_TEXT,bg);
            text(197U,y+12U,ui_protocol_name((UiProtocol)r->protocol),C_CYAN,bg);dec32(281U,y+12U,r->total_events,C_TEXT,bg);
            dec32(392U,y+12U,r->error_count,r->error_count?C_RED:C_GREEN,bg);dec32(490U,y+12U,r->count,C_MUTED,bg);
            dec32(594U,y+12U,r->duration_ms,C_MUTED,bg);text(752U,y+12U,r->snapshot_valid?">":"!",r->snapshot_valid?C_MUTED:C_WARN,bg);
        }clear_clip();draw_scroll_indicator_region(g_history->count,HISTORY_ROW_PX,HISTORY_LIST_Y0,HISTORY_LIST_Y1,g_history_list_scroll);
        text(108U,437U,"拖动浏览，轻点松手打开；断电后历史清空。",C_MUTED,C_BG);return;
    }
    r=test_history_get(g_history,g_history_selected);if(!r)return;
    button(626U,786U,g_history_errors?"查看事件":"查看错误",1U,0U);
    metric(108U,326U,"历史测试",r->id,1U,C_TEXT);metric(338U,556U,"保存事件",r->count,1U,C_CYAN);metric(568U,786U,"本轮错误",r->error_count,1U,r->error_count?C_RED:C_GREEN);
    if(g_history_errors){error_list(&r->errors,(UiProtocol)r->protocol,182U);card(568U,182U,786U,447U,C_PANEL);
        text(582U,198U,"历史结果",C_TEXT,C_PANEL);text(582U,237U,ui_protocol_name((UiProtocol)r->protocol),C_CYAN,C_PANEL);
        text(582U,282U,"新测试不会改写",C_MUTED,C_PANEL);text(582U,307U,"本轮保存的统计",C_MUTED,C_PANEL);
        text(582U,360U,"外部事件丢失",C_MUTED,C_PANEL);dec32(582U,390U,r->external_loss,r->external_loss?C_RED:C_GREEN,C_PANEL);return;}
    table_header();fill(108U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
    if(!r->count){text(146U,260U,r->snapshot_valid?"本轮未收到事件":"快照不可用",C_MUTED,C_PANEL);return;}
    set_clip(108U,EVENTS_Y0,786U,EVENTS_Y1);
    for(i=g_history_scroll/EVENT_ROW_PX;i<r->count;++i){int y=(int)EVENTS_Y0+(int)(i*EVENT_ROW_PX)-(int)g_history_scroll;
        if(y>(int)EVENTS_Y1)break;
        draw_event_row_at(r->words[i],i,0xffffffffU,y,&r->words[0][0],r->count);}
    clear_clip();draw_scroll_indicator_region(r->count,EVENT_ROW_PX,EVENTS_Y0,EVENTS_Y1,g_history_scroll);
}
