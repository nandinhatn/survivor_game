local ProximityPromptService = game:GetService("ProximityPromptService")

-- CONSTANT

    local PROXIMITY_ACTION = "Eat"

local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    print(prompObject)
    print(player)
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
