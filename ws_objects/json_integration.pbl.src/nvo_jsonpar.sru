$PBExportHeader$nvo_jsonpar.sru
forward
global type nvo_jsonpar from jsonparser
end type
end forward

global type nvo_jsonpar from jsonparser
end type
global nvo_jsonpar nvo_jsonpar

on nvo_jsonpar.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_jsonpar.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

