local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")

local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- CONSTANT

    local PROXIMITY_ACTION = "Eat"
    local EATING_SOUND_ID = "rbxassetid://3043029786"

local function playEatingSound ()
    local eatSoundClone = Instance.new("Sound", game:GetService("Workspace"))
     eatSoundClone.SoundId = EATING_SOUND_ID
    local ramdom = Random.new()
    local value = ramdom:NextNumber(0.5,1)

    eatSoundClone.Pitch = value
    eatSoundClone.Parent =workspace
   
    eatSoundClone:Play()
end


local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local foodModel = prompObject.Parent
    local foodValue = foodModel.Food.Value
    print(foodModel.name,foodValue)
    playEatingSound()
    foodModel:Destroy()
    print(PlayerModule.GetHunger(player))
    local current_hunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player,current_hunger + foodValue)
    print(foodModel)
   
    PlayerHungerUpdated:FireClient(player,PlayerModule.GetHunger(player) )
    print(prompObject)
    print(player)
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
