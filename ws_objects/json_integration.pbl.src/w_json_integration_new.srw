$PBExportHeader$w_json_integration_new.srw
forward
global type w_json_integration_new from w_manu_base
end type
type cbx_1 from checkbox within w_json_integration_new
end type
type tv_1 from treeview within w_json_integration_new
end type
type cb_4 from commandbutton within w_json_integration_new
end type
type sle_1 from singlelineedit within w_json_integration_new
end type
type cbx_2 from checkbox within w_json_integration_new
end type
type p_1 from picture within w_json_integration_new
end type
type dw_1 from datawindow within w_json_integration_new
end type
type st_1 from statictext within w_json_integration_new
end type
type em_1 from editmask within w_json_integration_new
end type
type cb_5 from commandbutton within w_json_integration_new
end type
type cbx_3 from checkbox within w_json_integration_new
end type
type st_2 from statictext within w_json_integration_new
end type
type st_3 from statictext within w_json_integration_new
end type
type sle_2 from singlelineedit within w_json_integration_new
end type
type st_4 from statictext within w_json_integration_new
end type
type mle_jsonarray from multilineedit within w_json_integration_new
end type
type em_2 from editmask within w_json_integration_new
end type
type dw_2 from datawindow within w_json_integration_new
end type
type dw_3 from datawindow within w_json_integration_new
end type
end forward

global type w_json_integration_new from w_manu_base
string title = "Json_integration"
cbx_1 cbx_1
tv_1 tv_1
cb_4 cb_4
sle_1 sle_1
cbx_2 cbx_2
p_1 p_1
dw_1 dw_1
st_1 st_1
em_1 em_1
cb_5 cb_5
cbx_3 cbx_3
st_2 st_2
st_3 st_3
sle_2 sle_2
st_4 st_4
mle_jsonarray mle_jsonarray
em_2 em_2
dw_2 dw_2
dw_3 dw_3
end type
global w_json_integration_new w_json_integration_new

type variables

//json对象
jsonparser ijs_par
jsongenerator ijs_gen




//各参数
//loadstring 参数
string is_json
end variables

forward prototypes
public subroutine wf_init ()
public subroutine wf_scriptexe (integer ai_item)
public subroutine wf_loadfile ()
public function integer wf_parsertostring (long al_parent, boolean ab_array, string as_key, jsongenerator ajs_gen, long al_genparent)
public function integer wf_treetojson_new (long al_handle, long al_jsonparent, long al_jsonchild)
public function integer wf_keyvalue (string as_value, ref string as_keyvalue[])
public function integer wf_genstring (long al_parent, boolean ab_array, string as_key, long al_genparent)
public subroutine wf_loadpicture ()
public function integer wf_parser_json (long al_parent, boolean ai_array, long al_treeparent, string as_key)
public function integer wf_generatetree ()
public subroutine wf_treetojson ()
public subroutine wf_dwtojson ()
public subroutine wf_jsontodw ()
public subroutine wf_jsonarray ()
public function integer wf_jsontodw_bigdata ()
end prototypes

public subroutine wf_init ();//用来初始化信息

//初始化函数列表,多个函数通过逗号分割
is_funlist = "loadstring,loadfile,generatestring,savetofile,loadpicture,generatetree,treetojson,dwtojson,jsontodw,jsontodw_bigdata,jsonarray,exception"
wf_additem(is_funlist,lb_fun)


//初始化新加对象的resize逻辑
ieon_resize.of_setflag(cbx_1,"0000")
ieon_resize.of_setflag(cbx_2,"0000")
ieon_resize.of_setflag(cbx_3,"0000")
ieon_resize.of_setflag(p_1,"0000")

ieon_resize.of_setflag(tv_1,"0022")
ieon_resize.of_setflag(sle_1,"0200")
ieon_resize.of_setflag(cb_4,"0200")

ieon_resize.of_setflag(st_1,"0000")
ieon_resize.of_setflag(cb_5,"0000")
ieon_resize.of_setflag(em_1,"0000")
ieon_resize.of_setflag(st_2,"0020")

ieon_resize.of_setflag(dw_1,"0022")
ieon_resize.of_setflag(dw_2,"0022")
ieon_resize.of_setflag(dw_3,"0022")
ieon_resize.of_setflag(st_3,"0000")
ieon_resize.of_setflag(sle_2,"0000")
ieon_resize.of_setflag(em_2,"0000")
ieon_resize.of_setflag(st_4,"0020")
ieon_resize.of_setflag(mle_jsonarray,"0022")
end subroutine

public subroutine wf_scriptexe (integer ai_item);// 执行测试点，需要在子窗体重写
string ls_item,ls_value,ls_output,ls_rtn
string ls_json,ls_path,ls_file
//long ll_root,ll_count,ll_handle,ll_rtn,ll_start
longptr ll_root,ll_count,ll_handle,ll_rtn,ll_start
jsonitemtype ljs_type
jsonparser ljs_par
if ai_item <= 0 then return

if gb_glob then
	//使用全局变量
	ljs_par = gjs_par
else
	ljs_par = create jsonparser
end if
ls_item = lb_fun.text(ai_item)
wf_output("Begin "+ls_item,true)
choose case ls_item
	case "loadstring"
		ls_rtn  = ljs_par.loadstring(is_json )
		if len(trim(ls_rtn)) = 0 then
			wf_output("ljs_par.loadstring("+is_json+") succeed!",false)
		else
			wf_output("ljs_par.loadstring("+is_json+") Failed:"+ls_rtn,false)
		end if
	case "loadfile"
		wf_loadfile()
	case "generatestring"
		ll_root = gjs_par.getrootitem( )
		ll_count = gjs_par.getchildcount( ll_root)
		if ll_count <= 0 then
			messagebox("Error","JsonParser对象，未包含有效的json")
			return
		end if
		ljs_type = gjs_par.getitemtype( ll_root)
		if ljs_type = jsonobjectitem! then
			ll_handle = gjs_gen.createjsonobject()
			//wf_parsertostring(ll_root,false,'',gjs_gen,ll_handle)
			wf_genstring(ll_root,false,'',ll_handle)
		elseif  ljs_type = jsonarrayitem! then
			ll_handle = gjs_gen.createjsonarray()
			//wf_parsertostring(ll_root,true,'',gjs_gen,ll_handle)
			wf_genstring(ll_root,true,'',ll_handle)
		end if
		ls_json = gjs_gen.getjsonstring( )
		mle_parm.text = ls_json
		wf_output("generate string is ~r~n"+ls_json,false)
	case "savetofile"
