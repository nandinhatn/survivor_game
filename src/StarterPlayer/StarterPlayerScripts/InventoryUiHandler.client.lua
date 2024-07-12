local Players = game:GetService("Players")
local PlayerInventoryUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerInventoryUpdated
local TweenService = game:GetService("TweenService")

-- CONSTANTS

-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui= PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local inventory:Frame = hud:WaitForChild("Inventory")
local inventoryUI:Frame = leftBar:WaitForChild("Inventory")
local inventoryButton:ImageButton = inventoryUI:WaitForChild("Button")
local inventoryOriginalPosition = UDim2.fromScale(inventory.Position.X.Scale, inventory.Position.Y.Scale)
inventory.Position= UDim2.fromScale(-1, inventory.Position.Y.Scale)

local stoneNumberLabel:TextLabel= inventory.Stone.number
local copperNumberLabel:TextLabel= inventory.Copper.number
local woodNumberLabel:TextLabel= inventory.Wood.number

print(inventoryUI)
print(inventoryOriginalPosition)

local tweenInfo = TweenInfo.new(
    2,   
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out,
    0,
    false,
    0
)
local tween = TweenService:Create(inventory, tweenInfo,{Position=inventoryOriginalPosition})
local tweenReverse = TweenService:Create(inventory, tweenInfo,{Position= UDim2.fromScale(-1, inventory.Position.Y.Scale)})

inventoryUI.MouseEnter:Connect(function()
    print("mouse enter")
end
)
local debounce = false
inventoryButton.MouseButton1Click:Connect(function()
    print("cliquei")
    if debounce ==false then
        print("caiu aqui")
        inventory.Visible= true;
        tween:Play()       
        debounce = true
    else
        print("voltar")
        
       tweenReverse:Play()
     
        debounce = false
    
    end
    

    
    
   
end
)



PlayerInventoryUpdated.OnClientEvent:Connect(function(inventory:table)
 print(inventory)
 print("chamei o inventario")
    -- updated the bar's size according hunger
    if inventory.Stone then
        stoneNumberLabel.Text = inventory.Stone
    end
    if inventory.Copper then
        copperNumberLabel.Text = inventory.Copper
    end
    if inventory.Wood then
        woodNumberLabel.Text = inventory.Wood
    end
   

   
end
)