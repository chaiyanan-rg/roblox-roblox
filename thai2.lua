local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")

-- 🔴 UI หลัก
local screenGui = Instance.new("ScreenGui", player.PlayerGui)

-- 🔘 ปุ่มเปิด/ปิด UI
local toggleMainButton = Instance.new("TextButton", screenGui)
toggleMainButton.Size = UDim2.new(0.1, 0, 0.05, 0)
toggleMainButton.Position = UDim2.new(0.45, 0, 0.9, 0)
toggleMainButton.Text = "📜 เปิด UI"
toggleMainButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleMainButton.TextScaled = true

-- 🖥️ แผง UI
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.3, 0, 0.5, 0)
frame.Position = UDim2.new(0.35, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false  -- ปิด UI เริ่มต้น

-- 🔄 ปุ่มสลับหน้า
local switchPage = Instance.new("TextButton", frame)
switchPage.Size = UDim2.new(1, 0, 0.1, 0)
switchPage.Position = UDim2.new(0, 0, 0, 0)
switchPage.Text = "🔄 สลับไปหน้า Admin"
switchPage.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local currentPage = "self"

-- 🟢 ปุ่ม UI - จัดการตัวเอง
local toggleName = Instance.new("TextButton", frame)
toggleName.Size = UDim2.new(1, 0, 0.1, 0)
toggleName.Position = UDim2.new(0, 0, 0.15, 0)
toggleName.Text = "🟢 เปิดชื่อ"
toggleName.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local toggleRank = Instance.new("TextButton", frame)
toggleRank.Size = UDim2.new(1, 0, 0.1, 0)
toggleRank.Position = UDim2.new(0, 0, 0.3, 0)
toggleRank.Text = "🟢 เปิดยศ"
toggleRank.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local toggleInvisible = Instance.new("TextButton", frame)
toggleInvisible.Size = UDim2.new(1, 0, 0.1, 0)
toggleInvisible.Position = UDim2.new(0, 0, 0.45, 0)
toggleInvisible.Text = "🟢 ปกติ"
toggleInvisible.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, 0, 0.1, 0)
flyButton.Position = UDim2.new(0, 0, 0.6, 0)
flyButton.Text = "🟢 ปิดบิน"
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- 🎛️ ฟังก์ชัน เปิด/ปิด UI
toggleMainButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggleMainButton.Text = frame.Visible and "📜 ปิด UI" or "📜 เปิด UI"
    toggleMainButton.BackgroundColor3 = frame.Visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- 🟢 เปิด/ปิดชื่อ
toggleName.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    if head then
        local billboard = head:FindFirstChildOfClass("BillboardGui")
        if billboard then
            billboard.Enabled = not billboard.Enabled
            toggleName.Text = billboard.Enabled and "🟢 เปิดชื่อ" or "🔴 ปิดชื่อ"
            toggleName.BackgroundColor3 = billboard.Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- 🏅 เปิด/ปิดยศ
toggleRank.MouseButton1Click:Connect(function()
    local rankVisible = player.Name:find("%[.*%]")
    if rankVisible then
        player.Name = player.Name:gsub("%[.*%]", "")
        toggleRank.Text = "🔴 ปิดยศ"
        toggleRank.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        player.Name = "[ทหาร] " .. player.Name
        toggleRank.Text = "🟢 เปิดยศ"
        toggleRank.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- 👻 ล่องหน (ซ่อนหัวและผม)
toggleInvisible.MouseButton1Click:Connect(function()
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("Accessory") or part.Name == "Head" then
            part.Transparency = part.Transparency == 0 and 1 or 0
        end
    end
    toggleInvisible.Text = (toggleInvisible.Text == "🟢 ปกติ") and "🔴 ล่องหน" or "🟢 ปกติ"
    toggleInvisible.BackgroundColor3 = (toggleInvisible.BackgroundColor3 == Color3.fromRGB(0, 255, 0)) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
end)

-- ✈️ บิน
local flying = false
flyButton.MouseButton1Click:Connect(function()
    if flying then
        humanoid.PlatformStand = false
        flying = false
        flyButton.Text = "🟢 ปิดบิน"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        humanoid.PlatformStand = true
        flying = true
        flyButton.Text = "🔴 เปิดบิน"
        flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- 🔄 ปุ่มสลับหน้า
switchPage.MouseButton1Click:Connect(function()
    if currentPage == "self" then
        currentPage = "admin"
        switchPage.Text = "🔄 กลับไปหน้าจัดการตัวเอง"
        toggleName.Visible = false
        toggleRank.Visible = false
        toggleInvisible.Visible = false
        flyButton.Visible = false
    else
        currentPage = "self"
        switchPage.Text = "🔄 สลับไปหน้า Admin"
        toggleName.Visible = true
        toggleRank.Visible = true
        toggleInvisible.Visible = true
        flyButton.Visible = true
    end
end)
