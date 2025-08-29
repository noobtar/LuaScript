gg.clearResults() --clearResults before run script.

local globalbase = nil --global variable for base libgame.so

function Baselib() --find base libgame.so function.
local baselib = gg.getRangesList('libgame.so')
gg.setVisible(false)
gg.setRanges(16384) --set memory range to libgame.so
gg.searchNumber('h7F 45 4C 46 01 01 01 00  00 00 00 00 00 00 00 00﻿ 03 00 28 00 01 00 00 00  00 00 00 00 34 00 00 00﻿ 4C 35 52 01 00 02 00 05  34 00 20 00 08 00 28 00',gg.TYPE_BYTE,false,nil,nil,nil,2)
local base = gg.getResults(1) --get base address libgame.so
gg.clearResults()
if base[1] ~= nil then
return base[1].address
elseif(baselib[1] ~= nil) then  ---check headers libgame.so. function is for testing.
return baselib[1].start
else
return nil
end
end

gg.setVisible(false)

if Baselib() == nil then
gg.alert('ไม่พบ libgame.so กรุณารันสคริปใหม่') -- exit if libgame.so not found.
os.exit()
end

gg.setVisible(false)

globalbase = Baselib()

gg.alert([[
✅ยินดีตอนรับ สคริปต์ของ Noname Open SRC
สามารถดัดแปลงแก้ไขได้ตามใจชอบ
💥💢ขอให้สนุกกับการใช้สคริปต์นะครับ💥💢
]])

---------------------------------------------------------
-- Select bit game function.
local bitgame = gg.alert('⚙️กรุณาเลือกบิตเกมของท่าน🤔','32bit📱','64bit📱') --select bitgame
--------------------------------------------------------
-- Static Byte function for edit memory.

function Static_Byte(hex,offset_plus,num_edit,type_edit)
gg.clearResults()
gg.setRanges(16384) --set memory range to libgame.so
gg.searchNumber(hex,gg.TYPE_BYTE,false,nil,nil,nil,2)
local get_result = gg.getResults(1)
gg.clearResults()
local setvalue = {}
table.insert(setvalue,1,{address = get_result[1].address + offset_plus,
flags = type_edit,
value = num_edit})
if (setvalue ~= nil) then -- check result not nil. 
gg.setValues(setvalue)
gg.alert('ทำการเสร็จสิ้น ✅' .. '\naddress : '..setvalue[1].address
.. '\ntype : '..setvalue[1].flags ..'\nvalue : '..setvalue[1].value) 
else
gg.alert('ทำการไม่เสร็จสิ้น ❌') 
end
setvalue = {} --clear tables after use.
get_result = {} --clear tables after use.
end

-------------------------------------------------------

local feature32 = { --menu 1 for 32bit
    {flags = false,name = " ปล่อยรัว: 🔫🎯",hex = "h 9F ED C8 9A 06 46",offset = 0x322,on = -999.0,off = 0.0},
    {flags = false,name = " แร่ไม่ลด: 💎📉",hex = "h9F ED 44 0A D0 F8 D4 10 20 46",offset = 0x114,on = 0.0,off = 0.03333333507},
    {flags = false,name = " ตีป้อมแรง: 🏰💥",hex = "h9F ED 3D 8A 00 2E",offset = 0xF8,on = 50.0,off = 0.0},
    {flags = false,name = " ตายออโต้: 💀🔄",hex = "h9F ED 52 0A 01 EE 10 0A B4 EE C0 1A",offset = 0x14C,on = 99999.0,off = -100.0},
    {flags = false,name = " ตีแรง: ⚔️💪",hex = "h9F ED 2F AA B0 EE 4A 9A B0 EE 4A 8A",offset = 0xBE,on = 3000.0,off = 0.0},
    {flags = false,name = " จรวดไม่แรง PVP: 🚀⬇️",hex = "h9F ED B1 2A 01 EE 10 4A 9F ED AE 0A",offset = 0x2C6,on = -9999999.0,off = 90.0},
    {flags = false,name = " จรวดโครตแรง : 👾",hex = "h9F ED B1 2A 01 EE 10 4A 9F ED AE 0A",offset = 0x2C6,on = 999999.0,off = 90.0},
    {flags = false,name = " เลือดป้อม 999: 🏰",hex = "h9F ED 3D 8A 00 2E",offset = 0xF8,on = -99999.0,off = 0.0},  
    {flags = false,name = " วิ่งเร็ว: 🏃‍♂️💨",hex = "h9F ED 37 AA 01 EE 10 6A 39 EE 00 0A",offset = 0xE0,on = 20.0,off = 0.10000000149},
    {flags = false,name = " ตีไกล ⚔️🚀",hex = "h9F ED 14 8A E8 B1",offset = 0x52,on = 5.0,off = 0.0},
    {flags = false,name = " เวลา x4 [สเตจจุติ] : ⏱️✖️",hex = "h9F ED 35 0A 94 ED 38 1A",offset = 0xD6,on = 0.41,off = 1.12},
    {flags = false,name = " เวลา x2: ⏱️✖️",hex = "h9F ED 35 0A 94 ED 38 1A",offset = 0xD6,on = 0.61,off = 1.12},
    {flags = false,name = " Auto ฟังชั่น PvP 🤖"},
    {flags = false,name = " Auto ฟังชั่น จรวดเคลียจุติ 🤖"},
    {bit32  = "[[💥💢ยินดีต้อนรับสู่เมนูของ Noname Open SRC ไลน์เรนเจอร์ 32BIT ]]"},
}

