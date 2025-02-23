local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.01, 0, 0.9, 0)
toggleButton.Text = "📋 เปิดเมนู"
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleButton
toggleCorner.CornerRadius = UDim.new(0.2, 0)

-- หน้าหลัก UI
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 500, 0, 450)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = mainFrame
frameCorner.CornerRadius = UDim.new(0.05, 0)

-- หัวข้อ UI
local header = Instance.new("TextLabel")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
header.Text = "🎮 เมนูควบคุม"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextSize = 20
header.Font = Enum.Font.GothamBold

-- ปุ่มเมนูขีด 3 ขีด
local menuButton = Instance.new("TextButton")
menuButton.Parent = mainFrame
menuButton.Size = UDim2.new(0, 40, 0, 40)
menuButton.Position = UDim2.new(0.9, 0, 0, 0)
menuButton.Text = "☰"
menuButton.TextSize = 18
menuButton.Font = Enum.Font.GothamBold
menuButton.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
menuButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menuButton
menuCorner.CornerRadius = UDim.new(0.2, 0)

-- สร้างหน้า UI ทั้ง 3 หน้า
local pages = {}

for i, name in ipairs({"จัดการผู้เล่น", "จัดการตัวเอง", "Command"}) do
    local page = Instance.new("Frame")
    page.Parent = mainFrame
    page.Size = UDim2.new(1, 0, 0.85, 0)
    page.Position = UDim2.new(0, 0, 0.15, 0)
    page.BackgroundTransparency = 1
    page.Visible = i == 1 -- แสดงหน้าแรกก่อน
    pages[name] = page
end

-- ปุ่มเปลี่ยนหน้า
local menuList = Instance.new("Frame")
menuList.Parent = mainFrame
menuList.Size = UDim2.new(0, 120, 0, 120)
menuList.Position = UDim2.new(0.9, 0, 0.1, 0)
menuList.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
menuList.Visible = false

for i, name in ipairs({"จัดการผู้เล่น", "จัดการตัวเอง", "Command"}) do
    local btn = Instance.new("TextButton")
    btn.Parent = menuList
    btn.Size = UDim2.new(1, 0, 0.33, 0)
    btn.Position = UDim2.new(0, 0, (i-1)*0.33, 0)
    btn.Text = name
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

    btn.MouseButton1Click:Connect(function()
        for _, page in pairs(pages) do
            page.Visible = false
        end
        pages[name].Visible = true
        menuList.Visible = false
    end)
end

menuButton.MouseButton1Click:Connect(function()
    menuList.Visible = not menuList.Visible
end)

-- ✅ **หน้า "จัดการตัวเอง"**
local settings = {
    {name = "ซ่อนชื่อ", action = function(state) player.Character.Head.NameTag.Enabled = not state end},
    {name = "ซ่อนยศ", action = function(state) print("ซ่อนยศ", state) end},
    {name = "ล่องหน", action = function(state) for _, part in pairs(player.Character:GetChildren()) do if part:IsA("BasePart") then part.Transparency = state and 1 or 0 end end end},
    {name = "บิน", action = function(state) print("เปิดบิน", state) end},
    {name = "ทะลุพื้น", action = function(state) print("ทะลุพื้น", state) end}
}

for i, setting in ipairs(settings) do
    local toggle = Instance.new("TextButton")
    toggle.Parent = pages["จัดการตัวเอง"]
    toggle.Size = UDim2.new(0.9, 0, 0, 40)
    toggle.Position = UDim2.new(0.05, 0, (i-1)*0.2, 0)
    toggle.Text = setting.name .. " ❌"
    toggle.TextSize = 16
    toggle.Font = Enum.Font.Gotham
    toggle.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)

    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggle.Text = setting.name .. (isOn and " ✅" or " ❌")
        setting.action(isOn)
    end)
end

-- ✅ **หน้า "Command"**
local commandBox = Instance.new("TextBox")
commandBox.Parent = pages["Command"]
commandBox.Size = UDim2.new(0.9, 0, 0, 40)
commandBox.Position = UDim2.new(0.05, 0, 0.1, 0)
commandBox.PlaceholderText = "พิมพ์คำสั่ง..."
commandBox.TextSize = 16
commandBox.Font = Enum.Font.Gotham
commandBox.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
commandBox.TextColor3 = Color3.fromRGB(100, 0, 150)

commandBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        game:GetService("ReplicatedStorage"):FindFirstChild("RunCommand"):FireServer(commandBox.Text)
        commandBox.Text = ""
    end
end)

-- เปิด/ปิด UI
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    toggleButton.Text = mainFrame.Visible and "❌ ปิดเมนู" or "📋 เปิดเมนู"
end)
