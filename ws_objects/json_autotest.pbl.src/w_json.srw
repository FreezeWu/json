$PBExportHeader$w_json.srw
forward
global type w_json from window
end type
type cbx_2 from checkbox within w_json
end type
type uo_1 from uo_json_per within w_json
end type
type cb_3 from commandbutton within w_json
end type
type cb_2 from commandbutton within w_json
end type
type cbx_1 from checkbox within w_json
end type
type cb_1 from commandbutton within w_json
end type
type mle_2 from multilineedit within w_json
end type
type st_2 from statictext within w_json
end type
type mle_1 from multilineedit within w_json
end type
type st_1 from statictext within w_json
end type
end forward

global type w_json from window
integer width = 3657
integer height = 2120
boolean titlebar = true
string title = "Json_auto"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_2 cbx_2
uo_1 uo_1
cb_3 cb_3
cb_2 cb_2
cbx_1 cbx_1
cb_1 cb_1
mle_2 mle_2
st_2 st_2
mle_1 mle_1
st_1 st_1
end type
global w_json w_json

type variables
eon_appeon_resize  ieon_resize
jsonparser ijs_par
jsongenerator ijs_gen
end variables

forward prototypes
public subroutine wf_classic_jsonparser ()
public subroutine wf_jsonparser_load ()
public subroutine wf_init ()
public subroutine wf_jsonparser_query ()
public subroutine wf_jsonparser_getitem ()
public subroutine wf_jsongenerator_classic ()
public subroutine wf_jsongenerator_inout ()
public subroutine wf_jsgenerate_additem ()
public subroutine wf_gettmpfile ()
public subroutine wf_parm_area ()
public subroutine wf_string_encoding ()
end prototypes

public subroutine wf_classic_jsonparser ();//  jsonparser对象 标准pb对象测试
jsonparser  ljs_par
string ls_output,ls_rtn,ls_value
long ll_root

ljs_par = create jsonparser
ls_rtn = ljs_par.classname( )
ls_output = "classname() = "+ls_rtn+"~r~n"


if  ljs_par.typeof( ) = jsonparser! then
	ls_output += "typeof() = jsonparser!~r~n"
else
	ls_output += "typeof() <> jsonparser!~r~n"
end if

//powerobject
ls_rtn = ljs_par.loadstring( '{"id":100,"Text":"测试jsonparser数据传递"}')
if len(trim(ls_rtn)) <> 0 then
	ls_output += "loadstring failed : "+ls_rtn+"~r~n"
else
	openwithparm(w_tmp,ljs_par)
	ljs_par = message.powerobjectparm
	ll_root = ljs_par.getrootitem( )
	ls_value = ljs_par.getitemstring( ll_root, "Text")
	ls_output+="return from message is "+ls_value+"~r~n"
end if

//create/destroy
destroy ljs_par
if isvalid(ljs_par) then
	ls_output += "Error, After Destroy the object,it is still valid~r~n"
else
	ls_output += "The object is destoyed!~r~n"
end if
ljs_par = create using "jsonparser"
if isvalid(ljs_par) then
	ls_output += "The object was created~r~n"
else
	ls_output += "Error, Create the object failed~r~n"
end if
ls_rtn = ljs_par.loadstring( '{"id":100,"Text":"测试jsonparser数据传递"}')
if len(trim(ls_rtn)) <> 0 then
	ls_output += "loadstring failed : "+ls_rtn+"~r~n"
else
	ls_output += "loadstring succeed : "+ls_rtn+"~r~n"
end if

mle_2.text += ls_output
wf_init()
end subroutine

public subroutine wf_jsonparser_load ();
string ls_json,ls_null,ls_space,ls_rtn,ls_output
string ls_file,ls_path

//loadstring
setnull(ls_null)
ls_rtn = ijs_par.loadstring( ls_null)
if isnull(ls_null) then
	ls_output = "loadstring(null) = Null~r~n"
else
	ls_output = "loadstring(null) <> Null~r~n"
end if
//未赋值数据
ls_rtn = ijs_par.loadstring( ls_space)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//space(1000)
ls_rtn = ijs_par.loadstring( space(1000))
ls_output += "loadstring(space(1000)) = "+ls_rtn+"~r~n"
//"json value包含特殊字符"
ls_json = '{"id":45,"name":"lisan~r~nter@#$-`*&"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//json value包含char(10)
ls_json = '{"id":45,"name":"lisan'+char(10)+char(13)+'"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//json value包含多字节
ls_json = '{"id":45,"name":"李三③Ⅲ😭"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//key包含特殊字符
ls_json = '{"~r~nid":45,"name":"lisan"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//json key包含多字节
ls_json = '{"功能《id":45,"ÄÖÜß|name":"李三"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//key 为纯数字
ls_json = '{"123":45,"name":"lisan"}'
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//正常加载数据
ls_json =mle_1.text
ls_rtn = ijs_par.loadstring(ls_json)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_json+") = "+string(" Succeed")+"~r~n"
else
	ls_output += "loadstring("+ls_json+") = "+ls_rtn+"~r~n"
end if
//loadfile
setnull(ls_null)
ls_rtn = ijs_par.loadfile( ls_null)
if isnull(ls_null) then
	ls_output = "loadfile(null) = Null~r~n"
else
	ls_output = "loadfile(null) <> Null~r~n"
end if
//未赋值数据
ls_rtn = ijs_par.loadfile( ls_space)
ls_output += "loadfile(~"~") = "+ls_rtn+"~r~n"
//pbl 文件加载
ls_file = 'json_autotest.pbl'
ls_rtn = ijs_par.loadfile(ls_file)
ls_output += "loadstring("+ls_file+") = "+ls_rtn+"~r~n"
//docx文件加载
ls_file = 'json.docx'
ls_rtn = ijs_par.loadfile(ls_file)
ls_output += "loadstring("+ls_file+") = "+ls_rtn+"~r~n"
//txt文件加载
ls_file = 'json.txt'
ls_rtn = ijs_par.loadfile(ls_file)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_file+") Succeed~r~n"
else
	ls_output += "loadstring("+ls_file+") = "+ls_rtn+"~r~n"
end if
//使用绝对路径
//"D:\APB-File\PB NewFeature\Json_test"
ls_path = getcurrentdirectory()
ls_file =ls_path+'\json.txt'
ls_rtn = ijs_par.loadfile(ls_file)
if ls_rtn = '' then
	ls_output += "loadstring("+ls_file+") Succeed~r~n"
else
	ls_output += "loadstring("+ls_file+") = "+ls_rtn+"~r~n"
end if
mle_2.text += ls_output
wf_init()
end subroutine

public subroutine wf_init ();ijs_par.loadstring( mle_1.text)

end subroutine

public subroutine wf_jsonparser_query ();//getrootitem,getchilditem,getchildkey,getchildcount,getitemtype,isnullitem
long ll_root,ll_handle1,ll_null,ll_count,ll_root_null,ll_object,ll_object2,ll_array,ll_loop,ll_child
string ls_json,ls_output,ls_key
boolean lb_rtn
jsonitemtype ljs_type
jsongenerator ljs_gen
jsonparser ljs_par
setnull(ll_null)
//getrootitem
ljs_gen = create jsongenerator
ljs_par = create jsonparser
ll_root = ijs_par.getrootitem( )
ls_output = "getrootitem() = "+string(ll_root)+"~r~n"

//getchilditem
//正常参数
ll_handle1 = ijs_par.getchilditem( ll_root,2)
ls_output += "getchilditem() = "+string(ll_handle1)+"~r~n"
//超出范围的index
ll_handle1 = ijs_par.getchilditem( ll_root,32768)
ls_output += "getchilditem(ll_root,32768) = "+string(ll_handle1)+"~r~n"
//负数的index
ll_handle1 = ijs_par.getchilditem( ll_root,-32768)
ls_output += "getchilditem(ll_root,-32768) = "+string(ll_handle1)+"~r~n"
//0的index
ll_handle1 = ijs_par.getchilditem( ll_root,0)
ls_output += "getchilditem(ll_root,0) = "+string(ll_handle1)+"~r~n"
//Null 
ll_handle1 = ijs_par.getchilditem( ll_root,ll_null)
if isnull(ll_handle1) then
	ls_output+= "getchilditem(ll_root,null) = null~r~n"
