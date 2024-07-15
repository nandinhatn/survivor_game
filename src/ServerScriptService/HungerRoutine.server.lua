local Players = game:GetService("Players")
-- reducao da fome do jogador ao longo do tempo


local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)

-- CONSTANTS
local CORE_LOOP_INTERVAL = 2
local HUNGER_DECREMENT = 2

-- MEMBERS
local PlayerLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoadedUnloaded
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated
local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated

local function coreLoop(player:Player)
   
    local isRunning = true
    -- listen to the player Unloaded
    PlayerUnLoaded.Event:Connect(function(PlayerUnLoaded:Player)
        if PlayerUnLoaded == player then
            isRunning =false
            
        end
       
    end
    )
    
    while  true do 
        if not isRunning then
            break
        end
            local currentHunger = PlayerModule.GetHunger(player)
            PlayerModule.SetHunger(player, currentHunger -HUNGER_DECREMENT)
           
            -- Notify Client
            PlayerHungerUpdated:FireClient(player,PlayerModule.GetHunger(player) )
            if currentHunger<=0 then
               
                
                player.Character:FindFirstChildOfClass("Humanoid").Health=0
                local humanoid = player.Character:WaitForChild("Humanoid")
                humanoid.Died:Connect(function()
                    print("humanoid morreu")
                    
                    
                    PlayerModule.SetHunger(player,100)
                    
                    local inventory  = PlayerModule.GetInventory(player)
                    
                    inventory.Copper = inventory.Copper >=10 and inventory.Copper-10 or inventory.Copper - inventory.Copper

                    inventory.Stone = inventory.Stone >= 10 and inventory.Stone -10 or inventory.Stone - inventory.Stone
                    inventory.Wood = inventory.Wood >= 10 and inventory.Wood - 10 or inventory.Wood - inventory.Wood

                    PlayerHungerUpdated:FireClient(player,PlayerModule.GetHunger(player) )
                    PlayerInventoryUpdated:FireClient(player,PlayerModule.GetInventory(player))
                 
                    
                    
                end
        
                )
               
                return
                
            end

       
    

        
      
        wait(CORE_LOOP_INTERVAL)
    end
end



local function onPlayerLoaded(player:Player)
    spawn(function()
      coreLoop(player)
        print("onplayerloaded")
    end)
end
PlayerLoaded.Event:Connect(onPlayerLoaded)



    

    


