local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- 📦 สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ⚡ ปุ่มเมนูวงกลม (เปิด/ปิด UI)
local mainButton = Instance.new("TextButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 60, 0, 60)
mainButton.Position = UDim2.new(0.05, 0, 0.5, -30)
mainButton.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
mainButton.Text = "⚡"
mainButton.TextSize = 24
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.BorderSizePixel = 0
mainButton.Font = Enum.Font.GothamBold
mainButton.BackgroundTransparency = 0.2
mainButton.AutoButtonColor = true
mainButton.ZIndex = 10

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = mainButton

-- 🖥️ UI หลักแบบเต็มหน้าจอ
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(1, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.Visible = false

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.05, 0)
uiCorner.Parent = mainFrame

-- 🎨 ส่วน: รายชื่อผู้เล่น (ซ้าย)
local leftFrame = Instance.new("Frame")
leftFrame.Parent = mainFrame
leftFrame.Size = UDim2.new(0.3, 0, 1, 0)
leftFrame.BackgroundTransparency = 1

local searchBox = Instance.new("TextBox")
searchBox.Parent = leftFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 40)
searchBox.Position = UDim2.new(0.05, 0, 0.05, 0)
searchBox.PlaceholderText = "🔍 ค้นหาผู้เล่น"
searchBox.TextSize = 16
searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextColor3 = Color3.fromRGB(0, 0, 0)

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0.3, 0)
searchCorner.Parent = searchBox

local playerList = Instance.new("ScrollingFrame")
playerList.Parent = leftFrame
playerList.Size = UDim2.new(0.9, 0, 0.7, 0)
playerList.Position = UDim2.new(0.05, 0, 0.15, 0)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarImageColor3 = Color3.fromRGB(100, 0, 150)

local selectedPlayer = nil

local function updatePlayerList(searchText)
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and (searchText == "" or string.find(plr.Name:lower(), searchText:lower())) then
            local button = Instance.new("TextButton")
            button.Parent = playerList
            button.Size = UDim2.new(1, 0, 0, 30)
            button.Text = plr.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            button.Font = Enum.Font.Gotham

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0.2, 0)
            btnCorner.Parent = button

            button.MouseButton1Click:Connect(function()
                selectedPlayer = plr
            end)
        end
    end
end

searchBox.Changed:Connect(function()
    updatePlayerList(searchBox.Text)
end)

updatePlayerList("")

-- 🟣 ส่วน: ปุ่มคำสั่ง (ตรงกลาง)
local middleFrame = Instance.new("Frame")
middleFrame.Parent = mainFrame
middleFrame.Size = UDim2.new(0.4, 0, 1, 0)
middleFrame.Position = UDim2.new(0.3, 0, 0, 0)
middleFrame.BackgroundTransparency = 1

local function createCommandButton(text, pos, action)
    local button = Instance.new("TextButton")
    button.Parent = middleFrame
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, pos, 0)
    button.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0.3, 0)
    btnCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        if selectedPlayer then
            action(selectedPlayer)
        end
    end)
end

-- 👁️ ฟังก์ชันดูมุมมอง
local camera = workspace.CurrentCamera
local originalCFrame = camera.CFrame
local isViewing = false

createCommandButton("👁️ ดูมุมมองผู้เล่น", 0.1, function(target)
    if not isViewing then
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            originalCFrame = camera.CFrame
            camera.CameraSubject = target.Character.Humanoid
            isViewing = true
        end
    else
        camera.CameraSubject = player.Character.Humanoid
        camera.CFrame = originalCFrame
        isViewing = false
    end
end)

-- ⚔️ ปุ่มคำสั่งอื่น ๆ
createCommandButton("💀 ฆ่าผู้เล่น", 0.25, function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

createCommandButton("🚀 ไปหาผู้เล่น", 0.4, function(target)
    if player.Character and target.Character then
        player.Character:SetPrimaryPartCFrame(target.Character:GetPrimaryPartCFrame())
    end
end)

createCommandButton("🌀 ดึงผู้เล่นมา", 0.55, function(target)
    if target.Character and player.Character then
        target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
    end
end)

-- 🌍 วาร์ปไปยังจุดเกิด
createCommandButton("🏠 วาร์ปไปจุดเกิด", 0.7, function()
    local spawnPoint = workspace:FindFirstChild("SpawnLocation")
    if spawnPoint and player.Character then
        player.Character:SetPrimaryPartCFrame(spawnPoint.CFrame)
    end
end)

-- 🔶 ส่วน: คำสั่งของตัวเอง (ขวาสุด)
local rightFrame = Instance.new("Frame")
rightFrame.Parent = mainFrame
rightFrame.Size = UDim2.new(0.3, 0, 1, 0)
rightFrame.Position = UDim2.new(0.7, 0, 0, 0)
rightFrame.BackgroundTransparency = 1

local selfCommand = Instance.new("TextButton")
selfCommand.Parent = rightFrame
selfCommand.Size = UDim2.new(0.8, 0, 0, 40)
selfCommand.Position = UDim2.new(0.1, 0, 0.1, 0)
selfCommand.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
selfCommand.Text = "🔄 รีเซ็ตตัวเอง"
selfCommand.TextColor3 = Color3.fromRGB(255, 255, 255)
selfCommand.Font = Enum.Font.GothamBold

local selfCorner = Instance.new("UICorner")
selfCorner.CornerRadius = UDim.new(0.3, 0)
selfCorner.Parent = selfCommand

selfCommand.MouseButton1Click:Connect(function()
    if player.Character then
        player.Character:BreakJoints()
    end
end)

-- 🟢 เปิด/ปิด UI
local isOpen = false
mainButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
end)
