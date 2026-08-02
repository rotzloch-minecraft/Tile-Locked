# Check we are up to date
execute unless score #version TileLockedData matches 10050.. run function tilelocked:check_version
execute unless score #version TileLockedData matches 10050.. run scoreboard players set #version TileLockedData 10050

# Add to our tick counts
scoreboard players add #ticks TileLockedData 1

# Run checks on our players
execute as @a[gamemode=!spectator] at @s run function tilelocked:pre_tick_player
