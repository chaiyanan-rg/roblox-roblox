local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")

-- 🔴 UI หลัก
local screenGui = Instance.new("ScreenGui", player.PlayerGui)

-- 🔘 ปุ่มเปิด/ปิด UI (อยู่ด้านบนสุดตรงกลาง)
local toggleMainButton = Instance.new("TextButton", screenGui)
toggleMainButton.Size = UDim2.new(0.15, 0, 0.05, 0)
toggleMainButton.Position = UDim2.new(0.425, 0, 0.02, 0)
toggleMainButton.Text = "📜 เปิด UI"
toggleMainButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleMainButton.TextScaled = true

-- 🖥️ แผง UI (Dashboard)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.3, 0, 0.6, 0)
frame.Position = UDim2.new(0.35, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false  

-- 🔄 ปุ่มสลับหน้า
local switchPage = Instance.new("TextButton", frame)
switchPage.Size = UDim2.new(1, 0, 0.1, 0)
switchPage.Position = UDim2.new(0, 0, 0, 0)
switchPage.Text = "🔄 สลับไปหน้า Admin"
switchPage.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local currentPage = "self"

-- 🔴 หน้า "จัดการตัวเอง"
local selfPage = Instance.new("Frame", frame)
selfPage.Size = UDim2.new(1, 0, 0.9, 0)
selfPage.Position = UDim2.new(0, 0, 0.1, 0)
selfPage.Visible = true  

local toggleName = Instance.new("TextButton", selfPage)
toggleName.Size = UDim2.new(1, 0, 0.1, 0)
toggleName.Text = "🟢 เปิดชื่อ"
toggleName.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local flyButton = Instance.new("TextButton", selfPage)
flyButton.Size = UDim2.new(1, 0, 0.1, 0)
flyButton.Position = UDim2.new(0, 0, 0.15, 0)
flyButton.Text = "🟢 ปิดบิน"
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- 🟠 หน้า "Admin"
local adminPage = Instance.new("Frame", frame)
adminPage.Size = UDim2.new(1, 0, 0.9, 0)
adminPage.Position = UDim2.new(0, 0, 0.1, 0)
adminPage.Visible = false  

local rankButton = Instance.new("TextButton", adminPage)
rankButton.Size = UDim2.new(1, 0, 0.1, 0)
rankButton.Text = "🏅 เปลี่ยนยศ"
rankButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)

local moneyButton = Instance.new("TextButton", adminPage)
moneyButton.Size = UDim2.new(1, 0, 0.1, 0)
moneyButton.Position = UDim2.new(0, 0, 0.15, 0)
moneyButton.Text = "💰 เพิ่มเงิน"
moneyButton.BackgroundColor3 = Color3.fromRGB(0, 165, 255)

-- 🎛️ ฟังก์ชัน เปิด/ปิด UI
toggleMainButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggleMainButton.Text = frame.Visible and "📜 ปิด UI" or "📜 เปิด UI"
    toggleMainButton.BackgroundColor3 = frame.Visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- 🔄 ปุ่มสลับหน้า
switchPage.MouseButton1Click:Connect(function()
    if currentPage == "self" then
        currentPage = "admin"
        switchPage.Text = "🔄 กลับไปหน้าจัดการตัวเอง"
        selfPage.Visible = false
        adminPage.Visible = true
    else
        currentPage = "self"
        switchPage.Text = "🔄 สลับไปหน้า Admin"
        selfPage.Visible = true
        adminPage.Visible = false
    end
end)

-- 🟢 เปิด/ปิดชื่อ
toggleName.MouseButton1Click:Connect(function()
    local head = char:FindFirstChild("Head")
    if head then
        local billboard = head:FindFirstChildOfClass("BillboardGui")
        if billboard then
            billboard.Enabled = not billboard.Enabled
            toggleName.Text = billboard.Enabled and "🟢 เปิดชื่อ" or "🔴 ปิดชื่อ"
        end
    end
end)

-- ✈️ บิน
local flying = false
flyButton.MouseButton1Click:Connect(function()
    if flying then
        humanoid.PlatformStand = false
        flying = false
        flyButton.Text = "🟢 ปิดบิน"
    else
        humanoid.PlatformStand = true
        flying = true
        flyButton.Text = "🔴 เปิดบิน"
    end
end)

-- 🏅 เปลี่ยนยศ
rankButton.MouseButton1Click:Connect(function()
    local newRank = "[OF-9] General | พลเอก"
    player.Name = newRank
    rankButton.Text = "✅ ยศเปลี่ยนเป็น 'พลเอก'"
end)

-- 💰 เพิ่มเงิน
moneyButton.MouseButton1Click:Connect(function()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local money = leaderstats:FindFirstChild("Money")
        if money then
            money.Value = money.Value + 1000
            moneyButton.Text = "✅ เพิ่มเงิน 1,000!"
        end
    end
end)
