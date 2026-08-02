# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Tile Locked is a **Minecraft data pack** (not a compiled/scripted program) for Java Edition, `pack_format` 101 (Minecraft 26.1.2). All logic lives in `.mcfunction` files under `data/tilelocked/function/`, driven by vanilla `minecraft:load`/`minecraft:tick` function tags. There is no build step, package manager, or test runner — "code" is Minecraft commands.

## Workflow (build/test/deploy)

- **No compiler/linter/tests exist.** The only correctness check is loading the pack in an actual Minecraft 26.1.2 client/server and observing behavior.
- To test locally: copy or symlink this repo's contents into a world's `datapacks/<name>/` folder, then run `/reload` in-game after making changes.
- Useful in-game debug commands while iterating:
  - `/reload` — reload the data pack after editing `.mcfunction` files.
  - `/function tilelocked:reset` — wipes all placed tile entities/scoreboards and re-runs `load` (fastest way to get back to a clean state while testing).
  - `/trigger TileLockedSettings` — opens the in-game settings menu (difficulty, sound, tile color).
- **CI/"build"**: `.github/workflows/push-actions.yml` runs on every push and simply zips `data/`, `pack.mcmeta`, `pack.png` into an artifact named `Tile-Locked`. There's no validation step — a push that breaks a function will still "build" successfully.

## Architecture

### Tick pipeline
Three custom function tags chain together every tick (see `data/minecraft/tags/function/tick.json`):
`tilelocked:pre_tick` → `tilelocked:tick` → `tilelocked:post_tick`

- **pre_tick**: version check/migration, increments the global `#ticks` counter, then runs `pre_tick_player` for each non-spectator player. This is where tile unlocking/locking decisions and teleport-back-into-bounds logic happen.
- **tick**: initializes newly-joined players (`init_player`), processes the `/trigger TileLockedSettings` menu (settings changes + rendering the tellraw menu).
- **post_tick**: per-player bookkeeping (saves "last good position" marker), periodically (`#ticks >= 10`) repaints tile colors and runs `check_add_tile`/`check_remove_tile` around each player, then cleans up temporary markers.

