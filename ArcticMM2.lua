--[[
    ARCTIC MM2 - UI FOUNDATION
    Version 1.0
    Glossy Arctic interface, 15 themes, mobile + PC support.

    Install as a LocalScript in StarterPlayer > StarterPlayerScripts.
    This is a UI foundation for a Roblox Studio experience.
    It does not reveal hidden roles or provide ESP in live MM2 matches.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("ArcticMM2")
if Old then Old:Destroy() end

local Themes = {
    ["Arctic Blue"] = {Color3.fromRGB(40,160,255), Color3.fromRGB(8,18,35)},
    ["Blood Red"] = {Color3.fromRGB(255,55,65), Color3.fromRGB(30,8,12)},
    ["Purple Haze"] = {Color3.fromRGB(165,85,255), Color3.fromRGB(20,10,35)},
    ["Midnight"] = {Color3.fromRGB(90,110,160), Color3.fromRGB(8,10,20)},
    ["Emerald"] = {Color3.fromRGB(30,220,140), Color3.fromRGB(5,25,20)},
    ["Rose Gold"] = {Color3.fromRGB(255,130,160), Color3.fromRGB(35,15,25)},
    ["Sunset"] = {Color3.fromRGB(255,145,60), Color3.fromRGB(35,15,5)},
    ["Ocean"] = {Color3.fromRGB(0,200,220), Color3.fromRGB(5,20,30)},
    ["Crimson"] = {Color3.fromRGB(180,20,40), Color3.fromRGB(25,5,10)},
    ["Lime"] = {Color3.fromRGB(160,255,50), Color3.fromRGB(15,25,5)},
    ["Galaxy"] = {Color3.fromRGB(130,90,255), Color3.fromRGB(15,5,35)},
    ["Gold"] = {Color3.fromRGB(255,195,50), Color3.fromRGB(30,20,5)},
    ["Ice White"] = {Color3.fromRGB(210,240,255), Color3.fromRGB(20,30,40)},
    ["Cyber"] = {Color3.fromRGB(0,255,190), Color3.fromRGB(5,20,25)},
    ["Stealth"] = {Color3.fromRGB(120,130,145), Color3.fromRGB(12,14,18)}
}

local CurrentTheme = "Arctic Blue"
local Accent = Themes[CurrentTheme][1]
local Background = Themes[CurrentTheme][2]

local function Create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function Round(object, radius)
    Create("UICorner", {CornerRadius = UDim.new(0, radius)}, object)
end

local function Stroke(object, color, transparency)
    return Create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = 1
    }, object)
end

local function Tween(object, properties, duration)
    TweenService:Create(
        object,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quart),
        properties
    ):Play()
end

local Screen = Create("ScreenGui", {
    Name = "ArcticMM2",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

local Float = Create("TextButton", {
    Name = "ArcticButton",
    Size = UDim2.fromOffset(55,55),
    Position = UDim2.new(0,20,0.5,-27),
    BackgroundColor3 = Background,
    Text = "A",
    TextColor3 = Accent,
    TextSize = 27,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Screen)
Round(Float, 18)
local FloatStroke = Stroke(Float, Accent, 0.1)

Create("UIGradient", {
    Rotation = 45,
    Color = ColorSequence.new(Color3.fromRGB(35,65,100), Background)
}, Float)

local Main = Create("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(490,320),
    Position = UDim2.new(0.5,-245,0.5,-160),
    BackgroundColor3 = Background,
    Visible = true,
    BorderSizePixel = 0
}, Screen)
Round(Main, 16)
local MainStroke = Stroke(Main, Accent, 0.2)

Create("UIGradient", {
    Rotation = 120,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(27,42,65)),
        ColorSequenceKeypoint.new(1, Background)
    })
}, Main)

local Header = Create("Frame", {
    Size = UDim2.new(1,0,0,55),
    BackgroundTransparency = 1
}, Main)