else
	ls_output += "getchilditem(ll_root,null) = "+string(ll_handle1)+"~r~n"
end if
//getchildkey
//正常参数
ls_key = ijs_par.getchildkey( ll_root, 2)
ls_output += "getchildkey(ll_root,2) = "+ls_key+"~r~n"
//index为0
ls_key = ijs_par.getchildkey( ll_root, 0)
ls_output += "getchildkey(ll_root,0) = "+ls_key+"~r~n"
//index为null
ls_key = ijs_par.getchildkey( ll_root, ll_null)
if isnull(ls_key) then
	ls_output+= "getchildkey(ll_root,null) = null~r~n"
else
	ls_output += "getchildkey(ll_root,null) = "+ls_key+"~r~n"
end if

//getchildcount
//正常参数
ll_count = ijs_par.getchildcount( ll_root)
ls_output += "getchildcount(ll_root) = "+string(ll_count)+"~r~n"
//空jsonparser对象
ll_root_null = ljs_par.getrootitem()
ll_count = ljs_par.getchildcount(ll_root_null)
ls_output += "getchildcount(ll_root_tmp) = "+string(ll_count)+"~r~n"
//Null参数
ll_count = ijs_par.getchildcount( ll_null)
if isnull(ll_count) then
	ls_output += "getchildcount(null) = null~r~n"
else
	ls_output += "getchildcount(null) = "+string(ll_count)+"~r~n"
end if
//0参数时
ll_count = ijs_par.getchildcount( 0)
ls_output += "getchildcount(0) = "+string(ll_count)+"~r~n"
//-1参数时
ll_count = ijs_par.getchildcount( -1)
ls_output += "getchildcount(-1) = "+string(ll_count)+"~r~n"
//getitemtype
ll_object = ljs_gen.createjsonobject( )
ljs_gen.additemstring(ll_object,'string','s_parent')
ljs_gen.additemnumber( ll_object, 'long',12)
ljs_gen.additemblob( ll_object,'blob',blob('test'))
ljs_gen.additemboolean(ll_object,'boolean',true)
ljs_gen.additemdatetime(ll_object,'datetime',datetime('2017-09-12 12:23:23'))
ljs_gen.additemdate( ll_object,"date",2017-09-23)
ljs_gen.additemtime(ll_object,'time',12:23:23)
ljs_gen.additemnull( ll_object,'null')
ll_object2 = ljs_gen.additemobject(ll_object, "child_object")
ljs_gen.additemstring(ll_object2,"child",'childitem')
ll_array = ljs_gen.additemarray( ll_object, 'chidl_array')
ljs_gen.additemstring( ll_array, "星期一")
ljs_gen.additemstring( ll_array, "星期二")
ls_json = ljs_gen.getjsonstring( )
ls_output += "jsonstring= "+ls_json+"~r~n"
ljs_par.loadstring(ls_json)
ll_root = ljs_par.getrootitem( )
ll_count = ljs_par.getchildcount( ll_root)
for ll_loop = 1 to ll_count
	ls_key = ljs_par.getchildkey( ll_root, ll_loop)
	ll_child = ljs_par.getchilditem( ll_root, ll_loop)
	ljs_type = ljs_par.getitemtype(ll_child)
	choose case ljs_type
		case jsonstringitem!
			ls_output+= ls_key+" is jsonstringitem!~r~n"
		case jsonnumberitem!
			ls_output+= ls_key+" is jsonnumberitem!~r~n"
		case jsonbooleanitem!
			ls_output+= ls_key+" is jsonbooleanitem!~r~n"
		case jsonnullitem!
			ls_output+= ls_key+" is jsonnullitem!~r~n"
		case jsonobjectitem!
			ls_output+= ls_key+" is jsonobjectitem!~r~n"
		case jsonarrayitem!
			ls_output+= ls_key+" is jsonarrayitem!~r~n"
		case else
			ls_output += ls_key+" is else~r~n"
	end choose
next
//isnullitem
//ll_object = ljs_gen.createjsonobject( )
//ljs_gen.additemstring(ll_object,'string','test')
//ljs_gen.additemnull( ll_object,'null')
//ijs_par.loadstring( ljs_gen.getjsonstring())
//ll_root = ijs_par.getrootitem( )
////参数为null时
//lb_rtn = ijs_par.isnullitem(ll_null)
//if isnull(lb_rtn) then
//	ls_output += "isnullitem(null) = null~r~n"
//else
//	ls_output += "isnullitem(null) = "+string(lb_rtn)+"~r~n"
//end if
////正常参数暂时未实现该重载函数
//lb_rtn = ijs_par.isnullitem(ll_root,'null')
//if isnull(lb_rtn) then
//	ls_output += "isnullitem(root,null) = null~r~n"
//else
//	ls_output += "isnullitem(root,null) = "+string(lb_rtn)+"~r~n"
//end if
////正常参数
//ll_child = ijs_par.getchilditem( ll_root, 1)
//lb_rtn = ijs_par.isnullitem( ll_child)
//ls_output += "isnullitem() = "+string(lb_rtn)+"~r~n"
//ll_child = ijs_par.getchilditem( ll_root, 2)
//lb_rtn = ijs_par.isnullitem( ll_child)
//ls_output += "isnullitem() = "+string(lb_rtn)+"~r~n"
//lb_rtn = ijs_par.isnullitem(ll_root,'null')
//ls_output += "isnullitem(root,'null') = "+string(lb_rtn)+"~r~n"
////异常参数0
//lb_rtn = ijs_par.isnullitem( 0)
//ls_output += "isnullitem(0) = "+string(lb_rtn)+"~r~n"
////异常参数-1
//lb_rtn = ijs_par.isnullitem( -1)
//ls_output += "isnullitem(-1) = "+string(lb_rtn)+"~r~n"
////异常参数2^63
//lb_rtn = ijs_par.isnullitem( 2^63)
//ls_output += "isnullitem(2^63) = "+string(lb_rtn)+"~r~n"

mle_2.text += ls_output
wf_init()







end subroutine

public subroutine wf_jsonparser_getitem ();//getitem系列函数
long ll_handle,ll_root,ll_null
string ls_key,ls_value,ls_rtn,ls_json,ls_null,ls_output,ls_load
long ll_object,ll_object2
jsonparser ljs_par
jsongenerator ljs_gen
setnull(ll_null)
setnull(ls_null)
ljs_par = create jsonparser
ljs_gen = create jsongenerator
//getitemstring
//Null 参数
ls_value = ljs_par.getitemstring( ll_null)
if isnull(ls_value) then
	ls_output = "getitemstring(null) = null~r~n"
else
	ls_output = "getitemstring(null) = "+ls_value+"~r~n"
end if
ls_value = ljs_par.getitemstring( 0,ls_null)
if isnull(ls_value) then
	ls_output = "getitemstring(null) = null~r~n"
else
	ls_output = "getitemstring(null) = "+ls_value+"~r~n"
end if
//-1 /0句柄
ls_json = '{"name":"test"}'
ljs_par.loadstring( ls_json)
ls_value = ljs_par.getitemstring(-1)
ls_output += "getitemstring(-1) = "+ls_value+"~r~n"
ls_value = ljs_par.getitemstring(0,"name")
ls_output += "getitemstring(-1) = "+ls_value+"~r~n"
//正常句柄
ll_root = ljs_par.getrootitem( )
ll_handle = ljs_par.getchilditem( ll_root,1)
ls_value = ljs_par.getitemstring(ll_handle)
ls_output += "getitemstring(handle) = "+ls_value+"~r~n"
ls_value = ljs_par.getitemstring(ll_root,'name')
ls_output += "getitemstring(root,'name') = "+ls_value+"~r~n"
//特殊字符
ls_json = '{"name":"te~r~nst"}'
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = ljs_par.getitemstring(ll_root,'name')
ls_output += "getitemstring(root,'name') = "+ls_value+"~r~n"
//多字节字符
ls_json = '{"姓名":"李三"}'
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = ljs_par.getitemstring(ll_root,'姓名')
ls_output += "getitemstring(root,'姓名') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root,1)
ls_value = ljs_par.getitemstring(ll_handle)   
ls_output += "getitemstring(handle) = "+ls_value+"~r~n"
//key为空字符时
ls_json = '{"  ":"李三"}'
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = ljs_par.getitemstring(ll_root,'  ')
ls_output += "getitemstring(root,'  ') = "+ls_value+"~r~n"
//Getitemnumber
//Null 参数
ls_value = string(ljs_par.Getitemnumber( ll_null))
if isnull(ls_value) then
	ls_output += "Getitemnumber(null) = null~r~n"
