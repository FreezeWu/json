$PBExportHeader$nvo_jsongen.sru
forward
global type nvo_jsongen from jsongenerator
end type
end forward

global type nvo_jsongen from jsongenerator
end type
global nvo_jsongen nvo_jsongen

on nvo_jsongen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_jsongen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

