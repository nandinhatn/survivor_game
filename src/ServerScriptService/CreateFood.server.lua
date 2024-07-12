local CreateFood:BindableEvent = game.ServerStorage.BindableEvents.CreateFood
local ReplicatedStorage:ReplicatedStorage = game:GetService("ReplicatedStorage")
local baseplate = game.Workspace:FindFirstChild("Baseplate")
print(baseplate)

-- subir para o workspace o stone, bigstone wood e cooper 

local foodApple:Folder= game.Workspace.Apples

local foodHamburguer:Folder= workspace.Hamburguer




-- constant
local QUANTITY_APPLE = 50
local QUANTITY_HAMBURGUER= 50


local baseplateSize = baseplate.Size
local baseplatePosition = baseplate.Position
local minX = baseplatePosition.X - (baseplateSize.X / 2)
local maxX = baseplatePosition.X + (baseplateSize.X / 2)
 local fixedY = baseplatePosition.Y + baseplateSize.Y / 2 

local minZ = baseplatePosition.Z - (baseplateSize.Z / 2)
local maxZ = baseplatePosition.Z + (baseplateSize.Z / 2)


local function getRandomPosition()
    local x = math.random(minX, maxX)
    local y = fixedY
    local z = math.random(minZ, maxZ)
    return Vector3.new(x, y, z)
end

local function createFood(quantity:number, folder:string, model:string,  nameFolder)
-- verificacao de quantos tem e quantos eu quero
     for count=1, quantity do
        if #nameFolder:GetChildren() <quantity then
            local modelBigStone:Model= ReplicatedStorage:WaitForChild(folder)
            print(modelBigStone)
            local modelBigStoneClone = modelBigStone:Clone()
            print(modelBigStoneClone)
            local randomPosition = getRandomPosition()

            modelBigStoneClone:FindFirstChild(model).CFrame= CFrame.new(randomPosition)
            print(randomPosition)
           
            modelBigStoneClone.Parent= nameFolder
            
        end
     end
end



local function  generateFood()
    createFood(QUANTITY_APPLE, "Apples", "food", foodApple)
createFood(QUANTITY_HAMBURGUER, "Hamburguer", "food",  foodHamburguer)


end

generateFood()




CreateFood.Event:Connect(function()
    print("Comeu")
           wait(2)                         --folder      --model          --child
    generateFood()
end)