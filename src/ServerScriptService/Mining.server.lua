local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")

local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- CONSTANT

    local PROXIMITY_ACTION = "Mining"
  


local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://18428811797"

local issPressing = true

local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local stoneModel = prompObject.Parent
    issPressing = false

    print(stoneModel)
    print("eeeeeeeee")
    
  
   
end

local function onPromptHoldBegan(prompObject,player:Player)
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local character = player.Character
    local humanoid = character.Humanoid
    local humanoidAnimator:Animator = humanoid.Animator
    issPressing = true
local animationTrack:Animation =humanoidAnimator:LoadAnimation(animation)

while issPressing do
    animationTrack:Play(nil,nil,1.5)
    print('while')
    wait(1)
end

    print("segurei o botão")
end


ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(function()
    print('desapertei')
    issPressing=false
end)
