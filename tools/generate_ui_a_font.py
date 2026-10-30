from pathlib import Path
from PIL import Image,ImageFont,ImageDraw
import sys
root=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else Path(__file__).resolve().parent.parent
# Rasterize a local, fixed-size subset; no runtime filesystem/font dependencies.
texts=(root/'software/src/ui_a_views.inc').read_text(encoding='utf8')
chars=sorted(set(chr(i) for i in range(32,127))|set(c for c in texts if ord(c)>127))
latin=ImageFont.truetype('C:/Windows/Fonts/consola.ttf',14)
cjk=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',15)
out=['/* Generated local 16x18 CJK / 8x18 ASCII alpha subset. */','#ifndef UI_A_FONT_H','#define UI_A_FONT_H',f'#define UI_FONT_COUNT {len(chars)}U','static const unsigned int ui_font_code[]={'+','.join(str(ord(c)) for c in chars)+'};','static const unsigned char ui_font_bits[][144]={']
for c in chars:
    im=Image.new('L',(16,18));draw=ImageDraw.Draw(im);f=latin if ord(c)<128 else cjk;box=draw.textbbox((0,0),c,font=f);w=8 if ord(c)<128 else 16
    draw.text(((w-(box[2]-box[0]))//2-box[0],(18-(box[3]-box[1]))//2-box[1]),c,font=f,fill=255)
    v=list(im.getdata());packed=[((v[y*16+x]//17)<<4)|(v[y*16+x+1]//17) for y in range(18) for x in range(0,16,2)]
    out.append('{'+','.join(map(str,packed))+'},')
out+=['};','static const unsigned char ui_large_digit[][392]={']
f=ImageFont.truetype('C:/Windows/Fonts/consola.ttf',25)
for c in '0123456789':
    im=Image.new('L',(14,28));draw=ImageDraw.Draw(im);box=draw.textbbox((0,0),c,font=f);draw.text(((14-(box[2]-box[0]))//2-box[0],(28-(box[3]-box[1]))//2-box[1]),c,font=f,fill=255);out.append('{'+','.join(map(str,im.getdata()))+'},')
out+=['};','#endif'];(root/'software/src/ui_a_font.h').write_text('\n'.join(out),encoding='ascii')
print('Prepared Workbench A and font subset:',len(chars),'glyphs')
