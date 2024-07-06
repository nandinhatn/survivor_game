local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")

local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- CONSTANT

    local PROXIMITY_ACTION = "Eat"

local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local foodModel = prompObject.Parent
    foodModel:Destroy()
    print(PlayerModule.GetHunger(player))
    local current_hunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player,current_hunger + 20)
    print(foodModel)
   
    PlayerHungerUpdated:FireClient(player,PlayerModule.GetHunger(player) )
    print(prompObject)
    print(player)
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
