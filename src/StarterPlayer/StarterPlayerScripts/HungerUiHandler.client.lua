local Players = game:GetService("Players")
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated
local TweenService = game:GetService("TweenService")

-- CONSTANTS
local BAR_FULL_COLOR = Color3.fromRGB(48, 255, 55)
local BAR_LOW_COLOR = Color3.fromRGB(200, 150, 55)
local BAR_LOWER_COLOR = Color3.fromRGB(255, 0, 0)
-- MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui= PlayerGui:WaitForChild("HUD")
local leftBar:Frame = hud:WaitForChild("LeftBar")
local hungerUI:Frame = leftBar:WaitForChild("Hunger")
local hungerBar:Frame = hungerUI:WaitForChild("Bar")





PlayerHungerUpdated.OnClientEvent:Connect(function(hunger)
   
    -- Atualiza o tamanho da barra de fome de acordo com o valor de hunger
    local newSize = UDim2.fromScale(hunger / 100, hungerBar.Size.Y.Scale)
    
    
    -- Verificação de visibilidade antes do tween
  
    
    local tweenInfo = TweenInfo.new(
        0.5, -- Duração
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(hungerBar, tweenInfo, {Size = newSize})
    tween:Play()
    
    tween.Completed:Connect(function()
      
        -- Atualiza a cor da barra de fome de acordo com o valor de hunger
        if hungerBar.Size.X.Scale >= 0.45 then
          
            hungerBar.BackgroundColor3 = BAR_FULL_COLOR
        elseif hungerBar.Size.X.Scale < 0.45 and hungerBar.Size.X.Scale > 0.30 then
         
            hungerBar.BackgroundColor3 = BAR_LOW_COLOR
        else
           
            hungerBar.BackgroundColor3 = BAR_LOWER_COLOR
            print(newSize)
        end
        
        -- Forçar uma atualização visual
     
        
        -- Verificação de visibilidade após o tween
       
    end)
    
  
end)