else
	ls_output += "Getitemnumber(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.Getitemnumber( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemnumber(null) = null~r~n"
else
	ls_output += "Getitemnumber(null) = "+ls_value+"~r~n"
end if
//正常句柄
ls_json= '{"number1":34,"number2":453.56090}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.getitemnumber(ll_root, "number2"))
ls_output +="getitemnumber(root,'number2') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.getitemnumber(ll_handle))
ls_output +="getitemnumber(handle) = "+ls_value+"~r~n"
//key为日文字符
ls_json = '{"フルネーム":45}'
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.getitemnumber(ll_root, "フルネーム"))
ls_output +="getitemnumber(root,'フルネーム') = "+ls_value+"~r~n"
//key为空串
ls_json = '{"":567.8}'
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.getitemnumber(ll_root, ""))
ls_output +="getitemnumber(root,'') = "+ls_value+"~r~n"
//数据为非number时
if cbx_1.checked then
	ls_json = '{"number":"test"}'
	ljs_par.loadstring( ls_json)
	ll_root = ljs_par.getrootitem( )
	ls_value = string(ljs_par.getitemnumber(ll_root, "number"))
	ls_output +="getitemnumber(root,'number') = "+ls_value+"~r~n"
end if
//key 错误时
ls_json = '{"number":45}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.getitemnumber(ll_root, "nuber"))
ls_output +="getitemnumber(root,'nuber') = "+ls_value+"~r~n"
//Getitemboolean
//Null参数
ls_value = string(ljs_par.Getitemboolean( ll_null))
if isnull(ls_value) then
	ls_output += "Getitemboolean(null) = null~r~n"
else
	ls_output += "Getitemboolean(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.Getitemboolean( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemboolean(null) = null~r~n"
else
	ls_output += "Getitemboolean(null) = "+ls_value+"~r~n"
end if
//正常参数
ls_json = '{"boolean1":true,"boolean2":false}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemboolean(ll_root, "boolean2"))
ls_output +="Getitemboolean(root,'boolean2') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemboolean(ll_handle))
ls_output +="Getitemboolean(handle) = "+ls_value+"~r~n"
//key为数字
ls_json ='{"42":true}'
ls_load = ljs_par.loadstring( ls_json )
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemboolean(ll_root, "42"))
ls_output +="Getitemboolean(root,'42') = "+ls_value+"~r~n"
//GetitemDate
//Null参数
ls_value = string(ljs_par.GetitemDate( ll_null))
if isnull(ls_value) then
	ls_output += "GetitemDate(null) = null~r~n"
else
	ls_output += "GetitemDate(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.GetitemDate( 0,ls_null))
if isnull(ls_value) then
	ls_output += "GetitemDate(null) = null~r~n"
else
	ls_output += "GetitemDate(null) = "+ls_value+"~r~n"
end if
//正常参数，通过js加载
ls_json = '{"date":"2017-09-08"}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdate(ll_root, "date"))
ls_output +="getitemdate(root,'date') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.getitemdate(ll_handle))
ls_output +="getitemdate(handle) = "+ls_value+"~r~n"
//通过generatoer对象加载
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemdate( ll_object, 'date', 2017-09-08)
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdate(ll_root, "date"))
ls_output +="getitemdate(root,'date') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.getitemdate(ll_handle))
ls_output +="getitemdate(handle) = "+ls_value+"~r~n"
//key为韩文
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemdate( ll_object, '날짜', 2017-09-08)
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdate(ll_root, "날짜"))
ls_output +="getitemdate(root,'날짜') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.getitemdate(ll_handle))
ls_output +="getitemdate(handle) = "+ls_value+"~r~n"
//Getitemtime
//Null参数
ls_value = string(ljs_par.Getitemtime( ll_null))
if isnull(ls_value) then
	ls_output += "Getitemtime(null) = null~r~n"
else
	ls_output += "Getitemtime(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.Getitemtime( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemtime(null) = null~r~n"
else
	ls_output += "Getitemtime(null) = "+ls_value+"~r~n"
end if
//正常参数，通过js加载
ls_json = '{"time":"12:23:23"}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemtime(ll_root, "time"))
ls_output +="Getitemtime(root,'time') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemtime(ll_handle))
ls_output +="Getitemtime(handle) = "+ls_value+"~r~n"
//通过generatoer对象加载
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemtime( ll_object, 'time', 12:23:23)
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemtime(ll_root, "time"))
ls_output +="Getitemtime(root,'time') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemtime(ll_handle))
ls_output +="Getitemtime(handle) = "+ls_value+"~r~n"
//key为阿拉伯文
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemtime( ll_object, 'وقت', 12:23:23)
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemtime(ll_root, "وقت"))
ls_output +="Getitemtime(root,'وقت') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemtime(ll_handle))
ls_output +="Getitemtime(handle) = "+ls_value+"~r~n"
//Getitemdatetime
//Null参数
ls_value = string(ljs_par.Getitemdatetime( ll_null))
if isnull(ls_value) then
	ls_output += "Getitemdatetime(null) = null~r~n"
else
	ls_output += "Getitemdatetime(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.Getitemdatetime( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemdatetime(null) = null~r~n"
else
	ls_output += "Getitemdatetime(null) = "+ls_value+"~r~n"
end if
//正常参数，通过js加载
ls_json = '{"datetime":"2017-09-12 12:23:23"}'
ljs_par.loadstring( ls_json)
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))
ls_output +="Getitemdatetime(root,'datetime') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemdatetime(ll_handle))
ls_output +="Getitemdatetime(handle) = "+ls_value+"~r~n"
//通过generator对象加载
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23"))
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))
ls_output +="Getitemdatetime(root,'datetime') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemdatetime(ll_handle))
ls_output +="Getitemdatetime(handle) = "+ls_value+"~r~n"
//key为德文
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemdatetime( ll_object, 'Datumäöüß', datetime("2017-09-12 12:23:23"))
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemdatetime(ll_root,"Datumäöüß"))
ls_output +="Getitemdatetime(root,'Datumäöüß') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemdatetime(ll_handle))
ls_output +="Getitemdatetime(handle) = "+ls_value+"~r~n"
//GetItemBlob
//Null参数
ls_value = string(ljs_par.GetItemBlob( ll_null))
if isnull(ls_value) then
	ls_output += "GetItemBlob(null) = null~r~n"
else
	ls_output += "GetItemBlob(null) = "+ls_value+"~r~n"
end if
ls_value = string(ljs_par.GetItemBlob( 0,ls_null))
if isnull(ls_value) then
	ls_output += "GetItemBlob(null) = null~r~n"
else
	ls_output += "GetItemBlob(null) = "+ls_value+"~r~n"
