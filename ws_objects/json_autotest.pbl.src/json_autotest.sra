$PBExportHeader$json_autotest.sra
$PBExportComments$Generated Application Object
forward
global type json_autotest from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
jsongenerator gjs_gen
jsonparser gjs_par
end variables
global type json_autotest from application
string appname = "json_autotest"
end type
global json_autotest json_autotest

type variables
transaction itr_1
end variables

on json_autotest.create
appname="json_autotest"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on json_autotest.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gjs_gen = create jsongenerator
gjs_par = create jsonparser


open(w_json_auto)


end event

event systemerror;messagebox("Error",error.text)
end event

