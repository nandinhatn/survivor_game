local ModelMingingDestroy:BindableEvent = game.ServerStorage.BindableEvents.ModelMiningDestroy
local ReplicatedStorage:ReplicatedStorage = game:GetService("ReplicatedStorage")
local baseplate = game.Workspace:FindFirstChild("Baseplate")
print(baseplate)

-- subir para o workspace o stone, bigstone wood e cooper 

local bigStone:Folder= game.Workspace.BigStone

local smallStone:Folder= workspace.SmallStone
local wood:Folder= workspace.Wood
local cooper:Folder= workspace.Copper



-- constant
local QUANTITY_BIGSTONE = 10
local QUANTITY_SMALLSTONE= 20
local QUANTITY_WOOD =20
local QUANTITY_COPPER= 20

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

local function createMining(quantity:number, folder:string, model:string, child:string, nameFolder)
-- verificacao de quantos tem e quantos eu quero
     for count=1, quantity do
        if #nameFolder:GetChildren() <quantity then
            local modelBigStone:Model= ReplicatedStorage:WaitForChild(folder):WaitForChild(child)
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



local function  generateMining()
    createMining(QUANTITY_BIGSTONE, "BigStone", "MiningModel", "MiningStone", bigStone)
createMining(QUANTITY_SMALLSTONE, "SmallStone", "MiningModel", "MiningStone", smallStone)
createMining(QUANTITY_COPPER, "Copper", "MiningModel", "MiningStone",cooper)
createMining(QUANTITY_WOOD, "Wood", "MiningModel", "MiningStone",wood)

end

generateMining()




ModelMingingDestroy.Event:Connect(function()
    print("Destruido")
           wait(2)                         --folder      --model          --child
    generateMining()
end)