end if
//通过generator对象加载
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemblob( ll_object, 'blob', blob("Test测试"))
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemblob(ll_root, "blob"))
ls_output +="Getitemblob(root,'blob') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemblob(ll_handle))
ls_output +="Getitemblob(handle) = "+ls_value+"~r~n"
//key为西班牙文  borrón
ll_object = ljs_gen.createjsonobject()
ljs_gen.additemblob( ll_object, 'borrón', blob("borrón测试"))
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemblob(ll_root, "borrón"))
ls_output +="Getitemblob(root,'borrón') = "+ls_value+"~r~n"
ll_handle = ljs_par.getchilditem( ll_root, 1)
ls_value = string(ljs_par.Getitemblob(ll_handle))
ls_output +="Getitemblob(handle) = "+ls_value+"~r~n"
//Getitemobject
//Null参数
ls_value = string(ljs_par.Getitemobject( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemobject(null) = null~r~n"
else
	ls_output += "Getitemobject(null) = "+ls_value+"~r~n"
end if
//通过generator对象加载
ll_object = ljs_gen.createjsonobject()
ll_object2 = ljs_gen.additemobject( ll_object, 'object')
ljs_gen.additemstring(ll_object2,'name',"test1")
ljs_gen.additemnumber( ll_object2,'number',34)
ljs_gen.additemstring(ll_object2,'Null','null')
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemobject(ll_root, "object"))
ls_output +="Getitemobject(root,'object') = "+ls_value+"~r~n"
ls_output+="Child count of the object is "+string(ljs_par.getchildcount( long(ls_value)))+"~r~n"
//key为俄文 Россия
ll_object = ljs_gen.createjsonobject()
ll_object2 = ljs_gen.additemobject( ll_object, 'Россия')
ljs_gen.additemstring(ll_object2,'name',"test1Россия")
ljs_gen.additemnumber( ll_object2, 34)
ljs_gen.additemstring(ll_object2,'Null','null')
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemobject(ll_root, "Россия"))
ls_output +="Getitemobject(root,'Россия') = "+ls_value+"~r~n"
ls_output+="Child count of the object is "+string(ljs_par.getchildcount( long(ls_value)))+"~r~n"
//Getitemarray
//Null参数
ls_value = string(ljs_par.Getitemarray( 0,ls_null))
if isnull(ls_value) then
	ls_output += "Getitemarray(null) = null~r~n"
else
	ls_output += "Getitemarray(null) = "+ls_value+"~r~n"
end if
//通过generator对象加载
ll_object = ljs_gen.createjsonobject()
ll_object2 = ljs_gen.additemarray( ll_object, 'array')
ljs_gen.additemstring(ll_object2,"test1")
ljs_gen.additemnumber( ll_object2, 34)
ljs_gen.additemstring(ll_object2,'null')
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemarray(ll_root, "array"))
ls_output +="Getitemobject(root,'array') = "+ls_value+"~r~n"
ls_output+="Child count of the object is "+string(ljs_par.getchildcount( long(ls_value)))+"~r~n"
//key为泰文 วาล์วด้วยมือ
ll_object = ljs_gen.createjsonobject()
ll_object2 = ljs_gen.additemarray( ll_object, 'วาล์วด้วยมือ')
ljs_gen.additemstring(ll_object2,"test1วาล์วด้วยมือ")
ljs_gen.additemnumber( ll_object2, 34)
ljs_gen.additemstring(ll_object2,'Null')
ls_json = ljs_gen.getjsonstring( )
ls_load = ljs_par.loadstring( ls_json)
ls_output += "loadstring("+ls_json+") = "+ls_load+"~r~n"
ll_root = ljs_par.getrootitem( )
ls_value = string(ljs_par.Getitemarray(ll_root, "วาล์วด้วยมือ"))
ls_output +="Getitemobject(root,'วาล์วด้วยมือ') = "+ls_value+"~r~n"
ls_output+="Child count of the object is "+string(ljs_par.getchildcount( long(ls_value)))+"~r~n"
mle_2.text +=ls_output
wf_init()




















end subroutine

public subroutine wf_jsongenerator_classic ();//  jsongenerator对象 标准pb对象测试
jsongenerator ljs_gen,ljs_gen2
string ls_output,ls_rtn,ls_value
long ll_root,ll_object

ljs_gen = create jsongenerator
ls_rtn = ljs_gen.classname( )
ls_output = "classname() = "+ls_rtn+"~r~n"


if  ljs_gen.typeof( ) = jsongenerator! then
	ls_output += "typeof() = jsongenerator!~r~n"
else
	ls_output += "typeof() <> jsongenerator!~r~n"
end if

ll_object = ljs_gen.createjsonobject()
ljs_gen.additemnumber(ll_object,"id",100)
ljs_gen.additemstring(ll_object,"Text","test")
openwithparm(w_tmp_generator,ljs_gen)
ljs_gen2 = message.powerobjectparm
ls_value = ljs_gen2.getjsonstring()
ls_output += "return from message is "+ls_value+"~r~n"
//create/destroy
destroy ljs_gen
if isvalid(ljs_gen) then
	ls_output += "Error, After Destroy the object,it is still valid~r~n"
else
	ls_output += "The object is destoyed!~r~n"
end if
ljs_gen = create using "jsongenerator"
if isvalid(ljs_gen) then
	ls_output += "The object was created~r~n"
else
	ls_output += "Error, Create the object failed~r~n"
end if
ll_object = ljs_gen.createjsonobject()
ls_rtn = string(ljs_gen.additemnumber(ll_object,"id",100))
ls_output += "additemnumber(object,'id',100) = "+ls_rtn+"~r~n"

destroy ljs_gen
destroy ljs_gen2
mle_2.text += ls_output

end subroutine

public subroutine wf_jsongenerator_inout ();//createjsonobject,createjsonarray
long ll_object1,ll_object2,ll_rtn
string ls_output,ls_rtn,ls_null,ls_file,ls_path
blob lb_data
jsongenerator ljs_gen
setnull(ls_null)
//异常捕捉
try
	ljs_gen.createjsonobject()
catch (runtimeerror err)
	ls_output = err.getmessage()+"~r~n"
end try
ljs_gen = create jsongenerator
ll_object1 = ljs_gen.createjsonobject()
ls_output += "First createjsonobject = "+string(ll_object1)+"~r~n"
ll_object2 = ljs_gen.createjsonobject()
ls_output += "Second createjsonobject = "+string(ll_object1)+"~r~n"
ll_rtn = ljs_gen.additemstring(ll_object1,"name",'test')
ls_output += "Additem to first object = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemstring(ll_object2,"name",'test')
ls_output += "Additem to second object = "+string(ll_rtn)+"~r~n"
ll_object1 = ljs_gen.createjsonarray()
ls_output += "First createjsonarray = "+string(ll_object1)+"~r~n"
ll_object2 = ljs_gen.createjsonarray()
ls_output += "Second createjsonarray = "+string(ll_object1)+"~r~n"
ll_rtn = ljs_gen.additemstring(ll_object1,'test')
ls_output += "Additem to first object = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemstring(ll_object2,'test')
ls_output += "Additem to second object = "+string(ll_rtn)+"~r~n"

//输出 getjsonstring,getjsonblob,savetofile
//重新初始化jsongenerator
destroy ljs_gen
ljs_gen = create jsongenerator
//空对象保存为string
ls_rtn = ljs_gen.getjsonstring( )
ls_output+= "空变量 To string = "+ls_rtn+"~r~n"
ljs_gen.createjsonobject( )
ls_rtn = ljs_gen.getjsonstring( )
ls_output+="Createjsonobject 后 to string = "+ls_rtn+"~r~n"
ljs_gen.createjsonarray()
ls_rtn = ljs_gen.getjsonstring( )
ls_output+="Createjsonarray 后 to string = "+ls_rtn+"~r~n"
//object 数据
ll_object1 = ljs_gen.createjsonobject( )
ll_object2 = ljs_gen.additemobject( ll_object1,"object1")
ljs_gen.additemstring( ll_object2, "Testobject2","Test")
ljs_gen.additemboolean( ll_object2,"booleanvalue",True)
ljs_gen.additemnumber(ll_object2,"number",24.5)
ll_object2 = ljs_gen.additemarray( ll_object2, "星期")
ljs_gen.additemstring(ll_object2,"一")
ljs_gen.additemstring(ll_object2,"二")
ljs_gen.additemstring(ll_object2,"三")
ljs_gen.additemstring(ll_object2,"四")
ljs_gen.additemstring(ll_object2,"五")
ljs_gen.additemdate( ll_object1, "日期", 2017-10-17)
ls_rtn = ljs_gen.getjsonstring( )
ls_output += "json string = "+ls_rtn+"~r~n"
//array数据
ll_object1 = ljs_gen.createjsonarray( )
ll_object2 = ljs_gen.additemobject( ll_object1)
ljs_gen.additemstring( ll_object2, "Testobject2","Test")
ljs_gen.additemboolean( ll_object2,"booleanvalue",True)
ljs_gen.additemnumber(ll_object2,"number",24.5)
ll_object2 = ljs_gen.additemarray( ll_object2, "星期")
ljs_gen.additemstring(ll_object2,"一")
ljs_gen.additemstring(ll_object2,"二")
ljs_gen.additemstring(ll_object2,"三")
ljs_gen.additemstring(ll_object2,"四")
ljs_gen.additemstring(ll_object2,"五")
ljs_gen.additemdate( ll_object1, 2017-10-17)
ll_object2 = ljs_gen.additemarray( ll_object1)
ljs_gen.additemstring(ll_object2,"六")
ljs_gen.additemstring(ll_object2,"⑥")
ljs_gen.additemstring(ll_object2,"Ⅵ")
ljs_gen.additemstring(ll_object2,"日")
ls_rtn = ljs_gen.getjsonstring( )
ls_output += "json string = "+ls_rtn+"~r~n"