//		if gjs_gen.isjsonvalid( ) then
//	
//		else
//			messagebox("Error","jsongenerator is not a valid json string")
//			return
//		end if
		ll_rtn = getfilesavename("Save Jsonstring to file",ls_path,ls_file,"*.*","All File(*.*),*.*")
		if ll_rtn > 0 then
			ls_output = string(gjs_gen.savetofile( ls_path))
			wf_output("Return from Savetofile("+ls_path+") = "+ls_output,false)
		end if
	case "loadpicture"
		wf_loadpicture()
	case "generatetree"
		//将json输出到树结构
		wf_generatetree()
	case "treetojson"
		//将修改后的数据重新生成json字符串
		wf_treetojson()
	case "dwtojson"
		//将datawindow转化为json
		wf_dwtojson()
	case "jsontodw"
		//将json转化为datawindow
		wf_jsontodw()
	case "jsontodw_bigdata"
		ll_start = cpu()
		wf_jsontodw_bigdata()
		wf_output("耗时："+string(cpu() - ll_start)+"MS",false)
	case "jsonarray"
		wf_jsonarray()
	case "exception"
		ljs_par.loadstring( mle_parm.text)
		ll_root = ljs_par.getrootitem()
		ljs_par.getitemstring( ll_root,"test")
	case else
		messagebox("Info","测试点"+ls_item+"没有维护代码")
end choose
end subroutine

public subroutine wf_loadfile ();string ls_file,ls_rtn,ls_path,ls_json
long ll_return,ll_handle,ll_root,ll_file
jsonitemtype ljs_type
jsonparser ljs_par
jsongenerator ljs_gen
if gb_glob then
	ljs_par = gjs_par
	ljs_gen = gjs_gen
else
	ljs_par = create jsonparser
	ljs_gen = create jsongenerator
end if

ll_return = getfileopenname("Select Json File",ls_path,ls_file,"*.*","All File(*.*),*.*")


if ll_return > 0 then
	if not cbx_1.checked then
		ls_rtn = ljs_par.loadfile(ls_file)
		if ls_rtn = '' then
			ijs_par = ljs_par
			wf_output( "LoadFile("+ls_file+") Succeed",false)
		else
			wf_output("LoadFile("+ls_file+") Failed:"+ls_rtn,false)
		end if
	else
		//unicode 的json文件，以字符串方式读取
		ll_file = fileopen(ls_path,streammode!,read!,shared!)
		fileread(ll_file,ls_json)
		ls_rtn = ljs_par.loadstring(ls_json)
		if ls_rtn = '' then
			wf_output("Loadstring("+ls_json+") Succeed",false)
		else
			wf_output("LoadString("+ls_json+") Failed:"+ls_rtn,false)
		end if
		fileclose(ll_file)
	end if
	ll_root = ljs_par.getrootitem( )
	ljs_type = ljs_par.getitemtype( ll_root)
	
	if ljs_type = jsonobjectitem! then
		ll_handle = ljs_gen.createjsonobject()
		wf_parsertostring(ll_root,false,'',ljs_gen,ll_handle)
		//wf_genstring(ll_root,false,'',ll_handle)
	elseif  ljs_type = jsonarrayitem! then
		ll_handle = ljs_gen.createjsonarray()
		wf_parsertostring(ll_root,true,'',ljs_gen,ll_handle)
		//wf_genstring(ll_root,true,'',ll_handle)
	end if
	ls_json = ljs_gen.getjsonstring( )
	mle_parm.text =ls_json
end if
//这个写法会导致崩溃，不再赋值
//if not gb_glob then
//	gjs_par = ljs_par
//	gjs_gen = ljs_gen
//end if
end subroutine

public function integer wf_parsertostring (long al_parent, boolean ab_array, string as_key, jsongenerator ajs_gen, long al_genparent);//
long ll_object,ll_child,ll_count,ll_loop
//longptr ll_object,ll_child,ll_count,ll_loop
boolean lb_value
double ld_value
string ls_key,ls_value
jsonitemtype ljs_type

ll_count = ijs_par.getchildcount( al_parent)
if ll_count <= 0 then
	return 1
end if
if ab_array  then  //父对象是数组
//插入数组对象
	for ll_loop = 1 to ll_count
		ll_child = ijs_par.getchilditem( al_parent, ll_loop)
		ljs_type = ijs_par.getitemtype(ll_child)
		choose case ljs_type
			case jsonstringitem!
				ls_value = ijs_par.getitemstring(ll_child)
				ajs_gen.additemstring(al_genparent,ls_value)
			case jsonbooleanitem!
				lb_value = ijs_par.getitemboolean(ll_child)
				ajs_gen.additemboolean(al_genparent,lb_value)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ld_value = ijs_par.getitemnumber(ll_child)
				ajs_gen.additemnumber(al_genparent,ld_value)
			case jsonnullitem!
				ls_value = "null"
				ajs_gen.additemnull(al_genparent)
			case jsonobjectitem!
				ll_object = ajs_gen.additemobject(al_genparent)
				wf_parsertostring(ll_child,false,'',ajs_gen,ll_object)
			case jsonarrayitem!
				ll_object = ajs_gen.additemarray(al_genparent)
				wf_parsertostring(ll_child,true,'',ajs_gen,ll_object)
		end choose
	next
else    //父对象是object
	for ll_loop = 1 to ll_count
		ll_child = ijs_par.getchilditem( al_parent, ll_loop)
		ljs_type = ijs_par.getitemtype(ll_child)
		ls_key = ijs_par.getchildkey( al_parent,ll_loop)
		choose case ljs_type
			case jsonstringitem!
				ls_value = ijs_par.getitemstring(ll_child)
				ajs_gen.additemstring(al_genparent,ls_key,ls_value)
			case jsonbooleanitem!
				lb_value = ijs_par.getitemboolean(ll_child)
				ajs_gen.additemboolean(al_genparent,ls_key,lb_value)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ld_value = ijs_par.getitemnumber(ll_child)
				ajs_gen.additemnumber(al_genparent,ls_key,ld_value)
			case jsonnullitem!
				ls_value = "null"
				ajs_gen.additemnull(al_parent,ls_key)
			case jsonobjectitem!
				ll_object = ajs_gen.additemobject(al_genparent,ls_key)
				wf_parsertostring(ll_child,false,ls_key,ajs_gen,ll_object)
			case jsonarrayitem!
				ll_object = ajs_gen.additemarray(al_genparent,ls_key)
				wf_parsertostring(ll_child,true,ls_key,ajs_gen,ll_object)
		end choose
	next
end if

return 1
end function

