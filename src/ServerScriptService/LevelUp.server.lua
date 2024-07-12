local PlayerModule = require(game.ServerStorage.Modules.PlayerModules)
local ProximityPromptService = game:GetService("ProximityPromptService")
local PlayerLevelUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerLevelUp
local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated
 local PROXIMITY_ACTION = "LevelUp"
 local LEVEL_CAP = 3
 local RESOURCES_REQURIRED = {
    [1] = {
        Stone = 50,
        Copper =10,
        Wood = 100,
    },
    [2] = {
        Stone = 50 *2,
        Copper =10  * 2,
        Wood = 100 * 2,

    },
    [3] = {
        Stone = 50 * 3,
        Copper =10 * 3,
        Wood = 100 * 3,
    }

 }

 local function onPromptTriggered(prompObject,player)
  
    if  prompObject.Name ~= PROXIMITY_ACTION then
        return
    end
   
  
     print("LevelUp")
     local inventory = PlayerModule.GetInventory(player)
     local level = PlayerModule.GetLevel(player)


    if level >= LEVEL_CAP then
        -- TO DO 
        -- FAZER UM GUI WIN!
        return
    
    end
     local required = RESOURCES_REQURIRED[level + 1]

     if inventory.Stone < required.Stone then
        print("Enough Stone")
        return

     end

     if inventory.Copper < required.Copper then
        print("Enough copper")
        return
     end

     if inventory.Wood < required.Copper then
        print("Enough wood")
        return
      

     end

     inventory.Copper -= required.Copper
     inventory.Stone -= required.Stone
     inventory.Wood -= required.Wood

   
     PlayerModule.SetLevel(player, level +1)
   
    PlayerLevelUpdated:FireClient(player,PlayerModule.GetLevel(player))
    PlayerInventoryUpdated:FireClient(player,PlayerModule.GetInventory(player))
  
    print(prompObject)
    print(player)
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)