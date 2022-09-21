local present, alpha = pcall(require, "alpha")

if not present then
	return
end
require("base46").load_highlight("alpha")
math.randomseed(os.time())

local COMMON_CODE_DIRS = {
	["/mnt/klet/koda/cotko"] = "cotko",
	["/mnt/klet/koda/gid"] = "globalID"
}

local function pick_color()
	local colors = { "AlphaHeader", "SpecialComment", "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

-- https://github.com/rcalimlim/dotfiles/blob/main/.config/nvim/lua/plugins/alpha.lua
local col = function(strlist, opts, optsFirstCol)
	-- strlist is a TABLE of TABLES, representing columns of text
	-- opts is a text display option

	-- column spacing
	local padding = 6
	-- fill lines up to the maximim length with 'fillchar'
	local fillchar = " "
	-- columns padding char (for testing)
	local padchar = " "

	-- define maximum string length in a table
	local maxlen = function(str)
		local max = 0
		for i in pairs(str) do
			if #str[i] > max then
				max = #str[i]
			end
		end
		return max
	end

	-- add as much right-padding to align the text block
	local pad = function(str, max)
		local strlist = {}
		for i in pairs(str) do
			if #str[i] < max then
				local newstr = str[i] .. string.rep(fillchar, max - #str[i])
				table.insert(strlist, newstr)
			else
				table.insert(strlist, str[i])
			end
		end
		return strlist
	end

	-- this is a table for text strings
	local values = {}
	-- process all the lines
	for i = 1, maxlen(strlist) do
		local str = ""
		-- process all the columns but last, because we dont wand extra padding
		-- after last column
		for column = 1, #strlist - 1 do
			local maxstr = maxlen(strlist[column])
			local padded = pad(strlist[column], maxstr)
			if strlist[column][i] == nil then
				str = str .. string.rep(fillchar, maxstr) .. string.rep(padchar, padding)
			else
				str = str .. padded[i] .. string.rep(padchar, padding)
			end
		end

		-- lets process the last column, no extra padding
		do
			local maxstr = maxlen(strlist[#strlist])
			local padded = pad(strlist[#strlist], maxstr)
			if strlist[#strlist][i] == nil then
				str = str .. string.rep(fillchar, maxlen(strlist[#strlist]))
			else
				str = str .. padded[i]
			end
		end

		-- insert result into output table
		local colOpts = opts
		if i == 1 and optsFirstCol ~= nil then
			colOpts = optsFirstCol
		end
		table.insert(values, { type = "text", val = str, opts = colOpts })
	end

	return values
end

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = "right",
		hl = "AlphaButtons",
	}

	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local function getSessionCols()
	local sessions = require("session_manager.utils").get_sessions()
	local names = {}
	local collected = {}
	local sessResult = {}
	local keymapchars = {
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
		"p",
		"r",
		"s",
		"t",
		"u",
		"v",
		"z",
	}
	local usedkeymaps = {}
	local sessionNames = {}

	for _, session in ipairs(sessions) do
		table.insert(names, session.dir.filename)
		sessionNames[session.dir.filename] = session.filename
	end

	table.sort(names)

	for _, name in ipairs(names) do
		local sname = name:gsub(vim.loop.os_homedir(), "~")
		local target = "other"
    local prefix = ''

		for cd, cdlbl in pairs(COMMON_CODE_DIRS) do
			local cdpos = sname:find(cd)
			if cdpos == 1 then
				target = cdlbl

        local sub = sname:sub(string.len(cd) + 1)
        local lastSepIdx = sub:match("^.*()/")
        if lastSepIdx == nil then
          prefix = sub
          break
        end

        sub = sub:sub(1, lastSepIdx - 1)
        lastSepIdx = sub:match("^.*()/")

        if lastSepIdx ~= nil then
          sub = sub:sub(lastSepIdx + 1)
          prefix = "{" .. sub .. '}..'
        else
          prefix = ""
        end



				break
			end
		end

		if sname:find("~") ~= 1 then
			local lastSepIdx = sname:match("^.*()/")
			sname = sname:sub(lastSepIdx)
		end

		if collected[target] == nil then
			collected[target] = { target }
			usedkeymaps[target] = {}
			table.insert(sessResult, collected[target])
		end

		local keymap
		for _, k in ipairs(keymapchars) do
			if usedkeymaps[target][k] == nil then
				usedkeymaps[target][k] = true
				keymap = string.sub(target, 1, 1) .. " " .. k
				break
			end
		end

		table.insert(collected[target], keymap .. "    " .. prefix .. sname)

		local lsname = sessionNames[name]

		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			keymap:gsub("%s", ""),
			":lua require('session_manager.utils').load_session('" .. lsname .. "')<CR>",
			{ noremap = true, silent = true }
		)
	end

	return sessResult
end

local logo = {
	"",
	"█▀▀ █▀█ ▀█▀ █▄▀ █▀█",
	"█▄▄ █▄█ ░█░ █░█ █▄█",
	"",
}

alpha.setup({
	layout = {
		{ type = "padding", val = 2 },
		{
			type = "text",
			val = logo,
			opts = {
				position = "center",
				hl = pick_color(),
			},
		},
		{ type = "padding", val = 2 },
		{ type = "padding", val = 2 },
		{
			type = "group",
			val = {
				button("e", "  New Buffer  ", ":enew<CR>"),
				button("f f", "  Find File  ", ":Telescope find_files<CR>"),
				button("f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
				button("b", "  Bookmarks  ", ":Telescope marks<CR>"),
				button("s", "  Sessions", ":lua require('session_manager').load_session()<CR>"),
				button("l s", "  Last session", ":lua require('session_manager').load_last_session()<CR>"),
				button("q", "  Quit", ":qa<CR>"),
			},
			position = "center",
		},
		{ type = "padding", val = 2 },
		{
			type = "text",
			val = "Sessions",
			opts = {
				position = "center",
				hl = "Number",
			},
		},
		{ type = "padding", val = 1 },
		{
			type = "group",
			val = col(getSessionCols(), {
				position = "center",
			}, {
				position = "center",
				hl = "Identifier",
			}),
		},
	},
})
