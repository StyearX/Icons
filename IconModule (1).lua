local cloneref = (cloneref or clonereference or function(instance) return instance end)

local function httpGet(url)
	if writefile and game.HttpGet then
		return game:HttpGet(url)
	else
		return cloneref(game:GetService("HttpService")):GetAsync(url)
	end
end

local iconModule = {
	icons = {
		lucide = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/lucide/dist/Icons.lua"))(),
		solar = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/solar/dist/Icons.lua"))(),
		craft = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/craft/dist/Icons.lua"))(),
		geist = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/geist/dist/Icons.lua"))(),
		sfsymbols = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/sfsymbols/dist/Icons.lua"))(),
		gravity = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/gravity/dist/Icons.lua"))(),
		googlematerial = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/GoogleMaterialIcons/dist/Icons.lua"))(),
		hero = loadstring(httpGet("https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/hero/dist/Icons.lua"))(),
	},
}

function iconModule.AddIcons(packName, iconsData)
	if type(packName) ~= "string" or type(iconsData) ~= "table" then
		error("AddIcons: packName must be string, iconsData must be table")
	end

	if not iconModule.icons[packName] then
		iconModule.icons[packName] = { icons = {} }
	end

	local pack = iconModule.icons[packName]
	pack.icons = pack.icons or {}

	for iconName, iconValue in pairs(iconsData) do
		if type(iconValue) == "number" or (type(iconValue) == "string" and iconValue:match("^rbxassetid://")) then
			local imageId = iconValue
			if type(iconValue) == "number" then
				imageId = "rbxassetid://" .. tostring(iconValue)
			end
			pack.icons[iconName] = {
				image = imageId,
				imageRectSize = Vector2.new(0, 0),
				imageRectPosition = Vector2.new(0, 0),
			}
		elseif type(iconValue) == "table" and iconValue.Image and iconValue.ImageRectSize and iconValue.ImageRectPosition then
			local imageId = iconValue.Image
			if type(imageId) == "number" then
				imageId = "rbxassetid://" .. tostring(imageId)
			end
			pack.icons[iconName] = {
				image = imageId,
				imageRectSize = iconValue.ImageRectSize,
				imageRectPosition = iconValue.ImageRectPosition,
				parts = iconValue.Parts,
			}
		else
			warn("AddIcons: Unsupported data for icon '" .. iconName .. "'")
		end
	end
end

local function parseIconString(str)
	local splitIndex = str:find("/")
	if not splitIndex then
		return nil, nil
	end
	return str:sub(1, splitIndex - 1), str:sub(splitIndex + 1)
end

local function resolveIcon(iconString)
	local prefix, name = parseIconString(iconString)
	if not prefix or not name then
		return nil
	end

	local pack = iconModule.icons[prefix]
	if not pack then
		return nil
	end

	local iconData = pack.icons and pack.icons[name]
	if iconData then
		return iconData
	end

	if type(pack[name]) == "string" and pack[name]:find("rbxassetid://") then
		return {
			image = pack[name],
			imageRectSize = Vector2.new(0, 0),
			imageRectPosition = Vector2.new(0, 0),
		}
	end

	return nil
end

local rectSupportedClasses = {
	ImageLabel = true,
	ImageButton = true,
}

local propertyMap = {
	ImageLabel = { "Image" },
	ImageButton = { "Image" },
	Decal = { "Texture" },
	Texture = { "Texture" },
	MeshPart = { "TextureID" },
	SurfaceAppearance = { "ColorMap", "MetalnessMap", "NormalMap", "RoughnessMap" },
	Sky = { "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp", "MoonTextureId", "SunTextureId" },
	Shirt = { "Texture" },
	Pants = { "Texture" },
	ShirtGraphic = { "Graphic" },
	ParticleEmitter = { "Texture" },
	Beam = { "Texture" },
	Trail = { "Texture" },
}

local watching = {}

local function isRawValue(value)
	return type(value) == "string"
		and value ~= ""
		and not value:match("^rbxassetid://")
		and not value:match("^rbxasset://")
		and not value:match("^https?://")
		and not value:match("^rbxthumb://")
end

local function clearParts(instance)
	for _, child in ipairs(instance:GetChildren()) do
		if child:GetAttribute("__iconPart") then
			child:Destroy()
		end
	end
end

local function applyProperty(instance, propertyName)
	local ok, value = pcall(function()
		return instance[propertyName]
	end)
	if not ok or not isRawValue(value) then
		return
	end

	local iconData = resolveIcon(value)
	if not iconData then
		return
	end

	instance[propertyName] = iconData.image

	if rectSupportedClasses[instance.ClassName] and propertyName == "Image" then
		instance.ImageRectSize = iconData.imageRectSize
		instance.ImageRectOffset = iconData.imageRectPosition

		clearParts(instance)

		if iconData.parts then
			local prefix = parseIconString(value)
			for _, part in ipairs(iconData.parts) do
				local partData = resolveIcon(prefix .. "/" .. part)
				if partData then
					local partLabel = Instance.new(instance.ClassName)
					partLabel.Name = "IconPart"
					partLabel.BackgroundTransparency = 1
					partLabel.Size = UDim2.new(1, 0, 1, 0)
					partLabel.Image = partData.image
					partLabel.ImageRectSize = partData.imageRectSize
					partLabel.ImageRectOffset = partData.imageRectPosition
					partLabel:SetAttribute("__iconPart", true)
					partLabel.Parent = instance
				end
			end
		end
	end
end

local function watchInstance(instance)
	local properties = propertyMap[instance.ClassName]
	if not properties or watching[instance] then
		return
	end

	local connections = {}
	for _, propertyName in ipairs(properties) do
		table.insert(
			connections,
			instance:GetPropertyChangedSignal(propertyName):Connect(function()
				applyProperty(instance, propertyName)
			end)
		)
		applyProperty(instance, propertyName)
	end

	watching[instance] = connections
end

local function unwatchInstance(instance)
	local connections = watching[instance]
	if not connections then
		return
	end
	for _, connection in ipairs(connections) do
		connection:Disconnect()
	end
	watching[instance] = nil
end

function iconModule.Init(container)
	container = container or game

	for _, descendant in ipairs(container:GetDescendants()) do
		watchInstance(descendant)
	end

	container.DescendantAdded:Connect(watchInstance)
	container.DescendantRemoving:Connect(unwatchInstance)

	return iconModule
end

return iconModule