Create("TextLabel", {
    Position = UDim2.fromOffset(17,7),
    Size = UDim2.fromOffset(200,25),
    BackgroundTransparency = 1,
    Text = "❄ ARCTIC MM2",
    TextColor3 = Accent,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

Create("TextLabel", {
    Position = UDim2.fromOffset(18,32),
    Size = UDim2.fromOffset(180,15),
    BackgroundTransparency = 1,
    Text = "PREMIUM INTERFACE  •  V1.0",
    TextColor3 = Color3.fromRGB(140,160,185),
    TextSize = 8,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

local Close = Create("TextButton", {
    Size = UDim2.fromOffset(32,32),
    Position = UDim2.new(1,-43,0,10),
    BackgroundColor3 = Color3.fromRGB(55,30,40),
    Text = "×",
    TextColor3 = Color3.fromRGB(255,110,120),
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, Header)
Round(Close, 9)

local Sidebar = Create("Frame", {
    Position = UDim2.fromOffset(10,65),
    Size = UDim2.new(0,120,1,-75),
    BackgroundColor3 = Color3.fromRGB(12,22,38),
    BorderSizePixel = 0
}, Main)
Round(Sidebar, 12)

local Content = Create("Frame", {
    Position = UDim2.fromOffset(140,65),
    Size = UDim2.new(1,-150,1,-75),
    BackgroundTransparency = 1,
    ClipsDescendants = true
}, Main)

local Pages = {}
local TabButtons = {}

local function CreatePage(name)
    local page = Create("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false
    }, Content)

    Create("UIListLayout", {
        Padding = UDim.new(0,9),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    Create("UIPadding", {
        PaddingTop = UDim.new(0,5),
        PaddingLeft = UDim.new(0,5),
        PaddingRight = UDim.new(0,8),
        PaddingBottom = UDim.new(0,8)
    }, page)

    Pages[name] = page
    return page
end

local function Section(parent, text)
    return Create("TextLabel", {
        Size = UDim2.new(1,0,0,28),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)
end

local function Info(parent, text)
    return Create("TextLabel", {
        Size = UDim2.new(1,0,0,42),
        BackgroundColor3 = Color3.fromRGB(22,35,52),
        Text = text,
        TextColor3 = Color3.fromRGB(205,220,240),
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextWrapped = true
    }, parent)
end

local function AddToggle(parent, name, callback)
    local enabled = false
    local button = Create("TextButton", {
        Size = UDim2.new(1,0,0,39),
        BackgroundColor3 = Color3.fromRGB(20,35,53),
        Text = "",
        AutoButtonColor = false
    }, parent)
    Round(button, 9)

    Create("TextLabel", {
        Position = UDim2.fromOffset(12,0),
        Size = UDim2.new(0.7,0,1,0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(225,235,250),
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left
    }, button)

    local switch = Create("Frame", {
        Position = UDim2.new(1,-48,0.5,-10),
        Size = UDim2.fromOffset(36,20),
        BackgroundColor3 = Color3.fromRGB(65,75,90)
    }, button)
    Round(switch, 20)

    local dot = Create("Frame", {
        Position = UDim2.fromOffset(2,2),
        Size = UDim2.fromOffset(16,16),
        BackgroundColor3 = Color3.fromRGB(230,240,255)
    }, switch)
    Round(dot, 20)

    button.Activated:Connect(function()
        enabled = not enabled
        Tween(switch, {
            BackgroundColor3 = enabled and Accent or Color3.fromRGB(65,75,90)
        })
        Tween(dot, {
            Position = enabled and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
        })
        if callback then callback(enabled) end
    end)

    return button
end

local Home = CreatePage("Home")
local Visuals = CreatePage("Visuals")
local Inventory = CreatePage("Inventory")
local Settings = CreatePage("Settings")

Section(Home, "WELCOME TO ARCTIC")
Info(Home, "Your personal MM2 companion interface. Customize your experience.")
Info(Home, "Choose a theme in Settings to change the interface colors.")
Section(Home, "QUICK SETTINGS")
AddToggle(Home, "UI animations", function(value)
    print("UI animations:", value)
end)
AddToggle(Home, "Compact interface", function(value)
    Main.Size = value and UDim2.fromOffset(420,280) or UDim2.fromOffset(490,320)
end)

Section(Visuals, "VISUAL SETTINGS")
Info(Visuals, "Visual options for characters and objects in your own Roblox Studio experience.")
AddToggle(Visuals, "Highlight test characters", function(value)
    print("Test character highlighting:", value)
end)
AddToggle(Visuals, "Show character names", function(value)
    print("Character names:", value)
end)
AddToggle(Visuals, "Show character distance", function(value)
    print("Character distance:", value)
end)
AddToggle(Visuals, "Highlight test items", function(value)
    print("Test item highlighting:", value)
end)

Section(Inventory, "WEAPON PREVIEW")
Info(Inventory, "Cosmetic preview options for items configured in your own experience.")
for _, name in ipairs({
    "Default Knife", "Default Gun", "Icebreaker", "Chroma",
    "Darkbringer", "Lightbringer", "Virtual", "Eternal"
}) do
    local button = Create("TextButton", {
        Size = UDim2.new(1,0,0,34),
        BackgroundColor3 = Color3.fromRGB(20,35,53),
        Text = "   " .. name,
        TextColor3 = Color3.fromRGB(225,235,250),
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    }, Inventory)
    Round(button, 8)
    button.Activated:Connect(function()
        print("Selected preview:", name)
    end)
end

Section(Settings, "15 CUSTOM THEMES")
Info(Settings, "Select a theme for the Arctic interface.")
for name, colors in pairs(Themes) do
    local button = Create("TextButton", {
        Size = UDim2.new(1,0,0,34),
        BackgroundColor3 = Color3.fromRGB(20,35,53),
        Text = "   " .. name,
        TextColor3 = colors[1],
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    }, Settings)
    Round(button, 8)

    button.Activated:Connect(function()
        CurrentTheme = name
        Accent = colors[1]
        Background = colors[2]
        Main.BackgroundColor3 = Background
        MainStroke.Color = Accent
        Float.TextColor3 = Accent
        Float.BackgroundColor3 = Background
        FloatStroke.Color = Accent
        for _, page in pairs(Pages) do
            page.ScrollBarImageColor3 = Accent
        end
        for _, tab in pairs(TabButtons) do
            if tab:GetAttribute("Selected") then
                tab.BackgroundColor3 = Accent
            end
        end
        print("Theme changed to:", name)
    end)
end

local function CreateTab(name, order)
    local button = Create("TextButton", {
        Position = UDim2.fromOffset(6,7 + (order-1)*43),
        Size = UDim2.new(1,-12,0,36),
        BackgroundColor3 = Color3.fromRGB(23,40,60),
        Text = name,
        TextColor3 = Color3.fromRGB(190,205,225),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, Sidebar)
    Round(button, 8)
    TabButtons[name] = button

    button.Activated:Connect(function()
        for pageName, page in pairs(Pages) do
            page.Visible = pageName == name
        end
        for tabName, tab in pairs(TabButtons) do
            local selected = tabName == name
            tab:SetAttribute("Selected", selected)
            Tween(tab, {
                BackgroundColor3 = selected and Accent or Color3.fromRGB(23,40,60),
                TextColor3 = selected and Color3.new(1,1,1) or Color3.fromRGB(190,205,225)
            })
        end
    end)
end

CreateTab("Home",1)
CreateTab("Visuals",2)
CreateTab("Inventory",3)
CreateTab("Settings",4)

Pages.Home.Visible = true
TabButtons.Home.BackgroundColor3 = Accent
TabButtons.Home.TextColor3 = Color3.new(1,1,1)
TabButtons.Home:SetAttribute("Selected", true)

Close.Activated:Connect(function()
    Main.Visible = false
end)

Float.Activated:Connect(function()
    Main.Visible = not Main.Visible
end)

local function MakeDraggable(object, dragArea)
    local dragging = false
    local dragStart
    local startPosition

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

MakeDraggable(Main, Header)
MakeDraggable(Float, Float)

print("ARCTIC MM2 UI LOADED")
