-- search for icons here: https://fonts.google.com/icons
local url = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/Material/dist/"

local function fetch(file)
	return loadstring(game:HttpGet(url .. file .. ".lua"))()
end

return {
	["default"] = {
		["dp 18"] = {
			["scale 1"] = fetch("Default18Part1"),
			["scale 2"] = fetch("Default18Part2"),
			["scale 3"] = fetch("Default18Part3"),
			["scale 4"] = fetch("Default18Part4"),
		},
		["dp 24"] = {
			["scale 1"] = fetch("Default24Part1"),
			["scale 2"] = fetch("Default24Part2"),
			["scale 3"] = fetch("Default24Part3"),
			["scale 4"] = fetch("Default24Part4"),
		},
		["dp 36"] = {
			["scale 1"] = fetch("Default36Part1"),
			["scale 2"] = fetch("Default36Part2"),
			["scale 3"] = fetch("Default36Part3"),
			["scale 4"] = fetch("Default36Part4"),
		},
		["dp 48"] = {
			["scale 1"] = fetch("Default48Part1"),
			["scale 2"] = fetch("Default48Part2"),
			["scale 3"] = fetch("Default48Part3"),
			["scale 4"] = fetch("Default48Part4"),
		},
	},
	["outlined"] = {
		["dp 18"] = {
			["scale 1"] = fetch("Outlined18Part1"),
			["scale 2"] = fetch("Outlined18Part2"),
		},
		["dp 24"] = {
			["scale 1"] = fetch("Outlined24Part1"),
			["scale 2"] = fetch("Outlined24Part2"),
		},
		["dp 36"] = {
			["scale 1"] = fetch("Outlined36Part1"),
			["scale 2"] = fetch("Outlined36Part2"),
		},
		["dp 48"] = {
			["scale 1"] = fetch("Outlined48Part1"),
			["scale 2"] = fetch("Outlined48Part2"),
		},
	},
	["round"] = {
		["dp 18"] = {
			["scale 1"] = fetch("Round18Part1"),
			["scale 2"] = fetch("Round18Part2"),
		},
		["dp 24"] = {
			["scale 1"] = fetch("Round24Part1"),
			["scale 2"] = fetch("Round24Part2"),
		},
		["dp 36"] = {
			["scale 1"] = fetch("Round36Part1"),
			["scale 2"] = fetch("Round36Part2"),
		},
		["dp 48"] = {
			["scale 1"] = fetch("Round48Part1"),
			["scale 2"] = fetch("Round48Part2"),
		},
	},
	["sharp"] = {
		["dp 18"] = {
			["scale 1"] = fetch("Sharp18Part1"),
			["scale 2"] = fetch("Sharp18Part2"),
		},
		["dp 24"] = {
			["scale 1"] = fetch("Sharp24Part1"),
			["scale 2"] = fetch("Sharp24Part2"),
		},
		["dp 36"] = {
			["scale 1"] = fetch("Sharp36Part1"),
			["scale 2"] = fetch("Sharp36Part2"),
		},
		["dp 48"] = {
			["scale 1"] = fetch("Sharp48Part1"),
			["scale 2"] = fetch("Sharp48Part2"),
		},
	},
	["two tone"] = {
		["dp 18"] = {
			["scale 1"] = fetch("Twotone18Part1"),
			["scale 2"] = fetch("Twotone18Part2"),
		},
		["dp 24"] = {
			["scale 1"] = fetch("Twotone24Part1"),
			["scale 2"] = fetch("Twotone24Part2"),
		},
		["dp 36"] = {
			["scale 1"] = fetch("Twotone36Part1"),
			["scale 2"] = fetch("Twotone36Part2"),
		},
		["dp 48"] = {
			["scale 1"] = fetch("Twotone48Part1"),
			["scale 2"] = fetch("Twotone48Part2"),
		},
	},
}

