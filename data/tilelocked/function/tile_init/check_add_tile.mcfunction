# x = 2.5;
# output = []
# while (x --> -2) {
#     z = 2.5;
#     while (z --> -2) {
#             output.push(`execute align xyz positioned ~${x} 64 ~${z} if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~${x} ~ ~${z} run function tilelocked:tile_init/check_add_tile_xz`)
#     }
# }
# copy(output.join('\n'));

# Add tiles if missing from blocks
# Grid shrunk from 12x12 to 6x6 (144 -> 36 cells) - on worlds with a large already-unlocked area,
# nearly every cell's "if entity unlocked" check succeeds, so this ran check_add_tile_xz (12 more
# entity checks each) for up to 144 cells every throttle window, which could take the server minutes
# to work through and hang the game. This is a self-heal/repair pass (CLAUDE.md), not required for
# core gameplay, so a smaller radius is an acceptable tradeoff for not hanging the server.

execute if score #debug TileLockedData matches 1 run say [TileLocked DEBUG] check_add_tile grid scan for @s

# Check if this x/z axis is unlocked, if so, check the tiles are displayed correctly
execute align xyz positioned ~2.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~2.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~2.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~2.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~2.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~2.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~2.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~1.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~1.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~0.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~0.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-0.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-0.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-1.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-1.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~2.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~-0.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~-0.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~-1.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~-1.5 run function tilelocked:tile_init/check_add_tile_xz
execute align xyz positioned ~-2.5 64 ~-2.5 if entity @e[tag=tilelocked,tag=unlocked,distance=..0.1] positioned as @s align xyz positioned ~-2.5 ~ ~-2.5 run function tilelocked:tile_init/check_add_tile_xz