//getjsonblob
destroy ljs_gen
ljs_gen = create jsongenerator
//空对象保存为blob
lb_data = ljs_gen.getjsonblob( )
ls_output+= "空变量 To blob = "+string(lb_data)+"~r~n"
ljs_gen.createjsonobject( )
lb_data = ljs_gen.getjsonblob( )
ls_output+="Createjsonobject 后 to string = "+string(lb_data)+"~r~n"
ljs_gen.createjsonarray()
lb_data = ljs_gen.getjsonblob( )
ls_output+="Createjsonarray 后 to string = "+string(lb_data)+"~r~n"
//object 数据
ll_object1 = ljs_gen.createjsonobject( )
ll_object2 = ljs_gen.additemobject( ll_object1,"object1")
ljs_gen.additemstring( ll_object2, "Testobject2","Test")
ljs_gen.additemboolean( ll_object2,"booleanvalue",True)
ljs_gen.additemnumber(ll_object2,"number",24.5)
ll_object2 = ljs_gen.additemarray( ll_object2, "星期")
ljs_gen.additemstring(ll_object2,"一")
ljs_gen.additemstring(ll_object2,"二")
ljs_gen.additemstring(ll_object2,"三")
ljs_gen.additemstring(ll_object2,"四")
ljs_gen.additemstring(ll_object2,"五")
ljs_gen.additemdate( ll_object1, "日期", 2017-10-17)
lb_data = ljs_gen.getjsonblob( )
ls_output += "json blob = "+string(lb_data)+"~r~n"
//array数据
ll_object1 = ljs_gen.createjsonarray( )
ll_object2 = ljs_gen.additemobject( ll_object1)
ljs_gen.additemstring( ll_object2, "Testobject2","Test")
ljs_gen.additemboolean( ll_object2,"booleanvalue",True)
ljs_gen.additemnumber(ll_object2,"number",24.5)
ll_object2 = ljs_gen.additemarray( ll_object2, "星期")
ljs_gen.additemstring(ll_object2,"一")
ljs_gen.additemstring(ll_object2,"二")
ljs_gen.additemstring(ll_object2,"三")
ljs_gen.additemstring(ll_object2,"四")
ljs_gen.additemstring(ll_object2,"五")
ljs_gen.additemdate( ll_object1, 2017-10-17)
ll_object2 = ljs_gen.additemarray( ll_object1)
ljs_gen.additemstring(ll_object2,"六")
ljs_gen.additemstring(ll_object2,"⑥")
ljs_gen.additemstring(ll_object2,"Ⅵ")
ljs_gen.additemstring(ll_object2,"日")
lb_data = ljs_gen.getjsonblob( )
ls_output += "json blob = "+string(lb_data)+"~r~n"

//savetofile
destroy ljs_gen
ljs_gen = create jsongenerator
ll_object1 = ljs_gen.createjsonarray( )
ll_object2 = ljs_gen.additemobject( ll_object1)
ljs_gen.additemstring( ll_object2, "Testobject2","Test")
ljs_gen.additemboolean( ll_object2,"booleanvalue",True)
ljs_gen.additemnumber(ll_object2,"number",24.5)
ll_object2 = ljs_gen.additemarray( ll_object2, "星期")
ljs_gen.additemstring(ll_object2,"一")
ljs_gen.additemstring(ll_object2,"二")
ljs_gen.additemstring(ll_object2,"三")
ljs_gen.additemstring(ll_object2,"四")
ljs_gen.additemstring(ll_object2,"五")
ljs_gen.additemdate( ll_object1, 2017-10-17)
ll_object2 = ljs_gen.additemarray( ll_object1)
ljs_gen.additemstring(ll_object2,"六")
ljs_gen.additemstring(ll_object2,"⑥")
ljs_gen.additemstring(ll_object2,"Ⅵ")
ljs_gen.additemstring(ll_object2,"日")
//文件为Null
ll_rtn = ljs_gen.savetofile( ls_null)
if isnull(ll_rtn) then
	ls_output += "savetofile(null) = null~r~n"
else
	ls_output += "savetofile(null) = "+string(ll_rtn)+"~r~n"
end if
//保存为txt(文件不存在时)
ls_file = "createjson.txt"
filedelete(ls_file)
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为txt(文件已存在)
ls_file = "testforsave.txt"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//文件被占用
ls_file = getcurrentdirectory()+"\testforsave.txt"
run("notepad "+ls_file)
ls_file = "testforsave.txt"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//无权限的路径
ls_file = "C:\Windows\System32\testforsave.txt"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为docx文件
ls_file = "createforjson.docx"
filedelete(ls_file)
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存到已存在的docx
//ls_file = getcurrentdirectory()+"\testforsave.docx"
//run("WINWORD "+ls_file)
ls_file = "testforsave.docx"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为pdf
ls_file = "temp.pdf"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为xml
ls_file = "temp.xml"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为html
ls_file = "temp.html"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
//保存为excel
ls_file = "temp.xlsx"
ll_rtn = ljs_gen.savetofile( ls_file)
ls_output += "savetofile("+ls_file+") = "+string(ll_rtn)+"~r~n"
mle_2.text += ls_output








end subroutine

public subroutine wf_jsgenerate_additem ();//additem系列函数
jsongenerator ljs_gen
string ls_output,ls_rtn,ls_value
long ll_object,ll_rtn,ll_object2,ll_null
string ls_json
setnull(ll_null)
ljs_gen = create jsongenerator
ll_object = ljs_gen.createjsonobject( )
ll_object2 = ljs_gen.additemarray( ll_object, "array")
//additemstring
//null参数
ll_rtn = ljs_gen.additemstring( ll_null, '','')
if isnull(ll_rtn) then
	ls_output += "additemstring(null,'','') = null~r~n"
else
	ls_output += "additemstring(null,'','') = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemstring( ll_null, '')
if isnull(ll_rtn) then
	ls_output += "additemstring(null,'') = null~r~n"
else
	ls_output += "additemstring(null,'') = "+string(ll_rtn)+"~r~n"
end if
//句柄为-1
ll_rtn = ljs_gen.additemstring( -1, 'test','test')
ls_output += "additemstring(-1,'test','test') = "+string(ll_rtn)+"~r~n"
//正常参数
ll_rtn = ljs_gen.additemstring( ll_object, 'test','test')
ls_output += "additemstring(obejct,'test','test') = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemstring( ll_object2, 'test')
ls_output += "additemstring(array,'test') = "+string(ll_rtn)+"~r~n"
//往数组下插入key，对象下不插入key
ll_rtn = ljs_gen.additemstring( ll_object2, 'test','test')
ls_output += "additemstring(arry,'test','test') = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemstring( ll_object, 'test')
ls_output += "additemstring(object,'test') = "+string(ll_rtn)+"~r~n"
//key为泰文 วาล์วด้วยมือ
ll_rtn = ljs_gen.additemstring( ll_object, 'วาล์วด้วยมือ','วาล์วด้วยมือtest')
ls_output += "additemstring(obejct,'วาล์วด้วยมือ','วาล์วด้วยมือtest') = "+string(ll_rtn)+"~r~n"
//additemnumber
ll_rtn = ljs_gen.additemnumber( ll_null, '',123)
if isnull(ll_rtn) then
	ls_output += "additemnumber(null,'',123) = null~r~n"
