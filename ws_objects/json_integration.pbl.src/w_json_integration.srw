$PBExportHeader$w_json_integration.srw
forward
global type w_json_integration from w_base
end type
type cbx_2 from checkbox within w_json_integration
end type
type dw_1 from datawindow within w_json_integration
end type
type cb_12 from commandbutton within w_json_integration
end type
type cbx_1 from checkbox within w_json_integration
end type
type cb_10 from commandbutton within w_json_integration
end type
type sle_1 from singlelineedit within w_json_integration
end type
type st_1 from statictext within w_json_integration
end type
type cb_9 from commandbutton within w_json_integration
end type
type cb_8 from commandbutton within w_json_integration
end type
type cb_7 from commandbutton within w_json_integration
end type
type tv_1 from treeview within w_json_integration
end type
type cb_6 from commandbutton within w_json_integration
end type
type p_1 from picture within w_json_integration
end type
type cb_5 from commandbutton within w_json_integration
end type
type mle_2 from multilineedit within w_json_integration
end type
type cb_4 from commandbutton within w_json_integration
end type
type cb_3 from commandbutton within w_json_integration
end type
type cb_2 from commandbutton within w_json_integration
end type
type cb_1 from commandbutton within w_json_integration
end type
type mle_1 from multilineedit within w_json_integration
end type
type gb_1 from groupbox within w_json_integration
end type
type gb_2 from groupbox within w_json_integration
end type
end forward

global type w_json_integration from w_base
integer width = 4027
integer height = 3244
string title = "Json_Integration"
cbx_2 cbx_2
dw_1 dw_1
cb_12 cb_12
cbx_1 cbx_1
cb_10 cb_10
sle_1 sle_1
st_1 st_1
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
tv_1 tv_1
cb_6 cb_6
p_1 p_1
cb_5 cb_5
mle_2 mle_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_json_integration w_json_integration

type variables
jsongenerator ijs_gen
jsonparser ijs_par
long il_file
end variables

forward prototypes
public function integer wf_parser_json (long al_parent, boolean ai_array, long al_treeparent, string as_key)
public function integer wf_genstring (long al_parent, boolean ab_array, string as_key, long al_genparent)
public function integer wf_parsertostring (long al_parent, boolean ab_array, string as_key, jsongenerator ajs_gen, long al_genparent)
public function integer wf_keyvalue (string as_value, ref string as_keyvalue[])
public function integer wf_treetojson (long al_handle, long al_jsonpar)
public function integer wf_treetojson_new (long al_handle, long al_jsonparent, long al_jsonchild)
end prototypes

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

public function integer wf_genstring (long al_parent, boolean ab_array, string as_key, long al_genparent);//
long ll_object,ll_child,ll_count,ll_loop
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
				ijs_gen.additemstring(al_genparent,ls_value)
			case jsonbooleanitem!
				lb_value = ijs_par.getitemboolean(ll_child)
				ijs_gen.additemboolean(al_genparent,lb_value)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ld_value = ijs_par.getitemnumber(ll_child)
				ijs_gen.additemnumber(al_genparent,ld_value)
			case jsonnullitem!
				ls_value = "null"
				ijs_gen.additemnull(al_genparent)
			case jsonobjectitem!
				ll_object = ijs_gen.additemobject(al_genparent)
				wf_genstring(ll_child,false,'',ll_object)
			case jsonarrayitem!
				ll_object = ijs_gen.additemarray(al_genparent)
				wf_genstring(ll_child,true,'',ll_object)
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
				ijs_gen.additemstring(al_genparent,ls_key,ls_value)
			case jsonbooleanitem!
				lb_value = ijs_par.getitemboolean(ll_child)
				ijs_gen.additemboolean(al_genparent,ls_key,lb_value)
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child))
				ld_value = ijs_par.getitemnumber(ll_child)
				ijs_gen.additemnumber(al_genparent,ls_key,ld_value)
			case jsonnullitem!
				ls_value = "null"
				ijs_gen.additemnull(al_genparent,ls_key)
			case jsonobjectitem!
				ll_object = ijs_gen.additemobject(al_genparent,ls_key)
				wf_genstring(ll_child,false,ls_key,ll_object)
			case jsonarrayitem!
				ll_object = ijs_gen.additemarray(al_genparent,ls_key)
				wf_genstring(ll_child,true,ls_key,ll_object)
		end choose
	next
