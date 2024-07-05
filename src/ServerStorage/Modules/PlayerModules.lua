local PlayerModule ={}
-- gravar todos os jogadores



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
    print("chamou setHUnger")
   
  
        playersCached[player.UserId].hunger = hunger
   
    
end


function PlayerModule.GetHunger(player:Player)
    print("Dentro do Gethunger ")
        print(player)
    print(playersCached)
    if playersCached[player.UserId] then
        return playersCached[player.UserId].hunger 
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
    print("Player Removido")
    PlayerUnLoaded:Fire(player)
    playersCached[player.UserId]= nil
   
end





Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
return PlayerModule