## We will set our versions as padded 2 - 1.0.6 = 1 00 60 = 10060
# Run our load function again if version is less than 1.0.6
execute unless score #version TileLockedData matches 10060.. run function tilelocked:load
