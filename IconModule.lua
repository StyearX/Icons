local cloneref = (cloneref or clonereference or function(i) return i end)
local HttpService = cloneref(game:GetService("HttpService"))

local function httpGet(url)
	if game.HttpGet then
		return game:HttpGet(url, true)
	else
		return HttpService:GetAsync(url)
	end
end

local BASE = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/"

local PACK_URLS = {
	lucide    = BASE .. "lucide/dist/Icons.lua",
	solar     = BASE .. "solar/dist/Icons.lua",
	craft     = BASE .. "craft/dist/Icons.lua",
	geist     = BASE .. "geist/dist/Icons.lua",
	sfsymbols = BASE .. "sfsymbols/dist/Icons.lua",
	gravity   = BASE .. "gravity/dist/Icons.lua",
	gmi       = BASE .. "GoogleMaterialIcons/dist/Icons.lua",
	hero      = BASE .. "hero/dist/Icons.lua",
	feather   = BASE .. "Feather/dist/Icons.lua",
	bootstrap = BASE .. "Bootstrap/dist/Icons.lua",
	phosphor  = BASE .. "Phosphor/dist/Icons.lua",
	tabler    = BASE .. "Tabler/dist/Icons.lua",
	pixelart  = BASE .. "PixelArtsIcons/dist/Icons.lua",
	prime     = BASE .. "prime/dist/Icons.lua",
}

local VARIANT_PACK_URLS = {
	fluent = {
		_default = "filled",
		filled   = BASE .. "Fluent/dist/Variant/Filled/Icons.lua",
		outlined = BASE .. "Fluent/dist/Variant/Outlined/Icons.lua",
	},
	mynaui = {
		_default = "solid",
		solid    = BASE .. "MynaUi/dist/Variant/Solid/Icons.lua",
		regular  = BASE .. "MynaUi/dist/Variant/Regular/Icons.lua",
	},
	weui = {
		_default = "filled",
		filled   = BASE .. "WeUi/dist/Variant/Filled/Icons.lua",
		outlined = BASE .. "WeUi/dist/Variant/Outlined/Icons.lua",
	},
}

local CACHE_FOLDER = "IconModuleCache"

local function diskRead(key)
	if not (isfolder and isfile and readfile) then return nil end
	local path = CACHE_FOLDER .. "/" .. key .. ".lua"
	if not isfile(path) then return nil end
	local ok, body = pcall(readfile, path)
	if not ok or not body or body == "" then return nil end
	local ok2, chunk = pcall(loadstring, body)
	if not ok2 or not chunk then pcall(delfile, path); return nil end
	local ok3, result = pcall(chunk)
	if not ok3 then pcall(delfile, path); return nil end
	return result
end

local function diskWrite(key, body)
	if not (isfolder and makefolder and writefile) then return end
	pcall(function()
		if not isfolder(CACHE_FOLDER) then makefolder(CACHE_FOLDER) end
		writefile(CACHE_FOLDER .. "/" .. key .. ".lua", body)
	end)
end

local loadedPacks = {}

local function loadPack(cacheKey, url)
	if loadedPacks[cacheKey] then return loadedPacks[cacheKey] end

	local result = diskRead(cacheKey)

	if not result then
		local ok, body = pcall(httpGet, url)
		if not ok or not body or #body < 50 then return nil end
		local ok2, chunk = pcall(loadstring, body)
		if not ok2 or not chunk then return nil end
		local ok3, res = pcall(chunk)
		if not ok3 then return nil end
		result = res
		diskWrite(cacheKey, body)
	end

	local pack
	if type(result) == "table" and result.Icons then
		pack = { _sprites = result.Spritesheets or {}, _icons = result.Icons }
	else
		pack = result
	end

	loadedPacks[cacheKey] = pack
	return pack
end

