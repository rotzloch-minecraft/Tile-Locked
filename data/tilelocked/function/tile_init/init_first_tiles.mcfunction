execute if score #debug TileLockedData matches 1 run tellraw @a ["",{"text":"[TileLocked DEBUG] init_first_tiles starting for ","color":"aqua"},{"selector":"@a[tag=currentPlayer,limit=1]"}]

# We summon a tile marker at the current location and then process the unlocked tiles
execute as @s[tag=currentPlayer] align xyz positioned ~1.5 ~ ~1.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~0.5 ~ ~1.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~-0.5 ~ ~1.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}

execute as @s[tag=currentPlayer] align xyz positioned ~1.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~0.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~-0.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}

execute as @s[tag=currentPlayer] align xyz positioned ~1.5 ~ ~-0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~0.5 ~ ~-0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}
execute as @s[tag=currentPlayer] align xyz positioned ~-0.5 ~ ~-0.5 run summon minecraft:marker ~ ~ ~ {Tags: [tilelocked, tileMarker, unlocked]}

execute as @e[type=marker,tag=tileMarker,tag=unlocked,distance=..1.1,sort=nearest,limit=1] at @s run function tilelocked:tile_init/init_unlocked_tile

# Add 9 to the amount of unlocked tiles
scoreboard players add Unlocked TileLockedData 9