else
	ls_output += "additemnumber(null,'',123) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemnumber( ll_null, 123)
if isnull(ll_rtn) then
	ls_output += "additemnumber(null,123) = null~r~n"
else
	ls_output += "additemnumber(null,123) = "+string(ll_rtn)+"~r~n"
end if
//句柄为0
ll_rtn = ljs_gen.additemnumber( 0, 'test',123)
ls_output += "additemnumber(0,'test',123) = "+string(ll_rtn)+"~r~n"
//数值为0
ll_rtn = ljs_gen.additemnumber( ll_object, 'test',0)
ls_output += "additemnumber(object,'test',0) = "+string(ll_rtn)+"~r~n"
//value为负数-32768
ll_rtn = ljs_gen.additemnumber( ll_object, 'test',-32768)
ls_output += "additemnumber(object,'test',-32768) = "+string(ll_rtn)+"~r~n"
//value为科学计数法
ll_rtn = ljs_gen.additemnumber( ll_object, 'test',1.79e+308)
ls_output += "additemnumber(object,'test',1.79e+308) = "+string(ll_rtn)+"~r~n"
//key为中文
ll_rtn = ljs_gen.additemnumber( ll_object, '序号',100)
ls_output += "additemnumber(object,'序号',100) = "+string(ll_rtn)+"~r~n"
//正常数据
ll_rtn = ljs_gen.additemnumber( ll_object, 'test',12.4)
ls_output += "additemnumber(obejct,'test',12.4) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemnumber( ll_object2, 12)
ls_output += "additemnumber(array,12) = "+string(ll_rtn)+"~r~n"
//additemboolean
//null参数
ll_rtn = ljs_gen.additemboolean( ll_null, '',true)
if isnull(ll_rtn) then
	ls_output += "additemboolean(null,'',true) = null~r~n"
else
	ls_output += "additemboolean(null,'',true) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemboolean( ll_null, true)
if isnull(ll_rtn) then
	ls_output += "additemboolean(null,true) = null~r~n"
else
	ls_output += "additemboolean(null,true) = "+string(ll_rtn)+"~r~n"
end if
//value为表达式
ll_rtn = ljs_gen.additemboolean( ll_object, 'test',1=1)
ls_output += "additemboolean(obejct,'test',1=1) = " +string(ll_rtn)+"~r~n"
//value为窗体属性
ll_rtn = ljs_gen.additemboolean( ll_object, 'test',this.visible)
ls_output += "additemboolean(obejct,'test',this.visible) = " +string(ll_rtn)+"~r~n"
//value 为isjsonvalid函数
ll_rtn = ljs_gen.additemboolean( ll_object, 'test',true)
ls_output += "additemboolean(obejct,'test',ljs_gen.isjsonvalid()) = " +string(ll_rtn)+"~r~n"
//正常值
ll_rtn = ljs_gen.additemboolean( ll_object, 'test',true)
ls_output += "additemboolean(obejct,'test',true) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemboolean( ll_object2, false)
ls_output += "additemboolean(array,false) = "+string(ll_rtn)+"~r~n"
//additemdate
//null参数
ll_rtn = ljs_gen.additemdate( ll_null, '',today())
if isnull(ll_rtn) then
	ls_output += "additemdate(null,'',today()) = null~r~n"
else
	ls_output += "additemdate(null,'',today()) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemdate( ll_null, today())
if isnull(ll_rtn) then
	ls_output += "additemdate(null,today()) = null~r~n"
else
	ls_output += "additemdate(null,today()) = "+string(ll_rtn)+"~r~n"
end if
//yyyy-mm-dd
ll_rtn = ljs_gen.additemdate( ll_object, 'test',2017-09-18)
ls_output += "additemdate(obejct,'test',2017-09-18) = " +string(ll_rtn)+"~r~n"
//yy-mm-dd
ll_rtn = ljs_gen.additemdate( ll_object, 'test',date('17-09-18'))
ls_output += "additemdate(obejct,'test',17-09-18) = " +string(ll_rtn)+"~r~n"
//mm-dd-yyyy
ll_rtn = ljs_gen.additemdate( ll_object, 'test',date("09-18-2017"))
ls_output += "additemdate(obejct,'test',09-18-2017) = " +string(ll_rtn)+"~r~n"
//正常值
ll_rtn = ljs_gen.additemdate( ll_object, 'test',today())
ls_output += "additemdate(obejct,'test',today()) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemdate( ll_object2, today())
ls_output += "additemdate(array,today()) = "+string(ll_rtn)+"~r~n"
//additemtime
//null参数
ll_rtn = ljs_gen.additemtime( ll_null, '',now())
if isnull(ll_rtn) then
	ls_output += "additemtime(null,'',now()) = null~r~n"
else
	ls_output += "additemtime(null,'',now()) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemtime( ll_null, now())
if isnull(ll_rtn) then
	ls_output += "additemtime(null,now()) = null~r~n"
else
	ls_output += "additemtime(null,now()) = "+string(ll_rtn)+"~r~n"
end if
//带毫秒
ll_rtn = ljs_gen.additemtime( ll_object, 'test',time("12:34:45:454"))
ls_output += "additemtime(obejct,'test',12:34:45:454) = " +string(ll_rtn)+"~r~n"
//key为阿拉伯文วาล์วด้วยมือ
ll_rtn = ljs_gen.additemtime( ll_object, 'วาล์วด้วยมือ',time("12:34:45:454"))
ls_output += "additemtime(obejct,'วาล์วด้วยมือ',12:34:45:454) = " +string(ll_rtn)+"~r~n"
//正常值
ll_rtn = ljs_gen.additemtime( ll_object, 'test',now())
ls_output += "additemtime(obejct,'test',now()) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemtime( ll_object2, now())
ls_output += "additemtime(array,now()) = "+string(ll_rtn)+"~r~n"
//additemdatatime
//null参数
ll_rtn = ljs_gen.additemdatetime( ll_null, '',datetime(today(),now()))
if isnull(ll_rtn) then
	ls_output += "additemdatetime(null,'',datetime(today(),now())) = null~r~n"
else
	ls_output += "additemdatetime(null,'',datetime(today(),now())) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemdatetime( ll_null, datetime(today(),now()))
if isnull(ll_rtn) then
	ls_output += "additemdatetime(null,datetime(today(),now())) = null~r~n"
else
	ls_output += "additemdatetime(null,datetime(today(),now())) = "+string(ll_rtn)+"~r~n"
end if
//key为韩文  날짜
ll_rtn = ljs_gen.additemdatetime( ll_object, '날짜',datetime(today(),now()))
ls_output += "additemdatetime(obejct,'날짜',datetime(today(),now())) = "+string(ll_rtn)+"~r~n"
//正常值
ll_rtn = ljs_gen.additemdatetime( ll_object, 'test',datetime(today(),now()))
ls_output += "additemdatetime(obejct,'test',datetime(today(),now())) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemdatetime( ll_object2, datetime(today(),now()))
ls_output += "additemdatetime(array,datetime(today(),now())) = "+string(ll_rtn)+"~r~n"
//ll_rtn = ljs_gen.additemdatetime( ll_object, 'test',datetime(today(),now()),true)
//ls_output += "additemdatetime(obejct,'test',datetime(today(),now()),true) = "+string(ll_rtn)+"~r~n"
//ll_rtn = ljs_gen.additemdatetime( ll_object2, datetime(today(),now()),false)
//ls_output += "additemdatetime(array,datetime(today(),now()),false) = "+string(ll_rtn)+"~r~n"

