$PBExportHeader$nvo_base64.sru
forward
global type nvo_base64 from nonvisualobject
end type
end forward

global type nvo_base64 from nonvisualobject autoinstantiate
end type

type variables
char ich_base64key[64] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
end variables

forward prototypes
public function ulong hex2int (string hex)
public function string int2hex (unsignedlong ai)
public function string base64encode (blob blobbuf)
public function unsignedlong blob2bytes (blob ab_blob, ref byte aby_bytes[])
public function blob base64decode (string strbuf)
end prototypes

public function ulong hex2int (string hex);//字符型十六进制数转为十进制数值
//asc->asca
//mid->mida
//len->lena

long l_len,l,l_lenmax,ll
decimal hex_to_dec,dec_x

l_len=lena(trim(hex))
l=1
for l=1 to l_len
	if asca(mida(hex,l,1))>=71 then //asca('G')=71
		return 0
	end if
next
l=1
l_lenmax=l_len -1
do while l_lenmax>=0
	if asca(upper(mida(hex,l,1)))>=65 and asca(upper(mida(hex,l,1)))<=70 then //asca('A')=65;asca('F')=70
		ll=asca(upper(mida(hex,l,1))) - 55 //asca('A')-55=10
	else
		ll=long(mida(hex,l,1))
	end if
	dec_x=16^l_lenmax
	hex_to_dec=hex_to_dec+ll*dec_x
	l_lenmax=l_lenmax -1
	l=l+1
loop
return truncate(hex_to_dec,0)

end function

public function string int2hex (unsignedlong ai);//十进制数转为十六进制字符
//返回字串为2的倍数长度，长度不足则前补0
//char->chara
//asc->asca
//len->lena
string hex
if ai = 0 then return '00'
ai = Truncate (ai,0)
do while ai > 0
	if mod(ai,16) >= 10 then
		hex=chara(asca("A")+mod(ai,16) - 10)+hex
	else
		hex=string(mod(ai,16))+hex
	end if
	ai = Truncate(ai/16,0)
loop

if mod(lena(hex),2) = 1 then
	hex = '0' + hex
end if

return hex
end function

public function string base64encode (blob blobbuf);//base64加密
//参数说明
//blobbuf   待加密内容
//返回值		base64加密后的字串
//char ich_base64key[64]
//ich_base64key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

longlong ll_bloblen
ll_bloblen = lena(blobbuf)
if ll_bloblen <= 0 then return ''

ulong lul_bytes
byte ly_bytesbuf[],ly_bytes_null[]

longlong i,ll_temp,j
string ls_temp,ls_return[]

long ll_loops
IF ll_bloblen > 6000 THEN
	IF Mod(ll_bloblen, 6000) = 0 THEN
		ll_loops = ll_bloblen/6000
	ELSE
		ll_loops = (ll_bloblen/6000) + 1
	END IF
ELSE
	ll_loops = 1
END IF
longlong ll_currentpos
ll_currentpos = 1
blob lblb_Data

for j = 1 to ll_loops
	lblb_Data = blobMid(blobbuf,ll_currentpos,6000)
	ll_currentpos += 6000
	lul_bytes = blob2bytes(lblb_Data,ly_bytesbuf)
	ll_bloblen = lena(lblb_Data)
	for i = 1 to longlong(ll_bloblen/3)
		ls_temp = int2hex(int(ly_bytesbuf[3*i - 2])) +&
					 int2hex(int(ly_bytesbuf[3*i - 1])) +&
					 int2hex(int(ly_bytesbuf[3*i]))
		ll_temp = hex2int(lefta(ls_temp,3))
		ls_return[j] += ich_base64key[int(ll_temp / 64)+1] + ich_base64key[mod(ll_temp,64)+1]
		ll_temp = hex2int(mid(ls_temp,4,3))
		ls_return[j] += ich_base64key[int(ll_temp / 64)+1] + ich_base64key[mod(ll_temp,64)+1]
	next
next
string ls_ret

