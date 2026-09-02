local WorldMap = require("Assets.worldMap")
local worldMapSurfaceName = "world_map";

script.on_init(function()
  log("on_init");
  local WorldMapSurfaceSettings = {
    width = WorldMap.width,
    height = WorldMap.height
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
  local empty_map_gen_settings = {
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
  };

  local worldMapTiles = {}
  local middleX = math.floor(WorldMap.width / 2);
  local middleY = math.floor(WorldMap.height / 2);
  for y, row in pairs(WorldMap.tiles) do
    for x, tile in ipairs(row) do
      table.insert(worldMapTiles, {name = "refined-concrete", position = {x - middleX, y - middleY}});
    end
  end
  
  worldMapSurface.set_tiles(worldMapTiles)
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