end if

return 1
end function

public function integer wf_parsertostring (long al_parent, boolean ab_array, string as_key, jsongenerator ajs_gen, long al_genparent);//
long ll_object,ll_child,ll_count,ll_loop
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

public function integer wf_treetojson (long al_handle, long al_jsonpar);//将Treeview对象转换为json
treeviewitem ltrv_1,ltrv_2
long ll_child,ll_next,ll_jsonchild1,ll_rtn,ll_parentjson,ll_jsonchild2
string ls_label,ls_key,ls_value,ls_tmp[]
string ls_file,ls_log
long ll_file
ll_parentjson = al_jsonpar


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
				ll_jsonchild1 = ijs_gen.additemobject( ll_parentjson)
			else
				ll_jsonchild1 = ijs_gen.additemobject( ll_parentjson,ls_tmp[1])
			end if
			ls_log += ls_label+" additemhandle = "+string(ll_parentjson)+"~r~n"
		else
			if ll_rtn = -1 then
				ll_jsonchild1 = ijs_gen.additemarray( ll_parentjson)
			else
				ll_jsonchild1 = ijs_gen.additemarray( ll_parentjson,ls_tmp[1])
			end if	
		end if
		ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson(ll_next,ll_jsonchild1)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				ijs_gen.additemnumber(ll_parentjson,dec(ls_label))
			else
				ijs_gen.additemstring(ll_parentjson,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				ijs_gen.additemnumber(ll_parentjson,ls_tmp[1],dec(ls_tmp[2]))
			else
				ijs_gen.additemstring(ll_parentjson,ls_tmp[1],ls_tmp[2])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(ll_parentjson)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson(ll_next,ll_parentjson)
	end if
end if


ll_child = tv_1.finditem(childtreeitem!,al_handle)
//ls_file = "debug.log"
//filedelete(ls_file)
//ll_file = fileopen(ls_file,textmode!,write!,shared!)
//存在子节点
if ll_child <> -1 then
	tv_1.getitem(ll_child,ltrv_2)
	ls_label = ltrv_2.label
	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
	if ltrv_2.children then
		//存在子节点
		if pos(ls_label,'objectitem') > 0 then
			if ll_rtn = -1 then
				ll_jsonchild2 = ijs_gen.additemobject( ll_parentjson)
			else
				ll_jsonchild2 = ijs_gen.additemobject( ll_parentjson,ls_tmp[1])
			end if
		else
			if ll_rtn = -1 then
				ll_jsonchild2 = ijs_gen.additemarray( ll_parentjson)
			else
				ll_jsonchild2 = ijs_gen.additemarray( ll_parentjson,ls_tmp[1])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(ll_parentjson)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson(ll_child,ll_jsonchild2)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				ijs_gen.additemnumber(ll_parentjson,dec(ls_label))
			else
				ijs_gen.additemstring(ll_parentjson,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				ijs_gen.additemnumber(ll_parentjson,ls_tmp[1],dec(ls_tmp[2]))
			else
				ijs_gen.additemstring(ll_parentjson,ls_tmp[1],ls_tmp[2])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(ll_parentjson)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson(ll_child,ll_parentjson)
	end if
//查找兄弟节点
//ll_next = tv_1.finditem(nexttreeitem!,ll_child)
//
////存在兄弟
//if ll_next <> -1 then
//	tv_1.getitem(ll_next,ltrv_1)
//	ls_label = ltrv_1.label
//	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
//	if ltrv_1.children then
//		//存在子节点
//		if pos(ls_label,'objectitem') > 0 then
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar,ls_tmp[1])
//			end if
//		else
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar,ls_tmp[1])
//			end if
//		end if
//		wf_treetojson(ll_next,ll_jsonchild)
//	else
//		//不存在子节点
//		if ll_rtn = -1 then
//			if isnumber(ls_label) then
//				ijs_gen.additemnumber(al_jsonpar,dec(ls_label))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_label)
//			end if
//		else
//			if isnumber(ls_tmp[2]) then
//				ijs_gen.additemnumber(al_jsonpar,ls_tmp[1],dec(ls_tmp[2]))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_tmp[1],ls_tmp[2])
//			end if
//		end if
//	end if
//end if
end if


