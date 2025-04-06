if getgenv().executed then return else getgenv().executed = true end

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Giftbux.Visible = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = playerGui

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local sound4 = Instance.new("Sound")
sound4.Parent = playerGui
sound4.SoundId = "rbxassetid://124766475011230" -- Replace with your sound ID
sound4.Volume = 1
sound4.Looped = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
Frame.Size = UDim2.new(0, 260, 0, 180)
Frame.Position = UDim2.new(0.5, -130, 0.4, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(34, 139, 34) -- Green border

local UICorner1 = Instance.new("UICorner")
UICorner1.Parent = Frame
UICorner1.CornerRadius = UDim.new(0.2, 0)

local DashText = Instance.new("TextLabel")
DashText.Parent = Frame
DashText.Text = "Tom Scripts"
DashText.Font = Enum.Font.FredokaOne
DashText.TextSize = 26
DashText.Size = UDim2.new(1, 0, 0.15, 0)
DashText.Position = UDim2.new(0, 0, 0.02, 0)
DashText.TextColor3 = Color3.fromRGB(34, 139, 34) -- Green text
DashText.BackgroundTransparency = 1

local TitleText = Instance.new("TextLabel")
TitleText.Parent = Frame
TitleText.Text = "Robux Donator"
TitleText.Font = Enum.Font.FredokaOne
TitleText.TextSize = 22
TitleText.Size = UDim2.new(1, 0, 0.15, 0)
TitleText.Position = UDim2.new(0, 0, 0.18, 0)
TitleText.TextColor3 = Color3.fromRGB(34, 139, 34)
TitleText.BackgroundTransparency = 1

local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.Text = "Silent Donate"
Button.Font = Enum.Font.FredokaOne
Button.TextSize = 18
Button.Size = UDim2.new(0.85, 0, 0.2, 0)
Button.Position = UDim2.new(0.075, 0, 0.45, 0) -- Centered vertically
Button.BackgroundColor3 = Color3.fromRGB(34, 139, 34) -- Green button
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = Button
UICorner2.CornerRadius = UDim.new(1, 0)

local ContentText = Instance.new("TextLabel")
ContentText.Parent = Frame
ContentText.Text = "The Robux Depends On The Players."
ContentText.Font = Enum.Font.FredokaOne
ContentText.TextSize = 14
ContentText.Size = UDim2.new(1, 0, 0.1, 0)
ContentText.Position = UDim2.new(0, 0, 0.68, 0) -- Moved below the button
ContentText.TextColor3 = Color3.fromRGB(34, 139, 34)
ContentText.BackgroundTransparency = 1

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.Text = "Close"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = 18
CloseButton.Size = UDim2.new(0.3, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.35, 0, 0.82, 0) -- Centered horizontally
CloseButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICornerClose = Instance.new("UICorner")
UICornerClose.Parent = CloseButton
UICornerClose.CornerRadius = UDim.new(1, 0)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

local function Donate()
    local Players = game:GetService("Players")
    local playerList = Players:GetPlayers()
    local username = "No Players"

    if #playerList > 1 then  
        local randomPlayer = playerList[math.random(1, #playerList)]
        username = randomPlayer.Name
    end

    local robux_amount = math.random(5, 700) -- New range: 5 - 700 Robux

    function formatNumber(number)
        local formatted = tostring(number)
        formatted = formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse()
        if formatted:sub(1, 1) == "," then
            formatted = formatted:sub(2)
        end
        return formatted
    end

    local ScreenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
    local TweenService = game:GetService("TweenService")
    local Donation_Text = username.." DONATED " ..formatNumber(robux_amount).. " TO YOU!"
    local clone = game:GetService("Players").LocalPlayer.PlayerGui.UITemplates.donationPopup:Clone()

    -- Fix leaderstats issue
    local leaderstats = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local Raised = leaderstats:FindFirstChild("Raised")
        if Raised then
            Raised.Value = Raised.Value + robux_amount
        end
    end

    clone.Message.Text = Donation_Text
    clone.Transparency = 1
    clone.UIScale.Scale = 0
    clone.Parent = ScreenGui.Popups
    TweenService:Create(clone, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
    
    local Back = Enum.EasingStyle.Back
    if not Back then
        Back = Enum.EasingStyle.Quint
    end
    
    TweenService:Create(clone.UIScale, TweenInfo.new(0.3, Back), { Scale = 1 }):Play()
    TweenService:Create(clone.Message, TweenInfo.new(1, Enum.EasingStyle.Quint), { MaxVisibleGraphemes = #Donation_Text }):Play()
    
    wait(4)
    TweenService:Create(clone, TweenInfo.new(0.25, Enum.EasingStyle.Quint), { Transparency = 1 }):Play()
    TweenService:Create(clone.UIScale, TweenInfo.new(0.5, Back), { Scale = 0 }):Play()
    
    wait(0.5)
end

Button.MouseButton1Click:Connect(function()
    sound4:Play()  -- Play the sound immediately when the button is clicked
    Button:TweenSize(UDim2.new(0.88, 0, 0.22, 0), "Out", "Quad", 0.2, true)
    task.wait(0.2)
    Button:TweenSize(UDim2.new(0.8, 0, 0.18, 0), "Out", "Quad", 0.2, true)
    task.wait(0.2)
    Button:TweenSize(UDim2.new(0.85, 0, 0.2, 0), "Out", "Quad", 0.2, true)
    Donate()
end)

UICorner1.CornerRadius = UDim.new(0.2, 0)

local DashText = Instance.new("TextLabel")
DashText.Parent = Frame
DashText.Text = "Tom Scripts"
DashText.Font = Enum.Font.FredokaOne
DashText.TextSize = 26
DashText.Size = UDim2.new(1, 0, 0.15, 0)
DashText.Position = UDim2.new(0, 0, 0.02, 0)
DashText.TextColor3 = Color3.fromRGB(34, 139, 34)
DashText.BackgroundTransparency = 1

local TitleText = Instance.new("TextLabel")
TitleText.Parent = Frame
TitleText.Text = "Robux Donator"
TitleText.Font = Enum.Font.FredokaOne
TitleText.TextSize = 22
TitleText.Size = UDim2.new(1, 0, 0.15, 0)
TitleText.Position = UDim2.new(0, 0, 0.18, 0)
TitleText.TextColor3 = Color3.fromRGB(34, 139, 34)
TitleText.BackgroundTransparency = 1

local Button = Instance.new("TextButton")
Button.Parent = Frame
Button.Text = "Silent Donate"
Button.Font = Enum.Font.FredokaOne
Button.TextSize = 18
Button.Size = UDim2.new(0.85, 0, 0.2, 0)
Button.Position = UDim2.new(0.075, 0, 0.45, 0)
Button.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = Button
UICorner2.CornerRadius = UDim.new(1, 0)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.Text = "Close"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = 18
CloseButton.Size = UDim2.new(0.3, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.35, 0, 0.82, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICornerClose = Instance.new("UICorner")
UICornerClose.Parent = CloseButton
UICornerClose.CornerRadius = UDim.new(1, 0)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

local function Donate()
    local Players = game:GetService("Players")
    local playerList = Players:GetPlayers()
    local username = "No Players"

    if #playerList > 1 then  
        local randomPlayer = playerList[math.random(1, #playerList)]
        username = randomPlayer.Name
    end

    local robux_amount = math.random(5, 700) -- Robux amount between 5 - 700

    function formatNumber(number)
        local formatted = tostring(number)
        formatted = formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse()
        if formatted:sub(1, 1) == "," then
            formatted = formatted:sub(2)
        end
        return formatted
    end

    -- Update leaderstats (fixing the issue)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local raised = leaderstats:FindFirstChild("Raised")
        if raised then
            raised.Value = raised.Value + robux_amount
        else
            warn("Raised leaderstat not found!")
        end
    else
        warn("Leaderstats not found for player!")
    end

    -- Show visual donation message
    local ScreenGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
    local TweenService = game:GetService("TweenService")
    local Donation_Text = username.." DONATED " ..formatNumber(robux_amount).. " TO YOU!"
    local clone = game:GetService("Players").LocalPlayer.PlayerGui.UITemplates.donationPopup:Clone()

    clone.Message.Text = Donation_Text
    clone.Transparency = 1
    clone.UIScale.Scale = 0
    clone.Parent = ScreenGui.Popups

    TweenService:Create(clone, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
    TweenService:Create(clone.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), { Scale = 1 }):Play()
    TweenService:Create(clone.Message, TweenInfo.new(1, Enum.EasingStyle.Quint), { MaxVisibleGraphemes = #Donation_Text }):Play()

    wait(4)
    TweenService:Create(clone, TweenInfo.new(0.25, Enum.EasingStyle.Quint), { Transparency = 1 }):Play()
    TweenService:Create(clone.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back), { Scale = 0 }):Play()
end

Button.MouseButton1Click:Connect(function()
    sound4:Play()
    Button:TweenSize(UDim2.new(0.88, 0, 0.22, 0), "Out", "Quad", 0.2, true)
    task.wait(0.2)
    Button:TweenSize(UDim2.new(0.8, 0, 0.18, 0), "Out", "Quad", 0.2, true)
    task.wait(0.2)
    Button:TweenSize(UDim2.new(0.85, 0, 0.2, 0), "Out", "Quad", 0.2, true)
    Donate()
end)
