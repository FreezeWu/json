$PBExportHeader$u_derek_fun.sru
$PBExportComments$ÏÄ×ÓÊ¡ÀËÉ³×¨ÓÃÓÃ»§¶ÔÏó
forward
global type u_derek_fun from nonvisualobject
end type
end forward

global type u_derek_fun from nonvisualobject autoinstantiate
end type

forward prototypes
public subroutine move (datawindow adw_control)
public function string replace (string as_text, string as_str1, string as_str2)
public function decimal power (decimal ad_num, integer ad_power)
public function any arraysort (any a[], readonly string as_sort)
public function decimal todec (string as_num, decimal ad_sys)
public function string hexstring (string as_text, readonly encoding ae_encode)
public function string decto (decimal ad_dec, readonly unsignedinteger aui_sys)
public function string urlencode (character as_text[], encoding ae_encode)
public function any getsep (string as_text, readonly string as_sep, unsignedinteger ai_end)
public function string hexdecode (character ac_text[], encoding ae_encode)
public function string hexencode (string as_text, readonly encoding ae_encode)
public function string urldecode (character as_text[], encoding ae_encode)
public function string createpath (string as_filepath)
end prototypes

public subroutine move (datawindow adw_control);
int x2,y2
//powerobject po_1
//po_1=adw_control
//do until typeof(po_1)=window!
//	po_1=po_1.getparent()
//loop
//window w_2
//w_2=po_1
//
//x2=w_2.PointerX ()
//y2=w_2.PointerY ()
//
//messagebox('',string(x2)+string(y2,'/###'))
//
//if w_2.PointerX () + adw_control.width > w_2.width then
//	x2=w_2.PointerX () - adw_control.width
//end if
//if w_2.PointerY () + adw_control.height > w_2.height then
//	y2=w_2.PointerY () - adw_control.height
//end if
//adw_control.bringtotop=true
//adw_control.move(x2,y2)
powerobject po_parent
po_parent=adw_control.getparent()
adw_control.bringtotop=true
adw_control.move(po_parent.dynamic pointerx(),po_parent.dynamic pointery())
end subroutine

public function string replace (string as_text, string as_str1, string as_str2);//×Ö·û´®Ìæ»»º¯Êý
//参数1:操作的字符串
//参数2:要替换的字符
//参数3:目标字符

int li_pos
int li_len1,li_len2
li_len1=len(as_str1)
li_len2=len(as_str2)
li_pos=Pos(as_text,as_str1,1)
do while(li_pos>0)
	as_text=Replace(as_text,li_pos,li_len1,as_str2)
	li_pos=Pos(as_text,as_str1,li_pos + li_len2 )
loop
return as_text
end function

public function decimal power (decimal ad_num, integer ad_power);//作用:得到数字的指定次方
//参数1:要操作的数字
//参数2:次方数
//说明:ad_power 只能是整数

//dec i 
//dec ld_result
//
//if ad_num=0 then //操作数为零时,返回值始终为0 
//	ld_result=0 
//	goto e
//end if
//
//if ad_power=0 then //次方为零时,返回值为1
//	ld_result=1
//	goto e
//else	//次方不等于零时
//	ld_result=ad_num
//	for i=2 to abs(ad_power) 
//		ld_result*=ad_num
//	next
//end if
//
//if ad_power<0 then ld_result=1 / ld_result	//次方小于零时,返回值为1 / 结果
//
//e:
//return ld_result

return ad_num^ad_power	//返回ad_num的ad_power次幂
end function

public function any arraysort (any a[], readonly string as_sort);//对一维数组进行排序
//参数1:要排序的数组
//参数2:升序:asc 否则为降序
//返回排序后的数组

any c[]
int i,m,n

for i=1 to upperbound(a)
	m=i
	for n=i + 1 to upperbound(a)
		if as_sort='asc'  then 
			if  a[m]>a[n] then m=n
		else
			if  a[m]<a[n] then m=n
		end if
	next
	c[i]=a[m] //记录值
	a[m]=a[i] //记录i处的值
next
return c


end function

public function decimal todec (string as_num, decimal ad_sys);//其它进制转10进制数字函数
//参数1:要转换的数字
//参数2:源进制
//说明:ad_sys只能为整数

dec ld_num,ld_num1
string  ls_num1
int i,li_sign=1
int li_pos,li_len,li_pointpos,li_maxpower,li_minpower

if isnull(as_num) or isnull(ad_sys)  then return 0

if dec(as_num)<0 then 	//是负数
	li_sign=-1	
	as_num=mid(as_num,1)	//去除负号
end if

li_len=len(as_num)

