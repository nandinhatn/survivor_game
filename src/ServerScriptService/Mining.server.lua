local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")

local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated

-- CONSTANT

    local PROXIMITY_ACTION = "Mining"
    local PICKAXE_SOUND ="rbxassetid://7650217335"
  


local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://18428811797"

local issPressing = true


local function playMiningSound()
    local miningSound = Instance.new("Sound", game:GetService(game:GetService("Workspace")))
    miningSound.SoundId=PICKAXE_SOUND
    miningSound.Parent = workspace
    miningSound:Play()
end

local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local miningModel:Model = prompObject.Parent
    print(miningModel)
    local miningValue = miningModel:FindFirstChildOfClass("IntValue")
    issPressing = false
    PlayerModule.AddToIventory(player, miningValue.Name, miningValue.Value)
   PlayerInventoryUpdated:FireClient(player,PlayerModule.GetInventory(player))
    PlayerModule.GetInventory(player)
    print(miningModel)
    print(miningValue.Name)
    print(miningValue.Value)
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
    playMiningSound()
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