//additemblob
//null参数
ll_rtn = ljs_gen.additemblob( ll_null, '',blob(''))
if isnull(ll_rtn) then
	ls_output += "additemblob(null,'',blob('')) = null~r~n"
else
	ls_output += "additemblob(null,'',blob('')) = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemblob( ll_null, blob(''))
if isnull(ll_rtn) then
	ls_output += "additemblob(null,blob('')) = null~r~n"
else
	ls_output += "additemblob(null,blob('')) = "+string(ll_rtn)+"~r~n"
end if
//正常值
ll_rtn = ljs_gen.additemblob( ll_object, 'test',blob('测试使用DE'))
ls_output += "additemblob(obejct,'test'blob('测试使用DE')) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemblob( ll_object2, blob('测试使用DE'))
ls_output += "additemblob(array,blob('测试使用DE')) = "+string(ll_rtn)+"~r~n"
//key为西班牙文borrón
ll_rtn = ljs_gen.additemblob( ll_object, 'borrón',blob('测试使用borrón'))
ls_output += "additemblob(obejct,'borrón'blob('测试使用borrón')) = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemblob( ll_object2, blob('测试使用borrónDE'))
ls_output += "additemblob(array,blob('测试使用DE')) = "+string(ll_rtn)+"~r~n"
//additemnull
//null参数
ll_rtn = ljs_gen.additemnull( ll_null, '')
if isnull(ll_rtn) then
	ls_output += "additemnull(null,'') = null~r~n"
else
	ls_output += "additemnull(null,'') = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemnull( ll_null)
if isnull(ll_rtn) then
	ls_output += "additemnull(null) = null~r~n"
else
	ls_output += "additemnull(null) = "+string(ll_rtn)+"~r~n"
end if
//正常值
ll_rtn = ljs_gen.additemnull( ll_object, 'test')
ls_output += "additemnull(obejct,'test') = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemnull( ll_object2)
ls_output += "additemnull(array) = "+string(ll_rtn)+"~r~n"
//key为日文 フルネーム
ll_rtn = ljs_gen.additemnull( ll_object, 'フルネーム')
ls_output += "additemnull(obejct,'フルネーム') = "+string(ll_rtn)+"~r~n"
//additemobject
//null参数
ll_rtn = ljs_gen.additemobject( ll_null, '')
if isnull(ll_rtn) then
	ls_output += "additemobject(null,'') = null~r~n"
else
	ls_output += "additemobject(null,'') = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemobject( ll_null)
if isnull(ll_rtn) then
	ls_output += "additemobject(null) = null~r~n"
else
	ls_output += "additemobject(null) = "+string(ll_rtn)+"~r~n"
end if
//正常数据
ll_rtn = ljs_gen.additemobject( ll_object, 'test测试')
ls_output += "additemnull(obejct,'test测试') = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemobject( ll_object2)
ls_output += "additemnull(array) = "+string(ll_rtn)+"~r~n"
//key为俄文 Россия
ll_rtn = ljs_gen.additemobject( ll_object, 'Россия测试')
ls_output += "additemnull(obejct,'Россия测试') = "+string(ll_rtn)+"~r~n"
//additemarray
//null参数
ll_rtn = ljs_gen.additemarray( ll_null, '')
if isnull(ll_rtn) then
	ls_output += "additemarray(null,'') = null~r~n"
else
	ls_output += "additemarray(null,'') = "+string(ll_rtn)+"~r~n"
end if
ll_rtn = ljs_gen.additemarray( ll_null)
if isnull(ll_rtn) then
	ls_output += "additemarray(null) = null~r~n"
else
	ls_output += "additemarray(null) = "+string(ll_rtn)+"~r~n"
end if
//正常数据
ll_rtn = ljs_gen.additemarray( ll_object, 'test测试')
ls_output += "additemarray(obejct,'test测试') = "+string(ll_rtn)+"~r~n"
ll_rtn = ljs_gen.additemarray( ll_object2)
ls_output += "additemarray(array) = "+string(ll_rtn)+"~r~n"
ls_json = ljs_gen.getjsonstring( )
ls_output += "ljs_gen.getjsonstring() = "+ls_json+"~r~n"
//isjsonvalid
destroy ljs_gen
//ljs_gen = create jsongenerator
//ls_rtn = string(ljs_gen.isjsonvalid( ))
//ls_output += "空jsongeneraotr isjsonvalid() = "+ls_rtn+"~r~n"
//ll_object = ljs_gen.createjsonobject( )
//ls_rtn = string(ljs_gen.isjsonvalid( ))
//ls_output += "createjsonobject后 isjsonvalid() = "+ls_rtn+"~r~n"
//ljs_gen.additemstring(ll_object,'test')
//ls_rtn = string(ljs_gen.isjsonvalid( ))
//ls_output += "错误数据 isjsonvalid() = "+ls_rtn+"~r~n"
//ljs_gen.additemstring(ll_object,'test',"testdata")
//ls_rtn = string(ljs_gen.isjsonvalid( ))
//ls_output += "正确数据后数据 isjsonvalid() = "+ls_rtn+"~r~n"
//ls_json = ljs_gen.getjsonstring( )
//ls_output += "ljs_gen.getjsonstring() = "+ls_json+"~r~n"
mle_2.text += ls_output







end subroutine

public subroutine wf_gettmpfile ();//
long ll_file
string ls_file
ls_file = "jsontmp.tmp"
filedelete(ls_file)
ll_file = fileopen(ls_file,textmode!,write!,shared!,replace!)
filewriteex(ll_file,mle_1.text)
fileclose(ll_file)
end subroutine

public subroutine wf_parm_area ();
long ll_object,ll_array,ll_object2,ll_root,ll_count
string ls_json,ls_output,ls_rtn
jsongenerator ljs_gen
jsonparser ljs_par
ljs_par = create jsonparser
ljs_gen = create jsongenerator
str_json_new lstr_json

//构建jsongenerator数据
ll_object = ljs_gen.createjsonobject( )
ljs_gen.additemstring(ll_object,'string','s_parent')
ljs_gen.additemnumber( ll_object, 'long',12)
ljs_gen.additemblob( ll_object,'blob',blob('test'))
ljs_gen.additemboolean(ll_object,'boolean',true)
ljs_gen.additemdatetime(ll_object,'datetime',datetime('2017-09-12 12:23:23'))
ljs_gen.additemdate( ll_object,"date",2017-09-23)
ljs_gen.additemtime(ll_object,'time',12:23:23)
ljs_gen.additemnull( ll_object,'null')
ll_object2 = ljs_gen.additemobject(ll_object, "child_object")
ljs_gen.additemstring(ll_object2,"child1",'childitem1')
ljs_gen.additemstring(ll_object2,"child2",'childitem2')
ll_array = ljs_gen.additemarray( ll_object, 'chidl_array')
ljs_gen.additemstring( ll_array, "星期一")
ljs_gen.additemstring( ll_array, "星期二")
//构建jsonparser数据
ls_json = ljs_gen.getjsonstring( )
ljs_par.loadstring(ls_json)

