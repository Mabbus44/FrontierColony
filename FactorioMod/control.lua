local WorldMap = require("Classes.World.worldMap")
local Settlement = require("Classes.Settlement.settlement")
local EntityData = require("Classes.entityData")
local Constants = require("Classes.constants")
local EventQueue = require("Classes.eventQueue")
local Controls = require("Classes.controls")

script.on_init(function()
  log("on_init");
	Controls.initGame()		
end)

script.on_event({defines.events.on_player_created, defines.events.on_player_respawned}, function(event)
  log("on_player_created");
	local player = game.get_player(event.player_index)
	Controls.initPlayer(player)
end)

script.on_event(defines.events.on_player_controller_changed, function(event)
  log("on_player_controller_changed");
	local player = game.get_player(event.player_index)
	Controls.forceRemoteView(player)
end)

script.on_nth_tick(10, function(event)
  EventQueue:runEvents(event.tick);
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  log("on_chunk_generated " .. event.surface.name .. " " .. event.position.x .. "," .. event.position.y .. " (" .. event.area.left_top.x .. "," .. event.area.left_top.y .. ")-(" .. event.area.right_bottom.x .. "," .. event.area.right_bottom.y .. ")");
  if event.surface.name == WorldMap:getSurface().name then
    WorldMap:setTiles(event.area.left_top, event.area.right_bottom);
  elseif Settlement:surfaceIsSettlement(event.surface.name) then
    EntityData:forSurface(event.surface).settlement:setTiles(event.area.left_top, event.area.right_bottom)
  end
end)

script.on_event(defines.events.on_gui_opened, function(event)
  log("on_gui_opened");
  if event.entity and event.entity.name == "settlement" then
    local settlement = EntityData:forEntity(event.entity).settlement
    settlement:clicked(event.player_index)
  end
end)

script.on_event(defines.events.on_built_entity, function(event)
  log("on_built_entity");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:addGhost(entity)
  end
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
  log("on_robot_built_entity");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:addGhost(entity)
  end
end)

script.on_event(defines.events.script_raised_built, function(event)
  log("script_raised_built");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:addGhost(entity)
  end
end)

script.on_event(defines.events.on_player_mined_entity, function(event)
  log("on_player_mined_entity");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:removeGhost(entity)
  end
end)

script.on_event(defines.events.on_robot_mined_entity, function(event)
  log("on_robot_mined_entity");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:removeGhost(entity)
  end
end)

script.on_event(defines.events.on_entity_died, function(event)
  log("on_entity_died");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:removeGhost(entity)
  end
end)

script.on_event(defines.events.script_raised_destroy, function(event)
  log("script_raised_destroy");
  local entity = event.entity
  if entity and entity.valid and entity.name == "entity-ghost" andSettlement:surfaceIsSettlement(entity.surface.name) then
    EntityData:forSurface(entity.surface).settlement:removeGhost(entity)
  end
end)