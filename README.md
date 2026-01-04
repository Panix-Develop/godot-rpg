# Godot RTS RPG - Phase 2

A Warcraft 3-style Real-Time Strategy RPG game built with Godot 4.x featuring isometric camera, unit selection, character progression, and comprehensive HUD systems.

## Features

### ✅ Implemented (Phase 1 MVP)
- **Isometric Camera**
  - WASD/Arrow key movement
  - Edge scrolling (20px margin)
  - Mouse wheel zoom (10-30 range)
  - Map bounds to prevent leaving terrain
  
- **Unit Selection**
  - Single unit selection (left-click)
  - Box selection (click-drag)
  - Multi-selection (Shift+Click, Shift+Drag)
  - Green selection indicators
  - Visual selection box feedback
  
- **Unit Movement**
  - Right-click movement commands
  - Smooth rotation and movement
  - Formation spread for multiple units
  - Collision handling with obstacles
  - Units stop at destination
  
### ✅ Implemented (Phase 2 - HUD & RPG Systems)
- **Unit Classification**
  - Player unit (Blue): First spawned unit, XP gain enabled
  - Friendly units (Green): Allied NPCs
  - Neutral units (Yellow): Non-hostile NPCs
  - Enemy units (Red): Hostile NPCs
  - Color-coded materials for instant identification
  
- **Stats & Leveling System**
  - 6 Core Stats: Strength, Constitution, Dexterity, Agility, Intelligence, Wisdom
  - Derived Stats: Attack Damage (base + STR×2), Armor (base + DEX), Max Health (base + CON×10)
  - Experience & Levels: Player gains XP, levels up automatically (5 stat points per level)
  - NPC Scaling: Non-player units have stats scaled by level (base + level×2)
  
- **Enhanced HUD System**
  - Top Menu Bar: Settings button to configure UI preferences
  - Bottom Panel (250px): Portrait, name, level, health, XP bar, all 6 stats, combat stats, unspent points
  - Player-Centric Display: Shows player info when no selection
  - Settings Panel: Health bar mode (never/always/injured), name display toggles (9 options), format preferences
  - All settings apply immediately to game view
  
- **Map View Overlays**
  - Floating Health Bars: Billboard SubViewport displays above units (configurable format: bar/numbers/percent)
  - Name Labels: Label3D with outline, respects unit type settings
  - Level Display: "Lvl X" above each unit (toggleable)
  - Dynamic Visibility: Follows GameSettings preferences (show on injury, always, never)
  - Updates on Health Changes: Real-time health bar synchronization
  
- **Debug Menu (F12)**
  - Level Control: Add levels to selected unit
  - Experience Addition: Grant XP to player unit
  - Unit Spawning: Create neutral/enemy units at random positions
  - Stat Modification: Add points to any stat for selected unit
  - Status Display: Shows current selection info

## How to Run

1. Open project in Godot 4.x
2. Press **F5** to run
3. Use mouse and keyboard to control camera and units

## Controls

| Action | Input |
|--------|-------|
| Camera Movement | WASD, Arrow Keys, Mouse to Screen Edges |
| Camera Zoom | Mouse Wheel Up/Down |
| Select Unit | Left-Click |
| Box Selection | Left-Click + Drag |
| Add to Selection | Shift + Left-Click |
| Move Unit(s) | Right-Click on Terrain |
| Open Settings | Click Menu Button (Top-Left) |
| Toggle Debug Menu | F12 |

## Performance Testing

To test with different unit counts:

1. Open `scenes/world.tscn`
2. Select the root "Main" node
3. In Inspector, change "Test Unit Count" to 20 or 50
4. Run project (F5)
5. Check FPS in Debug > Monitor > FPS

**Performance Targets:**
- 60 FPS with 50+ units
- Smooth box selection with all units
- Formation movement without lag

## Project Structure