//通过全局函数调用结构体查看返回值
lstr_json.str_gen = ljs_gen
lstr_json.str_par = ljs_par
ls_rtn = gf_getjsonstring(lstr_json)
ls_output+= "Return from gf_getjsonstring = "+ls_rtn+"~r~n"
//
//将临时变量赋值给实例变量
ijs_par = ljs_par
ijs_gen = ljs_gen
ll_root = ijs_par.getrootitem( )
ll_count = ijs_par.getchildcount(ll_root)
ls_output+= " ijs_par.getchildcount() = "+string(ll_count)+"~r~n"
//ls_output+= " ijs_gen.isjsonvalid() = "+string(ijs_gen.isjsonvalid() )+"~r~n"
//destroy 实例变量重新赋值
//destroy ijs_par
//destroy ijs_gen
//ijs_par = ljs_par
//ijs_gen = ljs_gen
//ll_root = ijs_par.getrootitem( )
//ll_count = ijs_par.getchildcount(ll_root)
//ls_output+= "destroy ijs_par重新赋值 ijs_par.getchildcount() = "+string(ll_count)+"~r~n"
//ls_output+= " destroy ijs_gen重新赋值ijs_gen.isjsonvalid() = "+string(ijs_gen.isjsonvalid() )+"~r~n"
//destroy临时变量，查看实例变量是否受影响
//destroy ljs_par
//destroy ljs_gen
//ll_root = ijs_par.getrootitem( )
//ll_count = ijs_par.getchildcount(ll_root)
//ls_output+= "destroy ljs_par重新赋值 ijs_par.getchildcount() = "+string(ll_count)+"~r~n"
//ls_output+= " destroy ljs_gen重新赋值ijs_gen.isjsonvalid() = "+string(ijs_gen.isjsonvalid() )+"~r~n"
//将实例变量赋值给全局变量
gjs_par = ijs_par
gjs_gen = ijs_gen
ll_root = gjs_par.getrootitem( )
ll_count = gjs_par.getchildcount(ll_root)
ls_output+= " gjs_par.getchildcount() = "+string(ll_count)+"~r~n"
//ls_output+= " gjs_gen.isjsonvalid() = "+string(gjs_gen.isjsonvalid() )+"~r~n"
//性能测试
if cbx_2.checked then
	uo_1.cb_1.triggerevent( clicked!)
	ls_output += uo_1.mle_1.text
end if
//释放实例变量后，查看数据返回
//destroy ijs_par
//destroy ijs_gen
//ll_root = gjs_par.getrootitem( )
//ll_count = gjs_par.getchildcount(ll_root)
//ls_output+= "释放ijs_par后 gjs_par.getchildcount() = "+string(ll_count)+"~r~n"
//ls_output+= "释放ijs_gen后gjs_gen.isjsonvalid() = "+string(gjs_gen.isjsonvalid() )+"~r~n"
//通过any，获取json的节点数
ll_count = gf_parser_any(gjs_par)
ls_output += "gf_parser_any(gjs_par) = "+string(ll_count)+"~r~n"

mle_2.text += ls_output
wf_init()


end subroutine

public subroutine wf_string_encoding ();//字符串的四种编码，分别调用loadstring，查看能否加载成功
string  ls_json,ls_tmp,ls_output,ls_rtn
string ls_name
blob lb_encoding
long ll_root

ls_tmp = '{"id":45,"name":"李三"}'

if not isvalid(gjs_par) then gjs_par = create jsonparser

//将字符串变为ANSI编码
lb_encoding = blob(ls_tmp,EncodingANSI!)
ls_json = string(lb_encoding,EncodingANSI!)
ls_rtn = gjs_par.loadstring(ls_json)
if len(ls_rtn) = 0 then
	ls_output += "gjs_par.loadstring("+ls_json+") Succeed!"+"~r~n"
else
	ls_output += "gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn+"~r~n"
end if
ll_root = gjs_par.getrootitem( )
ls_name = gjs_par.getitemstring(ll_root,"name")
ls_output += "getitemstring(root,name)= "+ls_name+"~r~n"

//将字符串变为UTF8编码
lb_encoding = blob(ls_tmp,EncodingUTF8!)
ls_json = string(lb_encoding,EncodingUTF8!)
ls_rtn = gjs_par.loadstring(ls_json)
if len(ls_rtn) = 0 then
	ls_output += "gjs_par.loadstring("+ls_json+") Succeed!"+"~r~n"
else
	ls_output += "gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn+"~r~n"
end if
ll_root = gjs_par.getrootitem( )
ls_name = gjs_par.getitemstring(ll_root,"name")
ls_output += "getitemstring(root,name)= "+ls_name+"~r~n"

//将字符串变为UTF16LE编码
lb_encoding = blob(ls_tmp,EncodingUTF16LE!)
ls_json = string(lb_encoding,EncodingUTF16LE!)
ls_rtn = gjs_par.loadstring(ls_json)
if len(ls_rtn) = 0 then
	ls_output += "gjs_par.loadstring("+ls_json+") Succeed!"+"~r~n"
else
	ls_output += "gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn+"~r~n"
end if
ll_root = gjs_par.getrootitem( )
ls_name = gjs_par.getitemstring(ll_root,"name")
ls_output += "getitemstring(root,name)= "+ls_name+"~r~n"

//将字符串变为UTF16BE编码
lb_encoding = blob(ls_tmp,EncodingUTF16BE!)
ls_json = string(lb_encoding,EncodingUTF16BE!)
ls_rtn = gjs_par.loadstring(ls_json)
if len(ls_rtn) = 0 then
	ls_output += "gjs_par.loadstring("+ls_json+") Succeed!"+"~r~n"
else
	ls_output += "gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn+"~r~n"
end if
ll_root = gjs_par.getrootitem( )
ls_name = gjs_par.getitemstring(ll_root,"name")
ls_output += "getitemstring(root,name)= "+ls_name+"~r~n"
mle_2.text += ls_output
end subroutine

on w_json.create
this.cbx_2=create cbx_2
this.uo_1=create uo_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.mle_2=create mle_2
this.st_2=create st_2
this.mle_1=create mle_1
this.st_1=create st_1
this.Control[]={this.cbx_2,&
this.uo_1,&
this.cb_3,&
this.cb_2,&
this.cbx_1,&
this.cb_1,&
this.mle_2,&
this.st_2,&
this.mle_1,&
this.st_1}
end on

on w_json.destroy
destroy(this.cbx_2)
destroy(this.uo_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.mle_2)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.st_1)
end on

event open;ieon_resize = create eon_appeon_resize
//ieon_resize = create using "eon_appeon_resize"
ijs_par = create jsonparser
ijs_gen = create jsongenerator
ieon_resize.of_init(this,true)

//mle_1.text =  '&
//{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
//{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
//}'
mle_1.text =  ' &
{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
}'

wf_init()
end event

event resize;ieon_resize.of_resize(this,newwidth,newheight,true)
end event

type cbx_2 from checkbox within w_json
integer x = 1024
integer y = 488
integer width = 338
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Loop"
end type

type uo_1 from uo_json_per within w_json
integer y = 620
integer height = 1176
integer taborder = 30
boolean border = true
end type

on uo_1.destroy
call uo_json_per::destroy
end on

type cb_3 from commandbutton within w_json
integer x = 1993
integer y = 1856
integer width = 457
integer height = 132
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Compare"
end type

event clicked;string ls_run,ls_expfile,ls_realfile
ls_expfile = getcurrentdirectory()+'\json.ben'
ls_realfile = getcurrentdirectory()+'\jsontmp.tmp'
ls_run = "C:\Program Files\Beyond~~1"
run("~""+ls_run+"\BCompare.exe~" "+"~""+ls_expfile+"~" "+"~""+ls_realfile+"~"")
end event

type cb_2 from commandbutton within w_json
integer x = 1303
integer y = 1864
integer width = 457
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SaveBen"
end type

event clicked;long ll_file
string ls_file

ls_file = "json.ben"

if messagebox("Question","Are you sure to Save ben file ?",question!,yesno!,1) = 2 then return
ll_file = fileopen(ls_file,textmode!,write!,shared!,replace!)

filewriteex(ll_file,mle_1.text)

fileclose(ll_file)
end event

type cbx_1 from checkbox within w_json
integer x = 599
integer y = 488
integer width = 338
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Error"
end type

type cb_1 from commandbutton within w_json
integer x = 23
integer y = 464
integer width = 457
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "runitem"
end type

event clicked;wf_classic_jsonparser()

wf_jsonparser_load()

wf_jsonparser_query()

wf_jsonparser_getitem()

wf_jsongenerator_classic()

wf_jsongenerator_inout()

wf_parm_area()

wf_string_encoding()

sleep(1)

wf_gettmpfile()
end event

type mle_2 from multilineedit within w_json
integer x = 1801
integer y = 96
integer width = 1797
integer height = 1700
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_json
integer x = 1810
integer y = 20
integer width = 270
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "OutPut"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_json
integer x = 18
integer y = 96
integer width = 1765
integer height = 364
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_json
integer x = 9
integer y = 8
integer width = 352
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "JsonString"
boolean focusrectangle = false
end type

