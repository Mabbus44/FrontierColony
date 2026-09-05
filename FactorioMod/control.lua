local WorldMap = require("Classes.World.worldMap")
local Settlement = require("Classes.Settlement.settlement")
local EntityData = require("Classes.entityData")
local Constants = require("Classes.constants")
local EventQueue = require("Classes.eventQueue")

script.on_init(function()
  log("on_init");

	local surface = game.surfaces["nauvis"]
	local mgs = surface.map_gen_settings
	mgs.width = WorldMap.width
	mgs.height = WorldMap.height
	surface.map_gen_settings = mgs

	if remote.interfaces["freeplay"] then
		remote.call("freeplay", "set_disable_crashsite", true)
		remote.call("freeplay", "set_skip_intro", true)
  end
		
	EventQueue:addEvent(60, WorldMap.addSettlement, WorldMap, 3, 3);
end)

local function force_remote_view(player)
	if not player or not player.valid then return end
	if player.controller_type ~= defines.controllers.remote then
		player.set_controller{type=defines.controllers.remote}
	end
end

local function remove_player_character(player)
	if not player or not player.valid then return end
	local character = player.character
	if character and character.valid then
		player.character = nil
		character.destroy()
	end
end

script.on_event({defines.events.on_player_created, defines.events.on_player_respawned}, function(event)
	local player = game.get_player(event.player_index)
	force_remote_view(player)
	remove_player_character(player)
	player.ticks_to_respawn = nil
end)

script.on_event(defines.events.on_player_controller_changed, function(event)
	local player = game.get_player(event.player_index)
	force_remote_view(player)
end)

script.on_nth_tick(10, function(event)
  EventQueue:runEvents(event.tick);
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  log("on_chunk_generated " .. event.surface.name .. " " .. event.position.x .. "," .. event.position.y .. " (" .. event.area.left_top.x .. "," .. event.area.left_top.y .. ")-(" .. event.area.right_bottom.x .. "," .. event.area.right_bottom.y .. ")");

  if event.surface.name == WorldMap:getSurface().name then
    WorldMap:setTiles(event.area.left_top, event.area.right_bottom);
  elseif event.surface.name:sub(1, #Constants.settlementSurfaceNameBase) == Constants.settlementSurfaceNameBase then
    EntityData:forSurface(event.surface).settlement:setTiles(event.area.left_top, event.area.right_bottom)
  end
end)

script.on_event(defines.events.on_gui_opened, function(event)
  if event.entity and event.entity.name == "settlement" then
    local settlement = EntityData:forEntity(event.entity).settlement
    settlement:clicked(event.player_index)
  end
end)