choose case mod(ll_bloblen,3)
	case 1
		ls_temp = int2hex(int(ly_bytesbuf[ll_bloblen])) +'0000'
		ll_temp = hex2int(lefta(ls_temp,3))
		ls_return[j] += ich_base64key[int(ll_temp / 64)+1] + ich_base64key[mod(ll_temp,64)+1] + '=='
	case 2
		ls_temp = int2hex(int(ly_bytesbuf[ll_bloblen - 1])) +&
					 int2hex(int(ly_bytesbuf[ll_bloblen])) +'00'
		ll_temp = hex2int(lefta(ls_temp,3))
		ls_return[j] += ich_base64key[int(ll_temp / 64)+1] + ich_base64key[mod(ll_temp,64)+1]
		ll_temp = hex2int(mida(ls_temp,4,3))
		ls_return[j] += ich_base64key[int(ll_temp / 64)+1] + '='
end choose

//return ls_return
for i = 1 to upperbound(ls_return)
	ls_ret += ls_return[i]
next

return ls_ret

end function

public function unsignedlong blob2bytes (blob ab_blob, ref byte aby_bytes[]);//将blob转为byte数组
//返回值 lulreturn                 转换的字节数
//参数   ab_blob                   待转换blob变量
//          abybytes[]    回传    转换后的byte变量

ulong lul_return
long i
blob{1} blob_temp
byte byte_null[]
aby_bytes = byte_null			//将aby_bytes置空
if Len(ab_blob) <= 0 then return 0
for i = 1 to len(ab_blob)
	blob_temp = blobmid(ab_blob,i,1)
	aby_bytes[i] = byte(blob_temp)
	lul_return ++
next

Return lul_return
end function

public function blob base64decode (string strbuf);//base64解密
//参数说明：
//strbuf		待解密串
//返回解密后blob
//char ich_base64key[64]
//ich_base64key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

blob lbl_return
if lena(strbuf) = 0 then return lbl_return
if righta(strbuf,1) = '=' then
	if lefta(righta(strbuf,2),1) = '=' then
		strbuf = lefta(strbuf,lena(strbuf) - 2)
	else
		strbuf = lefta(strbuf,lena(strbuf) - 1)
	end if
end if
longlong ll_len,i,t,j
ll_len = lena(strbuf) / 2
string m[],x
char s1[2]

long ll_loops,ll_strlen
ll_strlen = lena(strbuf)
IF ll_strlen > 6000 THEN
	IF Mod(ll_strlen, 6000) = 0 THEN
		ll_loops = ll_strlen/6000
	ELSE
		ll_loops = (ll_strlen/6000) + 1
	END IF
ELSE
	ll_loops = 1
END IF
longlong ll_currentpos
ll_currentpos = 1
string ls_tmp
for j = 1 to ll_loops
	ls_tmp = mida(strbuf,ll_currentpos,6000)
	ll_currentpos += 6000
	ll_len = lena(ls_tmp) / 2
	//转为十六进制字串
	for i = 1 to ll_len
		s1 = mida(ls_tmp,i*2 - 1,2)
		t = (Posa(ich_base64key,s1[1]) - 1) * 64 + (Posa(ich_base64key,s1[2]) - 1)
		x = int2hex(t)
		if lena(x) > 3 then
			m[j] += righta(x,3)
		elseif lena(x) = 2 then
			m[j] += '0'+x
		elseif lena(x) = 1 then
			m[j] += '00'+x
		end if
	next
next

if mod(lena(ls_tmp),2)=1 then
   t = (posa(ich_base64key,righta(ls_tmp,1)) - 1) * 64
	x = int2hex(t)
	if lena(x) > 3 then
		m[ll_loops] += righta(x,3)
	elseif lena(x) = 2 then
		m[ll_loops] += '0'+x
	elseif lena(x) = 1 then
   	m[ll_loops] += '00'+x
	end if
	m[ll_loops] = lefta(m[ll_loops],lena(m[ll_loops]) - 2)
end if

byte ly_temp[]
string ls_temp

ll_currentpos = 0
for j = 1 to upperbound(m)
	ll_len = lena(m[j]) / 2
	for i = 1 to ll_len
		ls_temp = mida(m[j],i*2 - 1,2)
		ly_temp[i+ll_currentpos] = byte(hex2int(ls_temp))
	next
	ll_currentpos += lena(m[j]) / 2
next
lbl_return = blob(ly_temp)

return lbl_return

end function

on nvo_base64.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_base64.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Create By Leio 张映磊
//2011.1.31

end event

