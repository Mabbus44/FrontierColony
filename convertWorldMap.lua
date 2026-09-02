local bmp = assert(io.open("worldmap.bmp", "rb"))

-- Read BMP header
bmp:seek("set", 10)
local pixelOffset = string.unpack("<I4", bmp:read(4))

bmp:seek("set", 18)
local width = string.unpack("<I4", bmp:read(4))
local height = string.unpack("<I4", bmp:read(4))

bmp:seek("set", 28)
local bpp = string.unpack("<I2", bmp:read(2))

assert(bpp == 8, "Only 8-bit BMP supported")

-- Read palette
bmp:seek("set", 54)

local palette = {}
local paletteSize = (pixelOffset - 54) / 4

for i = 0, paletteSize - 1 do
    local b = bmp:read(1):byte()
    local g = bmp:read(1):byte()
    local r = bmp:read(1):byte()
    bmp:read(1) -- reserved

    -- Terrain types
    --                          32          96      160     224
    --255, 0,   0     lava,     -montain    -lake   -forest -land
    --0,   255, 0     grass,    -montain    -lake   -forest -land
    --0,   0,   255   ice,      -montain    -lake   -forest -land
    --0,   255, 255   swamp,    -montain    -lake   -forest -land
    --255, 255, 0     desert,   -montain    -lake   -forest -land

    -- Assign tile IDs by RGB value
    local secondaryColor = 0
    if r == 255 and g < 255 and b < 255 then        --lava
        palette[i] = 0
        secondaryColor = g
    elseif r < 255 and g == 255 and b < 255 then    --grass
        palette[i] = 10
        secondaryColor = r
    elseif r < 255 and g < 255 and b == 255 then    --ice
        palette[i] = 20
        secondaryColor = r
    elseif r < 255 and g == 255 and b == 255 then   --swamp
        palette[i] = 30
        secondaryColor = r
    elseif r == 255 and g == 255 and b < 255 then   --desert
        palette[i] = 40
        secondaryColor = b
    else
        palette[i] = -1 -- unknown
    end
    if palette[i] > -1 then
        if secondaryColor >= 32 then palette[i] = palette[i] + 1 end
        if secondaryColor >= 96 then palette[i] = palette[i] + 1 end
        if secondaryColor >= 160 then palette[i] = palette[i] + 1 end
        if secondaryColor >= 224 then palette[i] = palette[i] + 1 end
    end
end

-- Read pixel data
bmp:seek("set", pixelOffset)

local rowSize = math.floor((width + 3) / 4) * 4

local tiles = {}

-- BMP stores rows bottom-up
for y = height, 1, -1 do
    local row = bmp:read(rowSize)
    tiles[y] = {}

    for x = 1, width do
        local paletteIndex = row:byte(x)
        tiles[y][x] = palette[paletteIndex] or -1
    end
end

bmp:close()

-- Write Lua file
local out = assert(io.open("FactorioMod/Assets/worldMap.lua", "w"))

out:write("---@class WorldMap\n")
out:write("---@field width number\n")
out:write("---@field height number\n")
out:write("---@field tiles number[][]\n\n")

out:write("local WorldMap = {\n")
out:write(("    width = %d,\n"):format(width))
out:write(("    height = %d,\n"):format(height))
out:write("    tiles = {\n")

for y, row in ipairs(tiles) do
    out:write("        {")
    for x, tile in ipairs(row) do
        out:write(("%02d"):format(tile))
        if x < #row then out:write(",") end
    end
    out:write("}")
    if y < #tiles then out:write(",") end
    out:write("\n")
end

out:write("    }\n")
out:write("}\n")
out:write("return WorldMap;\n")
out:close()