////查找兄弟节点
//ll_next = tv_1.finditem(nexttreeitem!,al_handle)
//
////存在兄弟
//if ll_next <> -1 then
//	tv_1.getitem(ll_next,ltrv_1)
//	ls_label = ltrv_1.label
//	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
//	if ltrv_1.children then
//		//存在子节点
//		if pos(ls_label,'objectitem') > 0 then
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar,ls_tmp[1])
//			end if
//			ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		else
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar,ls_tmp[1])
//			end if	
//		end if
//		ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		filewriteex(il_file,ls_log)
//		wf_treetojson(ll_next,ll_jsonchild)
//	else
//		//不存在子节点
//		if ll_rtn = -1 then
//			if isnumber(ls_label) then
//				ijs_gen.additemnumber(al_jsonpar,dec(ls_label))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_label)
//			end if
//		else
//			if isnumber(ls_tmp[2]) then
//				ijs_gen.additemnumber(al_jsonpar,ls_tmp[1],dec(ls_tmp[2]))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_tmp[1],ls_tmp[2])
//			end if
//		end if
//		ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		filewriteex(il_file,ls_log)
//		wf_treetojson(ll_next,ll_parentjson)
//	end if
//end if

//fileclose(ll_file)

return  1
end function

public function integer wf_treetojson_new (long al_handle, long al_jsonparent, long al_jsonchild);//将Treeview对象转换为json
treeviewitem ltrv_1,ltrv_2
long ll_child,ll_next,ll_jsonchild1,ll_rtn,ll_jsonchild2
string ls_label,ls_key,ls_value,ls_tmp[]
string ls_file,ls_log
long ll_file
//al_jsonparent = al_jsonpar


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
				ll_jsonchild1 = ijs_gen.additemobject( al_jsonparent)
			else
				ll_jsonchild1 = ijs_gen.additemobject( al_jsonparent,ls_tmp[1])
			end if
			ls_log += ls_label+" additemhandle = "+string(al_jsonparent)+"~r~n"
		else
			if ll_rtn = -1 then
				ll_jsonchild1 = ijs_gen.additemarray( al_jsonparent)
			else
				ll_jsonchild1 = ijs_gen.additemarray( al_jsonparent,ls_tmp[1])
			end if	
		end if
		ls_log += ls_label+" additemhandle = "+string(al_jsonparent)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson_new(ll_next,al_jsonparent,ll_jsonchild1)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				ijs_gen.additemnumber(al_jsonparent,dec(ls_label))
			else
				ijs_gen.additemstring(al_jsonparent,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				ijs_gen.additemnumber(al_jsonparent,ls_tmp[1],dec(ls_tmp[2]))
			else
				ijs_gen.additemstring(al_jsonparent,ls_tmp[1],ls_tmp[2])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(al_jsonparent)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson_new(ll_next,al_jsonparent,al_jsonparent)
	end if
end if


ll_child = tv_1.finditem(childtreeitem!,al_handle)
//ls_file = "debug.log"
//filedelete(ls_file)
//ll_file = fileopen(ls_file,textmode!,write!,shared!)
//存在子节点
if ll_child <> -1 then
	tv_1.getitem(ll_child,ltrv_2)
	ls_label = ltrv_2.label
	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
	if ltrv_2.children then
		//存在子节点
		if pos(ls_label,'objectitem') > 0 then
			if ll_rtn = -1 then
				ll_jsonchild2 = ijs_gen.additemobject( al_jsonchild)
			else
				ll_jsonchild2 = ijs_gen.additemobject( al_jsonchild,ls_tmp[1])
			end if
		else
			if ll_rtn = -1 then
				ll_jsonchild2 = ijs_gen.additemarray( al_jsonchild)
			else
				ll_jsonchild2 = ijs_gen.additemarray( al_jsonchild,ls_tmp[1])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(al_jsonchild)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson_new(ll_child,al_jsonchild,ll_jsonchild2)
	else
		//不存在子节点
		if ll_rtn = -1 then
			if isnumber(ls_label) then
				ijs_gen.additemnumber(al_jsonchild,dec(ls_label))
			else
				ijs_gen.additemstring(al_jsonchild,ls_label)
			end if
		else
			if isnumber(ls_tmp[2]) then
				ijs_gen.additemnumber(al_jsonchild,ls_tmp[1],dec(ls_tmp[2]))
			else
				ijs_gen.additemstring(al_jsonchild,ls_tmp[1],ls_tmp[2])
			end if
		end if
		ls_log += ls_label+" additemhandle = "+string(al_jsonchild)+"~r~n"
		filewriteex(il_file,ls_log)
		wf_treetojson_new(ll_child,al_jsonchild,al_jsonchild)
	end if
end if


////查找兄弟节点
//ll_next = tv_1.finditem(nexttreeitem!,al_handle)
//
////存在兄弟
//if ll_next <> -1 then
//	tv_1.getitem(ll_next,ltrv_1)
//	ls_label = ltrv_1.label
//	ll_rtn = wf_keyvalue(ls_label,ls_tmp)
//	if ltrv_1.children then
//		//存在子节点
//		if pos(ls_label,'objectitem') > 0 then
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemobject( al_jsonpar,ls_tmp[1])
//			end if
//			ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		else
//			if ll_rtn = -1 then
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar)
//			else
//				ll_jsonchild = ijs_gen.additemarray( al_jsonpar,ls_tmp[1])
//			end if	
//		end if
//		ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		filewriteex(il_file,ls_log)
//		wf_treetojson(ll_next,ll_jsonchild)
//	else
//		//不存在子节点
//		if ll_rtn = -1 then
//			if isnumber(ls_label) then
//				ijs_gen.additemnumber(al_jsonpar,dec(ls_label))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_label)
//			end if
//		else
//			if isnumber(ls_tmp[2]) then
//				ijs_gen.additemnumber(al_jsonpar,ls_tmp[1],dec(ls_tmp[2]))
//			else
//				ijs_gen.additemstring(al_jsonpar,ls_tmp[1],ls_tmp[2])
//			end if
//		end if
//		ls_log += ls_label+" additemhandle = "+string(al_jsonpar)+"~r~n"
//		filewriteex(il_file,ls_log)
//		wf_treetojson(ll_next,al_jsonparent)
//	end if
//end if

