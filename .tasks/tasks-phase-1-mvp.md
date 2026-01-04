# Tasks: Phase 1 MVP Completion

**Feature:** Complete Phase 1 MVP - RTS Foundation  
**Status:** In Progress  
**Created:** January 4, 2026  
**Based on:** [PRD v1.0](prd.md)  
**Engine:** Godot 4.x

---

## Relevant Files

- `scenes/world.tscn` - Main game scene containing terrain, camera, units container, and HUD instance
- `scenes/units/rts_unit.tscn` - Unit scene template with mesh, collision, and selection indicator
- `scenes/ui/hud.tscn` - HUD scene with selection box and unit info panels
- `scripts/units/rts_unit.gd` - Unit behavior script (movement, selection, health)
- `scripts/systems/selection_manager.gd` - Manages unit selection and command input
- `scripts/ui/hud.gd` - HUD controller for displaying unit information
- `scripts/camera_controller.gd` - Camera movement, edge scrolling, and zoom controls
- `project.godot` - Godot project configuration with input mappings

### Notes

- This is a Godot 4.x project using GDScript
- Run the project with F5 in Godot Editor or via command line
- Test in-editor for faster iteration
- Use Godot's built-in debugger for troubleshooting

---

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task.

---

## Tasks

- [ ] 0.0 Create feature branch
  - [ ] 0.1 Create and checkout a new branch (e.g., `git checkout -b feature/phase-1-mvp-completion`)
  - [ ] 0.2 Ensure all existing files are committed before starting new work

- [ ] 1.0 Complete HUD System Integration
  - [ ] 1.1 Read `scripts/ui/hud.gd` to understand current HUD implementation
  - [ ] 1.2 Read `scripts/systems/selection_manager.gd` to see how it calls HUD methods
  - [ ] 1.3 Test HUD in Godot: Run the project and select a single unit
  - [ ] 1.4 Verify unit name displays correctly in HUD
  - [ ] 1.5 Verify health bar updates correctly (current/max HP)
  - [ ] 1.6 Verify health text label shows "Health: X/Y" format
  - [ ] 1.7 Test multi-unit selection: Select 2+ units and verify group display
  - [ ] 1.8 Ensure "Multiple Units (X)" text appears with correct count
  - [ ] 1.9 Verify HUD hides when no units are selected
  - [ ] 1.10 Style the HUD panel with background color/texture for better visibility
  - [ ] 1.11 Position HUD at bottom of screen (200px height as per PRD)
  - [ ] 1.12 Add unit portrait placeholder (80x80px ColorRect or TextureRect)
  - [ ] 1.13 Test HUD at different screen resolutions (1920x1080, 1280x720)

- [ ] 2.0 Verify and Test Unit Selection System
  - [ ] 2.1 Read `scripts/systems/selection_manager.gd` selection logic
  - [ ] 2.2 Test single unit selection: Left-click individual units
  - [ ] 2.3 Verify green selection indicator appears beneath selected unit
  - [ ] 2.4 Test that clicking another unit deselects the first
  - [ ] 2.5 Test Shift+Click to add units to selection
  - [ ] 2.6 Verify multiple units can be selected simultaneously with Shift
  - [ ] 2.7 Test box selection: Click and drag to create selection rectangle
  - [ ] 2.8 Verify selection box visual appears during drag (semi-transparent panel)
  - [ ] 2.9 Ensure all units within box are selected on mouse release
  - [ ] 2.10 Test Shift+Drag to add box selection to existing selection
  - [ ] 2.11 Test clicking terrain deselects all units
  - [ ] 2.12 Test edge case: Very small box (< 5px) should act as single click
  - [ ] 2.13 Verify selection works with 10+ units on screen

- [ ] 3.0 Verify and Test Unit Movement System
  - [ ] 3.1 Read `scripts/units/rts_unit.gd` movement implementation
  - [ ] 3.2 Select a unit and right-click on terrain to issue move command
  - [ ] 3.3 Verify unit moves toward clicked location
  - [ ] 3.4 Verify unit rotates to face movement direction
  - [ ] 3.5 Verify unit stops when reaching destination (within 0.5 units)
  - [ ] 3.6 Test moving multiple selected units - they should all move
  - [ ] 3.7 Add simple obstacle (StaticBody3D cube) and test pathfinding around it
  - [ ] 3.8 If pathfinding doesn't work, implement basic NavigationAgent3D or collision avoidance
  - [ ] 3.9 Test group movement with 3+ units - ensure they don't overlap excessively
  - [ ] 3.10 Verify velocity resets to zero when unit reaches destination

