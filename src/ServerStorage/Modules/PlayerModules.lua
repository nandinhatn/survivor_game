local PlayerModule ={}
-- gravar todos os jogadores

local function normalizeHunger(hunger:number):number
    if hunger >100 then
        hunger = 100
    end
    if hunger <0 then
        hunger = 0
    end
    return hunger
end

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local PLAYER_DEFAULT_DATA= {
    hunger=100,
    inventory = {},
    level =1,

}

local playersCached ={} -- Dicitionary with all players in the game
local database = DataStoreService:GetDataStore("Survival")
local PlayerLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoaded
local PlayerUnLoaded:BindableEvent = game.ServerStorage.BindableEvents.PlayerLoadedUnloaded


function PlayerModule.isLoaded(player:Player):boolean
    local isLoaded = playersCached[player.UserId] and true or false

    return isLoaded
end

function PlayerModule.SetHunger(player:Player, hunger: number)
 
    local hungerCurrent = normalizeHunger(hunger)
        
       
        playersCached[player.UserId].hunger = hungerCurrent
   
    
end


function PlayerModule.GetHunger(player:Player)
      
   
    if playersCached[player.UserId] then
        
        local hungerCurrent = normalizeHunger(playersCached[player.UserId].hunger)
        return hungerCurrent
    end
   
end
local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then 
            data= PLAYER_DEFAULT_DATA

        end
        playersCached[player.UserId]= data

        -- Players is fully loaded
        PlayerLoaded:Fire(player)
       


    end)
    playersCached[player.UserId] = PLAYER_DEFAULT_DATA
   
end


local function onPlayerRemoving(player:Player)
   
    PlayerUnLoaded:Fire(player)
    playersCached[player.UserId]= nil
   
end





Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
return PlayerModule