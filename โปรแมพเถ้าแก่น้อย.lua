local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local seaweedCount = 0
local processTime = 50
local maxCapacity = 50
local machineCapacity = 10

local seaweedPoints = {
    Vector3.new(105.02, -22.40, 1298.66),
    Vector3.new(88.71, -22.06, 1299.03),
    Vector3.new(66.08, -22.10, 1300.26),
    Vector3.new(45.58, -21.68, 1298.51),
    Vector3.new(17.73, -22.29, 1300.79)
}

local machines = {
    Vector3.new(194.29, 6.40, 342.65), 
    Vector3.new(197.94, 6.40, 326.19)
}

local moneyPosition = Vector3.new(300.36, 6.07, 223.51)

local Vim = game:GetService("VirtualInputManager")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- แจ้งเตือน (มุมล่างขวา)
local notifyLabel = Instance.new("TextLabel", screenGui)
notifyLabel.Size = UDim2.new(0, 300, 0, 50)
notifyLabel.Position = UDim2.new(1, -320, 1, -60)
notifyLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
notifyLabel.BorderSizePixel = 0
notifyLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
notifyLabel.Font = Enum.Font.SourceSansBold
notifyLabel.TextSize = 18
notifyLabel.Text = "พร้อมทำงาน"
notifyLabel.Visible = true
local notifyCorner = Instance.new("UICorner", notifyLabel)
notifyCorner.CornerRadius = UDim.new(0.3, 0)

-- จับเวลา (มุมขวาบนสุด)
local timerFrame = Instance.new("Frame", screenGui)
timerFrame.Size = UDim2.new(0, 200, 0, 50)
timerFrame.Position = UDim2.new(1, -220, 0, 10)
timerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
timerFrame.BorderSizePixel = 0

-- ✨ เพิ่มกรอบรอบตัวจับเวลา
local timerStroke = Instance.new("UIStroke", timerFrame)
timerStroke.Thickness = 3
timerStroke.Color = Color3.fromRGB(255, 255, 255) -- สีขาว
timerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local timerCorner = Instance.new("UICorner", timerFrame)
timerCorner.CornerRadius = UDim.new(0.3, 0)

local timerLabel = Instance.new("TextLabel", timerFrame)
timerLabel.Size = UDim2.new(1, 0, 1, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.TextSize = 20
timerLabel.Text = "รอการผลิต: 0 วิ"

-- หลอดจับเวลา
local timerBar = Instance.new("Frame", timerFrame)
timerBar.Size = UDim2.new(1, 0, 0, 8)
timerBar.Position = UDim2.new(0, 0, 1, -8)
timerBar.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
local timerBarCorner = Instance.new("UICorner", timerBar)
timerBarCorner.CornerRadius = UDim.new(0.5, 0)

-- ปุ่ม เริ่ม / หยุด
local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0, 20, 1, -80)
button.Text = "เริ่ม"
button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
local buttonCorner = Instance.new("UICorner", button)
buttonCorner.CornerRadius = UDim.new(0.3, 0)

local function notify(msg)
    notifyLabel.Text = msg
    notifyLabel.Visible = true
    wait(3)
    notifyLabel.Visible = false
end

local function moveTo(targetPosition)
    humanoidRootPart.CFrame = CFrame.new(targetPosition)
end

local function pressE(times, delay)
    for i = 1, times do
        if not flying then return end
        Vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        wait(0.2)
        Vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        wait(delay or 0.3)
    end
end

local function collectSeaweed()
    notify("🔄 ไปเก็บสาหร่าย...")
    seaweedCount = maxCapacity
    for _, seaweed in ipairs(seaweedPoints) do
        if not flying then return end
        moveTo(seaweed)
        wait(1)
    end
end

local function startProcess()
    if flying then
        flying = false
        button.Text = "เริ่ม"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        notify("🚫 หยุดทำงาน")

        -- 🛑 รีเซ็ตเวลา
        timerLabel.Text = "รอการผลิต: 0 วิ"
        timerBar.Size = UDim2.new(0, 0, 0, 8)

        return
    end

    flying = true
    button.Text = "หยุด"
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

    while flying do
        if seaweedCount == 0 then
            collectSeaweed()
        end

        for _, machine in ipairs(machines) do
            if seaweedCount == 0 then break end
            if not flying then return end
            moveTo(machine)
            wait(2)
            notify("⚙️ เติมเครื่องผลิต")
            pressE(10)
            seaweedCount = seaweedCount - machineCapacity
        end

        notify("⏳ กำลังผลิต... (50 วิ)")
        
        moveTo(moneyPosition)
        for i = 1, 10 do
            if not flying then return end
            pressE(1, 2) -- 💰 เปลี่ยนเป็นกด E ทุก 2 วิ
        end
        
        for i = processTime, 0, -1 do
            if not flying then return end
            timerLabel.Text = "รอการผลิต: " .. i .. " วิ"
            timerBar.Size = UDim2.new(i / processTime, 0, 0, 8)
            wait(1)
        end
        
        if seaweedCount > 0 then
            notify("🔄 มีสาหร่ายเหลือ → เติมเครื่องต่อ")
        else
            notify("🔄 สาหร่ายหมด → ไปเก็บใหม่")
            collectSeaweed()
        end
    end
end

button.MouseButton1Click:Connect(startProcess)
