$PBExportHeader$uo_json_share.sru
forward
global type uo_json_share from userobject
end type
type mle_1 from multilineedit within uo_json_share
end type
end forward

shared variables
//定义共享变量调用
jsonparser ijs_par
jsongenerator ijs_gen
end variables

global type uo_json_share from userobject
integer width = 1189
integer height = 756
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
mle_1 mle_1
end type
global uo_json_share uo_json_share

type variables
string ls_test
end variables

forward prototypes
public subroutine uf_output ()
public subroutine uf_setvalue (ref jsonparser ajs_par, ref jsongenerator ajs_gen)
public subroutine uf_destroy ()
end prototypes

public subroutine uf_output ();//输出jsonparser对象
//jsonparser简单测试字符串形式
long ll_root,ll_count,ll_handle,ll_object,ll_item
string ls_key,ls_jsonparser,ls_jsongenerator,ls_value
jsonitemtype ljs_type
jsongenerator ljs_gen
ljs_gen = create jsongenerator
if not isvalid(ijs_par) then
	mle_1.text = "对象未实例化"
	return
end if
ll_root = ijs_par.getrootitem( )
ll_count = ijs_par.getchildcount(ll_root)
ll_object = ljs_gen.createjsonobject()

for ll_item = 1 to ll_count
	ls_key = ijs_par.getchildkey( ll_root, ll_item)
	ll_handle = ijs_par.getchilditem( ll_root,ll_item)
	ljs_type = ijs_par.getitemtype(ll_handle)
	choose case ljs_type
		case jsonnumberitem!
			ls_value =string(ijs_par.getitemnumber( ll_handle))
			ljs_gen.additemnumber( ll_object,ls_key, dec(ls_value))
		case jsonstringitem!
			ls_value = ijs_par.getitemstring( ll_handle)
			ljs_gen.additemstring( ll_object,ls_key, ls_value)
		case else
			//
	end choose
next
ls_jsonparser = ljs_gen.getjsonstring( )

//输出jsongenerator对象
ls_jsongenerator = ijs_gen.getjsonstring()

mle_1.text = "jsonparser:~r~n"+ls_jsonparser+"~r~n"+"jsongenerator:~r~n"+ls_jsongenerator
end subroutine

public subroutine uf_setvalue (ref jsonparser ajs_par, ref jsongenerator ajs_gen);//将jsonparser和jsongenerator赋值给共享变量

ijs_par = ajs_par
ijs_gen = ajs_gen
end subroutine

public subroutine uf_destroy ();destroy ijs_par
destroy ijs_gen
end subroutine

on uo_json_share.create
this.mle_1=create mle_1
this.Control[]={this.mle_1}
end on

on uo_json_share.destroy
destroy(this.mle_1)
end on

event constructor;//ijs_gen = create jsongenerator
//ijs_par = create jsonparser
end event

event destructor;//ijs_gen = create jsongenerator
//ijs_par = create jsonparser

//destroy ijs_gen
//destroy ijs_par
end event

type mle_1 from multilineedit within uo_json_share
integer x = 82
integer y = 32
integer width = 960
integer height = 532
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