//fileclose(ll_file)

return  1
end function

on w_json_integration.create
int iCurrent
call super::create
this.cbx_2=create cbx_2
this.dw_1=create dw_1
this.cb_12=create cb_12
this.cbx_1=create cbx_1
this.cb_10=create cb_10
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.tv_1=create tv_1
this.cb_6=create cb_6
this.p_1=create p_1
this.cb_5=create cb_5
this.mle_2=create mle_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_12
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cb_10
this.Control[iCurrent+6]=this.sle_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_9
this.Control[iCurrent+9]=this.cb_8
this.Control[iCurrent+10]=this.cb_7
this.Control[iCurrent+11]=this.tv_1
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.p_1
this.Control[iCurrent+14]=this.cb_5
this.Control[iCurrent+15]=this.mle_2
this.Control[iCurrent+16]=this.cb_4
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.mle_1
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
end on

on w_json_integration.destroy
call super::destroy
destroy(this.cbx_2)
destroy(this.dw_1)
destroy(this.cb_12)
destroy(this.cbx_1)
destroy(this.cb_10)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.tv_1)
destroy(this.cb_6)
destroy(this.p_1)
destroy(this.cb_5)
destroy(this.mle_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;ijs_par = create jsonparser
ijs_gen = create jsongenerator


mle_2.text =  ' &
{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
}'
end event

type cbx_2 from checkbox within w_json_integration
integer x = 1111
integer y = 984
integer width = 590
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "PictureAsString"
end type

type dw_1 from datawindow within w_json_integration
integer y = 2324
integer width = 4005
integer height = 804
integer taborder = 130
string title = "none"
string dataobject = "d_customer"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_12 from commandbutton within w_json_integration
integer x = 37
integer y = 2140
integer width = 457
integer height = 132
integer taborder = 120
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "JsonToDW"
end type

event clicked;long ll_root,ll_handle,ll_count,ll_child,ll_loop,ll_object,ll_count2,ll_loop2,ll_child2
integer li_id
boolean lb_value
double ld_value
string ls_json,ls_value,ls_key
jsonitemtype ljs_type

//// Profile sqlserver102 database: en_sql2000
//SQLCA.DBMS = "ODBC"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = "ConnectString='DSN=sqlserver102;UID=sa;PWD=admin'"
//
//connect;

ll_root = ijs_par.getrootitem( )
ll_count = ijs_par.getchildcount( ll_root)
if ll_count <= 0 then
	messagebox("Error","JsonParser对象，未包含有效的json")
	return
end if

ljs_type = ijs_par.getitemtype( ll_root)
if ljs_type = jsonobjectitem! then
	return
else

//将json数据输出到datawindow
for ll_loop = 1 to ll_count
	dw_1.insertrow(0)
	ll_child = ijs_par.getchilditem( ll_root, ll_loop)
	ll_count2 =  ijs_par.getchildcount( ll_child)
	for ll_loop2 = 1 to ll_count2
		ll_child2 = ijs_par.getchilditem( ll_child, ll_loop2)
		ljs_type = ijs_par.getitemtype(ll_child2)
		ls_key = ijs_par.getchildkey( ll_child,ll_loop2)
		choose case ljs_type
			case jsonstringitem!
				ls_value = ijs_par.getitemstring(ll_child2)				
				dw_1.setitem(ll_loop,ls_key,ls_value)
			case jsonbooleanitem!
				lb_value = ijs_par.getitemboolean(ll_child2)
				dw_1.setitem(ll_loop,ls_key,string(lb_value))				
			case jsonnumberitem!
				ls_value = string(ijs_par.getitemnumber(ll_child2))
				ld_value = ijs_par.getitemnumber(ll_child2)
				dw_1.setitem(ll_loop,ls_key,ld_value)				
			case jsonnullitem!
				ls_value = "null"
				dw_1.setitem(ll_loop,ls_key,ls_value)				
		end choose
	next
next
end if

end event

type cbx_1 from checkbox within w_json_integration
integer x = 1125
integer y = 712
integer width = 480
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "FileAsString"
end type

type cb_10 from commandbutton within w_json_integration
integer x = 1609
integer y = 840
integer width = 457
integer height = 132
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;mle_2.text =  ' &
{"name":"中国", "province":[ { "name":"黑龙江", "cities":{ "city":["哈尔滨","大庆"] }},&
{"name":"广东", "cities":{ "city":["深圳","广州","珠海"] }}] &
}'
mle_1.text = ''

tv_1.deleteitem(1)

dw_1.reset()
end event

type sle_1 from singlelineedit within w_json_integration
integer x = 23
integer y = 1684
integer width = 485
integer height = 132
integer taborder = 110
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Testitem"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_json_integration
integer x = 23
integer y = 1576
integer width = 480
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Label"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within w_json_integration
integer x = 18
integer y = 1852
integer width = 498
integer height = 132
integer taborder = 110
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Additem"
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

type cb_8 from commandbutton within w_json_integration
integer x = 1609
integer y = 688
integer width = 457
integer height = 132
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clear"
end type

event clicked;mle_2.text = ''
mle_1.text = ''
end event

type cb_7 from commandbutton within w_json_integration
integer x = 18
integer y = 1408
integer width = 498
integer height = 132
integer taborder = 100
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "TreeToJson"
end type

event clicked;treeviewitem ltrv_root
long ll_root,ll_handle
string ls_json,ls_file
ll_root = tv_1.finditem( roottreeitem!, 0)

tv_1.getitem(ll_root,ltrv_root)
ls_file = "debug.log"
filedelete(ls_file)
il_file = fileopen(ls_file,textmode!,write!,shared!,append!)
if ltrv_root.label = "objectitem" then
	ll_handle = ijs_gen.createjsonobject( )
else
	ll_handle = ijs_gen.createjsonarray( )
end if

//wf_treetojson(ll_root,ll_handle)
wf_treetojson_new(ll_root,ll_handle,ll_handle)

ls_json = ijs_gen.getjsonstring( )

mle_1.text = ls_json
//mle_2.text = ls_json

fileclose(il_file)
end event

type tv_1 from treeview within w_json_integration
integer x = 539
integer y = 1172
integer width = 1545
integer height = 1128
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"ArrangeIcons!","ArrangeTables5!","ArrangeTables!","UserObject_icon_2!"}
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

