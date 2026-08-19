# Tick our players
execute as @a[gamemode=!spectator] at @s run function tilelocked:post_tick_player

# Kill our 2d player markers
kill @e[type=marker,tag=tilelocked,tag=player2d]

# i = 0;
# output = []
# while (i++ < 17) {
#     output.push(`execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches ${i} as @e[type=block_display,tag=tilelocked,tag=!color${i},distance=..24] run function tilelocked:tile_init/check_color`)
# }
# copy(output.join('\n'));

# Update tile colors if needed.
# Throttled to every 40 ticks and scoped to entities within 24 blocks of each player -
# previously this ran every single tick as an unbounded, world-wide entity scan
# (@e[...] with no distance/position filter), which on worlds with many unlocked tiles
# had to walk every tilelocked block_display in the whole dimension every tick and could
# freeze the server. Even after bounding to 48 blocks/10 ticks, worlds with a large densely
# tiled area still hung for minutes (confirmed empirically: unaffected by render distance or
# mods, but resolved by moving far from the tiled area) - tightened further to 24 blocks/40
# ticks. See #debug logging below for diagnosing tick-time issues.
execute if score #ticks TileLockedData matches 40.. if score #debug TileLockedData matches 1 run say [TileLocked DEBUG] check_color pass
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 0 as @e[type=block_display,tag=tilelocked,tag=!color0,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 1 as @e[type=block_display,tag=tilelocked,tag=!color1,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 2 as @e[type=block_display,tag=tilelocked,tag=!color2,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 3 as @e[type=block_display,tag=tilelocked,tag=!color3,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 4 as @e[type=block_display,tag=tilelocked,tag=!color4,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 5 as @e[type=block_display,tag=tilelocked,tag=!color5,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 6 as @e[type=block_display,tag=tilelocked,tag=!color6,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 7 as @e[type=block_display,tag=tilelocked,tag=!color7,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 8 as @e[type=block_display,tag=tilelocked,tag=!color8,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 9 as @e[type=block_display,tag=tilelocked,tag=!color9,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 10 as @e[type=block_display,tag=tilelocked,tag=!color10,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 11 as @e[type=block_display,tag=tilelocked,tag=!color11,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 12 as @e[type=block_display,tag=tilelocked,tag=!color12,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 13 as @e[type=block_display,tag=tilelocked,tag=!color13,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 14 as @e[type=block_display,tag=tilelocked,tag=!color14,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 15 as @e[type=block_display,tag=tilelocked,tag=!color15,distance=..24] run function tilelocked:tile_init/check_color
execute if score #ticks TileLockedData matches 40.. as @a[gamemode=!spectator] at @s if score #tileColor TileLockedData matches 16 as @e[type=block_display,tag=tilelocked,tag=!color16,distance=..24] run function tilelocked:tile_init/check_color

# Reset our ticking counters
execute if score #ticks TileLockedData matches 40.. run scoreboard players set #ticks TileLockedData 0
