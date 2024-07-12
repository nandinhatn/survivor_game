local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local player = Players. LocalPlayer
--MEMBERS

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud:ScreenGui = PlayerGui:WaitForChild("HUD")
local inviteFriends:TextButton =hud:WaitForChild("InviteFriends")
print(hud)
print(inviteFriends)


inviteFriends.MouseButton1Click:Connect(function()
    SocialService:PromptGameInvite(player)
end
)