- [ ] 4.0 Polish Camera Controls
  - [ ] 4.1 Read `scripts/camera_controller.gd` implementation
  - [ ] 4.2 Test WASD keyboard movement in all 4 directions
  - [ ] 4.3 Test Arrow key movement in all 4 directions
  - [ ] 4.4 Test edge scrolling by moving mouse to screen borders
  - [ ] 4.5 Verify edge scroll margin is approximately 20 pixels
  - [ ] 4.6 Test mouse wheel zoom in/out
  - [ ] 4.7 Verify zoom limits are enforced (min: 10, max: 30 units)
  - [ ] 4.8 Add camera bounds to prevent moving outside 50x50 terrain
  - [ ] 4.9 Implement clamping in `camera_controller.gd` to constrain X/Z position
  - [ ] 4.10 Test camera at terrain boundaries - should stop smoothly
  - [ ] 4.11 Verify camera maintains isometric angle (45° H, 35° V) during all movements
  - [ ] 4.12 Ensure camera movement feels smooth (no jittering or stuttering)

- [ ] 5.0 Performance Testing and Optimization
  - [ ] 5.1 Create a test scenario with 20 units in `scripts/systems/selection_manager.gd`
  - [ ] 5.2 Modify spawn_unit calls to create 20 units in a grid pattern
  - [ ] 5.3 Run project and check FPS (use Godot's Debug > Monitor > FPS)
  - [ ] 5.4 Verify FPS stays at 60 with 20 units
  - [ ] 5.5 Increase to 50 units and test again
  - [ ] 5.6 Profile performance if FPS drops below 60 (Debug > Profiler)
  - [ ] 5.7 Test box selection with all 50 units
  - [ ] 5.8 Test moving all 50 units simultaneously
  - [ ] 5.9 If performance issues occur, optimize HUD update frequency (only on selection change)
  - [ ] 5.10 Ensure `_process` in selection_manager only updates HUD when needed
  - [ ] 5.11 Return unit count to 3 for final demo build

- [ ] 6.0 Bug Fixes and Final MVP Polish
  - [ ] 6.1 Test all acceptance criteria from PRD Section 7 (User Stories)
  - [ ] 6.2 Fix any selection bugs found during testing
  - [ ] 6.3 Fix any movement bugs found during testing
  - [ ] 6.4 Fix any camera bugs found during testing
  - [ ] 6.5 Fix any HUD display bugs found during testing
  - [ ] 6.6 Add visual feedback for movement destination (temporary marker/circle)
  - [ ] 6.7 Improve selection indicator visual (ensure it's clearly visible)
  - [ ] 6.8 Add comments to complex functions in all scripts
  - [ ] 6.9 Remove any debug print statements from code
  - [ ] 6.10 Verify no errors appear in Godot console during gameplay
  - [ ] 6.11 Test complete gameplay loop: Select > Move > Select Different > Move
  - [ ] 6.12 Record a short video or GIF demonstrating all features
  - [ ] 6.13 Update PRD checkboxes for completed Phase 1 items
  - [ ] 6.14 Commit all changes with message: "feat: Complete Phase 1 MVP - RTS Foundation"
  - [ ] 6.15 Create pull request or merge feature branch to main

---

## Acceptance Criteria (from PRD)

### Camera Control
- [x] WASD keys move camera
- [x] Arrow keys move camera  
- [x] Mouse at screen edges scrolls camera
- [x] Mouse wheel zooms in/out
- [ ] Camera stays within map boundaries
- [ ] Camera movement feels smooth

### Unit Selection
- [x] Left-clicking a unit selects it
- [x] Selected unit shows green indicator
- [x] Click-dragging creates selection box
- [x] All units in box are selected
- [x] Shift+click adds to selection
- [ ] Clicking terrain deselects all units (verify)

### Unit Movement
- [x] Right-clicking terrain moves selected units
- [ ] Units navigate around obstacles (needs testing/implementation)
- [ ] Multiple units maintain formation
- [x] Units face movement direction
- [x] Units stop at destination
- [ ] Visual feedback shows move target

### Unit Information Display
- [ ] HUD displays when unit is selected
- [ ] Unit name is clearly visible
- [ ] Health bar shows current/max HP
- [ ] Health updates in real-time
- [ ] Unit type is displayed
- [ ] Multiple units show group info
- [ ] HUD minimizes when nothing selected

---

## Notes

- Most core systems (camera, selection, movement) are already implemented
- Focus is on completing HUD functionality and ensuring all systems work together
- This completes Phase 1 as defined in the PRD (Section 10)
- Target: Playable demo with selection and movement
- Use Godot 4's built-in features: NavigationAgent3D, signals, CharacterBody3D
- Test frequently in the Godot Editor (F5 to run)
- Commit small, logical changes as you progress through tasks