type cb_6 from commandbutton within w_json_integration
integer x = 18
integer y = 1256
integer width = 498
integer height = 132
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GenerateTree"
end type

event clicked;string ls_output
long ll_handle,ll_root
jsonitemtype ljs_type
treeviewitem ltrv_1
ls_output = ijs_par.loadstring( mle_2.text)

if len(trim(ls_output)) >  0 then
	messagebox("LoadString Failed",mle_2.text+"~r~n"+ls_output)
	return
end if
//init tree
tv_1.deleteitem(1)

ll_root = ijs_par.getrootitem( )

ljs_type = ijs_par.getitemtype( ll_root)
//ltrv_1.label = "Root"
//ltrv_1.pictureindex = 1
//ll_handle = tv_1.insertitemlast(0,ltrv_1)
if ljs_type = jsonobjectitem! then
	//wf_parser_json(ll_root,false,ll_handle,'')
	wf_parser_json(ll_root,false,0,'')
elseif  ljs_type = jsonarrayitem! then
	//wf_parser_json(ll_root,true,ll_handle,'')
	wf_parser_json(ll_root,true,0,'')
end if

tv_1.expandall(1)
end event

type p_1 from picture within w_json_integration
integer x = 544
integer y = 720
integer width = 567
integer height = 420
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_json_integration
integer x = 32
integer y = 972
integer width = 462
integer height = 132
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "LoadPicture"
end type

