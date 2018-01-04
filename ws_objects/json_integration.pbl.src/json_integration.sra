$PBExportHeader$json_integration.sra
$PBExportComments$Generated Application Object
forward
global type json_integration from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
nvo_jsonpar gjs_par
nvo_jsongen gjs_gen
//使用全局变量标志

boolean gb_glob
end variables

global type json_integration from application
string appname = "json_integration"
end type
global json_integration json_integration

on json_integration.create
appname="json_integration"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on json_integration.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//读取配置文件
string ls_glob
ls_glob = profilestring("json_integration.ini","jsonobject","glob","")
if lower(ls_glob) = "true" then  gb_glob = true
gjs_par = create nvo_jsonpar
gjs_gen = create nvo_jsongen



open(w_json_integration_new)

end event

