# Godot RTS Game - Phase 1 MVP

A Warcraft 3-style Real-Time Strategy game built with Godot 4.x featuring isometric camera, unit selection, and movement mechanics.

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
  
- **HUD System**
  - Bottom panel with unit information
  - Unit portrait placeholder
  - Health bar display
  - Single/multiple unit info
  - Hides when nothing selected

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
│   ├── units/
│   │   └── rts_unit.tscn       # Unit template
│   ├── ui/
│   │   └── hud.tscn            # HUD interface
│   └── world.tscn              # Main game scene
├── scripts/
│   ├── units/
│   │   └── rts_unit.gd         # Unit behavior
│   ├── systems/
│   │   └── selection_manager.gd # Selection & commands
│   ├── ui/
│   │   └── hud.gd              # HUD controller
│   └── camera_controller.gd    # Camera movement
├── .tasks/
│   ├── prd.md                  # Product Requirements
│   └── tasks-phase-1-mvp.md    # Task checklist
└── README.md
```

## Development Status

**Phase 1 (MVP):** ✅ Complete
- All core systems implemented
- Ready for playtesting

**Phase 2 (Combat):** 🔲 Not Started
- Attack commands
- Damage system
- Unit death

**Phase 3 (Progression):** 🔲 Not Started
- Experience points
- Leveling system
- Stat increases

**Phase 4 (Abilities):** 🔲 Not Started
- Active abilities
- Cooldowns
- Hero units

See [.tasks/prd.md](.tasks/prd.md) for full roadmap.

## Contributing

This is a learning project. Commits should follow conventional commit format:
- `feat:` New features
- `fix:` Bug fixes
- `refactor:` Code improvements
- `docs:` Documentation updates

## Testing Checklist

- [ ] Camera moves smoothly in all directions
- [ ] Camera stops at map boundaries
- [ ] Zoom works correctly
- [ ] Single unit selection works
- [ ] Box selection selects multiple units
- [ ] Shift-selection adds to group
- [ ] Right-click moves units
- [ ] Multiple units move in formation
- [ ] Units avoid obstacles
- [ ] HUD updates correctly
- [ ] Performance: 60 FPS with 50 units

## Known Limitations

- **No Pathfinding**: Units use direct movement and collision detection. They can block each other and may get stuck behind obstacles. Pathfinding/navigation will be added in future phases.
- **Basic AI**: Units have no autonomous behavior or decision-making
- **Placeholder Visuals**: Using simple geometric shapes (capsules, boxes)

## License

[Add your license here]

## Credits

Built with Godot 4.x
