## We will set our versions as padded 2 - 1.0.5 = 1 00 50 = 10050
# Run our load function again if version is less than 1.0.5
execute unless score #version TileLockedData matches 10050.. run function tilelocked:load
