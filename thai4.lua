local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

-- UI หลัก
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DriveControlUI"

-- สร้าง UI ปุ่ม
local function createButton(name, text, position, size, callback)
    local button = Instance.new("TextButton", screenGui)
    button.Name = name
    button.Text = text
    button.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    button.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.BackgroundTransparency = 0.4 -- ความโปร่งแสงของปุ่ม
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 24
    button.AutoButtonColor = true
    button.BorderSizePixel = 0
    button.ClipsDescendants = true
    button.SizeConstraint = Enum.SizeConstraint.RelativeYY
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.ZIndex = 2

    -- ทำให้ปุ่มเป็นวงกลม
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(1, 0)
    uicorner.Parent = button

    button.MouseButton1Down:Connect(function()
        callback(true)
    end)
    button.MouseButton1Up:Connect(function()
        callback(false)
    end)

    return button
end

-- ฟังก์ชันควบคุมการขับรถ
local function sendInput(input)
    if humanoid and humanoid.SeatPart then
        humanoid.SeatPart:Move(Vector3.new(input.X, 0, input.Z), true)
    end
end

-- ฟังก์ชันขับรถ
local function driveForward(state) sendInput(Vector3.new(0, 0, state and -1 or 0)) end
local function driveBackward(state) sendInput(Vector3.new(0, 0, state and 1 or 0)) end
local function turnLeft(state) sendInput(Vector3.new(state and -1 or 0, 0, 0)) end
local function turnRight(state) sendInput(Vector3.new(state and 1 or 0, 0, 0)) end

-- ปุ่มลูกศร
local buttons = {
    Up = createButton("Up", "⬆", UDim2.new(0.1, 0, 0.75, 0), UDim2.new(0.07, 0, 0.07, 0), driveForward),
    Down = createButton("Down", "⬇", UDim2.new(0.1, 0, 0.85, 0), UDim2.new(0.07, 0, 0.07, 0), driveBackward),
    Left = createButton("Left", "⬅", UDim2.new(0.85, 0, 0.8, 0), UDim2.new(0.07, 0, 0.07, 0), turnLeft),
    Right = createButton("Right", "➡", UDim2.new(0.93, 0, 0.8, 0), UDim2.new(0.07, 0, 0.07, 0), turnRight)
}

-- ปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Name = "ToggleButton"
toggleButton.Text = "🟢 UI ON"
toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
toggleButton.Position = UDim2.new(0.9, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20
toggleButton.AutoButtonColor = true

-- เปิด/ปิด UI
local uiVisible = true
toggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    for _, button in pairs(buttons) do
        button.Visible = uiVisible
    end
    toggleButton.Text = uiVisible and "🟢 UI ON" or "🔴 UI OFF"
    toggleButton.BackgroundColor3 = uiVisible and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)
