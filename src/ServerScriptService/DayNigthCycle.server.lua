-- CONSTANTS

local WAIT_INTERVAL = 5
-- MEMBER 
local minutesAfterMidnight:number
while true do
    minutesAfterMidnight= game.Lighting:GetMinutesAfterMidnight() +10
    game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)
    wait(WAIT_INTERVAL)
end