local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")
local ModelMingingDestroy = game.ServerStorage.BindableEvents.ModelMiningDestroy

local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated


-- CONSTANT

    local PROXIMITY_ACTION = "Mining"
    local PICKAXE_SOUND ="rbxassetid://7650217335"
    local INVENTORY_SOUND ="rbxassetid://4612383790"
  


local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://18428811797"

local issPressing = true


local function playMiningSound(soundId)
    local miningSound = Instance.new("Sound", game:GetService(game:GetService("Workspace")))
    miningSound.SoundId= soundId
    miningSound.Parent = workspace
    miningSound:Play()
end




local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
    local miningModel:Model = prompObject.Parent
   
    local miningValue = miningModel:FindFirstChildOfClass("IntValue")
    issPressing = false
    PlayerModule.AddToIventory(player, miningValue.Name, miningValue.Value)
   PlayerInventoryUpdated:FireClient(player,PlayerModule.GetInventory(player))
    PlayerModule.GetInventory(player)
    playMiningSound(INVENTORY_SOUND)
    miningModel:Destroy()
    ModelMingingDestroy:Fire()
    
   
    
  
   
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
    playMiningSound(PICKAXE_SOUND)
   
    wait(1)
end

    
end


ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(function()
 
    issPressing=false
end)