`load` (via `minecraft:load` tag) creates all scoreboard objectives, sets default option values (only if unset), and sets `gamerule minecraft:respawn_radius 0` / `minecraft:keep_inventory true`. (Game rules were renamed from camelCase to snake_case resource locations in 1.21.11/format 94.1 — `spawnRadius`→`minecraft:respawn_radius`, `keepInventory`→`minecraft:keep_inventory`; don't reintroduce the old camelCase names.)

### World representation — two parallel layers
1. **Visual tiles**: `block_display` entities tagged `tilelocked` rendered as a thin colored glass "slab" (`scale: [1, 0.001, 1]`) sitting on top of the topmost opaque block in a column. Color is driven by the `#tileColor` scoreboard value and repainted via `tile_init/check_color`.
2. **Logic markers**: invisible `minecraft:marker` entities tagged `tilelocked`/`tileMarker`/`unlocked` at the center of each unlocked 1×1 column — these (not the visuals) are what selectors query with `distance=..N` to decide if a player is inside/near an unlocked tile.

A separate `player2d` marker is summoned each tick at a fixed Y (64) directly above/below each player, purely so XZ-only distance checks can be done with vanilla 3D `distance=` selectors without Y interfering.

Because entities can't be selected "as the player who owns this marker" directly, player UUIDs are copied into 4 scoreboard values (`Uuid1`-`Uuid4`, split via `data get entity @s UUID[n]`) and matched against the same 4 scores on marker entities (e.g. `prevPosMarker`) to associate a marker with its owner.

### Tile lifecycle
- `tile_init/calc_available_tiles` computes a player's "tile budget" score (`TileLockedData`) from their XP/levels, based on `#difficulty` (0 = 1 xp/tile via `XpTotal`, 1 = 5 xp/tile via `XpTotal / #cost5`, 2 = 1 level/tile via `XpLevel`).
- `tile_init/init_first_tiles` / `init_tile` spend that budget (deduct xp/levels, play a sound, bump the global `Unlocked` counter) and summon the logic marker(s) for newly unlocked column(s).
- `tile_init/init_unlocked_tile` scans the **entire world height** (Y 320 → -64) at that XZ column and drops a visual tile on every exposed opaque surface (handles caves/overhangs/nether/end all at once).
- `tile_init/check_add_tile` scans a 12×12 area (offsets -5.5..5.5 in both X/Z) around each unlocked marker and calls `check_add_tile_xz` (which scans Y -6..5 relative) to backfill any missing visual tiles, e.g. after terrain changes.
- `tile_init/check_remove_tile` kills any visual tile whose block is no longer opaque or has become covered.
- `tile_init/teleport_player_back` and the "no available tiles" branches in `pre_tick_player` handle the edge case of a player ending up with no unlocked tile nearby (e.g. after Nether/End travel): teleport back to last known good position if close, otherwise to the nearest tile.

### Custom block tag
`data/tilelocked/tags/block/opaque.json` is a hand-maintained list of "solid, fully opaque" blocks (mirrors vanilla opacity semantics) used everywhere a function needs to test "is this a walkable/valid tile surface." When Mojang adds new blocks in a Minecraft version bump, this list needs new entries (see git history: "Add missing tile blocks", "Add a couple of missing blocks", "Add more missing blocks").

### Generated repetitive commands — read before editing
Several `.mcfunction` files (`check_add_tile.mcfunction`, `check_add_tile_xz.mcfunction`, `init_unlocked_tile.mcfunction`, `check_color.mcfunction`, the settings menu in `tick_player.mcfunction`) contain dozens/hundreds of near-identical `execute ...` lines (grid scans, full-world-height Y scans, per-color-index branches, per-setting-value menu rows). Each such file has a **commented-out JavaScript snippet at the top** that was used in a browser console to generate that block via `output.push(...)` + `copy(output.join('\n'))`. If you need to change the range/values (e.g. tile grid radius, Y scan bounds, add a color), **regenerate the block using that JS snippet** rather than hand-editing/adding individual lines — it keeps the pattern consistent and avoids off-by-one mistakes across dozens of lines.

### Settings system
`TileLockedSettings` is a `trigger`-type objective. The client runs `/trigger TileLockedSettings set <code>` (via clickable `tellraw` buttons); `tick_player.mcfunction` matches on `scores={TileLockedSettings=<code>}` to apply the change, then resets the trigger and re-renders the tellraw menu. Codes are grouped by range: `10-12` difficulty, `20-21` unlock sound, `100-116` tile color. Buttons use the modern raw-JSON text component keys `click_event`/`hover_event` (snake_case, not the pre-1.21.5 `clickEvent`/`hoverEvent`); `hover_event`'s `show_text` action takes a `value` field, not `contents`. Keep using this schema for any new menu rows.

### Pack format / pack.mcmeta
`pack.mcmeta` uses `min_format`/`max_format` (both `101`, i.e. major 101 with any minor) as the primary compatibility declaration — since data pack format 88.0 (1.21.9+), a bare `pack_format` integer is no longer sufficient on its own for a modern-only pack, though it's kept here too for graceful degradation/warnings on older clients. Bump `min_format`/`max_format` together when targeting a new major data pack format.

### Versioning/migration
`#version` on the `TileLockedData` objective stores a zero-padded version integer (e.g. `1.0.5` → `10050`) for **this data pack's own release**, unrelated to Minecraft's `pack_format`. `check_version.mcfunction` re-runs `load` if the stored version is older than the current pack's expected value, giving existing worlds a migration path when upgrading the data pack (e.g. re-applying renamed gamerules). Bump this number (and the matching checks in `pre_tick.mcfunction`/`check_version.mcfunction`) whenever `load.mcfunction`'s effects change in a way existing worlds need re-applied.
