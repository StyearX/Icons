local RunService = game:GetService("RunService")

local Spinners = {}

Spinners.Spritesheets = {
    ["1"] = "rbxassetid://128760610957420",
}

Spinners.FrameSize = 32

Spinners.Icons = {
    ["12-dots-scale-rotate"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 0),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 0,
        Duration = 6.0000,
    },
    ["180-ring"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 32),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 32,
        Duration = 0.7500,
    },
    ["180-ring-with-bg"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 64),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 64,
        Duration = 0.7500,
    },
    ["270-ring"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 96),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 96,
        Duration = 0.7500,
    },
    ["270-ring-with-bg"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 128),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 128,
        Duration = 0.7500,
    },
    ["3-dots-bounce"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 160),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 25,
        RowY = 160,
        Duration = 1.0500,
    },
    ["3-dots-fade"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 192),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 19,
        RowY = 192,
        Duration = 0.8000,
    },
    ["3-dots-move"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 224),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 224,
        Duration = 2.0000,
    },
    ["3-dots-rotate"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 256),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 24,
        RowY = 256,
        Duration = 1.0000,
    },
    ["3-dots-scale"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 288),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 19,
        RowY = 288,
        Duration = 0.8000,
    },
    ["3-dots-scale-middle"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 320),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 320,
        Duration = 0.7500,
    },
    ["6-dots-rotate"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 352),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 352,
        Duration = 0.7500,
    },
    ["6-dots-scale"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 384),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 384,
        Duration = 1.2000,
    },
    ["6-dots-scale-middle"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 416),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 416,
        Duration = 1.2000,
    },
    ["8-dots-rotate"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 448),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 36,
        RowY = 448,
        Duration = 1.5000,
    },
    ["90-ring"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 480),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 480,
        Duration = 0.7500,
    },
    ["90-ring-with-bg"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 512),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 512,
        Duration = 0.7500,
    },
    ["bars-fade"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 544),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 19,
        RowY = 544,
        Duration = 0.8000,
    },
    ["bars-rotate-fade"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 576),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 576,
        Duration = 0.7500,
    },
    ["bars-scale"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 608),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 22,
        RowY = 608,
        Duration = 0.9000,
    },
    ["bars-scale-fade"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 640),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 19,
        RowY = 640,
        Duration = 0.8000,
    },
    ["bars-scale-middle"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 672),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 22,
        RowY = 672,
        Duration = 0.9000,
    },
    ["blocks-scale"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 704),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 704,
        Duration = 1.2000,
    },
    ["blocks-shuffle-2"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 736),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 38,
        RowY = 736,
        Duration = 1.6000,
    },
    ["blocks-shuffle-3"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 768),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 768,
        Duration = 2.4000,
    },
    ["blocks-wave"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 800),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 800,
        Duration = 1.2000,
    },
    ["bouncing-ball"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 832),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 19,
        RowY = 832,
        Duration = 0.8000,
    },
    ["clock"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 864),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 864,
        Duration = 9.0000,
    },
    ["dot-revolve"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 896),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 896,
        Duration = 0.7500,
    },
    ["eclipse"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 928),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 14,
        RowY = 928,
        Duration = 0.6000,
    },
    ["eclipse-half"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 960),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 14,
        RowY = 960,
        Duration = 0.6000,
    },
    ["gooey-balls-1"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 992),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 992,
        Duration = 0.7500,
    },
    ["gooey-balls-2"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1024),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 1024,
        Duration = 6.0000,
    },
    ["pulse"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1056),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1056,
        Duration = 1.2000,
    },
    ["pulse-2"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1088),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1088,
        Duration = 1.2000,
    },
    ["pulse-3"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1120),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1120,
        Duration = 1.2000,
    },
    ["pulse-multiple"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1152),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 38,
        RowY = 1152,
        Duration = 1.6000,
    },
    ["pulse-ring"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1184),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1184,
        Duration = 1.2000,
    },
    ["pulse-rings-2"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1216),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1216,
        Duration = 1.2000,
    },
    ["pulse-rings-3"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1248),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 29,
        RowY = 1248,
        Duration = 1.2000,
    },
    ["pulse-rings-multiple"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1280),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 38,
        RowY = 1280,
        Duration = 1.6000,
    },
    ["ring-resize"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1312),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 48,
        RowY = 1312,
        Duration = 6.0000,
    },
    ["tadpole"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1344),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 18,
        RowY = 1344,
        Duration = 0.7500,
    },
    ["wifi"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1376),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 35,
        RowY = 1376,
        Duration = 1.4510,
    },
    ["wifi-fade"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1408),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 37,
        RowY = 1408,
        Duration = 1.5500,
    },
    ["wind-toy"] = {
        Image = 1,
        ImageRectOffset = Vector2.new(0, 1440),
        ImageRectSize = Vector2.new(32, 32),
        Frames = 36,
        RowY = 1440,
        Duration = 1.5000,
    },
}

function Spinners:Play(imageLabel, iconName, options)
    local data = self.Icons[iconName]
    if not data then
        warn("[Spinners] Icon not found: " .. tostring(iconName))
        return nil
    end

    options = options or {}
    local speed = options.Speed or 1
    local loop = (options.Loop ~= false) -- default true

    local sheetId = self.Spritesheets[tostring(data.Image)]
    local fs = self.FrameSize

    imageLabel.Image = sheetId
    imageLabel.ImageRectSize = Vector2.new(fs, fs)

    local frameDuration = data.Duration / data.Frames
    local elapsed = 0
    local lastFrame = -1

    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        if not imageLabel or not imageLabel.Parent then
            conn:Disconnect()
            return
        end

        elapsed += dt * speed

        if not loop and elapsed >= data.Duration then
            elapsed = data.Duration - frameDuration
            conn:Disconnect()
        end

        local frameIndex = math.floor((elapsed % data.Duration) / frameDuration)
        frameIndex = math.clamp(frameIndex, 0, data.Frames - 1)

        if frameIndex ~= lastFrame then
            lastFrame = frameIndex
            imageLabel.ImageRectOffset = Vector2.new(frameIndex * fs, data.RowY)
        end
    end)

    return conn
end

-- Spinners:Stop(connection)
function Spinners:Stop(connection)
    if connection then
        connection:Disconnect()
    end
end

function Spinners:SetStatic(imageLabel, iconName, frameIndex)
    local data = self.Icons[iconName]
    if not data then
        warn("[Spinners] Icon not found: " .. tostring(iconName))
        return
    end
    frameIndex = math.clamp(frameIndex or 0, 0, data.Frames - 1)
    local fs = self.FrameSize
    imageLabel.Image = self.Spritesheets[tostring(data.Image)]
    imageLabel.ImageRectSize = Vector2.new(fs, fs)
    imageLabel.ImageRectOffset = Vector2.new(frameIndex * fs, data.RowY)
end

return Spinners