local feature64 = { --menu 2 for 64bit
     {flags = false,name = " ปล่อยรัว: 🔫🎯",hex = "h 9F ED C8 9A 06 46",offset = 0x322,on = 9488438999.0,off = 0.0},
     {bit64  = "[[💥💢ยินดีต้อนรับสู่เมนูของ Noname Open SRC  ไลน์เรนเจอร์ 64BIT ]]"},
}

-------------------------------------------------------

local function Menu(bitgame)
   local BIT = nil
   local select_table = nil -- select table between 32 or 64.
   local items = {} --table for menu to save,change,show,etc.
   ----------------------------------------------------
    if bitgame == 1 then
        BIT = feature32[#feature32].bit32  
        select_table = feature32 --copy table 32bit to select_table.
    elseif bitgame == 2 then     --copy table 64bit to select_table.
        BIT = feature64[#feature64].bit64 --check bit game.
        select_table = feature64
    else
        gg.alert('กรุณาเลือกบิตเกมของท่าน')
        os.exit()   
    end
    ---------------------------------------------------
    local choid = gg.multiChoice((
    function ()
        for i, v in ipairs(select_table) do
           if v.name ~= nil and v.flags == true then
              table.insert(items,"[🟢]" .. v.name .. "[เปิดอยู่]") --insert emoji checklist to table
              elseif v.name ~= nil and v.flags == false then
              table.insert(items,"[🔴]" .. v.name .. "[ปิดอยู่]") --insert emoji checklist to table
           end
        end
        table.insert(items,#items + 1,"ออก🚪") --add exit script table.
        return items --return the table.
    end)(),nil,BIT)
------------------------------------------------------    
if choid ~= nil then
if choid[#items] then
  print("Thank you for using Noname Open SRC") --check exit script.
  os.exit()
end
-------------------------------------------------------
if choid[13] then
    if select_table[13].flags == false then
         table.insert(choid,1,false) 
    for i = 2,6,1 do
        table.insert(choid,i,true) --insert auto function to table.
    end
    select_table[13].flags = true
    gg.toast("✅ เปิด "..select_table[13].name)
    else
    table.insert(choid,1,false) 
    for i = 2,6,1 do
        table.insert(choid,i,true) --insert auto function to table.
    end
    select_table[13].flags = false
    gg.toast("❌ ปิด "..select_table[13].name)
    end
end
-------------------------------------------------------
if choid[14] then
    if select_table[14].flags == false then
    for i = 1,8,1 do
     if i >= 3 and i <= 6 then
        table.insert(choid,i,false) --insert auto function to table.
     else
        table.insert(choid,i,true) --insert auto function to table.
        end
    end
    select_table[14].flags = true
    gg.toast("✅ เปิด "..select_table[13].name)
    else
    for i = 1,8,1 do
     if i >= 3 and i <= 6 then
        table.insert(choid,i,false) --insert auto function to table.
     else
        table.insert(choid,i,true) --insert auto function to table.
        end
    end
    select_table[14].flags = false
    gg.toast("❌ ปิด "..select_table[13].name)
    end
end
------------------------------------------------------ 
gg.setVisible(false) --hide menu when use.
------------------------------------------------------
for i, v in pairs(choid) do
    if v then
    if  select_table[i].flags == true and select_table[i].offset ~= nil then -- check flags true or false.
    Static_Byte(select_table[i].hex,select_table[i].offset,select_table[i].off,gg.TYPE_FLOAT) --call function Static_Byte.
    select_table[i].flags = false
    gg.toast("❌ ปิด "..select_table[i].name)
    elseif select_table[i].flags == false and select_table[i].offset ~= nil then
    Static_Byte(select_table[i].hex,select_table[i].offset,select_table[i].on,gg.TYPE_FLOAT) --call function Static_Byte.
    select_table[i].flags = true
    gg.toast("✅ เปิด "..select_table[i].name)
end
    end
      end 
      gg.setVisible(true) --show menu again after use.
end
     items = {} --clear tables after use.
     select_table = {} --clear tables after use.
end

gg.setVisible(true) --set menu visibles.

local function main()
 Menu(bitgame) --call menu function.
I = -1 
end

while true do
    if gg.isVisible() == true then
        I = 1
        gg.setVisible(false)
    end
    if I == 1 then
        main() --loop main function.
    end
    I = -1
end

