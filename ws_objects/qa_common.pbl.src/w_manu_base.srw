$PBExportHeader$w_manu_base.srw
forward
global type w_manu_base from w_base
end type
type cb_3 from commandbutton within w_manu_base
end type
type cb_2 from commandbutton within w_manu_base
end type
type cb_1 from commandbutton within w_manu_base
end type
type mle_parm from multilineedit within w_manu_base
end type
type lb_data from listbox within w_manu_base
end type
type ddlb_parm from dropdownlistbox within w_manu_base
end type
type mle_desc from multilineedit within w_manu_base
end type
type mle_output from multilineedit within w_manu_base
end type
type lb_fun from listbox within w_manu_base
end type
type gb_1 from groupbox within w_manu_base
end type
type gb_2 from groupbox within w_manu_base
end type
type gb_3 from groupbox within w_manu_base
end type
type gb_4 from groupbox within w_manu_base
end type
type gb_5 from groupbox within w_manu_base
end type
end forward

global type w_manu_base from w_base
integer width = 4197
integer height = 2344
string title = "Manu_integration"
windowstate windowstate = maximized!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_parm mle_parm
lb_data lb_data
ddlb_parm ddlb_parm
mle_desc mle_desc
mle_output mle_output
lb_fun lb_fun
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global w_manu_base w_manu_base

type variables
string is_funlist,is_parmlist
end variables

forward prototypes
public subroutine wf_setflag ()
public subroutine wf_output (string as_msg, boolean ab_clear)
public subroutine wf_desc (string as_desc)
public function integer wf_additem (string as_list, powerobject ap_object)
public subroutine wf_init ()
public subroutine wf_scriptexe (integer ai_item)
end prototypes

public subroutine wf_setflag ();//设置控件的resize逻辑
ieon_resize.of_setflag(gb_1,"0002")
ieon_resize.of_setflag(lb_fun,"0002")

ieon_resize.of_setflag(gb_4,"0000")
ieon_resize.of_setflag(gb_5,"0002")
ieon_resize.of_setflag(ddlb_parm,"0000")
ieon_resize.of_setflag(lb_data,"0000")
ieon_resize.of_setflag(mle_parm,"0002")

ieon_resize.of_setflag(cb_1,"0200")
ieon_resize.of_setflag(cb_2,"0200")
ieon_resize.of_setflag(cb_3,"0200")

ieon_resize.of_setflag(gb_3,"0020")
ieon_resize.of_setflag(mle_desc,"0020")

ieon_resize.of_setflag(gb_2,"0200")
ieon_resize.of_setflag(mle_output,"0200")

end subroutine

public subroutine wf_output (string as_msg, boolean ab_clear);//输出output

if ab_clear then
	mle_output.text = ''	
end if
mle_output.text += as_msg+"~r~n"
end subroutine

public subroutine wf_desc (string as_desc);//输出测试点的描述信息或备注
mle_desc.text = as_desc+"~r~n"
end subroutine

public function integer wf_additem (string as_list, powerobject ap_object);//将相应的数据插入到ddlb或lb
long  ll_loop,ll_item,ll_int
string ls_item[]
listbox lb_tmp
dropdownlistbox  lddlb_tmp

//将数据转化为数组
ieon_resize.of_stringtoarray( as_list, ls_item,",")

choose case ap_object.typeof()
	case listbox!
		lb_tmp = ap_object
		lb_tmp.reset()
		for ll_loop = 1 to upperbound(ls_item)
			lb_tmp.additem(ls_item[ll_loop])
		next
	case dropdownlistbox!
		lddlb_tmp = ap_object
		lddlb_tmp.reset()
		for ll_loop = 1 to upperbound(ls_item)
			lddlb_tmp.additem(ls_item[ll_loop])
		next
end choose

return 1



end function

public subroutine wf_init ();//用来初始化信息

//初始化函数列表,多个函数通过逗号分割
is_funlist = "test1,test2,test3"
wf_additem(is_funlist,lb_fun)


