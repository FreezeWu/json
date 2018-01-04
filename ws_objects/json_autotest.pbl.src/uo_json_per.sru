$PBExportHeader$uo_json_per.sru
forward
global type uo_json_per from userobject
end type
type cb_2 from commandbutton within uo_json_per
end type
type mle_1 from multilineedit within uo_json_per
end type
type em_1 from editmask within uo_json_per
end type
type st_1 from statictext within uo_json_per
end type
type cb_1 from commandbutton within uo_json_per
end type
end forward

global type uo_json_per from userobject
integer width = 1778
integer height = 1140
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_loadstring ( jsonparser ajs_par,  integer ai_index,  string as_json )
cb_2 cb_2
mle_1 mle_1
em_1 em_1
st_1 st_1
cb_1 cb_1
end type
global uo_json_per uo_json_per

type variables
jsonparser  ijs_par[10000]
string is_json
boolean ib_stop
end variables
forward prototypes
public subroutine uf_exe ()
end prototypes

event ue_loadstring(jsonparser ajs_par, integer ai_index, string as_json);// 加载json数据
string ls_json,ls_output
long ll_root,ll_count

if not isvalid(ajs_par) then
	ajs_par = create jsonparser
end if
ajs_par.loadstring(as_json)

ll_root = ajs_par.getrootitem()
ll_count = ajs_par.getchildcount(ll_root)

ls_output = "The ChildCount of jsonparser["+string(ai_index)+"] = "+string(ll_count)+"~r~n"

mle_1.text = ls_output + mle_1.text

end event

public subroutine uf_exe ();//
long ll_loop,ll_start,ll_end
string ls_json,ls_out
ll_start = cpu()
ls_json = gjs_gen.getjsonstring( )
for ll_loop = 1 to long(em_1.text)
	yield()
//	if not isvalid(ijs_par1[ll_loop]) then
//		ijs_par1[ll_loop] = create jsonparser
//	end if
	this.event ue_loadstring(ijs_par[ll_loop],ll_loop,ls_json)
	if ib_stop then
		exit
	end if
next
ib_stop = false
ll_end = cpu()
ls_out = string(ll_loop - 1)+" times loop，耗时:"+string(ll_end - ll_start)+" MS"
st_1.text = ls_out
end subroutine

on uo_json_per.create
this.cb_2=create cb_2
this.mle_1=create mle_1
this.em_1=create em_1
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.mle_1,&
this.em_1,&
this.st_1,&
this.cb_1}
end on

on uo_json_per.destroy
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within uo_json_per
integer x = 1253
integer y = 16
integer width = 457
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stop"
end type

event clicked;//if this.text = 'Stop' then
//	
//else
//	
//end if
ib_stop = true
end event

type mle_1 from multilineedit within uo_json_per
integer x = 32
integer y = 164
integer width = 1737
integer height = 864
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

type em_1 from editmask within uo_json_per
integer x = 658
integer y = 16
integer width = 457
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "1000"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_1 from statictext within uo_json_per
integer y = 1048
integer width = 1769
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_1 from commandbutton within uo_json_per
integer x = 32
integer y = 20
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "execute"
end type

event clicked;uf_exe()
end event