event clicked;//通过generator加载图片,并通过parser对象加载，读取到picture控件中
long ll_file,ll_object,ll_rtn,ll_root
string ls_file,ls_path,ls_json,ls_data,ls_val
blob lb_data,lb_par
jsongenerator  ljs_gen
jsonparser ljs_par
nvo_base64  lnvo_base
ljs_par = create jsonparser
ljs_gen = create jsongenerator
//lnvo_base = create nvo_base64
ll_object = ljs_gen.createjsonobject( )

ll_rtn = getfileopenname("Select Picture File",ls_path,ls_file,"BMP","Picture file(*.bmp;*.png;*.jpg),*.bmp;*.png;*.jpg")
if ll_rtn > 0 then
	if not cbx_2.checked then
		//read file to blob
		ll_file = fileopen(ls_path,textmode!,read!,shared!)
		filereadex(ll_file,lb_data)
		fileclose(ll_file)
		ljs_gen.additemblob( ll_object, "picture", lb_data)
	//	if ljs_gen.isjsonvalid( ) then
	//		messagebox("","valid")
	//	else
	//		messagebox("","not valid")
	//	end if
		ijs_gen = ljs_gen
	//	
	//	if ijs_gen.isjsonvalid( ) then
	//		messagebox("","valid")
	//	else
	//		messagebox("","not valid")
	//	end if
		ls_json = ijs_gen.getjsonstring( )
		mle_2.text = ls_json
		mle_1.text = ls_json
		ljs_par.loadstring( ls_json)
		ll_root = ljs_par.getrootitem( )
		lb_par = ljs_par.getitemblob( ll_root,'picture')
		p_1.setpicture( lb_par)
	else
		ll_file = fileopen(ls_path,textmode!,read!,shared!)
		filereadex(ll_file,lb_par)
		fileclose(ll_file)
		ls_data = lnvo_base.base64encode(lb_par)
		ljs_gen.additemstring(ll_object,"picture",ls_data)
		ijs_gen = ljs_gen
		ls_json = ijs_gen.getjsonstring( )
		mle_2.text = ls_json
		mle_1.text = ls_json
		ljs_par.loadstring( ls_json)
		ll_root = ljs_par.getrootitem( )
		ls_val = ljs_par.getitemstring( ll_root,'picture')
		p_1.setpicture( lnvo_base.base64decode(ls_val))
	end if
end if





end event

type mle_2 from multilineedit within w_json_integration
integer x = 535
integer y = 116
integer width = 1527
integer height = 532
integer taborder = 60
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

type cb_4 from commandbutton within w_json_integration
integer x = 32
integer y = 748
integer width = 462
integer height = 132
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GenerateFile"
end type

event clicked;string ls_file,ls_path
long ll_rtn
string ls_output

//if ijs_gen.isjsonvalid( ) then
//	
//else
//	messagebox("Error","jsongenerator is not a valid json string")
//	return
//end if

ll_rtn = getfilesavename("Save Jsonstring to file",ls_path,ls_file,"*.*","All File(*.*),*.*")

if ll_rtn > 0 then
	ls_output = string(ijs_gen.savetofile( ls_path))
	mle_1.text = "Return of Savetofile("+ls_path+") = "+ls_output
end if
end event

