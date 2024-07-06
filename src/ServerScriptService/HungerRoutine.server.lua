-- reducao da fome do jogador ao longo do tempo


local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)

-- CONSTANTS
local CORE_LOOP_INTERVAL = 2
local HUNGER_DECREMENT = 3

-- MEMBERS
local PlayerLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoadedUnloaded
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

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


       
    

        
      
        wait(CORE_LOOP_INTERVAL)
    end
end

local function onPlayerLoaded(player:Player)
    spawn(function()
      coreLoop(player)

    end)
end
PlayerLoaded.Event:Connect(onPlayerLoaded)
    

    


