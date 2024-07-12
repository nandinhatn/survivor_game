local PlayerLevelUp:RemoteEvent = game.ReplicatedStorage.Network.PlayerLevelUp

 -- Members 

 
  local homeStorage:Folder = game.ReplicatedStorage.HomeStorage

  -- constants
  local LEVEL_CAP = 3
local function onPlayerLevelUp(level)


    for _, instance in workspace.Home:GetChildren() do
        instance:Destroy()
    end

    local home
    
    if level >= LEVEL_CAP then
        home = homeStorage:FindFirstChild(LEVEL_CAP):Clone()
    else
        home = homeStorage:FindFirstChild(level):Clone()
    end

     home = homeStorage:FindFirstChild(level):Clone()
    
    home.Parent = workspace.Home
 print(level)
 print(level)
 print(level)
 print(level)
 print(level)
 print(level)
 print(level)
end



PlayerLevelUp.OnClientEvent:Connect(onPlayerLevelUp)