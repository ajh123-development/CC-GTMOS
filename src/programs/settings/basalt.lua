local ba={}local ca=true;local da=require
local _b=function(bb)
for cb,db in pairs(ba)do
if(type(db)=="table")then for _c,ac in pairs(db)do if(_c==bb)then
return ac()end end else if(cb==bb)then return db()end end end;return da(bb)end
local ab=function(bb)if(bb~=nil)then return ba[bb]end;return ba end
ba["main"]=function(...)local bb=_b("basaltEvent")()
local cb=_b("loadObjects")local db=_b("plugin")local _c=_b("utils")local ac=_b("basaltLogs")
local bc=_c.uuid;local cc=_c.wrapText;local dc=_c.tableCount;local _d=300;local ad=0;local bd=0
local cd=term.current()local dd="1.7.0"
local __a=fs.getDir(table.pack(...)[2]or"")local a_a,b_a,c_a,d_a,_aa,aaa={},{},{},{},{},{}local baa,caa,daa,_ba;local aba={}if not term.isColor or not
term.isColor()then
error('Basalt requires an advanced (golden) computer to run.',0)end;local bba={}
for cbb,dbb in
pairs(colors)do if(type(dbb)=="number")then
bba[cbb]={cd.getPaletteColor(dbb)}end end
local function cba()_ba=false;cd.clear()cd.setCursorPos(1,1)
for cbb,dbb in pairs(colors)do if(type(dbb)==
"number")then
cd.setPaletteColor(dbb,colors.packRGB(table.unpack(bba[cbb])))end end end
function aba.basaltError(cbb)cd.clear()
cd.setBackgroundColor(colors.black)cd.setTextColor(colors.red)local dbb,_cb=cd.getSize()if
(aba.logging)then ac(cbb,"Error")end
local acb=cc("Basalt error: "..cbb,dbb)local bcb=1;for ccb,dcb in pairs(acb)do cd.setCursorPos(1,bcb)cd.write(dcb)
bcb=bcb+1 end
cd.setCursorPos(1,bcb+1)_ba=false end
local function dba(cbb)
assert(cbb~="function","Schedule needs a function in order to work!")
return function(...)local dbb=coroutine.create(cbb)
local _cb,acb=coroutine.resume(dbb,...)
if(_cb)then table.insert(aaa,dbb)else aba.basaltError(acb)end end end;aba.log=function(...)ac(...)end
local _ca=function(cbb,dbb)_aa[cbb]=dbb end;local aca=function(cbb)return _aa[cbb]end
local bca={getDynamicValueEventSetting=function()
return aba.dynamicValueEvents end,getMainFrame=function()return baa end,setVariable=_ca,getVariable=aca,setMainFrame=function(cbb)baa=cbb end,getActiveFrame=function()return caa end,setActiveFrame=function(cbb)
caa=cbb end,getFocusedObject=function()return daa end,setFocusedObject=function(cbb)daa=cbb end,getMonitorFrame=function(cbb)return
c_a[cbb]or d_a[cbb][1]end,setMonitorFrame=function(cbb,dbb,_cb)if(baa==dbb)then baa=nil end;if(_cb)then
d_a[cbb]={dbb,sides}else c_a[cbb]=dbb end
if(dbb==nil)then d_a[cbb]=nil end end,getTerm=function()
return cd end,schedule=dba,stop=cba,newFrame=Frame,debug=aba.debug,log=aba.log,getObjects=function()return cb end,getObject=function(cbb)return cb[cbb]end,getDirectory=function()
return __a end}
local function cca(cbb,dbb,_cb,acb,bcb)
if(#aaa>0)then local ccb={}
for n=1,#aaa do
if(aaa[n]~=nil)then
if
(coroutine.status(aaa[n])=="suspended")then
local dcb,_db=coroutine.resume(aaa[n],cbb,dbb,_cb,acb,bcb)if not(dcb)then aba.basaltError(_db)end else
table.insert(ccb,n)end end end
for n=1,#ccb do table.remove(aaa,ccb[n]- (n-1))end end end
local function dca()if(_ba==false)then return end;if(baa~=nil)then baa:render()
baa:updateTerm()end;for cbb,dbb in pairs(c_a)do dbb:render()
dbb:updateTerm()end;for cbb,dbb in pairs(d_a)do dbb[1]:render()
dbb[1]:updateTerm()end end;local _da,ada,bda=nil,nil,nil;local cda=nil
local function dda(cbb,dbb,_cb,acb)_da,ada,bda=dbb,_cb,acb;if(cda==nil)then
cda=os.startTimer(_d/1000)end end
local function __b()cda=nil;baa:hoverHandler(ada,bda,_da)caa=baa end;local a_b,b_b,c_b=nil,nil,nil;local d_b=nil;local function _ab()d_b=nil;baa:dragHandler(a_b,b_b,c_b)
caa=baa end;local function aab(cbb,dbb,_cb,acb)a_b,b_b,c_b=dbb,_cb,acb
if(ad<50)then _ab()else if(d_b==nil)then d_b=os.startTimer(
ad/1000)end end end
local bab=nil;local function cab()bab=nil;dca()end
local function dab(cbb)if(bd<50)then dca()else if(bab==nil)then
bab=os.startTimer(bd/1000)end end end
local function _bb(cbb,...)local dbb={...}if
(bb:sendEvent("basaltEventCycle",cbb,...)==false)then return end
if(cbb=="terminate")then aba.stop()end
if(baa~=nil)then
local _cb={mouse_click=baa.mouseHandler,mouse_up=baa.mouseUpHandler,mouse_scroll=baa.scrollHandler,mouse_drag=aab,mouse_move=dda}local acb=_cb[cbb]
if(acb~=nil)then acb(baa,...)cca(cbb,...)dab()return end end
if(cbb=="monitor_touch")then if(c_a[dbb[2]]~=nil)then
c_a[dbb[2]]:mouseHandler(1,dbb[2],dbb[3],true)caa=c_a[dbb[2]]end
if
(dc(d_a)>0)then for _cb,acb in pairs(d_a)do
acb[1]:mouseHandler(1,dbb[2],dbb[3],true,dbb[1])end end;cca(cbb,...)dab()return end
if(caa~=nil)then
local _cb={char=caa.charHandler,key=caa.keyHandler,key_up=caa.keyUpHandler}local acb=_cb[cbb]if(acb~=nil)then if(cbb=="key")then a_a[dbb[1]]=true elseif(cbb=="key_up")then
a_a[dbb[1]]=false end;acb(caa,...)cca(cbb,...)
dab()return end end
if(cbb=="timer")and(dbb[1]==cda)then __b()elseif
(cbb=="timer")and(dbb[1]==d_b)then _ab()elseif(cbb=="timer")and(dbb[1]==bab)then cab()else for _cb,acb in pairs(b_a)do
acb:eventHandler(cbb,...)end;cca(cbb,...)dab()end end
aba={logging=false,dynamicValueEvents=false,setTheme=setTheme,getTheme=getTheme,drawFrames=dca,log=ac,getVersion=function()return dd end,memory=function()return
math.floor(collectgarbage("count")+0.5).."KB"end,setVariable=_ca,getVariable=aca,setBaseTerm=function(cbb)
cd=cbb end,resetPalette=function()
for cbb,dbb in pairs(colors)do if(type(dbb)=="number")then end end end,setMouseMoveThrottle=function(cbb)
if(_HOST:find("CraftOS%-PC"))then if(
config.get("mouse_move_throttle")~=10)then
config.set("mouse_move_throttle",10)end
if(cbb<100)then _d=100 else _d=cbb end;return true end;return false end,setRenderingThrottle=function(cbb)if(
cbb<=0)then bd=0 else bab=nil;bd=cbb end end,setMouseDragThrottle=function(cbb)if
(cbb<=0)then ad=0 else d_b=nil;ad=cbb end end,autoUpdate=function(cbb)_ba=cbb;if(
cbb==nil)then _ba=true end;local function dbb()dca()while _ba do
_bb(os.pullEventRaw())end end
while _ba do
local _cb,acb=xpcall(dbb,debug.traceback)if not(_cb)then aba.basaltError(acb)end end end,update=function(cbb,...)
if(
cbb~=nil)then local dbb,_cb=xpcall(_bb,debug.traceback,cbb,...)if not(dbb)then
aba.basaltError(_cb)return end end end,stop=cba,stopUpdate=cba,isKeyDown=function(cbb)if(
a_a[cbb]==nil)then return false end;return a_a[cbb]end,getFrame=function(cbb)for dbb,_cb in
pairs(b_a)do if(_cb.name==cbb)then return _cb end end end,getActiveFrame=function()return
caa end,setActiveFrame=function(cbb)
if(cbb:getType()=="Container")then caa=cbb;return true end;return false end,getMainFrame=function()return baa end,onEvent=function(...)
for cbb,dbb in
pairs(table.pack(...))do if(type(dbb)=="function")then
bb:registerEvent("basaltEventCycle",dbb)end end end,schedule=dba,createFrame=function(cbb)
for _cb,acb in
pairs(b_a)do if(acb:getName()==cbb)then return nil end end;local dbb=cb["BaseFrame"](cbb,bca)dbb:init()
dbb:load()dbb:draw()table.insert(b_a,dbb)
if(baa==nil)and(dbb:getName()~=
"basaltDebuggingFrame")then dbb:show()end;return dbb end,removeFrame=function(cbb)b_a[cbb]=
nil end,setProjectDir=function(cbb)__a=cbb end}cb=db.addPlugins(cb,bca)local abb=db.get("basalt")
if(abb~=nil)then for cbb,dbb in
pairs(abb)do
for _cb,acb in pairs(dbb(aba))do aba[_cb]=acb;bca[_cb]=acb end end end;local bbb=db.get("basaltInternal")
if(bbb~=nil)then for cbb,dbb in pairs(bbb)do for _cb,acb in pairs(dbb(aba))do
bca[_cb]=acb end end end;return aba end
ba["plugin"]=function(...)local bb={...}local cb={}
local db=fs.getDir(bb[2]or"Basalt")local _c=fs.combine(db,"plugins")
if(ca)then
for bc,cc in pairs(ab("plugins"))do
local dc=cc()
if(type(dc)=="table")then for _d,ad in pairs(dc)do
if(type(_d)=="string")then
if(cb[_d]==nil)then cb[_d]={}end;table.insert(cb[_d],ad)end end end end end
if(fs.exists(_c))then
for bc,cc in pairs(fs.list(_c))do
local dc=_b(cc:gsub(".lua",""))
if(type(dc)=="table")then for _d,ad in pairs(dc)do
if(type(_d)=="string")then
if(cb[_d]==nil)then cb[_d]={}end;table.insert(cb[_d],ad)end end end end end;local function ac(bc)return cb[bc]end
return
{get=ac,addPlugins=function(bc,cc)
for dc,_d in pairs(bc)do local ad=cb[dc]
if(ad~=nil)then
bc[dc]=function(...)
local bd=_d(...)for cd,dd in pairs(ad)do local __a=dd(bd,cc,...)__a.__index=__a
bd=setmetatable(__a,bd)end;return bd end end end;return bc end}end;ba["objects"]={}
ba["objects"]["BaseFrame"]=function(...)
local bb=_b("basaltDraw")local cb=_b("utils")
local db,_c,ac,bc=math.max,math.min,string.sub,string.rep
return
function(cc,dc)local _d=dc.getObject("Container")(cc,dc)
local ad="BaseFrame"local bd,cd=0,0;local dd={}local __a=true;local a_a=dc.getTerm()local b_a=bb(a_a)
local c_a,d_a,_aa,aaa=1,1,false,colors.white
local baa={getType=function()return ad end,isType=function(caa,daa)return
ad==daa or _d.isType~=nil and _d.isType(daa)or false end,getBase=function(caa)return
_d end,getOffset=function(caa)return bd,cd end,setOffset=function(caa,daa,_ba)bd=daa or bd;cd=_ba or cd
caa:updateDraw()return caa end,show=function(caa)_d.show(caa)
for daa,_ba in pairs(dd)do
if(
type(_ba)=="number")then
a_a.setPaletteColor(type(daa)=="number"and daa or colors[daa],_ba)else local aba,bba,cba=table.unpack(_ba)
a_a.setPaletteColor(
type(daa)=="number"and daa or colors[daa],aba,bba,cba)end end;return caa end,setPalette=function(caa,daa,...)
if(
caa==dc.getActiveFrame())then
if(type(daa)=="string")then dd[daa]=...
a_a.setPaletteColor(
type(daa)=="number"and daa or colors[daa],...)elseif(type(daa)=="table")then
for _ba,aba in pairs(daa)do dd[_ba]=aba
if(type(aba)=="number")then
a_a.setPaletteColor(
type(_ba)=="number"and _ba or colors[_ba],aba)else local bba,cba,dba=table.unpack(aba)
a_a.setPaletteColor(
type(_ba)=="number"and _ba or colors[_ba],bba,cba,dba)end end end end;return caa end,setSize=function(caa,...)
_d.setSize(caa,...)b_a=bb(a_a)return caa end,getSize=function()return a_a.getSize()end,getWidth=function(caa)return
({a_a.getSize()})[1]end,getHeight=function(caa)
return({a_a.getSize()})[2]end,show=function(caa)_d.show(caa)dc.setActiveFrame(caa)
for daa,_ba in
pairs(colors)do if(type(_ba)=="number")then
a_a.setPaletteColor(_ba,colors.packRGB(term.nativePaletteColor((_ba))))end end
for daa,_ba in pairs(dd)do
if(type(_ba)=="number")then
a_a.setPaletteColor(
type(daa)=="number"and daa or colors[daa],_ba)else local aba,bba,cba=table.unpack(_ba)
a_a.setPaletteColor(
type(daa)=="number"and daa or colors[daa],aba,bba,cba)end end;dc.setMainFrame(caa)return caa end,render=function(caa)
if(
_d.render~=nil)then
if(caa:isVisible())then
if(__a)then _d.render(caa)
local daa=caa:getObjects()for _ba,aba in ipairs(daa)do if(aba.element.render~=nil)then
aba.element:render()end end
__a=false end end end end,updateDraw=function(caa)
__a=true;return caa end,eventHandler=function(caa,daa,...)_d.eventHandler(caa,daa,...)if
(daa=="term_resize")then caa:setSize(a_a.getSize())end end,updateTerm=function(caa)
b_a.update()end,setTerm=function(caa,daa)a_a=daa;b_a=bb(a_a)return caa end,getTerm=function()return a_a end,blit=function(caa,daa,_ba,aba,bba,cba)
local dba,_ca=caa:getPosition()local aca,bca=caa:getSize()
if _ba>=1 and _ba<=bca then local cca=ac(aba,db(1 -daa+1,1),db(
aca-daa+1,1))local dca=ac(bba,db(1 -daa+1,1),db(
aca-daa+1,1))local _da=ac(cba,db(1 -daa+1,1),db(
aca-daa+1,1))
b_a.blit(db(daa+
(dba-1),dba),_ca+_ba-1,cca,dca,_da)end end,setCursor=function(caa,daa,_ba,aba,bba)
local cba,dba=caa:getAbsolutePosition()_aa=daa or false;if(_ba~=nil)then c_a=cba+_ba-1 end;if(aba~=nil)then d_a=dba+
aba-1 end;aaa=bba or aaa;if(_aa)then
a_a.setTextColor(aaa)a_a.setCursorPos(c_a,d_a)a_a.setCursorBlink(_aa)else
a_a.setCursorBlink(false)end;return caa end}
for caa,daa in
pairs({"drawBackgroundBox","drawForegroundBox","drawTextBox"})do
baa[daa]=function(_ba,aba,bba,cba,dba,_ca)local aca,bca=_ba:getPosition()local cca,dca=_ba:getSize()
dba=(bba<1 and(dba+
bba>_ba:getHeight()and _ba:getHeight()or dba+bba-
1)or(dba+bba>
_ba:getHeight()and _ba:getHeight()-bba+1 or
dba))
cba=(aba<1 and(cba+aba>_ba:getWidth()and _ba:getWidth()or cba+
aba-1)or(

cba+aba>_ba:getWidth()and _ba:getWidth()-aba+1 or cba))
b_a[daa](db(aba+ (aca-1),aca),db(bba+ (bca-1),bca),cba,dba,_ca)end end
for caa,daa in pairs({"setBG","setFG","setText"})do
baa[daa]=function(_ba,aba,bba,cba)
local dba,_ca=_ba:getPosition()local aca,bca=_ba:getSize()if(bba>=1)and(bba<=bca)then
b_a[daa](db(aba+ (dba-1),dba),
_ca+bba-1,ac(cba,db(1 -aba+1,1),db(aca-aba+1,1)))end end end;baa.__index=baa;return setmetatable(baa,_d)end end
ba["objects"]["MonitorFrame"]=function(...)
local bb,cb,db,_c=math.max,math.min,string.sub,string.rep
return
function(ac,bc)local cc=bc.getObject("BaseFrame")(ac,bc)
local dc="MonitorFrame"cc:hide()
local _d={getType=function()return dc end,isType=function(ad,bd)
return dc==bd or
cc.isType~=nil and cc.isType(bd)or false end,getBase=function(ad)return cc end,setMonitor=function(ad,bd)
local cd=peripheral.wrap(bd)if(cd~=nil)then ad:setTerm(cd)end;return ad end,show=function(ad)if(
bc.getTerm()~=ad:getTerm())then cc.show()end;return ad end}_d.__index=_d;return setmetatable(_d,cc)end end
ba["objects"]["Graphic"]=function(...)local bb=_b("Object")local cb=_b("tHex")
local db=_b("utils").getValueFromXML;local _c=_b("bimg")local ac=_b("images")
local bc,cc,dc,_d=string.sub,string.len,math.max,math.min
return
function(ad)local bd=bb(ad)local cd="Graphic"local dd=_c()local __a=dd.getFrameObject(1)local a_a
local b_a=1;bd:setZIndex(5)local c_a,d_a=0,0
local _aa={getType=function(aaa)return cd end,setOffset=function(aaa,baa,caa,daa)
if(daa)then
c_a=c_a+baa or 0;d_a=d_a+caa or 0 else c_a=baa or c_a;d_a=caa or d_a end;aaa:updateDraw()return aaa end,getOffset=function(aaa)return
c_a,d_a end,setValuesByXMLData=function(aaa,baa)bd.setValuesByXMLData(aaa,baa)return aaa end,selectFrame=function(aaa,baa)if(
dd.getFrameObject(baa)==nil)then dd.addFrame(baa)end
__a=dd.getFrameObject(baa)a_a=__a.getImage(baa)b_a=baa;aaa:updateDraw()end,addFrame=function(aaa,baa)
dd.addFrame(baa)return aaa end,getFrameMetadata=function(aaa,baa,caa)return dd.getFrameData(baa,caa)end,setFrameMetadata=function(aaa,baa,caa,daa)
dd.setFrameData(baa,caa,daa)return aaa end,getMetadata=function(aaa,baa)return dd.getMetadata(baa)end,setMetadata=function(aaa,baa,caa)return
dd.setMetadata(baa,caa)end,getFrame=function(aaa,baa)return dd.getFrame(baa)end,getFrameObject=function(aaa,baa)return
dd.getFrameObject(baa)end,removeFrame=function(aaa,baa)dd.removeFrame(baa)return aaa end,moveFrame=function(aaa,baa,caa)
dd.moveFrame(baa,caa)return aaa end,getFrames=function(aaa)return dd.getFrames()end,getFrameCount=function(aaa)return
#dd.getFrames()end,getSelectedFrame=function(aaa)return b_a end,blit=function(aaa,baa,caa,daa,_ba,aba)
x=_ba or x;y=aba or y;__a.blit(baa,caa,daa,x,y)a_a=__a.getImage()
aaa:updateDraw()return aaa end,setText=function(aaa,baa,caa,daa)
x=caa or x;y=daa or y;__a.text(baa,x,y)a_a=__a.getImage()
aaa:updateDraw()return aaa end,setBg=function(aaa,baa,caa,daa)x=caa or x;y=
daa or y;__a.bg(baa,x,y)a_a=__a.getImage()
aaa:updateDraw()return aaa end,setFg=function(aaa,baa,caa,daa)x=caa or x;y=
daa or y;__a.fg(baa,x,y)a_a=__a.getImage()
aaa:updateDraw()return aaa end,getImageSize=function(aaa)
return dd.getSize()end,setImageSize=function(aaa,baa,caa)dd.setSize(baa,caa)a_a=__a.getImage()
aaa:updateDraw()return aaa end,resizeImage=function(aaa,baa,caa)
local daa=ac.resizeBIMG(dd.createBimg(),baa,caa)dd=_c(daa)b_a=1;__a=dd.getFrameObject(1)a_a=__a.getImage()
aaa:updateDraw()return aaa end,loadImage=function(aaa,baa)
if
(fs.exists(baa))then local caa=ac.loadBIMG(baa)dd=_c(caa)b_a=1
__a=dd.getFrameObject(1)a_a=__a.getImage()aaa:updateDraw()end;return aaa end,clear=function(aaa)
dd=_c()a_a=nil;aaa:updateDraw()return aaa end,getImage=function(aaa)return
dd.createBimg()end,draw=function(aaa)
if(bd.draw(aaa))then
if(aaa.parent~=nil)then
local baa,caa=aaa:getAnchorPosition()local daa,_ba=aaa:getSize()
if(a_a~=nil)then
for aba,bba in pairs(a_a)do if
(aba<=_ba-d_a)and(aba+d_a>=1)then
aaa.parent:blit(baa+c_a,caa+aba-1 +d_a,bba[1],bba[2],bba[3])end end end end end end,init=function(aaa)
if
(bd.init(aaa))then aaa.bgColor=aaa.parent:getTheme("GraphicBG")end end}return setmetatable(_aa,bd)end end
ba["objects"]["Animation"]=function(...)
local bb,cb,db,_c,ac,bc=math.floor,math.sin,math.cos,math.pi,math.sqrt,math.pow
local cc=function(bab,cab,dab)return bab+ (cab-bab)*dab end;local dc=function(bab)return bab end
local _d=function(bab)return 1 -bab end;local ad=function(bab)return bab*bab*bab end;local bd=function(bab)return
_d(ad(_d(bab)))end;local cd=function(bab)return
cc(ad(bab),bd(bab),bab)end;local dd=function(bab)return
cb((bab*_c)/2)end;local __a=function(bab)return
_d(db((bab*_c)/2))end;local a_a=function(bab)return
- (db(_c*x)-1)/2 end
local b_a=function(bab)
local cab=1.70158;local dab=cab+1;return dab*bab^3 -cab*bab^2 end;local c_a=function(bab)return bab^3 end
local d_a=function(bab)local cab=(2 *_c)/3;return

bab==0 and 0 or(bab==1 and 1 or(-2 ^ (10 *bab-10)*
cb((bab*10 -10.75)*cab)))end
local function _aa(bab)return bab==0 and 0 or 2 ^ (10 *bab-10)end
local function aaa(bab)return bab==0 and 0 or 2 ^ (10 *bab-10)end
local function baa(bab)local cab=1.70158;local dab=cab*1.525;return
bab<0.5 and( (2 *bab)^2 *
( (dab+1)*2 *bab-dab))/2 or
(
(2 *bab-2)^2 * ( (dab+1)* (bab*2 -2)+dab)+2)/2 end;local function caa(bab)return
bab<0.5 and 4 *bab^3 or 1 - (-2 *bab+2)^3 /2 end
local function daa(bab)
local cab=(2 *_c)/4.5
return
bab==0 and 0 or(bab==1 and 1 or
(
bab<0.5 and- (2 ^ (20 *bab-10)*
cb((20 *bab-11.125)*cab))/2 or
(2 ^ (-20 *bab+10)*cb((20 *bab-11.125)*cab))/2 +1))end
local function _ba(bab)return
bab==0 and 0 or(bab==1 and 1 or
(
bab<0.5 and 2 ^ (20 *bab-10)/2 or(2 -2 ^ (-20 *bab+10))/2))end;local function aba(bab)return
bab<0.5 and 2 *bab^2 or 1 - (-2 *bab+2)^2 /2 end;local function bba(bab)return
bab<0.5 and 8 *
bab^4 or 1 - (-2 *bab+2)^4 /2 end;local function cba(bab)return
bab<0.5 and 16 *
bab^5 or 1 - (-2 *bab+2)^5 /2 end;local function dba(bab)
return bab^2 end;local function _ca(bab)return bab^4 end
local function aca(bab)return bab^5 end;local function bca(bab)local cab=1.70158;local dab=cab+1;return
1 +dab* (bab-1)^3 +cab* (bab-1)^2 end;local function cca(bab)return 1 -
(1 -bab)^3 end
local function dca(bab)local cab=(2 *_c)/3;return

bab==0 and 0 or(bab==1 and 1 or(
2 ^ (-10 *bab)*cb((bab*10 -0.75)*cab)+1))end
local function _da(bab)return bab==1 and 1 or 1 -2 ^ (-10 *bab)end;local function ada(bab)return 1 - (1 -bab)* (1 -bab)end;local function bda(bab)return 1 - (
1 -bab)^4 end;local function cda(bab)
return 1 - (1 -bab)^5 end
local function dda(bab)return 1 -ac(1 -bc(bab,2))end;local function __b(bab)return ac(1 -bc(bab-1,2))end
local function a_b(bab)return

bab<0.5 and(1 -ac(
1 -bc(2 *bab,2)))/2 or(ac(1 -bc(-2 *bab+2,2))+1)/2 end
local function b_b(bab)local cab=7.5625;local dab=2.75
if(bab<1 /dab)then return cab*bab*bab elseif(bab<2 /dab)then local _bb=bab-
1.5 /dab;return cab*_bb*_bb+0.75 elseif(bab<2.5 /dab)then local _bb=bab-
2.25 /dab;return cab*_bb*_bb+0.9375 else
local _bb=bab-2.625 /dab;return cab*_bb*_bb+0.984375 end end;local function c_b(bab)return 1 -b_b(1 -bab)end;local function d_b(bab)return
x<0.5 and(1 -
b_b(1 -2 *bab))/2 or(1 +b_b(2 *bab-1))/2 end
local _ab={linear=dc,lerp=cc,flip=_d,easeIn=ad,easeInSine=__a,easeInBack=b_a,easeInCubic=c_a,easeInElastic=d_a,easeInExpo=aaa,easeInQuad=dba,easeInQuart=_ca,easeInQuint=aca,easeInCirc=dda,easeInBounce=c_b,easeOut=bd,easeOutSine=dd,easeOutBack=bca,easeOutCubic=cca,easeOutElastic=dca,easeOutExpo=_da,easeOutQuad=ada,easeOutQuart=bda,easeOutQuint=cda,easeOutCirc=__b,easeOutBounce=b_b,easeInOut=cd,easeInOutSine=a_a,easeInOutBack=baa,easeInOutCubic=caa,easeInOutElastic=daa,easeInOutExpo=_ba,easeInOutQuad=aba,easeInOutQuart=bba,easeInOutQuint=cba,easeInOutCirc=a_b,easeInOutBounce=d_b}local aab={}
return
function(bab,cab)local dab=cab.getObject("Object")(bab,cab)
local _bb={}local abb="Animation"local bbb;local cbb={}local dbb=0;local _cb=false;local acb=1;local bcb=false;local ccb=0;local dcb
local _db=false;local adb=false;local bdb="easeOut"local cdb;local function ddb(c_c)for d_c,_ac in pairs(c_c)do
_ac(_bb,cbb[acb].t,acb)end end
local function __c(c_c)if(acb==1)then
c_c:animationStartHandler()end;if(cbb[acb]~=nil)then ddb(cbb[acb].f)
dbb=cbb[acb].t end;acb=acb+1
if(cbb[acb]==nil)then if(bcb)then acb=1;dbb=0 else
c_c:animationDoneHandler()return end end;if(cbb[acb].t>0)then
bbb=os.startTimer(cbb[acb].t-dbb)else __c(c_c)end end
local function a_c(c_c,d_c)for n=1,#cbb do
if(cbb[n].t==c_c)then table.insert(cbb[n].f,d_c)return end end
for n=1,#cbb do
if(cbb[n].t>c_c)then if
(cbb[n-1]~=nil)then if(cbb[n-1].t<c_c)then
table.insert(cbb,n-1,{t=c_c,f={d_c}})return end else
table.insert(cbb,n,{t=c_c,f={d_c}})return end end end
if(#cbb<=0)then table.insert(cbb,1,{t=c_c,f={d_c}})return elseif(
cbb[#cbb].t<c_c)then table.insert(cbb,{t=c_c,f={d_c}})end end
local function b_c(c_c,d_c,_ac,aac,bac,cac,dac,_bc)local abc=cdb;local bbc,cbc;local dbc=""if(abc:getParent()~=nil)then
dbc=abc:getParent():getName()end;dbc=dbc..abc:getName()
a_c(aac+0.05,function()
if(
dac~=nil)then if(aab[dac]==nil)then aab[dac]={}end;if
(aab[dac][dbc]~=nil)then
if(aab[dac][dbc]~=_bc)then aab[dac][dbc]:cancel()end end;aab[dac][dbc]=_bc end;bbc,cbc=bac(abc)end)
for n=0.05,_ac+0.01,0.05 do
a_c(aac+n,function()
local _cc=math.floor(_ab.lerp(bbc,c_c,_ab[bdb](n/_ac))+0.5)
local acc=math.floor(_ab.lerp(cbc,d_c,_ab[bdb](n/_ac))+0.5)cac(abc,_cc,acc)
if(dac~=nil)then if(n>=_ac-0.01)then if(aab[dac][dbc]==_bc)then aab[dac][dbc]=
nil end end end end)end end
_bb={name=bab,getType=function(c_c)return abb end,setMode=function(c_c,d_c)bdb=d_c;return c_c end,addMode=function(c_c,d_c,_ac)_ab[d_c]=_ac
return c_c end,setObject=function(c_c,d_c)cdb=d_c;return c_c end,move=function(c_c,d_c,_ac,aac,bac,cac)cdb=cac or cdb
b_c(d_c,_ac,aac,
bac or 0,cdb.getPosition,cdb.setPosition,"position",c_c)return c_c end,offset=function(c_c,d_c,_ac,aac,bac,cac)cdb=
cac or cdb
b_c(d_c,_ac,aac,bac or 0,cdb.getOffset,cdb.setOffset,"offset",c_c)return c_c end,size=function(c_c,d_c,_ac,aac,bac,cac)cdb=cac or
cdb
b_c(d_c,_ac,aac,bac or 0,cdb.getSize,cdb.setSize,"size",c_c)return c_c end,changeText=function(c_c,d_c,_ac,...)
local aac={...}_ac=_ac or 0;cdb=obj or cdb;for n=1,#aac do
a_c(_ac+n* (d_c/#aac),function()
cdb.setText(cdb,aac[n])end)end;return c_c end,changeBackground=function(c_c,d_c,_ac,...)
local aac={...}_ac=_ac or 0;cdb=obj or cdb;for n=1,#aac do
a_c(_ac+n* (d_c/#aac),function()
cdb.setBackground(cdb,aac[n])end)end;return c_c end,changeTextColor=function(c_c,d_c,_ac,...)
local aac={...}_ac=_ac or 0;cdb=obj or cdb;for n=1,#aac do
a_c(_ac+n* (d_c/#aac),function()
cdb.setForeground(cdb,aac[n])end)end;return c_c end,add=function(c_c,d_c,_ac)
dcb=d_c
a_c((_ac or ccb)+
(cbb[#cbb]~=nil and cbb[#cbb].t or 0),d_c)return c_c end,wait=function(c_c,d_c)ccb=d_c;return c_c end,rep=function(c_c,d_c)
if(
dcb~=nil)then for n=1,d_c or 1 do
a_c((wait or ccb)+
(cbb[#cbb]~=nil and cbb[#cbb].t or 0),dcb)end end;return c_c end,onDone=function(c_c,d_c)
c_c:registerEvent("animation_done",d_c)return c_c end,onStart=function(c_c,d_c)
c_c:registerEvent("animation_start",d_c)return c_c end,setAutoDestroy=function(c_c,d_c)
adb=d_c~=nil and d_c or true;return c_c end,animationDoneHandler=function(c_c)
c_c:sendEvent("animation_done",c_c)c_c:listenEvent("other_event",false)if(adb)then
c_c:getParent():removeObject(c_c)c_c=nil end end,animationStartHandler=function(c_c)
c_c:sendEvent("animation_start",c_c)end,clear=function(c_c)cbb={}dcb=nil;ccb=0;acb=1;dbb=0;bcb=false;return c_c end,play=function(c_c,d_c)
c_c:cancel()_cb=true;bcb=d_c and true or false;acb=1;dbb=0
if(cbb[acb]~=nil)then
if(
cbb[acb].t>0)then bbb=os.startTimer(cbb[acb].t)else __c(c_c)end else c_c:animationDoneHandler()end;c_c:listenEvent("other_event")return c_c end,cancel=function(c_c)if(
bbb~=nil)then os.cancelTimer(bbb)bcb=false end
_cb=false;c_c:listenEvent("other_event",false)return c_c end,internalObjetCall=function(c_c)
c_c:play(_db)end,eventHandler=function(c_c,d_c,_ac)if(_cb)then
if(d_c=="timer")and(_ac==bbb)then if(cbb[acb]~=nil)then
__c(c_c)else c_c:animationDoneHandler()end end end end}_bb.__index=_bb;return setmetatable(_bb,dab)end end
ba["objects"]["MovableFrame"]=function(...)
local bb,cb,db,_c=math.max,math.min,string.sub,string.rep
return
function(ac,bc)local cc=bc.getObject("Frame")(ac,bc)local dc="MovableFrame"
local _d;local ad,bd=0,0;local cd={{x1=1,x2="width",y1=1,y2=1}}
local dd={getType=function()return dc end,setDraggingMap=function(__a,a_a)
cd=a_a;return __a end,getDraggingMap=function(__a)return cd end,isType=function(__a,a_a)
return dc==a_a or(cc.isType~=nil and
cc.isType(a_a))or false end,getBase=function(__a)return cc end,load=function(__a)
cc.load(__a)__a:listenEvent("mouse_click")
__a:listenEvent("mouse_up")__a:listenEvent("mouse_drag")end,dragHandler=function(__a,a_a,b_a,c_a)
if
(cc.dragHandler(__a,a_a,b_a,c_a))then
if(isDragging)then local d_a,_aa=_d:getOffset()
d_a=d_a<0 and math.abs(d_a)or-d_a;_aa=_aa<0 and math.abs(_aa)or-_aa;local aaa=1
local baa=1;aaa,baa=_d:getAbsolutePosition()
__a:setPosition(b_a+ad- (aaa-1)+d_a,
c_a+bd- (baa-1)+_aa)__a:updateDraw()end;return true end end,mouseHandler=function(__a,a_a,b_a,c_a,...)
if
(cc.mouseHandler(__a,a_a,b_a,c_a,...))then _d:setImportant(__a)local d_a,_aa=__a:getAbsolutePosition()
local aaa,baa=__a:getSize()
for caa,daa in pairs(cd)do local _ba,aba=daa.x1 =="width"and aaa or daa.x1,daa.x2 =="width"and
aaa or daa.x2;local bba,cba=
daa.y1 =="height"and baa or daa.y1,
daa.y2 =="height"and baa or daa.y2
if
(b_a>=
d_a+_ba-1)and(b_a<=d_a+aba-1)and(c_a>=_aa+bba-1)and(c_a<=_aa+cba-1)then isDragging=true;ad=
d_a-b_a;bd=_aa-c_a;return true end end;return true end end,mouseUpHandler=function(__a,...)
isDragging=false;return cc.mouseUpHandler(__a,...)end,setParent=function(__a,a_a,...)
cc.setParent(__a,a_a,...)_d=a_a;return __a end}dd.__index=dd;return setmetatable(dd,cc)end end
ba["objects"]["Button"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("VisualObject")(db,_c)local bc="Button"local cc="center"local dc="center"local _d="Button"ac:setSize(12,3)
ac:setZIndex(5)
local ad={getType=function(bd)return bc end,isType=function(bd,cd)return
bc==cd or ac.isType~=nil and ac.isType(cd)or false end,getBase=function(bd)return
ac end,setHorizontalAlign=function(bd,cd)cc=cd;bd:updateDraw()return bd end,setVerticalAlign=function(bd,cd)
dc=cd;bd:updateDraw()return bd end,setText=function(bd,cd)_d=cd
bd:updateDraw()return bd end,draw=function(bd)ac.draw(bd)
bd:addDraw("button",function()
local cd,dd=bd:getSize()local __a=bb.getTextVerticalAlign(dd,dc)local a_a;if(cc=="center")then a_a=math.floor((
cd-_d:len())/2)elseif(cc=="right")then
a_a=cd-_d:len()end
bd:addText(a_a+1,__a,_d)
bd:addFG(a_a+1,__a,cb[bd:getForeground()or colors.white]:rep(_d:len()))end)end}ad.__index=ad;return setmetatable(ad,ac)end end
ba["objects"]["Slider"]=function(...)local bb=_b("tHex")
return
function(cb,db)
local _c=db.getObject("ChangeableObject")(cb,db)local ac="Slider"_c:setSize(12,1)_c:setValue(1)
_c:setBackground(false,"\140",colors.black)local bc="horizontal"local cc=" "local dc=colors.black;local _d=colors.gray;local ad=12;local bd=1
local cd=1
local function dd(a_a,b_a,c_a,d_a)local _aa,aaa=a_a:getPosition()local baa,caa=a_a:getSize()local daa=
bc=="vertical"and caa or baa
for i=0,daa do
if

(
(bc=="vertical"and aaa+i==d_a)or(bc=="horizontal"and _aa+i==c_a))and(_aa<=c_a)and(_aa+baa>c_a)and(aaa<=d_a)and
(aaa+caa>d_a)then bd=math.min(i+1,daa- (#
cc+cd-2))
a_a:setValue(ad/daa*bd)a_a:updateDraw()end end end
local __a={getType=function(a_a)return ac end,load=function(a_a)a_a:listenEvent("mouse_click")
a_a:listenEvent("mouse_drag")a_a:listenEvent("mouse_scroll")end,setSymbol=function(a_a,b_a)
cc=b_a:sub(1,1)a_a:updateDraw()return a_a end,setIndex=function(a_a,b_a)bd=b_a;if(bd<1)then
bd=1 end;local c_a,d_a=a_a:getSize()
bd=math.min(bd,
(bc=="vertical"and d_a or c_a)- (cd-1))
a_a:setValue(ad/ (bc=="vertical"and d_a or c_a)*bd)a_a:updateDraw()return a_a end,getIndex=function(a_a)return
bd end,setMaxValue=function(a_a,b_a)ad=b_a;return a_a end,setSymbolColor=function(a_a,b_a)symbolColor=b_a
a_a:updateDraw()return a_a end,setBarType=function(a_a,b_a)bc=b_a:lower()
a_a:updateDraw()return a_a end,mouseHandler=function(a_a,b_a,c_a,d_a)if(_c.mouseHandler(a_a,b_a,c_a,d_a))then
dd(a_a,b_a,c_a,d_a)return true end;return false end,dragHandler=function(a_a,b_a,c_a,d_a)if
(_c.dragHandler(a_a,b_a,c_a,d_a))then dd(a_a,b_a,c_a,d_a)return true end
return false end,scrollHandler=function(a_a,b_a,c_a,d_a)
if
(_c.scrollHandler(a_a,b_a,c_a,d_a))then local _aa,aaa=a_a:getSize()bd=bd+b_a;if(bd<1)then bd=1 end
bd=math.min(bd,(
bc=="vertical"and aaa or _aa)- (cd-1))
a_a:setValue(ad/ (bc=="vertical"and aaa or _aa)*bd)a_a:updateDraw()return true end;return false end,draw=function(a_a)
_c.draw(a_a)
a_a:addDraw("slider",function()local b_a,c_a=a_a:getSize()
local d_a,_aa=a_a:getBackground(),a_a:getForeground()
if(bc=="horizontal")then a_a:addText(bd,oby,cc:rep(cd))
if(_d~=false)then a_a:addBG(bd,1,bb[_d]:rep(
#cc*cd))end;if(dc~=false)then
a_a:addFG(bd,1,bb[dc]:rep(#cc*cd))end end
if(bc=="vertical")then
for n=0,c_a-1 do
if(bd==n+1)then for curIndexOffset=0,math.min(cd-1,c_a)do
a_a:addBlit(1,1 +n+curIndexOffset,cc,bb[symbolColor],bb[symbolColor])end else if(n+1 <bd)or(n+1 >
bd-1 +cd)then
a_a:addBlit(1,1 +n,bgSymbol,bb[_aa],bb[d_a])end end end end end)end}__a.__index=__a;return setmetatable(__a,_c)end end
ba["objects"]["Object"]=function(...)local bb=_b("basaltEvent")
local cb=_b("utils")local db=cb.uuid;local _c,ac=table.unpack,string.sub
return
function(bc,cc)bc=bc or db()
assert(cc~=nil,
"Unable to find basalt instance! ID: "..bc)local dc="Object"local _d,ad=true,false;local bd=bb()local cd={}local dd
local __a={init=function(a_a)if(ad)then return false end
ad=true;return true end,load=function(a_a)end,getType=function(a_a)return dc end,isType=function(a_a,b_a)
return dc==b_a end,getName=function(a_a)return bc end,getParent=function(a_a)return dd end,setParent=function(a_a,b_a,c_a)
if(c_a)then dd=b_a;return a_a end
if(b_a.getType~=nil and b_a:isType("Container"))then
a_a:remove()b_a:addObject(a_a)if(a_a.show)then a_a:show()end;dd=b_a end;return a_a end,updateEvents=function(a_a)for b_a,c_a in
pairs(cd)do dd:removeEvent(b_a,a_a)
if(c_a)then dd:addEvent(b_a,a_a)end end;return a_a end,listenEvent=function(a_a,b_a,c_a)if(
dd~=nil)then
if(c_a)or(c_a==nil)then cd[b_a]=true;dd:addEvent(b_a,a_a)elseif
(c_a==false)then cd[b_a]=false;dd:removeEvent(b_a,a_a)end end
return a_a end,getZIndex=function(a_a)return
1 end,enable=function(a_a)_d=true;return a_a end,disable=function(a_a)_d=false;return a_a end,isEnabled=function(a_a)return
_d end,remove=function(a_a)if(dd~=nil)then dd:removeObject(a_a)end
a_a:updateDraw()return a_a end,getBaseFrame=function(a_a)if(dd~=nil)then
return dd:getBaseFrame()end;return a_a end,onEvent=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("other_event",c_a)end end;return a_a end,getEventSystem=function(a_a)return
bd end,registerEvent=function(a_a,b_a,c_a)if(dd~=nil)then dd:addEvent(b_a,a_a)end;return
bd:registerEvent(b_a,c_a)end,removeEvent=function(a_a,b_a,c_a)if(
bd:getEventCount(b_a)<1)then
if(dd~=nil)then dd:removeEvent(b_a,a_a)end end
return bd:removeEvent(b_a,c_a)end,sendEvent=function(a_a,b_a,...)return
bd:sendEvent(b_a,a_a,...)end,onClick=function(a_a,...)for b_a,c_a in pairs(table.pack(...))do
if(
type(c_a)=="function")then a_a:registerEvent("mouse_click",c_a)end end;return a_a end,onClickUp=function(a_a,...)for b_a,c_a in
pairs(table.pack(...))do
if(type(c_a)=="function")then a_a:registerEvent("mouse_up",c_a)end end;return a_a end,onRelease=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("mouse_release",c_a)end end;return a_a end,onScroll=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("mouse_scroll",c_a)end end;return a_a end,onHover=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("mouse_hover",c_a)end end;return a_a end,onLeave=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("mouse_leave",c_a)end end;return a_a end,onDrag=function(a_a,...)
for b_a,c_a in
pairs(table.pack(...))do if(type(c_a)=="function")then
a_a:registerEvent("mouse_drag",c_a)end end;return a_a end,onKey=function(a_a,...)for b_a,c_a in
pairs(table.pack(...))do
if(type(c_a)=="function")then a_a:registerEvent("key",c_a)end end;return a_a end,onChar=function(a_a,...)for b_a,c_a in
pairs(table.pack(...))do
if(type(c_a)=="function")then a_a:registerEvent("char",c_a)end end;return a_a end,onKeyUp=function(a_a,...)for b_a,c_a in
pairs(table.pack(...))do
if(type(c_a)=="function")then a_a:registerEvent("key_up",c_a)end end;return a_a end}__a.__index=__a;return __a end end
ba["objects"]["ChangeableObject"]=function(...)
return
function(bb,cb)
local db=cb.getObject("VisualObject")(bb,cb)local _c="ChangeableObject"local ac
local bc={setValue=function(cc,dc,_d)if(ac~=dc)then ac=dc;cc:updateDraw()if(_d~=false)then
cc:valueChangedHandler()end end;return cc end,getValue=function(cc)return
ac end,onChange=function(cc,...)
for dc,_d in pairs(table.pack(...))do if(type(_d)=="function")then
cc:registerEvent("value_changed",_d)end end;return cc end,valueChangedHandler=function(cc)
cc:sendEvent("value_changed",ac)end}bc.__index=bc;return setmetatable(bc,db)end end
ba["objects"]["Frame"]=function(...)local bb=_b("utils")
local cb,db,_c,ac,bc=math.max,math.min,string.sub,string.rep,string.len
return
function(cc,dc)local _d=dc.getObject("Container")(cc,dc)local ad="Frame"
local bd;local cd=true;local dd,__a=0,0;_d:setSize(30,10)_d:setZIndex(10)
local a_a={getType=function()return ad end,isType=function(b_a,c_a)return

ad==c_a or _d.isType~=nil and _d.isType(c_a)or false end,getBase=function(b_a)
return _d end,getOffset=function(b_a)return dd,__a end,setOffset=function(b_a,c_a,d_a)dd=c_a or dd;__a=d_a or __a
b_a:updateDraw()return b_a end,setParent=function(b_a,c_a,...)
_d.setParent(b_a,c_a,...)bd=c_a;return b_a end,render=function(b_a)
if(_d.render~=nil)then
if
(b_a:isVisible())then _d.render(b_a)local c_a=b_a:getObjects()for d_a,_aa in ipairs(c_a)do
if(
_aa.element.render~=nil)then _aa.element:render()end end end end end,updateDraw=function(b_a)if(
bd~=nil)then bd:updateDraw()end;return b_a end,blit=function(b_a,c_a,d_a,_aa,aaa,baa)
local caa,daa=b_a:getPosition()local _ba,aba=bd:getOffset()caa=caa-_ba;daa=daa-aba
local bba,cba=b_a:getSize()
if d_a>=1 and d_a<=cba then
local dba=_c(_aa,cb(1 -c_a+1,1),cb(bba-c_a+1,1))
local _ca=_c(aaa,cb(1 -c_a+1,1),cb(bba-c_a+1,1))
local aca=_c(baa,cb(1 -c_a+1,1),cb(bba-c_a+1,1))
bd:blit(cb(c_a+ (caa-1),caa),daa+d_a-1,dba,_ca,aca)end end,setCursor=function(b_a,c_a,d_a,_aa,aaa)
local baa,caa=b_a:getPosition()
bd:setCursor(c_a or false,(d_a or 0)+baa-1,(_aa or 0)+caa-1,aaa or
colors.white)return b_a end}
for b_a,c_a in
pairs({"drawBackgroundBox","drawForegroundBox","drawTextBox"})do
a_a[c_a]=function(d_a,_aa,aaa,baa,caa,daa)local _ba,aba=d_a:getPosition()local bba,cba=bd:getOffset()
_ba=_ba-bba;aba=aba-cba
caa=(aaa<1 and(
caa+aaa>d_a:getHeight()and d_a:getHeight()or caa+aaa-1)or(
caa+
aaa>d_a:getHeight()and d_a:getHeight()-aaa+1 or caa))
baa=(_aa<1 and(baa+_aa>d_a:getWidth()and d_a:getWidth()or baa+
_aa-1)or(

baa+_aa>d_a:getWidth()and d_a:getWidth()-_aa+1 or baa))
bd[c_a](bd,cb(_aa+ (_ba-1),_ba),cb(aaa+ (aba-1),aba),baa,caa,daa)end end
for b_a,c_a in pairs({"setBG","setFG","setText"})do
a_a[c_a]=function(d_a,_aa,aaa,baa)
local caa,daa=d_a:getPosition()local _ba,aba=bd:getOffset()caa=caa-_ba;daa=daa-aba
local bba,cba=d_a:getSize()if(aaa>=1)and(aaa<=cba)then
bd[c_a](bd,cb(_aa+ (caa-1),caa),daa+aaa-1,_c(baa,cb(
1 -_aa+1,1),cb(bba-_aa+1,1)))end end end;a_a.__index=a_a;return setmetatable(a_a,_d)end end
ba["objects"]["Flexbox"]=function(...)
return
function(bb,cb)
local db=cb.getObject("Frame")(bb,cb)local _c="Flexbox"local ac="row"local bc="flex-start"local cc=1
local function dc(ad)local bd=ad:getObjects()
local cd=#bd;local dd,__a=ad:getPosition()local a_a,b_a=ad:getSize()local c_a=0
for aaa,baa in ipairs(bd)do if
ac=="row"then local caa,daa=baa.element:getSize()c_a=c_a+caa else
local caa,daa=baa.element:getSize()c_a=c_a+daa end end
local d_a=(ac=="row"and a_a or b_a)-c_a- (cc* (cd-1))local _aa=0
if bc=="center"then _aa=d_a/2 elseif bc=="flex-end"then _aa=d_a end
for aaa,baa in ipairs(bd)do
if ac=="row"then baa.element:setPosition(_aa,1)
local caa,daa=baa.element:getSize()_aa=_aa+caa+cc else
baa.element:setPosition(1,math.floor(_aa+0.5))local caa,daa=baa.element:getSize()_aa=_aa+daa+cc end end end
local _d={getType=function()return _c end,isType=function(ad,bd)return
_c==bd or db.getBase(ad).isType(bd)or false end,setSpacing=function(ad,bd)
cc=bd;dc(ad)return ad end,getSpacing=function(ad)return cc end,setFlexDirection=function(ad,bd)if
bd=="row"or bd=="column"then ac=bd;dc(ad)end;return ad end,setJustifyContent=function(ad,bd)if


bd=="flex-start"or bd=="flex-end"or bd=="center"or bd=="space-between"or bd=="space-around"then bc=bd;dc(ad)end
return ad end}for ad,bd in pairs(cb.getObjects())do
_d["add"..ad]=function(cd,dd)
local __a=db["add"..ad](cd,dd)dc(db)return __a end end;_d.__index=_d;return
setmetatable(_d,db)end end
ba["objects"]["Container"]=function(...)local bb=_b("utils")local cb=bb.tableCount
return
function(db,_c)
local ac=_c.getObject("VisualObject")(db,_c)local bc="Container"local cc={}local dc={}local _d={}local ad={}local bd;local cd=true;local dd,__a=0,0
local a_a=function(cba,dba)if cba.zIndex==
dba.zIndex then return cba.objId<dba.objId else
return cba.zIndex<dba.zIndex end end
local b_a=function(cba,dba)if cba.zIndex==dba.zIndex then return cba.evId>dba.evId else return
cba.zIndex>dba.zIndex end end
local function c_a(cba,dba)if(type(dba)=="table")then dba=dba:getName()end;for _ca,aca in
ipairs(cc)do
if aca.element:getName()==dba then return aca.element end end end
local function d_a(cba,dba)local _ca=c_a(dba)if(_ca~=nil)then return _ca end;for aca,bca in pairs(objects)do
if
(b:getType()=="Container")then local cca=b:getDeepObject(dba)if(cca~=nil)then return cca end end end end
local function _aa(cba,dba,_ca)if(c_a(dba:getName())~=nil)then return end;dd=dd+1
local aca=dba:getZIndex()
table.insert(cc,{element=dba,zIndex=aca,objId=dd})cd=false;dba:setParent(cba,true)
if(dba.init~=nil)then dba:init()end;if(dba.load~=nil)then dba:load()end;if(dba.draw~=nil)then
dba:draw()end;return dba end
local function aaa(cba,dba,_ca)dd=dd+1;__a=__a+1;for aca,bca in pairs(cc)do
if(bca.element==dba)then bca.zIndex=_ca;bca.objId=dd;break end end;for aca,bca in pairs(dc)do
for cca,dca in pairs(bca)do if
(dca.element==dba)then dca.zIndex=_ca;dca.evId=__a end end end;cd=false
cba:updateDraw()end
local function baa(cba,dba)
if(type(dba)=="string")then dba=c_a(dba:getName())end;if(dba==nil)then return end
for _ca,aca in ipairs(cc)do if aca.element==dba then
table.remove(cc,_ca)return true end end;cd=false end
local function caa(cba,dba)local _ca=cba:getParent()
for aca,bca in pairs(dc)do for cca,dca in pairs(bca)do if(dca.element==dba)then
table.remove(dc[aca],cca)end end;if(
cb(dc[aca])<=0)then ad[aca]=false
if(_ca~=nil)then _ca:removeEvent(aca,cba)end end end;cd=false end
local function daa(cba,dba,_ca)if(type(_ca)=="table")then _ca=_ca:getName()end
if(dc[dba]~=
nil)then for aca,bca in pairs(dc[dba])do
if(bca.element:getName()==_ca)then return bca end end end end
local function _ba(cba,dba,_ca)
if(daa(cba,dba,_ca:getName())~=nil)then return end;local aca=_ca:getZIndex()__a=__a+1
if(dc[dba]==nil)then dc[dba]={}end
table.insert(dc[dba],{element=_ca,zIndex=aca,evId=__a})cd=false;cba:listenEvent(dba)return _ca end
local function aba(cba,dba,_ca)local aca=cba:getParent()
if(dc[dba]~=nil)then
for bca,cca in pairs(dc[dba])do if
(cca.element==_ca)then table.remove(dc[dba],bca)end end
if(cb(dc[dba])<=0)then cba:listenEvent(dba,false)end end;cd=false end;local function bba(cba)cba:sortElementOrder()return cc end
_d={getType=function()return bc end,getBase=function(cba)return
ac end,isType=function(cba,dba)return
bc==dba or ac.isType~=nil and ac.isType(dba)or false end,setSize=function(cba,...)
ac.setSize(cba,...)cba:customEventHandler("basalt_FrameResize")return cba end,setPosition=function(cba,...)
ac.setPosition(cba,...)cba:customEventHandler("basalt_FrameReposition")
return cba end,searchObjects=function(cba,dba)local _ca={}
for aca,bca in pairs(cc)do if
(string.find(aca:getName(),dba))then table.insert(_ca,bca)end end;return _ca end,getObjectsByType=function(cba,dba)
local _ca={}for aca,bca in pairs(cc)do
if(bca:isType(_ca))then table.insert(_ca,bca)end end;return _ca end,setImportant=function(cba,dba)dd=
dd+1;__a=__a+1
for _ca,aca in pairs(dc)do for bca,cca in pairs(aca)do
if(cca.element==dba)then cca.evId=__a
table.remove(dc[_ca],bca)table.insert(dc[_ca],cca)break end end end
for _ca,aca in ipairs(cc)do if aca.element==dba then aca.objId=dd;table.remove(cc,_ca)
table.insert(cc,aca)break end end;if(cba.updateDraw~=nil)then cba:updateDraw()end
cd=false end,sortElementOrder=function(cba)if
(cd)then return end;table.sort(cc,a_a)for dba,_ca in pairs(dc)do
table.sort(dc[dba],b_a)end;cd=true end,removeFocusedObject=function(cba)if(
bd~=nil)then
if(c_a(cba,bd)~=nil)then bd:loseFocusHandler()end end;bd=nil;return cba end,setFocusedObject=function(cba,dba)
if(
bd~=dba)then if(bd~=nil)then
if(c_a(cba,bd)~=nil)then bd:loseFocusHandler()end end;if(dba~=nil)then if(c_a(cba,dba)~=nil)then
dba:getFocusHandler()end end;bd=dba;return true end;return false end,getFocusedObject=function(cba)return
bd end,getObject=c_a,getObjects=bba,getDeepObject=d_a,addObject=_aa,removeObject=baa,getEvent=daa,addEvent=_ba,removeEvent=aba,updateZIndex=aaa,listenEvent=function(cba,dba,_ca)ac.listenEvent(cba,dba,_ca)ad[dba]=
_ca~=nil and _ca or true
if(dc[dba]==nil)then dc[dba]={}end;return cba end,customEventHandler=function(cba,...)
ac.customEventHandler(cba,...)
for dba,_ca in pairs(cc)do if(_ca.element.customEventHandler~=nil)then
_ca.element:customEventHandler(...)end end end,loseFocusHandler=function(cba)
ac.loseFocusHandler(cba)if(bd~=nil)then bd:loseFocusHandler()bd=nil end end,getBasalt=function(cba)return
_c end,setPalette=function(cba,dba,...)local _ca=cba:getParent()
_ca:setPalette(dba,...)return cba end,eventHandler=function(cba,...)
if(ac.eventHandler~=nil)then
ac.eventHandler(cba,...)
if(dc["other_event"]~=nil)then cba:sortElementOrder()
for dba,_ca in
ipairs(dc["other_event"])do if(_ca.element.eventHandler~=nil)then
_ca.element.eventHandler(_ca.element,...)end end end end end}
for cba,dba in
pairs({mouse_click={"mouseHandler",true},mouse_up={"mouseUpHandler",false},mouse_drag={"dragHandler",false},mouse_scroll={"scrollHandler",true},mouse_hover={"hoverHandler",false}})do
_d[dba[1]]=function(_ca,aca,bca,cca,...)
if(ac[dba[1]]~=nil)then
if(ac[dba[1]](_ca,aca,bca,cca,...))then
if
(dc[cba]~=nil)then _ca:sortElementOrder()
for dca,_da in ipairs(dc[cba])do
if
(_da.element[dba[1]]~=nil)then local ada,bda=0,0
if(_ca.getOffset~=nil)then ada,bda=_ca:getOffset()end;if(_da.element[dba[1]](_da.element,aca,bca+ada,cca+bda,...))then return
true end end end;if(dba[2])then _ca:removeFocusedObject()end;return true end end end end end
for cba,dba in
pairs({key="keyHandler",key_up="keyUpHandler",char="charHandler"})do
_d[dba]=function(_ca,...)
if(ac[dba]~=nil)then
if(ac[dba](_ca,...))then
if(dc[cba]~=nil)then
_ca:sortElementOrder()for aca,bca in ipairs(dc[cba])do
if(bca.element[dba]~=nil)then if
(bca.element[dba](bca.element,...))then return true end end end end end end end end
for cba,dba in pairs(_c.getObjects())do _d["add"..cba]=function(_ca,aca)
return _aa(_ca,dba(aca,_c))end end;_d.__index=_d;return setmetatable(_d,ac)end end
ba["objects"]["Graph"]=function(...)
return
function(bb,cb)
local db=cb.getObject("ChangeableObject")(bb,cb)local _c="Graph"db:setZIndex(5)db:setSize(30,10)local ac={}
local bc=colors.gray;local cc="\7"local dc=colors.black;local _d=100;local ad=0;local bd="line"local cd=10
local dd={getType=function(__a)return _c end,setGraphColor=function(__a,a_a)bc=
a_a or bc;__a:updateDraw()return __a end,setGraphSymbol=function(__a,a_a,b_a)cc=
a_a or cc;dc=b_a or dc;__a:updateDraw()return __a end,getGraphSymbol=function(__a)return
cc,dc end,addDataPoint=function(__a,a_a)if a_a>=ad and a_a<=_d then table.insert(ac,a_a)
__a:updateDraw()end
if(#ac>100)then table.remove(ac,1)end;return __a end,setMaxValue=function(__a,a_a)
_d=a_a;__a:updateDraw()return __a end,getMaxValue=function(__a)return _d end,setMinValue=function(__a,a_a)
ad=a_a;__a:updateDraw()return __a end,getMinValue=function(__a)return ad end,setGraphType=function(__a,a_a)if
a_a=="scatter"or a_a=="line"or a_a=="bar"then bd=a_a
__a:updateDraw()end;return __a end,setMaxEntries=function(__a,a_a)
cd=a_a;__a:updateDraw()return __a end,getMaxEntries=function(__a)return cd end,clear=function(__a)
ac={}__a:updateDraw()return __a end,draw=function(__a)db.draw(__a)
__a:addDraw("graph",function()
local a_a,b_a=__a:getPosition()local c_a,d_a=__a:getSize()
local _aa,aaa=__a:getBackground(),__a:getForeground()local baa=_d-ad;local caa,daa;local _ba=#ac-cd+1;if _ba<1 then _ba=1 end
for i=_ba,#ac do local aba=ac[i]
local bba=math.floor(( (
c_a-1)/ (cd-1))* (i-_ba)+1.5)
local cba=math.floor((d_a-1)- ( (d_a-1)/baa)* (aba-ad)+1.5)
if bd=="scatter"then __a:addBackgroundBox(bba,cba,1,1,bc)
__a:addForegroundBox(bba,cba,1,1,dc)__a:addTextBox(bba,cba,1,1,cc)elseif bd=="line"then
if caa and daa then
local dba=math.abs(bba-caa)local _ca=math.abs(cba-daa)local aca=caa<bba and 1 or-1;local bca=daa<
cba and 1 or-1;local cca=dba-_ca
while true do
__a:addBackgroundBox(caa,daa,1,1,bc)__a:addForegroundBox(caa,daa,1,1,dc)
__a:addTextBox(caa,daa,1,1,cc)if caa==bba and daa==cba then break end;local dca=2 *cca;if dca>-_ca then
cca=cca-_ca;caa=caa+aca end
if dca<dba then cca=cca+dba;daa=daa+bca end end end;caa,daa=bba,cba elseif bd=="bar"then
__a:addBackgroundBox(bba-1,cba,1,d_a-cba,bc)end end end)end}dd.__index=dd;return setmetatable(dd,db)end end
ba["objects"]["Label"]=function(...)local bb=_b("utils")local cb=bb.wrapText
local db=_b("tHex")
return
function(_c,ac)local bc=ac.getObject("VisualObject")(_c,ac)
local cc="Label"bc:setZIndex(3)local dc=true;local _d,ad=false,false;local bd,cd="Label","left"
local dd={getType=function(__a)return cc end,getBase=function(__a)return
bc end,setText=function(__a,a_a)bd=tostring(a_a)
if(dc)then __a:setSize(#bd,1)dc=true end;__a:updateDraw()return __a end,getAutoSize=function(__a)return
dc end,setAutoSize=function(__a,a_a)dc=a_a;return __a end,getText=function(__a)return bd end,setBackground=function(__a,a_a)
bc.setBackground(__a,a_a)ad=true;return __a end,setForeground=function(__a,a_a)
bc.setForeground(__a,a_a)_d=true;return __a end,setSize=function(__a,...)bc.setSize(__a,...)
dc=false;return __a end,setTextAlign=function(__a,a_a)cd=a_a or cd;return __a end,draw=function(__a)
bc.draw(__a)
__a:addDraw("label",function()local a_a=__a:getParent()local b_a,c_a=__a:getPosition()
local d_a,_aa=__a:getSize()local aaa,baa=__a:getBackground(),__a:getForeground()
if not(dc)then
local caa=cb(bd,d_a)
for daa,_ba in pairs(caa)do
if(daa<=_aa)then
local aba=cd=="center"and
math.floor(d_a/2 -_ba:len()/2 +0.5)or
cd=="right"and d_a- (_ba:len()-1)or 1;__a:addText(aba,daa,_ba)end end else __a:addText(1,1,bd:sub(1,d_a))end end)end,init=function(__a)
bc.init(__a)local a_a=__a:getParent()
__a:setForeground(a_a:getForeground())__a:setBackground(a_a:getBackground())end}dd.__index=dd;return setmetatable(dd,bc)end end
ba["objects"]["Radio"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("List")(db,_c)local bc="Radio"ac:setSize(1,1)ac:setZIndex(5)local cc={}
local dc=colors.black;local _d=colors.green;local ad=colors.black;local bd=colors.red;local cd=true;local dd="\7"
local __a="left"
local a_a={getType=function(b_a)return bc end,addItem=function(b_a,c_a,d_a,_aa,aaa,baa,...)ac.addItem(b_a,c_a,aaa,baa,...)table.insert(cc,{x=d_a or 1,y=
_aa or#cc*2})
return b_a end,removeItem=function(b_a,c_a)
ac.removeItem(b_a,c_a)table.remove(cc,c_a)return b_a end,clear=function(b_a)
ac.clear(b_a)cc={}return b_a end,editItem=function(b_a,c_a,d_a,_aa,aaa,baa,caa,...)
ac.editItem(b_a,c_a,d_a,baa,caa,...)table.remove(cc,c_a)
table.insert(cc,c_a,{x=_aa or 1,y=aaa or 1})return b_a end,setBoxSelectionColor=function(b_a,c_a,d_a)
dc=c_a;_d=d_a;return b_a end,getBoxSelectionColor=function(b_a)return dc,_d end,setBoxDefaultColor=function(b_a,c_a,d_a)ad=c_a;bd=d_a
return b_a end,getBoxDefaultColor=function(b_a)return ad,bd end,mouseHandler=function(b_a,c_a,d_a,_aa,...)
if(#cc>0)then
local aaa,baa=b_a:getAbsolutePosition()local caa=b_a:getAll()
for daa,_ba in pairs(caa)do
if
(aaa+cc[daa].x-1 <=d_a)and
(aaa+
cc[daa].x-1 +_ba.text:len()+1 >=d_a)and(baa+cc[daa].y-1 ==_aa)then b_a:setValue(_ba)
local aba=b_a:sendEvent("mouse_click",b_a,"mouse_click",c_a,d_a,_aa,...)b_a:updateDraw()if(aba==false)then return aba end;return true end end end end,draw=function(b_a)
b_a:addDraw("radio",function()
local c_a,d_a=b_a:getSelectionColor()local _aa=b_a:getAll()
for aaa,baa in pairs(_aa)do
if(baa==b_a:getValue())then
b_a:addBlit(cc[aaa].x,cc[aaa].y,dd,cb[_d],cb[dc])
b_a:addBlit(cc[aaa].x+2,cc[aaa].y,baa.text,cb[d_a]:rep(#baa.text),cb[c_a]:rep(
#baa.text))else
b_a:addBackgroundBox(cc[aaa].x,cc[aaa].y,1,1,ad or colors.black)
b_a:addBlit(cc[aaa].x+2,cc[aaa].y,baa.text,cb[baa.fgCol]:rep(#baa.text),cb[baa.bgCol]:rep(
#baa.text))end end;return true end)end}a_a.__index=a_a;return setmetatable(a_a,ac)end end
ba["objects"]["Progressbar"]=function(...)
return
function(bb,cb)
local db=cb.getObject("ChangeableObject")(bb,cb)local _c="Progressbar"local ac=0;db:setZIndex(5)db:setValue(false)
db:setSize(25,3)local bc=colors.black;local cc=""local dc=colors.white;local _d=""local ad=0
local bd={getType=function(cd)return _c end,setDirection=function(cd,dd)
ad=dd;cd:updateDraw()return cd end,setProgressBar=function(cd,dd,__a,a_a)bc=dd or bc
cc=__a or cc;dc=a_a or dc;cd:updateDraw()return cd end,getProgressBar=function(cd)return
bc,cc,dc end,setBackgroundSymbol=function(cd,dd)_d=dd:sub(1,1)cd:updateDraw()return cd end,setProgress=function(cd,dd)
if(
dd>=0)and(dd<=100)and(ac~=dd)then ac=dd;cd:setValue(ac)if
(ac==100)then cd:progressDoneHandler()end end;cd:updateDraw()return cd end,getProgress=function(cd)return
ac end,onProgressDone=function(cd,dd)cd:registerEvent("progress_done",dd)
return cd end,progressDoneHandler=function(cd)
cd:sendEvent("progress_done",cd)end,draw=function(cd)db.draw(cd)
cd:addDraw("progressbar",function()
local dd,__a=cd:getPosition()local a_a,b_a=cd:getSize()
local c_a,d_a=cd:getBackground(),cd:getForeground()
if(c_a~=false)then cd:addBackgroundBox(dd,__a,a_a,b_a,c_a)end
if(_d~="")then cd:addTextBox(dd,__a,a_a,b_a,_d)end
if(d_a~=false)then cd:addForegroundBox(dd,__a,a_a,b_a,d_a)end
if(ad==1)then
cd:addBackgroundBox(dd,__a,a_a,b_a/100 *ac,bc)cd:addForegroundBox(dd,__a,a_a,b_a/100 *ac,dc)cd:addTextBox(dd,__a,a_a,
b_a/100 *ac,cc)elseif(ad==2)then
cd:addBackgroundBox(dd,__a+math.ceil(
b_a-b_a/100 *ac),a_a,b_a/100 *ac,bc)
cd:addForegroundBox(dd,__a+math.ceil(b_a-b_a/100 *ac),a_a,
b_a/100 *ac,dc)cd:addTextBox(dd,__a+math.ceil(b_a-b_a/100 *ac),a_a,b_a/100 *
ac,cc)elseif(
ad==3)then
cd:addBackgroundBox(dd+math.ceil(a_a-a_a/100 *ac),__a,a_a/
100 *ac,b_a,bc)
cd:addForegroundBox(dd+math.ceil(a_a-a_a/100 *ac),__a,
a_a/100 *ac,b_a,dc)
cd:addTextBox(dd+math.ceil(a_a-a_a/100 *ac),__a,a_a/100 *ac,b_a,cc)else cd:addBackgroundBox(dd,__a,a_a/100 *ac,b_a,bc)cd:addForegroundBox(dd,__a,
a_a/100 *ac,b_a,dc)cd:addTextBox(dd,__a,
a_a/100 *ac,b_a,cc)end end)end}bd.__index=bd;return setmetatable(bd,db)end end
ba["objects"]["Input"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("ChangeableObject")(db,_c)local bc="Input"local cc="text"local dc=0;ac:setZIndex(5)ac:setValue("")
ac:setSize(12,1)local _d=1;local ad=1;local bd=""local cd=colors.black;local dd=colors.white;local __a=bd;local a_a=false
local b_a={load=function(c_a)
c_a:listenEvent("mouse_click")c_a:listenEvent("key")c_a:listenEvent("char")
c_a:listenEvent("other_event")c_a:listenEvent("mouse_drag")end,getType=function(c_a)return
bc end,isType=function(c_a,d_a)return
bc==d_a or ac.isType~=nil and ac.isType(d_a)or false end,setDefaultText=function(c_a,d_a,_aa,aaa)
bd=d_a;dd=_aa or dd;cd=aaa or cd
if(c_a:isFocused())then __a=""else __a=bd end;c_a:updateDraw()return c_a end,getDefaultText=function(c_a)return
bd,dd,cd end,setOffset=function(c_a,d_a)ad=d_a;c_a:updateDraw()return c_a end,getOffset=function(c_a)return
ad end,setTextOffset=function(c_a,d_a)_d=d_a;c_a:updateDraw()return c_a end,getTextOffset=function(c_a)return
_d end,setInputType=function(c_a,d_a)cc=d_a;c_a:updateDraw()return c_a end,getInputType=function(c_a)return
cc end,setValue=function(c_a,d_a)ac.setValue(c_a,tostring(d_a))
if not(a_a)then _d=
tostring(d_a):len()+1
ad=math.max(1,_d-c_a:getWidth()+1)
if(c_a:isFocused())then local _aa=c_a:getParent()
local aaa,baa=c_a:getPosition()
_aa:setCursor(true,aaa+_d-ad,baa+math.floor(c_a:getHeight()/2),c_a:getForeground())end end;c_a:updateDraw()return c_a end,getValue=function(c_a)
local d_a=ac.getValue(c_a)
return cc=="number"and tonumber(d_a)or d_a end,setInputLimit=function(c_a,d_a)
dc=tonumber(d_a)or dc;c_a:updateDraw()return c_a end,getInputLimit=function(c_a)return dc end,getFocusHandler=function(c_a)
ac.getFocusHandler(c_a)local d_a=c_a:getParent()
if(d_a~=nil)then local _aa,aaa=c_a:getPosition()__a=""if(
bd~="")then c_a:updateDraw()end
d_a:setCursor(true,_aa+_d-ad,aaa+math.max(math.ceil(
c_a:getHeight()/2 -1,1)),c_a:getForeground())end end,loseFocusHandler=function(c_a)
ac.loseFocusHandler(c_a)local d_a=c_a:getParent()__a=bd
if(bd~="")then c_a:updateDraw()end;d_a:setCursor(false)end,keyHandler=function(c_a,d_a)
if
(ac.keyHandler(c_a,d_a))then local _aa,aaa=c_a:getSize()local baa=c_a:getParent()a_a=true
if
(d_a==keys.backspace)then local aba=tostring(ac.getValue())
if(_d>1)then c_a:setValue(aba:sub(1,_d-2)..
aba:sub(_d,aba:len()))_d=math.max(
_d-1,1)if(_d<ad)then ad=math.max(ad-1,1)end end end
if(d_a==keys.enter)then baa:removeFocusedObject(c_a)end
if(d_a==keys.right)then
local aba=tostring(ac.getValue()):len()_d=_d+1;if(_d>aba)then _d=aba+1 end;_d=math.max(_d,1)if(_d<ad)or
(_d>=_aa+ad)then ad=_d-_aa+1 end;ad=math.max(ad,1)end;if(d_a==keys.left)then _d=_d-1;if(_d>=1)then
if(_d<ad)or(_d>=_aa+ad)then ad=_d end end;_d=math.max(_d,1)
ad=math.max(ad,1)end
local caa,daa=c_a:getPosition()local _ba=tostring(ac.getValue())c_a:updateDraw()
a_a=false;return true end end,charHandler=function(c_a,d_a)
if
(ac.charHandler(c_a,d_a))then a_a=true;local _aa,aaa=c_a:getSize()local baa=ac.getValue()
if(
baa:len()<dc or dc<=0)then
if(cc=="number")then local aba=baa
if
(_d==1 and d_a=="-")or(d_a==".")or(tonumber(d_a)~=nil)then
c_a:setValue(baa:sub(1,_d-1)..
d_a..baa:sub(_d,baa:len()))_d=_d+1;if(d_a==".")or(d_a=="-")and(#baa>0)then
if(
tonumber(ac.getValue())==nil)then c_a:setValue(aba)_d=_d-1 end end end else
c_a:setValue(baa:sub(1,_d-1)..d_a..baa:sub(_d,baa:len()))_d=_d+1 end;if(_d>=_aa+ad)then ad=ad+1 end end;local caa,daa=c_a:getPosition()
local _ba=tostring(ac.getValue())a_a=false;c_a:updateDraw()return true end end,mouseHandler=function(c_a,d_a,_aa,aaa)
if
(ac.mouseHandler(c_a,d_a,_aa,aaa))then local baa=c_a:getParent()local caa,daa=c_a:getPosition()
local _ba,aba=c_a:getAbsolutePosition(caa,daa)local bba,cba=c_a:getSize()_d=_aa-_ba+ad;local dba=ac.getValue()if(_d>
dba:len())then _d=dba:len()+1 end;if(_d<ad)then ad=_d-1
if(ad<1)then ad=1 end end
baa:setCursor(true,caa+_d-ad,daa+
math.max(math.ceil(cba/2 -1,1)),c_a:getForeground())return true end end,dragHandler=function(c_a,d_a,_aa,aaa,baa,caa)
if
(c_a:isFocused())then if(c_a:isCoordsInObject(_aa,aaa))then
if(ac.dragHandler(c_a,d_a,_aa,aaa,baa,caa))then return true end end
local daa=c_a:getParent()daa:removeFocusedObject()end end,draw=function(c_a)
ac.draw(c_a)
c_a:addDraw("input",function()local d_a=c_a:getParent()local _aa,aaa=c_a:getPosition()
local baa,caa=c_a:getSize()local daa=bb.getTextVerticalAlign(caa,textVerticalAlign)
local _ba=tostring(ac.getValue())local aba=c_a:getBackground()local bba=c_a:getForeground()local cba;if(
_ba:len()<=0)then cba=__a;aba=cd or aba;bba=dd or bba end
cba=__a;if(_ba~="")then cba=_ba end;cba=cba:sub(ad,baa+ad-1)local dba=baa-
cba:len()if(dba<0)then dba=0 end
if
(cc=="password")and(_ba~="")then cba=string.rep("*",cba:len())end;cba=cba..string.rep(" ",dba)
c_a:addBlit(1,daa,cba,cb[bba]:rep(cba:len()),cb[aba]:rep(cba:len()))if(c_a:isFocused())then
d_a:setCursor(true,_aa+_d-ad,aaa+
math.floor(c_a:getHeight()/2),c_a:getForeground())end end)end}b_a.__index=b_a;return setmetatable(b_a,ac)end end
ba["objects"]["List"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("ChangeableObject")(db,_c)local bc="List"local cc={}local dc=colors.black;local _d=colors.lightGray;local ad=true
local bd="left"local cd=0;local dd=true;ac:setSize(16,8)ac:setZIndex(5)
local __a={init=function(a_a)
local b_a=a_a:getParent()a_a:listenEvent("mouse_click")
a_a:listenEvent("mouse_drag")a_a:listenEvent("mouse_scroll")return ac.init(a_a)end,getBase=function(a_a)return
ac end,setTextAlign=function(a_a,b_a)bd=b_a;return a_a end,getTextAlign=function(a_a)return bd end,getBase=function(a_a)return ac end,getType=function(a_a)return
bc end,isType=function(a_a,b_a)return
bc==b_a or ac.isType~=nil and ac.isType(b_a)or false end,addItem=function(a_a,b_a,c_a,d_a,...)
table.insert(cc,{text=b_a,bgCol=
c_a or a_a:getBackground(),fgCol=d_a or a_a:getForeground(),args={...}})if(#cc<=1)then a_a:setValue(cc[1],false)end
a_a:updateDraw()return a_a end,setOffset=function(a_a,b_a)
cd=b_a;a_a:updateDraw()return a_a end,getOffset=function(a_a)return cd end,removeItem=function(a_a,b_a)
table.remove(cc,b_a)a_a:updateDraw()return a_a end,getItem=function(a_a,b_a)
return cc[b_a]end,getAll=function(a_a)return cc end,getItemIndex=function(a_a)local b_a=a_a:getValue()for c_a,d_a in pairs(cc)do if
(d_a==b_a)then return c_a end end end,clear=function(a_a)
cc={}a_a:setValue({},false)a_a:updateDraw()return a_a end,getItemCount=function(a_a)return
#cc end,editItem=function(a_a,b_a,c_a,d_a,_aa,...)table.remove(cc,b_a)
table.insert(cc,b_a,{text=c_a,bgCol=d_a or
a_a:getBackground(),fgCol=_aa or a_a:getForeground(),args={...}})a_a:updateDraw()return a_a end,selectItem=function(a_a,b_a)a_a:setValue(
cc[b_a]or{},false)a_a:updateDraw()return a_a end,setSelectionColor=function(a_a,b_a,c_a,d_a)dc=
b_a or a_a:getBackground()
_d=c_a or a_a:getForeground()ad=d_a~=nil and d_a or true;a_a:updateDraw()
return a_a end,getSelectionColor=function(a_a)
return dc,_d end,isSelectionColorActive=function(a_a)return ad end,setScrollable=function(a_a,b_a)dd=b_a;if(b_a==nil)then dd=true end
a_a:updateDraw()return a_a end,scrollHandler=function(a_a,b_a,c_a,d_a)
if
(ac.scrollHandler(a_a,b_a,c_a,d_a))then
if(dd)then local _aa,aaa=a_a:getSize()cd=cd+b_a;if(cd<0)then cd=0 end
if(b_a>=1)then if(#cc>aaa)then if(cd>
#cc-aaa)then cd=#cc-aaa end;if(cd>=#cc)then cd=#cc-1 end else cd=
cd-1 end end;a_a:updateDraw()end;return true end;return false end,mouseHandler=function(a_a,b_a,c_a,d_a)
if
(ac.mouseHandler(a_a,b_a,c_a,d_a))then local _aa,aaa=a_a:getAbsolutePosition()local baa,caa=a_a:getSize()
if
(#cc>0)then
for n=1,caa do if(cc[n+cd]~=nil)then
if
(_aa<=c_a)and(_aa+baa>c_a)and(aaa+n-1 ==d_a)then a_a:setValue(cc[n+cd])a_a:updateDraw()end end end end;return true end;return false end,dragHandler=function(a_a,b_a,c_a,d_a)return
a_a:mouseHandler(b_a,c_a,d_a)end,touchHandler=function(a_a,b_a,c_a)return
a_a:mouseHandler(1,b_a,c_a)end,draw=function(a_a)ac.draw(a_a)
a_a:addDraw("list",function()
local b_a=a_a:getParent()local c_a,d_a=a_a:getPosition()local _aa,aaa=a_a:getSize()
for n=1,aaa do
if cc[n+cd]then
local baa=cc[n+cd].text;local caa,daa=cc[n+cd].fgCol,cc[n+cd].bgCol;if cc[n+cd]==
a_a:getValue()and ad then caa,daa=_d,dc end
a_a:addBlit(1,n,baa,cb[caa]:rep(
#baa),cb[daa]:rep(#baa))end end end)end}__a.__index=__a;return setmetatable(__a,ac)end end
ba["objects"]["Dropdown"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("List")(db,_c)local bc="Dropdown"ac:setSize(12,1)ac:setZIndex(6)
local cc=colors.black;local dc=colors.lightGray;local _d=true;local ad="left"local bd=0;local cd=16;local dd=6;local __a="\16"
local a_a="\31"local b_a=false
local c_a={getType=function(d_a)return bc end,isType=function(d_a,_aa)
return bc==_aa or
ac.isType~=nil and ac.isType(_aa)or false end,load=function(d_a)
d_a:listenEvent("mouse_click",d_a)d_a:listenEvent("mouse_up",d_a)
d_a:listenEvent("mouse_scroll",d_a)d_a:listenEvent("mouse_drag",d_a)end,setOffset=function(d_a,_aa)
bd=_aa;d_a:updateDraw()return d_a end,getOffset=function(d_a)return bd end,setDropdownSize=function(d_a,_aa,aaa)
cd,dd=_aa,aaa;d_a:updateDraw()return d_a end,getDropdownSize=function(d_a)return cd,dd end,mouseHandler=function(d_a,_aa,aaa,baa)
if
(b_a)then local daa,_ba=d_a:getAbsolutePosition()
if(_aa==1)then local aba=d_a:getAll()
if(#
aba>0)then
for n=1,dd do
if(aba[n+bd]~=nil)then
if
(daa<=aaa)and(daa+cd>aaa)and(_ba+n==baa)then d_a:setValue(aba[n+bd])d_a:updateDraw()
local bba=d_a:sendEvent("mouse_click",d_a,"mouse_click",dir,aaa,baa)if(bba==false)then return bba end;return true end end end end end end;local caa=ac:getBase()
if(caa.mouseHandler(d_a,_aa,aaa,baa))then b_a=true
d_a:updateDraw()return true else if(b_a)then d_a:updateDraw()b_a=false end;return false end end,mouseUpHandler=function(d_a,_aa,aaa,baa)
if
(b_a)then local caa,daa=d_a:getAbsolutePosition()
if(_aa==1)then local _ba=d_a:getAll()
if(#
_ba>0)then
for n=1,dd do
if(_ba[n+bd]~=nil)then
if
(caa<=aaa)and(caa+cd>aaa)and(daa+n==baa)then b_a=false;d_a:updateDraw()
local aba=d_a:sendEvent("mouse_up",d_a,"mouse_up",dir,aaa,baa)if(aba==false)then return aba end;return true end end end end end end end,scrollHandler=function(d_a,_aa,aaa,baa)
if
(b_a)and(d_a:isFocused())then local caa=d_a:getAll()bd=bd+_aa
if(bd<0)then bd=0 end
if(_aa==1)then if(#caa>dd)then if(bd>#caa-dd)then bd=#caa-dd end else
bd=math.min(#caa-1,0)end end
local daa=d_a:sendEvent("mouse_scroll",d_a,"mouse_scroll",_aa,aaa,baa)if(daa==false)then return daa end;d_a:updateDraw()return true end end,draw=function(d_a)
ac.draw(d_a)d_a:setDrawState("list",false)
d_a:addDraw("dropdown",function()
local _aa,aaa=d_a:getPosition()local baa,caa=d_a:getSize()local daa=d_a:getValue()
local _ba=d_a:getAll()local aba,bba=d_a:getBackground(),d_a:getForeground()
local cba=bb.getTextHorizontalAlign((
daa~=nil and daa.text or""),baa,ad):sub(1,
baa-1).. (b_a and a_a or __a)
d_a:addBlit(1,1,cba,cb[bba]:rep(#cba),cb[aba]:rep(#cba))
if(b_a)then d_a:addTextBox(1,2,cd,dd," ")
d_a:addBackgroundBox(1,2,cd,dd,aba)d_a:addForegroundBox(1,2,cd,dd,bba)
for n=1,dd do
if(_ba[n+bd]~=nil)then local dba=bb.getTextHorizontalAlign(_ba[
n+bd].text,cd,ad)
if(
_ba[n+bd]==daa)then
if(_d)then
d_a:addBlit(1,n+1,dba,cb[dc]:rep(#dba),cb[cc]:rep(#dba))else
d_a:addBlit(1,n+1,dba,cb[_ba[n+bd].fgCol]:rep(#dba),cb[_ba[n+bd].bgCol]:rep(
#dba))end else
d_a:addBlit(1,n+1,dba,cb[_ba[n+bd].fgCol]:rep(#dba),cb[_ba[n+bd].bgCol]:rep(
#dba))end end end end end)end}c_a.__index=c_a;return setmetatable(c_a,ac)end end
ba["objects"]["Checkbox"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("ChangeableObject")(db,_c)local bc="Checkbox"ac:setZIndex(5)ac:setValue(false)
ac:setSize(1,1)local cc,dc,_d,ad="\42"," ","","right"
local bd={load=function(cd)cd:listenEvent("mouse_click",cd)
cd:listenEvent("mouse_up",cd)end,getType=function(cd)return bc end,isType=function(cd,dd)return
bc==dd or
ac.isType~=nil and ac.isType(dd)or false end,setSymbol=function(cd,dd,__a)
cc=dd or cc;dc=__a or dc;cd:updateDraw()return cd end,getSymbol=function(cd)return
cc,dc end,setText=function(cd,dd)_d=dd;return cd end,setTextPosition=function(cd,dd)ad=dd or ad;return cd end,setChecked=ac.setValue,mouseHandler=function(cd,dd,__a,a_a)
if
(ac.mouseHandler(cd,dd,__a,a_a))then
if(dd==1)then if
(cd:getValue()~=true)and(cd:getValue()~=false)then cd:setValue(false)else
cd:setValue(not cd:getValue())end
cd:updateDraw()return true end end;return false end,draw=function(cd)
ac.draw(cd)
cd:addDraw("checkbox",function()local dd,__a=cd:getPosition()local a_a,b_a=cd:getSize()
local c_a=bb.getTextVerticalAlign(b_a,"center")local d_a,_aa=cd:getBackground(),cd:getForeground()
if
(cd:getValue())then
cd:addBlit(1,c_a,bb.getTextHorizontalAlign(cc,a_a,"center"),cb[d_a],cb[_aa])else
cd:addBlit(1,c_a,bb.getTextHorizontalAlign(dc,a_a,"center"),cb[d_a],cb[_aa])end;if(_d~="")then local aaa=ad=="left"and-_d:len()or 3
cd:addText(aaa,c_a,_d)end end)end}bd.__index=bd;return setmetatable(bd,ac)end end
ba["objects"]["Menubar"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("List")(db,_c)local bc="Menubar"local cc={}ac:setSize(30,1)ac:setZIndex(5)local dc=0
local _d,ad=1,1;local bd=true
local function cd()local dd=0;local __a=ac:getWidth()local a_a=ac:getAll()for n=1,#a_a do dd=dd+
a_a[n].text:len()+_d*2 end;return
math.max(dd-__a,0)end
cc={init=function(dd)local __a=dd:getParent()dd:listenEvent("mouse_click")
dd:listenEvent("mouse_drag")dd:listenEvent("mouse_scroll")return ac.init(dd)end,getType=function(dd)return
bc end,getBase=function(dd)return ac end,setSpace=function(dd,__a)_d=__a or _d;dd:updateDraw()
return dd end,setScrollable=function(dd,__a)bd=__a;if(__a==nil)then bd=true end;return dd end,mouseHandler=function(dd,__a,a_a,b_a)
if
(ac:getBase().mouseHandler(dd,__a,a_a,b_a))then local c_a,d_a=dd:getAbsolutePosition()local _aa,aaa=dd:getSize()local baa=0
local caa=dd:getAll()
for n=1,#caa do
if(caa[n]~=nil)then
if
(c_a+baa<=a_a+dc)and(
c_a+baa+caa[n].text:len()+ (_d*2)>a_a+dc)and(d_a==b_a)then
dd:setValue(caa[n])dd:sendEvent(event,dd,event,0,a_a,b_a,caa[n])end;baa=baa+caa[n].text:len()+_d*2 end end;dd:updateDraw()return true end end,scrollHandler=function(dd,__a,a_a,b_a)
if
(ac:getBase().scrollHandler(dd,__a,a_a,b_a))then if(bd)then dc=dc+__a;if(dc<0)then dc=0 end;local c_a=cd()if(dc>c_a)then dc=c_a end
dd:updateDraw()end;return true end;return false end,draw=function(dd)
ac.draw(dd)
dd:addDraw("list",function()local __a=dd:getParent()local a_a,b_a=dd:getPosition()
local c_a,d_a=dd:getSize()local _aa=""local aaa=""local baa=""local caa,daa=dd:getSelectionColor()
for _ba,aba in
pairs(dd:getAll())do
local bba=(" "):rep(_d)..aba.text.. (" "):rep(_d)_aa=_aa..bba
if(aba==dd:getValue())then aaa=aaa..
cb[caa or aba.bgCol or
dd:getBackground()]:rep(bba:len())baa=baa..
cb[daa or
aba.FgCol or dd:getForeground()]:rep(bba:len())else aaa=aaa..
cb[aba.bgCol or
dd:getBackground()]:rep(bba:len())baa=baa..
cb[aba.FgCol or
dd:getForeground()]:rep(bba:len())end end
dd:addBlit(1,1,_aa:sub(dc+1,c_a+dc),baa:sub(dc+1,c_a+dc),aaa:sub(dc+1,c_a+dc))end)end}cc.__index=cc;return setmetatable(cc,ac)end end
ba["objects"]["Image"]=function(...)local bb=_b("images")local cb=_b("bimg")
local db,_c,ac,bc=table.unpack,string.sub,math.max,math.min
return
function(cc,dc)local _d=dc.getObject("VisualObject")(cc,dc)
local ad="Image"local bd=cb()local cd=bd.getFrameObject(1)local dd;local __a;local a_a=1;local b_a=false;local c_a
local d_a=false;local _aa,aaa=0,0;_d:setSize(24,8)_d:setZIndex(2)
local function baa(daa)local _ba={}
for cba,dba in pairs(colors)do if(
type(dba)=="number")then
_ba[cba]={term.nativePaletteColor(dba)}end end;local aba=bd.getMetadata("palette")if(aba~=nil)then for cba,dba in pairs(aba)do
_ba[cba]=tonumber(dba)end end
local bba=bd.getFrameData("palette")dc.log(bba)if(bba~=nil)then
for cba,dba in pairs(bba)do _ba[cba]=tonumber(dba)end end;return _ba end
local caa={getType=function(daa)return ad end,isType=function(daa,_ba)return
ad==_ba or _d.isType~=nil and _d.isType(_ba)or false end,setOffset=function(daa,_ba,aba,bba)if
(bba)then _aa=_aa+_ba or 0;aaa=aaa+aba or 0 else _aa=_ba or _aa
aaa=aba or aaa end;daa:updateDraw()return daa end,getOffset=function(daa)return
_aa,aaa end,selectFrame=function(daa,_ba)if(bd.getFrameObject(_ba)==nil)then
bd.addFrame(_ba)end;cd=bd.getFrameObject(_ba)
__a=cd.getImage(_ba)selectedFrame=_ba;daa:updateDraw()end,addFrame=function(daa,_ba)
bd.addFrame(_ba)return daa end,getFrame=function(daa,_ba)return bd.getFrame(_ba)end,getFrameObject=function(daa,_ba)return
bd.getFrameObject(_ba)end,removeFrame=function(daa,_ba)bd.removeFrame(_ba)return daa end,moveFrame=function(daa,_ba,aba)
bd.moveFrame(_ba,aba)return daa end,getFrames=function(daa)return bd.getFrames()end,getFrameCount=function(daa)return
#bd.getFrames()end,getActiveFrame=function(daa)return a_a end,loadImage=function(daa,_ba)
if
(fs.exists(_ba))then local aba=bb.loadBIMG(_ba)bd=cb(aba)selectedFrame=1
cd=bd.getFrameObject(1)dd=bd.createBimg()__a=cd.getImage()daa:updateDraw()end;return daa end,setImage=function(daa,_ba)
if(
type(_ba)=="table")then bd=cb(_ba)selectedFrame=1;cd=bd.getFrameObject(1)
dd=bd.createBimg()__a=cd.getImage()daa:updateDraw()end;return daa end,clear=function(daa)
bd=cb()cd=bd.getFrameObject(1)__a=nil;daa:updateDraw()return daa end,getImage=function(daa)return
bd.createBimg()end,getImageFrame=function(daa,_ba)return cd.getImage(_ba)end,usePalette=function(daa,_ba)d_a=
_ba~=nil and _ba or true;return daa end,play=function(daa,_ba)
if
(bd.getMetadata("animated"))then
local aba=
bd.getMetadata("duration")or bd.getMetadata("secondsPerFrame")or 0.2;daa:listenEvent("other_event")
c_a=os.startTimer(aba)b_a=_ba or false end;return daa end,stop=function(daa)
os.cancelTimer(c_a)c_a=nil;b_a=false;return daa end,eventHandler=function(daa,_ba,aba,...)
_d.eventHandler(daa,_ba,aba,...)
if(_ba=="timer")then
if(aba==c_a)then
if(bd.getFrame(a_a+1)~=nil)then a_a=a_a+1
daa:selectFrame(a_a)
local bba=
bd.getFrameData(a_a,"duration")or bd.getMetadata("secondsPerFrame")or 0.2;c_a=os.startTimer(bba)else
if(b_a)then a_a=1;daa:selectFrame(a_a)
local bba=
bd.getFrameData(a_a,"duration")or bd.getMetadata("secondsPerFrame")or 0.2;c_a=os.startTimer(bba)end end;daa:updateDraw()end end end,setMetadata=function(daa,_ba,aba)
bd.setMetadata(_ba,aba)return daa end,getMetadata=function(daa,_ba)return bd.getMetadata(_ba)end,getFrameMetadata=function(daa,_ba,aba)return
bd.getFrameData(_ba,aba)end,setFrameMetadata=function(daa,_ba,aba,bba)
bd.setFrameData(_ba,aba,bba)return daa end,blit=function(daa,_ba,aba,bba,cba,dba)x=cba or x;y=dba or y
cd.blit(_ba,aba,bba,x,y)__a=cd.getImage()daa:updateDraw()return daa end,setText=function(daa,_ba,aba,bba)x=
aba or x;y=bba or y;cd.text(_ba,x,y)__a=cd.getImage()
daa:updateDraw()return daa end,setBg=function(daa,_ba,aba,bba)x=aba or x;y=
bba or y;cd.bg(_ba,x,y)__a=cd.getImage()
daa:updateDraw()return daa end,setFg=function(daa,_ba,aba,bba)x=aba or x;y=bba or
y;cd.fg(_ba,x,y)__a=cd.getImage()
daa:updateDraw()return daa end,getImageSize=function(daa)
return bd.getSize()end,setImageSize=function(daa,_ba,aba)bd.setSize(_ba,aba)__a=cd.getImage()
daa:updateDraw()return daa end,resizeImage=function(daa,_ba,aba)
local bba=bb.resizeBIMG(dd,_ba,aba)bd=cb(bba)selectedFrame=1;cd=bd.getFrameObject(1)
__a=cd.getImage()daa:updateDraw()return daa end,draw=function(daa)
_d.draw(daa)
daa:addDraw("image",function()local _ba,aba=daa:getSize()local bba,cba=daa:getPosition()
local dba,_ca=daa:getParent():getSize()local aca,bca=daa:getParent():getOffset()
if
(bba-aca>dba)or(cba-bca>_ca)or(bba-aca+_ba<1)or(cba-
bca+aba<1)then return end
if(d_a)then daa:getParent():setPalette(baa(a_a))end
if(__a~=nil)then
for cca,dca in pairs(__a)do
if(cca+aaa<=aba)and(cca+aaa>=1)then
local _da,ada,bda=dca[1],dca[2],dca[3]local cda=ac(1 -_aa,1)local dda=bc(_ba-_aa,#_da)
_da=_c(_da,cda,dda)ada=_c(ada,cda,dda)bda=_c(bda,cda,dda)
daa:addBlit(ac(1 +_aa,1),cca+aaa,_da,ada,bda)end end end end)end}caa.__index=caa;return setmetatable(caa,_d)end end
ba["objects"]["Program"]=function(...)local bb=_b("tHex")local cb=_b("process")
local db=string.sub
return
function(_c,ac)local bc=ac.getObject("VisualObject")(_c,ac)
local cc="Program"local dc;local _d;local ad={}
local function bd(aaa,baa,caa,daa)local _ba,aba=1,1;local bba,cba=colors.black,colors.white;local dba=false
local _ca=false;local aca={}local bca={}local cca={}local dca={}local _da;local ada={}for i=0,15 do local dab=2 ^i
dca[dab]={ac.getTerm().getPaletteColour(dab)}end;local function bda()_da=(" "):rep(caa)
for n=0,15 do
local dab=2 ^n;local _bb=bb[dab]ada[dab]=_bb:rep(caa)end end
local function cda()bda()local dab=_da
local _bb=ada[colors.white]local abb=ada[colors.black]
for n=1,daa do
aca[n]=db(aca[n]==nil and dab or aca[n]..dab:sub(1,
caa-aca[n]:len()),1,caa)
cca[n]=db(cca[n]==nil and _bb or cca[n]..
_bb:sub(1,caa-cca[n]:len()),1,caa)
bca[n]=db(bca[n]==nil and abb or bca[n]..
abb:sub(1,caa-bca[n]:len()),1,caa)end;bc.updateDraw(bc)end;cda()local function dda()if
_ba>=1 and aba>=1 and _ba<=caa and aba<=daa then else end end
local function __b(dab,_bb,abb)if

aba<1 or aba>daa or _ba<1 or _ba+#dab-1 >caa then return end
aca[aba]=db(aca[aba],1,_ba-1)..dab..db(aca[aba],
_ba+#dab,caa)cca[aba]=db(cca[aba],1,_ba-1)..
_bb..db(cca[aba],_ba+#dab,caa)
bca[aba]=
db(bca[aba],1,_ba-1)..abb..db(bca[aba],_ba+#dab,caa)_ba=_ba+#dab;if _ca then dda()end;dc:updateDraw()end
local function a_b(dab,_bb,abb)
if(abb~=nil)then local bbb=aca[_bb]if(bbb~=nil)then
aca[_bb]=db(bbb:sub(1,dab-1)..abb..bbb:sub(dab+
(abb:len()),caa),1,caa)end end;dc:updateDraw()end
local function b_b(dab,_bb,abb)
if(abb~=nil)then local bbb=bca[_bb]if(bbb~=nil)then
bca[_bb]=db(bbb:sub(1,dab-1)..abb..bbb:sub(dab+
(abb:len()),caa),1,caa)end end;dc:updateDraw()end
local function c_b(dab,_bb,abb)
if(abb~=nil)then local bbb=cca[_bb]if(bbb~=nil)then
cca[_bb]=db(bbb:sub(1,dab-1)..abb..bbb:sub(dab+
(abb:len()),caa),1,caa)end end;dc:updateDraw()end
local d_b=function(dab)
if type(dab)~="number"then
error("bad argument #1 (expected number, got "..type(dab)..")",2)elseif bb[dab]==nil then
error("Invalid color (got "..dab..")",2)end;cba=dab end
local _ab=function(dab)
if type(dab)~="number"then
error("bad argument #1 (expected number, got "..type(dab)..")",2)elseif bb[dab]==nil then
error("Invalid color (got "..dab..")",2)end;bba=dab end
local aab=function(dab,_bb,abb,bbb)if type(dab)~="number"then
error("bad argument #1 (expected number, got "..type(dab)..")",2)end
if bb[dab]==nil then error("Invalid color (got "..
dab..")",2)end;local cbb
if
type(_bb)=="number"and abb==nil and bbb==nil then cbb={colours.rgb8(_bb)}dca[dab]=cbb else if
type(_bb)~="number"then
error("bad argument #2 (expected number, got "..type(_bb)..")",2)end;if type(abb)~="number"then
error(
"bad argument #3 (expected number, got "..type(abb)..")",2)end;if type(bbb)~="number"then
error(
"bad argument #4 (expected number, got "..type(bbb)..")",2)end;cbb=dca[dab]cbb[1]=_bb
cbb[2]=abb;cbb[3]=bbb end end
local bab=function(dab)if type(dab)~="number"then
error("bad argument #1 (expected number, got "..type(dab)..")",2)end
if bb[dab]==nil then error("Invalid color (got "..
dab..")",2)end;local _bb=dca[dab]return _bb[1],_bb[2],_bb[3]end
local cab={setCursorPos=function(dab,_bb)if type(dab)~="number"then
error("bad argument #1 (expected number, got "..type(dab)..")",2)end;if type(_bb)~="number"then
error(
"bad argument #2 (expected number, got "..type(_bb)..")",2)end;_ba=math.floor(dab)
aba=math.floor(_bb)if(_ca)then dda()end end,getCursorPos=function()return
_ba,aba end,setCursorBlink=function(dab)if type(dab)~="boolean"then
error("bad argument #1 (expected boolean, got "..
type(dab)..")",2)end;dba=dab end,getCursorBlink=function()return
dba end,getPaletteColor=bab,getPaletteColour=bab,setBackgroundColor=_ab,setBackgroundColour=_ab,setTextColor=d_b,setTextColour=d_b,setPaletteColor=aab,setPaletteColour=aab,getBackgroundColor=function()return bba end,getBackgroundColour=function()return bba end,getSize=function()
return caa,daa end,getTextColor=function()return cba end,getTextColour=function()return cba end,basalt_resize=function(dab,_bb)caa,daa=dab,_bb;cda()end,basalt_reposition=function(dab,_bb)
aaa,baa=dab,_bb end,basalt_setVisible=function(dab)_ca=dab end,drawBackgroundBox=function(dab,_bb,abb,bbb,cbb)for n=1,bbb do
b_b(dab,_bb+ (n-1),bb[cbb]:rep(abb))end end,drawForegroundBox=function(dab,_bb,abb,bbb,cbb)
for n=1,bbb do c_b(dab,
_bb+ (n-1),bb[cbb]:rep(abb))end end,drawTextBox=function(dab,_bb,abb,bbb,cbb)for n=1,bbb do
a_b(dab,_bb+ (n-1),cbb:rep(abb))end end,basalt_update=function()for n=1,daa do
dc:addBlit(1,n,aca[n],cca[n],bca[n])end end,scroll=function(dab)
assert(type(dab)==
"number","bad argument #1 (expected number, got "..type(dab)..")")
if dab~=0 then
for newY=1,daa do local _bb=newY+dab;if _bb<1 or _bb>daa then aca[newY]=_da
cca[newY]=ada[cba]bca[newY]=ada[bba]else aca[newY]=aca[_bb]bca[newY]=bca[_bb]
cca[newY]=cca[_bb]end end end;if(_ca)then dda()end end,isColor=function()return
ac.getTerm().isColor()end,isColour=function()
return ac.getTerm().isColor()end,write=function(dab)dab=tostring(dab)if(_ca)then
__b(dab,bb[cba]:rep(dab:len()),bb[bba]:rep(dab:len()))end end,clearLine=function()
if
(_ca)then a_b(1,aba,(" "):rep(caa))
b_b(1,aba,bb[bba]:rep(caa))c_b(1,aba,bb[cba]:rep(caa))end;if(_ca)then dda()end end,clear=function()
for n=1,daa
do a_b(1,n,(" "):rep(caa))
b_b(1,n,bb[bba]:rep(caa))c_b(1,n,bb[cba]:rep(caa))end;if(_ca)then dda()end end,blit=function(dab,_bb,abb)if
type(dab)~="string"then
error("bad argument #1 (expected string, got "..type(dab)..")",2)end;if type(_bb)~="string"then
error(
"bad argument #2 (expected string, got "..type(_bb)..")",2)end;if type(abb)~="string"then
error(
"bad argument #3 (expected string, got "..type(abb)..")",2)end
if
#_bb~=#dab or#abb~=#dab then error("Arguments must be the same length",2)end;if(_ca)then __b(dab,_bb,abb)end end}return cab end;bc:setZIndex(5)bc:setSize(30,12)local cd=bd(1,1,30,12)local dd
local __a=false;local a_a={}
local function b_a(aaa)local baa=aaa:getParent()local caa,daa=cd.getCursorPos()
local _ba,aba=aaa:getPosition()local bba,cba=aaa:getSize()
if(_ba+caa-1 >=1 and
_ba+caa-1 <=_ba+bba-1 and daa+aba-1 >=1 and
daa+aba-1 <=aba+cba-1)then
baa:setCursor(
aaa:isFocused()and cd.getCursorBlink(),_ba+caa-1,daa+aba-1,cd.getTextColor())end end
local function c_a(aaa,baa,...)local caa,daa=dd:resume(baa,...)
if(caa==false)and(daa~=nil)and
(daa~="Terminated")then
local _ba=aaa:sendEvent("program_error",daa)
if(_ba~=false)then error("Basalt Program - "..daa)end end
if(dd:getStatus()=="dead")then aaa:sendEvent("program_done")end end
local function d_a(aaa,baa,caa,daa,_ba)if(dd==nil)then return false end
if not(dd:isDead())then if not(__a)then
local aba,bba=aaa:getAbsolutePosition()c_a(aaa,baa,caa,daa-aba+1,_ba-bba+1)
b_a(aaa)end end end
local function _aa(aaa,baa,caa,daa)if(dd==nil)then return false end
if not(dd:isDead())then if not(__a)then if(aaa.draw)then
c_a(aaa,baa,caa,daa)b_a(aaa)end end end end
dc={getType=function(aaa)return cc end,show=function(aaa)bc.show(aaa)
cd.setBackgroundColor(aaa:getBackground())cd.setTextColor(aaa:getForeground())
cd.basalt_setVisible(true)return aaa end,hide=function(aaa)
bc.hide(aaa)cd.basalt_setVisible(false)return aaa end,setPosition=function(aaa,baa,caa,daa)
bc.setPosition(aaa,baa,caa,daa)cd.basalt_reposition(aaa:getPosition())return aaa end,getBasaltWindow=function()return
cd end,getBasaltProcess=function()return dd end,setSize=function(aaa,baa,caa,daa)bc.setSize(aaa,baa,caa,daa)
cd.basalt_resize(aaa:getWidth(),aaa:getHeight())return aaa end,getStatus=function(aaa)if(dd~=nil)then return
dd:getStatus()end;return"inactive"end,setEnviroment=function(aaa,baa)ad=
baa or{}return aaa end,execute=function(aaa,baa,...)_d=baa or _d
dd=cb:new(_d,cd,ad,...)cd.setBackgroundColor(colors.black)
cd.setTextColor(colors.white)cd.clear()cd.setCursorPos(1,1)
cd.setBackgroundColor(aaa:getBackground())
cd.setTextColor(aaa:getForeground()or colors.white)cd.basalt_setVisible(true)c_a(aaa)__a=false
aaa:listenEvent("mouse_click",aaa)aaa:listenEvent("mouse_up",aaa)
aaa:listenEvent("mouse_drag",aaa)aaa:listenEvent("mouse_scroll",aaa)
aaa:listenEvent("key",aaa)aaa:listenEvent("key_up",aaa)
aaa:listenEvent("char",aaa)aaa:listenEvent("other_event",aaa)return aaa end,stop=function(aaa)
local baa=aaa:getParent()
if(dd~=nil)then if not(dd:isDead())then c_a(aaa,"terminate")if(dd:isDead())then
baa:setCursor(false)end end end;baa:removeEvents(aaa)return aaa end,pause=function(aaa,baa)__a=
baa or(not __a)
if(dd~=nil)then if not(dd:isDead())then if not(__a)then
aaa:injectEvents(a_a)a_a={}end end end;return aaa end,isPaused=function(aaa)return
__a end,injectEvent=function(aaa,baa,caa,...)
if(dd~=nil)then if not(dd:isDead())then
if(__a==false)or(caa)then
c_a(aaa,baa,...)else table.insert(a_a,{event=baa,args={...}})end end end;return aaa end,getQueuedEvents=function(aaa)return
a_a end,updateQueuedEvents=function(aaa,baa)a_a=baa or a_a;return aaa end,injectEvents=function(aaa,...)if(dd~=nil)then
if not
(dd:isDead())then for baa,caa in pairs({...})do
c_a(aaa,caa.event,table.unpack(caa.args))end end end;return aaa end,mouseHandler=function(aaa,baa,caa,daa)
if
(bc.mouseHandler(aaa,baa,caa,daa))then d_a(aaa,"mouse_click",baa,caa,daa)return true end;return false end,mouseUpHandler=function(aaa,baa,caa,daa)
if
(bc.mouseUpHandler(aaa,baa,caa,daa))then d_a(aaa,"mouse_up",baa,caa,daa)return true end;return false end,scrollHandler=function(aaa,baa,caa,daa)
if
(bc.scrollHandler(aaa,baa,caa,daa))then d_a(aaa,"mouse_scroll",baa,caa,daa)return true end;return false end,dragHandler=function(aaa,baa,caa,daa)
if
(bc.dragHandler(aaa,baa,caa,daa))then d_a(aaa,"mouse_drag",baa,caa,daa)return true end;return false end,keyHandler=function(aaa,baa,caa)if
(bc.keyHandler(aaa,baa,caa))then _aa(aaa,"key",baa,caa)return true end;return
false end,keyUpHandler=function(aaa,baa)if
(bc.keyUpHandler(aaa,baa))then _aa(aaa,"key_up",baa)return true end
return false end,charHandler=function(aaa,baa)if
(bc.charHandler(aaa,baa))then _aa(aaa,"char",baa)return true end
return false end,getFocusHandler=function(aaa)
bc.getFocusHandler(aaa)
if(dd~=nil)then
if not(dd:isDead())then
if not(__a)then local baa=aaa:getParent()
if(baa~=nil)then
local caa,daa=cd.getCursorPos()local _ba,aba=aaa:getPosition()local bba,cba=aaa:getSize()
if
(

_ba+caa-1 >=1 and _ba+caa-1 <=_ba+bba-1 and daa+aba-1 >=1 and daa+aba-1 <=aba+cba-1)then
baa:setCursor(cd.getCursorBlink(),_ba+caa-1,daa+aba-1,cd.getTextColor())end end end end end end,loseFocusHandler=function(aaa)
bc.loseFocusHandler(aaa)
if(dd~=nil)then if not(dd:isDead())then local baa=aaa:getParent()if(baa~=nil)then
baa:setCursor(false)end end end end,eventHandler=function(aaa,baa,...)
bc.eventHandler(aaa,baa,...)if dd==nil then return end
if not dd:isDead()then
if not __a then c_a(aaa,baa,...)
if
aaa:isFocused()then local caa=aaa:getParent()local daa,_ba=aaa:getPosition()
local aba,bba=cd.getCursorPos()local cba,dba=aaa:getSize()
if daa+aba-1 >=1 and
daa+aba-1 <=daa+cba-1 and bba+_ba-1 >=1 and
bba+_ba-1 <=_ba+dba-1 then
caa:setCursor(cd.getCursorBlink(),
daa+aba-1,bba+_ba-1,cd.getTextColor())end end else table.insert(a_a,{event=baa,args={...}})end end end,draw=function(aaa)
bc.draw(aaa)
aaa:addDraw("program",function()local baa=aaa:getParent()local caa,daa=aaa:getPosition()
local _ba,aba=cd.getCursorPos()local bba,cba=aaa:getSize()cd.basalt_reposition(caa,daa)
cd.basalt_update()end)end,onError=function(aaa,...)
for caa,daa in
pairs(table.pack(...))do if(type(daa)=="function")then
aaa:registerEvent("program_error",daa)end end;local baa=aaa:getParent()aaa:listenEvent("other_event")
return aaa end,onDone=function(aaa,...)
for caa,daa in
pairs(table.pack(...))do if(type(daa)=="function")then
aaa:registerEvent("program_done",daa)end end;local baa=aaa:getParent()aaa:listenEvent("other_event")
return aaa end}dc.__index=dc;return setmetatable(dc,bc)end end
ba["objects"]["ScrollableFrame"]=function(...)
local bb,cb,db,_c=math.max,math.min,string.sub,string.rep
return
function(ac,bc)local cc=bc.getObject("Frame")(ac,bc)
local dc="ScrollableFrame"local _d;local ad=0
local function bd(__a)local a_a=0;local b_a=__a:getObjects()
for c_a,d_a in pairs(b_a)do
if
(d_a.element.getWidth~=nil)and(d_a.element.getX~=nil)then
local _aa,aaa=d_a.element:getWidth(),d_a.element:getX()local baa=__a:getWidth()if(_aa+aaa-baa>=a_a)then
a_a=bb(_aa+aaa-baa,0)end end end;return a_a end
local function cd(__a)local a_a=0;local b_a=__a:getObjects()
for c_a,d_a in pairs(b_a)do
if
(d_a.element.getHeight~=nil)and(d_a.element.getY~=nil)then
local _aa,aaa=d_a.element:getHeight(),d_a.element:getY()local baa=__a:getHeight()if(_aa+aaa-baa>=a_a)then
a_a=bb(_aa+aaa-baa,0)end end end;return a_a end
local dd={getType=function()return dc end,isType=function(__a,a_a)return
dc==a_a or cc.isType~=nil and cc.isType(a_a)or false end,setDirection=function(__a,a_a)ad=
a_a=="horizontal"and 1 or a_a=="vertical"and 0 or
ad;return __a end,getBase=function(__a)return
cc end,load=function(__a)cc.load(__a)
__a:listenEvent("mouse_scroll")end,setParent=function(__a,a_a,...)cc.setParent(__a,a_a,...)_d=a_a
return __a end,scrollHandler=function(__a,a_a,b_a,c_a)
if(cc.scrollHandler(__a,a_a,b_a,c_a))then
local d_a,_aa=__a:getOffset()if(ad==1)then
__a:setOffset(cb(bd(__a),bb(0,d_a+a_a)),_aa)elseif(ad==0)then
__a:setOffset(d_a,cb(cd(__a),bb(0,_aa+a_a)))end
__a:updateDraw()return true end end}dd.__index=dd;return setmetatable(dd,cc)end end
ba["objects"]["Pane"]=function(...)
return
function(bb,cb)
local db=cb.getObject("VisualObject")(bb,cb)local _c="Pane"db:setSize(25,10)
local ac={getType=function(bc)return _c end}ac.__index=ac;return setmetatable(ac,db)end end
ba["objects"]["Textfield"]=function(...)local bb=_b("tHex")
local cb,db,_c,ac,bc=string.rep,string.find,string.gmatch,string.sub,string.len
return
function(cc,dc)
local _d=dc.getObject("ChangeableObject")(cc,dc)local ad="Textfield"local bd,cd,dd,__a=1,1,1,1;local a_a={""}local b_a={""}local c_a={""}local d_a={}local _aa={}
local aaa,baa,caa,daa;local _ba,aba=colors.lightBlue,colors.black;_d:setSize(30,12)
_d:setZIndex(5)
local function bba()if
(aaa~=nil)and(baa~=nil)and(caa~=nil)and(daa~=nil)then return true end;return false end
local function cba()local dca,_da,ada,bda=aaa,baa,caa,daa
if bba()then
if aaa<baa and caa<=daa then dca=aaa;_da=baa;if caa<daa then
ada=caa;bda=daa else ada=daa;bda=caa end elseif aaa>baa and caa>=daa then
dca=baa;_da=aaa;if caa>daa then ada=daa;bda=caa else ada=caa;bda=daa end elseif caa>daa then
dca=baa;_da=aaa;ada=daa;bda=caa end;return dca,_da,ada,bda end end
local function dba(dca)local _da,ada,bda,cda=cba(dca)local dda=a_a[bda]local __b=a_a[cda]
a_a[bda]=
dda:sub(1,_da-1)..__b:sub(ada+1,__b:len())b_a[bda]=b_a[bda]:sub(1,_da-1)..
b_a[cda]:sub(ada+1,b_a[cda]:len())
c_a[bda]=c_a[bda]:sub(1,
_da-1)..c_a[cda]:sub(ada+1,c_a[cda]:len())
for i=cda,bda+1,-1 do if i~=bda then table.remove(a_a,i)table.remove(b_a,i)
table.remove(c_a,i)end end;dd,__a=_da,bda;aaa,baa,caa,daa=nil,nil,nil,nil;return dca end
local function _ca(dca,_da)local ada={}
if(dca:len()>0)then
for bda in _c(dca,_da)do local cda,dda=db(dca,bda)
if
(cda~=nil)and(dda~=nil)then table.insert(ada,cda)table.insert(ada,dda)
local __b=ac(dca,1,(cda-1))local a_b=ac(dca,dda+1,dca:len())dca=__b.. (":"):rep(bda:len())..
a_b end end end;return ada end
local function aca(dca,_da)_da=_da or __a
local ada=bb[dca:getForeground()]:rep(c_a[_da]:len())
local bda=bb[dca:getBackground()]:rep(b_a[_da]:len())
for cda,dda in pairs(_aa)do local __b=_ca(a_a[_da],dda[1])
if(#__b>0)then
for x=1,#__b/2 do
local a_b=x*2 -1;if(dda[2]~=nil)then
ada=ada:sub(1,__b[a_b]-1)..bb[dda[2]]:rep(__b[a_b+1]- (
__b[a_b]-1))..
ada:sub(__b[a_b+1]+1,ada:len())end;if
(dda[3]~=nil)then
bda=bda:sub(1,__b[a_b]-1)..

bb[dda[3]]:rep(__b[a_b+1]- (__b[a_b]-1))..bda:sub(__b[a_b+1]+1,bda:len())end end end end
for cda,dda in pairs(d_a)do
for __b,a_b in pairs(dda)do local b_b=_ca(a_a[_da],a_b)
if(#b_b>0)then for x=1,#b_b/2 do
local c_b=x*2 -1
ada=ada:sub(1,b_b[c_b]-1)..

bb[cda]:rep(b_b[c_b+1]- (b_b[c_b]-1))..ada:sub(b_b[c_b+1]+1,ada:len())end end end end;c_a[_da]=ada;b_a[_da]=bda;dca:updateDraw()end;local function bca(dca)for n=1,#a_a do aca(dca,n)end end
local cca={getType=function(dca)return ad end,setBackground=function(dca,_da)
_d.setBackground(dca,_da)bca(dca)return dca end,setForeground=function(dca,_da)
_d.setForeground(dca,_da)bca(dca)return dca end,setSelection=function(dca,_da,ada)aba=_da or aba
_ba=ada or _ba;return dca end,getSelection=function(dca)return aba,_ba end,getLines=function(dca)return a_a end,getLine=function(dca,_da)return
a_a[_da]end,editLine=function(dca,_da,ada)a_a[_da]=ada or a_a[_da]
aca(dca,_da)dca:updateDraw()return dca end,clear=function(dca)
a_a={""}b_a={""}c_a={""}aaa,baa,caa,daa=nil,nil,nil,nil;bd,cd,dd,__a=1,1,1,1
dca:updateDraw()return dca end,addLine=function(dca,_da,ada)
if(_da~=nil)then
local bda=dca:getBackground()local cda=dca:getForeground()
if(#a_a==1)and(a_a[1]=="")then
a_a[1]=_da;b_a[1]=bb[bda]:rep(_da:len())
c_a[1]=bb[cda]:rep(_da:len())aca(dca,1)return dca end
if(ada~=nil)then table.insert(a_a,ada,_da)
table.insert(b_a,ada,bb[bda]:rep(_da:len()))
table.insert(c_a,ada,bb[cda]:rep(_da:len()))else table.insert(a_a,_da)
table.insert(b_a,bb[bda]:rep(_da:len()))
table.insert(c_a,bb[cda]:rep(_da:len()))end end;aca(dca,ada or#a_a)dca:updateDraw()return dca end,addKeywords=function(dca,_da,ada)if(
d_a[_da]==nil)then d_a[_da]={}end;for bda,cda in pairs(ada)do
table.insert(d_a[_da],cda)end;dca:updateDraw()return dca end,addRule=function(dca,_da,ada,bda)
table.insert(_aa,{_da,ada,bda})dca:updateDraw()return dca end,editRule=function(dca,_da,ada,bda)for cda,dda in
pairs(_aa)do
if(dda[1]==_da)then _aa[cda][2]=ada;_aa[cda][3]=bda end end;dca:updateDraw()return dca end,removeRule=function(dca,_da)
for ada,bda in
pairs(_aa)do if(bda[1]==_da)then table.remove(_aa,ada)end end;dca:updateDraw()return dca end,setKeywords=function(dca,_da,ada)
d_a[_da]=ada;dca:updateDraw()return dca end,removeLine=function(dca,_da)
if(#a_a>1)then table.remove(a_a,
_da or#a_a)
table.remove(b_a,_da or#b_a)table.remove(c_a,_da or#c_a)else a_a={""}b_a={""}c_a={""}end;dca:updateDraw()return dca end,getTextCursor=function(dca)return
dd,__a end,getOffset=function(dca)return cd,bd end,setOffset=function(dca,_da,ada)cd=_da or cd;bd=ada or bd
dca:updateDraw()return dca end,getFocusHandler=function(dca)
_d.getFocusHandler(dca)local _da,ada=dca:getPosition()
dca:getParent():setCursor(true,_da+dd-cd,
ada+__a-bd,dca:getForeground())end,loseFocusHandler=function(dca)
_d.loseFocusHandler(dca)dca:getParent():setCursor(false)end,keyHandler=function(dca,_da)
if
(_d.keyHandler(dca,event,_da))then local ada=dca:getParent()local bda,cda=dca:getPosition()
local dda,__b=dca:getSize()
if(_da==keys.backspace)then
if(bba())then dba(dca)else
if(a_a[__a]=="")then
if(__a>1)then
table.remove(a_a,__a)table.remove(c_a,__a)table.remove(b_a,__a)dd=
a_a[__a-1]:len()+1;cd=dd-dda+1;if(cd<1)then cd=1 end;__a=__a-1 end elseif(dd<=1)then
if(__a>1)then dd=a_a[__a-1]:len()+1;cd=dd-dda+1;if(cd<
1)then cd=1 end;a_a[__a-1]=a_a[__a-1]..a_a[__a]c_a[
__a-1]=c_a[__a-1]..c_a[__a]b_a[__a-1]=b_a[__a-1]..
b_a[__a]table.remove(a_a,__a)
table.remove(c_a,__a)table.remove(b_a,__a)__a=__a-1 end else a_a[__a]=a_a[__a]:sub(1,dd-2)..
a_a[__a]:sub(dd,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,
dd-2)..c_a[__a]:sub(dd,c_a[__a]:len())b_a[__a]=b_a[__a]:sub(1,dd-2)..
b_a[__a]:sub(dd,b_a[__a]:len())
if(dd>1)then dd=dd-1 end;if(cd>1)then if(dd<cd)then cd=cd-1 end end end;if(__a<bd)then bd=bd-1 end end;aca(dca)dca:setValue("")elseif(_da==keys.delete)then
if(bba())then dba(dca)else
if(dd>
a_a[__a]:len())then
if(a_a[__a+1]~=nil)then
a_a[__a]=a_a[__a]..a_a[__a+1]table.remove(a_a,__a+1)table.remove(b_a,__a+1)table.remove(c_a,
__a+1)end else a_a[__a]=a_a[__a]:sub(1,dd-1)..
a_a[__a]:sub(dd+1,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,
dd-1)..c_a[__a]:sub(dd+1,c_a[__a]:len())b_a[__a]=b_a[__a]:sub(1,dd-1)..
b_a[__a]:sub(dd+1,b_a[__a]:len())end end;aca(dca)elseif(_da==keys.enter)then if(bba())then dba(dca)end
table.insert(a_a,__a+1,a_a[__a]:sub(dd,a_a[__a]:len()))
table.insert(c_a,__a+1,c_a[__a]:sub(dd,c_a[__a]:len()))
table.insert(b_a,__a+1,b_a[__a]:sub(dd,b_a[__a]:len()))a_a[__a]=a_a[__a]:sub(1,dd-1)
c_a[__a]=c_a[__a]:sub(1,dd-1)b_a[__a]=b_a[__a]:sub(1,dd-1)__a=__a+1;dd=1;cd=1;if
(__a-bd>=__b)then bd=bd+1 end;dca:setValue("")elseif(_da==keys.up)then
aaa,caa,baa,daa=nil,nil,nil,nil
if(__a>1)then __a=__a-1;if(dd>a_a[__a]:len()+1)then dd=
a_a[__a]:len()+1 end;if(cd>1)then if(dd<cd)then cd=dd-dda+1;if
(cd<1)then cd=1 end end end;if(
bd>1)then if(__a<bd)then bd=bd-1 end end end elseif(_da==keys.down)then aaa,caa,baa,daa=nil,nil,nil,nil
if(__a<#a_a)then __a=__a+1
if(dd>
a_a[__a]:len()+1)then dd=a_a[__a]:len()+1 end
if(cd>1)then if(dd<cd)then cd=dd-dda+1;if(cd<1)then cd=1 end end end;if(__a>=bd+__b)then bd=bd+1 end end elseif(_da==keys.right)then aaa,caa,baa,daa=nil,nil,nil,nil;dd=dd+1
if(__a<#a_a)then if(dd>
a_a[__a]:len()+1)then dd=1;__a=__a+1 end elseif(dd>
a_a[__a]:len())then dd=a_a[__a]:len()+1 end;if(dd<1)then dd=1 end
if(dd<cd)or(dd>=dda+cd)then cd=dd-dda+1 end;if(cd<1)then cd=1 end elseif(_da==keys.left)then aaa,caa,baa,daa=nil,nil,nil,nil;dd=dd-1
if(dd>=1)then if(
dd<cd)or(dd>=dda+cd)then cd=dd end end;if(__a>1)then if(dd<1)then __a=__a-1;dd=a_a[__a]:len()+1
cd=dd-dda+1 end end
if(dd<1)then dd=1 end;if(cd<1)then cd=1 end elseif(_da==keys.tab)then
if(dd%3 ==0)then
a_a[__a]=
a_a[__a]:sub(1,dd-1).." "..a_a[__a]:sub(dd,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,dd-1)..bb[dca:getForeground()]..
c_a[__a]:sub(dd,c_a[__a]:len())
b_a[__a]=b_a[__a]:sub(1,dd-1)..bb[dca:getBackground()]..
b_a[__a]:sub(dd,b_a[__a]:len())dd=dd+1 end
while dd%3 ~=0 do
a_a[__a]=a_a[__a]:sub(1,dd-1).." "..
a_a[__a]:sub(dd,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,dd-1)..bb[dca:getForeground()]..
c_a[__a]:sub(dd,c_a[__a]:len())
b_a[__a]=b_a[__a]:sub(1,dd-1)..bb[dca:getBackground()]..
b_a[__a]:sub(dd,b_a[__a]:len())dd=dd+1 end end
if not
( (bda+dd-cd>=bda and bda+dd-cd<bda+dda)and(
cda+__a-bd>=cda and cda+__a-bd<cda+__b))then cd=math.max(1,
a_a[__a]:len()-dda+1)
bd=math.max(1,__a-__b+1)end;local a_b=
(dd<=a_a[__a]:len()and dd-1 or a_a[__a]:len())- (cd-1)
if(a_b>
dca:getX()+dda-1)then a_b=dca:getX()+dda-1 end
local b_b=(__a-bd<__b and __a-bd or __a-bd-1)if(a_b<1)then a_b=0 end
ada:setCursor(true,bda+a_b,cda+b_b,dca:getForeground())dca:updateDraw()return true end end,charHandler=function(dca,_da)
if
(_d.charHandler(dca,_da))then local ada=dca:getParent()local bda,cda=dca:getPosition()
local dda,__b=dca:getSize()if(bba())then dba(dca)end
a_a[__a]=a_a[__a]:sub(1,dd-1).._da..
a_a[__a]:sub(dd,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,dd-1)..bb[dca:getForeground()]..
c_a[__a]:sub(dd,c_a[__a]:len())
b_a[__a]=b_a[__a]:sub(1,dd-1)..bb[dca:getBackground()]..
b_a[__a]:sub(dd,b_a[__a]:len())dd=dd+1;if(dd>=dda+cd)then cd=cd+1 end;aca(dca)
dca:setValue("")
if not
( (bda+dd-cd>=bda and bda+dd-cd<bda+dda)and(
cda+__a-bd>=cda and cda+__a-bd<cda+__b))then cd=math.max(1,
a_a[__a]:len()-dda+1)
bd=math.max(1,__a-__b+1)end;local a_b=
(dd<=a_a[__a]:len()and dd-1 or a_a[__a]:len())- (cd-1)
if(a_b>
dca:getX()+dda-1)then a_b=dca:getX()+dda-1 end
local b_b=(__a-bd<__b and __a-bd or __a-bd-1)if(a_b<1)then a_b=0 end
ada:setCursor(true,bda+a_b,cda+b_b,dca:getForeground())dca:updateDraw()return true end end,dragHandler=function(dca,_da,ada,bda)
if
(_d.dragHandler(dca,_da,ada,bda))then local cda=dca:getParent()local dda,__b=dca:getAbsolutePosition()
local a_b,b_b=dca:getPosition()local c_b,d_b=dca:getSize()
if(a_a[bda-__b+bd]~=nil)then
if
a_b<=ada-dda+cd and a_b+c_b>ada-dda+cd then dd=ada-dda+cd;__a=
bda-__b+bd;if dd>a_a[__a]:len()then
dd=a_a[__a]:len()+1 end;baa=dd;daa=__a
if dd<cd then cd=dd-1;if cd<1 then cd=1 end end
cda:setCursor(not bba(),a_b+dd-cd,b_b+__a-bd,dca:getForeground())dca:updateDraw()end end;return true end end,scrollHandler=function(dca,_da,ada,bda)
if
(_d.scrollHandler(dca,_da,ada,bda))then local cda=dca:getParent()local dda,__b=dca:getAbsolutePosition()
local a_b,b_b=dca:getPosition()local c_b,d_b=dca:getSize()bd=bd+_da;if(bd>#a_a- (d_b-1))then
bd=#a_a- (d_b-1)end;if(bd<1)then bd=1 end
if(dda+dd-cd>=dda and dda+dd-cd<
dda+c_b)and(b_b+__a-bd>=b_b and
b_b+__a-bd<b_b+d_b)then
cda:setCursor(not bba(),
a_b+dd-cd,b_b+__a-bd,dca:getForeground())else cda:setCursor(false)end;dca:updateDraw()return true end end,mouseHandler=function(dca,_da,ada,bda)
if
(_d.mouseHandler(dca,_da,ada,bda))then local cda=dca:getParent()local dda,__b=dca:getAbsolutePosition()
local a_b,b_b=dca:getPosition()
if(a_a[bda-__b+bd]~=nil)then dd=ada-dda+cd;__a=bda-__b+bd;baa=
nil;daa=nil;aaa=dd;caa=__a;if(dd>a_a[__a]:len())then dd=
a_a[__a]:len()+1;aaa=dd end;if(dd<cd)then cd=dd-1
if(cd<1)then cd=1 end end;dca:updateDraw()end
cda:setCursor(true,a_b+dd-cd,b_b+__a-bd,dca:getForeground())return true end end,mouseUpHandler=function(dca,_da,ada,bda)
if
(_d.mouseUpHandler(dca,_da,ada,bda))then local cda,dda=dca:getAbsolutePosition()
local __b,a_b=dca:getPosition()
if(a_a[bda-dda+bd]~=nil)then baa=ada-cda+cd
daa=bda-dda+bd
if(baa>a_a[daa]:len())then baa=a_a[daa]:len()+1 end
if(aaa==baa)and(caa==daa)then aaa,baa,caa,daa=nil,nil,nil,nil end;dca:updateDraw()end;return true end end,eventHandler=function(dca,_da,ada,bda,cda,dda)
if
(_d.eventHandler(dca,_da,ada,bda,cda,dda))then
if(_da=="paste")then
if(dca:isFocused())then local __b=dca:getParent()
local a_b,b_b=dca:getForeground(),dca:getBackground()local c_b,d_b=dca:getSize()
a_a[__a]=a_a[__a]:sub(1,dd-1)..ada..
a_a[__a]:sub(dd,a_a[__a]:len())
c_a[__a]=c_a[__a]:sub(1,dd-1)..bb[a_b]:rep(ada:len())..
c_a[__a]:sub(dd,c_a[__a]:len())
b_a[__a]=b_a[__a]:sub(1,dd-1)..bb[b_b]:rep(ada:len())..
b_a[__a]:sub(dd,b_a[__a]:len())dd=dd+ada:len()if(dd>=c_b+cd)then cd=(dd+1)-c_b end
local _ab,aab=dca:getPosition()
__b:setCursor(true,_ab+dd-cd,aab+__a-bd,a_b)aca(dca)dca:updateDraw()end end end end,draw=function(dca)
_d.draw(dca)
dca:addDraw("textfield",function()local _da=dca:getParent()local ada,bda=dca:getPosition()
local cda,dda=dca:getSize()local __b=bb[dca:getBackground()]
local a_b=bb[dca:getForeground()]
for n=1,dda do local b_b=""local c_b=""local d_b=""if a_a[n+bd-1]then b_b=a_a[n+bd-1]
d_b=c_a[n+bd-1]c_b=b_a[n+bd-1]end
b_b=ac(b_b,cd,cda+cd-1)c_b=cb(__b,cda)d_b=cb(a_b,cda)dca:addText(1,n,b_b)
dca:addBG(1,n,c_b)dca:addFG(1,n,d_b)dca:addBlit(1,n,b_b,d_b,c_b)end
if aaa and baa and caa and daa then local b_b,c_b,d_b,_ab=cba(dca)
for n=d_b,_ab do
local aab=#a_a[n]local bab=0
if n==d_b and n==_ab then bab=b_b-1
aab=aab- (b_b-1)- (aab-c_b)elseif n==_ab then aab=aab- (aab-c_b)elseif n==d_b then aab=aab- (b_b-1)bab=b_b-1 end;dca:addBG(1 +bab,n,cb(bb[_ba],aab))
dca:addFG(1 +bab,n,cb(bb[aba],aab))end end end)end,load=function(dca)
dca:listenEvent("mouse_click")dca:listenEvent("mouse_up")
dca:listenEvent("mouse_scroll")dca:listenEvent("mouse_drag")
dca:listenEvent("key")dca:listenEvent("char")
dca:listenEvent("other_event")end}cca.__index=cca;return setmetatable(cca,_d)end end
ba["objects"]["Switch"]=function(...)
return
function(bb,cb)
local db=cb.getObject("ChangeableObject")(bb,cb)local _c="Switch"db:setSize(4,1)db:setValue(false)
db:setZIndex(5)local ac=colors.black;local bc=colors.red;local cc=colors.green
local dc={getType=function(_d)return _c end,setSymbol=function(_d,ad)
ac=ad;return _d end,setActiveBackground=function(_d,ad)cc=ad;return _d end,setInactiveBackground=function(_d,ad)bc=ad;return _d end,load=function(_d)
_d:listenEvent("mouse_click")end,mouseHandler=function(_d,...)
if(db.mouseHandler(_d,...))then
_d:setValue(not _d:getValue())_d:updateDraw()return true end end,draw=function(_d)db.draw(_d)
_d:addDraw("switch",function()
local ad=_d:getParent()local bd,cd=_d:getBackground(),_d:getForeground()
local dd,__a=_d:getSize()
if(_d:getValue())then _d:addBackgroundBox(1,1,dd,__a,cc)
_d:addBackgroundBox(dd,1,1,__a,ac)else _d:addBackgroundBox(1,1,dd,__a,bc)
_d:addBackgroundBox(1,1,1,__a,ac)end end)end}dc.__index=dc;return setmetatable(dc,db)end end
ba["objects"]["Thread"]=function(...)
return
function(bb,cb)
local db=cb.getObject("Object")(bb,cb)local _c="Thread"local ac;local bc;local cc=false;local dc
local _d={getType=function(ad)return _c end,start=function(ad,bd)if(bd==nil)then
error("Function provided to thread is nil")end;ac=bd;bc=coroutine.create(ac)
cc=true;dc=nil;local cd,dd=coroutine.resume(bc)dc=dd;if not(cd)then
if(dd~="Terminated")then error(
"Thread Error Occurred - "..dd)end end
ad:listenEvent("mouse_click")ad:listenEvent("mouse_up")
ad:listenEvent("mouse_scroll")ad:listenEvent("mouse_drag")ad:listenEvent("key")
ad:listenEvent("key_up")ad:listenEvent("char")
ad:listenEvent("other_event")return ad end,getStatus=function(ad,bd)if(
bc~=nil)then return coroutine.status(bc)end;return nil end,stop=function(ad,bd)
cc=false;ad:listenEvent("mouse_click",false)
ad:listenEvent("mouse_up",false)ad:listenEvent("mouse_scroll",false)
ad:listenEvent("mouse_drag",false)ad:listenEvent("key",false)
ad:listenEvent("key_up",false)ad:listenEvent("char",false)
ad:listenEvent("other_event",false)return ad end,mouseHandler=function(ad,...)
ad:eventHandler("mouse_click",...)end,mouseUpHandler=function(ad,...)ad:eventHandler("mouse_up",...)end,mouseScrollHandler=function(ad,...)
ad:eventHandler("mouse_scroll",...)end,mouseDragHandler=function(ad,...)
ad:eventHandler("mouse_drag",...)end,mouseMoveHandler=function(ad,...)
ad:eventHandler("mouse_move",...)end,keyHandler=function(ad,...)ad:eventHandler("key",...)end,keyUpHandler=function(ad,...)
ad:eventHandler("key_up",...)end,charHandler=function(ad,...)ad:eventHandler("char",...)end,eventHandler=function(ad,bd,...)
if
(cc)then
if(coroutine.status(bc)=="suspended")then if(dc~=nil)then if(bd~=dc)then return end;dc=
nil end
local cd,dd=coroutine.resume(bc,bd,...)dc=dd;if not(cd)then if(dd~="Terminated")then
error("Thread Error Occurred - "..dd)end end else
ad:stop()end end end}_d.__index=_d;return setmetatable(_d,db)end end
ba["objects"]["Treeview"]=function(...)local bb=_b("utils")local cb=_b("tHex")
return
function(db,_c)
local ac=_c.getObject("ChangeableObject")(db,_c)local bc="Treeview"local cc={}local dc=colors.black;local _d=colors.lightGray;local ad=true
local bd="left"local cd,dd=0,0;local __a=true;ac:setSize(16,8)ac:setZIndex(5)
local function a_a(d_a,_aa)
d_a=d_a or""_aa=_aa or false;local aaa=false;local baa=nil;local caa={}local daa={}local _ba
daa={getChildren=function()return caa end,setParent=function(aba)if(
baa~=nil)then
baa.removeChild(baa.findChildrenByText(daa.getText()))end;baa=aba;ac:updateDraw()return daa end,getParent=function()return
baa end,addChild=function(aba,bba)local cba=a_a(aba,bba)cba.setParent(daa)
table.insert(caa,cba)ac:updateDraw()return cba end,setExpanded=function(aba)if
(_aa)then aaa=aba end;ac:updateDraw()return daa end,isExpanded=function()return
aaa end,onSelect=function(...)for aba,bba in pairs(table.pack(...))do if(type(bba)=="function")then
_ba=bba end end;return daa end,callOnSelect=function()if(
_ba~=nil)then _ba(daa)end end,setExpandable=function(aba)aba=aba
ac:updateDraw()return daa end,isExpandable=function()return _aa end,removeChild=function(aba)
if(type(aba)=="table")then for bba,cba in
pairs(aba)do if(cba==aba)then aba=bba;break end end end;table.remove(caa,aba)ac:updateDraw()return daa end,findChildrenByText=function(aba)
local bba={}
for cba,dba in ipairs(caa)do if string.find(dba.getText(),aba)then
table.insert(bba,dba)end end;return bba end,getText=function()return
d_a end,setText=function(aba)d_a=aba;ac:updateDraw()return daa end}return daa end;local b_a=a_a("Root",true)b_a.setExpanded(true)
local c_a={init=function(d_a)
local _aa=d_a:getParent()d_a:listenEvent("mouse_click")
d_a:listenEvent("mouse_scroll")return ac.init(d_a)end,getBase=function(d_a)return
ac end,getType=function(d_a)return bc end,isType=function(d_a,_aa)
return bc==_aa or
ac.isType~=nil and ac.isType(_aa)or false end,setOffset=function(d_a,_aa,aaa)cd=_aa;dd=aaa;return d_a end,getOffset=function(d_a)return
cd,dd end,setScrollable=function(d_a,_aa)__a=_aa;return d_a end,setSelectionColor=function(d_a,_aa,aaa,baa)dc=_aa or
d_a:getBackground()
_d=aaa or d_a:getForeground()ad=baa~=nil and baa or true;d_a:updateDraw()
return d_a end,getSelectionColor=function(d_a)
return dc,_d end,isSelectionColorActive=function(d_a)return ad end,getRoot=function(d_a)return b_a end,setRoot=function(d_a,_aa)b_a=_aa
_aa.setParent(nil)return d_a end,onSelect=function(d_a,...)for _aa,aaa in pairs(table.pack(...))do
if(type(aaa)==
"function")then d_a:registerEvent("treeview_select",aaa)end end;return d_a end,selectionHandler=function(d_a,_aa)
_aa.callOnSelect(_aa)d_a:sendEvent("treeview_select",_aa)return d_a end,mouseHandler=function(d_a,_aa,aaa,baa)
if
ac.mouseHandler(d_a,_aa,aaa,baa)then local caa=1 -dd;local daa,_ba=d_a:getAbsolutePosition()
local aba,bba=d_a:getSize()
local function cba(dba,_ca)
if baa==_ba+caa-1 then
if aaa>=daa and aaa<daa+aba then dba.setExpanded(not
dba.isExpanded())
d_a:selectionHandler(dba)d_a:setValue(dba)d_a:updateDraw()return true end end;caa=caa+1
if dba.isExpanded()then for aca,bca in ipairs(dba.getChildren())do if cba(bca,_ca+1)then return
true end end end;return false end
for dba,_ca in ipairs(b_a.getChildren())do if cba(_ca,1)then return true end end end end,scrollHandler=function(d_a,_aa,aaa,baa)
if
ac.scrollHandler(d_a,_aa,aaa,baa)then
if __a then local caa,daa=d_a:getSize()dd=dd+_aa;if dd<0 then dd=0 end
if _aa>=1 then local _ba=0
local function aba(bba,cba)
_ba=_ba+1;if bba.isExpanded()then
for dba,_ca in ipairs(bba.getChildren())do aba(_ca,cba+1)end end end;for bba,cba in ipairs(b_a.getChildren())do aba(cba,1)end
if
_ba>daa then if dd>_ba-daa then dd=_ba-daa end else dd=dd-1 end end;d_a:updateDraw()end;return true end;return false end,draw=function(d_a)
ac.draw(d_a)
d_a:addDraw("treeview",function()local _aa=1 -dd;local aaa=d_a:getValue()
local function baa(caa,daa)
local _ba,aba=d_a:getSize()
if _aa>=1 and _aa<=aba then
local bba=(caa==aaa)and dc or d_a:getBackground()
local cba=(caa==aaa)and _d or d_a:getForeground()local dba=caa.getText()
d_a:addBlit(1 +daa+cd,_aa,dba,cb[cba]:rep(#dba),cb[bba]:rep(
#dba))end;_aa=_aa+1;if caa.isExpanded()then for bba,cba in ipairs(caa.getChildren())do
baa(cba,daa+1)end end end;for caa,daa in ipairs(b_a.getChildren())do baa(daa,1)end end)end}c_a.__index=c_a;return setmetatable(c_a,ac)end end
ba["objects"]["Scrollbar"]=function(...)local bb=_b("tHex")
return
function(cb,db)
local _c=db.getObject("VisualObject")(cb,db)local ac="Scrollbar"_c:setZIndex(2)_c:setSize(1,8)
_c:setBackground(colors.lightGray,"\127",colors.gray)local bc="vertical"local cc=" "local dc=colors.yellow;local _d=colors.black;local ad=3;local bd=1
local cd=1;local dd=true
local function __a()local c_a,d_a=_c:getSize()if(dd)then
cd=math.max((bc=="vertical"and d_a or
c_a- (#cc))- (ad-1),1)end end
local function a_a(c_a,d_a,_aa,aaa)local baa,caa=c_a:getPosition()local daa,_ba=c_a:getSize()__a()local aba=
bc=="vertical"and _ba or daa
for i=0,aba do
if

(
(bc=="vertical"and caa+i==aaa)or(bc=="horizontal"and baa+i==_aa))and(baa<=_aa)and(baa+daa>_aa)and(caa<=aaa)and
(caa+_ba>aaa)then bd=math.min(i+1,aba- (#
cc+cd-2))
c_a:scrollbarMoveHandler()c_a:updateDraw()end end end
local b_a={getType=function(c_a)return ac end,load=function(c_a)_c.load(c_a)local d_a=c_a:getParent()
c_a:listenEvent("mouse_click")c_a:listenEvent("mouse_up")
c_a:listenEvent("mouse_scroll")c_a:listenEvent("mouse_drag")end,setSymbol=function(c_a,d_a,_aa,aaa)
cc=d_a:sub(1,1)dc=_aa or dc;_d=aaa or _d;__a()c_a:updateDraw()return c_a end,setIndex=function(c_a,d_a)
bd=d_a;if(bd<1)then bd=1 end;local _aa,aaa=c_a:getSize()
bd=math.min(bd,(
bc=="vertical"and aaa or _aa)- (cd-1))__a()c_a:updateDraw()return c_a end,setScrollAmount=function(c_a,d_a)
ad=d_a;__a()c_a:updateDraw()return c_a end,getIndex=function(c_a)
local d_a,_aa=c_a:getSize()return
ad> (bc=="vertical"and _aa or d_a)and
math.floor(ad/ (
bc=="vertical"and _aa or d_a)*bd)or bd end,setSymbolSize=function(c_a,d_a)cd=
tonumber(d_a)or 1;dd=d_a~=false and false or true
__a()c_a:updateDraw()return c_a end,setBarType=function(c_a,d_a)
bc=d_a:lower()__a()c_a:updateDraw()return c_a end,mouseHandler=function(c_a,d_a,_aa,aaa)if
(_c.mouseHandler(c_a,d_a,_aa,aaa))then a_a(c_a,d_a,_aa,aaa)return true end;return
false end,dragHandler=function(c_a,d_a,_aa,aaa)if
(_c.dragHandler(c_a,d_a,_aa,aaa))then a_a(c_a,d_a,_aa,aaa)return true end;return
false end,setSize=function(c_a,...)
_c.setSize(c_a,...)__a()return c_a end,scrollHandler=function(c_a,d_a,_aa,aaa)
if(_c.scrollHandler(c_a,d_a,_aa,aaa))then
local baa,caa=c_a:getSize()__a()bd=bd+d_a;if(bd<1)then bd=1 end
bd=math.min(bd,
(bc=="vertical"and caa or baa)- (bc=="vertical"and cd-1 or#cc+cd-2))c_a:scrollbarMoveHandler()c_a:updateDraw()end end,onChange=function(c_a,...)
for d_a,_aa in
pairs(table.pack(...))do if(type(_aa)=="function")then
c_a:registerEvent("scrollbar_moved",_aa)end end;return c_a end,scrollbarMoveHandler=function(c_a)
c_a:sendEvent("scrollbar_moved",c_a,c_a:getIndex())end,customEventHandler=function(c_a,d_a,...)
_c.customEventHandler(c_a,d_a,...)if(d_a=="basalt_FrameResize")then __a()end end,draw=function(c_a)
_c.draw(c_a)
c_a:addDraw("scrollbar",function()local d_a=c_a:getParent()local _aa,aaa=c_a:getSize()
local baa,caa=c_a:getBackground(),c_a:getForeground()
if(bc=="horizontal")then for n=0,aaa-1 do
c_a:addBlit(bd,1 +n,cc:rep(cd),bb[_d]:rep(#cc*cd),bb[dc]:rep(
#cc*cd))end elseif(bc=="vertical")then
for n=0,aaa-1 do
if(bd==n+1)then
for curIndexOffset=0,math.min(
cd-1,aaa)do
c_a:blit(1,bd+curIndexOffset,cc:rep(math.max(#cc,_aa)),bb[_d]:rep(math.max(
#cc,_aa)),bb[dc]:rep(math.max(#cc,_aa)))end end end end end)end}b_a.__index=b_a;return setmetatable(b_a,_c)end end
ba["objects"]["Timer"]=function(...)
return
function(bb)local cb="Timer"local db=0;local _c=0;local ac=0;local bc;local cc=false
local dc={getType=function(_d)return cb end,setTime=function(_d,ad,bd)db=
ad or 0;_c=bd or 1;return _d end,start=function(_d)if(cc)then
os.cancelTimer(bc)end;ac=_c;bc=os.startTimer(db)cc=true
_d:listenEvent("other_event")return _d end,isActive=function(_d)return cc end,cancel=function(_d)if(
bc~=nil)then os.cancelTimer(bc)end;cc=false
_d:removeEvent("other_event")return _d end,onCall=function(_d,ad)
_d:registerEvent("timed_event",ad)return _d end,eventHandler=function(_d,ad,bd)
if
ad=="timer"and bd==bc and cc then _d:sendEvent("timed_event")
if(ac>=1)then ac=ac-1;if(ac>=1)then
bc=os.startTimer(db)end elseif(ac==-1)then bc=os.startTimer(db)end end end}dc.__index=dc;return dc end end
ba["objects"]["VisualObject"]=function(...)local bb=_b("utils")local cb=_b("tHex")
local db,_c,ac=string.sub,string.find,table.insert
return
function(bc,cc)local dc=cc.getObject("Object")(bc,cc)
local _d="VisualObject"local ad,bd,cd,dd,__a=true,false,false,false,false;local a_a=1;local b_a,c_a,d_a,_aa=1,1,1,1
local aaa,baa,caa,daa=0,0,0,0;local _ba,aba,bba=colors.black,colors.white,false;local cba;local dba={}local _ca={}local aca={}
local bca={}
local function cca(_da,ada)local bda={}if _da==""then return bda end;ada=ada or" "local cda=1
local dda,__b=_c(_da,ada,cda)
while dda do
ac(bda,{x=cda,value=db(_da,cda,dda-1)})cda=__b+1;dda,__b=_c(_da,ada,cda)end;ac(bda,{x=cda,value=db(_da,cda)})return bda end
local dca={getType=function(_da)return _d end,getBase=function(_da)return dc end,isType=function(_da,ada)
return _d==ada or
dc.isType~=nil and dc.isType(ada)or false end,getBasalt=function(_da)return cc end,show=function(_da)ad=true
_da:updateDraw()return _da end,hide=function(_da)ad=false;_da:updateDraw()return _da end,isVisible=function(_da)return
ad end,setVisible=function(_da,ada)ad=ada or not ad;_da:updateDraw()return _da end,setTransparency=function(_da,ada)bba=
ada~=nil and ada or true;_da:updateDraw()
return _da end,setParent=function(_da,ada,bda)
dc.setParent(_da,ada,bda)cba=ada;return _da end,setFocus=function(_da)if(cba~=nil)then
cba:setFocusedObject(_da)end;return _da end,setZIndex=function(_da,ada)a_a=ada
if
(cba~=nil)then cba:updateZIndex(_da,a_a)_da:updateDraw()end;return _da end,getZIndex=function(_da)return a_a end,updateDraw=function(_da)if(
cba~=nil)then cba:updateDraw()end;return _da end,setPosition=function(_da,ada,bda,cda)
local dda,__b
if(type(ada)=="number")then b_a=cda and b_a+ada or ada end
if(type(bda)=="number")then c_a=cda and c_a+bda or bda end;if(cba~=nil)then
cba:customEventHandler("basalt_FrameReposition",_da)end;if(_da:getType()=="Container")then
cba:customEventHandler("basalt_FrameReposition",_da)end;_da:updateDraw()
return _da end,getX=function(_da)return
b_a end,getY=function(_da)return c_a end,getPosition=function(_da)return b_a,c_a end,setSize=function(_da,ada,bda,cda)
if(type(ada)==
"number")then d_a=cda and d_a+ada or ada end
if(type(bda)=="number")then _aa=cda and _aa+bda or bda end
if(cba~=nil)then
cba:customEventHandler("basalt_FrameResize",_da)if(_da:getType()=="Container")then
cba:customEventHandler("basalt_FrameResize",_da)end end;_da:updateDraw()return _da end,getHeight=function(_da)return
_aa end,getWidth=function(_da)return d_a end,getSize=function(_da)return d_a,_aa end,setBackground=function(_da,ada)_ba=ada
_da:updateDraw()return _da end,getBackground=function(_da)return _ba end,setForeground=function(_da,ada)aba=ada or false
_da:updateDraw()return _da end,getForeground=function(_da)return aba end,getAbsolutePosition=function(_da,ada,bda)if
(ada==nil)or(bda==nil)then ada,bda=_da:getPosition()end
if(cba~=nil)then
local cda,dda=cba:getAbsolutePosition()ada=cda+ada-1;bda=dda+bda-1 end;return ada,bda end,ignoreOffset=function(_da,ada)
bd=ada;if(ada==nil)then bd=true end;return _da end,isCoordsInObject=function(_da,ada,bda)
if(ad)and
(_da:isEnabled())then if(ada==nil)or(bda==nil)then return false end
local cda,dda=_da:getAbsolutePosition()local __b,a_b=_da:getSize()
if
(cda<=ada)and(cda+__b>ada)and(dda<=bda)and(dda+a_b>bda)then return true end end;return false end,onGetFocus=function(_da,...)
for ada,bda in
pairs(table.pack(...))do if(type(bda)=="function")then
_da:registerEvent("get_focus",bda)end end;return _da end,onLoseFocus=function(_da,...)
for ada,bda in
pairs(table.pack(...))do if(type(bda)=="function")then
_da:registerEvent("lose_focus",bda)end end;return _da end,isFocused=function(_da)
if(
cba~=nil)then return cba:getFocusedObject()==_da end;return true end,onResize=function(_da,...)
for ada,bda in
pairs(table.pack(...))do if(type(bda)=="function")then
_da:registerEvent("basalt_resize",bda)end end;return _da end,onReposition=function(_da,...)
for ada,bda in
pairs(table.pack(...))do if(type(bda)=="function")then
_da:registerEvent("basalt_reposition",bda)end end;return _da end,mouseHandler=function(_da,ada,bda,cda,dda)
if
(_da:isCoordsInObject(bda,cda))then local __b,a_b=_da:getAbsolutePosition()
local b_b=_da:sendEvent("mouse_click",_da,ada,bda- (__b-1),
cda- (a_b-1),bda,cda,dda)if(b_b==false)then return false end;if(cba~=nil)then
cba:setFocusedObject(_da)end;dd=true;__a=true;aaa,baa=bda,cda;return true end end,mouseUpHandler=function(_da,ada,bda,cda)
__a=false
if(dd)then local dda,__b=_da:getAbsolutePosition()
local a_b=_da:sendEvent("mouse_release",_da,"mouse_release",ada,bda- (
dda-1),cda- (__b-1),bda,cda)dd=false end
if(_da:isCoordsInObject(bda,cda))then local dda,__b=_da:getAbsolutePosition()
local a_b=_da:sendEvent("mouse_up",_da,ada,
bda- (dda-1),cda- (__b-1),bda,cda)if(a_b==false)then return false end;return true end end,dragHandler=function(_da,ada,bda,cda)
if
(__a)then local dda,__b=_da:getAbsolutePosition()
local a_b=_da:sendEvent("mouse_drag",_da,ada,bda- (dda-1),
cda- (__b-1),aaa-bda,baa-cda,bda,cda)aaa,baa=bda,cda;if(a_b~=nil)then return a_b end;if(cba~=nil)then
cba:setFocusedObject(_da)end;return true end
if(_da:isCoordsInObject(bda,cda))then local dda,__b=_da:getAbsolutePosition()
aaa,baa=bda,cda;caa,daa=dda-bda,__b-cda end end,scrollHandler=function(_da,ada,bda,cda)
if
(_da:isCoordsInObject(bda,cda))then local dda,__b=_da:getAbsolutePosition()
local a_b=_da:sendEvent("mouse_scroll",_da,"mouse_scroll",ada,bda-
(dda-1),cda- (__b-1))if(a_b==false)then return false end;if(cba~=nil)then
cba:setFocusedObject(_da)end;return true end end,hoverHandler=function(_da,ada,bda,cda)
if
(_da:isCoordsInObject(ada,bda))then
local dda=_da:sendEvent("mouse_hover",_da,"mouse_hover",ada,bda,cda)if(dda==false)then return false end;cd=true;return true end
if(cd)then
local dda=_da:sendEvent("mouse_leave",_da,"mouse_leave",ada,bda,cda)if(dda==false)then return false end;cd=false end end,keyHandler=function(_da,ada,bda)
if
(_da:isEnabled())and(ad)then
if(_da:isFocused())then
local cda=_da:sendEvent("key",_da,"key",ada,bda)if(cda==false)then return false end;return true end end end,keyUpHandler=function(_da,ada)
if
(_da:isEnabled())and(ad)then
if(_da:isFocused())then
local bda=_da:sendEvent("key_up",_da,"key_up",ada)if(bda==false)then return false end;return true end end end,charHandler=function(_da,ada)
if
(_da:isEnabled())and(ad)then
if(_da:isFocused())then
local bda=_da:sendEvent("char",_da,"char",ada)if(bda==false)then return false end;return true end end end,eventHandler=function(_da,ada,...)
local bda=_da:sendEvent("other_event",_da,ada,...)if(bda~=nil)then return bda end end,customEventHandler=function(_da,ada,...)
local bda=_da:sendEvent("custom_event",_da,ada,...)if(bda~=nil)then return bda end;return true end,getFocusHandler=function(_da)
local ada=_da:sendEvent("get_focus",_da)if(ada~=nil)then return ada end;return true end,loseFocusHandler=function(_da)
__a=false;local ada=_da:sendEvent("lose_focus",_da)
if(ada~=nil)then return ada end;return true end,addDraw=function(_da,ada,bda,cda,dda,__b)
local a_b=(dda==nil or
dda==1)and _ca or dda==2 and dba or dda==3 and aca;cda=cda or#a_b+1
if(ada~=nil)then for c_b,d_b in pairs(a_b)do if(d_b.name==ada)then
table.remove(a_b,c_b)break end end
local b_b={name=ada,f=bda,pos=cda,active=
__b~=nil and __b or true}table.insert(a_b,cda,b_b)end;_da:updateDraw()return _da end,addPreDraw=function(_da,ada,bda,cda,dda)
_da:addDraw(ada,bda,cda,2)return _da end,addPostDraw=function(_da,ada,bda,cda,dda)
_da:addDraw(ada,bda,cda,3)return _da end,setDrawState=function(_da,ada,bda,cda)
local dda=
(cda==nil or cda==1)and _ca or cda==2 and dba or cda==3 and aca
for __b,a_b in pairs(dda)do if(a_b.name==ada)then a_b.active=bda;break end end;_da:updateDraw()return _da end,getDrawId=function(_da,ada,bda)local cda=

bda==1 and _ca or bda==2 and dba or bda==3 and aca or _ca;for dda,__b in pairs(cda)do if(
__b.name==ada)then return dda end end end,addText=function(_da,ada,bda,cda)local dda=
_da:getParent()or _da;local __b,a_b=_da:getPosition()if(cba~=nil)then
local c_b,d_b=cba:getOffset()__b=bd and __b or __b-c_b
a_b=bd and a_b or a_b-d_b end
if not(bba)then dda:setText(ada+__b-1,
bda+a_b-1,cda)return end;local b_b=cca(cda,"\0")
for c_b,d_b in pairs(b_b)do if
(d_b.value~="")and(d_b.value~="\0")then
dda:setText(ada+d_b.x+__b-2,bda+a_b-1,d_b.value)end end end,addBG=function(_da,ada,bda,cda,dda)local __b=
cba or _da;local a_b,b_b=_da:getPosition()if(cba~=nil)then
local d_b,_ab=cba:getOffset()a_b=bd and a_b or a_b-d_b
b_b=bd and b_b or b_b-_ab end
if not(bba)then __b:setBG(ada+a_b-1,
bda+b_b-1,cda)return end;local c_b=cca(cda)
for d_b,_ab in pairs(c_b)do
if(_ab.value~="")and(_ab.value~=" ")then
if(dda~=
true)then
__b:setText(ada+_ab.x+a_b-2,bda+b_b-1,(" "):rep(#_ab.value))
__b:setBG(ada+_ab.x+a_b-2,bda+b_b-1,_ab.value)else
table.insert(bca,{x=ada+_ab.x-1,y=bda,bg=_ab.value})__b:setBG(ada+a_b-1,bda+b_b-1,fg)end end end end,addFG=function(_da,ada,bda,cda)local dda=
cba or _da;local __b,a_b=_da:getPosition()if(cba~=nil)then
local c_b,d_b=cba:getOffset()__b=bd and __b or __b-c_b
a_b=bd and a_b or a_b-d_b end
if not(bba)then dda:setFG(ada+__b-1,
bda+a_b-1,cda)return end;local b_b=cca(cda)
for c_b,d_b in pairs(b_b)do if(d_b.value~="")and(d_b.value~=" ")then
dda:setFG(
ada+d_b.x+__b-2,bda+a_b-1,d_b.value)end end end,addBlit=function(_da,ada,bda,cda,dda,__b)local a_b=
cba or _da;local b_b,c_b=_da:getPosition()if(cba~=nil)then
local bab,cab=cba:getOffset()b_b=bd and b_b or b_b-bab
c_b=bd and c_b or c_b-cab end
if not(bba)then a_b:blit(ada+b_b-1,
bda+c_b-1,cda,dda,__b)return end;local d_b=cca(cda,"\0")local _ab=cca(dda)local aab=cca(__b)
for bab,cab in pairs(d_b)do if
(cab.value~="")or(cab.value~="\0")then
a_b:setText(ada+cab.x+b_b-2,bda+c_b-1,cab.value)end end;for bab,cab in pairs(aab)do
if(cab.value~="")or(cab.value~=" ")then a_b:setBG(
ada+cab.x+b_b-2,bda+c_b-1,cab.value)end end;for bab,cab in pairs(_ab)do
if(
cab.value~="")or(cab.value~=" ")then a_b:setFG(ada+cab.x+b_b-2,bda+
c_b-1,cab.value)end end end,addTextBox=function(_da,ada,bda,cda,dda,__b)local a_b=
cba or _da;local b_b,c_b=_da:getPosition()if(cba~=nil)then
local d_b,_ab=cba:getOffset()b_b=bd and b_b or b_b-d_b
c_b=bd and c_b or c_b-_ab end;a_b:drawTextBox(ada+b_b-1,
bda+c_b-1,cda,dda,__b)end,addForegroundBox=function(_da,ada,bda,cda,dda,__b)local a_b=
cba or _da;local b_b,c_b=_da:getPosition()if(cba~=nil)then
local d_b,_ab=cba:getOffset()b_b=bd and b_b or b_b-d_b
c_b=bd and c_b or c_b-_ab end;a_b:drawForegroundBox(ada+b_b-1,
bda+c_b-1,cda,dda,__b)end,addBackgroundBox=function(_da,ada,bda,cda,dda,__b)local a_b=
cba or _da;local b_b,c_b=_da:getPosition()if(cba~=nil)then
local d_b,_ab=cba:getOffset()b_b=bd and b_b or b_b-d_b
c_b=bd and c_b or c_b-_ab end;a_b:drawBackgroundBox(ada+b_b-1,
bda+c_b-1,cda,dda,__b)end,render=function(_da)if
(ad)then _da:redraw()end end,redraw=function(_da)for ada,bda in pairs(dba)do if(bda.active)then
bda.f(_da)end end;for ada,bda in pairs(_ca)do if(bda.active)then
bda.f(_da)end end;for ada,bda in pairs(aca)do if(bda.active)then
bda.f(_da)end end;return true end,draw=function(_da)
_da:addDraw("base",function()
local ada,bda=_da:getSize()if(_ba~=false)then _da:addTextBox(1,1,ada,bda," ")
_da:addBackgroundBox(1,1,ada,bda,_ba)end;if(aba~=false)then
_da:addForegroundBox(1,1,ada,bda,aba)end end,1)end}dca.__index=dca;return setmetatable(dca,dc)end end;ba["libraries"]={}
ba["libraries"]["utils"]=function(...)
local bb,cb,db,_c,ac,bc=string.sub,string.find,string.reverse,string.rep,table.insert,string.len
local function cc(dc,_d)local ad={}if dc==""or _d==""then return ad end;local bd=1;local cd,dd=cb(dc,_d,bd)
while
cd do ac(ad,bb(dc,bd,cd-1))bd=dd+1;cd,dd=cb(dc,_d,bd)end;ac(ad,bb(dc,bd))return ad end
return
{getTextHorizontalAlign=function(dc,_d,ad,bd)dc=bb(dc,1,_d)local cd=_d-bc(dc)
if(ad=="right")then
dc=_c(bd or" ",cd)..dc elseif(ad=="center")then
dc=_c(bd or" ",math.floor(cd/2))..dc..
_c(bd or" ",math.floor(cd/2))
dc=dc.. (bc(dc)<_d and(bd or" ")or"")else dc=dc.._c(bd or" ",cd)end;return dc end,getTextVerticalAlign=function(dc,_d)
local ad=0
if(_d=="center")then ad=math.ceil(dc/2)if(ad<1)then ad=1 end end;if(_d=="bottom")then ad=dc end;if(ad<1)then ad=1 end;return ad end,orderedTable=function(dc)
local _d={}for ad,bd in pairs(dc)do _d[#_d+1]=bd end;return _d end,rpairs=function(dc)return function(_d,ad)ad=
ad-1;if ad~=0 then return ad,_d[ad]end end,dc,
#dc+1 end,tableCount=function(dc)
local _d=0;if(dc~=nil)then for ad,bd in pairs(dc)do _d=_d+1 end end;return _d end,splitString=cc,wrapText=function(dc,_d)
local ad=cc(dc,"\n")local bd={}
for cd,dd in pairs(ad)do if(#dd==0)then table.insert(bd,"")end
while
#dd>_d do local __a=cb(db(bb(dd,1,_d))," ")
if not __a then __a=_d else __a=_d-__a end;local a_a=bb(dd,1,__a)table.insert(bd,a_a)dd=bb(dd,__a+1)end;if#dd>0 then table.insert(bd,dd)end end;return bd end,xmlValue=function(dc,_d)
local ad;if(type(_d)~="table")then return end;if(_d[dc]~=nil)then
if
(type(_d[dc])=="table")then if(_d[dc].value~=nil)then ad=_d[dc]:value()end end end;if(ad==nil)then
ad=_d["@"..dc]end;if(ad=="true")then ad=true elseif(ad=="false")then ad=false elseif(tonumber(ad)~=nil)then
ad=tonumber(ad)end;return ad end,uuid=function()
return
string.gsub(string.format('%x-%x-%x-%x-%x',math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff),
math.random(0,0x0fff)+0x4000,math.random(0,0x3fff)+0x8000),' ','0')end}end
ba["libraries"]["basaltLogs"]=function(...)local bb=""local cb="basaltLog.txt"local db="Debug"
fs.delete(
bb~=""and bb.."/"..cb or cb)
local _c={__call=function(ac,bc,cc)if(bc==nil)then return end
local dc=bb~=""and bb.."/"..cb or cb
local _d=fs.open(dc,fs.exists(dc)and"a"or"w")
_d.writeLine("[Basalt]["..
os.date("%Y-%m-%d %H:%M:%S").."][".. (cc and cc or db)..
"]: "..tostring(bc))_d.close()end}return setmetatable({},_c)end
ba["libraries"]["module"]=function(...)return function(bb)local cb,db=pcall(_b,bb)
return cb and db or nil end end
ba["libraries"]["bimg"]=function(...)local bb,cb=string.sub,string.rep
local function db(_c,ac)local bc,cc=0,0
local dc,_d,ad={},{},{}local bd,cd=1,1;local dd={}
local function __a()
for y=1,cc do if(dc[y]==nil)then dc[y]=cb(" ",bc)else dc[y]=dc[y]..
cb(" ",bc-#dc[y])end;if
(_d[y]==nil)then _d[y]=cb("0",bc)else
_d[y]=_d[y]..cb("0",bc-#_d[y])end
if(ad[y]==nil)then ad[y]=cb("f",bc)else ad[y]=
ad[y]..cb("f",bc-#ad[y])end end end
local a_a=function(_aa,aaa,baa)bd=aaa or bd;cd=baa or cd
if(dc[cd]==nil)then dc[cd]=cb(" ",bd-1).._aa..
cb(" ",bc- (#_aa+bd))else dc[cd]=
bb(dc[cd],1,bd-1)..
cb(" ",bd-#dc[cd]).._aa..bb(dc[cd],bd+#_aa,bc)end;if(#dc[cd]>bc)then bc=#dc[cd]end;if(cd>cc)then cc=cd end
ac.updateSize(bc,cc)end
local b_a=function(_aa,aaa,baa)bd=aaa or bd;cd=baa or cd
if(ad[cd]==nil)then ad[cd]=cb("f",bd-1).._aa..
cb("f",bc- (#_aa+bd))else ad[cd]=
bb(ad[cd],1,bd-1)..
cb("f",bd-#ad[cd]).._aa..bb(ad[cd],bd+#_aa,bc)end;if(#ad[cd]>bc)then bc=#ad[cd]end;if(cd>cc)then cc=cd end
ac.updateSize(bc,cc)end
local c_a=function(_aa,aaa,baa)bd=aaa or bd;cd=baa or cd
if(_d[cd]==nil)then _d[cd]=cb("0",bd-1).._aa..
cb("0",bc- (#_aa+bd))else _d[cd]=
bb(_d[cd],1,bd-1)..
cb("0",bd-#_d[cd]).._aa..bb(_d[cd],bd+#_aa,bc)end;if(#_d[cd]>bc)then bc=#_d[cd]end;if(cd>cc)then cc=cd end
ac.updateSize(bc,cc)end
local function d_a(_aa)dd={}dc,_d,ad={},{},{}
for aaa,baa in pairs(_c)do if(type(aaa)=="string")then dd[aaa]=baa else
dc[aaa],_d[aaa],ad[aaa]=baa[1],baa[2],baa[3]end end;ac.updateSize(bc,cc)end
if(_c~=nil)then if(#_c>0)then bc=#_c[1][1]cc=#_c;d_a(_c)end end
return
{recalculateSize=__a,setFrame=d_a,getFrame=function()local _aa={}for aaa,baa in pairs(dc)do
table.insert(_aa,{baa,_d[aaa],ad[aaa]})end
for aaa,baa in pairs(dd)do _aa[aaa]=baa end;return _aa,bc,cc end,getImage=function()
local _aa={}for aaa,baa in pairs(dc)do
table.insert(_aa,{baa,_d[aaa],ad[aaa]})end;return _aa end,setFrameData=function(_aa,aaa)
if(
aaa~=nil)then dd[_aa]=aaa else if(type(_aa)=="table")then dd=_aa end end end,setFrameImage=function(_aa)
for aaa,baa in pairs(_aa.t)do
dc[aaa]=_aa.t[aaa]_d[aaa]=_aa.fg[aaa]ad[aaa]=_aa.bg[aaa]end end,getFrameImage=function()
return{t=dc,fg=_d,bg=ad}end,getFrameData=function(_aa)if(_aa~=nil)then return dd[_aa]else return dd end end,blit=function(_aa,aaa,baa,caa,daa)
a_a(_aa,caa,daa)c_a(aaa,caa,daa)b_a(baa,caa,daa)end,text=a_a,fg=c_a,bg=b_a,getSize=function()return
bc,cc end,setSize=function(_aa,aaa)local baa,caa,daa={},{},{}
for _y=1,aaa do
if(dc[_y]~=nil)then baa[_y]=bb(dc[_y],1,_aa)..cb(" ",
_aa-bc)else baa[_y]=cb(" ",_aa)end;if(_d[_y]~=nil)then
caa[_y]=bb(_d[_y],1,_aa)..cb("0",_aa-bc)else caa[_y]=cb("0",_aa)end;if
(ad[_y]~=nil)then daa[_y]=bb(ad[_y],1,_aa)..cb("f",_aa-bc)else
daa[_y]=cb("f",_aa)end end;dc,_d,ad=baa,caa,daa;bc,cc=_aa,aaa end}end
return
function(_c)local ac={}
local bc={creator="Bimg Library by NyoriE",date=os.date("!%Y-%m-%dT%TZ")}local cc,dc=0,0;local _d={}
local function ad(dd,__a)dd=dd or#ac+1;local a_a=db(__a,_d)
table.insert(ac,dd,a_a)if(__a==nil)then ac[dd].setSize(cc,dc)end;return a_a end;local function bd(dd)table.remove(ac,dd or#ac)end
local function cd(dd,__a)
local a_a=ac[dd]
if(a_a~=nil)then local b_a=dd+__a;if(b_a>=1)and(b_a<=#ac)then
table.remove(ac,dd)table.insert(ac,b_a,a_a)end end end
_d={updateSize=function(dd,__a,a_a)local b_a=a_a==true and true or false
if(dd>cc)then b_a=true;cc=dd end;if(__a>dc)then b_a=true;dc=__a end
if(b_a)then for c_a,d_a in pairs(ac)do d_a.setSize(cc,dc)
d_a.recalculateSize()end end end,text=function(dd,__a,a_a,b_a)
local c_a=ac[dd]if(c_a==nil)then c_a=ad(dd)end;c_a.text(__a,a_a,b_a)end,fg=function(dd,__a,a_a,b_a)
local c_a=ac[dd]if(c_a==nil)then c_a=ad(dd)end;c_a.fg(__a,a_a,b_a)end,bg=function(dd,__a,a_a,b_a)
local c_a=ac[dd]if(c_a==nil)then c_a=ad(dd)end;c_a.bg(__a,a_a,b_a)end,blit=function(dd,__a,a_a,b_a,c_a,d_a)
local _aa=ac[dd]if(_aa==nil)then _aa=ad(dd)end
_aa.blit(__a,a_a,b_a,c_a,d_a)end,setSize=function(dd,__a)cc=dd;dc=__a;for a_a,b_a in pairs(ac)do
b_a.setSize(dd,__a)end end,getFrame=function(dd)if
(ac[dd]~=nil)then return ac[dd].getFrame()end end,getFrameObjects=function()return
ac end,getFrames=function()local dd={}for __a,a_a in pairs(ac)do local b_a=a_a.getFrame()
table.insert(dd,b_a)end;return dd end,getFrameObject=function(dd)return
ac[dd]end,addFrame=function(dd)if(#ac<=1)then
if(bc.animated==nil)then bc.animated=true end
if(bc.secondsPerFrame==nil)then bc.secondsPerFrame=0.2 end end;return ad(dd)end,removeFrame=bd,moveFrame=cd,setFrameData=function(dd,__a,a_a)
if(
ac[dd]~=nil)then ac[dd].setFrameData(__a,a_a)end end,getFrameData=function(dd,__a)if(ac[dd]~=nil)then return
ac[dd].getFrameData(__a)end end,getSize=function()return
cc,dc end,setAnimation=function(dd)bc.animation=dd end,setMetadata=function(dd,__a)if(__a~=nil)then bc[dd]=__a else if(
type(dd)=="table")then bc=dd end end end,getMetadata=function(dd)if(
dd~=nil)then return bc[dd]else return bc end end,createBimg=function()
local dd={}
for __a,a_a in pairs(ac)do local b_a=a_a.getFrame()table.insert(dd,b_a)end;for __a,a_a in pairs(bc)do dd[__a]=a_a end;dd.width=cc;dd.height=dc;return dd end}
if(_c~=nil)then for dd,__a in pairs(_c)do
if(type(dd)=="string")then bc[dd]=__a else ad(dd,__a)end end
if
(bc.width==nil)or(bc.height==nil)then for dd,__a in pairs(ac)do local a_a,b_a=__a.getSize()if(a_a>cc)then a_a=cc end
if(b_a>dc)then b_a=dc end end
_d.updateSize(cc,dc,true)end else ad(1)end;return _d end end
ba["libraries"]["process"]=function(...)local bb={}local cb={}local db=0
local _c=dofile("rom/modules/main/cc/require.lua").make
function cb:new(ac,bc,cc,...)local dc={...}
local _d=setmetatable({path=ac},{__index=self})_d.window=bc;bc.current=term.current;bc.redirect=term.redirect
_d.processId=db
if(type(ac)=="string")then
_d.coroutine=coroutine.create(function()
local ad=shell.resolveProgram(ac)local bd=setmetatable(cc,{__index=_ENV})bd.shell=shell
bd.basaltProgram=true;bd.arg={[0]=ac,table.unpack(dc)}
bd.require,bd.package=_c(bd,fs.getDir(ad))
if(fs.exists(ad))then local cd=fs.open(ad,"r")local dd=cd.readAll()
cd.close()local __a=load(dd,ac,"bt",bd)if(__a~=nil)then return __a()end end end)elseif(type(ac)=="function")then
_d.coroutine=coroutine.create(function()
ac(table.unpack(dc))end)else return end;bb[db]=_d;db=db+1;return _d end
function cb:resume(ac,...)local bc=term.current()term.redirect(self.window)
if(
self.filter~=nil)then if(ac~=self.filter)then return end;self.filter=nil end;local cc,dc=coroutine.resume(self.coroutine,ac,...)if cc then
self.filter=dc else printError(dc)end;term.redirect(bc)
return cc,dc end
function cb:isDead()
if(self.coroutine~=nil)then
if
(coroutine.status(self.coroutine)=="dead")then table.remove(bb,self.processId)return true end else return true end;return false end
function cb:getStatus()if(self.coroutine~=nil)then
return coroutine.status(self.coroutine)end;return nil end
function cb:start()coroutine.resume(self.coroutine)end;return cb end
ba["libraries"]["tHex"]=function(...)local bb={}
for i=0,15 do bb[2 ^i]=("%x"):format(i)end;return bb end
ba["libraries"]["basaltMon"]=function(...)
local bb={[colors.white]="0",[colors.orange]="1",[colors.magenta]="2",[colors.lightBlue]="3",[colors.yellow]="4",[colors.lime]="5",[colors.pink]="6",[colors.gray]="7",[colors.lightGray]="8",[colors.cyan]="9",[colors.purple]="a",[colors.blue]="b",[colors.brown]="c",[colors.green]="d",[colors.red]="e",[colors.black]="f"}local cb,db,_c,ac=type,string.len,string.rep,string.sub
return
function(bc)local cc={}
for aba,bba in pairs(bc)do
cc[aba]={}
for cba,dba in pairs(bba)do local _ca=peripheral.wrap(dba)if(_ca==nil)then
error("Unable to find monitor "..dba)end;cc[aba][cba]=_ca
cc[aba][cba].name=dba end end;local dc,_d,ad,bd,cd,dd,__a,a_a=1,1,1,1,0,0,0,0;local b_a,c_a=false,1
local d_a,_aa=colors.white,colors.black
local function aaa()local aba,bba=0,0
for cba,dba in pairs(cc)do local _ca,aca=0,0
for bca,cca in pairs(dba)do local dca,_da=cca.getSize()
_ca=_ca+dca;aca=_da>aca and _da or aca end;aba=aba>_ca and aba or _ca;bba=bba+aca end;__a,a_a=aba,bba end;aaa()
local function baa()local aba=0;local bba,cba=0,0
for dba,_ca in pairs(cc)do local aca=0;local bca=0
for cca,dca in pairs(_ca)do
local _da,ada=dca.getSize()if(dc-aca>=1)and(dc-aca<=_da)then bba=cca end;dca.setCursorPos(
dc-aca,_d-aba)aca=aca+_da
if(bca<ada)then bca=ada end end;if(_d-aba>=1)and(_d-aba<=bca)then cba=dba end
aba=aba+bca end;ad,bd=bba,cba end;baa()
local function caa(aba,...)local bba={...}return
function()for cba,dba in pairs(cc)do for _ca,aca in pairs(dba)do
aca[aba](table.unpack(bba))end end end end
local function daa()caa("setCursorBlink",false)()
if not(b_a)then return end;if(cc[bd]==nil)then return end;local aba=cc[bd][ad]
if(aba==nil)then return end;aba.setCursorBlink(b_a)end
local function _ba(aba,bba,cba)if(cc[bd]==nil)then return end;local dba=cc[bd][ad]
if(dba==nil)then return end;dba.blit(aba,bba,cba)local _ca,aca=dba.getSize()
if
(db(aba)+dc>_ca)then local bca=cc[bd][ad+1]if(bca~=nil)then bca.blit(aba,bba,cba)ad=ad+1;dc=dc+
db(aba)end end;baa()end
return
{clear=caa("clear"),setCursorBlink=function(aba)b_a=aba;daa()end,getCursorBlink=function()return b_a end,getCursorPos=function()return dc,_d end,setCursorPos=function(aba,bba)
dc,_d=aba,bba;baa()daa()end,setTextScale=function(aba)
caa("setTextScale",aba)()aaa()baa()c_a=aba end,getTextScale=function()return c_a end,blit=function(aba,bba,cba)
_ba(aba,bba,cba)end,write=function(aba)aba=tostring(aba)local bba=db(aba)
_ba(aba,_c(bb[d_a],bba),_c(bb[_aa],bba))end,getSize=function()return __a,a_a end,setBackgroundColor=function(aba)
caa("setBackgroundColor",aba)()_aa=aba end,setTextColor=function(aba)
caa("setTextColor",aba)()d_a=aba end,calculateClick=function(aba,bba,cba)local dba=0
for _ca,aca in pairs(cc)do local bca=0;local cca=0
for dca,_da in pairs(aca)do
local ada,bda=_da.getSize()if(_da.name==aba)then return bba+bca,cba+dba end
bca=bca+ada;if(bda>cca)then cca=bda end end;dba=dba+cca end;return bba,cba end}end end
ba["libraries"]["images"]=function(...)local bb,cb=string.sub,math.floor;local function db(bd)return
{[1]={{},{},paintutils.loadImage(bd)}},"bimg"end;local function _c(bd)return
paintutils.loadImage(bd),"nfp"end
local function ac(bd,cd)
local dd=fs.open(bd,cd and"rb"or"r")if(dd==nil)then
error("Path - "..bd.." doesn't exist!")end
local __a=textutils.unserialize(dd.readAll())dd.close()if(__a~=nil)then return __a,"bimg"end end;local function bc(bd)end;local function cc(bd)end;local function dc(bd,cd,dd)
if(bb(bd,-4)==".bimg")then return ac(bd,dd)elseif
(bb(bd,-3)==".bbf")then return bc(bd,dd)else return _c(bd,dd)end end;local function _d(bd)
if
(bd:find(".bimg"))then return ac(bd)elseif(bd:find(".bbf"))then return cc(bd)else return db(bd)end end
local function ad(bd,cd,dd)local __a,a_a=bd.width or#
bd[1][1][1],bd.height or#bd[1]
local b_a={}
for c_a,d_a in pairs(bd)do
if(type(c_a)=="number")then local _aa={}
for y=1,dd do local aaa,baa,caa="","",""
local daa=cb(y/dd*a_a+0.5)
if(d_a[daa]~=nil)then
for x=1,cd do local _ba=cb(x/cd*__a+0.5)aaa=aaa..
bb(d_a[daa][1],_ba,_ba)
baa=baa..bb(d_a[daa][2],_ba,_ba)caa=caa..bb(d_a[daa][3],_ba,_ba)end;table.insert(_aa,{aaa,baa,caa})end end;table.insert(b_a,c_a,_aa)else b_a[c_a]=d_a end end;b_a.width=cd;b_a.height=dd;return b_a end
return{loadNFP=_c,loadBIMG=ac,loadImage=dc,resizeBIMG=ad,loadImageAsBimg=_d}end
ba["libraries"]["basaltDraw"]=function(...)local bb=_b("tHex")local cb=_b("utils")
local db=cb.splitString;local _c,ac=string.sub,string.rep
return
function(bc)local cc=bc or term.current()
local dc;local _d,ad=cc.getSize()local bd={}local cd={}local dd={}local __a;local a_a={}
local function b_a()__a=ac(" ",_d)for n=0,15 do
local daa=2 ^n;local _ba=bb[daa]a_a[daa]=ac(_ba,_d)end end;b_a()
local function c_a()b_a()local daa=__a;local _ba=a_a[colors.white]
local aba=a_a[colors.black]
for currentY=1,ad do
bd[currentY]=_c(bd[currentY]==nil and daa or bd[currentY]..daa:sub(1,_d-
bd[currentY]:len()),1,_d)
dd[currentY]=_c(dd[currentY]==nil and _ba or dd[currentY].._ba:sub(1,_d-
dd[currentY]:len()),1,_d)
cd[currentY]=_c(cd[currentY]==nil and aba or cd[currentY]..aba:sub(1,_d-
cd[currentY]:len()),1,_d)end end;c_a()
local function d_a(daa,_ba,aba,bba,cba)
if#aba==#bba and#aba==#cba then
if _ba>=1 and _ba<=ad then
if
daa+#aba>0 and daa<=_d then local dba,_ca,aca;local bca,cca,dca=bd[_ba],dd[_ba],cd[_ba]
local _da,ada=1,#aba
if daa<1 then _da=1 -daa+1;ada=_d-daa+1 elseif daa+#aba>_d then ada=_d-daa+1 end;dba=_c(bca,1,daa-1).._c(aba,_da,ada)_ca=
_c(cca,1,daa-1).._c(bba,_da,ada)aca=_c(dca,1,daa-1)..
_c(cba,_da,ada)
if daa+#aba<=_d then dba=dba..
_c(bca,daa+#aba,_d)
_ca=_ca.._c(cca,daa+#aba,_d)aca=aca.._c(dca,daa+#aba,_d)end;bd[_ba],dd[_ba],cd[_ba]=dba,_ca,aca end end end end
local function _aa(daa,_ba,aba)
if _ba>=1 and _ba<=ad then
if daa+#aba>0 and daa<=_d then local bba;local cba=bd[_ba]
local dba,_ca=1,#aba
if daa<1 then dba=1 -daa+1;_ca=_d-daa+1 elseif daa+#aba>_d then _ca=_d-daa+1 end;bba=_c(cba,1,daa-1).._c(aba,dba,_ca)
if
daa+#aba<=_d then bba=bba.._c(cba,daa+#aba,_d)end;bd[_ba]=bba end end end
local function aaa(daa,_ba,aba)
if _ba>=1 and _ba<=ad then
if daa+#aba>0 and daa<=_d then local bba;local cba=cd[_ba]
local dba,_ca=1,#aba
if daa<1 then dba=1 -daa+1;_ca=_d-daa+1 elseif daa+#aba>_d then _ca=_d-daa+1 end;bba=_c(cba,1,daa-1).._c(aba,dba,_ca)
if
daa+#aba<=_d then bba=bba.._c(cba,daa+#aba,_d)end;cd[_ba]=bba end end end
local function baa(daa,_ba,aba)
if _ba>=1 and _ba<=ad then
if daa+#aba>0 and daa<=_d then local bba;local cba=dd[_ba]
local dba,_ca=1,#aba
if daa<1 then dba=1 -daa+1;_ca=_d-daa+1 elseif daa+#aba>_d then _ca=_d-daa+1 end;bba=_c(cba,1,daa-1).._c(aba,dba,_ca)
if
daa+#aba<=_d then bba=bba.._c(cba,daa+#aba,_d)end;dd[_ba]=bba end end end
local caa={setSize=function(daa,_ba)_d,ad=daa,_ba;c_a()end,setMirror=function(daa)dc=daa end,setBG=function(daa,_ba,aba)
aaa(daa,_ba,aba)end,setText=function(daa,_ba,aba)_aa(daa,_ba,aba)end,setFG=function(daa,_ba,aba)
baa(daa,_ba,aba)end,blit=function(daa,_ba,aba,bba,cba)d_a(daa,_ba,aba,bba,cba)end,drawBackgroundBox=function(daa,_ba,aba,bba,cba)
local dba=ac(bb[cba],aba)for n=1,bba do aaa(daa,_ba+ (n-1),dba)end end,drawForegroundBox=function(daa,_ba,aba,bba,cba)
local dba=ac(bb[cba],aba)for n=1,bba do baa(daa,_ba+ (n-1),dba)end end,drawTextBox=function(daa,_ba,aba,bba,cba)
local dba=ac(cba,aba)for n=1,bba do _aa(daa,_ba+ (n-1),dba)end end,update=function()
local daa,_ba=cc.getCursorPos()local aba=false
if(cc.getCursorBlink~=nil)then aba=cc.getCursorBlink()end;cc.setCursorBlink(false)if(dc~=nil)then
dc.setCursorBlink(false)end
for n=1,ad do cc.setCursorPos(1,n)
cc.blit(bd[n],dd[n],cd[n])if(dc~=nil)then dc.setCursorPos(1,n)
dc.blit(bd[n],dd[n],cd[n])end end;cc.setBackgroundColor(colors.black)
cc.setCursorBlink(aba)cc.setCursorPos(daa,_ba)
if(dc~=nil)then
dc.setBackgroundColor(colors.black)dc.setCursorBlink(aba)dc.setCursorPos(daa,_ba)end end,setTerm=function(daa)
cc=daa end}return caa end end
ba["libraries"]["basaltEvent"]=function(...)
return
function()local bb={}
local cb={registerEvent=function(db,_c,ac)
if(bb[_c]==nil)then bb[_c]={}end;table.insert(bb[_c],ac)end,removeEvent=function(db,_c,ac)bb[_c][ac[_c]]=
nil end,hasEvent=function(db,_c)return bb[_c]~=nil end,getEventCount=function(db,_c)return
bb[_c]~=nil and#bb[_c]or 0 end,getEvents=function(db)
local _c={}for ac,bc in pairs(bb)do table.insert(_c,ac)end;return _c end,clearEvent=function(db,_c)bb[_c]=
nil end,clear=function(db,_c)bb={}end,sendEvent=function(db,_c,...)local ac
if(bb[_c]~=nil)then for bc,cc in pairs(bb[_c])do
local dc=cc(...)if(dc==false)then ac=dc end end end;return ac end}cb.__index=cb;return cb end end
ba["loadObjects"]=function(...)local bb={}if(ca)then
for _c,ac in pairs(ab("objects"))do bb[_c]=ac()end;return bb end;local cb=table.pack(...)local db=fs.getDir(
cb[2]or"Basalt")if(db==nil)then
error("Unable to find directory "..cb[2]..
" please report this bug to our discord.")end
for _c,ac in
pairs(fs.list(fs.combine(db,"objects")))do if(ac~="example.lua")and not(ac:find(".disabled"))then
local bc=ac:gsub(".lua","")bb[bc]=_b(bc)end end;return bb end;ba["plugins"]={}
ba["plugins"]["animations"]=function(...)
local bb,cb,db,_c,ac,bc=math.floor,math.sin,math.cos,math.pi,math.sqrt,math.pow;local function cc(cab,dab,_bb)return cab+ (dab-cab)*_bb end
local function dc(cab)return cab end;local function _d(cab)return 1 -cab end
local function ad(cab)return cab*cab*cab end;local function bd(cab)return _d(ad(_d(cab)))end;local function cd(cab)return
cc(ad(cab),bd(cab),cab)end
local function dd(cab)return cb((cab*_c)/2)end;local function __a(cab)return _d(db((cab*_c)/2))end;local function a_a(cab)return- (
db(_c*x)-1)/2 end
local function b_a(cab)local dab=1.70158
local _bb=dab+1;return _bb*cab^3 -dab*cab^2 end;local function c_a(cab)return cab^3 end;local function d_a(cab)local dab=(2 *_c)/3
return cab==0 and 0 or(cab==1 and 1 or
(-2 ^ (10 *
cab-10)*cb((cab*10 -10.75)*dab)))end
local function _aa(cab)return
cab==0 and 0 or 2 ^ (10 *cab-10)end
local function aaa(cab)return cab==0 and 0 or 2 ^ (10 *cab-10)end
local function baa(cab)local dab=1.70158;local _bb=dab*1.525;return
cab<0.5 and( (2 *cab)^2 *
( (_bb+1)*2 *cab-_bb))/2 or
(
(2 *cab-2)^2 * ( (_bb+1)* (cab*2 -2)+_bb)+2)/2 end;local function caa(cab)return
cab<0.5 and 4 *cab^3 or 1 - (-2 *cab+2)^3 /2 end
local function daa(cab)
local dab=(2 *_c)/4.5
return
cab==0 and 0 or(cab==1 and 1 or
(
cab<0.5 and- (2 ^ (20 *cab-10)*
cb((20 *cab-11.125)*dab))/2 or
(2 ^ (-20 *cab+10)*cb((20 *cab-11.125)*dab))/2 +1))end
local function _ba(cab)return
cab==0 and 0 or(cab==1 and 1 or
(
cab<0.5 and 2 ^ (20 *cab-10)/2 or(2 -2 ^ (-20 *cab+10))/2))end;local function aba(cab)return
cab<0.5 and 2 *cab^2 or 1 - (-2 *cab+2)^2 /2 end;local function bba(cab)return
cab<0.5 and 8 *
cab^4 or 1 - (-2 *cab+2)^4 /2 end;local function cba(cab)return
cab<0.5 and 16 *
cab^5 or 1 - (-2 *cab+2)^5 /2 end;local function dba(cab)
return cab^2 end;local function _ca(cab)return cab^4 end
local function aca(cab)return cab^5 end;local function bca(cab)local dab=1.70158;local _bb=dab+1;return
1 +_bb* (cab-1)^3 +dab* (cab-1)^2 end;local function cca(cab)return 1 -
(1 -cab)^3 end
local function dca(cab)local dab=(2 *_c)/3;return

cab==0 and 0 or(cab==1 and 1 or(
2 ^ (-10 *cab)*cb((cab*10 -0.75)*dab)+1))end
local function _da(cab)return cab==1 and 1 or 1 -2 ^ (-10 *cab)end;local function ada(cab)return 1 - (1 -cab)* (1 -cab)end;local function bda(cab)return 1 - (
1 -cab)^4 end;local function cda(cab)
return 1 - (1 -cab)^5 end
local function dda(cab)return 1 -ac(1 -bc(cab,2))end;local function __b(cab)return ac(1 -bc(cab-1,2))end
local function a_b(cab)return

cab<0.5 and(1 -ac(
1 -bc(2 *cab,2)))/2 or(ac(1 -bc(-2 *cab+2,2))+1)/2 end
local function b_b(cab)local dab=7.5625;local _bb=2.75
if(cab<1 /_bb)then return dab*cab*cab elseif(cab<2 /_bb)then local abb=cab-
1.5 /_bb;return dab*abb*abb+0.75 elseif(cab<2.5 /_bb)then local abb=cab-
2.25 /_bb;return dab*abb*abb+0.9375 else
local abb=cab-2.625 /_bb;return dab*abb*abb+0.984375 end end;local function c_b(cab)return 1 -b_b(1 -cab)end;local function d_b(cab)return
x<0.5 and(1 -
b_b(1 -2 *cab))/2 or(1 +b_b(2 *cab-1))/2 end
local _ab={linear=dc,lerp=cc,flip=_d,easeIn=ad,easeInSine=__a,easeInBack=b_a,easeInCubic=c_a,easeInElastic=d_a,easeInExpo=aaa,easeInQuad=dba,easeInQuart=_ca,easeInQuint=aca,easeInCirc=dda,easeInBounce=c_b,easeOut=bd,easeOutSine=dd,easeOutBack=bca,easeOutCubic=cca,easeOutElastic=dca,easeOutExpo=_da,easeOutQuad=ada,easeOutQuart=bda,easeOutQuint=cda,easeOutCirc=__b,easeOutBounce=b_b,easeInOut=cd,easeInOutSine=a_a,easeInOutBack=baa,easeInOutCubic=caa,easeInOutElastic=daa,easeInOutExpo=_ba,easeInOutQuad=aba,easeInOutQuart=bba,easeInOutQuint=cba,easeInOutCirc=a_b,easeInOutBounce=d_b}local aab=_b("utils")local bab=aab.xmlValue
return
{VisualObject=function(cab,dab)local _bb={}local abb="linear"
local function bbb(_cb,acb)for bcb,ccb in pairs(_bb)do if(ccb.timerId==
acb)then return ccb end end end
local function cbb(_cb,acb,bcb,ccb,dcb,_db,adb,bdb,cdb,ddb)local __c,a_c=cdb(_cb)if(_bb[adb]~=nil)then
os.cancelTimer(_bb[adb].timerId)end;_bb[adb]={}
_bb[adb].call=function()
local b_c=_bb[adb].progress
local c_c=math.floor(_ab.lerp(__c,acb,_ab[_db](b_c/ccb))+0.5)
local d_c=math.floor(_ab.lerp(a_c,bcb,_ab[_db](b_c/ccb))+0.5)ddb(_cb,c_c,d_c)end
_bb[adb].finished=function()ddb(_cb,acb,bcb)if(bdb~=nil)then bdb(_cb)end end;_bb[adb].timerId=os.startTimer(0.05 +dcb)
_bb[adb].progress=0;_bb[adb].duration=ccb;_bb[adb].mode=_db
_cb:listenEvent("other_event")end
local dbb={animatePosition=function(_cb,acb,bcb,ccb,dcb,_db,adb)_db=_db or abb;ccb=ccb or 1;dcb=dcb or 0
acb=math.floor(acb+0.5)bcb=math.floor(bcb+0.5)
cbb(_cb,acb,bcb,ccb,dcb,_db,"position",adb,_cb.getPosition,_cb.setPosition)return _cb end,animateSize=function(_cb,acb,bcb,ccb,dcb,_db,adb)_db=
_db or abb;ccb=ccb or 1;dcb=dcb or 0
cbb(_cb,acb,bcb,ccb,dcb,_db,"size",adb,_cb.getSize,_cb.setSize)return _cb end,animateOffset=function(_cb,acb,bcb,ccb,dcb,_db,adb)_db=
_db or abb;ccb=ccb or 1;dcb=dcb or 0
cbb(_cb,acb,bcb,ccb,dcb,_db,"offset",adb,_cb.getOffset,_cb.setOffset)return _cb end,doneHandler=function(_cb,acb,...)
for bcb,ccb in
pairs(_bb)do if(ccb.timerId==acb)then _bb[bcb]=nil
_cb:sendEvent("animation_done",_cb,"animation_done",bcb)end end end,onAnimationDone=function(_cb,...)
for acb,bcb in
pairs(table.pack(...))do if(type(bcb)=="function")then
_cb:registerEvent("animation_done",bcb)end end;return _cb end,eventHandler=function(_cb,acb,bcb,...)
cab.eventHandler(_cb,acb,bcb,...)
if(acb=="timer")then local ccb=bbb(_cb,bcb)
if(ccb~=nil)then
if(ccb.progress<ccb.duration)then
ccb.call()ccb.progress=ccb.progress+0.05
ccb.timerId=os.startTimer(0.05)else ccb.finished()_cb:doneHandler(bcb)end end end end,setValuesByXMLData=function(_cb,acb,bcb)
cab.setValuesByXMLData(_cb,acb,bcb)
local ccb,dcb,_db,adb,bdb=bab("animateX",acb),bab("animateY",acb),bab("animateDuration",acb),bab("animateTimeOffset",acb),bab("animateMode",acb)
local cdb,ddb,__c,a_c,b_c=bab("animateW",acb),bab("animateH",acb),bab("animateDuration",acb),bab("animateTimeOffset",acb),bab("animateMode",acb)
local c_c,d_c,_ac,aac,bac=bab("animateXOffset",acb),bab("animateYOffset",acb),bab("animateDuration",acb),bab("animateTimeOffset",acb),bab("animateMode",acb)if(ccb~=nil and dcb~=nil)then
_cb:animatePosition(ccb,dcb,_ac,aac,bac)end;if(cdb~=nil and ddb~=nil)then
_cb:animateSize(cdb,ddb,_ac,aac,bac)end;if(c_c~=nil and d_c~=nil)then
_cb:animateOffset(c_c,d_c,_ac,aac,bac)end;return _cb end}return dbb end}end
ba["plugins"]["advancedBackground"]=function(...)local bb=_b("utils")
local cb=bb.xmlValue
return
{VisualObject=function(db)local _c=false;local ac=colors.black
local bc={setBackground=function(cc,dc,_d,ad)db.setBackground(cc,dc)
_c=_d or _c;ac=ad or ac;return cc end,setBackgroundSymbol=function(cc,dc,_d)_c=dc
ac=_d or ac;cc:updateDraw()return cc end,getBackgroundSymbol=function(cc)return _c end,getBackgroundSymbolColor=function(cc)return
ac end,setValuesByXMLData=function(cc,dc,_d)db.setValuesByXMLData(cc,dc,_d)if(
cb("background-symbol",dc)~=nil)then
cc:setBackgroundSymbol(cb("background-symbol",dc),cb("background-symbol-color",dc))end;return cc end,draw=function(cc)
db.draw(cc)
cc:addDraw("advanced-bg",function()local dc,_d=cc:getSize()if(_c~=false)then
cc:addTextBox(1,1,dc,_d,_c:sub(1,1))
if(_c~=" ")then cc:addForegroundBox(1,1,dc,_d,ac)end end end,2)end}return bc end}end
ba["plugins"]["pixelbox"]=function(...)
local bb,cb,db=table.sort,table.concat,string.char;local function _c(_d,ad)return _d[2]>ad[2]end
local ac={{5,256,16,8,64,32},{4,16,16384,256,128},[4]={4,64,1024,256,128},[8]={4,512,2048,256,1},[16]={4,2,16384,256,1},[32]={4,8192,4096,256,1},[64]={4,4,1024,256,1},[128]={6,32768,256,1024,2048,4096,16384},[256]={6,1,128,2,512,4,8192},[512]={4,8,2048,256,128},[1024]={4,4,64,128,32768},[2048]={4,512,8,128,32768},[4096]={4,8192,32,128,32768},[8192]={3,32,4096,256128},[16384]={4,2,16,128,32768},[32768]={5,128,1024,2048,4096,16384}}local bc={}for i=0,15 do bc[("%x"):format(i)]=2 ^i end
local cc={}for i=0,15 do cc[2 ^i]=("%x"):format(i)end
local function dc(_d,ad)ad=ad or"f"local bd,cd=#
_d[1],#_d;local dd={}local __a={}local a_a=false
local function b_a()
for y=1,cd*3 do for x=1,bd*2 do
if not __a[y]then __a[y]={}end;__a[y][x]=ad end end;for aaa,baa in ipairs(_d)do
for x=1,#baa do local caa=baa:sub(x,x)__a[aaa][x]=bc[caa]end end end;b_a()local function c_a(aaa,baa)bd,cd=aaa,baa;__a={}a_a=false;b_a()end
local function d_a(aaa,baa,caa,daa,_ba,aba)
local bba={aaa,baa,caa,daa,_ba,aba}local cba={}local dba={}local _ca=0
for i=1,6 do local dca=bba[i]if not cba[dca]then _ca=_ca+1
cba[dca]={0,_ca}end;local _da=cba[dca]local ada=_da[1]+1;_da[1]=ada
dba[_da[2]]={dca,ada}end;local aca=#dba
while aca>2 do bb(dba,_c)local dca=ac[dba[aca][1]]
local _da,ada=1,false;local bda=aca-1
for i=2,dca[1]do if ada then break end;local __b=dca[i]for j=1,bda do if dba[j][1]==__b then _da=j
ada=true;break end end end;local cda,dda=dba[aca][1],dba[_da][1]
for i=1,6 do if bba[i]==cda then bba[i]=dda
local __b=dba[_da]__b[2]=__b[2]+1 end end;dba[aca]=nil;aca=aca-1 end;local bca=128;local cca=bba[6]if bba[1]~=cca then bca=bca+1 end;if bba[2]~=cca then bca=bca+
2 end;if bba[3]~=cca then bca=bca+4 end;if
bba[4]~=cca then bca=bca+8 end;if bba[5]~=cca then bca=bca+16 end;if
dba[1][1]==bba[6]then return db(bca),dba[2][1],bba[6]else
return db(bca),dba[1][1],bba[6]end end
local function _aa()local aaa=bd*2;local baa=0
for y=1,cd*3,3 do baa=baa+1;local caa=__a[y]local daa=__a[y+1]
local _ba=__a[y+2]local aba,bba,cba={},{},{}local dba=0
for x=1,aaa,2 do local _ca=x+1
local aca,bca,cca,dca,_da,ada=caa[x],caa[_ca],daa[x],daa[_ca],_ba[x],_ba[_ca]local bda,cda,dda=" ",1,aca;if not(
bca==aca and cca==aca and dca==aca and _da==aca and ada==aca)then
bda,cda,dda=d_a(aca,bca,cca,dca,_da,ada)end;dba=dba+1
aba[dba]=bda;bba[dba]=cc[cda]cba[dba]=cc[dda]end;dd[baa]={cb(aba),cb(bba),cb(cba)}end;a_a=true end
return
{convert=_aa,generateCanvas=b_a,setSize=c_a,getSize=function()return bd,cd end,set=function(aaa,baa)_d=aaa;ad=baa or ad;__a={}a_a=false;b_a()end,get=function(aaa)if
not a_a then _aa()end
return aaa~=nil and dd[aaa]or dd end}end
return
{Image=function(_d,ad)
return
{shrink=function(bd)local cd=bd:getImageFrame(1)local dd={}for a_a,b_a in pairs(cd)do if(type(a_a)=="number")then
table.insert(dd,b_a[3])end end
local __a=dc(dd,bd:getBackground()).get()bd:setImage(__a)return bd end,getShrinkedImage=function(bd)
local cd=bd:getImageFrame(1)local dd={}for __a,a_a in pairs(cd)do
if(type(__a)=="number")then table.insert(dd,a_a[3])end end;return
dc(dd,bd:getBackground()).get()end}end}end
ba["plugins"]["textures"]=function(...)local bb=_b("images")local cb=_b("utils")
local db=cb.xmlValue
return
{VisualObject=function(_c)local ac,bc=1,true;local cc,dc,_d;local ad="default"
local bd={addTexture=function(cd,dd,__a)cc=bb.loadImageAsBimg(dd)
dc=cc[1]
if(__a)then if(cc.animated)then cd:listenEvent("other_event")local a_a=cc[ac].duration or
cc.secondsPerFrame or 0.2
_d=os.startTimer(a_a)end end;cd:setBackground(false)cd:setForeground(false)
cd:setDrawState("texture-base",true)cd:updateDraw()return cd end,setTextureMode=function(cd,dd)ad=
dd or ad;cd:updateDraw()return cd end,setInfinitePlay=function(cd,dd)bc=dd
return cd end,eventHandler=function(cd,dd,__a,...)_c.eventHandler(cd,dd,__a,...)
if(dd=="timer")then
if
(__a==_d)then
if(cc[ac+1]~=nil)then ac=ac+1;dc=cc[ac]local a_a=
cc[ac].duration or cc.secondsPerFrame or 0.2
_d=os.startTimer(a_a)cd:updateDraw()else
if(bc)then ac=1;dc=cc[1]local a_a=
cc[ac].duration or cc.secondsPerFrame or 0.2
_d=os.startTimer(a_a)cd:updateDraw()end end end end end,draw=function(cd)
_c.draw(cd)
cd:addDraw("texture-base",function()local dd=cd:getParent()or cd
local __a,a_a=cd:getPosition()local b_a,c_a=cd:getSize()local d_a,_aa=dd:getSize()local aaa=cc.width or
#cc[ac][1][1]local baa=cc.height or#cc[ac]
local caa,daa=0,0
if(ad=="center")then caa=__a+math.floor((b_a-aaa)/2 +0.5)-
1;daa=a_a+
math.floor((c_a-baa)/2 +0.5)-1 elseif(ad=="default")then
caa,daa=__a,a_a elseif(ad=="right")then caa,daa=__a+b_a-aaa,a_a+c_a-baa end;local _ba=__a-caa;local aba=a_a-daa
if caa<__a then caa=__a;aaa=aaa-_ba end;if daa<a_a then daa=a_a;baa=baa-aba end;if caa+aaa>__a+b_a then aaa=
(__a+b_a)-caa end;if daa+baa>a_a+c_a then
baa=(a_a+c_a)-daa end
for k=1,baa do if(dc[k+aba]~=nil)then
local bba,cba,dba=table.unpack(dc[k+aba])
cd:addBlit(1,k,bba:sub(_ba,_ba+aaa),cba:sub(_ba,_ba+aaa),dba:sub(_ba,_ba+aaa))end end end,1)cd:setDrawState("texture-base",false)end,setValuesByXMLData=function(cd,dd,__a)
_c.setValuesByXMLData(cd,dd,__a)if(db("texture",dd)~=nil)then
cd:addTexture(db("texture",dd),db("animate",dd))end;if(db("textureMode",dd)~=nil)then
cd:setTextureMode(db("textureMode",dd))end;if(db("infinitePlay",dd)~=nil)then
cd:setInfinitePlay(db("infinitePlay",dd))end;return cd end}return bd end}end
ba["plugins"]["shadow"]=function(...)local bb=_b("utils")local cb=bb.xmlValue
return
{VisualObject=function(db)local _c=false
local ac={setShadow=function(bc,cc)
_c=cc;bc:updateDraw()return bc end,getShadow=function(bc)return _c end,draw=function(bc)
db.draw(bc)
bc:addDraw("shadow",function()
if(_c~=false)then local cc,dc=bc:getSize()
if(_c)then
bc:addBackgroundBox(cc+1,2,1,dc,_c)bc:addBackgroundBox(2,dc+1,cc,1,_c)
bc:addForegroundBox(cc+1,2,1,dc,_c)bc:addForegroundBox(2,dc+1,cc,1,_c)end end end)end,setValuesByXMLData=function(bc,cc,dc)
db.setValuesByXMLData(bc,cc,dc)if(cb("shadow",cc)~=nil)then
bc:setShadow(cb("shadow",cc))end;return bc end}return ac end}end
ba["plugins"]["dynamicValues"]=function(...)local bb=_b("utils")local cb=bb.tableCount
local db=bb.xmlValue
return
{VisualObject=function(_c,ac)local bc={}local cc={}
local dc={x="getX",y="getY",w="getWidth",h="getHeight"}
local function _d(dd)
local __a,a_a=pcall(load("return "..dd,"",nil,{math=math}))if not(__a)then
error(dd.." - is not a valid dynamic value string")end;return a_a end
local function ad(dd,__a,a_a)local b_a={}local c_a=dc
for aaa,baa in pairs(c_a)do for caa in a_a:gmatch("%a+%."..aaa)do
local daa=caa:gsub("%."..aaa,"")
if(daa~="self")and(daa~="parent")then table.insert(b_a,daa)end end end;local d_a=dd:getParent()local _aa={}
for aaa,baa in pairs(b_a)do
_aa[baa]=d_a:getObject(baa)if(_aa[baa]==nil)then
error("Dynamic Values - unable to find object: "..baa)end end;_aa["self"]=dd;_aa["parent"]=d_a
bc[__a]=function()local aaa=a_a
for baa,caa in pairs(c_a)do
for daa in
a_a:gmatch("%w+%."..baa)do local _ba=_aa[daa:gsub("%."..baa,"")]if(_ba~=nil)then
aaa=aaa:gsub(daa,_ba[caa](_ba))else
error("Dynamic Values - unable to find object: "..daa)end end end;cc[__a]=math.floor(_d(aaa)+0.5)end;bc[__a]()end
local function bd(dd)
if(cb(bc)>0)then for a_a,b_a in pairs(bc)do b_a()end
local __a={x="getX",y="getY",w="getWidth",h="getHeight"}
for a_a,b_a in pairs(__a)do
if(bc[a_a]~=nil)then
if(cc[a_a]~=dd[b_a](dd))then if
(a_a=="x")or(a_a=="y")then
_c.setPosition(dd,cc["x"]or dd:getX(),cc["y"]or dd:getY())end;if(a_a=="w")or(a_a=="h")then
_c.setSize(dd,
cc["w"]or dd:getWidth(),cc["h"]or dd:getHeight())end end end end end end
local cd={updatePositions=bd,createDynamicValue=ad,setPosition=function(dd,__a,a_a,b_a)cc.x=__a;cc.y=a_a
if(type(__a)=="string")then ad(dd,"x",__a)else bc["x"]=nil end
if(type(a_a)=="string")then ad(dd,"y",a_a)else bc["y"]=nil end;_c.setPosition(dd,cc.x,cc.y,b_a)return dd end,setSize=function(dd,__a,a_a,b_a)
cc.w=__a;cc.h=a_a
if(type(__a)=="string")then ad(dd,"w",__a)else bc["w"]=nil end
if(type(a_a)=="string")then ad(dd,"h",a_a)else bc["h"]=nil end;_c.setSize(dd,cc.w,cc.h,b_a)return dd end,customEventHandler=function(dd,__a,...)
_c.customEventHandler(dd,__a,...)if
(__a=="basalt_FrameReposition")or(__a=="basalt_FrameResize")then bd(dd)end end}return cd end}end
ba["plugins"]["bigfonts"]=function(...)local bb=_b("tHex")
local cb={{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147","\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132","\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131","\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132","\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32","\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129","\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32","\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32","\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148","\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32","\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32","\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148","\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149","\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32","\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32","\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32","\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132","\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32","\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149","\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32","\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148","\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32","\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32","\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129","\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32","\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32","\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32","\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148","\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32","\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32","\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32","\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132","\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149","\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32","\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32","\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32","\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144","\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149","\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129"},{"000110000110110000110010101000000010000000100101","000000110110000000000010101000000010000000100101","000000000000000000000000000000000000000000000000","100010110100000010000110110000010100000100000110","000000110000000010110110000110000000000000110000","000000000000000000000000000000000000000000000000","000000110110000010000000100000100000000000000010","000000000110110100010000000010000000000000000100","000000000000000000000000000000000000000000000000","010000000000100110000000000000000000000110010000","000000000000000000000000000010000000010110000000","000000000000000000000000000000000000000000000000","011110110000000100100010110000000100000000000000","000000000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110000110110000000000000000000010100100010000000","000010000000000000110110000000000100010010000000","000000000000000000000000000000000000000000000000","010110010110100110110110010000000100000110110110","000000000000000000000110000000000110000000000000","000000000000000000000000000000000000000000000000","010100010110110000000000000000110000000010000000","110110000000000000110000110110100000000010000000","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","100100100100100100100100100100100100100100100100","000000110100110110000010000011110000000000011000","000000000100000000000010000011000110000000001000","000000000000000000000000000000000000000000000000","010000100100000000000000000100000000010010110000","000000000000000000000000000000110110110110110000","000000000000000000000000000000000000000000000000","110110110110110110000000110110110110110110110110","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","000000000000110110000110010000000000000000010010","000010000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110110110110000000000000","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110000000000000000010000","000000000000000000000000100000000000000110000110","000000000000000000000000000000000000000000000000"}}local db={}local _c={}
do local _d=0;local ad=#cb[1]local bd=#cb[1][1]
for i=1,ad,3 do
for j=1,bd,3 do
local cd=string.char(_d)local dd={}dd[1]=cb[1][i]:sub(j,j+2)
dd[2]=cb[1][i+1]:sub(j,j+2)dd[3]=cb[1][i+2]:sub(j,j+2)local __a={}__a[1]=cb[2][i]:sub(j,
j+2)
__a[2]=cb[2][i+1]:sub(j,j+2)__a[3]=cb[2][i+2]:sub(j,j+2)_c[cd]={dd,__a}
_d=_d+1 end end;db[1]=_c end
local function ac(_d,ad)local bd={["0"]="1",["1"]="0"}if _d<=#db then return true end
for f=#db+1,_d do local cd={}local dd=db[
f-1]
for char=0,255 do local __a=string.char(char)local a_a={}local b_a={}
local c_a=dd[__a][1]local d_a=dd[__a][2]
for i=1,#c_a do local _aa,aaa,baa,caa,daa,_ba={},{},{},{},{},{}
for j=1,#c_a[1]do
local aba=_c[c_a[i]:sub(j,j)][1]table.insert(_aa,aba[1])
table.insert(aaa,aba[2])table.insert(baa,aba[3])
local bba=_c[c_a[i]:sub(j,j)][2]
if d_a[i]:sub(j,j)=="1"then
table.insert(caa,(bba[1]:gsub("[01]",bd)))
table.insert(daa,(bba[2]:gsub("[01]",bd)))
table.insert(_ba,(bba[3]:gsub("[01]",bd)))else table.insert(caa,bba[1])
table.insert(daa,bba[2])table.insert(_ba,bba[3])end end;table.insert(a_a,table.concat(_aa))
table.insert(a_a,table.concat(aaa))table.insert(a_a,table.concat(baa))
table.insert(b_a,table.concat(caa))table.insert(b_a,table.concat(daa))
table.insert(b_a,table.concat(_ba))end;cd[__a]={a_a,b_a}if ad then ad="Font"..f.."Yeld"..char
os.queueEvent(ad)os.pullEvent(ad)end end;db[f]=cd end;return true end
local function bc(_d,ad,bd,cd,dd)
if not type(ad)=="string"then error("Not a String",3)end
local __a=type(bd)=="string"and bd:sub(1,1)or bb[bd]or
error("Wrong Front Color",3)
local a_a=type(cd)=="string"and cd:sub(1,1)or bb[cd]or
error("Wrong Back Color",3)if(db[_d]==nil)then ac(3,false)end;local b_a=db[_d]or
error("Wrong font size selected",3)if ad==""then
return{{""},{""},{""}}end;local c_a={}
for _ba in ad:gmatch('.')do table.insert(c_a,_ba)end;local d_a={}local _aa=#b_a[c_a[1]][1]
for nLine=1,_aa do local _ba={}for i=1,#c_a do
_ba[i]=
b_a[c_a[i]]and b_a[c_a[i]][1][nLine]or""end;d_a[nLine]=table.concat(_ba)end;local aaa={}local baa={}local caa={["0"]=__a,["1"]=a_a}
local daa={["0"]=a_a,["1"]=__a}
for nLine=1,_aa do local _ba={}local aba={}
for i=1,#c_a do local bba=
b_a[c_a[i]]and b_a[c_a[i]][2][nLine]or""
_ba[i]=bba:gsub("[01]",dd and
{["0"]=bd:sub(i,i),["1"]=cd:sub(i,i)}or caa)
aba[i]=bba:gsub("[01]",
dd and{["0"]=cd:sub(i,i),["1"]=bd:sub(i,i)}or daa)end;aaa[nLine]=table.concat(_ba)
baa[nLine]=table.concat(aba)end;return{d_a,aaa,baa}end;local cc=_b("utils")local dc=cc.xmlValue
return
{Label=function(_d)local ad=1;local bd
local cd={setFontSize=function(dd,__a)
if(type(__a)=="number")then ad=__a
if(ad>
1)then dd:setDrawState("label",false)
bd=bc(ad-1,dd:getText(),dd:getForeground(),
dd:getBackground()or colors.lightGray)if(dd:getAutoSize())then
dd:getBase():setSize(#bd[1][1],#bd[1]-1)end else
dd:setDrawState("label",true)end;dd:updateDraw()end;return dd end,getFontSize=function(dd)return
ad end,getSize=function(dd)local __a,a_a=_d.getSize(dd)if(ad>1)then return __a* (3 *ad-3),a_a*
(3 *ad-3)else return __a,a_a end end,getWidth=function(dd)
local __a=_d.getWidth(dd)if(ad>1)then return __a* (3 *ad-3)else return __a end end,getHeight=function(dd)
local __a=_d.getHeight(dd)if(ad>1)then return __a* (3 *ad-3)else return __a end end,setValuesByXMLData=function(dd,__a,a_a)
_d.setValuesByXMLData(dd,__a,a_a)if(dc("fontSize",__a)~=nil)then
dd:setFontSize(dc("fontSize",__a))end;return dd end,draw=function(dd)
_d.draw(dd)
dd:addDraw("bigfonts",function()
if(ad>1)then local __a,a_a=dd:getPosition()local b_a=dd:getParent()
local c_a,d_a=b_a:getSize()local _aa,aaa=#bd[1][1],#bd[1]__a=__a or
math.floor((c_a-_aa)/2)+1;a_a=a_a or
math.floor((d_a-aaa)/2)+1
for i=1,aaa do dd:addFG(1,i,bd[2][i])
dd:addBG(1,i,bd[3][i])dd:addText(1,i,bd[1][i])end end end)end}return cd end}end
ba["plugins"]["xml"]=function(...)local bb=_b("utils")local cb=bb.uuid;local db=bb.xmlValue
local function _c(dc)
local _d={}_d.___value=nil;_d.___name=dc;_d.___children={}_d.___props={}function _d:value()
return self.___value end;function _d:setValue(ad)self.___value=ad end;function _d:name()return
self.___name end;function _d:setName(ad)self.___name=ad end;function _d:children()return
self.___children end
function _d:numChildren()return#self.___children end
function _d:addChild(ad)
if self[ad:name()]~=nil then
if
type(self[ad:name()].name)=="function"then local bd={}
table.insert(bd,self[ad:name()])self[ad:name()]=bd end;table.insert(self[ad:name()],ad)else
self[ad:name()]=ad end;table.insert(self.___children,ad)end;function _d:properties()return self.___props end;function _d:numProperties()
return#self.___props end
function _d:addProperty(ad,bd)local cd="@"..ad
if self[cd]~=nil then if
type(self[cd])=="string"then local dd={}table.insert(dd,self[cd])
self[cd]=dd end
table.insert(self[cd],bd)else self[cd]=bd end
table.insert(self.___props,{name=ad,value=self[ad]})end;return _d end;local ac={}
function ac:ToXmlString(dc)dc=string.gsub(dc,"&","&amp;")
dc=string.gsub(dc,"<","&lt;")dc=string.gsub(dc,">","&gt;")
dc=string.gsub(dc,"\"","&quot;")
dc=string.gsub(dc,"([^%w%&%;%p%\t% ])",function(_d)
return string.format("&#x%X;",string.byte(_d))end)return dc end
function ac:FromXmlString(dc)
dc=string.gsub(dc,"&#x([%x]+)%;",function(_d)
return string.char(tonumber(_d,16))end)
dc=string.gsub(dc,"&#([0-9]+)%;",function(_d)return string.char(tonumber(_d,10))end)dc=string.gsub(dc,"&quot;","\"")
dc=string.gsub(dc,"&apos;","'")dc=string.gsub(dc,"&gt;",">")
dc=string.gsub(dc,"&lt;","<")dc=string.gsub(dc,"&amp;","&")return dc end;function ac:ParseArgs(dc,_d)
string.gsub(_d,"(%w+)=([\"'])(.-)%2",function(ad,bd,cd)
dc:addProperty(ad,self:FromXmlString(cd))end)end
function ac:ParseXmlText(dc)
local _d={}local ad=_c()table.insert(_d,ad)local bd,cd,dd,__a,a_a;local b_a,c_a=1,1
while true do
bd,c_a,cd,dd,__a,a_a=string.find(dc,"<(%/?)([%w_:]+)(.-)(%/?)>",b_a)if not bd then break end;local _aa=string.sub(dc,b_a,bd-1)
if not
string.find(_aa,"^%s*$")then
local aaa=(ad:value()or"")..self:FromXmlString(_aa)_d[#_d]:setValue(aaa)end
if a_a=="/"then local aaa=_c(dd)self:ParseArgs(aaa,__a)
ad:addChild(aaa)elseif cd==""then local aaa=_c(dd)self:ParseArgs(aaa,__a)
table.insert(_d,aaa)ad=aaa else local aaa=table.remove(_d)ad=_d[#_d]
if#_d<1 then error("XmlParser: nothing to close with "..
dd)end;if aaa:name()~=dd then
error("XmlParser: trying to close "..aaa.name.." with "..dd)end;ad:addChild(aaa)end;b_a=c_a+1 end;local d_a=string.sub(dc,b_a)if#_d>1 then
error("XmlParser: unclosed ".._d[#_d]:name())end;return ad end
function ac:loadFile(dc,_d)if not _d then _d=""end;local ad=fs.combine(_d,dc)
local bd,cd=io.open(ad,"r")
if bd and not cd then local dd=bd:read("*a")io.close(bd)return
self:ParseXmlText(dd),nil else print(cd)return nil end end;local function bc(dc)
for _d,ad in pairs(dc)do if(_d~="env")then
for bd,cd in pairs(ad)do load(cd,nil,"t",dc.env)()end end end end
local function cc(dc,_d,ad,bd)
if(
_d:sub(1,1)=="$")then local cd=_d:sub(2)
ad(dc,dc:getBasalt():getVariable(cd))else ad(dc,load(_d,nil,"t",bd.env))end end
return
{VisualObject=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)dd.env[bd:getName()]=bd;local __a,a_a=bd:getPosition()
local b_a,c_a=nil,nil;if(db("x",cd)~=nil)then __a=db("x",cd)end;if(db("y",cd)~=nil)then
a_a=db("y",cd)end
if(db("width",cd)~=nil)then b_a=db("width",cd)end
if(db("height",cd)~=nil)then c_a=db("height",cd)end;if(db("background",cd)~=nil)then
bd:setBackground(colors[db("background",cd)])end;if(db("script",cd)~=nil)then if
(dd[1]==nil)then dd[1]={}end
table.insert(dd[1],db("script",cd))end
local d_a={"onClick","onClickUp","onHover","onScroll","onDrag","onKey","onKeyUp","onRelease","onChar","onGetFocus","onLoseFocus","onResize","onReposition","onEvent","onLeave"}for _aa,aaa in pairs(d_a)do
if(db(aaa,cd)~=nil)then cc(bd,db(aaa,cd),bd[aaa],dd)end end
bd:setPosition(__a,a_a)
if(b_a~=nil or c_a~=nil)then local _aa,aaa=bd:getSize()
if b_a==nil then b_a=_aa end;if c_a==nil then c_a=aaa end;bd:setSize(b_a,c_a)end;return bd end}return ad end,ChangeableObject=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)
if(db("value",cd)~=nil)then bd:setValue(db("value",cd))end;if(db("onChange",cd)~=nil)then
cc(bd,db("onChange",cd),bd.onChange,dd)end;return bd end}return ad end,BaseFrame=function(dc,_d)
local ad={}local function bd(__a,a_a,b_a)
if(a_a~=nil)then a_a:setValuesByXMLData(__a,b_a)end end
local function cd(__a,a_a,b_a,c_a)
if(__a~=nil)then if(__a.properties~=nil)then
__a={__a}end
for d_a,_aa in pairs(__a)do
local aaa=a_a(b_a,_aa["@id"]or cb())table.insert(ad,aaa)bd(_aa,aaa,c_a)end end end
local dd={setValuesByXMLData=function(__a,a_a,b_a)ad={}dc.setValuesByXMLData(__a,a_a,b_a)
local c_a,d_a=__a:getOffset()if(db("layout",a_a)~=nil)then
__a:addLayout(db("layout",a_a))end;if(db("xOffset",a_a)~=nil)then
c_a=db("xOffset",a_a)end;__a:setOffset(c_a,d_a)
local _aa=a_a:children()local aaa=_d.getObjects()
for baa,caa in pairs(_aa)do if(caa.___name~="animation")then
local daa=caa.___name:gsub("^%l",string.upper)
if(aaa[daa]~=nil)then cd(caa,__a["add"..daa],__a,b_a)end end end;cd(a_a["animation"],__a.addAnimation,__a,b_a)
return __a end,getXMLElements=function(__a)return
ad end,loadLayout=function(__a,a_a)
if(fs.exists(a_a))then local b_a={}b_a.env=_ENV;b_a.env.basalt=_d
b_a.env.shared={}local c_a=fs.open(a_a,"r")
local d_a=ac:ParseXmlText(c_a.readAll())c_a.close()ad={}__a:setValuesByXMLData(d_a,b_a)
bc(b_a)end;return __a end}return dd end,Frame=function(dc,_d)
local ad={}local function bd(__a,a_a,b_a)
if(a_a~=nil)then a_a:setValuesByXMLData(__a,b_a)end end
local function cd(__a,a_a,b_a,c_a)
if(__a~=nil)then if(__a.properties~=nil)then
__a={__a}end
for d_a,_aa in pairs(__a)do
local aaa=a_a(b_a,_aa["@id"]or cb())table.insert(ad,aaa)bd(_aa,aaa,c_a)end end end
local dd={setValuesByXMLData=function(__a,a_a,b_a)dc.setValuesByXMLData(__a,a_a,b_a)
local c_a,d_a=__a:getOffset()if(db("layout",a_a)~=nil)then
__a:addLayout(db("layout",a_a))end;if(db("xOffset",a_a)~=nil)then
c_a=db("xOffset",a_a)end;if(db("yOffset",a_a)~=nil)then
d_a=db("yOffset",a_a)end;__a:setOffset(c_a,d_a)
local _aa=a_a:children()local aaa=_d.getObjects()
for baa,caa in pairs(_aa)do if(caa.___name~="animation")then
local daa=caa.___name:gsub("^%l",string.upper)
if(aaa[daa]~=nil)then cd(caa,__a["add"..daa],__a,b_a)end end end;cd(a_a["animation"],__a.addAnimation,__a,b_a)
return __a end,loadLayout=function(__a,a_a)
if
(fs.exists(a_a))then local b_a={}b_a.env=_ENV;b_a.env.basalt=_d;b_a.env.main=__a
b_a.env.shared={}local c_a=fs.open(a_a,"r")
local d_a=ac:ParseXmlText(c_a.readAll())c_a.close()ad={}__a:setValuesByXMLData(d_a,b_a)
bc(b_a)end;return __a end}return dd end,Button=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)
if(db("text",cd)~=nil)then bd:setText(db("text",cd))end;if(db("horizontalAlign",cd)~=nil)then
bd:setHorizontalAlign(db("horizontalAlign",cd))end
if
(db("verticalAlign",cd)~=nil)then bd:setText(db("verticalAlign",cd))end;return bd end}return ad end,Label=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)
if(db("text",cd)~=nil)then bd:setText(db("text",cd))end;if(db("align",cd)~=nil)then
bd:setTextAlign(db("align",cd))end;return bd end}return ad end,Input=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a,b_a=bd:getDefaultText()if(db("defaultText",cd)~=nil)then
__a=db("defaultText",cd)end;if(db("defaultFG",cd)~=nil)then
a_a=db("defaultFG",cd)end;if(db("defaultBG",cd)~=nil)then
b_a=db("defaultBG",cd)end;bd:setDefaultText(__a,a_a,b_a)
if(
db("offset",cd)~=nil)then bd:setOffset(db("offset",cd))end;if(db("textOffset",cd)~=nil)then
bd:setTextOffset(db("textOffset",cd))end;if(db("text",cd)~=nil)then
bd:setValue(db("text",cd))end;if(db("inputLimit",cd)~=nil)then
bd:setInputLimit(db("inputLimit",cd))end;return bd end}return ad end,Image=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getOffset()if(db("xOffset",cd)~=nil)then
__a=db("xOffset",cd)end;if(db("yOffset",cd)~=nil)then
a_a=db("yOffset",cd)end;bd:setOffset(__a,a_a)if
(db("path",cd)~=nil)then bd:loadImage(db("path",cd))end
if(
db("usePalette",cd)~=nil)then bd:usePalette(db("usePalette",cd))end
if(db("play",cd)~=nil)then bd:play(db("play",cd))end;return bd end}return ad end,Checkbox=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,data,scripts)local __a,a_a=bd:getSymbol()if(db("text",data)~=nil)then
bd:setText(db("text",data))end;if(db("checked",data)~=nil)then
bd:setChecked(db("checked",data))end;if(db("textPosition",data)~=nil)then
bd:setTextPosition(db("textPosition",data))end;if
(db("activeSymbol",data)~=nil)then __a=db("activeSymbol",data)end
if(
db("inactiveSymbol",data)~=nil)then a_a=db("inactiveSymbol",data)end;bd:setSymbol(__a,a_a)return bd end}return ad end,Program=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("execute",cd)~=nil)then
bd:execute(db("execute",cd))end;return bd end}return ad end,Progressbar=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a,b_a=bd:getProgressBar()if(db("direction",cd)~=nil)then
bd:setDirection(db("direction",cd))end;if(db("activeBarColor",cd)~=nil)then
__a=colors[db("activeBarColor",cd)]end;if
(db("activeBarSymbol",cd)~=nil)then a_a=db("activeBarSymbol",cd)end;if(
db("activeBarSymbolColor",cd)~=nil)then
b_a=colors[db("activeBarSymbolColor",cd)]end;if
(db("backgroundSymbol",cd)~=nil)then
bd:setBackgroundSymbol(db("backgroundSymbol",cd))end;if(db("progress",cd)~=nil)then
bd:setProgress(db("progress",cd))end;return bd end}return ad end,Slider=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("symbol",cd)~=nil)then
bd:setSymbol(db("symbol",cd))end;if(db("symbolColor",cd)~=nil)then
bd:setSymbolColor(db("symbolColor",cd))end;if(db("index",cd)~=nil)then
bd:setIndex(db("index",cd))end;if(db("maxValue",cd)~=nil)then
bd:setIndex(db("maxValue",cd))end;if(db("barType",cd)~=nil)then
bd:setBarType(db("barType",cd))end;return bd end}return ad end,Scrollbar=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("symbol",cd)~=nil)then
bd:setSymbol(db("symbol",cd))end;if(db("symbolColor",cd)~=nil)then
bd:setSymbolColor(db("symbolColor",cd))end;if(db("symbolSize",cd)~=nil)then
bd:setSymbolSize(db("symbolSize",cd))end;if(db("scrollAmount",cd)~=nil)then
bd:setScrollAmount(db("scrollAmount",cd))end;if(db("index",cd)~=nil)then
bd:setIndex(db("index",cd))end;if(db("maxValue",cd)~=nil)then
bd:setIndex(db("maxValue",cd))end;if(db("barType",cd)~=nil)then
bd:setBarType(db("barType",cd))end;return bd end}return ad end,MonitorFrame=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("monitor",cd)~=nil)then
bd:setSymbol(db("monitor",cd))end;return bd end}return ad end,Switch=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("symbol",cd)~=nil)then
bd:setSymbol(db("symbol",cd))end;if(db("activeBackground",cd)~=nil)then
bd:setActiveBackground(db("activeBackground",cd))end;if
(db("inactiveBackground",cd)~=nil)then
bd:setInactiveBackground(db("inactiveBackground",cd))end;return bd end}return ad end,Textfield=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getSelection()local b_a,c_a=bd:getOffset()
if(
db("bgSelection",cd)~=nil)then __a=db("bgSelection",cd)end
if(db("fgSelection",cd)~=nil)then a_a=db("fgSelection",cd)end
if(db("xOffset",cd)~=nil)then b_a=db("xOffset",cd)end
if(db("yOffset",cd)~=nil)then c_a=db("yOffset",cd)end;bd:setSelection(a_a,__a)bd:setOffset(b_a,c_a)
if(
cd["lines"]~=nil)then local d_a=cd["lines"]["line"]if(d_a.properties~=nil)then
d_a={d_a}end
for _aa,aaa in pairs(d_a)do bd:addLine(aaa:value())end end
if(cd["keywords"]~=nil)then
for d_a,_aa in pairs(cd["keywords"])do
if(colors[d_a]~=nil)then
local aaa=_aa;if(aaa.properties~=nil)then aaa={aaa}end;local baa={}
for caa,daa in pairs(aaa)do
local _ba=daa["keyword"]if(daa["keyword"].properties~=nil)then
_ba={daa["keyword"]}end;for aba,bba in pairs(_ba)do
table.insert(baa,bba:value())end end;bd:addKeywords(colors[d_a],baa)end end end
if(cd["rules"]~=nil)then
if(cd["rules"]["rule"]~=nil)then
local d_a=cd["rules"]["rule"]if(cd["rules"]["rule"].properties~=nil)then
d_a={cd["rules"]["rule"]}end
for _aa,aaa in pairs(d_a)do if(db("pattern",aaa)~=nil)then
bd:addRule(db("pattern",aaa),colors[db("fg",aaa)],colors[db("bg",aaa)])end end end end;return bd end}return ad end,Thread=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)if(db("start",cd)~=nil)then
bd:start(load(db("start",cd),nil,"t",dd.env))end;return bd end}return ad end,Timer=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)
if(db("start",cd)~=nil)then bd:start(db("start",cd))end
if(db("time",cd)~=nil)then bd:setTime(db("time",cd))end;if(db("onCall",cd)~=nil)then
cc(bd,db("onCall",cd),bd.onCall,dd)end;return bd end}return ad end,List=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getSelectionColor()if(db("align",cd)~=nil)then
bd:setTextAlign(db("align",cd))end;if(db("offset",cd)~=nil)then
bd:setOffset(db("offset",cd))end;if(db("selectionBg",cd)~=nil)then
__a=db("selectionBg",cd)end;if(db("selectionFg",cd)~=nil)then
a_a=db("selectionFg",cd)end;bd:setSelectionColor(__a,a_a)if(
db("scrollable",cd)~=nil)then
bd:setScrollable(db("scrollable",cd))end
if(cd["item"]~=nil)then local b_a=cd["item"]if(
b_a.properties~=nil)then b_a={b_a}end
for c_a,d_a in pairs(b_a)do if
(bd:getType()~="Radio")then
bd:addItem(db("text",d_a),colors[db("bg",d_a)],colors[db("fg",d_a)])end end end;return bd end}return ad end,Dropdown=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getDropdownSize()if(db("dropdownWidth",cd)~=nil)then
__a=db("dropdownWidth",cd)end;if(db("dropdownHeight",cd)~=nil)then
a_a=db("dropdownHeight",cd)end;bd:setDropdownSize(__a,a_a)
return bd end}return ad end,Radio=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getBoxSelectionColor()
local b_a,c_a=bd:setBoxDefaultColor()
if(db("selectionBg",cd)~=nil)then __a=db("selectionBg",cd)end
if(db("selectionFg",cd)~=nil)then a_a=db("selectionFg",cd)end;bd:setBoxSelectionColor(__a,a_a)if
(db("defaultBg",cd)~=nil)then b_a=db("defaultBg",cd)end;if(db("defaultFg",cd)~=
nil)then c_a=db("defaultFg",cd)end
bd:setBoxDefaultColor(b_a,c_a)
if(cd["item"]~=nil)then local d_a=cd["item"]
if(d_a.properties~=nil)then d_a={d_a}end;for _aa,aaa in pairs(d_a)do
bd:addItem(db("text",aaa),db("x",aaa),db("y",aaa),colors[db("bg",aaa)],colors[db("fg",aaa)])end end;return bd end}return ad end,Menubar=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)
if(db("space",cd)~=nil)then bd:setSpace(db("space",cd))end;if(db("scrollable",cd)~=nil)then
bd:setScrollable(db("scrollable",cd))end;return bd end}return ad end,Graph=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getGraphSymbol()if(db("maxEntries",cd)~=nil)then
bd:setMaxEntries(db("maxEntries",cd))end;if(db("type",cd)~=nil)then
bd:setGraphType(db("type",cd))end;if(db("minValue",cd)~=nil)then
bd:setMinValue(db("minValue",cd))end;if(db("maxValue",cd)~=nil)then
bd:setMaxValue(db("maxValue",cd))end;if(db("symbol",cd)~=nil)then
__a=db("symbol",cd)end;if(db("symbolColor",cd)~=nil)then
a_a=db("symbolColor",cd)end;bd:setGraphSymbol(__a,a_a)if(
cd["item"]~=nil)then local b_a=cd["item"]
if(b_a.properties~=nil)then b_a={b_a}end
for c_a,d_a in pairs(b_a)do bd:addDataPoint(db("value"))end end;return
bd end}return ad end,Treeview=function(dc,_d)
local ad={setValuesByXMLData=function(bd,cd,dd)
dc.setValuesByXMLData(bd,cd,dd)local __a,a_a=bd:getSelectionColor()local b_a,c_a=bd:getOffset()
if(
db("space",cd)~=nil)then bd:setSpace(db("space",cd))end;if(db("scrollable",cd)~=nil)then
bd:setScrollable(db("scrollable",cd))end;if(db("selectionBg",cd)~=nil)then
__a=db("selectionBg",cd)end;if(db("selectionFg",cd)~=nil)then
a_a=db("selectionFg",cd)end;bd:setSelectionColor(__a,a_a)if(
db("xOffset",cd)~=nil)then b_a=db("xOffset",cd)end;if(
db("yOffset",cd)~=nil)then c_a=db("yOffset",cd)end
bd:setOffset(b_a,c_a)
local function d_a(_aa,aaa)
if(aaa["node"]~=nil)then local baa=aaa["node"]
if(baa.properties~=nil)then baa={baa}end
for caa,daa in pairs(baa)do
local _ba=_aa:addNode(db("text",daa),colors[db("bg",daa)],colors[db("fg",daa)])d_a(_ba,daa)end end end
if(cd["node"]~=nil)then local _aa=cd["node"]
if(_aa.properties~=nil)then _aa={_aa}end
for aaa,baa in pairs(_aa)do
local caa=bd:addNode(db("text",baa),colors[db("bg",baa)],colors[db("fg",baa)])d_a(caa,baa)end end;return bd end}return ad end}end
ba["plugins"]["themes"]=function(...)
local bb={BaseFrameBG=colors.lightGray,BaseFrameText=colors.black,FrameBG=colors.gray,FrameText=colors.black,ButtonBG=colors.gray,ButtonText=colors.black,CheckboxBG=colors.lightGray,CheckboxText=colors.black,InputBG=colors.black,InputText=colors.lightGray,TextfieldBG=colors.black,TextfieldText=colors.white,ListBG=colors.gray,ListText=colors.black,MenubarBG=colors.gray,MenubarText=colors.black,DropdownBG=colors.gray,DropdownText=colors.black,RadioBG=colors.gray,RadioText=colors.black,SelectionBG=colors.black,SelectionText=colors.lightGray,GraphicBG=colors.black,ImageBG=colors.black,PaneBG=colors.black,ProgramBG=colors.black,ProgressbarBG=colors.gray,ProgressbarText=colors.black,ProgressbarActiveBG=colors.black,ScrollbarBG=colors.lightGray,ScrollbarText=colors.gray,ScrollbarSymbolColor=colors.black,SliderBG=false,SliderText=colors.gray,SliderSymbolColor=colors.black,SwitchBG=colors.lightGray,SwitchText=colors.gray,LabelBG=false,LabelText=colors.black,GraphBG=colors.gray,GraphText=colors.black}
local cb={Container=function(db,_c,ac)local bc={}
local cc={getTheme=function(dc,_d)local ad=dc:getParent()return bc[_d]or(ad~=nil and ad:getTheme(_d)or
bb[_d])end,setTheme=function(dc,_d,ad)
if(
type(_d)=="table")then bc=_d elseif(type(_d)=="string")then bc[_d]=ad end;dc:updateDraw()return dc end}return cc end,basalt=function()
return
{getTheme=function(db)return
bb[db]end,setTheme=function(db,_c)if(type(db)=="table")then bb=db elseif(type(db)=="string")then
bb[db]=_c end end}end}
for db,_c in
pairs({"BaseFrame","Frame","ScrollableFrame","MovableFrame","Button","Checkbox","Dropdown","Graph","Graphic","Input","Label","List","Menubar","Pane","Program","Progressbar","Radio","Scrollbar","Slider","Switch","Textfield"})do
cb[_c]=function(ac,bc,cc)
local dc={init=function(_d)if(ac.init(_d))then local ad=_d:getParent()or _d
_d:setBackground(ad:getTheme(_c.."BG"))
_d:setForeground(ad:getTheme(_c.."Text"))end end}return dc end end;return cb end
ba["plugins"]["betterError"]=function(...)local bb=_b("utils")local cb=bb.wrapText
return
{basalt=function(db)local _c
local ac
return
{getBasaltErrorFrame=function()return _c end,basaltError=function(bc)
if(_c==nil)then local dc=db.getMainFrame()
local _d,ad=dc:getSize()
_c=dc:addMovableFrame("basaltErrorFrame"):setSize(_d-20,ad-10):setBackground(colors.lightGray):setForeground(colors.white):setZIndex(500)
_c:addPane("titleBackground"):setSize(_d,1):setPosition(1,1):setBackground(colors.black):setForeground(colors.white)
_c:setPosition(_d/2 -_c:getWidth()/2,ad/2 -_c:getHeight()/2):setBorder(colors.black)
_c:addLabel("title"):setText("Basalt Unexpected Error"):setPosition(2,1):setBackground(colors.black):setForeground(colors.white)
ac=_c:addList("errorList"):setSize(_c:getWidth()-2,_c:getHeight()-6):setPosition(2,3):setBackground(colors.lightGray):setForeground(colors.white):setSelectionColor(colors.lightGray,colors.gray)
_c:addButton("xButton"):setText("x"):setPosition(_c:getWidth(),1):setSize(1,1):setBackground(colors.black):setForeground(colors.red):onClick(function()
_c:hide()end)
_c:addButton("Clear"):setText("Clear"):setPosition(
_c:getWidth()-19,_c:getHeight()-1):setSize(9,1):setBackground(colors.black):setForeground(colors.white):onClick(function()
ac:clear()end)
_c:addButton("Close"):setText("Close"):setPosition(
_c:getWidth()-9,_c:getHeight()-1):setSize(9,1):setBackground(colors.black):setForeground(colors.white):onClick(function()
db.autoUpdate(false)term.clear()term.setCursorPos(1,1)end)end;_c:show()
ac:addItem("--------------------------------------------")local cc=cb(bc,_c:getWidth()-2)for i=1,#cc do
ac:addItem(cc[i])end end}end}end
ba["plugins"]["basaltAdditions"]=function(...)return
{basalt=function()return
{cool=function()print("ello")sleep(2)end}end}end
ba["plugins"]["border"]=function(...)local bb=_b("utils")local cb=bb.xmlValue
return
{VisualObject=function(db)local _c=true
local ac={top=false,bottom=false,left=false,right=false}
local bc={setBorder=function(cc,...)local dc={...}
if(dc~=nil)then
for _d,ad in pairs(dc)do
if(ad=="left")or(#dc==1)then ac["left"]=dc[1]end;if(ad=="top")or(#dc==1)then ac["top"]=dc[1]end;if
(ad=="right")or(#dc==1)then ac["right"]=dc[1]end;if
(ad=="bottom")or(#dc==1)then ac["bottom"]=dc[1]end end end;cc:updateDraw()return cc end,draw=function(cc)
db.draw(cc)
cc:addDraw("border",function()local dc,_d=cc:getPosition()local ad,bd=cc:getSize()
local cd=cc:getBackground()
if(_c)then
if(ac["left"]~=false)then cc:addTextBox(1,1,1,bd,"\149")if(cd~=false)then
cc:addBackgroundBox(1,1,1,bd,cd)end
cc:addForegroundBox(1,1,1,bd,ac["left"])end
if(ac["top"]~=false)then cc:addTextBox(1,1,ad,1,"\131")if(cd~=false)then
cc:addBackgroundBox(1,1,ad,1,cd)end
cc:addForegroundBox(1,1,ad,1,ac["top"])end
if(ac["left"]~=false)and(ac["top"]~=false)then
cc:addTextBox(1,1,1,1,"\151")
if(cd~=false)then cc:addBackgroundBox(1,1,1,1,cd)end;cc:addForegroundBox(1,1,1,1,ac["left"])end
if(ac["right"]~=false)then cc:addTextBox(ad,1,1,bd,"\149")if
(cd~=false)then cc:addForegroundBox(ad,1,1,bd,cd)end
cc:addBackgroundBox(ad,1,1,bd,ac["right"])end
if(ac["bottom"]~=false)then cc:addTextBox(1,bd,ad,1,"\143")if
(cd~=false)then cc:addForegroundBox(1,bd,ad,1,cd)end
cc:addBackgroundBox(1,bd,ad,1,ac["bottom"])end
if(ac["top"]~=false)and(ac["right"]~=false)then
cc:addTextBox(ad,1,1,1,"\148")
if(cd~=false)then cc:addForegroundBox(ad,1,1,1,cd)end;cc:addBackgroundBox(ad,1,1,1,ac["right"])end
if(ac["right"]~=false)and(ac["bottom"]~=false)then
cc:addTextBox(ad,bd,1,1,"\133")
if(cd~=false)then cc:addForegroundBox(ad,bd,1,1,cd)end;cc:addBackgroundBox(ad,bd,1,1,ac["right"])end
if(ac["bottom"]~=false)and(ac["left"]~=false)then
cc:addTextBox(1,bd,1,1,"\138")
if(cd~=false)then cc:addForegroundBox(0,bd,1,1,cd)end;cc:addBackgroundBox(1,bd,1,1,ac["left"])end end end)end,setValuesByXMLData=function(cc,dc,_d)
db.setValuesByXMLData(cc,dc)local ad={}
if(cb("border",dc)~=nil)then
ad["top"]=colors[cb("border",dc)]ad["bottom"]=colors[cb("border",dc)]
ad["left"]=colors[cb("border",dc)]ad["right"]=colors[cb("border",dc)]end;if(cb("borderTop",dc)~=nil)then
ad["top"]=colors[cb("borderTop",dc)]end;if(cb("borderBottom",dc)~=nil)then
ad["bottom"]=colors[cb("borderBottom",dc)]end;if(cb("borderLeft",dc)~=nil)then
ad["left"]=colors[cb("borderLeft",dc)]end;if(cb("borderRight",dc)~=nil)then
ad["right"]=colors[cb("borderRight",dc)]end
cc:setBorder(ad["top"],ad["bottom"],ad["left"],ad["right"])return cc end}return bc end}end
ba["plugins"]["debug"]=function(...)local bb=_b("utils")local cb=bb.wrapText
return
{basalt=function(db)
local _c=db.getMainFrame()local ac;local bc;local cc;local dc
local function _d()local ad=16;local bd=6;local cd=99;local dd=99;local __a,a_a=_c:getSize()
ac=_c:addMovableFrame("basaltDebuggingFrame"):setSize(
__a-20,a_a-10):setBackground(colors.lightGray):setForeground(colors.white):setZIndex(100):hide()
ac:addPane():setSize("parent.w",1):setPosition(1,1):setBackground(colors.black):setForeground(colors.white)
ac:setPosition(-__a,a_a/2 -ac:getHeight()/2):setBorder(colors.black)
local b_a=ac:addButton():setPosition("parent.w","parent.h"):setSize(1,1):setText("\133"):setForeground(colors.lightGray):setBackground(colors.black):onClick(function(c_a,d_a,_aa,aaa,baa)
end):onDrag(function(c_a,d_a,_aa,aaa,baa)
local caa,daa=ac:getSize()local _ba,aba=caa,daa;if(caa+aaa-1 >=ad)and(caa+aaa-1 <=cd)then _ba=caa+
aaa-1 end
if(daa+baa-1 >=bd)and(
daa+baa-1 <=dd)then aba=daa+baa-1 end;ac:setSize(_ba,aba)end)
dc=ac:addButton():setText("Exit"):setPosition("parent.w - 6",1):setSize(7,1):setBackground(colors.red):setForeground(colors.white):onClick(function()
ac:animatePosition(
-__a,a_a/2 -ac:getHeight()/2,0.5)end)
bc=ac:addList():setSize("parent.w - 2","parent.h - 3"):setPosition(2,3):setBackground(colors.lightGray):setForeground(colors.white):setSelectionColor(colors.lightGray,colors.gray)
if(cc==nil)then
cc=_c:addLabel():setPosition(1,"parent.h"):setBackground(colors.black):setForeground(colors.white):onClick(function()
ac:show()
ac:animatePosition(__a/2 -ac:getWidth()/2,a_a/2 -ac:getHeight()/2,0.5)end)end end
return
{debug=function(...)local ad={...}if(_c==nil)then _c=db.getMainFrame()
if(_c~=nil)then _d()else print(...)return end end
if
(_c:getName()~="basaltDebuggingFrame")then if(_c~=ac)then cc:setParent(_c)end end;local bd=""for cd,dd in pairs(ad)do
bd=bd..tostring(dd).. (#ad~=cd and", "or"")end
cc:setText("[Debug] "..bd)
for cd,dd in pairs(cb(bd,bc:getWidth()))do bc:addItem(dd)end
if(bc:getItemCount()>50)then bc:removeItem(1)end
bc:setValue(bc:getItem(bc:getItemCount()))
if(bc.getItemCount()>bc:getHeight())then bc:setOffset(bc:getItemCount()-
bc:getHeight())end;cc:show()end}end}end;return ba["main"]()