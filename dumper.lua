function tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

baseAddr=0
offset=0
reasults=AOBScan(tohex("Blank")..'00')
reasults2=AOBScan(tohex("Blank Seed")..'00')
if(reasults==nil or reasults2==nil)then
print('error')
return
end
for i=1,reasults.getCount()-1 do
for j=1,reasults2.getCount()-1 do
if(tonumber(reasults[i],16)<tonumber(reasults2[j],16))then
baseAddr=tonumber(reasults[i],16)
offset=tonumber(reasults2[j],16)-tonumber(reasults[i],16)
end
end
end
for i=9999,20000 do
isValid=true
mystr=readString(baseAddr+offset*(i))
if(mystr==nil)then
break
end
abc=0
for c in mystr:gmatch"." do
    if(string.byte(c)<32 or string.byte(c)>127 or (abc==0 and string.byte(c)==32))then
    isValid=false
    end
    abc=abc+1
end
if(isValid==true and mystr~="") then
print(i..": "..mystr)
else
mystr=readString(readPointer(baseAddr+offset*(i)))
isValid=true
if(mystr==nil)then
break
end
for c in mystr:gmatch"." do
    if(string.byte(c)<30 or string.byte(c)>127)then
    isValid=false
    end
end
if(isValid==true)then
print(i..": "..mystr)
else
break
end
end
end