local WorldMap = require("Assets.worldMap")
local worldMapSurfaceName = "world_map";

script.on_init(function()
  log("on_init");
  local WorldMapSurfaceSettings = {
    width = WorldMap.width,
    height = WorldMap.height,
		default_enable_all_autoplace_controls = false,
		autoplace_controls = {}, 
		autoplace_settings = {
				["tile"] = {
						settings = {
								["out-of-map"] = { frequency = "normal", size = "normal", richness = "normal" }
						}
				}
		},
		starting_area = "none",
		cliffiness = 0
  }
	log("Surfaces before");
	for name, surface in pairs(game.surfaces) do
		log("Surface: " .. name);
	end
  local worldMapSurface = game.create_surface(worldMapSurfaceName, WorldMapSurfaceSettings);
	log("Surfaces after");
	for name, surface in pairs(game.surfaces) do
		log("Surface: " .. name);
	end
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
	log("player.teleport: " .. tostring(player.teleport({x = 0, y = 0}, worldMapSurfaceName)));
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

  local worldMapSurface = event.surface;
	if worldMapSurface.name ~= worldMapSurfaceName then
		return;
	end
  local middleX = math.floor(WorldMap.width / 2) + 1;	-- This will generate from -a to +a if odd, and -a to +(a-1) if even. This is the same as the built in generation does
  local middleY = math.floor(WorldMap.height / 2) + 1;
	local minX = math.max(1 - middleX, event.area.left_top.x);
	local minY = math.max(1 - middleY, event.area.left_top.y);
	local maxX = math.min(WorldMap.width - middleX, event.area.right_bottom.x-1);
	local maxY = math.min(WorldMap.height - middleY, event.area.right_bottom.y-1);
  if minX > maxX or minY > maxY then
		log("Chunk outside map, skipping tile placement");
		return;
	end;
	local worldMapTiles = {};
	log("Setting (" .. minX .. "," .. minY .. ")-(" .. maxX .. "," .. maxY .. ")");
	for y = minY, maxY do
    for x = minX, maxX do
      table.insert(worldMapTiles, {name = "refined-concrete", position = {x, y}});
    end
  end
  worldMapSurface.set_tiles(worldMapTiles);
end)