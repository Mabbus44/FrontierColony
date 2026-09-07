---@class Controls
local EventQueue = require("Classes.eventQueue")
local WorldMap = require("Classes.World.worldMap")
local Globals = require("Classes.globals.lua")

local Controls= {
}

local function Controls:forceRemoteView(player)
  log("force_remote_view (from " .. tostring(player.controller_type) .. tostring(player.physical_controller_type) .. tostring(player.stashed_controller_type) .. ")");
	if not player or not player.valid then return end
	if player.controller_type ~= defines.controllers.remote then
		player.set_controller{type=defines.controllers.remote}
	end
end

local function Controls:removePlayerCharacter(player)
  log("remove_player_character");
	if not player or not player.valid then return end
	local character = player.character
	if character and character.valid then
		player.character = nil
		character.destroy()
	end
end

local function Controls:initPlayer(player)
	player.ticks_to_respawn = nil
	player.disable_space_map = true
	player.toggle_menu_leaves_remote_view = false
	self:removePlayerCharacter(player)
	self:forceRemoteView(player)
end


local function Controls:initEntityRecipeLookupTable()
	Globals.entityRecipes = {}
	for _, recipe in pairs(game.forces.player.recipes) do
    if #recipe.products == 1 then
			local item = prototypes.item[recipe.products[1].name]
			if item and item.place_result then
				Globals.entityRecipes[item.place_result.name] = recipe
			end
    end
	end
	log("recipe lookup table:")
	for entityName, recipe in pairs(Globals.entityRecipes) do
		log(entityName .. " -> " .. recipe.name)
	end
end


local function Controls:initGame()
	local surface = game.surfaces["nauvis"]
	local mgs = surface.map_gen_settings
	mgs.width = WorldMap.width
	mgs.height = WorldMap.height
	surface.map_gen_settings = mgs

	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_disable_crashsite", true)
		remote.call("freeplay", "set_skip_intro", true)
		EventQueue:addEvent(60, WorldMap.addSettlement, WorldMap, 3, 3);
	end
	self:initEntityRecipeLookupTable()
end

return Controls