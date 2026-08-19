# generate markers at a specific y-position so other markers can all remain relative
summon minecraft:marker ~ 64 ~ {Tags: [tilelocked, player2d, currentPlayer]}

# Tag the current player for use within this function
tag @s add currentPlayer

# Update our available tiles
function tilelocked:tile_init/calc_available_tiles

# Mark tile as unlocked if player has no tiles unlocked close by (no loaded chunks or different dimension)
# "distance=-0.." was a bug: -0 == 0, so "distance=-0.." means "distance >= 0", i.e. NO upper bound at
# all - scanning every "unlocked" marker in the entire dimension regardless of distance. Bounded to 24
# blocks (matching the radius used elsewhere) to actually check "close by" as intended. Also throttled
# to every 40 ticks (matching post_tick.mcfunction/post_tick_player.mcfunction).
execute if score #ticks TileLockedData matches 40.. as @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] at @s unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..24] if loaded ~ ~ ~ run function tilelocked:tile_init/init_first_tiles

# If no tile marker is nearby, we need to unlock a tile or teleport the player back to within the tile limits (within 0.71 distance, corner of block is about 0.707 away from the center)
# All three branches below require "if loaded ~ ~ ~" at the player's own position (chunk around the
# player actually loaded) - without it, right after login the player's own chunk (and thus their own
# unlocked markers) may not be loaded yet, so "unless entity ...unlocked..." looks like "no tile nearby"
# every tick while chunks stream in, repeatedly yanking the player towards the globally nearest tile.
# The "teleport to nearest tile" branch additionally requires "if loaded ~ ~ ~" at the DESTINATION too -
# the nearest block_display can be arbitrarily far away (no distance cap) in a chunk that is itself not
# loaded, so without this check the player gets teleported straight into unloaded terrain.
# if no available tiles, player within 3 blocks from last good position teleport back there
execute if score @s TileLockedData matches ..0 at @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] if loaded ~ ~ ~ unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..0.71] if entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..3] at @s as @e[tag=tilelocked,tag=prevPosMarker,sort=nearest,limit=1] at @s run function tilelocked:tile_init/teleport_player_back
# if no available tiles, player further than 3 blocks from last good position teleport to middle of nearest tile
execute if score @s TileLockedData matches ..0 if score #debug TileLockedData matches 1 at @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] if loaded ~ ~ ~ unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..0.71] unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..3] run say [TileLocked DEBUG] pre_tick_player: no unlocked tile nearby, teleporting to nearest tile anywhere for @s
execute if score @s TileLockedData matches ..0 at @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] if loaded ~ ~ ~ unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..0.71] unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..3] at @s positioned ~ ~-1 ~ as @e[type=block_display,tag=tilelocked,distance=0..,sort=nearest,limit=1] at @s if loaded ~ ~ ~ run teleport @a[tag=currentPlayer] ~ ~1 ~
# if has available tile, unlock the new tile
execute if score @s TileLockedData matches 1.. as @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] at @s unless entity @e[type=marker,tag=tilelocked,tag=unlocked,distance=..0.71] if loaded ~ ~ ~ run function tilelocked:tile_init/init_tile

# Remove temporary tag so that it can be used by the next player
tag @e[type=marker,tag=tilelocked,tag=player2d,tag=currentPlayer] remove currentPlayer
tag @s remove currentPlayer
