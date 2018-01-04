$PBExportHeader$w_json_auto.srw
forward
global type w_json_auto from w_appeon_base
end type
type mle_1 from multilineedit within w_json_auto
end type
type uo_1 from uo_json_per within w_json_auto
end type
type gb_5 from groupbox within w_json_auto
end type
type jsongenerator_1 from jsongenerator within w_json_auto
end type
type jsonparser_1 from jsonparser within w_json_auto
end type
end forward

global type w_json_auto from w_appeon_base
string title = "Json_Auto"
event ue_ref_any ( any aa )
mle_1 mle_1
uo_1 uo_1
gb_5 gb_5
jsongenerator_1 jsongenerator_1
jsonparser_1 jsonparser_1
end type
global w_json_auto w_json_auto

type variables
jsonparser ieon_parser
jsongenerator ieon_gen

//integer ix_or,iy_or,iw_or,ih_or
end variables

forward prototypes
public subroutine wf_init ()
public subroutine wf_scriptexe (integer ai_item, boolean ab_execute)
public subroutine wf_scriptexe_jsonparser_classic (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_declare (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_jsonparser_qurey (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_getitem (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_jsongenerator_classic (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_inout (string as_item, boolean ab_execute)
public subroutine wf_scriptexe_additem (string as_item, boolean ab_execute)
public subroutine wf_script_load (string as_item, boolean ab_execute)
public function any wf_return_any ()
end prototypes

event ue_ref_any(any aa);jsonparser  ljs_par
long ll_root
string ls_value
ljs_par = aa

ls_value ='{"编号":"001-ref"}'

ljs_par.loadstring( ls_value)
end event

public subroutine wf_init ();//设置测试点,多个测试点通过逗号分隔

is_testitems = "p001_parserclassic_classname,p001a_parserclassic_classdefinition,p002_parserclassic_typeof,p003_parserclassic_createanddestroy,p004_parserclassic_message,p005_parserclassic_ansi,p006_parserclassic_utf8,p007_parserclassic_utf16le,p008_parserclassic_utf16be,&
p009_area_struct,p010_area_instance,p011_area_glob,p011a_area_share,p012_area_performance,p013_area_any,p013a_area_parm,p013b_area_event,&
p014_parserquery_getrootitem,p015_parserquery_getchilditem,p016_parserquery_getchildkey,p017_parserquery_getchildcount,p018_parserquery_getitemtype,p019_parserquery_isnullitem,&
p020_getitemstring,p021_getitemnumber,p022_getitemboolean,p023_getitemdate,p024_getitemtime,p025_getitemdatetime,p026_getitemblob,p027_getitemobject,p028_getitemarray,&
p029_generatorclassic_classname,p029a_generatorclassic_classdefinition,p030_generatorclassic_typeof,p031_generatorclassic_createanddestroy,p032_generatorclassic_message,&
p033_generatorinout_createjsonobject,p034_generatorinout_createjsonarray,p035_generatorinout_getjsonstring,p036_generatorinout_getjsonblob,p037_generatorinout_savetofile,&
p038_additemstring,p039_additemnumber,p040_additemboolean,p041_additemdate,p042_additemtime,p043_additemdatetime,p044_additemblob,p045_additemnull,p046_additemobject,p047_additemarray,p048_additem_isjsonvalid,&
p049_loadstring,p050_loadfile"

//初始化结果集文件
is_expfile = "json.ben"
is_realfile = "jsontmp.txt"

//清空运行值
is_realvalue = ""

//设置测试总体描述
is_testpurpose = "~r~n自动化测试2017 New Featrue:~r~nJsonparser & JsonGenerator"

//setflag新加的控件可以在此resize
ieon_resize.of_setflag(gb_5,"0020")
ieon_resize.of_setflag(mle_1,"0020")
ieon_resize.of_setflag(uo_1,"2000")


end subroutine

public subroutine wf_scriptexe (integer ai_item, boolean ab_execute);
String ls_item
If ai_item < 1 Then Return
ls_item = lb_1.text(ai_item)
If ab_execute Then 
	wf_output("-----Test Point:" + ls_item + "-----", True)
End If
//将每个测试点通过测试范围化为新函数内执行

//将uo对象隐藏
uo_1.visible = false
if pos(ls_item,"parserclassic") > 0 then
	//jsonparser对象的classic测试
	wf_scriptexe_jsonparser_classic(ls_item,ab_execute)
elseif pos(ls_item,"area") > 0 then
	//测试变量的调用
	wf_scriptexe_declare(ls_item,ab_execute)
elseif pos(ls_item,"parserquery")  > 0 then
	wf_scriptexe_jsonparser_qurey(ls_item,ab_execute)
elseif pos(ls_item,"getitem") > 0 then
	wf_scriptexe_getitem(ls_item,ab_execute)
elseif pos(ls_item,"load") > 0 then
	wf_script_load(ls_item,ab_execute)
	//jsongenerator 对象
elseif pos(ls_item,"generatorclassic") > 0 then
	wf_scriptexe_jsongenerator_classic(ls_item,ab_execute)
elseif pos(ls_item,"generatorinout") > 0 then
	wf_scriptexe_inout(ls_item,ab_execute)
elseif pos(ls_item,"additem") > 0 then
	wf_scriptexe_additem(ls_item,ab_execute)
end if

end subroutine

public subroutine wf_scriptexe_jsonparser_classic (string as_item, boolean ab_execute);//测试jsonparser作为powerobject对象的基本操作
jsonparser leon_par,leon_par2
string ls_rtn,ls_value,ls_tmp,ls_json
blob lb_encoding
long ll_root
classdefinition lcd_tmp
ContextInformation lcx_key
ContextKeyword  lck_key
string ls_name
leon_par = create jsonparser
ls_tmp = '{"编号":45,"姓名":"李三"}'
Choose Case as_item
	Case 'p001_parserclassic_classname'
		If ab_execute  Then		
			ls_rtn = leon_par.classname( )
			wf_OutPut('leon_par.classname( ) = ' + ls_rtn, False)
			//测试未实例化异常
			try
				ls_rtn = leon_par2.classname()
			catch(runtimeerror re_classic)
				wf_output("RuntimeError: "+re_classic.getmessage(),false)
			end try
			//加入getparent测试点
			leon_par = jsonparser_1
			ls_rtn = leon_par.getparent().classname()
			wf_OutPut('leon_par.getparent().classname() = ' + ls_rtn, False)
		Else
			wf_scriptview("ls_rtn = leon_par.classname( )                                 ")
			wf_scriptview("wf_OutPut('leon_par.classname( ) = ' + ls_rtn, False)     ")
			wf_scriptview('//测试未实例化异常   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_rtn = leon_par2.classname()   ')
			wf_scriptview('catch(runtimeerror re_classic)   ')
			wf_scriptview('	wf_output("RuntimeError: "+re_classic.getmessage(),false)   ')
			wf_scriptview('end try   ')
			wf_scriptview('//加入getparent测试点   ')
			wf_scriptview('leon_par = jsonparser_1   ')
			wf_scriptview('ls_rtn = leon_par.getparent().classname()   ')
			wf_scriptview('wf_OutPut(~'leon_par.getparent().classname() = ~' + ls_rtn, False)   ')
		End If
	case "p001a_parserclassic_classdefinition"
		//测试classdefinition对象和getcontextservice
		if ab_execute then
			//通过classdefinition获取对象名称
			lcd_tmp = leon_par.classdefinition
			ls_rtn = lcd_tmp.name
			wf_output("classdefiniton.name="+ls_rtn,false)
			//通过服务获取公司名称
			leon_par.GetContextservice("ContextInformation", lcx_key)
			lcx_key.GetCompanyName (ls_rtn)
			wf_output("GetCompanyName="+ls_rtn,false)
//			通过服务取parent
//			leon_par.getcontextservice( "ContextKeyWord",lck_key)
//			ls_rtn = lck_key.getparent( ).classname( )			
		else
			wf_scriptview('//通过classdefinition获取对象名称   ')
			wf_scriptview('lcd_tmp = leon_par.classdefinition   ')
			wf_scriptview('ls_rtn = lcd_tmp.name   ')
			wf_scriptview('wf_output("classdefiniton.name="+ls_rtn,false)   ')
			wf_scriptview('//通过服务获取公司名称   ')
			wf_scriptview('leon_par.GetContextservice("ContextInformation", lcx_key)   ')
			wf_scriptview('lcx_key.GetCompanyName (ls_rtn)   ')
			wf_scriptview('wf_output("GetCompanyName="+ls_rtn,false)   ')
		end if
	Case "p002_parserclassic_typeof"	
		If ab_execute  Then		
			if leon_par.typeof( ) = jsonparser! then
				wf_OutPut('leon_par.typeof( ) = jsonparser!', False)
			else
				wf_OutPut('Failed : leon_par.typeof( ) <> jsonparser!', False)
			end if
		Else
			wf_scriptview("if leon_par.typeof( ) = jsonparser! then                                 ")
			wf_scriptview("	wf_OutPut('leon_par.typeof( ) = jsonparser!', False)                           ")
			wf_scriptview("else    ")
			wf_scriptview("	wf_OutPut('Failed : leon_par.typeof( ) <> jsonparser!', False)                                 ")
			wf_scriptview("end if                                 ")
		End If
	case "p003_parserclassic_createanddestroy"
		if ab_execute then
			Destroy leon_par 
			if isvalid(leon_par) then
				wf_OutPut('Failed: After destroy leon_par is still avalid', False)
			else
				wf_OutPut('Succeed: After destroy leon_par is not avalid', False)
			end if
			leon_par = create using "jsonparser"
			if isvalid(leon_par) then
				wf_output('The object was created',False)
			else
				wf_output('Create the object failed',False)
			end if
			ls_rtn = leon_par.loadstring( '{"id":100,"Text":"test"}')
			if len(trim(ls_rtn)) <> 0 then
				wf_output('loadstring failed : '+ls_rtn,False)
			else
				wf_output('loadstring succeed',False)
			end if
		else
			wf_scriptview("Destroy leon_par                                  ")
			wf_scriptview("if isvalid(leon_par) then                           ")
			wf_scriptview("	wf_OutPut('Failed: After destroy leon_par is still avalid', False)")
			wf_scriptview("else    ")
			wf_scriptview("	wf_OutPut('Succeed: After destroy leon_par is not avalid', False)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("leon_par = create using~"jsonparser~"                              ")
			wf_scriptview("if isvalid(leon_par) then                           ")
			wf_scriptview("	wf_output('The object was created',False)					")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output('Create the object failed',False)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ls_rtn = leon_par.loadstring( '{~"id~":100,~"Text~":~"test~"}')                             ")
			wf_scriptview("if len(trim(ls_rtn)) <> 0 then                           ")
			wf_scriptview("	wf_output('loadstring failed : '+ls_rtn,False)					")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output('loadstring succeed',False)                               ")
			wf_scriptview("end if                                 ")
		end if
	case "p004_parserclassic_message"
		if ab_execute then
			ls_rtn = leon_par.loadstring( '{"id":100,"Text":"测试对象传递"}')
			if len(trim(ls_rtn)) <> 0 then
				wf_output("loadstring failed : "+ls_rtn,false)
			else
				openwithparm(w_tmp,leon_par)
				leon_par = message.powerobjectparm
				ll_root = leon_par.getrootitem( )
				ls_value = leon_par.getitemstring( ll_root, "Text")
				wf_output("return from message is "+ls_value,false)
			end if
		else
			wf_scriptview("ls_rtn = leon_par.loadstring( '{~"id~":100,~"Text~":~"测试对象传递~"}')                                  ")
			wf_scriptview("if len(trim(ls_rtn)) <> 0 then                           ")
			wf_scriptview("	wf_output(~"loadstring failed : ~"+ls_rtn,false)")
			wf_scriptview("else    ")
			wf_scriptview("	openwithparm(w_tmp,leon_par)                                 ")
			wf_scriptview("	leon_par = message.powerobjectparm                                ")
			wf_scriptview("	ll_root = leon_par.getrootitem( )                                 ")
			wf_scriptview("	ls_value = leon_par.getitemstring( ll_root, ~"Text~")                                 ")
			wf_scriptview("	wf_output(~"return from message is ~"+ls_value,false)                                ")
			wf_scriptview("end if                                 ")
		end if
	case "p005_parserclassic_ansi"
		//测试Ansi编码
		if ab_execute then
			lb_encoding = blob(ls_tmp,EncodingANSI!)
			ls_json = string(lb_encoding,EncodingANSI!)
			ls_rtn = gjs_par.loadstring(ls_json)
			if len(ls_rtn) = 0 then
				wf_output("gjs_par.loadstring("+ls_json+") Succeed!",false)
			else
				wf_output("gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn,false)
				return
			end if
			ll_root = gjs_par.getrootitem( )
			ls_value = gjs_par.getitemstring(ll_root,"姓名")
			wf_output("getitemstring(root,'姓名')= "+ls_value,false)
		else
			wf_scriptview("lb_encoding = blob(ls_tmp,EncodingANSI!)                                 ")
			wf_scriptview("ls_json = string(lb_encoding,EncodingANSI!)                           ")
			wf_scriptview("ls_rtn = gjs_par.loadstring(ls_json)		")
			wf_scriptview("if len(ls_rtn) = 0 then        			")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Succeed!~",false)        			")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Failed : ~"+ls_rtn,false)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ll_root = gjs_par.getrootitem( )                                 ")
			wf_scriptview("ls_value = gjs_par.getitemstring(ll_root,~"姓名~")                          ")
			wf_scriptview("wf_output(~"getitemstring(root,'姓名')= ~"+ls_value,false)		")
		end if
	case "p006_parserclassic_utf8"
		//测试utf8编码
		if ab_execute then
			lb_encoding = blob(ls_tmp,Encodingutf8!)
			ls_json = string(lb_encoding,Encodingutf8!)
			ls_rtn = gjs_par.loadstring(ls_json)
			if len(ls_rtn) = 0 then
				wf_output("gjs_par.loadstring("+ls_json+") Succeed!",false)
			else
				wf_output("gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn,false)
			end if
			ll_root = gjs_par.getrootitem( )
			ls_value = gjs_par.getitemstring(ll_root,"姓名")
			wf_output("getitemstring(root,'姓名')= "+ls_value,false)
		else
			wf_scriptview("lb_encoding = blob(ls_tmp,Encodingutf8!)                                 ")
			wf_scriptview("ls_json = string(lb_encoding,Encodingutf8!)                           ")
			wf_scriptview("ls_rtn = gjs_par.loadstring(ls_json)		")
			wf_scriptview("if len(ls_rtn) = 0 then        			")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Succeed!~",false)        			")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Failed : ~"+ls_rtn,false)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ll_root = gjs_par.getrootitem( )                                 ")
			wf_scriptview("ls_value = gjs_par.getitemstring(ll_root,~"姓名~")                          ")
			wf_scriptview("wf_output(~"getitemstring(root,'姓名')= ~"+ls_value,false)		")
		end if
	case "p007_parserclassic_utf16le"
		//测试utf16le编码
		if ab_execute then
			lb_encoding = blob(ls_tmp,Encodingutf16le!)
			ls_json = string(lb_encoding,Encodingutf16le!)
			ls_rtn = gjs_par.loadstring(ls_json)
			if len(ls_rtn) = 0 then
				wf_output("gjs_par.loadstring("+ls_json+") Succeed!",false)
			else
				wf_output("gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn,false)
			end if
			ll_root = gjs_par.getrootitem( )
			ls_value = gjs_par.getitemstring(ll_root,"姓名")
			wf_output("getitemstring(root,'姓名')= "+ls_value,false)
		else
			wf_scriptview("lb_encoding = blob(ls_tmp,Encodingutf16le!)                                 ")
			wf_scriptview("ls_json = string(lb_encoding,Encodingutf16le!)                           ")
			wf_scriptview("ls_rtn = gjs_par.loadstring(ls_json)		")
			wf_scriptview("if len(ls_rtn) = 0 then        			")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Succeed!~",false)        			")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Failed : ~"+ls_rtn,false)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ll_root = gjs_par.getrootitem( )                                 ")
			wf_scriptview("ls_value = gjs_par.getitemstring(ll_root,~"姓名~")                          ")
			wf_scriptview("wf_output(~"getitemstring(root,'姓名')= ~"+ls_value,false)		")
		end if
	case "p008_parserclassic_utf16be"
		//测试utf16be编码
		if ab_execute then
			lb_encoding = blob(ls_tmp,Encodingutf16be!)
			ls_json = string(lb_encoding,Encodingutf16be!)
			ls_rtn = gjs_par.loadstring(ls_json)
			if len(ls_rtn) = 0 then
				wf_output("gjs_par.loadstring("+ls_json+") Succeed!",false)
			else
				wf_output("gjs_par.loadstring("+ls_json+") Failed : "+ls_rtn,false)
			end if
			ll_root = gjs_par.getrootitem( )
			ls_value = gjs_par.getitemstring(ll_root,"姓名")
			wf_output("getitemstring(root,'姓名')= "+ls_value,false)
		else
			wf_scriptview("lb_encoding = blob(ls_tmp,Encodingutf16be!)                                 ")
			wf_scriptview("ls_json = string(lb_encoding,Encodingutf16be!)                           ")
			wf_scriptview("ls_rtn = gjs_par.loadstring(ls_json)		")
			wf_scriptview("if len(ls_rtn) = 0 then        			")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Succeed!~",false)        			")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output(~"gjs_par.loadstring(~"+ls_json+~") Failed : ~"+ls_rtn,false)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ll_root = gjs_par.getrootitem( )                                 ")
			wf_scriptview("ls_value = gjs_par.getitemstring(ll_root,~"姓名~")                          ")
			wf_scriptview("wf_output(~"getitemstring(root,'姓名')= ~"+ls_value,false)		")
		end if
	case else
	 	MessageBox("Error",as_item+" Not Coding",Exclamation!)
End Choose

end subroutine

public subroutine wf_scriptexe_declare (string as_item, boolean ab_execute);//测试jsonparser/jsongenerator作为基本变量的操作
long ll_object,ll_array,ll_object2,ll_root,ll_count,ll_loop
string ls_json,ls_output,ls_rtn,ls_value
uo_json_share luo_array[]
jsongenerator ljs_gen
jsonparser ljs_par
jsongenerator ljs_genarray[]
nvo_gen lnvo_gen
nvo_par lnvo_par

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
uo_1.visible = false
Choose Case as_item
	Case 'p009_area_struct'
		If ab_execute  Then		
			//通过全局函数调用结构体查看返回值
			lstr_json.str_gen = ljs_gen
			lstr_json.str_par = ljs_par
			ls_rtn = gf_getjsonstring(lstr_json)
			wf_output("Return from gf_getjsonstring = "+ls_rtn,False)
		Else
			wf_scriptview("lstr_json.str_gen = ljs_gen                               ")
			wf_scriptview("lstr_json.str_par = ljs_par    ")
			wf_scriptview("ls_rtn = gf_getjsonstring(lstr_json)   ")
			wf_scriptview("wf_output(~"Return from gf_getjsonstring = ~"+ls_rtn,False)    ")
		End If
	Case "p010_area_instance"	
		If ab_execute  Then		
			ieon_parser = ljs_par
			ieon_gen = ljs_gen
			ll_root = ieon_parser.getrootitem( )
			ll_count = ieon_parser.getchildcount(ll_root)
			wf_output(" ieon_parser.getchildcount() = "+string(ll_count),False)
			wf_output(" ieon_gen.getjsonstring() = "+string(ieon_gen.getjsonstring() ),False)
		Else
			wf_scriptview("ieon_parser = ljs_par                                 ")
			wf_scriptview("ieon_gen = ljs_gen                           ")
			wf_scriptview("ll_root = ieon_parser.getrootitem( )   ")
			wf_scriptview("ll_count = ieon_parser.getchildcount(ll_root)                                 ")
			wf_scriptview("wf_output(~" ieon_parser.getchildcount() = ~"+string(ll_count),False)                                ")
			wf_scriptview("wf_output(~" ieon_gen.getjsonstring() = ~"+string(ieon_gen.getjsonstring() ),False)                               ")
		End If
	Case "p011_area_glob"	
		If ab_execute  Then		
			gjs_par = ljs_par
			gjs_gen = ljs_gen
			ll_root = gjs_par.getrootitem( )
			ll_count = gjs_par.getchildcount(ll_root)
			wf_output(" ieon_parser.getchildcount() = "+string(ll_count),False)
			wf_output(" ieon_gen.getjsonstring() = "+string(gjs_gen.getjsonstring() ),False)
		Else
			wf_scriptview("gjs_par = ljs_par                                 ")
			wf_scriptview("gjs_par = ljs_gen                           ")
			wf_scriptview("ll_root = gjs_par.getrootitem( )   ")
			wf_scriptview("ll_count = gjs_par.getchildcount(ll_root)                                 ")
			wf_scriptview("wf_output(~" gjs_par.getchildcount() = ~"+string(ll_count),False)                                ")
			wf_scriptview("wf_output(~" gjs_par.getjsonstring() = ~"+string(gjs_par.getjsonstring() ),False)                               ")
		End If
	case "p011a_area_share"
		if ab_execute then
			//打开两个对象
			openuserobject(luo_array[1],"uo_json_share",100,100)
			luo_array[1].bringtotop = true
			openuserobject(luo_array[2],"uo_json_share",500,100)
			luo_array[2].bringtotop = true
			//luo_array[1].ls_test = ''
			ls_json = '{"number":123,"name":"test"}'
			ieon_parser.loadstring( ls_json)
			ljs_par.loadstring( ls_json)
			//luo_array[1].uf_setvalue(ieon_parser,ljs_gen)
			luo_array[1].uf_setvalue(ljs_par,ljs_gen)
			luo_array[1].uf_output()
			wf_output("uo1 = "+luo_array[1].mle_1.text,false)
			//查看uo2是否被共享
			luo_array[2].uf_output( )
			wf_output("ShareValue from uo1 = "+luo_array[2].mle_1.text,false)
			//关闭uo1后，查看uo2是否继续共享
			closeuserobject(luo_array[1])
			luo_array[2].uf_output( )
			wf_output("close uo1后，uo2数据 = "+luo_array[2].mle_1.text,false)
			//新打开uo3，查看是否共享
			openuserobject(luo_array[3],"uo_json_share",800,100)
			luo_array[3].bringtotop = true
			luo_array[3].uf_output( )
			wf_output("新打开对象 uo3，uo3数据 = "+luo_array[3].mle_1.text,false)
			//全部关闭，重新打开uo1
			closeuserobject(luo_array[1])
			closeuserobject(luo_array[2])
			closeuserobject(luo_array[3])
			openuserobject(luo_array[1],"uo_json_share",100,100)
			luo_array[1].bringtotop = true
			luo_array[1].uf_output()
			wf_output("新开启uo1 = "+luo_array[1].mle_1.text,false)
			//手工在uo1中destroy ，查看uo2共享变量也被destroy
			openuserobject(luo_array[2],"uo_json_share",500,100)
			luo_array[2].bringtotop = true
			luo_array[1].uf_destroy()
			luo_array[2].uf_output( )
			wf_output("手工Destroy后，ShareValue from uo1 = "+luo_array[2].mle_1.text,false)
			//close打开的uo
			closeuserobject(luo_array[1])
			closeuserobject(luo_array[2])
		else
			wf_scriptview('//打开两个对象   ')
			wf_scriptview('openuserobject(luo_array[1],"uo_json_share",100,100)   ')
			wf_scriptview('luo_array[1].bringtotop = true   ')
			wf_scriptview('openuserobject(luo_array[2],"uo_json_share",500,100)   ')
			wf_scriptview('luo_array[2].bringtotop = true   ')
			wf_scriptview('//luo_array[1].ls_test = ~'~'   ')
			wf_scriptview('ls_json = ~'{"number":123,"name":"test"}~'   ')
			wf_scriptview('ieon_parser.loadstring( ls_json)   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('//luo_array[1].uf_setvalue(ieon_parser,ljs_gen)   ')
			wf_scriptview('luo_array[1].uf_setvalue(ljs_par,ljs_gen)   ')
			wf_scriptview('luo_array[1].uf_output()   ')
			wf_scriptview('wf_output("uo1 = "+luo_array[1].mle_1.text,false)   ')
			wf_scriptview('//查看uo2是否被共享   ')
			wf_scriptview('luo_array[2].uf_output( )   ')
			wf_scriptview('wf_output("ShareValue from uo1 = "+luo_array[2].mle_1.text,false)   ')
			wf_scriptview('//关闭uo1后，查看uo2是否继续共享   ')
			wf_scriptview('closeuserobject(luo_array[1])   ')
			wf_scriptview('luo_array[2].uf_output( )   ')
			wf_scriptview('wf_output("close uo1后，uo2数据 = "+luo_array[2].mle_1.text,false)   ')
			wf_scriptview('//新打开uo3，查看是否共享   ')
			wf_scriptview('openuserobject(luo_array[3],"uo_json_share",800,100)   ')
			wf_scriptview('luo_array[3].bringtotop = true   ')
			wf_scriptview('luo_array[3].uf_output( )   ')
			wf_scriptview('wf_output("新打开对象 uo3，uo3数据 = "+luo_array[3].mle_1.text,false)   ')
			wf_scriptview('//全部关闭，重新打开uo1   ')
			wf_scriptview('closeuserobject(luo_array[1])   ')
			wf_scriptview('closeuserobject(luo_array[2])   ')
			wf_scriptview('closeuserobject(luo_array[3])   ')
			wf_scriptview('openuserobject(luo_array[1],"uo_json_share",100,100)   ')
			wf_scriptview('luo_array[1].bringtotop = true   ')
			wf_scriptview('luo_array[1].uf_output()   ')
			wf_scriptview('wf_output("新开启uo1 = "+luo_array[1].mle_1.text,false)   ')
			wf_scriptview('//手工在uo1中destroy ，查看uo2共享变量也被destroy   ')
			wf_scriptview('openuserobject(luo_array[2],"uo_json_share",500,100)   ')
			wf_scriptview('luo_array[2].bringtotop = true   ')
			wf_scriptview('luo_array[1].uf_destroy()   ')
			wf_scriptview('luo_array[2].uf_output( )   ')
			wf_scriptview('wf_output("手工Destroy后，ShareValue from uo1 = "+luo_array[2].mle_1.text,false)   ')
			wf_scriptview('//close打开的uo   ')
			wf_scriptview('closeuserobject(luo_array[1])   ')
			wf_scriptview('closeuserobject(luo_array[2])   ')
		end if
	case "p012_area_performance"
		if ab_execute then
			//性能测试，测试定限数组
			gjs_par = ljs_par  //栽单独执行的情况下，使数据继续有效
			uo_1.visible  = true
			uo_1.cb_1.triggerevent( clicked!)
			wf_output(uo_1.st_1.text,false)
			//测试不定限数组
			for ll_loop = 1 to 1000
				ljs_genarray[ll_loop] = ljs_gen
				//输出最后100条数据
				if ll_loop > 900 then
					wf_output("ljs_genarray["+string(ll_loop)+"].getjsonstring() = "+ljs_genarray[ll_loop].getjsonstring(),false)
				end if
			next
		else
			wf_scriptview('//性能测试，测试定限数组   ')
			wf_scriptview('gjs_par = ljs_par  //栽单独执行的情况下，使数据继续有效   ')
			wf_scriptview('uo_1.visible  = true   ')
			wf_scriptview('uo_1.cb_1.triggerevent( clicked!)   ')
			wf_scriptview('wf_output(uo_1.st_1.text,false)   ')
			wf_scriptview('//测试不定限数组   ')
			wf_scriptview('for ll_loop = 1 to 1000   ')
			wf_scriptview('	ljs_genarray[ll_loop] = ljs_gen   ')
			wf_scriptview('	//输出最后100条数据   ')
			wf_scriptview('	if ll_loop > 900 then   ')
			wf_scriptview('		wf_output("ljs_genarray["+string(ll_loop)+"].getjsonstring() = "+ljs_genarray[ll_loop].getjsonstring(),false)   ')
			wf_scriptview('	end if   ')
			wf_scriptview('next   ')
		end if
	case "p013_area_any"
		if ab_execute then
			gjs_par = ljs_par
			//any作为值传递
			ll_count = gf_parser_any(gjs_par)
			wf_output("gf_parser_any(gjs_par) = "+string(ll_count),False)
			//any作为返回值
			ljs_gen = wf_return_any()
			wf_output("wf_return_any() = "+ljs_gen.getjsonstring(),False)
			//any作为reference传递(ref只能传any，重新定义为value型)
			ls_json = '{"编号","001"}'
			ljs_par.loadstring( ls_json)
			this.event ue_ref_any(ljs_par)
			ll_root = ljs_par.getrootitem()
			ls_value = ljs_par.getitemstring(ll_root,"编号")
			wf_output("After Changed in the event,the value is "+ls_value,false)	
		else
			wf_scriptview('gjs_par = ljs_par   ')
			wf_scriptview('//any作为值传递   ')
			wf_scriptview('ll_count = gf_parser_any(gjs_par)   ')
			wf_scriptview('wf_output("gf_parser_any(gjs_par) = "+string(ll_count),False)   ')
			wf_scriptview('//any作为返回值   ')
			wf_scriptview('ljs_gen = wf_return_any()   ')
			wf_scriptview('wf_output("wf_return_any() = "+ljs_gen.getjsonstring(),False)   ')
			wf_scriptview('//any作为reference传递(ref只能传any，重新定义为value型)   ')
			wf_scriptview('ls_json = ~'{"编号","001"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('this.event ue_ref_any(ljs_par)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem()   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,"编号")   ')
			wf_scriptview('wf_output("After Changed in the event,the value is "+ls_value,false)	   ')
		end if
	case "p013a_area_parm"
		if ab_execute then
			//jsonparser作为值传递
			ls_json = '{"test":"test"}'
			ljs_par.loadstring(ls_json)
			gf_parser_value(ljs_par)
			ll_root = ljs_par.getrootitem()
			ls_value = ljs_par.getitemstring(ll_root,"test")
			wf_output("jsonparser 值传递后, 数据为："+ls_value,false)	
			//jsonparser作为readonly传递
			ls_json = '{"test":"test"}'
			ljs_par.loadstring(ls_json)
			ll_root = ljs_par.getrootitem()
			ls_value = ljs_par.getitemstring(ll_root,"test")
			wf_output("jsonparser readonly传递前, 数据为："+ls_value,false)	
			gf_parser_readonly(ljs_par)
			ll_root = ljs_par.getrootitem()
			ls_value = ljs_par.getitemstring(ll_root,"test")
			wf_output("jsonparser readonly传递后, 数据为："+ls_value,false)	
			//jsongenerator作为ref传递
			ljs_gen.createjsonarray( )
			gf_gen_ref(ljs_gen)
			wf_output("jsongenerator ref传递后, 数据为："+ljs_gen.getjsonstring(),false)
			//jsongenerator作为返回值
			ljs_gen.createjsonarray( )
			ljs_gen = gf_gen_return()
			wf_output("jsongenerator return from全局函数，数据为："+ljs_gen.getjsonstring(),false)
		else
			wf_scriptview('//jsonparser作为值传递   ')
			wf_scriptview('ls_json = ~'{"test":"test"}~'   ')
			wf_scriptview('ljs_par.loadstring(ls_json)   ')
			wf_scriptview('gf_parser_value(ljs_par)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem()   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,"test")   ')
			wf_scriptview('wf_output("jsonparser 值传递后, 数据为："+ls_value,false)	   ')
			wf_scriptview('//jsonparser作为readonly传递   ')
			wf_scriptview('ls_json = ~'{"test":"test"}~'   ')
			wf_scriptview('ljs_par.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem()   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,"test")   ')
			wf_scriptview('wf_output("jsonparser readonly传递前, 数据为："+ls_value,false)	   ')
			wf_scriptview('gf_parser_readonly(ljs_par)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem()   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,"test")   ')
			wf_scriptview('wf_output("jsonparser readonly传递后, 数据为："+ls_value,false)	   ')
			wf_scriptview('//jsongenerator作为ref传递   ')
			wf_scriptview('ljs_gen.createjsonarray( )   ')
			wf_scriptview('gf_gen_ref(ljs_gen)   ')
			wf_scriptview('wf_output("jsongenerator ref传递后, 数据为："+ljs_gen.getjsonstring(),false)   ')
			wf_scriptview('//jsongenerator作为返回值   ')
			wf_scriptview('ljs_gen.createjsonarray( )   ')
			wf_scriptview('ljs_gen = gf_gen_return()   ')
			wf_scriptview('wf_output("jsongenerator return from全局函数，数据为："+ljs_gen.getjsonstring(),false)   ')
		end if
	case "p013b_area_event"
		if ab_execute then
			//通过post和trigger触发标准不可视对象的事件
			lnvo_par = create nvo_par
			lnvo_gen = create nvo_gen
			//通过trigger方式触发
			lnvo_par.of_event_create( "trigger")
			wf_output('lnvo_par.of_event_create( "trigger") = '+lnvo_par.is_event,false)
			lnvo_par.of_event_destroy( "trigger")
			wf_output('lnvo_par.of_event_destroy( "trigger") = '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "constructor", "trigger")
			wf_output('lnvo_gen.of_event( "constructor", "trigger") = '+lnvo_gen.is_event,false)
			lnvo_gen.of_event( "destructor", "trigger")
			wf_output('lnvo_gen.of_event( "destructor", "trigger") = '+lnvo_gen.is_event,false)
			//通过trigger触发自定义事件
			lnvo_par.of_event( "ue_test", "trigger", 0, "")
			wf_output('lnvo_par.of_event( "ue_test", "trigger", 0, "")= '+lnvo_par.is_event,false)
			lnvo_par.of_event( "ue_test", "trigger", 0, "100")
			wf_output('lnvo_par.of_event( "ue_test", "trigger", 0, "100")= '+lnvo_par.is_event,false)
			lnvo_par.of_event( "ue_test", "trigger", 0, "testparser")
			wf_output('lnvo_par.of_event( "ue_test", "trigger", 0, "testparser")= '+lnvo_par.is_event,false)
			lnvo_par.of_event( "ue_test", "trigger", 200, "150")
			wf_output('lnvo_par.of_event( "ue_test", "trigger", 200, "150")= '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "ue_test", "trigger", 0, "")
			wf_output('lnvo_gen.of_event( "ue_test", "trigger", 0, "")= '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "ue_test", "trigger", 100, "")
			wf_output('lnvo_par.of_event( "ue_test", "trigger", 100, "")= '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "ue_test", "trigger", 0, "testgenerate")
			wf_output('lnvo_gen.of_event( "ue_test", "trigger", 0, "testgenerate")= '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "ue_test", "trigger", 200, "150")
			wf_output('lnvo_gen.of_event( "ue_test", "trigger", 200, "150")= '+lnvo_par.is_event,false)
			//通过post方式触发
			lnvo_par.of_event_create( "post")
			//wf_output('lnvo_par.of_event_create( "post") = '+lnvo_par.is_event,false)
			lnvo_par.of_event_destroy( "post")
			//wf_output('lnvo_par.of_event_destroy( "post") = '+lnvo_par.is_event,false)
			lnvo_gen.of_event( "constructor", "post")
			//wf_output('lnvo_gen.of_event( "constructor", "post") = '+lnvo_gen.is_event,false)
			lnvo_gen.of_event( "destructor", "post")
			//wf_output('lnvo_gen.of_event( "destructor", "post") = '+lnvo_gen.is_event,false)
			//通过post触发自定义事件
			lnvo_par.of_event( "ue_test", "post", 0, "")
			lnvo_par.of_event( "ue_test", "post", 50, "")
			lnvo_par.of_event( "ue_test", "post", 0, "testpost")
			lnvo_par.of_event( "ue_test", "post", 0, "100")
			lnvo_gen.of_event( "ue_test", "post", 0, "")
			lnvo_gen.of_event( "ue_test", "post", 500, "")
			lnvo_gen.of_event( "ue_test", "post", 0, "testpost")
			lnvo_gen.of_event( "ue_test", "post", 0, "200")
		else
			wf_scriptview('//通过post和trigger触发标准不可视对象的事件   ')
			wf_scriptview('lnvo_par = create nvo_par   ')
			wf_scriptview('lnvo_gen = create nvo_gen   ')
			wf_scriptview('//通过trigger方式触发   ')
			wf_scriptview('lnvo_par.of_event_create( "trigger")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event_create( "trigger") = ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_par.of_event_destroy( "trigger")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event_destroy( "trigger") = ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "constructor", "trigger")   ')
			wf_scriptview('wf_output(~'lnvo_gen.of_event( "constructor", "trigger") = ~'+lnvo_gen.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "destructor", "trigger")   ')
			wf_scriptview('wf_output(~'lnvo_gen.of_event( "destructor", "trigger") = ~'+lnvo_gen.is_event,false)   ')
			wf_scriptview('//通过trigger触发自定义事件   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "trigger", 0, "")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event( "ue_test", "trigger", 0, "")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "trigger", 0, "100")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event( "ue_test", "trigger", 0, "100")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "trigger", 0, "testparser")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event( "ue_test", "trigger", 0, "testparser")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "trigger", 200, "150")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event( "ue_test", "trigger", 200, "150")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "trigger", 0, "")   ')
			wf_scriptview('wf_output(~'lnvo_gen.of_event( "ue_test", "trigger", 0, "")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "trigger", 100, "")   ')
			wf_scriptview('wf_output(~'lnvo_par.of_event( "ue_test", "trigger", 100, "")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "trigger", 0, "testgenerate")   ')
			wf_scriptview('wf_output(~'lnvo_gen.of_event( "ue_test", "trigger", 0, "testgenerate")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "trigger", 200, "150")   ')
			wf_scriptview('wf_output(~'lnvo_gen.of_event( "ue_test", "trigger", 200, "150")= ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('//通过post方式触发   ')
			wf_scriptview('lnvo_par.of_event_create( "post")   ')
			wf_scriptview('//wf_output(~'lnvo_par.of_event_create( "post") = ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_par.of_event_destroy( "post")   ')
			wf_scriptview('//wf_output(~'lnvo_par.of_event_destroy( "post") = ~'+lnvo_par.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "constructor", "post")   ')
			wf_scriptview('//wf_output(~'lnvo_gen.of_event( "constructor", "post") = ~'+lnvo_gen.is_event,false)   ')
			wf_scriptview('lnvo_gen.of_event( "destructor", "post")   ')
			wf_scriptview('//wf_output(~'lnvo_gen.of_event( "destructor", "post") = ~'+lnvo_gen.is_event,false)   ')
			wf_scriptview('//通过post触发自定义事件   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "post", 0, "")   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "post", 50, "")   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "post", 0, "testpost")   ')
			wf_scriptview('lnvo_par.of_event( "ue_test", "post", 0, "100")   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "post", 0, "")   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "post", 500, "")   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "post", 0, "testpost")   ')
			wf_scriptview('lnvo_gen.of_event( "ue_test", "post", 0, "200")   ')
		end if
		
	case else
	 	MessageBox("Error",as_item+" Not Coding",Exclamation!)
End Choose

end subroutine

public subroutine wf_scriptexe_jsonparser_qurey (string as_item, boolean ab_execute);//测试jsonparser作为基本的查询函数对象的基本操作
long ll_root,ll_handle1,ll_null,ll_count,ll_root_null,ll_object,ll_object2,ll_array,ll_loop,ll_child
string ls_json,ls_output,ls_key,ls_null
boolean lb_rtn
jsonitemtype ljs_type
jsongenerator ljs_gen
jsonparser ljs_par
setnull(ll_null)
setnull(ls_null)
//getrootitem
ljs_gen = create jsongenerator
ljs_par = create jsonparser

Choose Case as_item
	Case 'p014_parserquery_getrootitem'
		If ab_execute  Then	
			ll_root = ieon_parser.getrootitem( )
			//未加载任何对象
			wf_output("getrootitem() = "+string(ll_root),False)
			//加载错误的json
			ls_json = "{tete,tet}"
			ieon_parser.loadstring(ls_json)
			ll_root = ieon_parser.getrootitem( )
			wf_output("getrootitem() = "+string(ll_root),False)
			//加载正确的json
			ls_json = mle_1.text
			ieon_parser.loadstring(ls_json)
			ll_root = ieon_parser.getrootitem( )
			wf_output("getrootitem() = "+string(ll_root),False)
		Else
			wf_scriptview("ll_root = ieon_parser.getrootitem( )                                 ")
			wf_scriptview("//未加载任何对象     ")
			wf_scriptview("wf_output(~"getrootitem() = ~"+string(ll_root),False)     ")
			wf_scriptview("//加载错误的json    ")
			wf_scriptview("ls_json = ~"{tete,tet}~"    ")
			wf_scriptview("ieon_parser.loadstring(ls_json)     ")
			wf_scriptview("ll_root = ieon_parser.getrootitem( )    ")
			wf_scriptview("wf_output(~"getrootitem() = ~"+string(ll_root),False)     ")
			wf_scriptview("//加载正确的json   ")
			wf_scriptview("ls_json = mle_1.text    ")
			wf_scriptview("ieon_parser.loadstring(ls_json)     ")
			wf_scriptview("ll_root = ieon_parser.getrootitem( )    ")
			wf_scriptview("wf_output(~"getrootitem() = ~"+string(ll_root),False)     ")
		End If
	Case "p015_parserquery_getchilditem"	
		If ab_execute  Then	
			ieon_parser.loadstring(mle_1.text)
			ll_root = ieon_parser.getrootitem()
			ll_handle1 = ieon_parser.getchilditem( ll_root,2)
			wf_output("getchilditem() 可能每次执行获取的值不一致",false)
			wf_output("getchilditem() = "+string(ll_handle1),false)
			//超出范围的index
			ll_handle1 = ieon_parser.getchilditem( ll_root,32768)
			wf_output("getchilditem(ll_root,32768) = "+string(ll_handle1),false)
			//负数的index
			ll_handle1 = ieon_parser.getchilditem( ll_root,-32768)
			wf_output("getchilditem(ll_root,-32768) = "+string(ll_handle1),false)
			//0的index
			ll_handle1 = ieon_parser.getchilditem( ll_root,0)
			wf_output("getchilditem(ll_root,0) = "+string(ll_handle1),false)
			//Null 
			ll_handle1 = ieon_parser.getchilditem( ll_root,ll_null)
			if isnull(ll_handle1) then
				wf_output("Succeed : getchilditem(ll_root,null) = null",false)
			else
				wf_output("Failed:getchilditem(ll_root,null) = "+string(ll_handle1),false)
			end if
		Else
			wf_scriptview('eon_parser.loadstring(mle_1.text)              ')
			wf_scriptview("ll_root = ieon_parser.getrootitem()")
			wf_scriptview("ll_handle1 = ieon_parser.getchilditem( ll_root,2)        ")
			wf_scriptview('wf_output("getchilditem() 可能每次执行获取的值不一致",false)         ')
			wf_scriptview('wf_output("getchilditem() = "+string(ll_handle1),false)             ')
			wf_scriptview('//超出范围的index')
			wf_scriptview('ll_handle1 = ieon_parser.getchilditem( ll_root,32768)         ')
			wf_scriptview('wf_output("getchilditem(ll_root,32768) = "+string(ll_handle1),false)          ')
			wf_scriptview('//负数的index                ')
			wf_scriptview('ll_handle1 = ieon_parser.getchilditem( ll_root,-32768)                    ')
			wf_scriptview('wf_output("getchilditem(ll_root,-32768) = "+string(ll_handle1),false)            ')
			wf_scriptview('//0的index           ')
			wf_scriptview('ll_handle1 = ieon_parser.getchilditem( ll_root,0)                 ')
			wf_scriptview('wf_output("getchilditem(ll_root,0) = "+string(ll_handle1),false)                ') 
			wf_scriptview('ll_handle1 = ieon_parser.getchilditem( ll_root,ll_null)             ')
			wf_scriptview('if isnull(ll_handle1) then       ')
			wf_scriptview('	wf_output("Succeed : getchilditem(ll_root,null) = null",false)           ')
			wf_scriptview('else               ')
			wf_scriptview('	wf_output("Failed:getchilditem(ll_root,null) = "+string(ll_handle1),false)             ')
			wf_scriptview('end if                        ')
		End If		
	case "p016_parserquery_getchildkey"
		if not ab_execute then
			//正常参数
			wf_scriptview("ieon_parser.loadstring(mle_1.text)  ")
			wf_scriptview("ls_key = ieon_parser.getchildkey( ll_root, 2)   " )
			wf_scriptview('wf_output("getchildkey(ll_root,2) = "+ls_key,False)              ')
			wf_scriptview('//index为0                     ')
			wf_scriptview('ls_key = ieon_parser.getchildkey( ll_root, 0)               ')
			wf_scriptview('wf_output("getchildkey(ll_root,0) = "+ls_key,False)        ')
			wf_scriptview('//index为null                  ')
			wf_scriptview('ls_key = ieon_parser.getchildkey( ll_root, ll_null)              ')
			wf_scriptview('if isnull(ls_key) then              ')
			wf_scriptview('	wf_output("getchildkey(ll_root,null) = null",False)          ')
			wf_scriptview('else               ')
			wf_scriptview('	wf_output("Failed: getchildkey(ll_root,null) = "+ls_key,False)              ')
			wf_scriptview('end if                   ')
		else
			//正常参数
			ieon_parser.loadstring(mle_1.text)
			ls_key = ieon_parser.getchildkey( ll_root, 2)
			wf_output("getchildkey(ll_root,2) = "+ls_key,False)
			//index为0
			ls_key = ieon_parser.getchildkey( ll_root, 0)
			wf_output("getchildkey(ll_root,0) = "+ls_key,False)
			//index为null
			ls_key = ieon_parser.getchildkey( ll_root, ll_null)
			if isnull(ls_key) then
				wf_output("getchildkey(ll_root,null) = null",False)
			else
				wf_output("Failed: getchildkey(ll_root,null) = "+ls_key,False)
			end if
		end if
	case "p017_parserquery_getchildcount"
		if ab_execute then
			ieon_parser.loadstring( mle_1.text)
			ll_count = ieon_parser.getchildcount( ll_root)
			wf_output("getchildcount(ll_root) = "+string(ll_count),False)
			//空jsonparser对象
			ll_root_null = ljs_par.getrootitem()
			ll_count = ljs_par.getchildcount(ll_root_null)
			wf_output("getchildcount(ll_root_tmp) = "+string(ll_count),False)
			//Null参数
			ll_count = ieon_parser.getchildcount( ll_null)
			if isnull(ll_count) then
				wf_output("getchildcount(null) = null",False)
			else
				wf_output("Failed: getchildcount(null) = "+string(ll_count),False)
			end if
			//0参数时
			ll_count = ieon_parser.getchildcount( 0)
			wf_output("getchildcount(0) = "+string(ll_count),False)
			//-1参数时
			ll_count = ieon_parser.getchildcount( -1)
			wf_output("getchildcount(-1) = "+string(ll_count),False)
			//正常数据
			ll_root = ieon_parser.getrootitem()
			ll_count = ieon_parser.getchildcount(ll_root)
			wf_output("getchildcount(root) = "+string(ll_count),False)
		else
			wf_scriptview('ieon_parser.loadstring( mle_1.text)   ')
			wf_scriptview('ll_count = ieon_parser.getchildcount( ll_root)       ')
			wf_scriptview('wf_output("getchildcount(ll_root) = "+string(ll_count),False)          ')
			wf_scriptview('//空jsonparser对象        ')
			wf_scriptview('ll_root_null = ljs_par.getrootitem()           ')
			wf_scriptview('ll_count = ljs_par.getchildcount(ll_root_null)            ')
			wf_scriptview('wf_output("getchildcount(ll_root_tmp) = "+string(ll_count),False)             ')
			wf_scriptview('//Null参数           ')
			wf_scriptview('ll_count = ieon_parser.getchildcount( ll_null)            ')
			wf_scriptview('if isnull(ll_count) then            ')
			wf_scriptview('	wf_output("getchildcount(null) = null",False)      ')
			wf_scriptview('else       ')
			wf_scriptview('	wf_output("Failed: getchildcount(null) = "+string(ll_count),False)  ')
			wf_scriptview('end if     ')
			wf_scriptview('//0参数时          ')
			wf_scriptview('ll_count = ieon_parser.getchildcount( 0)          ')
			wf_scriptview('wf_output("getchildcount(0) = "+string(ll_count),False)         ')
			wf_scriptview('//-1参数时        ')
			wf_scriptview('ll_count = ieon_parser.getchildcount( -1)           ')
			wf_scriptview('wf_output("getchildcount(-1) = "+string(ll_count),False)       ')
			wf_scriptview('//正常数据   ')
			wf_scriptview('ll_root = ieon_parser.getrootitem()   ')
			wf_scriptview('ll_count = ieon_parser.getchildcount(ll_root)   ')
			wf_scriptview('wf_output("getchildcount(root) = "+string(ll_count),False)   ')
		end if
	case "p018_parserquery_getitemtype"
		//getitemtype
		if ab_execute then
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
			ll_array = ljs_gen.additemarray( ll_object, 'child_array')
			ljs_gen.additemstring( ll_array, "星期一")
			ljs_gen.additemstring( ll_array, "星期二")
			ls_json = ljs_gen.getjsonstring( )
			wf_output("jsonstring= "+ls_json,false)
			ljs_par.loadstring(ls_json)
			ll_root = ljs_par.getrootitem( )
			ll_count = ljs_par.getchildcount( ll_root)
			for ll_loop = 1 to ll_count
				ls_key = ljs_par.getchildkey( ll_root, ll_loop)
				ll_child = ljs_par.getchilditem( ll_root, ll_loop)
				ljs_type = ljs_par.getitemtype(ll_child)
				choose case ljs_type
					case jsonstringitem!
						wf_output(ls_key+" is jsonstringitem!",false)
					case jsonnumberitem!
						wf_output(ls_key+" is jsonnumberitem!",false)
					case jsonbooleanitem!
						wf_output(ls_key+" is jsonbooleanitem!",false)
					case jsonnullitem!
						wf_output(ls_key+" is jsonnullitem!",false)
					case jsonobjectitem!
						wf_output(ls_key+" is jsonobjectitem!",false)
					case jsonarrayitem!
						wf_output(ls_key+" is jsonarrayitem!",false)
					case else
						wf_output(ls_key+" is error",false)
				end choose
			next
		else
			wf_scriptview('ll_object = ljs_gen.createjsonobject( )   ')
			wf_scriptview('ljs_gen.additemstring(ll_object,~'string~',~'s_parent~')   ')
			wf_scriptview('ljs_gen.additemnumber( ll_object, ~'long~',12)   ')
			wf_scriptview('ljs_gen.additemblob( ll_object,~'blob~',blob(~'test~'))   ')
			wf_scriptview('ljs_gen.additemboolean(ll_object,~'boolean~',true)   ')
			wf_scriptview('ljs_gen.additemdatetime(ll_object,~'datetime~',datetime(~'2017-09-12 12:23:23~'))   ')
			wf_scriptview('ljs_gen.additemdate( ll_object,"date",2017-09-23)   ')
			wf_scriptview('ljs_gen.additemtime(ll_object,~'time~',12:23:23)   ')
			wf_scriptview('ljs_gen.additemnull( ll_object,~'null~')   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject(ll_object, "child_object")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"child",~'childitem~')   ')
			wf_scriptview('ll_array = ljs_gen.additemarray( ll_object, ~'child_array~')   ')
			wf_scriptview('ljs_gen.additemstring( ll_array, "星期一")   ')
			wf_scriptview('ljs_gen.additemstring( ll_array, "星期二")   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("jsonstring= "+ls_json,false)   ')
			wf_scriptview('ljs_par.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ll_count = ljs_par.getchildcount( ll_root)   ')
			wf_scriptview('for ll_loop = 1 to ll_count   ')
			wf_scriptview('	ls_key = ljs_par.getchildkey( ll_root, ll_loop)   ')
			wf_scriptview('	ll_child = ljs_par.getchilditem( ll_root, ll_loop)   ')
			wf_scriptview('	ljs_type = ljs_par.getitemtype(ll_child)   ')
			wf_scriptview('	choose case ljs_type   ')
			wf_scriptview('		case jsonstringitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonstringitem!",false)   ')
			wf_scriptview('		case jsonnumberitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonnumberitem!",false)   ')
			wf_scriptview('		case jsonbooleanitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonbooleanitem!",false)   ')
			wf_scriptview('		case jsonnullitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonnullitem!",false)   ')
			wf_scriptview('		case jsonobjectitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonobjectitem!",false)   ')
			wf_scriptview('		case jsonarrayitem!   ')
			wf_scriptview('			wf_output(ls_key+" is jsonarrayitem!",false)   ')
			wf_scriptview('		case else   ')
			wf_scriptview('			wf_output(ls_key+" is error",false)   ')
			wf_scriptview('	end choose   ')
			wf_scriptview('next   ')
		end if
	case "p019_parserquery_isnullitem"
		if ab_execute then
			//下个版本会删除该测试点
//			ll_object = ljs_gen.createjsonobject( )
//			ljs_gen.additemstring(ll_object,"string","test")
//			ljs_gen.additemnull( ll_object,"null")
//			ieon_parser.loadstring( ljs_gen.getjsonstring())
//			ll_root = ieon_parser.getrootitem( )
//			//参数为null时
//			lb_rtn = ieon_parser.isnullitem(ll_null)
//			if isnull(lb_rtn) then
//				wf_output("isnullitem(null) = null",false)
//			else
//				wf_output("Failed : isnullitem(null) = "+string(lb_rtn),false)
//			end if
//			//重载函数
//			lb_rtn = ieon_parser.isnullitem(ll_root,ls_null)
//			if isnull(lb_rtn) then
//				wf_output("isnullitem(root,null) = null",false)
//			else
//				wf_output("Failed:isnullitem(root,null) = "+string(lb_rtn),false)
//			end if
//			//正常参数
//			ll_child = ieon_parser.getchilditem( ll_root, 1)
//			lb_rtn = ieon_parser.isnullitem( ll_child)
//			wf_output("isnullitem() = "+string(lb_rtn),false)
//			ll_child = ieon_parser.getchilditem( ll_root, 2)
//			lb_rtn = ieon_parser.isnullitem( ll_child)
//			wf_output("isnullitem() = "+string(lb_rtn),false)
//			lb_rtn = ieon_parser.isnullitem(ll_root,'null')
//			wf_output("isnullitem(root,'null') = "+string(lb_rtn),false)
//			//异常参数0
//			lb_rtn = ieon_parser.isnullitem( 0)
//			wf_output("isnullitem(0) = "+string(lb_rtn),false)
//			//异常参数-1
//			lb_rtn = ieon_parser.isnullitem( -1)
//			wf_output("isnullitem(-1) = "+string(lb_rtn),false)
//			//异常参数2^63
//			lb_rtn = ieon_parser.isnullitem( 2^63)
//			wf_output("isnullitem(2^63) = "+string(lb_rtn),false)
		else
			wf_scriptview('ll_object = ljs_gen.createjsonobject( )   ')
			wf_scriptview('ljs_gen.additemstring(ll_object,"string","test")   ')
			wf_scriptview('ljs_gen.additemnull( ll_object,"null")   ')
			wf_scriptview('ieon_parser.loadstring( ljs_gen.getjsonstring())   ')
			wf_scriptview('ll_root = ieon_parser.getrootitem( )   ')
			wf_scriptview('//参数为null时   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem(ll_null)   ')
			wf_scriptview('if isnull(lb_rtn) then   ')
			wf_scriptview('	wf_output("isnullitem(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed : isnullitem(null) = "+string(lb_rtn),false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//重载函数   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem(ll_root,~'null~')   ')
			wf_scriptview('if isnull(lb_rtn) then   ')
			wf_scriptview('	wf_output("isnullitem(root,null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed:isnullitem(root,null) = "+string(lb_rtn),false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常参数   ')
			wf_scriptview('ll_child = ieon_parser.getchilditem( ll_root, 1)   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem( ll_child)   ')
			wf_scriptview('wf_output("isnullitem() = "+string(lb_rtn),false)   ')
			wf_scriptview('ll_child = ieon_parser.getchilditem( ll_root, 2)   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem( ll_child)   ')
			wf_scriptview('wf_output("isnullitem() = "+string(lb_rtn),false)   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem(ll_root,~'null~')   ')
			wf_scriptview('wf_output("isnullitem(root,~'null~') = "+string(lb_rtn),false)   ')
			wf_scriptview('//异常参数0   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem( 0)   ')
			wf_scriptview('wf_output("isnullitem(0) = "+string(lb_rtn),false)   ')
			wf_scriptview('//异常参数-1   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem( -1)   ')
			wf_scriptview('wf_output("isnullitem(-1) = "+string(lb_rtn),false)   ')
			wf_scriptview('//异常参数2^63   ')
			wf_scriptview('lb_rtn = ieon_parser.isnullitem( 2^63)   ')
			wf_scriptview('wf_output("isnullitem(2^63) = "+string(lb_rtn),false)   ')
		end if
	case else
			MessageBox("Error",as_item+" Not Coding",Exclamation!)
	End Choose

end subroutine

public subroutine wf_scriptexe_getitem (string as_item, boolean ab_execute);//测试jsonparser的getitem系列函数基本操作
long ll_handle,ll_root,ll_null
string ls_key,ls_value,ls_rtn,ls_json,ls_null,ls_output,ls_load
long ll_object,ll_object2,ll_index,ll_array,ll_objecttmp
jsonparser ljs_par,ljs_partmp
jsongenerator ljs_gen,ljs_gentmp
setnull(ll_null)
setnull(ls_null)
ljs_par = create jsonparser
ljs_gen = create jsongenerator
ljs_partmp = create jsonparser
ljs_gentmp = create jsongenerator

Choose Case as_item
	Case 'p020_getitemstring'
		If ab_execute  Then	
			//Null 参数
			ls_value = ljs_par.getitemstring( ll_null)
			if isnull(ls_value) then
				wf_output("getitemstring(null) = null",False)
			else
				wf_output("Failed: getitemstring(null) = "+ls_value,False)
			end if
			ls_value = ljs_par.getitemstring( 0,ls_null)
			if isnull(ls_value) then
				wf_output("getitemstring(null) = null",False)
			else
				wf_output("Failed: getitemstring(null) = "+ls_value,False)
			end if
			//-1 /0句柄
			ls_json = '{"name":"test"}'
			ljs_par.loadstring( ls_json)
			try
				ls_value = ljs_par.getitemstring(-1)
				wf_output("getitemstring(-1) = "+ls_value,False)
			catch (runtimeerror re_1)
				wf_output("getitemstring(-1) = "+re_1.getmessage(),False)	
			end try
			try
				ls_value = ljs_par.getitemstring(0,"name")
				wf_output("getitemstring(0,~"name~") = "+ls_value,False)
			catch (runtimeerror re_2)
				wf_output("getitemstring(0,~"name~") = "+re_2.getmessage(),False)	
			end try
			//正常句柄
			ll_root = ljs_par.getrootitem( )
			ll_handle = ljs_par.getchilditem( ll_root,1)
			ls_value = ljs_par.getitemstring(ll_handle)
			wf_output("getitemstring(handle) = "+ls_value,False)
			ls_value = ljs_par.getitemstring(ll_root,'name')
			wf_output("getitemstring(root,'name') = "+ls_value,False)
			//特殊字符
			ls_json = '{"name":"te~r~nst"}'
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			try
				ls_value = ljs_par.getitemstring(ll_root,'name')
				wf_output("getitemstring(root,'name') = "+ls_value,False)
			catch(runtimeerror re_3)
				wf_output("getitemstring(-1) = "+re_3.getmessage(),False)	
			end try
			
			//多字节字符
			ls_json = '{"姓名":"李三"}'
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = ljs_par.getitemstring(ll_root,'姓名')
			wf_output("getitemstring(root,'姓名') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root,1)
			ls_value = ljs_par.getitemstring(ll_handle)   
			wf_output("getitemstring(handle) = "+ls_value,False)
			//key为空字符时
			ls_json = '{"  ":"李三"}'
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = ljs_par.getitemstring(ll_root,'  ')
			wf_output("getitemstring(root,'  ') = "+ls_value,False)
		Else
			wf_scriptview('//Null 参数   ')
			wf_scriptview('ls_value = ljs_par.getitemstring( ll_null)   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("getitemstring(null) = null",False)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed: getitemstring(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = ljs_par.getitemstring( 0,ls_null)   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("getitemstring(null) = null",False)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed: getitemstring(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//-1 /0句柄   ')
			wf_scriptview('ls_json = ~'{"name":"test"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = ljs_par.getitemstring(-1)   ')
			wf_scriptview('	wf_output("getitemstring(-1) = "+ls_value,False)   ')
			wf_scriptview('catch (runtimeerror re_1)   ')
			wf_scriptview('		   ')
			wf_scriptview('end try   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = ljs_par.getitemstring(0,"name")   ')
			wf_scriptview('	wf_output("getitemstring(0,~"name~") = "+ls_value,False)   ')
			wf_scriptview('catch (runtimeerror re_2)   ')
			wf_scriptview('		   ')
			wf_scriptview('end try   ')
			wf_scriptview('//正常句柄   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root,1)   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_handle)   ')
			wf_scriptview('wf_output("getitemstring(handle) = "+ls_value,False)   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,~'name~')   ')
			wf_scriptview('wf_output("getitemstring(root,~'name~') = "+ls_value,False)   ')
			wf_scriptview('//特殊字符   ')
			wf_scriptview('ls_json = ~'{"name":"te~r~nst"}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = ljs_par.getitemstring(ll_root,~'name~')   ')
			wf_scriptview('	wf_output("getitemstring(root,~'name~') = "+ls_value,False)   ')
			wf_scriptview('catch(runtimeerror re_3)   ')
			wf_scriptview('	wf_output("getitemstring(-1) = "+re_3.getmessage(),False)')
			wf_scriptview('end try   ')
			wf_scriptview('//多字节字符   ')
			wf_scriptview('ls_json = ~'{"姓名":"李三"}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,~'姓名~')   ')
			wf_scriptview('wf_output("getitemstring(root,~'姓名~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root,1)   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_handle)   ')
			wf_scriptview('wf_output("getitemstring(handle) = "+ls_value,False)   ')
			wf_scriptview('//key为空字符时   ')
			wf_scriptview('ls_json = ~'{"  ":"李三"}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = ljs_par.getitemstring(ll_root,~'  ~')   ')
			wf_scriptview('wf_output("getitemstring(root,~'  ~') = "+ls_value,False)   ')
		End If
	case "p021_getitemnumber"
		if ab_execute then
			ls_value = string(ljs_par.Getitemnumber( ll_null))
			if isnull(ls_value) then
				wf_output("Getitemnumber(null) = null",false)
			else
				wf_output("Failed:Getitemnumber(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.Getitemnumber( 0,ls_null))
			if isnull(ls_value) then
				wf_output("Getitemnumber(null) = null",false)
			else
				wf_output("Failed:Getitemnumber(null) = "+ls_value,False)
			end if
			//正常句柄
			ls_json= '{"number1":34,"number2":453.56090}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.getitemnumber(ll_root, "number2"))
			wf_output("getitemnumber(root,'number2') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.getitemnumber(ll_handle))
			wf_output("getitemnumber(handle) = "+ls_value,False)
			//key为日文字符
			ls_json = '{"フルネーム":45}'
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.getitemnumber(ll_root, "フルネーム"))
			wf_output("getitemnumber(root,'フルネーム') = "+ls_value,False)
			//key为空串
			ls_json = '{"":567.8}'
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.getitemnumber(ll_root, ""))
			wf_output("getitemnumber(root,'') = "+ls_value,False)
			//数据为非number时
			try
				ls_json = '{"number":"test"}'
				ljs_par.loadstring( ls_json)
				ll_root = ljs_par.getrootitem( )
				ls_value = string(ljs_par.getitemnumber(ll_root, "number"))
			catch (runtimeerror re)
				wf_output("Runtimeerror Message = "+re.getmessage(),False)
			end try
			//end if
			//key 错误时
			ls_json = '{"number":45}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			try
				ls_value = string(ljs_par.getitemnumber(ll_root, "nuber"))
				wf_output("getitemnumber(root,'nuber') = "+ls_value,False)
			catch (runtimeerror re_4)
				wf_output("Runtimeerror Message = "+re_4.getmessage(),False)
			end try
			//key相同时
			ls_json = '{"number":40,"number":50}'
			ljs_par.loadstring(ls_json)
			ll_root = ljs_par.getrootitem( )
			ll_index = ljs_par.getchilditem( ll_root,1)
			ls_value = string(ljs_par.getitemnumber(ll_root,"number"))
			wf_output("getitemnumber(root,'number') = "+ls_value,False)
			ls_value = string(ljs_par.getitemnumber( ll_index))
			wf_output("getitemnumber(index1) = "+ls_value,False)
			ll_index = ljs_par.getchilditem( ll_root,2)
			ls_value = string(ljs_par.getitemnumber( ll_index))
			wf_output("getitemnumber(index2) = "+ls_value,False)
		else
			wf_scriptview('ls_value = string(ljs_par.Getitemnumber( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("Getitemnumber(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed:Getitemnumber(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemnumber( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("Getitemnumber(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed:Getitemnumber(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常句柄   ')
			wf_scriptview('ls_json= ~'{"number1":34,"number2":453.56090}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_root, "number2"))   ')
			wf_scriptview('wf_output("getitemnumber(root,~'number2~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_handle))   ')
			wf_scriptview('wf_output("getitemnumber(handle) = "+ls_value,False)   ')
			wf_scriptview('//key为日文字符   ')
			wf_scriptview('ls_json = ~'{"フルネーム":45}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_root, "フルネーム"))   ')
			wf_scriptview('wf_output("getitemnumber(root,~'フルネーム~') = "+ls_value,False)   ')
			wf_scriptview('//key为空串   ')
			wf_scriptview('ls_json = ~'{"":567.8}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_root, ""))   ')
			wf_scriptview('wf_output("getitemnumber(root,~'~') = "+ls_value,False)   ')
			wf_scriptview('//数据为非number时   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_json = ~'{"number":"test"}~'   ')
			wf_scriptview('	ljs_par.loadstring( ls_json)   ')
			wf_scriptview('	ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('	ls_value = string(ljs_par.getitemnumber(ll_root, "number"))   ')
			wf_scriptview('catch (runtimeerror re)   ')
			wf_scriptview('	wf_output("Runtimeerror Message = "+re.getmessage(),False)   ')
			wf_scriptview('end try   ')
			wf_scriptview('//end if   ')
			wf_scriptview('//key 错误时   ')
			wf_scriptview('ls_json = ~'{"number":45}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_root, "nuber"))   ')
			wf_scriptview('wf_output("getitemnumber(root,~'nuber~') = "+ls_value,False)   ')
			wf_scriptview('//key相同时   ')
			wf_scriptview('ls_json = ~'{"number":40,"number":50}~'   ')
			wf_scriptview('ljs_par.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ll_index = ljs_par.getchilditem( ll_root,1)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber(ll_root,"number"))   ')
			wf_scriptview('wf_output("getitemnumber(root,~'number~') = "+ls_value,False)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber( ll_index))   ')
			wf_scriptview('wf_output("getitemnumber(index1) = "+ls_value,False)   ')
			wf_scriptview('ll_index = ljs_par.getchilditem( ll_root,2)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemnumber( ll_index))   ')
			wf_scriptview('wf_output("getitemnumber(index2) = "+ls_value,False)   ')
		end if
	case "p022_getitemboolean"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.Getitemboolean( ll_null))
			if isnull(ls_value) then
				wf_output( "Getitemboolean(null) = null",false)
			else
				wf_output( "Failed:Getitemboolean(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.Getitemboolean( 0,ls_null))
			if isnull(ls_value) then
				wf_output( "Getitemboolean(null) = null",false)
			else
				wf_output( "failed:Getitemboolean(null) = "+ls_value,False)
			end if
			//正常参数
			ls_json = '{"boolean1":true,"boolean2":false}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemboolean(ll_root, "boolean2"))
			wf_output("Getitemboolean(root,'boolean2') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemboolean(ll_handle))
			wf_output("Getitemboolean(handle) = "+ls_value,False)
			//key为数字
			ls_json ='{"42":true}'
			ls_load = ljs_par.loadstring( ls_json )
			wf_output( "loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemboolean(ll_root, "42"))
			wf_output("Getitemboolean(root,'42') = "+ls_value,False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemboolean( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "Getitemboolean(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:Getitemboolean(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemboolean( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "Getitemboolean(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "failed:Getitemboolean(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常参数   ')
			wf_scriptview('ls_json = ~'{"boolean1":true,"boolean2":false}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemboolean(ll_root, "boolean2"))   ')
			wf_scriptview('wf_output("Getitemboolean(root,~'boolean2~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemboolean(ll_handle))   ')
			wf_scriptview('wf_output("Getitemboolean(handle) = "+ls_value,False)   ')
			wf_scriptview('//key为数字   ')
			wf_scriptview('ls_json =~'{"42":true}~'   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json )   ')
			wf_scriptview('wf_output( "loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemboolean(ll_root, "42"))   ')
			wf_scriptview('wf_output("Getitemboolean(root,~'42~') = "+ls_value,False)   ')
		end if
	case "p023_getitemdate"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.GetitemDate( ll_null))
			if isnull(ls_value) then
				wf_output("GetitemDate(null) = null",false)
			else
				wf_output("Failed:GetitemDate(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.GetitemDate( 0,ls_null))
			if isnull(ls_value) then
				wf_output("GetitemDate(null) = null",false)
			else
				wf_output("GetitemDate(null) = "+ls_value,False)
			end if
			//正常参数，通过js加载
			ls_json = '{"date":"2017-09-08"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdate(ll_root, "date"))
			wf_output("getitemdate(root,'date') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.getitemdate(ll_handle))
			wf_output("getitemdate(handle) = "+ls_value,False)
			//通过generatoer对象加载
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdate( ll_object, 'date', 2017-09-08)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdate(ll_root, "date"))
			wf_output("getitemdate(root,'date') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.getitemdate(ll_handle))
			wf_output("getitemdate(handle) = "+ls_value,False)
			//key为韩文
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdate( ll_object, '날짜', 2017-09-08)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdate(ll_root, "날짜"))
			wf_output("getitemdate(root,'날짜') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.getitemdate(ll_handle))
			wf_output("getitemdate(handle) = "+ls_value,False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.GetitemDate( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("GetitemDate(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed:GetitemDate(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.GetitemDate( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("GetitemDate(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("GetitemDate(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常参数，通过js加载   ')
			wf_scriptview('ls_json = ~'{"date":"2017-09-08"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdate(ll_root, "date"))   ')
			wf_scriptview('wf_output("getitemdate(root,~'date~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemdate(ll_handle))   ')
			wf_scriptview('wf_output("getitemdate(handle) = "+ls_value,False)   ')
			wf_scriptview('//通过generatoer对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdate( ll_object, ~'date~', 2017-09-08)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdate(ll_root, "date"))   ')
			wf_scriptview('wf_output("getitemdate(root,~'date~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemdate(ll_handle))   ')
			wf_scriptview('wf_output("getitemdate(handle) = "+ls_value,False)   ')
			wf_scriptview('//key为韩文   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdate( ll_object, ~'날짜~', 2017-09-08)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdate(ll_root, "날짜"))   ')
			wf_scriptview('wf_output("getitemdate(root,~'날짜~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.getitemdate(ll_handle))   ')
			wf_scriptview('wf_output("getitemdate(handle) = "+ls_value,False)   ')
		end if
	case "p024_getitemtime"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.Getitemtime( ll_null))
			if isnull(ls_value) then
				wf_output( "Getitemtime(null) = null",false)
			else
				wf_output( "Failed: Getitemtime(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.Getitemtime( 0,ls_null))
			if isnull(ls_value) then
				wf_output( "Getitemtime(null) = null",false)
			else
				wf_output( "Failed: Getitemtime(null) = "+ls_value,False)
			end if
			//正常参数，通过js加载
			ls_json = '{"time":"12:23:23"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"))
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemtime(ll_handle))
			wf_output("Getitemtime(handle) = "+ls_value,False)
			//通过generatoer对象加载
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemtime( ll_object, 'time', 12:23:23)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"))
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemtime(ll_handle))
			wf_output("Getitemtime(handle) = "+ls_value,False)
			//时间带毫秒
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemtime( ll_object, 'time', 12:23:23.156)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:fff")
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			ls_json = '{"time":"12:23:23:234"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:fff")
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			//时间带微秒
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemtime( ll_object, 'time', 12:23:23.156456)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:ffffff")
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			ls_json = '{"time":"12:23:23:234123"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:ffffff")
			wf_output("Getitemtime(root,'time') = "+ls_value,False)
			//key为阿拉伯文
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemtime( ll_object, 'وقت', 12:23:23)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemtime(ll_root, "وقت"))
			wf_output("Getitemtime(root,'وقت') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemtime(ll_handle))
			wf_output("Getitemtime(handle) = "+ls_value,False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "Getitemtime(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed: Getitemtime(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "Getitemtime(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed: Getitemtime(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常参数，通过js加载   ')
			wf_scriptview('ls_json = ~'{"time":"12:23:23"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"))   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemtime(handle) = "+ls_value,False)   ')
			wf_scriptview('//通过generatoer对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemtime( ll_object, ~'time~', 12:23:23)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"))   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemtime(handle) = "+ls_value,False)   ')
			wf_scriptview('//时间带毫秒   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemtime( ll_object, ~'time~', 12:23:23.156)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('ls_json = ~'{"time":"12:23:23:234"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('//时间带微秒   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemtime( ll_object, ~'time~', 12:23:23.156456)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('ls_json = ~'{"time":"12:23:23:234123"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "time"),"hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemtime(root,~'time~') = "+ls_value,False)   ')
			wf_scriptview('//key为阿拉伯文   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemtime( ll_object,  وقت, 12:23:23)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_root, "وقت"))   ')
			wf_scriptview('wf_output("Getitemtime(root,~'وقت~')= "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemtime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemtime(handle) = "+ls_value,False)   ')
		end if
	case "p025_getitemdatetime"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.Getitemdatetime( ll_null))
			if isnull(ls_value) then
				wf_output("Getitemdatetime(null) = null",false)
			else
				wf_output("Failed: Getitemdatetime(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.Getitemdatetime( 0,ls_null))
			if isnull(ls_value) then
				wf_output("Getitemdatetime(null) = null",false)
			else
				wf_output("Failed: Getitemdatetime(null) = "+ls_value,False)
			end if
			//正常参数，通过js加载
			ls_json = '{"datetime":"2017-09-12 12:23:23"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle))
			wf_output("Getitemdatetime(handle) = "+ls_value,False)
			//加载毫秒的数据
			ls_json = '{"datetime":"2017-09-12 12:23:23:345"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(handle) = "+ls_value,False)
			//加载带毫秒的时间戳
			ls_json = "{~"datetime~":1505190515321}"
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			//加载微秒的数据
			ls_json = '{"datetime":"2017-09-12 12:23:23:345234"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle),"yyyy-mm-dd hh:mm:ss:ffffff")
			wf_output("Getitemdatetime(handle) = "+ls_value,False)
			//通过generator对象加载带毫秒的数据
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23:312"))
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(handle) = "+ls_value,False)
			//通过generator对象加载
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23"))
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle))
			wf_output("Getitemdatetime(handle) = "+ls_value,False)
			//key为德文
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'Datumäöüß', datetime("2017-09-12 12:23:23"))
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root,"Datumäöüß"))
			wf_output("Getitemdatetime(root,'Datumäöüß') = "+ls_value,false)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemdatetime(ll_handle))
			wf_output("Getitemdatetime(handle) = "+ls_value,false)
			//通过long型加载datetime数据
			ll_object = gjs_gen.createjsonobject()
			gjs_gen.additemdatetime( ll_object, "testdate_long", datetime("2017-11-12 12:23:23"),true)
			gjs_gen.additemdatetime( ll_object, "testdate", datetime("2017-11-12 12:23:23"),false)
			ll_array = gjs_gen.additemarray( ll_object, "date_array")
			gjs_gen.additemdatetime(ll_array,datetime("2017-11-12 12:23:23"),true)
			gjs_gen.additemdatetime(ll_array,datetime("2017-11-12 12:23:23"),false)
			ls_json = gjs_gen.getjsonstring()
			ls_load = gjs_par.loadstring(ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = gjs_par.getrootitem( )
			ls_value = string(gjs_par.getitemnumber( ll_root,"testdate_long"))
			wf_output("gjs_par.getitemnumber( root,~"testdate_long~") = "+ls_value,false)
			ls_value = string(gjs_par.getitemdatetime( ll_root,"testdate_long"))
			wf_output("gjs_par.getitemdatetime( root,~"testdate_long~") = "+ls_value,false)
			try
				ls_value = string(gjs_par.getitemdate( ll_root,"testdate_long"))
				wf_output("gjs_par.getitemdate( root,~"testdate_long~") = "+ls_value,false)
			catch (runtimeerror re_datetime1)
				wf_output("getitemdate(root,long) error : "+re_datetime1.getmessage(),false)
			end try
			ll_array = gjs_par.getitemarray( ll_root, "date_array")
			ll_index = gjs_par.getchilditem( ll_array,1)
			ls_value = string(gjs_par.getitemnumber( ll_index))
			wf_output("gjs_par.getitemnumber( index1,) = "+ls_value,false)
			ls_value = string(gjs_par.getitemdatetime( ll_index))
			wf_output("gjs_par.getitemdatetime(index1) = "+ls_value,false)
			try
				ls_value = string(gjs_par.getitemdate( ll_index))
				wf_output("gjs_par.getitemdate( index1) = "+ls_value,false)
			catch (runtimeerror re_datetime2)
				wf_output("getitemdate(index1) error : "+re_datetime2.getmessage(),false)
			end try
			//具体测试时间戳
			ll_objecttmp = ljs_gentmp.createjsonobject( )
			ljs_gentmp.additemdatetime( ll_objecttmp,"today_long",datetime(today(),now()),true)
			ljs_gentmp.additemdatetime( ll_objecttmp,"today_string",datetime(today(),now()),false)
			ls_json = ljs_gentmp.getjsonstring( )
			wf_output("ljs_gentmp.getjsonstring( ) = "+ls_json,false)
			ljs_partmp.loadstring( ls_json)
			ll_root = ljs_partmp.getrootitem( )
			ls_value = string(ljs_partmp.getitemnumber( ll_root,"today_long"))
			wf_output("ljs_partmp.getitemnumber( ll_root,~"today_long~")="+ls_value,false)
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"today_long"))
			wf_output("ljs_partmp.getitemdatetime( ll_root,~"today_long~")="+ls_value,false)
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"today_string"))
			wf_output("ljs_partmp.getitemdatetime( ll_root,~"today_string~")="+ls_value,false)
			//测试9位时间戳
			ls_json = "{~"date~":151204144}"
			ljs_partmp.loadstring(ls_json)
			ll_root = ljs_partmp.getrootitem()
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))
			wf_output("9位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)
			//测试10位时间戳
			ls_json = "{~"date~":1512041449}"
			ljs_partmp.loadstring(ls_json)
			ll_root = ljs_partmp.getrootitem()
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))
			wf_output("10位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)
			//测试11位时间戳
			ls_json = "{~"date~":15120414490}"
			ljs_partmp.loadstring(ls_json)
			ll_root = ljs_partmp.getrootitem()
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))
			wf_output("11位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)
			//测试12位时间戳 这个处理不了
			ls_json = "{~"date~":151204144902}"
			ljs_partmp.loadstring(ls_json)
			ll_root = ljs_partmp.getrootitem()
			Try
				ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))
				wf_output("12位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)
			catch (runtimeerror re_12)
				wf_output("12位时间戳：getitemdatetime() error : "+re_12.getmessage(),false)
			end try
			//测试13位时间戳
			ls_json = "{~"date~":1512041449020}"
			ljs_partmp.loadstring(ls_json)
			ll_root = ljs_partmp.getrootitem()
			ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))
			wf_output("13位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)
			//测试毫秒和时间戳情况
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23:312"),true)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23:312"),false)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			//测试微秒和时间戳情况
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23:312456"),true)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemdatetime( ll_object, 'datetime', datetime("2017-09-12 12:23:23:312456"),false)
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			if len(trim(ls_load)) = 0 then
				wf_output("loadstring("+ls_json+") Succeed ",false)
			else
				wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)
			end if
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")
			wf_output("Getitemdatetime(root,'datetime') = "+ls_value,False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("Getitemdatetime(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed: Getitemdatetime(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("Getitemdatetime(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed: Getitemdatetime(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常参数，通过js加载   ')
			wf_scriptview('ls_json = ~'{"datetime":"2017-09-12 12:23:23"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,False)   ')
			wf_scriptview('//加载毫秒的数据   ')
			wf_scriptview('ls_json = ~'{"datetime":"2017-09-12 12:23:23:345"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,False)   ')
			wf_scriptview('//加载带毫秒的时间戳   ')
			wf_scriptview('ls_json = "{~"datetime~":1505190515321}"   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('//加载微秒的数据   ')
			wf_scriptview('ls_json = ~'{"datetime":"2017-09-12 12:23:23:345234"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle),"yyyy-mm-dd hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,False)   ')
			wf_scriptview('//通过generator对象加载带毫秒的数据   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23:312"))   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,False)   ')
			wf_scriptview('//通过generator对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23"))   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"))   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,False)   ')	
			wf_scriptview('//key为德文   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'Datumäöüß~', datetime("2017-09-12 12:23:23"))   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root,"Datumäöüß"))   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'Datumäöüß~') = "+ls_value,false)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_handle))   ')
			wf_scriptview('wf_output("Getitemdatetime(handle) = "+ls_value,false)   ')
			wf_scriptview('//通过long型加载datetime数据   ')
			wf_scriptview('ll_object = gjs_gen.createjsonobject()   ')
			wf_scriptview('gjs_gen.additemdatetime( ll_object, "testdate_long", datetime("2017-11-12 12:23:23"),true)   ')
			wf_scriptview('gjs_gen.additemdatetime( ll_object, "testdate", datetime("2017-11-12 12:23:23"),false)   ')
			wf_scriptview('ll_array = gjs_gen.additemarray( ll_object, "date_array")   ')
			wf_scriptview('gjs_gen.additemdatetime(ll_array,datetime("2017-11-12 12:23:23"),true)   ')
			wf_scriptview('gjs_gen.additemdatetime(ll_array,datetime("2017-11-12 12:23:23"),false)   ')
			wf_scriptview('ls_json = gjs_gen.getjsonstring()   ')
			wf_scriptview('ls_load = gjs_par.loadstring(ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = gjs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(gjs_par.getitemnumber( ll_root,"testdate_long"))   ')
			wf_scriptview('wf_output("gjs_par.getitemnumber( root,~"testdate_long~") = "+ls_value,false)   ')
			wf_scriptview('ls_value = string(gjs_par.getitemdatetime( ll_root,"testdate_long"))   ')
			wf_scriptview('wf_output("gjs_par.getitemdatetime( root,~"testdate_long~") = "+ls_value,false)   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = string(gjs_par.getitemdate( ll_root,"testdate_long"))   ')
			wf_scriptview('	wf_output("gjs_par.getitemdate( root,~"testdate_long~") = "+ls_value,false)   ')
			wf_scriptview('catch (runtimeerror re_datetime1)   ')
			wf_scriptview('	wf_output("getitemdate(root,long) error : "+re_datetime1.getmessage(),false)   ')
			wf_scriptview('end try   ')
			wf_scriptview('ll_array = gjs_par.getitemarray( ll_root, "date_array")   ')
			wf_scriptview('ll_index = gjs_par.getchilditem( ll_array,1)   ')
			wf_scriptview('ls_value = string(gjs_par.getitemnumber( ll_index))   ')
			wf_scriptview('wf_output("gjs_par.getitemnumber( index1,) = "+ls_value,false)   ')
			wf_scriptview('ls_value = string(gjs_par.getitemdatetime( ll_index))   ')
			wf_scriptview('wf_output("gjs_par.getitemdatetime(index1) = "+ls_value,false)   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = string(gjs_par.getitemdate( ll_index))   ')
			wf_scriptview('	wf_output("gjs_par.getitemdate( index1) = "+ls_value,false)   ')
			wf_scriptview('catch (runtimeerror re_datetime2)   ')
			wf_scriptview('	wf_output("getitemdate(index1) error : "+re_datetime2.getmessage(),false)   ')
			wf_scriptview('end try   ')
			wf_scriptview('//测试9位时间戳   ')
			wf_scriptview('ls_json = "{~"date~":151204144}"   ')
			wf_scriptview('ljs_partmp.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_partmp.getrootitem()   ')
			wf_scriptview('ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))   ')
			wf_scriptview('wf_output("9位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)   ')
			wf_scriptview('//测试10位时间戳   ')
			wf_scriptview('ls_json = "{~"date~":1512041449}"   ')
			wf_scriptview('ljs_partmp.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_partmp.getrootitem()   ')
			wf_scriptview('ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))   ')
			wf_scriptview('wf_output("10位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)   ')
			wf_scriptview('//测试11位时间戳   ')
			wf_scriptview('ls_json = "{~"date~":15120414490}"   ')
			wf_scriptview('ljs_partmp.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_partmp.getrootitem()   ')
			wf_scriptview('ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))   ')
			wf_scriptview('wf_output("11位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)   ')
			wf_scriptview('//测试12位时间戳 这个处理不了   ')
			wf_scriptview('ls_json = "{~"date~":151204144902}"   ')
			wf_scriptview('ljs_partmp.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_partmp.getrootitem()   ')
			wf_scriptview('Try   ')
			wf_scriptview('	ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))   ')
			wf_scriptview('	wf_output("12位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)   ')
			wf_scriptview('catch (runtimeerror re_12)   ')
			wf_scriptview('	wf_output("12位时间戳：getitemdatetime() error : "+re_12.getmessage(),false)   ')
			wf_scriptview('end try   ')
			wf_scriptview('//测试13位时间戳   ')
			wf_scriptview('ls_json = "{~"date~":1512041449020}"   ')
			wf_scriptview('ljs_partmp.loadstring(ls_json)   ')
			wf_scriptview('ll_root = ljs_partmp.getrootitem()   ')
			wf_scriptview('ls_value = string(ljs_partmp.getitemdatetime( ll_root,"date"))   ')
			wf_scriptview('wf_output("13位时间戳：ljs_partmp.getitemdatetime( ll_root,~"date~")="+ls_value,false)   ')
			wf_scriptview('//测试毫秒和时间戳情况   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23:312"),true)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23:312"),false)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:fff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('//测试微秒和时间戳情况   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23:312456"),true)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemdatetime( ll_object, ~'datetime~', datetime("2017-09-12 12:23:23:312456"),false)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('if len(trim(ls_load)) = 0 then   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Succeed ",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadstring("+ls_json+") Failed : "+ls_load,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemdatetime(ll_root, "datetime"),"yyyy-mm-dd hh:mm:ss:ffffff")   ')
			wf_scriptview('wf_output("Getitemdatetime(root,~'datetime~') = "+ls_value,False)   ')
		end if
	case "p026_getitemblob"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.GetItemBlob( ll_null))
			if isnull(ls_value) then
				wf_output( "GetItemBlob(null) = null",false)
			else
				wf_output( "Failed:GetItemBlob(null) = "+ls_value,False)
			end if
			ls_value = string(ljs_par.GetItemBlob( 0,ls_null))
			if isnull(ls_value) then
				wf_output( "GetItemBlob(null) = null",false)
			else
				wf_output( "Failed: GetItemBlob(null) = "+ls_value,False)
			end if
			//通过generator对象加载
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemblob( ll_object, 'blob', blob("Test测试"))
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output( "loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemblob(ll_root, "blob"))
			wf_output("Getitemblob(root,'blob') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemblob(ll_handle))
			wf_output("Getitemblob(handle) = "+ls_value,False)
			//key为西班牙文  borrón
			ll_object = ljs_gen.createjsonobject()
			ljs_gen.additemblob( ll_object, 'borrón', blob("borrón测试"))
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output( "loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemblob(ll_root, "borrón"))
			wf_output("Getitemblob(root,'borrón') = "+ls_value,False)
			ll_handle = ljs_par.getchilditem( ll_root, 1)
			ls_value = string(ljs_par.Getitemblob(ll_handle))
			wf_output("Getitemblob(handle) = "+ls_value,False)
			//通过blob获取字符串数据
			ls_json = '{"test":"Test"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			try
				ls_value = string(ljs_par.Getitemblob(ll_root, "test"))
				wf_output("Getitemblob(root,'test') = "+ls_value,False)
			catch(runtimeerror re_blob1)
				wf_output("Getitemblob(root,'test') Error = "+re_blob1.getmessage(),False)
			end try
			//通过blob转码的字符串加载
			ls_json = '{"test":"VABlAHMAdABLbdWL"}'
			ljs_par.loadstring( ls_json)
			ll_root = ljs_par.getrootitem( )
			try
				ls_value = string(ljs_par.Getitemblob(ll_root, "test"))
				wf_output("Getitemblob(root,'test') = "+ls_value,False)
			catch(runtimeerror re_blob2)
				wf_output("Getitemblob(root,'test') Error = "+re_blob2.getmessage(),False)
			end try
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.GetItemBlob( ll_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "GetItemBlob(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:GetItemBlob(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ls_value = string(ljs_par.GetItemBlob( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "GetItemBlob(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed: GetItemBlob(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//通过generator对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemblob( ll_object, ~'blob~', blob("Test测试"))   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output( "loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemblob(ll_root, "blob"))   ')
			wf_scriptview('wf_output("Getitemblob(root,~'blob~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemblob(ll_handle))   ')
			wf_scriptview('wf_output("Getitemblob(handle) = "+ls_value,False)   ')
			wf_scriptview('//key为西班牙文  borrón   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ljs_gen.additemblob( ll_object, ~'borrón~', blob("borrón测试"))   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output( "loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemblob(ll_root, "borrón"))   ')
			wf_scriptview('wf_output("Getitemblob(root,~'borrón~') = "+ls_value,False)   ')
			wf_scriptview('ll_handle = ljs_par.getchilditem( ll_root, 1)   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemblob(ll_handle))   ')
			wf_scriptview('wf_output("Getitemblob(handle) = "+ls_value,False)   ')
			wf_scriptview('//通过blob获取字符串数据   ')
			wf_scriptview('ls_json = ~'{"test":"Test"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = string(ljs_par.Getitemblob(ll_root, "test"))   ')
			wf_scriptview('	wf_output("Getitemblob(root,~'test~') = "+ls_value,False)   ')
			wf_scriptview('catch(runtimeerror re_blob1)   ')
			wf_scriptview('	wf_output("Getitemblob(root,~'test~') Error = "+re_blob1.getmessage(),False)   ')
			wf_scriptview('end try   ')
			wf_scriptview('//通过blob转码的字符串加载   ')
			wf_scriptview('ls_json = ~'{"test":"VABlAHMAdABLbdWL"}~'   ')
			wf_scriptview('ljs_par.loadstring( ls_json)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('try   ')
			wf_scriptview('	ls_value = string(ljs_par.Getitemblob(ll_root, "test"))   ')
			wf_scriptview('	wf_output("Getitemblob(root,~'test~') = "+ls_value,False)   ')
			wf_scriptview('catch(runtimeerror re_blob2)   ')
			wf_scriptview('	wf_output("Getitemblob(root,~'test~') Error = "+re_blob2.getmessage(),False)   ')
			wf_scriptview('end try   ')
		end if
	case "p027_getitemobject"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.Getitemobject( 0,ls_null))
			if isnull(ls_value) then
				wf_output("Getitemobject(null) = null",false)
			else
				wf_output("Failed : Getitemobject(null) = "+ls_value,False)
			end if
			//通过generator对象加载
			ll_object = ljs_gen.createjsonobject()
			ll_object2 = ljs_gen.additemobject( ll_object, 'object')
			ljs_gen.additemstring(ll_object2,'name',"test1")
			ljs_gen.additemnumber( ll_object2,'number',34)
			ljs_gen.additemstring(ll_object2,'Null','null')
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemobject(ll_root, "object"))
			wf_output("Getitemobject(root,'object') = "+ls_value,False)
			wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)
			//key为俄文 Россия
			ll_object = ljs_gen.createjsonobject()
			ll_object2 = ljs_gen.additemobject( ll_object, 'Россия')
			ljs_gen.additemstring(ll_object2,'name',"test1Россия")
			ljs_gen.additemnumber( ll_object2, 34)
			ljs_gen.additemstring(ll_object2,'Null','null')
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output("loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemobject(ll_root, "Россия"))
			wf_output("Getitemobject(root,'Россия') = "+ls_value,False)
			wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemobject( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output("Getitemobject(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed : Getitemobject(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//通过generator对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object, ~'object~')   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'name~',"test1")   ')
			wf_scriptview('ljs_gen.additemnumber( ll_object2,~'number~',34)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'Null~',~'null~')   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemobject(ll_root, "object"))   ')
			wf_scriptview('wf_output("Getitemobject(root,~'object~') = "+ls_value,False)   ')
			wf_scriptview('wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)   ')
			wf_scriptview('//key为俄文 Россия   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object, ~'Россия~')   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'name~',"test1Россия")   ')
			wf_scriptview('ljs_gen.additemnumber( ll_object2, 34)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'Null~',~'null~')   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output("loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemobject(ll_root, "Россия"))   ')
			wf_scriptview('wf_output("Getitemobject(root,~'Россия~') = "+ls_value,False)   ')
			wf_scriptview('wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)   ')
		end if
	case "p028_getitemarray"
		if ab_execute then
			//Null参数
			ls_value = string(ljs_par.Getitemarray( 0,ls_null))
			if isnull(ls_value) then
				wf_output( "Getitemarray(null) = null",false)
			else
				wf_output( "Getitemarray(null) = "+ls_value,False)
			end if
			//通过generator对象加载
			ll_object = ljs_gen.createjsonobject()
			ll_object2 = ljs_gen.additemarray( ll_object, 'array')
			ljs_gen.additemstring(ll_object2,"test1")
			ljs_gen.additemnumber( ll_object2, 34)
			ljs_gen.additemstring(ll_object2,'null')
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output( "loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemarray(ll_root, "array"))
			wf_output("Getitemobject(root,'array') = "+ls_value,False)
			wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)
			//key为泰文 วาล์วด้วยมือ
			ll_object = ljs_gen.createjsonobject()
			ll_object2 = ljs_gen.additemarray( ll_object, 'วาล์วด้วยมือ')
			ljs_gen.additemstring(ll_object2,"test1วาล์วด้วยมือ")
			ljs_gen.additemnumber( ll_object2, 34)
			ljs_gen.additemstring(ll_object2,'Null')
			ls_json = ljs_gen.getjsonstring( )
			ls_load = ljs_par.loadstring( ls_json)
			wf_output( "loadstring("+ls_json+") = "+ls_load,False)
			ll_root = ljs_par.getrootitem( )
			ls_value = string(ljs_par.Getitemarray(ll_root, "วาล์วด้วยมือ"))
			wf_output("Getitemobject(root,'วาล์วด้วยมือ') = "+ls_value,False)
			wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)
		else
			wf_scriptview('//Null参数   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemarray( 0,ls_null))   ')
			wf_scriptview('if isnull(ls_value) then   ')
			wf_scriptview('	wf_output( "Getitemarray(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Getitemarray(null) = "+ls_value,False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//通过generator对象加载   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object, ~'array~')   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"test1")   ')
			wf_scriptview('ljs_gen.additemnumber( ll_object2, 34)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'null~')   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output( "loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemarray(ll_root, "array"))   ')
			wf_scriptview('wf_output("Getitemobject(root,~'array~') = "+ls_value,False)   ')
			wf_scriptview('wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)   ')
			wf_scriptview('//key为泰文 วาล์วด้วยมือ   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject()   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object, ~'วาล์วด้วยมือ~')   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"test1วาล์วด้วยมือ")   ')
			wf_scriptview('ljs_gen.additemnumber( ll_object2, 34)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,~'Null~')   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('ls_load = ljs_par.loadstring( ls_json)   ')
			wf_scriptview('wf_output( "loadstring("+ls_json+") = "+ls_load,False)   ')
			wf_scriptview('ll_root = ljs_par.getrootitem( )   ')
			wf_scriptview('ls_value = string(ljs_par.Getitemarray(ll_root, "วาล์วด้วยมือ"))   ')
			wf_scriptview('wf_output("Getitemobject(root,~'วาล์วด้วยมือ~') = "+ls_value,False)   ')
			wf_scriptview('wf_output("Child count of the object is "+string(ljs_par.getchildcount( long(ls_value))),False)   ')
		end if
	case else
			MessageBox("Error",as_item+" Not Coding",Exclamation!)
	End Choose

end subroutine

public subroutine wf_scriptexe_jsongenerator_classic (string as_item, boolean ab_execute);//测试jsongenerator作为powerobject对象的基本操作
jsongenerator leon_gen
string ls_rtn,ls_value,ls_tmp,ls_json
blob lb_encoding
long ll_root,ll_object
classdefinition lcd_tmp
ContextInformation  lcx_key
leon_gen = create jsongenerator
ls_tmp = '{"编号":45,"姓名":"李三"}'
Choose Case as_item
	Case 'p029_generatorclassic_classname'
		If ab_execute  Then		
			ls_rtn = leon_gen.classname( )
			wf_OutPut('leon_gen.classname( ) = ' + ls_rtn, False)
			//加入getparent测试点
			leon_gen = jsongenerator_1
			ls_rtn = leon_gen.getparent( ).classname( )
			wf_output("leon_gen.getparent( ).classname( ) = "+ls_rtn,false)
		Else
			wf_scriptview("ls_rtn = leon_gen.classname( )                                 ")
			wf_scriptview("wf_OutPut('leon_gen.classname( ) = ' + ls_rtn, False)     ")
			wf_scriptview('//加入getparent测试点   ')
			wf_scriptview('leon_gen = jsongenerator_1   ')
			wf_scriptview('ls_rtn = leon_gen.getparent( ).classname( )   ')
			wf_scriptview('wf_output("leon_gen.getparent( ).classname( ) = "+ls_rtn,false)   ')
		End If
	case "p029a_generatorclassic_classdefinition"
		//测试classdefinition对象和getcontextservice
		if ab_execute then
			//通过classdefinition获取对象名称
			lcd_tmp = leon_gen.classdefinition
			ls_rtn = lcd_tmp.name
			wf_output("classdefiniton.name="+ls_rtn,false)
			//通过服务获取公司名称
			leon_gen.GetContextservice("ContextInformation", lcx_key)
			lcx_key.GetCompanyName (ls_rtn)
			wf_output("GetCompanyName="+ls_rtn,false)
//			通过服务取parent
//			leon_gen.getcontextservice( "ContextKeyWord",lck_key)
//			ls_rtn = lck_key.getparent( ).classname( )			
		else
			wf_scriptview('//通过classdefinition获取对象名称   ')
			wf_scriptview('lcd_tmp = leon_gen.classdefinition   ')
			wf_scriptview('ls_rtn = lcd_tmp.name   ')
			wf_scriptview('wf_output("classdefiniton.name="+ls_rtn,false)   ')
			wf_scriptview('//通过服务获取公司名称   ')
			wf_scriptview('leon_gen.GetContextservice("ContextInformation", lcx_key)   ')
			wf_scriptview('lcx_key.GetCompanyName (ls_rtn)   ')
			wf_scriptview('wf_output("GetCompanyName="+ls_rtn,false)   ')
		end if
	Case "p030_generatorclassic_typeof"	
		If ab_execute  Then		
			if leon_gen.typeof( ) = jsongenerator! then
				wf_OutPut('leon_gen.typeof( ) = jsongenerator!', False)
			else
				wf_OutPut('Failed : leon_gen.typeof( ) <> jsongenerator!', False)
			end if
		Else
			wf_scriptview("if leon_gen.typeof( ) = jsongenerator! then                                 ")
			wf_scriptview("	wf_OutPut('leon_gen.typeof( ) = jsongenerator!', False)                           ")
			wf_scriptview("else    ")
			wf_scriptview("	wf_OutPut('Failed : leon_gen.typeof( ) <> jsongenerator!', False)                                 ")
			wf_scriptview("end if                                 ")
		End If
	case "p031_generatorclassic_createanddestroy"
		if ab_execute then
			Destroy leon_gen 
			if isvalid(leon_gen) then
				wf_OutPut('Failed: After destroy leon_gen is still avalid', False)
			else
				wf_OutPut('Succeed: After destroy leon_gen is not avalid', False)
			end if
			leon_gen = create using "jsongenerator"
			if isvalid(leon_gen) then
				wf_output('The object was created',False)
			else
				wf_output('Create the object failed',False)
			end if
			ll_object = leon_gen.createjsonobject()
			ls_rtn = string(leon_gen.additemnumber(ll_object,"id",100))
			wf_output("additemnumber(object,'id',100) = "+ls_rtn,false)
		else
			wf_scriptview("Destroy leon_gen                                  ")
			wf_scriptview("if isvalid(leon_gen) then                           ")
			wf_scriptview("	wf_OutPut('Failed: After destroy leon_gen is still avalid', False)")
			wf_scriptview("else    ")
			wf_scriptview("	wf_OutPut('Succeed: After destroy leon_gen is not avalid', False)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("leon_gen = create using~"jsonparser~"                              ")
			wf_scriptview("if isvalid(leon_gen) then                           ")
			wf_scriptview("	wf_output('The object was created',False)					")
			wf_scriptview("else    ")
			wf_scriptview("	wf_output('Create the object failed',False)                                 ")
			wf_scriptview("end if                                 ")
			wf_scriptview("ll_object = leon_gen.createjsonobject()                             ")
			wf_scriptview("ls_rtn = string(leon_gen.additemnumber(ll_object,~"id~",100))                           ")
			wf_scriptview("wf_output(~"additemnumber(object,'id',100) = ~"+ls_rtn,false)			")
		end if
	case "p032_generatorclassic_message"
		if ab_execute then
			ll_object = leon_gen.createjsonobject()
			leon_gen.additemnumber(ll_object,"id",100)
			leon_gen.additemstring(ll_object,"Text","test")
			openwithparm(w_tmp_generator,leon_gen)
			leon_gen = message.powerobjectparm
			ls_value = leon_gen.getjsonstring()
			wf_output("return from message is "+ls_value,false)
		else
			wf_scriptview('ll_object = leon_gen.createjsonobject()   ')
			wf_scriptview('leon_gen.additemnumber(ll_object,"id",100)   ')
			wf_scriptview('leon_gen.additemstring(ll_object,"Text","test")   ')
			wf_scriptview('openwithparm(w_tmp_generator,leon_gen)   ')
			wf_scriptview('leon_gen = message.powerobjectparm   ')
			wf_scriptview('ls_value = leon_gen.getjsonstring()   ')
			wf_scriptview('wf_output("return from message is "+ls_value,false)   ')
		end if
	case else
	 	MessageBox("Error",as_item+" Not Coding",Exclamation!)
End Choose

end subroutine

public subroutine wf_scriptexe_inout (string as_item, boolean ab_execute);//测试jsongenerator的输入输出操作
long ll_object1,ll_object2,ll_rtn
string ls_output,ls_rtn,ls_null,ls_file,ls_path,ls_json
blob lb_data
jsongenerator ljs_gen
ljs_gen = create jsongenerator
setnull(ls_null)
Choose Case as_item
	Case 'p033_generatorinout_createjsonobject'
		If ab_execute  Then		
			ll_object1 = ljs_gen.createjsonobject()
			wf_output( "First createjsonobject = "+string(ll_object1),False)
			ll_object2 = ljs_gen.createjsonobject()
			wf_output( "Second createjsonobject = "+string(ll_object2),False)
			ll_rtn = ljs_gen.additemstring(ll_object1,"name",'test')
			wf_output( "Additem to first object = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemstring(ll_object2,"name",'test')
			wf_output( "Additem to second object = "+string(ll_rtn),False)
			ls_json = ljs_gen.getjsonstring( )
			wf_output("ljs_gen.getjsonstring() = "+ls_json,false)
		Else
			wf_scriptview('ll_object1 = ljs_gen.createjsonobject()   ')
			wf_scriptview('wf_output( "First createjsonobject = "+string(ll_object1),False)   ')
			wf_scriptview('ll_object2 = ljs_gen.createjsonobject()   ')
			wf_scriptview('wf_output( "Second createjsonobject = "+string(ll_object2),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring(ll_object1,"name",~'test~')   ')
			wf_scriptview('wf_output( "Additem to first object = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring(ll_object2,"name",~'test~')   ')
			wf_scriptview('wf_output( "Additem to second object = "+string(ll_rtn),False)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("ljs_gen.getjsonstring() = "+ls_json,false)   ')
		End If
	case "p034_generatorinout_createjsonarray"
		if ab_execute then
			ll_object1 = ljs_gen.createjsonarray()
			wf_output( "First createjsonarray = "+string(ll_object1),False)
			ll_object2 = ljs_gen.createjsonarray()
			wf_output( "Second createjsonarray = "+string(ll_object2),False)
			ll_rtn = ljs_gen.additemstring(ll_object1,'test')
			wf_output( "Additem to first object = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemstring(ll_object2,'test')
			wf_output( "Additem to second object = "+string(ll_rtn),False)
		else
			wf_scriptview('ll_object1 = ljs_gen.createjsonarray()   ')
			wf_scriptview('wf_output( "First createjsonarray = "+string(ll_object1),False)   ')
			wf_scriptview('ll_object2 = ljs_gen.createjsonarray()   ')
			wf_scriptview('wf_output( "Second createjsonarray = "+string(ll_object2),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring(ll_object1,~'test~')   ')
			wf_scriptview('wf_output( "Additem to first object = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring(ll_object2,~'test~')   ')
			wf_scriptview('wf_output( "Additem to second object = "+string(ll_rtn),False)   ')
		end if
	case "p035_generatorinout_getjsonstring"
		if ab_execute then
			//重新初始化jsongenerator
			destroy ljs_gen
			ljs_gen = create jsongenerator
			//空对象保存为string
			ls_rtn = ljs_gen.getjsonstring( )
			wf_output( "空变量 To string = "+ls_rtn,False)
			ljs_gen.createjsonobject( )
			ls_rtn = ljs_gen.getjsonstring( )
			wf_output("Createjsonobject 后 to string = "+ls_rtn,False)
			ljs_gen.createjsonarray()
			ls_rtn = ljs_gen.getjsonstring( )
			wf_output("Createjsonarray 后 to string = "+ls_rtn,False)
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
			wf_output( "json string = "+ls_rtn,False)
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
			wf_output( "json string = "+ls_rtn,False)
		else
			wf_scriptview('//重新初始化jsongenerator   ')
			wf_scriptview('destroy ljs_gen   ')
			wf_scriptview('ljs_gen = create jsongenerator   ')
			wf_scriptview('//空对象保存为string   ')
			wf_scriptview('ls_rtn = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output( "空变量 To string = "+ls_rtn,False)   ')
			wf_scriptview('ljs_gen.createjsonobject( )   ')
			wf_scriptview('ls_rtn = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("Createjsonobject 后 to string = "+ls_rtn,False)   ')
			wf_scriptview('ljs_gen.createjsonarray()   ')
			wf_scriptview('ls_rtn = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("Createjsonarray 后 to string = "+ls_rtn,False)   ')
			wf_scriptview('//object 数据   ')
			wf_scriptview('ll_object1 = ljs_gen.createjsonobject( )   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object1,"object1")   ')
			wf_scriptview('ljs_gen.additemstring( ll_object2, "Testobject2","Test")   ')
			wf_scriptview('ljs_gen.additemboolean( ll_object2,"booleanvalue",True)   ')
			wf_scriptview('ljs_gen.additemnumber(ll_object2,"number",24.5)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object2, "星期")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"一")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"二")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"三")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"四")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"五")   ')
			wf_scriptview('ljs_gen.additemdate( ll_object1, "日期", 2017-10-17)   ')
			wf_scriptview('ls_rtn = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output( "json string = "+ls_rtn,False)   ')
			wf_scriptview('//array数据   ')
			wf_scriptview('ll_object1 = ljs_gen.createjsonarray( )   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring( ll_object2, "Testobject2","Test")   ')
			wf_scriptview('ljs_gen.additemboolean( ll_object2,"booleanvalue",True)   ')
			wf_scriptview('ljs_gen.additemnumber(ll_object2,"number",24.5)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object2, "星期")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"一")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"二")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"三")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"四")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"五")   ')
			wf_scriptview('ljs_gen.additemdate( ll_object1, 2017-10-17)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"六")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"⑥")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"Ⅵ")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"日")   ')
			wf_scriptview('ls_rtn = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output( "json string = "+ls_rtn,False)   ')
		end if
	case "p036_generatorinout_getjsonblob"
		if ab_execute then
			destroy ljs_gen
			ljs_gen = create jsongenerator
			//空对象保存为blob
			lb_data = ljs_gen.getjsonblob( )
			wf_output( "空变量 To blob = "+string(lb_data),False)
			ljs_gen.createjsonobject( )
			lb_data = ljs_gen.getjsonblob( )
			wf_output("Createjsonobject 后 to string = "+string(lb_data),False)
			ljs_gen.createjsonarray()
			lb_data = ljs_gen.getjsonblob( )
			wf_output("Createjsonarray 后 to string = "+string(lb_data),False)
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
			wf_output( "json blob = "+string(lb_data),False)
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
			wf_output( "json blob = "+string(lb_data),False)
		else
			wf_scriptview('destroy ljs_gen   ')
			wf_scriptview('ljs_gen = create jsongenerator   ')
			wf_scriptview('//空对象保存为blob   ')
			wf_scriptview('lb_data = ljs_gen.getjsonblob( )   ')
			wf_scriptview('wf_output( "空变量 To blob = "+string(lb_data),False)   ')
			wf_scriptview('ljs_gen.createjsonobject( )   ')
			wf_scriptview('lb_data = ljs_gen.getjsonblob( )   ')
			wf_scriptview('wf_output("Createjsonobject 后 to string = "+string(lb_data),False)   ')
			wf_scriptview('ljs_gen.createjsonarray()   ')
			wf_scriptview('lb_data = ljs_gen.getjsonblob( )   ')
			wf_scriptview('wf_output("Createjsonarray 后 to string = "+string(lb_data),False)   ')
			wf_scriptview('//object 数据   ')
			wf_scriptview('ll_object1 = ljs_gen.createjsonobject( )   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object1,"object1")   ')
			wf_scriptview('ljs_gen.additemstring( ll_object2, "Testobject2","Test")   ')
			wf_scriptview('ljs_gen.additemboolean( ll_object2,"booleanvalue",True)   ')
			wf_scriptview('ljs_gen.additemnumber(ll_object2,"number",24.5)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object2, "星期")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"一")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"二")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"三")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"四")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"五")   ')
			wf_scriptview('ljs_gen.additemdate( ll_object1, "日期", 2017-10-17)   ')
			wf_scriptview('lb_data = ljs_gen.getjsonblob( )   ')
			wf_scriptview('wf_output( "json blob = "+string(lb_data),False)   ')
			wf_scriptview('//array数据   ')
			wf_scriptview('ll_object1 = ljs_gen.createjsonarray( )   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring( ll_object2, "Testobject2","Test")   ')
			wf_scriptview('ljs_gen.additemboolean( ll_object2,"booleanvalue",True)   ')
			wf_scriptview('ljs_gen.additemnumber(ll_object2,"number",24.5)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object2, "星期")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"一")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"二")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"三")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"四")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"五")   ')
			wf_scriptview('ljs_gen.additemdate( ll_object1, 2017-10-17)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"六")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"⑥")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"Ⅵ")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"日")   ')
			wf_scriptview('lb_data = ljs_gen.getjsonblob( )   ')
			wf_scriptview('wf_output( "json blob = "+string(lb_data),False)   ')
		end if
	case "p037_generatorinout_savetofile"
		if ab_execute then
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
				wf_output( "savetofile(null) = null",false)
			else
				wf_output( "Failed : savetofile(null) = "+string(ll_rtn),False)
			end if
			//保存为txt(文件不存在时)
			ls_file = "createjson.txt"
			filedelete(ls_file)
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为txt(文件已存在)
			ls_file = "testforsave.txt"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//文件被占用
			ls_file = getcurrentdirectory()+"\testforsave.txt"
			run("notepad "+ls_file)
			ls_file = "testforsave.txt"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			run("taskkill /f /im notepad.exe")
			//无存在的路径
			ls_file = "C:\test234\testforsave.txt"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为docx文件
			ls_file = "createforjson.docx"
			filedelete(ls_file)
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存到已存在的docx
			ls_file = "testforsave.docx"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为pdf
			ls_file = "temp.pdf"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为xml
			ls_file = "temp.xml"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为html
			ls_file = "temp.html"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
			//保存为excel
			ls_file = "temp.xlsx"
			ll_rtn = ljs_gen.savetofile( ls_file)
			wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)
		else
			wf_scriptview('destroy ljs_gen   ')
			wf_scriptview('ljs_gen = create jsongenerator   ')
			wf_scriptview('ll_object1 = ljs_gen.createjsonarray( )   ')
			wf_scriptview('ll_object2 = ljs_gen.additemobject( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring( ll_object2, "Testobject2","Test")   ')
			wf_scriptview('ljs_gen.additemboolean( ll_object2,"booleanvalue",True)   ')
			wf_scriptview('ljs_gen.additemnumber(ll_object2,"number",24.5)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object2, "星期")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"一")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"二")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"三")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"四")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"五")   ')
			wf_scriptview('ljs_gen.additemdate( ll_object1, 2017-10-17)   ')
			wf_scriptview('ll_object2 = ljs_gen.additemarray( ll_object1)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"六")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"⑥")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"Ⅵ")   ')
			wf_scriptview('ljs_gen.additemstring(ll_object2,"日")   ')
			wf_scriptview('//文件为Null   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_null)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "savetofile(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed : savetofile(null) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//保存为txt(文件不存在时)   ')
			wf_scriptview('ls_file = "createjson.txt"   ')
			wf_scriptview('filedelete(ls_file)   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为txt(文件已存在)   ')
			wf_scriptview('ls_file = "testforsave.txt"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//文件被占用   ')
			wf_scriptview('ls_file = getcurrentdirectory()+"\testforsave.txt"   ')
			wf_scriptview('run("notepad "+ls_file)   ')
			wf_scriptview('ls_file = "testforsave.txt"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//无权限的路径   ')
			wf_scriptview('ls_file = "C:\Windows\System32\testforsave.txt"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为docx文件   ')
			wf_scriptview('ls_file = "createforjson.docx"   ')
			wf_scriptview('filedelete(ls_file)   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存到已存在的docx   ')
			wf_scriptview('ls_file = "testforsave.docx"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为pdf   ')
			wf_scriptview('ls_file = "temp.pdf"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为xml   ')
			wf_scriptview('ls_file = "temp.xml"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为html   ')
			wf_scriptview('ls_file = "temp.html"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
			wf_scriptview('//保存为excel   ')
			wf_scriptview('ls_file = "temp.xlsx"   ')
			wf_scriptview('ll_rtn = ljs_gen.savetofile( ls_file)   ')
			wf_scriptview('wf_output( "savetofile("+ls_file+") = "+string(ll_rtn),False)   ')
		end if
	case else
	 	MessageBox("Error",as_item+" Not Coding",Exclamation!)
End Choose

end subroutine

public subroutine wf_scriptexe_additem (string as_item, boolean ab_execute);//jsongenerator 的additem系列函数
jsongenerator ljs_gen
string ls_output,ls_rtn,ls_value
long ll_object,ll_rtn,ll_object2,ll_null,ll_array
string ls_json
setnull(ll_null)
ljs_gen = create jsongenerator
ll_object = ljs_gen.createjsonobject( )
ll_object2 = ljs_gen.additemarray( ll_object, "array")

Choose Case as_item
	Case 'p038_additemstring'
		If ab_execute  Then	
			//null参数
			ll_rtn = ljs_gen.additemstring( ll_null, '','')
			if isnull(ll_rtn) then
				wf_output( "additemstring(null,'','') = null",false)
			else
				wf_output( "Failed: additemstring(null,'','') = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemstring( ll_null, '')
			if isnull(ll_rtn) then
				wf_output( "additemstring(null,'') = null",false)
			else
				wf_output( "additemstring(null,'') = "+string(ll_rtn),False)
			end if
			//句柄为-1
			ll_rtn = ljs_gen.additemstring( -1, 'test','test')
			wf_output( "additemstring(-1,'test','test') = "+string(ll_rtn),False)
			//正常参数
			ll_rtn = ljs_gen.additemstring( ll_object, 'test','test')
			wf_output( "additemstring(obejct,'test','test') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemstring( ll_object2, 'test')
			wf_output( "additemstring(array,'test') = "+string(ll_rtn),False)
			//往数组下插入key，对象下不插入key
			ll_rtn = ljs_gen.additemstring( ll_object2, 'test','test')
			wf_output( "additemstring(arry,'test','test') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemstring( ll_object, 'test')
			wf_output( "additemstring(object,'test') = "+string(ll_rtn),False)
			//key为泰文 วาล์วด้วยมือ
			ll_rtn = ljs_gen.additemstring( ll_object, 'วาล์วด้วยมือ','วาล์วด้วยมือtest')
			wf_output( "additemstring(obejct,'วาล์วด้วยมือ','วาล์วด้วยมือtest') = "+string(ll_rtn),False)
			//同一个key加入两个数据的情况
			ll_rtn = ljs_gen.additemstring( ll_object, 'samekey','test1')
			wf_output( "additemstring(obejct,'samekey','test1') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemstring( ll_object, 'samekey','test2')
			wf_output( "additemstring(obejct,'samekey','test2') = "+string(ll_rtn),False)
			ls_json = ljs_gen.getjsonstring( )
			wf_output("ljs_gen.getjsonstring()="+ls_json,false)
		Else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_null, ~'~',~'~')   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemstring(null,~'~',~'~') = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed: additemstring(null,~'~',~'~') = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_null, ~'~')   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemstring(null,~'~') = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "additemstring(null,~'~') = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//句柄为-1   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( -1, ~'test~',~'test~')   ')
			wf_scriptview('wf_output( "additemstring(-1,~'test~',~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('//正常参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object, ~'test~',~'test~')   ')
			wf_scriptview('wf_output( "additemstring(obejct,~'test~',~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object2, ~'test~')   ')
			wf_scriptview('wf_output( "additemstring(array,~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('//往数组下插入key，对象下不插入key   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object2, ~'test~',~'test~')   ')
			wf_scriptview('wf_output( "additemstring(arry,~'test~',~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object, ~'test~')   ')
			wf_scriptview('wf_output( "additemstring(object,~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('//key为泰文 วาล์วด้วยมือ   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object, ~'วาล์วด้วยมือ~',~'วาล์วด้วยมือtest~')   ')
			wf_scriptview('wf_output( "additemstring(obejct,~'วาล์วด้วยมือ~',~'วาล์วด้วยมือtest~') = "+string(ll_rtn),False)   ')
			wf_scriptview('//同一个key加入两个数据的情况   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object, ~'samekey~',~'test1~')   ')
			wf_scriptview('wf_output( "additemstring(obejct,~'samekey~',~'test1~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemstring( ll_object, ~'samekey~',~'test2~')   ')
			wf_scriptview('wf_output( "additemstring(obejct,~'samekey~',~'test2~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("ljs_gen.getjsonstring()="+ls_json,false)   ')
		End If
	case "p039_additemnumber"
		if ab_execute then
			//additemnumber
			ll_rtn = ljs_gen.additemnumber( ll_null, '',123)
			if isnull(ll_rtn) then
				wf_output( "additemnumber(null,'',123) = null",false)
			else
				wf_output( "additemnumber(null,'',123) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemnumber( ll_null, 123)
			if isnull(ll_rtn) then
				wf_output( "additemnumber(null,123) = null",false)
			else
				wf_output( "additemnumber(null,123) = "+string(ll_rtn),False)
			end if
			//句柄为0
			ll_rtn = ljs_gen.additemnumber( 0, 'test',123)
			wf_output( "additemnumber(0,'test',123) = "+string(ll_rtn),False)
			//数值为0
			ll_rtn = ljs_gen.additemnumber( ll_object, 'test',0)
			wf_output( "additemnumber(object,'test',0) = "+string(ll_rtn),False)
			//value为负数-32768
			ll_rtn = ljs_gen.additemnumber( ll_object, 'test',-32768)
			wf_output( "additemnumber(object,'test',-32768) = "+string(ll_rtn),False)
			//value为科学计数法
			ll_rtn = ljs_gen.additemnumber( ll_object, 'test',1.79e+308)
			wf_output( "additemnumber(object,'test',1.79e+308) = "+string(ll_rtn),False)
			//key为中文
			ll_rtn = ljs_gen.additemnumber( ll_object, '序号',100)
			wf_output( "additemnumber(object,'序号',100) = "+string(ll_rtn),False)
			//正常数据
			ll_rtn = ljs_gen.additemnumber( ll_object, 'test',12.4)
			wf_output( "additemnumber(obejct,'test',12.4) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemnumber( ll_object2, 12)
			wf_output( "additemnumber(array,12) = "+string(ll_rtn),False)
		else
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_null, ~'~',123)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemnumber(null,~'~',123) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "additemnumber(null,~'~',123) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_null, 123)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemnumber(null,123) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "additemnumber(null,123) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//句柄为0   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( 0, ~'test~',123)   ')
			wf_scriptview('wf_output( "additemnumber(0,~'test~',123) = "+string(ll_rtn),False)   ')
			wf_scriptview('//数值为0   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object, ~'test~',0)   ')
			wf_scriptview('wf_output( "additemnumber(object,~'test~',0) = "+string(ll_rtn),False)   ')
			wf_scriptview('//value为负数-32768   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object, ~'test~',-32768)   ')
			wf_scriptview('wf_output( "additemnumber(object,~'test~',-32768) = "+string(ll_rtn),False)   ')
			wf_scriptview('//value为科学计数法   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object, ~'test~',1.79e+308)   ')
			wf_scriptview('wf_output( "additemnumber(object,~'test~',1.79e+308) = "+string(ll_rtn),False)   ')
			wf_scriptview('//key为中文   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object, ~'序号~',100)   ')
			wf_scriptview('wf_output( "additemnumber(object,~'序号~',100) = "+string(ll_rtn),False)   ')
			wf_scriptview('//正常数据   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object, ~'test~',12.4)   ')
			wf_scriptview('wf_output( "additemnumber(obejct,~'test~',12.4) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnumber( ll_object2, 12)   ')
			wf_scriptview('wf_output( "additemnumber(array,12) = "+string(ll_rtn),False)   ')
		end if
	case "p040_additemboolean"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemboolean( ll_null, '',true)
			if isnull(ll_rtn) then
				wf_output( "additemboolean(null,'',true) = null",false)
			else
				wf_output( "Failed : additemboolean(null,'',true) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemboolean( ll_null, true)
			if isnull(ll_rtn) then
				wf_output( "additemboolean(null,true) = null",false)
			else
				wf_output( "failed: additemboolean(null,true) = "+string(ll_rtn),False)
			end if
			//value为表达式
			ll_rtn = ljs_gen.additemboolean( ll_object, 'test',1=1)
			wf_output( "additemboolean(obejct,'test',1=1) = " +string(ll_rtn),False)
			//value为窗体属性
			ll_rtn = ljs_gen.additemboolean( ll_object, 'test',this.visible)
			wf_output( "additemboolean(obejct,'test',this.visible) = " +string(ll_rtn),False)
			//value 为isjsonvalid函数,函数已经不支持
			ll_rtn = ljs_gen.additemboolean( ll_object, 'test',true)
			wf_output( "additemboolean(obejct,'test',ljs_gen.isjsonvalid()) = " +string(ll_rtn),False)
			//正常值
			ll_rtn = ljs_gen.additemboolean( ll_object, 'test',true)
			wf_output( "additemboolean(obejct,'test',true) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemboolean( ll_object2, false)
			wf_output( "additemboolean(array,false) = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_null, ~'~',true)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemboolean(null,~'~',true) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed : additemboolean(null,~'~',true) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_null, true)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemboolean(null,true) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "failed: additemboolean(null,true) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//value为表达式   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_object, ~'test~',1=1)   ')
			wf_scriptview('wf_output( "additemboolean(obejct,~'test~',1=1) = " +string(ll_rtn),False)   ')
			wf_scriptview('//value为窗体属性   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_object, ~'test~',this.visible)   ')
			wf_scriptview('wf_output( "additemboolean(obejct,~'test~',this.visible) = " +string(ll_rtn),False)   ')
			wf_scriptview('//value 为isjsonvalid函数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_object, ~'test~',ljs_gen.isjsonvalid())   ')
			wf_scriptview('wf_output( "additemboolean(obejct,~'test~',ljs_gen.isjsonvalid()) = " +string(ll_rtn),False)   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_object, ~'test~',true)   ')
			wf_scriptview('wf_output( "additemboolean(obejct,~'test~',true) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemboolean( ll_object2, false)   ')
			wf_scriptview('wf_output( "additemboolean(array,false) = "+string(ll_rtn),False)   ')
		end if
	case "p041_additemdate"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemdate( ll_null, '',today())
			if isnull(ll_rtn) then
				wf_output( "additemdate(null,'',today()) = null",false)
			else
				wf_output( "Failed:additemdate(null,'',today()) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemdate( ll_null, today())
			if isnull(ll_rtn) then
				wf_output( "additemdate(null,today()) = null",false)
			else
				wf_output( "Failed: additemdate(null,today()) = "+string(ll_rtn),False)
			end if
			//yyyy-mm-dd
			ll_rtn = ljs_gen.additemdate( ll_object, 'test',2017-09-18)
			wf_output( "additemdate(obejct,'test',2017-09-18) = " +string(ll_rtn),False)
			//yy-mm-dd
			ll_rtn = ljs_gen.additemdate( ll_object, 'test',date('17-09-18'))
			wf_output( "additemdate(obejct,'test',17-09-18) = " +string(ll_rtn),False)
			//mm-dd-yyyy
			ll_rtn = ljs_gen.additemdate( ll_object, 'test',date("09-18-2017"))
			wf_output( "additemdate(obejct,'test',09-18-2017) = " +string(ll_rtn),False)
			//正常值
			ll_rtn = ljs_gen.additemdate( ll_object, 'test',today())
			wf_output( "additemdate(obejct,'test',today()) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemdate( ll_object2, today())
			wf_output( "additemdate(array,today()) = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_null, ~'~',today())   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemdate(null,~'~',today()) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemdate(null,~'~',today()) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_null, today())   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemdate(null,today()) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed: additemdate(null,today()) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//yyyy-mm-dd   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_object, ~'test~',2017-09-18)   ')
			wf_scriptview('wf_output( "additemdate(obejct,~'test~',2017-09-18) = " +string(ll_rtn),False)   ')
			wf_scriptview('//yy-mm-dd   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_object, ~'test~',date(~'17-09-18~'))   ')
			wf_scriptview('wf_output( "additemdate(obejct,~'test~',17-09-18) = " +string(ll_rtn),False)   ')
			wf_scriptview('//mm-dd-yyyy   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_object, ~'test~',date("09-18-2017"))   ')
			wf_scriptview('wf_output( "additemdate(obejct,~'test~',09-18-2017) = " +string(ll_rtn),False)   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_object, ~'test~',today())   ')
			wf_scriptview('wf_output( "additemdate(obejct,~'test~',today()) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdate( ll_object2, today())   ')
			wf_scriptview('wf_output( "additemdate(array,today()) = "+string(ll_rtn),False)   ')
		end if
	case "p042_additemtime"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemtime( ll_null, '',now())
			if isnull(ll_rtn) then
				wf_output( "additemtime(null,'',now()) = null",false)
			else
				wf_output( "additemtime(null,'',now()) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemtime( ll_null, now())
			if isnull(ll_rtn) then
				wf_output( "additemtime(null,now()) = null",false)
			else
				wf_output( "additemtime(null,now()) = "+string(ll_rtn),False)
			end if
			//带毫秒
			ll_rtn = ljs_gen.additemtime( ll_object, 'test',time("12:34:45:454"))
			wf_output( "additemtime(obejct,'test',12:34:45:454) = " +string(ll_rtn),False)
			//key为阿拉伯文วาล์วด้วยมือ
			ll_rtn = ljs_gen.additemtime( ll_object, 'วาล์วด้วยมือ',time("12:34:45:454"))
			wf_output( "additemtime(obejct,'วาล์วด้วยมือ',12:34:45:454) = " +string(ll_rtn),False)
			//正常值
			ll_rtn = ljs_gen.additemtime( ll_object, 'test',now())
			wf_output( "additemtime(obejct,'test',now()) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemtime( ll_object2, now())
			wf_output( "additemtime(array,now()) = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_null, ~'~',now())   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemtime(null,~'~',now()) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "additemtime(null,~'~',now()) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_null, now())   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemtime(null,now()) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "additemtime(null,now()) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//带毫秒   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_object, ~'test~',time("12:34:45:454"))   ')
			wf_scriptview('wf_output( "additemtime(obejct,~'test~',12:34:45:454) = " +string(ll_rtn),False)   ')
			wf_scriptview('//key为阿拉伯文วาล์วด้วยมือ   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_object, ~'วาล์วด้วยมือ~',time("12:34:45:454"))   ')
			wf_scriptview('wf_output( "additemtime(obejct,~'วาล์วด้วยมือ~',12:34:45:454) = " +string(ll_rtn),False)   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_object, ~'test~',now())   ')
			wf_scriptview('wf_output( "additemtime(obejct,~'test~',now()) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemtime( ll_object2, now())   ')
			wf_scriptview('wf_output( "additemtime(array,now()) = "+string(ll_rtn),False)   ')
		end if
	case "p043_additemdatetime"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemdatetime( ll_null, '',datetime(today(),now()))
			if isnull(ll_rtn) then
				wf_output( "additemdatetime(null,'',datetime(today(),now())) = null",false)
			else
				wf_output( "Failed: additemdatetime(null,'',datetime(today(),now())) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemdatetime( ll_null, datetime(today(),now()))
			if isnull(ll_rtn) then
				wf_output( "additemdatetime(null,datetime(today(),now())) = null",false)
			else
				wf_output( "failed:additemdatetime(null,datetime(today(),now())) = "+string(ll_rtn),False)
			end if
			//key为韩文  날짜
			ll_rtn = ljs_gen.additemdatetime( ll_object, '날짜',datetime(today(),now()))
			wf_output( "additemdatetime(object,'날짜',datetime(today(),now())) = "+string(ll_rtn),False)
			//正常值
			ll_rtn = ljs_gen.additemdatetime( ll_object, 'test',datetime(today(),now()))
			wf_output( "additemdatetime(object,'test',datetime(today(),now())) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemdatetime( ll_object2, datetime(today(),now()))
			wf_output( "additemdatetime(array,datetime(today(),now())) = "+string(ll_rtn),False)
			//object下数据输出为字符串/时间戳
			ll_rtn = ljs_gen.additemdatetime( ll_object,"StringTime", datetime("2017-11-17 12:40:40"),false)
			wf_output( "additemdatetime(object,'StringTime',datetime(~"2017-11-17 12:40:40~"),false) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemdatetime( ll_object,"StringTime", datetime("2017-11-17 12:40:40"),true)
			wf_output( "additemdatetime(object,'StringTime',datetime(~"2017-11-17 12:40:40~"),true) = "+string(ll_rtn),False)
			//array下数据输出为时间戳
			ll_array = ljs_gen.additemarray( ll_object, "Array-Time")
			ll_rtn = ljs_gen.additemdatetime(ll_array, datetime("2017-11-17 12:40:40"),false)
			wf_output( "additemdatetime(array,datetime(~"2017-11-17 12:40:40~"),false) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemdatetime(ll_array, datetime("2017-11-17 12:40:40"),true)
			wf_output( "additemdatetime(array,datetime(~"2017-11-17 12:40:40~"),true) = "+string(ll_rtn),False)
			ls_json = ljs_gen.getjsonstring( )
			wf_output("ljs_gen.getjsonstring( ) = "+ls_json,false)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_null, ~'~',datetime(today(),now()))   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemdatetime(null,~'~',datetime(today(),now())) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemdatetime(null,~'~',datetime(today(),now())) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_null, datetime(today(),now()))   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemdatetime(null,datetime(today(),now())) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemdatetime(null,datetime(today(),now())) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//key为韩文  날짜   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_object, ~'날짜~',datetime(today(),now()))   ')
			wf_scriptview('wf_output( "additemdatetime(obejct,~'날짜~',datetime(today(),now())) = "+string(ll_rtn),False)   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_object, ~'test~',datetime(today(),now()))   ')
			wf_scriptview('wf_output( "additemdatetime(object,~'test~',datetime(today(),now())) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_object2, datetime(today(),now()))   ')
			wf_scriptview('wf_output( "additemdatetime(array,datetime(today(),now())) = "+string(ll_rtn),False)   ')
			wf_scriptview('//object下数据输出为字符串/时间戳   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_object,"StringTime", datetime("2017-11-17 12:40:40"),false)   ')
			wf_scriptview('wf_output( "additemdatetime(object,~'StringTime~',datetime(~"2017-11-17 12:40:40~"),false) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime( ll_object,"StringTime", datetime("2017-11-17 12:40:40"),true)   ')
			wf_scriptview('wf_output( "additemdatetime(object,~'StringTime~',datetime(~"2017-11-17 12:40:40~"),true) = "+string(ll_rtn),False)   ')
			wf_scriptview('//array下数据输出为时间戳   ')
			wf_scriptview('ll_array = ljs_gen.additemarray( ll_object, "Array-Time")   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime(ll_array, datetime("2017-11-17 12:40:40"),false)   ')
			wf_scriptview('wf_output( "additemdatetime(array,datetime(~"2017-11-17 12:40:40~"),false) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemdatetime(ll_array, datetime("2017-11-17 12:40:40"),true)   ')
			wf_scriptview('wf_output( "additemdatetime(array,datetime(~"2017-11-17 12:40:40~"),true) = "+string(ll_rtn),False)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output("ljs_gen.getjsonstring( ) = "+ls_json,false)   ')
		end if
	case "p044_additemblob"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemblob( ll_null, '',blob(''))
			if isnull(ll_rtn) then
				wf_output( "additemblob(null,'',blob('')) = null",false)
			else
				wf_output( "Failed:additemblob(null,'',blob('')) = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemblob( ll_null, blob(''))
			if isnull(ll_rtn) then
				wf_output( "additemblob(null,blob('')) = null",false)
			else
				wf_output( "Failed:additemblob(null,blob('')) = "+string(ll_rtn),False)
			end if
			//正常值
			ll_rtn = ljs_gen.additemblob( ll_object, 'test',blob('测试使用DE'))
			wf_output( "additemblob(obejct,'test',blob('测试使用DE')) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemblob( ll_object2, blob('测试使用DE'))
			wf_output( "additemblob(array,blob('测试使用DE')) = "+string(ll_rtn),False)
			//key为西班牙文borrón
			ll_rtn = ljs_gen.additemblob( ll_object, 'borrón',blob('测试使用borrón'))
			wf_output( "additemblob(obejct,'borrón',blob('测试使用borrón')) = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemblob( ll_object2, blob('测试使用borrónDE'))
			wf_output( "additemblob(array,blob('测试使用DE')) = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_null, ~'~',blob(~'~'))   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemblob(null,~'~',blob(~'~')) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemblob(null,~'~',blob(~'~')) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_null, blob(~'~'))   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemblob(null,blob(~'~')) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemblob(null,blob(~'~')) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_object, ~'test~',blob(~'测试使用DE~'))   ')
			wf_scriptview('wf_output( "additemblob(obejct,~'test~',blob(~'测试使用DE~')) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_object2, blob(~'测试使用DE~'))   ')
			wf_scriptview('wf_output( "additemblob(array,blob(~'测试使用DE~')) = "+string(ll_rtn),False)   ')
			wf_scriptview('//key为西班牙文borrón   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_object, ~'borrón~',blob(~'测试使用borrón~'))   ')
			wf_scriptview('wf_output( "additemblob(obejct,~'borrón~',blob(~'测试使用borrón~')) = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemblob( ll_object2, blob(~'测试使用borrónDE~'))   ')
			wf_scriptview('wf_output( "additemblob(array,blob(~'测试使用DE~')) = "+string(ll_rtn),False)   ')
		end if
	case "p045_additemnull"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemnull( ll_null, '')
			if isnull(ll_rtn) then
				wf_output( "additemnull(null,'') = null",false)
			else
				wf_output( "Failed:additemnull(null,'') = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemnull( ll_null)
			if isnull(ll_rtn) then
				wf_output( "additemnull(null) = null",false)
			else
				wf_output( "Failed:additemnull(null) = "+string(ll_rtn),False)
			end if
			//正常值
			ll_rtn = ljs_gen.additemnull( ll_object, 'test')
			wf_output( "additemnull(obejct,'test') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemnull( ll_object2)
			wf_output( "additemnull(array) = "+string(ll_rtn),False)
			//key为日文 フルネーム
			ll_rtn = ljs_gen.additemnull( ll_object, 'フルネーム')
			wf_output( "additemnull(obejct,'フルネーム') = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnull( ll_null, ~'~')   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemnull(null,~'~') = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemnull(null,~'~') = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnull( ll_null)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemnull(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemnull(null) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常值   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnull( ll_object, ~'test~')   ')
			wf_scriptview('wf_output( "additemnull(obejct,~'test~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnull( ll_object2)   ')
			wf_scriptview('wf_output( "additemnull(array) = "+string(ll_rtn),False)   ')
			wf_scriptview('//key为日文 フルネーム   ')
			wf_scriptview('ll_rtn = ljs_gen.additemnull( ll_object, ~'フルネーム~')   ')
			wf_scriptview('wf_output( "additemnull(obejct,~'フルネーム~') = "+string(ll_rtn),False)   ')
		end if
	case "p046_additemobject"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemobject( ll_null, '')
			if isnull(ll_rtn) then
				wf_output( "additemobject(null,'') = null",false)
			else
				wf_output( "Failed:additemobject(null,'') = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemobject( ll_null)
			if isnull(ll_rtn) then
				wf_output( "additemobject(null) = null",false)
			else
				wf_output( "failed:additemobject(null) = "+string(ll_rtn),False)
			end if
			//正常数据
			ll_rtn = ljs_gen.additemobject( ll_object, 'test测试')
			wf_output( "additemnull(obejct,'test测试') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemobject( ll_object2)
			wf_output( "additemnull(array) = "+string(ll_rtn),False)
			//key为俄文 Россия
			ll_rtn = ljs_gen.additemobject( ll_object, 'Россия测试')
			wf_output( "additemnull(obejct,'Россия测试') = "+string(ll_rtn),False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemobject( ll_null, ~'~')   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemobject(null,~'~') = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "Failed:additemobject(null,~'~') = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemobject( ll_null)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemobject(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "failed:additemobject(null) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常数据   ')
			wf_scriptview('ll_rtn = ljs_gen.additemobject( ll_object, ~'test测试~')   ')
			wf_scriptview('wf_output( "additemnull(obejct,~'test测试~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemobject( ll_object2)   ')
			wf_scriptview('wf_output( "additemnull(array) = "+string(ll_rtn),False)   ')
			wf_scriptview('//key为俄文 Россия   ')
			wf_scriptview('ll_rtn = ljs_gen.additemobject( ll_object, ~'Россия测试~')   ')
			wf_scriptview('wf_output( "additemnull(obejct,~'Россия测试~') = "+string(ll_rtn),False)   ')
		end if
	case "p047_additemarray"
		if ab_execute then
			//null参数
			ll_rtn = ljs_gen.additemarray( ll_null, '')
			if isnull(ll_rtn) then
				wf_output( "additemarray(null,'') = null",false)
			else
				wf_output( "failed:additemarray(null,'') = "+string(ll_rtn),False)
			end if
			ll_rtn = ljs_gen.additemarray( ll_null)
			if isnull(ll_rtn) then
				wf_output( "additemarray(null) = null",false)
			else
				wf_output( "failed:additemarray(null) = "+string(ll_rtn),False)
			end if
			//正常数据
			ll_rtn = ljs_gen.additemarray( ll_object, 'test测试')
			wf_output( "additemarray(obejct,'test测试') = "+string(ll_rtn),False)
			ll_rtn = ljs_gen.additemarray( ll_object2)
			wf_output( "additemarray(array) = "+string(ll_rtn),False)
			ls_json = ljs_gen.getjsonstring( )
			wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)
		else
			wf_scriptview('//null参数   ')
			wf_scriptview('ll_rtn = ljs_gen.additemarray( ll_null, ~'~')   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemarray(null,~'~') = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "failed:additemarray(null,~'~') = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('ll_rtn = ljs_gen.additemarray( ll_null)   ')
			wf_scriptview('if isnull(ll_rtn) then   ')
			wf_scriptview('	wf_output( "additemarray(null) = null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "failed:additemarray(null) = "+string(ll_rtn),False)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常数据   ')
			wf_scriptview('ll_rtn = ljs_gen.additemarray( ll_object, ~'test测试~')   ')
			wf_scriptview('wf_output( "additemarray(obejct,~'test测试~') = "+string(ll_rtn),False)   ')
			wf_scriptview('ll_rtn = ljs_gen.additemarray( ll_object2)   ')
			wf_scriptview('wf_output( "additemarray(array) = "+string(ll_rtn),False)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)   ')
		end if
	case "p048_additem_isjsonvalid"
		if ab_execute then
			wf_output("isjsonvalid 函数取消",false)
//			destroy ljs_gen
//			ljs_gen = create jsongenerator
//			ls_rtn = string(ljs_gen.isjsonvalid( ))
//			wf_output( "空jsongeneraotr isjsonvalid() = "+ls_rtn,False)
//			ll_object = ljs_gen.createjsonobject( )
//			ls_rtn = string(ljs_gen.isjsonvalid( ))
//			wf_output( "createjsonobject后 isjsonvalid() = "+ls_rtn,False)
//			ls_json = ljs_gen.getjsonstring( )
//			wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)
//			ljs_gen.additemstring(ll_object,'test')
//			ls_rtn = string(ljs_gen.isjsonvalid( ))
//			wf_output( "错误数据 isjsonvalid() = "+ls_rtn,False)
//			ls_json = ljs_gen.getjsonstring( )
//			wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)
//			ljs_gen.additemstring(ll_object,'test',"testdata")
//			ls_rtn = string(ljs_gen.isjsonvalid( ))
//			wf_output( "正确数据后数据 isjsonvalid() = "+ls_rtn,False)
//			ls_json = ljs_gen.getjsonstring( )
//			wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)
		else
			wf_scriptview('destroy ljs_gen   ')
			wf_scriptview('ljs_gen = create jsongenerator   ')
			wf_scriptview('ls_rtn = string(ljs_gen.isjsonvalid( ))   ')
			wf_scriptview('wf_output( "空jsongeneraotr isjsonvalid() = "+ls_rtn,False)   ')
			wf_scriptview('ll_object = ljs_gen.createjsonobject( )   ')
			wf_scriptview('ls_rtn = string(ljs_gen.isjsonvalid( ))   ')
			wf_scriptview('wf_output( "createjsonobject后 isjsonvalid() = "+ls_rtn,False)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object,~'test~')   ')
			wf_scriptview('ls_rtn = string(ljs_gen.isjsonvalid( ))   ')
			wf_scriptview('wf_output( "错误数据 isjsonvalid() = "+ls_rtn,False)   ')
			wf_scriptview('ljs_gen.additemstring(ll_object,~'test~',"testdata")   ')
			wf_scriptview('ls_rtn = string(ljs_gen.isjsonvalid( ))   ')
			wf_scriptview('wf_output( "正确数据后数据 isjsonvalid() = "+ls_rtn,False)   ')
			wf_scriptview('ls_json = ljs_gen.getjsonstring( )   ')
			wf_scriptview('wf_output( "ljs_gen.getjsonstring() = "+ls_json,False)   ')
		end if
	case else
			MessageBox("Error",as_item+" Not Coding",Exclamation!)
	End Choose

end subroutine

public subroutine wf_script_load (string as_item, boolean ab_execute);//测试jsongenerator的输入输出操作
string ls_json,ls_null,ls_space,ls_rtn,ls_output
string ls_file,ls_path
setnull(ls_null)
Choose Case as_item
	Case 'p049_loadstring'
		If ab_execute  Then		
			ls_rtn = ieon_parser.loadstring( ls_null)
			if isnull(ls_null) then
				wf_output("loadstring(null) = Null",false)
			else
				wf_output("Failed:loadstring(null) <> Null",false)
			end if
			//未赋值数据
			ls_rtn = ieon_parser.loadstring( ls_space)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//space(1000)
			ls_rtn = ieon_parser.loadstring( space(1000))
			wf_output( "loadstring(space(1000)) = "+ls_rtn,false)
			//"json value包含特殊字符"
			ls_json = '{"id":45,"name":"lisan~r~nter@#$-`*&"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//json value包含char(10)
			ls_json = '{"id":45,"name":"lisan'+char(10)+char(13)+'"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//json value包含多字节
			ls_json = '{"id":45,"name":"李三③Ⅲ😭"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//key包含特殊字符
			ls_json = '{"~r~nid":45,"name":"lisan"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//value包含tab
			ls_json = '{"id":45,"name":"li~tsan"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//json key包含多字节
			ls_json = '{"功能《id":45,"ÄÖÜß|name":"李三"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//key 为纯数字
			ls_json = '{"123":45,"name":"lisan"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//数值已0开头
			ls_json = '{"编号":045,"name":"lisan"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = "" then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//数值为16进制数据0XAF
			ls_json = '{"编号":0xAF,"name":"lisan"}'
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = "" then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//正常加载数据
			ls_json =mle_1.text
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//添加测试点,字符串为纯数字
			ls_json = "1242354"
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//字符串为tab
			ls_json = "~t"
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//字符串为字母
			ls_json = "test"
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
			//字符串为双引号字母
			ls_json = "~"test~""
			ls_rtn = ieon_parser.loadstring(ls_json)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)
			else
				wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)
			end if
		Else
			wf_scriptview('ls_rtn = ieon_parser.loadstring( ls_null)   ')
			wf_scriptview('if isnull(ls_null) then   ')
			wf_scriptview('	wf_output("loadstring(null) = Null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("Failed:loadstring(null) <> Null",false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//未赋值数据   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring( ls_space)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//space(1000)   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring( space(1000))   ')
			wf_scriptview('wf_output( "loadstring(space(1000)) = "+ls_rtn,false)   ')
			wf_scriptview('//"json value包含特殊字符"   ')
			wf_scriptview('ls_json = ~'{"id":45,"name":"lisan~r~nter@#$-`*&"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//json value包含char(10)   ')
			wf_scriptview('ls_json = ~'{"id":45,"name":"lisan~'+char(10)+char(13)+~'"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//value包含tab   ')
			wf_scriptview('ls_json = ~'{"id":45,"name":"li~tsan"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//json value包含多字节   ')
			wf_scriptview('ls_json = ~'{"id":45,"name":"李三③Ⅲ😭"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//key包含特殊字符   ')
			wf_scriptview('ls_json = ~'{"~r~nid":45,"name":"lisan"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//json key包含多字节   ')
			wf_scriptview('ls_json = ~'{"功能《id":45,"ÄÖÜß|name":"李三"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//key 为纯数字   ')
			wf_scriptview('ls_json = ~'{"123":45,"name":"lisan"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//数值已0开头   ')
			wf_scriptview('ls_json = ~'{"编号":045,"name":"lisan"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = "" then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//数值为16进制数据0XAF   ')
			wf_scriptview('ls_json = ~'{"编号":0xAF,"name":"lisan"}~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = "" then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//正常加载数据   ')
			wf_scriptview('ls_json =mle_1.text   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//添加测试点,字符串为纯数字   ')
			wf_scriptview('ls_json = "1242354"   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//字符串为tab   ')
			wf_scriptview('ls_json = "~t"   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//字符串为字母   ')
			wf_scriptview('ls_json = "test"   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//字符串为双引号字母   ')
			wf_scriptview('ls_json = "~"test~""   ')
			wf_scriptview('ls_rtn = ieon_parser.loadstring(ls_json)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+string(" Succeed"),false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_json+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
		End If
	case "p050_loadfile"
		if ab_execute then
			setnull(ls_null)
			ls_rtn = ieon_parser.loadfile( ls_null)
			if isnull(ls_rtn) then
				wf_output("loadfile(null) = Null",false)
			else
				wf_output("loadfile(null) <> Null",false)
			end if
			//未赋值数据
			ls_rtn = ieon_parser.loadfile( ls_space)
			wf_output( "loadfile(~"~") = "+ls_rtn,false)
			//pbl 文件加载
			ls_file = 'json_autotest.pbl'
			ls_rtn = ieon_parser.loadfile(ls_file)
			wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)
			//docx文件加载
			ls_file = 'json.docx'
			ls_rtn = ieon_parser.loadfile(ls_file)
			wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)
			//txt文件加载
			ls_file = 'json.txt'
			ls_rtn = ieon_parser.loadfile(ls_file)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_file+") Succeed",false)
			else
				wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)
			end if
			//使用绝对路径
			//"D:\APB-File\PB NewFeature\Json_test"
			ls_path = getcurrentdirectory()
			ls_file =ls_path+'\json.txt'
			ls_rtn = ieon_parser.loadfile(ls_file)
			if ls_rtn = '' then
				wf_output( "loadstring("+ls_file+") Succeed",false)
			else
				wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)
			end if
		else
			wf_scriptview('setnull(ls_null)   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile( ls_null)   ')
			wf_scriptview('if isnull(ls_rtn) then   ')
			wf_scriptview('	wf_output("loadfile(null) = Null",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output("loadfile(null) <> Null",false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//未赋值数据   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile( ls_space)   ')
			wf_scriptview('wf_output( "loadfile(~"~") = "+ls_rtn,false)   ')
			wf_scriptview('//pbl 文件加载   ')
			wf_scriptview('ls_file = ~'json_autotest.pbl~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile(ls_file)   ')
			wf_scriptview('wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)   ')
			wf_scriptview('//docx文件加载   ')
			wf_scriptview('ls_file = ~'json.docx~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile(ls_file)   ')
			wf_scriptview('wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)   ')
			wf_scriptview('//txt文件加载   ')
			wf_scriptview('ls_file = ~'json.txt~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile(ls_file)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_file+") Succeed",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
			wf_scriptview('//使用绝对路径   ')
			wf_scriptview('//"D:\APB-File\PB NewFeature\Json_test"   ')
			wf_scriptview('ls_path = getcurrentdirectory()   ')
			wf_scriptview('ls_file =ls_path+~'\json.txt~'   ')
			wf_scriptview('ls_rtn = ieon_parser.loadfile(ls_file)   ')
			wf_scriptview('if ls_rtn = ~'~' then   ')
			wf_scriptview('	wf_output( "loadstring("+ls_file+") Succeed",false)   ')
			wf_scriptview('else   ')
			wf_scriptview('	wf_output( "loadstring("+ls_file+") = "+ls_rtn,false)   ')
			wf_scriptview('end if   ')
		end if
	case else
	 	MessageBox("Error",as_item+" Not Coding",Exclamation!)
End Choose

end subroutine

public function any wf_return_any ();jsongenerator ljs_gen
long ll_object
ljs_gen = create jsongenerator
ll_object = ljs_gen.createjsonarray( )
ljs_gen.additemnumber( ll_object, 1)
ljs_gen.additemnumber( ll_object,2)
ljs_gen.additemnumber( ll_object, 3)
ljs_gen.additemnumber( ll_object,4)
ljs_gen.additemnumber( ll_object, 5)

return ljs_gen
end function

on w_json_auto.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.uo_1=create uo_1
this.gb_5=create gb_5
this.jsongenerator_1=create jsongenerator_1
this.jsonparser_1=create jsonparser_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.gb_5
end on

on w_json_auto.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.uo_1)
destroy(this.gb_5)
destroy(this.jsongenerator_1)
destroy(this.jsonparser_1)
end on

event open;call super::open;ieon_parser = create jsonparser
ieon_gen = create jsongenerator

mle_1.text =  ' &
{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
}'

end event

type mle_output from w_appeon_base`mle_output within w_json_auto
integer y = 2312
integer height = 400
end type

event mle_output::getfocus;call super::getfocus;//ix_or = this.x
//iy_or = this.y
//iw_or = this.width
//ih_or = this.height
//
//this.move(lb_1.x,lb_1.y)
//this.resize( lb_1.width,lb_1.height)
//this.bringtotop = true
end event

event mle_output::losefocus;call super::losefocus;
//this.move(ix_or,iy_or)
//this.resize( iw_or,ih_or)
//this.bringtotop = true
end event

type cb_5 from w_appeon_base`cb_5 within w_json_auto
end type

type cb_4 from w_appeon_base`cb_4 within w_json_auto
end type

type cb_3 from w_appeon_base`cb_3 within w_json_auto
end type

type mle_view from w_appeon_base`mle_view within w_json_auto
integer y = 776
integer height = 1444
end type

type mle_dec from w_appeon_base`mle_dec within w_json_auto
integer height = 548
end type

type cb_2 from w_appeon_base`cb_2 within w_json_auto
end type

type cb_1 from w_appeon_base`cb_1 within w_json_auto
end type

type lb_1 from w_appeon_base`lb_1 within w_json_auto
integer y = 752
integer height = 1472
end type

type gb_1 from w_appeon_base`gb_1 within w_json_auto
integer height = 672
end type

type gb_2 from w_appeon_base`gb_2 within w_json_auto
integer y = 672
integer height = 1580
end type

type gb_3 from w_appeon_base`gb_3 within w_json_auto
integer y = 696
end type

type gb_4 from w_appeon_base`gb_4 within w_json_auto
integer y = 2240
integer height = 492
end type

type mle_1 from multilineedit within w_json_auto
integer x = 1659
integer y = 68
integer width = 1847
integer height = 568
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_json_per within w_json_auto
boolean visible = false
integer x = 1609
integer y = 36
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_json_per::destroy
end on

type gb_5 from groupbox within w_json_auto
integer x = 1641
integer width = 1883
integer height = 676
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Json String"
end type

type jsongenerator_1 from jsongenerator within w_json_auto descriptor "pb_nvo" = "true" 
end type

on jsongenerator_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on jsongenerator_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

type jsonparser_1 from jsonparser within w_json_auto descriptor "pb_nvo" = "true" 
end type

on jsonparser_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on jsonparser_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