public function integer wf_treetojson_new (long al_handle, long al_jsonparent, long al_jsonchild);//将Treeview对象转换为json
treeviewitem ltrv_1,ltrv_2
long ll_child,ll_next,ll_jsonchild1,ll_rtn,ll_jsonchild2
string ls_label,ls_key,ls_value,ls_tmp[]
string ls_file,ls_log
long ll_file

//查找兄弟节点
ll_next = tv_1.finditem(nexttreeitem!,al_handle)

//存在兄弟
if ll_next <> -1 then
	tv_1.getitem(ll_next,ltrv_1)
	ls_label = ltrv_1.label
	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
	if ltrv_1.children then
		//存在子节点
		if pos(ls_label,'objectitem') > 0 then
			if ll_rtn = -1 then
				ll_jsonchild1 = gjs_gen.additemobject( al_jsonparent)
			else
				ll_jsonchild1 = gjs_gen.additemobject( al_jsonparent,ls_tmp[1])
			end if
			ls_log += ls_label+" additemhandle = "+string(al_jsonparent)+"~r~n"
		else
			if ll_rtn = -1 then
				ll_jsonchild1 = gjs_gen.additemarray( al_jsonparent)
			else
				ll_jsonchild1 = gjs_gen.additemarray( al_jsonparent,ls_tmp[1])
			end if	
		end if
		wf_treetojson_new(ll_next,al_jsonparent,ll_jsonchild1)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				gjs_gen.additemnumber(al_jsonparent,dec(ls_label))
			else
				gjs_gen.additemstring(al_jsonparent,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				gjs_gen.additemnumber(al_jsonparent,ls_tmp[1],dec(ls_tmp[2]))
			else
				gjs_gen.additemstring(al_jsonparent,ls_tmp[1],ls_tmp[2])
			end if
		end if
		wf_treetojson_new(ll_next,al_jsonparent,al_jsonparent)
	end if
end if


ll_child = tv_1.finditem(childtreeitem!,al_handle)
//存在子节点
if ll_child <> -1 then
	tv_1.getitem(ll_child,ltrv_2)
	ls_label = ltrv_2.label
	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
	if ltrv_2.children then
		//存在子节点
		if pos(ls_label,'objectitem') > 0 then
			if ll_rtn = -1 then
				ll_jsonchild2 = gjs_gen.additemobject( al_jsonchild)
			else
				ll_jsonchild2 = gjs_gen.additemobject( al_jsonchild,ls_tmp[1])
			end if
		else
			if ll_rtn = -1 then
				ll_jsonchild2 = gjs_gen.additemarray( al_jsonchild)
			else
				ll_jsonchild2 = gjs_gen.additemarray( al_jsonchild,ls_tmp[1])
			end if
		end if
		wf_treetojson_new(ll_child,al_jsonchild,ll_jsonchild2)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				gjs_gen.additemnumber(al_jsonchild,dec(ls_label))
			else
				gjs_gen.additemstring(al_jsonchild,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				gjs_gen.additemnumber(al_jsonchild,ls_tmp[1],dec(ls_tmp[2]))
			else
				gjs_gen.additemstring(al_jsonchild,ls_tmp[1],ls_tmp[2])
			end if
		end if
		wf_treetojson_new(ll_child,al_jsonchild,al_jsonchild)
	end if
end if


return  1
end function

public function integer wf_keyvalue (string as_value, ref string as_keyvalue[]);long ll_pos

ll_pos = pos(as_value,'=')

//root对象或者数组数据
if ll_pos = 0 then
	return -1
end if

as_keyvalue[1] = mid(as_value,1,ll_pos - 1)
as_keyvalue[2] = mid(as_value,ll_pos+1)

return 1

end function

public function integer wf_genstring (long al_parent, boolean ab_array, string as_key, long al_genparent);//
long ll_object,ll_child,ll_count,ll_loop
boolean lb_value
double ld_value
string ls_key,ls_value
jsonitemtype ljs_type

ll_count =gjs_par.getchildcount( al_parent)
if ll_count <= 0 then
	return 1
end if
if ab_array  then  //父对象是数组
//插入数组对象
	for ll_loop = 1 to ll_count
		ll_child = gjs_par.getchilditem( al_parent, ll_loop)
		ljs_type = gjs_par.getitemtype(ll_child)
		choose case ljs_type
			case jsonstringitem!
				ls_value = gjs_par.getitemstring(ll_child)
				gjs_gen.additemstring(al_genparent,ls_value)
			case jsonbooleanitem!
				lb_value = gjs_par.getitemboolean(ll_child)
				gjs_gen.additemboolean(al_genparent,lb_value)
			case jsonnumberitem!
				ls_value = string(gjs_par.getitemnumber(ll_child))
				ld_value = gjs_par.getitemnumber(ll_child)
				gjs_gen.additemnumber(al_genparent,ld_value)
			case jsonnullitem!
				ls_value = "null"
				gjs_gen.additemnull(al_genparent)
			case jsonobjectitem!
				ll_object = gjs_gen.additemobject(al_genparent)
				wf_genstring(ll_child,false,'',ll_object)
			case jsonarrayitem!
				ll_object = gjs_gen.additemarray(al_genparent)
				wf_genstring(ll_child,true,'',ll_object)
		end choose
	next
else    //父对象是object
	for ll_loop = 1 to ll_count
		ll_child = gjs_par.getchilditem( al_parent, ll_loop)
		ljs_type = gjs_par.getitemtype(ll_child)
		ls_key = gjs_par.getchildkey( al_parent,ll_loop)
		choose case ljs_type
			case jsonstringitem!
				ls_value = gjs_par.getitemstring(ll_child)
				gjs_gen.additemstring(al_genparent,ls_key,ls_value)
			case jsonbooleanitem!
				lb_value = gjs_par.getitemboolean(ll_child)
				gjs_gen.additemboolean(al_genparent,ls_key,lb_value)
			case jsonnumberitem!
				ls_value = string(gjs_par.getitemnumber(ll_child))
				ld_value = gjs_par.getitemnumber(ll_child)
				gjs_gen.additemnumber(al_genparent,ls_key,ld_value)
			case jsonnullitem!
				ls_value = "null"
				gjs_gen.additemnull(al_genparent,ls_key)
			case jsonobjectitem!
				ll_object = gjs_gen.additemobject(al_genparent,ls_key)
				wf_genstring(ll_child,false,ls_key,ll_object)
			case jsonarrayitem!
				ll_object = gjs_gen.additemarray(al_genparent,ls_key)
				wf_genstring(ll_child,true,ls_key,ll_object)
		end choose
	next
end if

return 1
end function

public subroutine wf_loadpicture ();//通过generator加载图片,并通过parser对象加载，读取到picture控件中
long ll_file,ll_object,ll_rtn,ll_root
string ls_file,ls_path,ls_json,ls_data,ls_val
blob lb_data1,lb_par
jsongenerator  ljs_gen
jsonparser ljs_par
nvo_base64  lnvo_base
if gb_glob then
	ljs_par = gjs_par
	ljs_gen = gjs_gen
else
	ljs_par = create jsonparser
	ljs_gen = create jsongenerator
end if
//lnvo_base = create nvo_base64
ll_object = ljs_gen.createjsonobject( )

ll_rtn = getfileopenname("Select Picture File",ls_path,ls_file,"BMP","Picture file(*.bmp;*.png;*.jpg),*.bmp;*.png;*.jpg")
if ll_rtn > 0 then
	if not cbx_2.checked then
		//read file to blob
		ll_file = fileopen(ls_path,textmode!,read!,shared!)
		filereadex(ll_file,lb_data1)
		fileclose(ll_file)
		ljs_gen.additemblob( ll_object, "picture", lb_data1)
		ijs_gen = ljs_gen
		ls_json = ijs_gen.getjsonstring( )
		mle_parm.text = ls_json
		ljs_par.loadstring( ls_json)
		ll_root = ljs_par.getrootitem( )
		lb_par = ljs_par.getitemblob( ll_root,'picture')
		wf_output(" ljs_par.getitemblob( ll_root,'picture') = ~r~n"+string(lb_par),false)
		p_1.setpicture( lb_par)
	else
		ll_file = fileopen(ls_path,textmode!,read!,shared!)
		filereadex(ll_file,lb_par)
		fileclose(ll_file)
		ls_data = lnvo_base.base64encode(lb_par)
		ljs_gen.additemstring(ll_object,"picture",ls_data)
		ijs_gen = ljs_gen
		ls_json = ijs_gen.getjsonstring( )
		mle_parm.text = ls_json
		ljs_par.loadstring( ls_json)
		ll_root = ljs_par.getrootitem( )
		ls_val = ljs_par.getitemstring( ll_root,'picture')
		wf_output(" ljs_par.getitemstring( ll_root,'picture') = ~r~n"+ls_val,false)
		p_1.setpicture( lnvo_base.base64decode(ls_val))
	end if
end if





end subroutine

public function integer wf_parser_json (long al_parent, boolean ai_array, long al_treeparent, string as_key);//递归分析对象
treeviewitem  ltrv_1,ltrv_2
long ll_handle,ll_count,ll_loop,ll_child,ll_parent
string ls_value,ls_key
boolean lb_value
double ld_value
jsonitemtype ljs_type
ll_count = ijs_par.getchildcount( al_parent)
if ll_count <= 0  then
	return -1
end if
if ai_array  then  //父对象是数组
//插入数组对象
	if len(trim(as_key)) > 0 then
		ltrv_1.label = as_key
		ltrv_1.pictureindex = 2
		ll_parent = tv_1.insertitemlast(al_treeparent,ltrv_1)
	else
		ltrv_1.label = "arrayitem"
		ltrv_1.pictureindex = 2
		ll_parent = tv_1.insertitemlast(al_treeparent,ltrv_1)
	end if
	for ll_loop = 1 to ll_count
		ll_child = ijs_par.getchilditem( al_parent, ll_loop)
		ljs_type = ijs_par.getitemtype(ll_child)
		choose case ljs_type
			case jsonstringitem!
				ls_value = ijs_par.getitemstring(ll_child)
				ltrv_2.label = ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonbooleanitem!
				ls_value = string(ijs_par.getitemboolean(ll_child))
				ltrv_2.label = ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ltrv_2.label = ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonnullitem!
				ls_value = "null"
				ltrv_2.label = ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonobjectitem!
				wf_parser_json(ll_child,false,ll_parent,'')
			case jsonarrayitem!
				wf_parser_json(ll_child,true,ll_parent,'')
		end choose
	next
else    //父对象是object
	if len(trim(as_key)) > 0 then
		ltrv_1.label = as_key
		ltrv_1.pictureindex = 1
		ll_parent = tv_1.insertitemlast(al_treeparent,ltrv_1)
	else
		ltrv_1.label = "objectitem"
		ltrv_1.pictureindex = 1
		ll_parent = tv_1.insertitemlast(al_treeparent,ltrv_1)
	end if
	for ll_loop = 1 to ll_count
		ll_child = ijs_par.getchilditem( al_parent, ll_loop)
		ljs_type = ijs_par.getitemtype(ll_child)
		ls_key = ijs_par.getchildkey( al_parent,ll_loop)
		choose case ljs_type
			case jsonstringitem!
				ls_value = ijs_par.getitemstring(ll_child)
				ltrv_2.label = ls_key+"="+ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonbooleanitem!
				ls_value = string(ijs_par.getitemboolean(ll_child))
				ltrv_2.label = ls_key+"="+ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ltrv_2.label = ls_key+"="+ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonnullitem!
				ls_value = ls_key+"="+"null"
				ltrv_2.label = ls_value
				ltrv_2.pictureindex = 3
				tv_1.insertitemlast(ll_parent,ltrv_2)
			case jsonobjectitem!
				ls_key +="=objectitem" 
				wf_parser_json(ll_child,false,ll_parent,ls_key)
			case jsonarrayitem!
				ls_key +="=arrayitem"
				wf_parser_json(ll_child,true,ll_parent,ls_key)
		end choose
	next
end if

return 1
end function

public function integer wf_generatetree ();//
string ls_output
long ll_handle,ll_root
jsonitemtype ljs_type
treeviewitem ltrv_1
if gb_glob then
	ijs_par = gjs_par
end if
ls_output = ijs_par.loadstring( mle_parm.text)

if len(trim(ls_output)) >  0 then
	messagebox("LoadString Failed",mle_parm.text+"~r~n"+ls_output)
	return -1
else
	wf_output("ijs_par.loadstring("+mle_parm.text+") succeed!",false)
end if
//init tree
tv_1.deleteitem(1)

ll_root = ijs_par.getrootitem( )

ljs_type = ijs_par.getitemtype( ll_root)

if ljs_type = jsonobjectitem! then
	wf_parser_json(ll_root,false,0,'')
elseif  ljs_type = jsonarrayitem! then
	wf_parser_json(ll_root,true,0,'')
end if

tv_1.expanditem( 1)
return 1
end function

public subroutine wf_treetojson ();treeviewitem ltrv_root
long ll_root,ll_handle
string ls_json,ls_file
ll_root = tv_1.finditem( roottreeitem!, 0)

tv_1.getitem(ll_root,ltrv_root)
ijs_gen = gjs_gen
if ltrv_root.label = "objectitem" then
	ll_handle = ijs_gen.createjsonobject( )
else
	ll_handle = ijs_gen.createjsonarray( )
end if

wf_treetojson_new(ll_root,ll_handle,ll_handle)

ls_json = ijs_gen.getjsonstring( )
mle_parm.text = ls_json
wf_output("New Json is "+ ls_json,false)


end subroutine

public subroutine wf_dwtojson ();//将datawindow数据转化为json
string ls_key,ls_value
long ll_object,ll_array,ll_row,ll_loop,ll_id,ll_object2
long ll_colunm,ll_rtn
string ls_json
long ll_begin,ll_end
ll_begin = cpu()
string ls_log,ls_tmp
long ll_log
ls_log = "dw2json.log"
filedelete(ls_log)
ll_log = fileopen(ls_log,linemode!,write!,shared!,append!,encodingutf8!)
if cbx_3.checked then
	//插入一个json 数组
	ll_array = gjs_gen.createjsonarray( )
	
	for ll_row = 1 to dw_1.rowcount( )
		//循环插入array,以id为key
		ll_id = dw_1.getitemnumber( ll_row,1)
	//	ll_array = gjs_gen.additemarray( ll_object, string(ll_id))
		ll_object2 = gjs_gen.additemobject( ll_array)
		ls_tmp = string(now(),"mm:ss:fff")+": additemobject = "+string(ll_object2)
		filewrite(ll_log,ls_tmp)
		ll_colunm = long(dw_1.describe("DataWindow.Column.Count"))
		for ll_loop = 1 to ll_colunm
			ls_key = dw_1.describe( "#"+string(ll_loop)+".name")
			//取各个数据
			ls_value = string(dw_1.object.data.primary[ll_row,ll_loop])
			ls_tmp = string(now(),"mm:ss:fff")+": getvaluefromdw = "+ls_value
			filewrite(ll_log,ls_tmp)
			//往object2下插入数据
			gjs_gen.additemstring(ll_object2,ls_key,ls_value)
			ls_tmp = string(now(),"mm:ss:fff")+": additemstring"
			filewrite(ll_log,ls_tmp)
		next
	next
else
	//插入一个json 对象
	ll_object = gjs_gen.createjsonobject( )
	
	for ll_row = 1 to dw_1.rowcount( )
		//循环插入array,以id为key
		ll_id = dw_1.getitemnumber( ll_row,1)
		ll_object2 = gjs_gen.additemobject( ll_object, string(ll_id))
		ls_tmp = string(now(),"mm:ss:fff")+": additemobject = "+string(ll_object2)
		filewrite(ll_log,ls_tmp)
		ll_colunm = long(dw_1.describe("DataWindow.Column.Count"))
		for ll_loop = 2 to ll_colunm
			ls_key = dw_1.describe( "#"+string(ll_loop)+".name")
			//取各个数据
			ls_value = string(dw_1.object.data.primary[ll_row,ll_loop])
			ls_tmp = string(now(),"mm:ss:fff")+": getvaluefromdw = "+ls_value
			filewrite(ll_log,ls_tmp)
			//往object2下插入数据
			gjs_gen.additemstring(ll_object2,ls_key,ls_value)
			ls_tmp = string(now(),"mm:ss:fff")+": additemstring"
			filewrite(ll_log,ls_tmp)
		next
	next
end if
fileclose(ll_log)
ls_json = gjs_gen.getjsonstring( )
ll_end = cpu()
st_2.text = "耗时："+string(ll_end - ll_begin)+" MS"
//字符串赋值会非常慢，决定将数据保存为文件
mle_parm.text = ls_json
//wf_output("The result of dwtojson is :~r~n"+ls_json,false)
ll_rtn = gjs_gen.savetofile("dw2json.txt")
if ll_rtn = 1 then
	wf_output('gjs_gen.savetofile("dw2json.txt") Succeed ',false)
else
	wf_output('gjs_gen.savetofile("dw2json.txt") failed = '+string(ll_rtn),false)
end if

end subroutine

public subroutine wf_jsontodw ();//将datawindow数据转化为json
string ls_key,ls_value
long ll_object,ll_array,ll_row,ll_loop,ll_id,ll_object2,ll_loop2
long ll_colunm,ll_root,ll_rootchild,ll_child,ll_handle
string ls_json,ls_rtn,ls_objectkey
jsonitemtype ljs_type
long ll_begin,ll_end
ll_begin = cpu()

//加载json
ls_rtn = gjs_par.loadstring(mle_parm.text)
if len(ls_rtn) = 0 then
	wf_output("loadstring() succeed",false)
else
	wf_output("loadstring() failed ："+ls_rtn,false)
	return
end if
//取根节点
ll_root = gjs_par.getrootitem( )
ljs_type = gjs_par.getitemtype( ll_root)
ll_rootchild = gjs_par.getchildcount( ll_root)
if ljs_type = jsonarrayitem! then
	//通过数组来解析
	for ll_loop = 1 to ll_rootchild
		ll_array = gjs_par.getchilditem( ll_root,ll_loop)
		ll_row = dw_1.insertrow( 0)
		ll_child = gjs_par.getchildcount( ll_array)
		for ll_loop2 = 1 to ll_child
			ls_key = gjs_par.getchildkey( ll_array, ll_loop2)
			ls_value = gjs_par.getitemstring(ll_array,ls_key)
			if ll_loop2 = 1 then
				dw_1.setitem(ll_row,1,long(ls_value))
			else
				dw_1.setitem(ll_row,ll_loop2,ls_value)
			end if
		next
	next
else 
	//通过object解析
	for ll_loop = 1 to ll_rootchild
		ll_object = gjs_par.getchilditem( ll_root,ll_loop)
		ll_row = dw_1.insertrow( 0)
		ls_objectkey = gjs_par.getchildkey( ll_root, ll_loop)
		//插入key到第一列
		dw_1.setitem(ll_row,1,long(ls_objectkey))
		ll_child = gjs_par.getchildcount( ll_object)
		for ll_loop2 = 1 to ll_child
			//ls_key = gjs_par.getchildkey( ll_object, ll_loop2)
			//通过handle获取数据
			ll_handle = gjs_par.getchilditem( ll_object, ll_loop2)
			ls_value = gjs_par.getitemstring( ll_handle)
			dw_1.setitem(ll_row,ll_loop2 + 1,ls_value)
		next
	next
end if
ll_end = cpu()
st_2.text = "耗时："+string(ll_end - ll_begin)+" MS"
end subroutine

public subroutine wf_jsonarray ();//通过jsonarry，查看性能情况
nvo_jsonpar ljs_par[10000]
nvo_jsongen ljs_gen[10000]
jsonitemtype ljs_type
long ll_loop,ll_root,ll_handle
string ls_rtn,ls_json,ls_output,ls_tmp
long ll_start,ll_end,ll_pos
ll_start = cpu()
//this.setredraw(false)
for ll_loop = 1 to long(em_2.text)
	ll_pos = pos(mle_parm.text,"珠海")
	ls_tmp = replace(mle_parm.text,ll_pos,2,"珠海"+string(ll_loop))
	if not isvalid(ljs_par[ll_loop]) then
		ljs_par[ll_loop] = create nvo_jsonpar
	end if
	if not isvalid(ljs_gen[ll_loop]) then
		ljs_gen[ll_loop] = create nvo_jsongen
	end if
	ls_rtn = ljs_par[ll_loop].loadstring( ls_tmp)
	if len(ls_rtn) = 0 then
		gjs_par = ljs_par[ll_loop]
		wf_output(string(now())+":ljs_par["+string(ll_loop)+"] loadstring() Succeed!",false)
	else
		wf_output(string(now())+":ljs_par["+string(ll_loop)+"] loadstring() Failed:"+ls_rtn,false)
	end if
	ll_root = ljs_par[ll_loop].getrootitem( )
	ljs_type = ljs_par[ll_loop].getitemtype( ll_root)
	gjs_gen = ljs_gen[ll_loop]
	if ljs_type = jsonobjectitem! then
		ll_handle = ljs_gen[ll_loop].createjsonobject()
		wf_genstring(ll_root,false,'',ll_handle)
	elseif  ljs_type = jsonarrayitem! then
		ll_handle = ljs_gen[ll_loop].createjsonarray()
		wf_genstring(ll_root,true,'',ll_handle)
	end if
//	wf_output(string(now())+":json["+string(ll_loop)+"] = "+string(ljs_gen[ll_loop].isjsonvalid()),false)
	ls_json = ljs_gen[ll_loop].getjsonstring( )
	ls_output += string(now())+":"+"json["+string(ll_loop)+"] = ~r~n"+ls_json+"~r~n"
next
ll_end = cpu()
st_4.text = "耗时："+string(ll_end - ll_start)+" MS"
mle_jsonarray.text = ls_output

//this.setredraw(true)
end subroutine

public function integer wf_jsontodw_bigdata ();//加载地址json数据，然后输出到datawindow
string ls_file,ls_rtn
long ll_rtn,ll_root,ll_array1,ll_array2,ll_object1,ll_object2,ll_object3
long ll_loop1,ll_loop2,ll_loop3,ll_loop4,ll_row
long ll_rootchild,ll_child1,ll_child2,ll_child3
string ls_shengquid,ls_shengquname,ls_shiquid,ls_shiquname,ls_diquid,ls_diquname,ls_diquyb
string ls_key
jsonparser ljs_par
if gb_glob then
	ljs_par = gjs_par
else
	ljs_par = create jsonparser
end if
ls_file = getcurrentdirectory()+"\jsonfile\dizhi.dat"
//加载json数据
ls_rtn = ljs_par.loadfile( ls_file)
if len(ls_rtn) =0 then
	wf_output("loadfile("+ls_file+") Succeed!",false)	
else
	wf_output("loadfile("+ls_file+") Failed:"+ls_rtn,false)	
	return -1
end if
ll_root = ljs_par.getrootitem( )
ll_rootchild = ljs_par.getchildcount( ll_root)
dw_2.reset()
dw_3.reset()
for ll_loop1 = 1 to ll_rootchild
	//取出root下的对象
	ll_object1 = ljs_par.getchilditem( ll_root,ll_loop1)
	//对象1下有3个元素，分别为id，name，数组，取省区
	ls_key = ljs_par.getchildkey( ll_object1, 1)
	ls_shengquid = string(ljs_par.getitemnumber( ll_object1,ls_key))
	ls_key = ljs_par.getchildkey( ll_object1, 2)
	ls_shengquname = ljs_par.getitemstring( ll_object1,ls_key)
	//去数组对象
	ll_array1 = ljs_par.getchilditem( ll_object1, 3)
	ll_child1 = ljs_par.getchildcount( ll_array1)
	for ll_loop2 = 1 to ll_child1
		//取object2
		ll_object2 = ljs_par.getchilditem( ll_array1,ll_loop2)
		//对象1下有3个元素，分别为id，name，数组，取市区
		ls_key = ljs_par.getchildkey( ll_object2, 1)
		ls_shiquid = string(ljs_par.getitemnumber( ll_object2,ls_key))
		ls_key = ljs_par.getchildkey( ll_object2, 2)
		ls_shiquname = ljs_par.getitemstring( ll_object2,ls_key)
		//取数组对象2
		ll_array2 = ljs_par.getchilditem( ll_object2, 3)
		ll_child2 = ljs_par.getchildcount( ll_array2)
		for ll_loop3 = 1 to ll_child2
			//取object3
			ll_object3 = ljs_par.getchilditem( ll_array2,ll_loop3)
			//对象1下有3个元素，分别为id，name，bianhao
			ls_key = ljs_par.getchildkey( ll_object3, 1)
			ls_diquid = string(ljs_par.getitemnumber( ll_object3,ls_key))
			ls_key = ljs_par.getchildkey( ll_object3, 2)
			ls_diquname = ljs_par.getitemstring( ll_object3,ls_key)
			ls_key = ljs_par.getchildkey( ll_object3, 3)
			ls_diquyb = ljs_par.getitemstring( ll_object3,ls_key)
			ll_row = dw_2.insertrow( 0)
			dw_2.setitem(ll_row,"shengquid",ls_shengquid)
			dw_2.setitem(ll_row,"shengquname",ls_shengquname)
			dw_2.setitem(ll_row,"shiquid",ls_shiquid)
			dw_2.setitem(ll_row,"shiquname",ls_shiquname)
			dw_2.setitem(ll_row,"diquid",ls_diquid)
			dw_2.setitem(ll_row,"diquname",ls_diquname)
			dw_2.setitem(ll_row,"diquyb",ls_diquyb)
		next
	next
	
next

dw_2.sharedata( dw_3)


return 1

end function

on w_json_integration_new.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.tv_1=create tv_1
this.cb_4=create cb_4
this.sle_1=create sle_1
this.cbx_2=create cbx_2
this.p_1=create p_1
this.dw_1=create dw_1
this.st_1=create st_1
this.em_1=create em_1
this.cb_5=create cb_5
this.cbx_3=create cbx_3
this.st_2=create st_2
this.st_3=create st_3
this.sle_2=create sle_2
this.st_4=create st_4
this.mle_jsonarray=create mle_jsonarray
this.em_2=create em_2
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.cbx_2
this.Control[iCurrent+6]=this.p_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.cb_5
this.Control[iCurrent+11]=this.cbx_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.sle_2
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.mle_jsonarray
this.Control[iCurrent+17]=this.em_2
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.dw_3
end on

on w_json_integration_new.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.tv_1)
destroy(this.cb_4)
destroy(this.sle_1)
destroy(this.cbx_2)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_5)
destroy(this.cbx_3)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.mle_jsonarray)
destroy(this.em_2)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;ijs_par = create jsonparser
ijs_gen = create jsongenerator