```
godot-test/
├── scenes/
│   ├── components/
│   │   └── floating_ui.tscn        # Floating health/name/level UI
│   ├── units/
│   │   ├── rts_unit.tscn           # Base unit template
│   │   ├── player_unit.tscn        # Player unit variant
│   │   ├── enemy_unit.tscn         # Enemy unit variant
│   │   └── neutral_unit.tscn       # Neutral unit variant
│   ├── ui/
│   │   ├── hud.tscn                # Main HUD interface
│   │   ├── settings_panel.tscn     # Settings dialog
│   │   └── debug_panel.tscn        # Debug menu (F12)
│   └── world.tscn                  # Main game scene
├── scripts/
│   ├── autoloads/
│   │   └── game_settings.gd        # Global settings singleton
│   ├── components/
│   │   └── floating_ui.gd          # Floating UI logic
│   ├── units/
│   │   └── rts_unit.gd             # Unit behavior + stats
│   ├── systems/
│   │   └── selection_manager.gd    # Selection & commands
│   ├── ui/
│   │   ├── hud.gd                  # HUD controller
│   │   ├── settings_panel.gd       # Settings UI logic
│   │   └── debug_panel.gd          # Debug menu logic
│   └── camera_controller.gd        # Camera movement
├── assets/
│   └── materials/
│       ├── mat_player.tres         # Blue material
│       ├── mat_friendly.tres       # Green material
│       ├── mat_neutral.tres        # Yellow material
│       └── mat_enemy.tres          # Red material
├── .tasks/
│   ├── prd-hud-expansion-and-bug-fixes.md  # Phase 2 PRD
│   ├── tasks-hud-expansion-and-bug-fixes.md # Phase 2 tasks
│   └── archive/                    # Completed tasks
└── README.md
```

## Development Status

**Phase 1 (MVP):** ✅ Complete
- All core systems implemented
- Camera, selection, movement mechanics
- Basic HUD

**Phase 2 (HUD & RPG Systems):** ✅ Complete
- Unit classification (Player/Friendly/Neutral/Enemy)
- Stats & leveling system (6 core stats + derived stats)
- Enhanced HUD with settings panel
- Floating health bars, names, levels
- Debug menu for testing
- All critical bugs fixed

**Phase 3 (Combat):** 🔲 Not Started
- Attack commands
- Damage calculations using stats
- Combat animations
- Unit death and respawn

**Phase 4 (Abilities):** 🔲 Not Started
- Active abilities
- Cooldowns
- Mana system
- Hero units

See [.tasks/prd-hud-expansion-and-bug-fixes.md](.tasks/prd-hud-expansion-and-bug-fixes.md) for Phase 2 details.

## Contributing

This is a learning project. Commits should follow conventional commit format:
- `feat:` New features
- `fix:` Bug fixes
- `refactor:` Code improvements
- `docs:` Documentation updates

## Testing Checklist

### Phase 1 (Core Systems)
- [x] Camera moves smoothly in all directions
- [x] Camera stops at map boundaries
- [x] Zoom works correctly
- [x] Single unit selection works
- [x] Box selection selects multiple units
- [x] Shift-selection adds to group
- [x] Right-click moves units
- [x] Multiple units move in formation
- [x] Units avoid obstacles
- [x] HUD updates correctly
- [x] Performance: 60 FPS with 50 units

### Phase 2 (HUD & RPG Systems)
- [ ] First spawned unit is blue (Player)
- [ ] Subsequent units have correct colors (Green/Yellow/Red)
- [ ] Selecting player unit shows full stats in HUD
- [ ] XP bar displays only for player units
- [ ] Level up grants 5 stat points
- [ ] Derived stats calculate correctly (Attack, Armor, Max Health)
- [ ] Settings panel opens from Menu button
- [ ] All settings options apply immediately
- [ ] Floating health bars appear above units
- [ ] Health bars update when units take damage
- [ ] Name labels respect visibility settings
- [ ] Level labels toggle with settings
- [ ] F12 opens debug menu
- [ ] Debug: Add Level increases unit level
- [ ] Debug: Add XP works for player unit
- [ ] Debug: Spawn buttons create units at random positions
- [ ] Debug: Stat modification updates unit correctly
- [ ] HUD shows player info when nothing selected
- [ ] Portrait color matches unit type

## Known Limitations

- **No Pathfinding**: Units use direct movement and collision detection. They can block each other and may get stuck behind obstacles. Pathfinding/navigation will be added in future phases.
- **Basic AI**: Units have no autonomous behavior or decision-making
- **Placeholder Visuals**: Using simple geometric shapes (capsules, boxes)

## License

[Add your license here]

## Credits

Built with Godot 4.x
