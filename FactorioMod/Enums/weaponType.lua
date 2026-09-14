---@enum WeaponType

local WeaponType = {
  AXE = "AXE",
  PISTOL = "PISTOL",
  MACHINE_GUN = "MACHINE_GUN",
  FLAME_THROWER = "FLAME_THROWER",
  POISON_THROWER = "POISON_THROWER",
  LASER_RIFLE = "LASER_RIFLE",
  FREEZE_RAY = "FREEZE_RAY",
  ROCKET_LAUNCHER = "ROCKET_LAUNCHER"
}

WeaponType.ordered = {
  WeaponType.AXE,
  WeaponType.PISTOL,
  WeaponType.MACHINE_GUN,
  WeaponType.FLAME_THROWER,
  WeaponType.POISON_THROWER,
  WeaponType.LASER_RIFLE,
  WeaponType.FREEZE_RAY,
  WeaponType.ROCKET_LAUNCHER
}

return WeaponType
