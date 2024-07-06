local Players = game:GetService("Players")
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- CONSTANTS
local BAR_FULL_COLOR = Color3.fromRGB(48, 255, 55)
local BAR_LOW_COLOR = Color3.fromRGB(200, 150, 55)

-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui= PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local hungerUI:Frame = leftBar:WaitForChild("Hunger")

local hungerBar:Frame = hungerUI:WaitForChild("Bar")




PlayerHungerUpdated.OnClientEvent:Connect(function(hunger:number)
 
    -- updated the bar's size according hunger
    hungerBar.Size= UDim2.fromScale(hunger/100, hungerBar.Size.Y.Scale)

    -- updated the bar's color accordig to the hunger value
    if hungerBar.Size.X.Scale >0.75 then
        hungerBar.BackgroundColor3 = BAR_FULL_COLOR
    else
        hungerBar.BackgroundColor3 = BAR_LOW_COLOR

    end
end
)