local function resolvePath(path)
	local parts = {}
	for segment in path:gmatch("[^/]+") do
		table.insert(parts, segment)
	end

	if #parts == 0 then return nil end

	local p1 = parts[1]:lower()

	if #parts >= 3 then
		local variantInfo = VARIANT_PACK_URLS[p1]
		if variantInfo then
			local v = parts[2]:lower()
			local url = variantInfo[v]
			if url then
				return p1 .. "-" .. v, table.concat(parts, "/", 3), url
			end
		end
	end

	if #parts >= 2 then
		local iconName = table.concat(parts, "/", 2)

		local variantInfo = VARIANT_PACK_URLS[p1]
		if variantInfo then
			local v = variantInfo._default
			return p1 .. "-" .. v, iconName, variantInfo[v]
		end

		local url = PACK_URLS[p1]
		if url then
			return p1, iconName, url
		end
	end

	return "lucide", path, PACK_URLS.lucide
end

local function resolveIcon(path)
	local cacheKey, iconName, url = resolvePath(path)
	if not cacheKey then return nil end

	local pack = loadPack(cacheKey, url)
	if not pack then return nil end

	if pack._icons then
		local icon = pack._icons[iconName]
		if not icon then return nil end

		local sheetKey = tostring(icon.Image)
		local imageUrl = pack._sprites[sheetKey] or sheetKey
		local offset = icon.ImageRectOffset or icon.ImageRectPosition or Vector2.zero
		local size   = icon.ImageRectSize or Vector2.zero

		return {
			image      = imageUrl,
			rectOffset = offset,
			rectSize   = size,
			parts      = icon.Parts,
		}
	end

	local assetId = pack[iconName]
	if type(assetId) == "string" and assetId:find("rbxassetid://") then
		return {
			image      = assetId,
			rectOffset = Vector2.zero,
			rectSize   = Vector2.zero,
		}
	end

	return nil
end

local IconModule = {}

function IconModule.Get(path)
	return resolveIcon(path)
end

function IconModule.Apply(instance, path)
	local icon = resolveIcon(path)
	if not icon then return end

	instance.Image           = icon.image
	instance.ImageRectOffset = icon.rectOffset
	instance.ImageRectSize   = icon.rectSize

	for _, child in ipairs(instance:GetChildren()) do
		if child:GetAttribute("__iconPart") then child:Destroy() end
	end

	if icon.parts then
		local providerPath = path:match("^(.+)/[^/]+$") or ""
		for _, partName in ipairs(icon.parts) do
			local partIcon = resolveIcon(providerPath .. "/" .. partName)
			if partIcon then
				local part = Instance.new(instance.ClassName)
				part.Name                   = "IconPart"
				part.BackgroundTransparency = 1
				part.Size                   = UDim2.new(1, 0, 1, 0)
				part.Image                  = partIcon.image
				part.ImageRectOffset        = partIcon.rectOffset
				part.ImageRectSize          = partIcon.rectSize
				part:SetAttribute("__iconPart", true)
				part.Parent                 = instance
			end
		end
	end
end

local watching = {}
local WATCHED_CLASSES = { ImageLabel = true, ImageButton = true }

local function applyIfRaw(instance)
	if not WATCHED_CLASSES[instance.ClassName] then return end
	local ok, value = pcall(function() return instance.Image end)
	if not ok or type(value) ~= "string" or value == "" then return end
	if value:find("rbxassetid://") or value:find("rbxasset://") or value:find("https?://") then return end
	IconModule.Apply(instance, value)
end

local function watchInstance(instance)
	if not WATCHED_CLASSES[instance.ClassName] or watching[instance] then return end
	watching[instance] = instance:GetPropertyChangedSignal("Image"):Connect(function()
		applyIfRaw(instance)
	end)
	applyIfRaw(instance)
end

local function unwatchInstance(instance)
	local conn = watching[instance]
	if conn then conn:Disconnect() end
	watching[instance] = nil
end

function IconModule.Watch(container)
	container = container or game
	for _, desc in ipairs(container:GetDescendants()) do
		watchInstance(desc)
	end
	container.DescendantAdded:Connect(watchInstance)
	container.DescendantRemoving:Connect(unwatchInstance)
	return IconModule
end

function IconModule.RegisterPack(name, url)
	PACK_URLS[name:lower()] = url
end

function IconModule.RegisterVariantPack(name, variantTable)
	VARIANT_PACK_URLS[name:lower()] = variantTable
end

function IconModule.Preload(path)
	task.spawn(function()
		local cacheKey, _, url = resolvePath(path .. "/dummy")
		if cacheKey and url then loadPack(cacheKey, url) end
	end)
end

return IconModule
