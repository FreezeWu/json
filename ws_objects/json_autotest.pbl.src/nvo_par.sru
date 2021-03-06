﻿$PBExportHeader$nvo_par.sru
forward
global type nvo_par from jsonparser
end type
end forward

global type nvo_par from jsonparser
event ue_test ( )
end type
global nvo_par nvo_par

type variables
string is_event
string is_method,is_post
boolean ib_parm,ib_string,ib_long
end variables
forward prototypes
public subroutine of_event_destroy (string as_method)
public subroutine of_event_create (string as_method)
public function integer of_event (string as_event, string as_method, long al_word, string as_long)
end prototypes

event ue_test();//通过post或trigger触发自定义事件
string ls_tmp1,ls_tmp2

if lower(is_method) = 'post' then
	if not ib_parm then
		is_event = "ue_test is post!"
		w_json_auto.wf_output('lnvo_par.ue_test( "post") = '+this.is_event,false)
	else
		if ib_string then
			ls_tmp1 = string(message.wordparm)
			ls_tmp2 = string(message.longparm,"address")
		else
			ls_tmp1 = string(message.wordparm)
			ls_tmp2 = string(message.longparm)
		end if
		is_event = "wordparm="+ls_tmp1+";longparm="+ls_tmp2
		w_json_auto.wf_output('lnvo_par.ue_test( "post") = '+this.is_event,false)
	end if
elseif lower(is_method) = 'trigger' then
	if not ib_parm then
		is_event = "lnvo_par.ue_test is triggered!"
	else
		if ib_string then
			ls_tmp1 = string(message.wordparm)
			ls_tmp2 = string(message.longparm,"address")
		else
			ls_tmp1 = string(message.wordparm)
			ls_tmp2 = string(message.longparm)
		end if
		is_event = "lnvo_par.ue_test is triggered with parm : wordparm="+ls_tmp1+";longparm="+ls_tmp2
	end if
end if

end event

public subroutine of_event_destroy (string as_method);//通过post或trigger方式触发事件
is_method = as_method

if lower(as_method) = 'post' then
	//以字符串方式触发
	this.postevent( "constructor")
else
	//以枚举值方式触发
	this.triggerevent( constructor!)
end if
end subroutine

public subroutine of_event_create (string as_method);//通过post或trigger方式触发事件
is_method = as_method

if lower(as_method) = 'post' then
	//以字符串方式触发
	this.postevent( "constructor")
else
	//以枚举值方式触发
	this.triggerevent( constructor!)
end if
end subroutine

public function integer of_event (string as_event, string as_method, long al_word, string as_long);//通过post和trigger触发事件
is_method = as_method

//判断是否有参数
if al_word = 0 and as_long = "" then
	ib_parm = false
else
	ib_parm = true
	if len(as_long) > 0 then
		if isnumber(as_long) then
			ib_string = false
		else
			ib_string = true
		end if	
	end if
end if

if is_method = 'post' then
	//判断参数
	if not ib_parm then
		this.postevent( as_event)
	else
		if ib_string then
			this.postevent( as_event,al_word,as_long)
		else
			this.postevent( as_event,al_word,long(as_long))
		end if
	end if
else
	//判断参数
	if not ib_parm then
		this.triggerevent( as_event)
	else
		if ib_string then
			this.triggerevent( as_event,al_word,as_long)
		else
			this.triggerevent( as_event,al_word,long(as_long))
		end if
	end if
	
end if

return 1


end function

on nvo_par.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_par.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;if lower(is_method) = 'post' then
	is_event = "constructor is post!"
	w_json_auto.wf_output('lnvo_par.of_event_create( "post") = '+this.is_event,false)
elseif lower(is_method) = 'trigger' then
	is_event = "constructor is triggered!"
end if
end event

event destructor;if lower(is_method) = 'post' then
	is_event = "destructor is post!"
	w_json_auto.wf_output('lnvo_par.of_event_destroy( "post") = '+this.is_event,false)
elseif lower(is_method) = 'trigger' then
	is_event = "destructor is triggered!"
end if
end event

