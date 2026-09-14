---@enum TransportType

local TransportType = {
  BACKPACK = "BACKPACK",
  HORSE = "HORSE",
  CAR = "CAR",
  TRUCK = "TRUCK",
  ROAD_TRAIN = "ROAD_TRAIN"
}

TransportType.ordered = {
  TransportType.BACKPACK,
  TransportType.HORSE,
  TransportType.CAR,
  TransportType.TRUCK,
  TransportType.ROAD_TRAIN
}

return TransportType
