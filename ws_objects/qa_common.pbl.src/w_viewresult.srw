$PBExportHeader$w_viewresult.srw
forward
global type w_viewresult from w_base
end type
type cb_3 from commandbutton within w_viewresult
end type
type cb_2 from commandbutton within w_viewresult
end type
type cb_1 from commandbutton within w_viewresult
end type
type mle_2 from multilineedit within w_viewresult
end type
type mle_1 from multilineedit within w_viewresult
end type
type gb_1 from groupbox within w_viewresult
end type
type gb_2 from groupbox within w_viewresult
end type
end forward

global type w_viewresult from w_base
integer width = 3776
integer height = 1888
string title = "ViewResult"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_2 mle_2
mle_1 mle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_viewresult w_viewresult

type variables
string is_real,is_exp
end variables

forward prototypes
public subroutine wf_getvalue ()
end prototypes

public subroutine wf_getvalue ();//获取期望值和实际值
long ll_exp,ll_real
string ls_exp,ls_real
ll_real = fileopen(is_real,textmode!,read!)
filereadex(ll_real,ls_real)
mle_1.text = ls_real
fileclose(ll_real)


ll_exp = fileopen(is_exp,textmode!,read!)
filereadex(ll_exp,ls_exp)
mle_2.text = ls_exp
fileclose(ll_exp)
end subroutine

on w_viewresult.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_2=create mle_2
this.mle_1=create mle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.mle_2
this.Control[iCurrent+5]=this.mle_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_viewresult.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_2)
destroy(this.mle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;string ls_message
ls_message = message.stringparm
is_real = mid(ls_message,pos(ls_message,",")+1)
is_exp = mid(ls_message,1,pos(ls_message,",") - 1)

wf_getvalue()
end event

type cb_3 from commandbutton within w_viewresult
integer x = 2318
integer y = 1636
integer width = 457
integer height = 128
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_viewresult
integer x = 1577
integer y = 1640
integer width = 457
integer height = 128
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Compare"
end type

event clicked;//使用compare工具比较期望值
string ls_run,ls_beyond,ls_key[]
long ll_rtn
ls_run = "C:\Program Files\Beyond~~1"

ll_rtn = Registryget("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\BeyondCompare.Snapshot\shell\open\command","",regstring!,ls_beyond)

if pos(ls_beyond,"%1") > 0 then
	ls_beyond = mid(ls_beyond,1,pos(ls_beyond,"%1") - 2)
end if

//run("~""+ls_run+"\BCompare.exe~" "+"~""+is_real+"~" "+"~""+is_exp+"~"")

run(ls_beyond +' "'+is_real+'" "'+is_exp+'"')


end event

type cb_1 from commandbutton within w_viewresult
integer x = 791
integer y = 1640
integer width = 457
integer height = 128
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Updateexp"
end type

event clicked;//update expvalue

if messagebox("Question","Are you sure to update expvale?",question!,yesno!,1) = 2 then return
long ll_exp
string ls_exp
ls_exp = mle_1.text
ll_exp = fileopen(is_exp,textmode!,write!,shared!,replace!,encodingutf8!)
filewriteex(ll_exp,ls_exp)
mle_2.text = ls_exp
fileclose(ll_exp)
end event

type mle_2 from multilineedit within w_viewresult
integer x = 1870
integer y = 96
integer width = 1851
integer height = 1472
integer taborder = 30
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

type mle_1 from multilineedit within w_viewresult
integer x = 18
integer y = 92
integer width = 1787
integer height = 1484
integer taborder = 20
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

type gb_1 from groupbox within w_viewresult
integer width = 1829
integer height = 1608
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "RealValue"
end type

type gb_2 from groupbox within w_viewresult
integer x = 1833
integer y = 20
integer width = 1906
integer height = 1592
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ExpectValue"
end type