if li_len=1 then
	if as_num>'9' then	//如果是字符
		ld_num=asc(as_num) - 64 + 9
	else
		ld_num=dec(as_num)
	end if
	
else

	li_pointpos=pos(as_num,'.')	//点的位置
	
	if li_pointpos=0 then 
		li_maxpower=li_len - 1
		li_minpower=0
	else
		li_maxpower=li_pointpos - 2
		li_minpower= li_pointpos - li_len 
	end if

	li_pos=1
	for i=li_maxpower to li_minpower step -1
		if li_pos=li_pointpos then 	//位置到点的位置
			i ++
		else
			ls_num1=mid(as_num,li_pos,1)
			ld_num1=todec(ls_num1,ad_sys)
			ld_num=ld_num + (ld_num1  * (ad_sys^i) )
		end if
		li_pos++	//位置加1
	next
	
end if

return ld_num * li_sign
end function

public function string hexstring (string as_text, readonly encoding ae_encode);//将字符转换成16进制编码
//参数1:是要转换的字符
//参数2:源字符中编码
//返回16进制编码

return hexencode(as_text,ae_encode)
end function

public function string decto (decimal ad_dec, readonly unsignedinteger aui_sys);//作用:将十进制数字转成其它进制字符串
//参数1:十进制数字
//参数2:目标进制
string ls_ret	//返回的结果
string ls_dec
string ls_left,ls_right,ls_mod
uint ld_mod	/*余数为整数*/
dec ld_mul	//取小数的乘积为dec
int i,li_pos,li_len,li_pointpos,li_maxpower,li_minpower
if isnull(ad_dec) or isnull(aui_sys) or aui_sys<2 then goto e

ls_dec=string(ad_dec)
li_pointpos=pos(ls_dec,'.')

if li_pointpos=0 then 

	if ad_dec<aui_sys then	//大于10进制
		if ad_dec<=9 then
			ls_ret=string(ad_dec)
			goto e
		elseif ad_dec>9 and ad_dec<aui_sys then
			ls_ret=char(64 - 9 + ad_dec)		//大于9的数字为转换为字母
			goto e
		end if
	else
		do
			ld_mod=mod(ad_dec,aui_sys)	//取余数
			ls_mod=decto(ld_mod,aui_sys)
			ls_ret=ls_mod+ls_ret

			ad_dec=long(( ad_dec - ld_mod) / aui_sys )		//去余取商
			
		loop until ad_dec<aui_sys
		
		if ad_dec>9 then 
			ls_ret=char(64 - 9 + ad_dec)+ls_ret
		else
			ls_ret=string(ad_dec)+ls_ret
		end if
		
	end if
else
	ls_left=mid(ls_dec,1,li_pointpos)			//取整数
	ls_right=mid(ls_dec,li_pointpos)			//取小数
	ls_ret=decto(dec(ls_left),aui_sys)+'.'		//整数部分转换

	ld_mul=dec(ls_right)
	for i=1 to 10 	//最大精度为10
		ld_mul=ld_mul * aui_sys
		ls_ret=ls_ret+string(int(ld_mul))	//取整
		if ld_mul=int(ld_mul) then exit		//没有余数
		ld_mul=ld_mul - int(ld_mul)		//去除整数
	next

end if

e:
return ls_ret

end function

public function string urlencode (character as_text[], encoding ae_encode);//对中文字符进行url 编码
//参数1:要编码的字符串
//参数2:要以哪种字符集编码
char lc_ret[]
string ls_ret
int i,j,li_len
string ls_temp
for i=1 to upperbound(as_text)
	if asc(as_text[i])>19968 then
		ls_temp=hexencode(as_text[i],ae_encode)
		li_len=len(ls_temp)
		li_len=li_len + li_len / 2		//增加百分号以后长度会增加1/2
		for j=1 to  li_len step 3
			ls_temp=replace(ls_temp,j,0,'%')
		next
	else
		ls_temp=as_text[i]
	end if
	ls_ret+=ls_temp
next

return ls_ret
end function

public function any getsep (string as_text, readonly string as_sep, unsignedinteger ai_end);//得到分隔符分开后的数组
//参数1:要分隔的字符串
//参数2:分隔符
//参数3:获取到第几个

int li_pos1=0,li_pos2=0,i=1
string ls_ret[],ls_sql

if right(as_text,len(as_sep))<>as_sep then as_text=as_text+as_sep

if ai_end=0 then ai_end=65535

li_pos1=pos(as_text,as_sep,li_pos2 + 1)

