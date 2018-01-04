$PBExportHeader$w_tmp.srw
forward
global type w_tmp from window
end type
type mle_1 from multilineedit within w_tmp
end type
end forward

global type w_tmp from window
integer width = 1440
integer height = 840
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
end type
global w_tmp w_tmp

type variables
jsonparser ijs_par
end variables

on w_tmp.create
this.mle_1=create mle_1
this.Control[]={this.mle_1}
end on

on w_tmp.destroy
destroy(this.mle_1)
end on

event open;jsonparser ljs_par
jsonitemtype ljs_type
long ll_count,ll_root,ll_item,ll_handle,ll_value
string ls_value,ls_key
string ls_output

ljs_par = message.powerobjectparm
ll_root = ljs_par.getrootitem( )

ll_count = ljs_par.getchildcount(ll_root)

for ll_item = 1 to ll_count
	ls_key = ljs_par.getchildkey( ll_root, ll_item)
	ll_handle = ljs_par.getchilditem( ll_root,ll_item)
	ljs_type = ljs_par.getitemtype(ll_handle)
	choose case ljs_type
		case jsonnumberitem!
			ls_value =string(ljs_par.getitemnumber( ll_handle))
			ls_output+='"'+ls_key+'":'+ls_value+","
		case jsonstringitem!
			ls_value = ljs_par.getitemstring( ll_handle)
			ls_output +='"'+ls_key+'":"'+ls_value+"123~","
		case else
			
	end choose
next

ls_output = left(ls_output,len(ls_output) - 1)
mle_1.text = "{"+ls_output+"}"
timer(0.5)

end event

event timer;//closewithreturn(this,)
jsonparser ljs_par
ljs_par = create jsonparser
ljs_par.loadstring(mle_1.text)
closewithreturn(this,ljs_par)
end event

type mle_1 from multilineedit within w_tmp
integer x = 18
integer y = 28
integer width = 1394
integer height = 524
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