mle_parm.text = ' &
		{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
		{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
		}'
end event

type cb_3 from w_manu_base`cb_3 within w_json_integration_new
end type

type cb_2 from w_manu_base`cb_2 within w_json_integration_new
end type

type cb_1 from w_manu_base`cb_1 within w_json_integration_new
end type

event cb_1::clicked;call super::clicked;//加载各测试点参数所需的默认测试数据
string ls_parm,ls_datalist

ls_parm = ddlb_parm.text
choose case ls_parm
	case "json"
		is_json = mle_parm.text
		
end choose

end event

type mle_parm from w_manu_base`mle_parm within w_json_integration_new
end type

type lb_data from w_manu_base`lb_data within w_json_integration_new
end type

event lb_data::selectionchanged;call super::selectionchanged;if index = 0 then return

mle_parm.text = this.text(index)
end event

type ddlb_parm from w_manu_base`ddlb_parm within w_json_integration_new
end type

event ddlb_parm::selectionchanged;call super::selectionchanged;//加载各测试点参数所需的默认测试数据
string ls_parm,ls_datalist
if index = 0 then  return

ls_parm = this.text(index)
choose case ls_parm
	case "json"
		//添加loadstring的测试数据
		ls_datalist = "{},[],123,[13],{'test':123},{~"test~":~"测试数据~"}"
		
end choose

wf_additem(ls_datalist,lb_data)
end event

type mle_desc from w_manu_base`mle_desc within w_json_integration_new
end type

type mle_output from w_manu_base`mle_output within w_json_integration_new
end type

type lb_fun from w_manu_base`lb_fun within w_json_integration_new
end type

event lb_fun::selectionchanged;call super::selectionchanged;string ls_testcase,ls_desc,ls_parmlist,ls_datalist
ls_testcase = this.text(index)
//控件是否可视
cbx_1.visible = false
cbx_2.visible = false
p_1.visible = false

tv_1.visible = false
sle_1.visible = false
cb_4.visible = false
st_2.visible = false

st_1.visible = false
em_1.visible = false
cb_5.visible = false
dw_1.visible = false
cbx_3.visible = false

st_3.visible = false
st_4.visible = false
sle_2.visible = false
em_2.visible = false
mle_jsonarray.visible = false
dw_2.visible = false
dw_3.visible = false

//给每个testcase加入描述信息
choose case lower(ls_testcase)
	case "loadstring"
		ls_desc = "测试loadstring功能，需要测试各种类型的json字符串，包括错误的非错误的，object和数组重叠的"
		ls_parmlist = "json"
	case "loadfile"
		cbx_1.visible = true
		ls_desc = "加载各种不同的文件，测试通过文件加载不同的json数据功能"+"~r~n"
		ls_desc +="filetostring单选框，如果选择将读取文件到字符串，然后通过loadstring加载"
		ls_parmlist = "不提供参数，执行时动态选择"
	case "generatestring"
		ls_desc = "将jsonpar中的json数据重新生成字符串，输出到界面"
	case "savetofile"
		ls_desc = "将json数据另存为其他任何格式的文件，可以测试保存到doc，同时doc被打开的情况"
		ls_parmlist = "不提供参数，保存的文件名执行时动态设置"
	case "loadpicture"
		cbx_2.visible = true
		p_1.visible = true
		ls_desc = "测试blob类数据，主要通过两种情况测试：~r~n"
		ls_desc += "通过additemblob和setitemblob测试~r~n"
		ls_desc += "通过additemstring和setitemstring测试，使用base64对图片进行加解密"
	case "generatetree"
		tv_1.visible = true
		sle_1.visible = true
		cb_4.visible = true
		ls_desc = "将合法的json数据，输出为树结构显示"
	case "treetojson"
		tv_1.visible = true
		sle_1.visible = true
		cb_4.visible = true
		ls_desc = "通过generate生成树结构以后，可以修改树节点数据，然后重新生成新的json"
	case "jsontodw"
		st_1.visible = true
		em_1.visible = true
		cb_5.visible = true
		dw_1.visible = true
		st_2.visible = true
		st_2.text = ""
		dw_1.reset( )
		ls_desc = "请先执行dwtojson，可以修改生成后的字符串名称，或者按规则添加新数据"
	case "jsontodw_bigdata"
		//dw_2.visible = true
		dw_3.visible = true
		ls_desc = "通过json加载dizi.dat，然后解析输出到datawindow"
		
	case "dwtojson"
		st_1.visible = true
		em_1.visible = true
		cb_5.visible = true
		dw_1.visible = true
		cbx_3.visible = true
		st_2.visible = true
		st_2.text = ''
		ls_desc = "通过测试大数据，查看json的执行效率~r~n"
		ls_desc += "选择array，生成array的json，不选择arrary生成object的json~r~n"
		ls_desc += "数据过多时，字符串赋值到mle非常慢"
		cb_5.postevent(clicked!)
	case "jsonarray"
		st_3.visible = true
		st_4.visible = true
		em_2.visible = true
		mle_jsonarray.visible = true
		mle_parm.text = ' &
		{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
		{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
		}'
		ls_desc = "通过jsonarray数组循环加载json字符串，然后通过jsongenerator数组输出加载后的数据~r~n"
		ls_desc += "数据过多时，字符串赋值到mle非常慢"
	case "exception"
		ls_desc = "未捕捉的异常，运行时会崩溃"
end choose
wf_desc(ls_desc)
wf_additem(ls_parmlist,ddlb_parm)
ddlb_parm.selectitem(1)
ddlb_parm.event selectionchanged(1)
end event

type gb_1 from w_manu_base`gb_1 within w_json_integration_new
end type

type gb_2 from w_manu_base`gb_2 within w_json_integration_new
end type

type gb_3 from w_manu_base`gb_3 within w_json_integration_new
end type

type gb_4 from w_manu_base`gb_4 within w_json_integration_new
end type

type gb_5 from w_manu_base`gb_5 within w_json_integration_new
end type

type cbx_1 from checkbox within w_json_integration_new
boolean visible = false
integer x = 2770
integer y = 580
integer width = 457
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "filetostring"
end type

type tv_1 from treeview within w_json_integration_new
boolean visible = false
integer x = 3255
integer y = 568
integer width = 891
integer height = 1644
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;long ll_newhandle
treeviewitem ltrv_1
this.editlabels = false
if newhandle <= 0 then return 

this.getitem(newhandle,ltrv_1)

if ltrv_1.children then return

this.editlabels = true
this.editlabel( newhandle)

end event

type cb_4 from commandbutton within w_json_integration_new
boolean visible = false
integer x = 2779
integer y = 2080
integer width = 466
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "AddItem"
end type

event clicked;long ll_handle,ll_parent,ll_next,ll_handle_new,ll_rtn
treeviewitem ltrv_1,ltrv_2,ltrv_3
string ls_label,ls_key,ls_tmp[]
boolean lb_array
string ls_data
ll_handle = tv_1.finditem(currenttreeitem!,0)
ls_data = sle_1.text
if ll_handle <= 0 then return
//ll_parent = tv_1.finditem(parenttreeitem!,ll_handle)
tv_1.getitem(ll_handle,ltrv_2)
ls_label = ltrv_2.label
if ltrv_2.children then
	if pos(ls_label,"objectitem") > 0 then
		if pos(ls_data,"=") = 0 then
			messagebox("Error","ls_data不合法~r~nObject下数据为Key=Value")
			return
		end if
	else
		if pos(ls_data,"=") > 0 then
			messagebox("Error","ls_data不合法~r~nArray下数据为Value")
			return
		end if
	end if
	ltrv_1.label = ls_data
	ltrv_1.pictureindex = 4
	tv_1.insertitemlast(ll_handle,ltrv_1)
else
	//子节点变父节点，根据子数据信息，修改label
	ll_next = tv_1.finditem( PreviousTreeItem!, ll_handle)
	ll_parent = tv_1.finditem(parenttreeitem!,ll_handle)
	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
	tv_1.getitem(ll_parent,ltrv_3)
	if pos(ltrv_3.label,'objectitem') >0 then
		if ll_rtn = -1 then	
		else
			ls_label = ls_tmp[2]
		end if
		lb_array = false
	else
		lb_array = true
		if ll_rtn = -1 then	
		else
			ls_label = ls_tmp[2]
		end if
	end if
	//删除当前结点
//	tv_1.deleteitem( ll_handle)
	if pos(ls_data,"=") > 0 then
		//当前节点变为object
		if lb_array then
			ls_label = "objectitem"
		else
			ls_label = ls_label+"=objectitem"
		end if
		ltrv_2.pictureindex = 1
	else
		//当前节点变为数组
		if lb_array then
			ls_label = "arrayitem"
		else
			ls_label = ls_label+"=arrayitem"
		end if
		ltrv_2.pictureindex = 2
	end if
	ltrv_2.label = ls_label
	tv_1.setitem(ll_handle,ltrv_2)
	//重新插入节点
//	if ll_next > 0 then
//		ll_handle_new = tv_1.insertitem(ll_parent,ll_next,ltrv_2)
//	else
//		ll_handle_new = tv_1.insertitemfirst(ll_parent,ltrv_2)
//	end if
//	tv_1.selectitem(ll_handle_new)
//	sleep(0.1)
	ltrv_1.label = ls_data
	ltrv_1.pictureindex = 4
	tv_1.insertitemlast(ll_handle,ltrv_1)
	tv_1.selectitem(ll_handle)
	tv_1.expanditem( ll_handle)
end if
	

end event

type sle_1 from singlelineedit within w_json_integration_new
boolean visible = false
integer x = 2779
integer y = 1900
integer width = 457
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "key=value"
borderstyle borderstyle = stylelowered!
end type

type cbx_2 from checkbox within w_json_integration_new
boolean visible = false
integer x = 2775
integer y = 580
integer width = 457
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "PicAsString"
end type

type p_1 from picture within w_json_integration_new
boolean visible = false
integer x = 3246
integer y = 564
integer width = 896
integer height = 696
boolean bringtotop = true
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_json_integration_new
boolean visible = false
integer x = 2770
integer y = 700
integer width = 1376
integer height = 1512
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_customer"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_json_integration_new
boolean visible = false
integer x = 2761
integer y = 580
integer width = 160
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "行数"
boolean focusrectangle = false
end type

type em_1 from editmask within w_json_integration_new
boolean visible = false
integer x = 2949
integer y = 568
integer width = 457
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "1000"
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type cb_5 from commandbutton within w_json_integration_new
boolean visible = false
integer x = 3429
integer y = 556
integer width = 361
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;//初始化datawindow数据
long ll_loop,ll_count,ll_row

ll_count = long(em_1.text)
dw_1.reset( )

for ll_loop = 1 to ll_count
	ll_row = dw_1.insertrow(0)
	dw_1.setitem(ll_row,1,100 + ll_loop)
	dw_1.setitem(ll_row,2,"firstname"+string(ll_loop))
	dw_1.setitem(ll_row,3,"address"+string(ll_loop))
	dw_1.setitem(ll_row,4,"lastname"+string(ll_loop))
	dw_1.setitem(ll_row,5,"city"+string(ll_loop))
	dw_1.setitem(ll_row,6,"1")
	dw_1.setitem(ll_row,7,"zip"+string(ll_loop))
	dw_1.setitem(ll_row,8,"phone"+string(ll_loop))
	dw_1.setitem(ll_row,9,"company"+string(ll_loop))
next

end event

type cbx_3 from checkbox within w_json_integration_new
boolean visible = false
integer x = 3799
integer y = 580
integer width = 279
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Array"
boolean checked = true
end type

type st_2 from statictext within w_json_integration_new
boolean visible = false
integer x = 4064
integer y = 588
integer width = 50
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_json_integration_new
integer x = 2770
integer y = 576
integer width = 315
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "数组个数"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_json_integration_new
boolean visible = false
integer x = 3113
integer y = 564
integer width = 457
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "3000"
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_json_integration_new
integer x = 3584
integer y = 580
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type mle_jsonarray from multilineedit within w_json_integration_new
boolean visible = false
integer x = 2775
integer y = 696
integer width = 1371
integer height = 1528
integer taborder = 90
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_json_integration_new
integer x = 3122
integer y = 560
integer width = 448
integer height = 112
integer taborder = 90
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "1000"
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type dw_2 from datawindow within w_json_integration_new
boolean visible = false
integer x = 2766
integer y = 556
integer width = 1385
integer height = 1668
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_diqu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_json_integration_new
boolean visible = false
integer x = 2775
integer y = 564
integer width = 1371
integer height = 1656
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_diqu_tree"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