do while(li_pos1>0 and i<=ai_end)
	ls_ret[i]=mid(as_text,li_pos2 + 1,li_pos1 - li_pos2 - 1)
	li_pos2=li_pos1
	li_pos1=pos(as_text,as_sep,li_pos2 + 1)
	i++
loop
//if i<=ai_end then 
//	ls_ret[i]=mid(as_text,li_pos2+1)
//end if
	
return ls_ret
end function

public function string hexdecode (character ac_text[], encoding ae_encode);
int i
byte lb_byte[]
blob lb_blob
char ls_result[]
u_derek_fun u_fun //用户对象其中todec 是其它进制转10进制的函数
for i=1 to upperbound(ac_text) / 2   
    lb_byte[i]=u_fun.todec(ac_text[2 * i - 1]+ac_text[2 * i],16)
next
lb_blob=blob(lb_byte)
ls_result=string(lb_blob,ae_encode)

return ls_result[]



////PB9 
//
//int i
//char lc_ret[]
//for i=1 to upperbound(ac_text) / 2 
//	lc_ret[i]=charA(todec(ac_text[2 * i - 1]+ac_text[2 * i],16))
//next
//clipboard(lc_ret)
//return lc_ret
end function

public function string hexencode (string as_text, readonly encoding ae_encode);//将字符转换成16进制编码
//参数1:是要转换的字符
//参数2:源字符中编码
//返回16进制编码
blob lb_text
blob{100} lb_stext
string ls_text2,ls_ret,ls_str1
uint i,li_len,li_asc
string ls_hex
//ls_text2=space(100)

//转换成编码encodingutf16BE
if len(as_text)<=50 then
	lb_stext=blob(as_text,ae_encode)
	ls_text2=string(lb_stext,encodingutf16Be!)
else
	lb_text=blob(as_text,ae_encode)
	ls_text2=string(lb_text,encodingutf16Be!)
end if

li_len=len(ls_text2)

for i=1 to li_len
	ls_str1=mid(ls_text2,i,1)
	li_asc=asc(ls_str1)
	ls_hex=decto(li_asc,16)
	
	////
	if ae_encode=encodingutf16BE! then	//高尾
		ls_hex=fill('0',4 - len(ls_hex))+ls_hex
		ls_ret=ls_ret+ls_hex
	elseif ae_encode=encodingutf16lE! then	//低尾
		ls_hex=fill('0',4 - len(ls_hex))+ls_hex
		ls_ret=ls_ret+ls_hex
	else
		if right(ls_hex,2)='00' then	ls_hex=left(ls_hex,2)
		ls_ret=ls_ret+ls_hex
	end if
next

return ls_ret
end function

public function string urldecode (character as_text[], encoding ae_encode);//对中文字符进行url 解码
//参数1:要解码的字符串
//参数2:要以哪种字符集解码

string ls_ret
int i 
string ls_str1

for i=1 to upperbound(as_text)
	if as_text[i]='%' then
		ls_str1+=as_text[i + 1]+as_text[i + 2]
		i=i + 2
	else
		if ls_str1>'' then
			ls_ret+=hexdecode(ls_str1,ae_encode)
			ls_str1=''
		end if
		ls_ret=ls_ret+as_text[i]
	end if
next
if ls_str1>'' then
	ls_ret+=hexdecode(ls_str1,ae_encode)
end if

return ls_ret
end function

public function string createpath (string as_filepath);//作用:创建路径
//参数:路径
//返回值:成功返回空字符串,失败返回创建失败的路径,参数为null或''则返回''
//说明:
//1.以'\'结尾则创建路径中所有文件夹,否则创建所有文件夹及一个文件
//2.以'\'开头,则在当前磁盘根目录下创建
//3.可以指定绝对路径(C:\1\2\3.txt)
//4.可以指定相对路径(.\1\2\3.txt)


string ls_dir
long l_hwd
int li_pos=0
as_filepath=trim(as_filepath)
if isnull(as_filepath) or as_filepath='' then return ''

if mid(as_filepath,2,1)=':' then li_pos=3	//绝对路径

do
	li_pos=pos(as_filepath,'\',li_pos + 1)
	if li_pos=0 then exit;
	ls_dir=mid(as_filepath,1,li_pos - 1)
	if directoryexists(ls_dir)=false then 
		if createdirectory(ls_dir)=-1 then return ls_dir
	end if
loop until li_pos=0

if left(as_filepath,1)<>'\' then 
	if fileexists(as_filepath)=false then
		l_hwd=fileopen(as_filepath,Linemode!,Write!,LockWrite!,Append!)
		fileclose(l_hwd)
		if l_hwd=-1 then return as_filepath
	end if
end if

return ''
end function

on u_derek_fun.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_derek_fun.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

