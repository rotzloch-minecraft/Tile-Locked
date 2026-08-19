execute if score #debug TileLockedData matches 1 run tellraw @a ["",{"text":"[TileLocked DEBUG] teleport_player_back for ","color":"aqua"},{"selector":"@a[tag=currentPlayer,limit=1]"}]

# Teleport the player back to their last good position within tile limits
execute as @e[tag=tilelocked,tag=prevPosMarker,sort=nearest,limit=1] rotated as @a[tag=currentPlayer] positioned as @s run tp @s ~ ~ ~ ~ ~
teleport @a[tag=currentPlayer] @e[tag=tilelocked,tag=prevPosMarker,sort=nearest,limit=1]
