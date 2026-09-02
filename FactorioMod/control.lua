local WorldMap = require("Assets.worldMap")

script.on_init(function()
  game.print("This rund when the game startsr");
  local worldMapSurfaceName = "world_map";
  local WorldMapSurfaceSettings = {
    width = WorldMap.width,
    height = WorldMap.height
  }
  local worldMapSurface = game.create_surface(worldMapSurfaceName, WorldMapSurfaceSettings);

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
  local middleX = WorldMap.width // 2;
  local middleY = WorldMap.height // 2;
  for y, row in pairs(WorldMap.tiles) do
    for x, tile in ipairs(row) do
      table.insert(worldMapTiles, {name = "refined-concrete", position = {x - middleX, y - middleY}});
    end
  end
  
  worldMapSurface.set_tiles(tiles_to_set)

  for _, player in pairs(game.players) do
    player.teleport({x = 0, y = 0}, worldMapSurfaceName)
  end

end)