//初始化新加对象的resize逻辑
end subroutine

public subroutine wf_scriptexe (integer ai_item);// 执行测试点，需要在子窗体重写
string ls_item,ls_value
if ai_item <= 0 then return

ls_item = lb_fun.text(ai_item)
wf_output("Begin "+ls_item,true)
choose case ls_item
	case "test1"
		//举例测试classname
		ls_value = this.classname( )
		wf_output("this.classname() = "+ls_value,false)
	case else
		messagebox("Info","测试点"+ls_item+"没有维护代码")
end choose
end subroutine

on w_manu_base.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_parm=create mle_parm
this.lb_data=create lb_data
this.ddlb_parm=create ddlb_parm
this.mle_desc=create mle_desc
this.mle_output=create mle_output
this.lb_fun=create lb_fun
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.mle_parm
this.Control[iCurrent+5]=this.lb_data
this.Control[iCurrent+6]=this.ddlb_parm
this.Control[iCurrent+7]=this.mle_desc
this.Control[iCurrent+8]=this.mle_output
this.Control[iCurrent+9]=this.lb_fun
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_5
end on

on w_manu_base.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_parm)
destroy(this.lb_data)
destroy(this.ddlb_parm)
destroy(this.mle_desc)
destroy(this.mle_output)
destroy(this.lb_fun)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event open;call super::open;lb_fun.sorted = false

//初始化数据
wf_init()
end event

type cb_3 from commandbutton within w_manu_base
integer x = 2254
integer y = 1452
integer width = 457
integer height = 128
integer taborder = 100
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clear"
end type

event clicked;mle_output.text = ''
end event

type cb_2 from commandbutton within w_manu_base
integer x = 1769
integer y = 1452
integer width = 457
integer height = 128
integer taborder = 90
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Execute"
end type

event clicked;integer  li_item

li_item = lb_fun.selectedindex( )

wf_scriptexe(li_item)
end event

type cb_1 from commandbutton within w_manu_base
integer x = 1285
integer y = 1452
integer width = 457
integer height = 128
integer taborder = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Set"
end type

type mle_parm from multilineedit within w_manu_base
integer x = 1289
integer y = 1216
integer width = 1454
integer height = 236
integer taborder = 70
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

type lb_data from listbox within w_manu_base
integer x = 1289
integer y = 192
integer width = 1454
integer height = 912
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 0 then return

mle_parm.text = this.text(index)

cb_1.triggerevent( clicked!)
end event

type ddlb_parm from dropdownlistbox within w_manu_base
integer x = 1289
integer y = 76
integer width = 1454
integer height = 540
integer taborder = 50
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

type mle_desc from multilineedit within w_manu_base
integer x = 2798
integer y = 72
integer width = 1330
integer height = 460
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

type mle_output from multilineedit within w_manu_base
integer x = 14
integer y = 1684
integer width = 2720
integer height = 524
integer taborder = 40
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

type lb_fun from listbox within w_manu_base
integer x = 18
integer y = 72
integer width = 1234
integer height = 1512
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ddlb_parm.reset()
lb_data.reset( )
//mle_parm.text = ''
end event

event doubleclicked;if index > 0 then
	wf_scriptexe(index)
end if
end event

type gb_1 from groupbox within w_manu_base
integer width = 1271
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
string text = "TestCase"
end type

type gb_2 from groupbox within w_manu_base
integer y = 1608
integer width = 2757
integer height = 620
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "OutPut"
end type

type gb_3 from groupbox within w_manu_base
integer x = 2766
integer width = 1385
integer height = 560
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Description"
end type

type gb_4 from groupbox within w_manu_base
integer x = 1280
integer width = 1481
integer height = 1140
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Parameter"
end type

type gb_5 from groupbox within w_manu_base
integer x = 1271
integer y = 1140
integer width = 1490
integer height = 468
integer taborder = 70
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "自定义参数"
end type

