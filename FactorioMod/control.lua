local WorldMap = require("Classes.World.worldMap")
local worldMapSurfaceName = "world_map";

script.on_init(function()
  log("on_init");
  WorldMap:createSurface();
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
  local nauvis = game.surfaces["nauvis"];
  log("Surfaces before");
  for name, surface in pairs(game.surfaces) do
    log("Surface: " .. name);
  end
  if nauvis then
    log("nauvis deleted");
    log("game.delete_surface: " .. tostring(game.delete_surface(nauvis)));
  end
  log("Surfaces after");
  for name, surface in pairs(game.surfaces) do
    log("Surface: " .. name);
  end
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  log("on_chunk_generated " .. event.surface.name .. " " .. event.position.x .. "," .. event.position.y .. " (" .. event.area.left_top.x .. "," .. event.area.left_top.y .. ")-(" .. event.area.right_bottom.x .. "," .. event.area.right_bottom.y .. ")");

  if event.surface.name == WorldMap:getSurface().name then
    WorldMap:setTiles(event.area.left_top, event.area.right_bottom);
  end

end)