type cb_3 from commandbutton within w_json_integration
integer x = 32
integer y = 536
integer width = 457
integer height = 132
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GenerateStr"
end type

event clicked;//将jsonparser转化为字符串
long ll_root,ll_handle,ll_count
string ls_json
jsonitemtype ljs_type
ll_root = ijs_par.getrootitem( )
ll_count = ijs_par.getchildcount( ll_root)
if ll_count <= 0 then
	messagebox("Error","JsonParser对象，未包含有效的json")
	return
end if
ljs_type = ijs_par.getitemtype( ll_root)
if ljs_type = jsonobjectitem! then
	ll_handle = ijs_gen.createjsonobject()
	//wf_parsertostring(ll_root,false,'',ijs_gen,ll_handle)
	wf_genstring(ll_root,false,'',ll_handle)
elseif  ljs_type = jsonarrayitem! then
	ll_handle = ijs_gen.createjsonarray()
	//wf_parsertostring(ll_root,true,'',ijs_gen,ll_handle)
	wf_genstring(ll_root,true,'',ll_handle)
end if
ls_json = ijs_gen.getjsonstring( )
mle_1.text += "getjsonstring = "+ls_json
mle_2.text = ls_json
end event

type cb_2 from commandbutton within w_json_integration
integer x = 32
integer y = 320
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "LoadFile"
end type

event clicked;string ls_file,ls_rtn,ls_path,ls_json
long ll_return,ll_handle,ll_root,ll_file
jsonitemtype ljs_type

ll_return = getfileopenname("Select Json File",ls_path,ls_file,"*.*","All File(*.*),*.*")

//根据所选文件来指定datawindow的dataobject
choose case ls_file
	case 'customer_json.txt'
		dw_1.dataobject = 'd_customer'
	case 'customers_json.txt'
		dw_1.dataobject = 'd_customers'
end choose

if ll_return > 0 then
	if not cbx_1.checked then
		ls_rtn = ijs_par.loadfile(ls_file)
		if ls_rtn = '' then
			mle_1.text = "LoadFile("+ls_file+") Succeed~r~n"
		else
			mle_1.text = "LoadFile("+ls_file+") Failed:"+ls_rtn+"~r~n"
		end if
	else
		//unicode 的json文件，以字符串方式读取
		ll_file = fileopen(ls_path,streammode!,read!,shared!)
		fileread(ll_file,ls_json)
		ls_rtn = ijs_par.loadstring(ls_json)
		if ls_rtn = '' then
			mle_1.text = "Loadstring("+ls_json+") Succeed~r~n"
		else
			mle_1.text = "LoadString("+ls_json+") Failed:"+ls_rtn+"~r~n"
		end if
		fileclose(ll_file)
	end if
	ll_root = ijs_par.getrootitem( )
	ljs_type = ijs_par.getitemtype( ll_root)
	if ljs_type = jsonobjectitem! then
		ll_handle = ijs_gen.createjsonobject()
		wf_parsertostring(ll_root,false,'',ijs_gen,ll_handle)
		//wf_genstring(ll_root,false,'',ll_handle)
	elseif  ljs_type = jsonarrayitem! then
		ll_handle = ijs_gen.createjsonarray()
		wf_parsertostring(ll_root,true,'',ijs_gen,ll_handle)
		//wf_genstring(ll_root,true,'',ll_handle)
	end if
	ls_json = ijs_gen.getjsonstring( )
	mle_1.text += "getjsonstring = "+ls_json
	mle_2.text = ls_json
end if

end event

type cb_1 from commandbutton within w_json_integration
integer x = 32
integer y = 120
integer width = 457
integer height = 132
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "LoadString"
end type

event clicked;string ls_output
ls_output = ijs_par.loadstring( mle_2.text)

if ls_output = '' then
	mle_1.text = "Loadstring("+mle_2.text+") Succeed. "
else
	mle_1.text = "Loadstring("+mle_2.text+") Failed: "+ls_output
end if
end event

type mle_1 from multilineedit within w_json_integration
integer x = 2130
integer y = 88
integer width = 1842
integer height = 2200
integer taborder = 30
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

type gb_1 from groupbox within w_json_integration
integer width = 2098
integer height = 2312
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Load"
end type

type gb_2 from groupbox within w_json_integration
integer x = 2117
integer y = 8
integer width = 1870
integer height = 2300
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "OutPut"
end type

