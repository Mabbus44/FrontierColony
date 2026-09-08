local hiddenItems = { "crude-oil-barrel", "fluoroketone-cold-barrel", "fluoroketone-hot-barrel", "heavy-oil-barrel", "light-oil-barrel", "lubricant-barrel", "petroleum-gas-barrel", "sulfuric-acid-barrel", "water-barrel"}

for _, prototypeName in ipairs(hiddenItems) do
	data.raw.item[prototypeName].hidden = true
	data.raw.item[prototypeName].hidden_in_factoriopedia = true
end
