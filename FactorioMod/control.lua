local WorldMap = require("Classes.World.worldMap")
local Settlement = require("Classes.Settlement.settlement")
local EntityData = require("Classes.entityData")
local Constants = require("Classes.constants")
local EventQueue = require("Classes.eventQueue")

script.on_init(function()
  log("on_init");
  WorldMap:createSurface();
	EventQueue:addEvent(60, WorldMap.addSettlement, WorldMap, 3, 3);
end)

script.on_event(defines.events.on_player_created, function(event)
  log("on_player_created");
end)

script.on_event(defines.events.on_cutscene_started, function(event)
  log("on_cutscene_started");
  local player = game.get_player(event.player_index);
  player.exit_cutscene();
end)

script.on_event(defines.events.on_cutscene_cancelled, function(event)
  log("on_cutscene_cancelled");
  local player = game.get_player(event.player_index);
  log("player.teleport: " .. tostring(player.teleport({x = 0, y = 0}, WorldMap:getSurface())));
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