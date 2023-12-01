-- Chrono Trigger (U) PartyOn
-- By FreshFeeling,
-- with some memory locations and ideas from Dromiceius and keylie.

memory.usememorydomain("WRAM")

local BATTLE_FLAG = 0x0117

-- Memory locations for each PCs.
local PC_1_LOCATION = 0x2980
local PC_2_LOCATION = 0x2981
local PC_3_LOCATION = 0x2982

-- Values for each PC possibly in the party.
local CHAR_CRONO = 00
local CHAR_MARLE = 01
local CHAR_LUCCA = 02
local CHAR_ROBO = 03
local CHAR_FROG = 04
local CHAR_AYLA = 05
local CHAR_MAGUS = 06

-- Set initial values for the PCs who should exist in the field.
local FIELD_PC_1 = memory.readbyte(PC_1_LOCATION)
local FIELD_PC_2 = memory.readbyte(PC_2_LOCATION)
local FIELD_PC_3 = memory.readbyte(PC_3_LOCATION)

-- Here's where you set which character you want to appear in battles!
local BATTLE_PC_1 = CHAR_ROBO
local BATTLE_PC_2 = CHAR_MAGUS
local BATTLE_PC_3 = CHAR_MARLE

-- Default value; supposes that you are starting this script outside of battle.
local in_battle = false

function main()

    -- If we weren't in battle on the previous frame, but we are now...
	if ((in_battle == false) and ((mainmemory.readbyte(BATTLE_FLAG) % 2) ~= 0)) then
		
        -- Set the flag to show we are now in battle.
        in_battle = true
        -- Force our battle team into the party.
        memory.writebyte(PC_1_LOCATION, BATTLE_PC_1)
        memory.writebyte(PC_2_LOCATION, BATTLE_PC_2)
        memory.writebyte(PC_3_LOCATION, BATTLE_PC_3)

    -- If we WERE in battle on the previous frame, but we are out of battle now...
    elseif ((in_battle == true) and ((mainmemory.readbyte(BATTLE_FLAG) % 2) == 0)) then

        -- Set the flag to show we are no longer in battle.
        in_battle = false
        -- Force the original team into the party.
        memory.writebyte(PC_1_LOCATION, FIELD_PC_1)
        memory.writebyte(PC_2_LOCATION, FIELD_PC_2)
        memory.writebyte(PC_3_LOCATION, FIELD_PC_3)

	end
end

-- Actual execution starts here.
while true do
	main()	
	emu.frameadvance()
end