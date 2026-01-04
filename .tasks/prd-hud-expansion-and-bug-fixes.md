# PRD: HUD Expansion and Critical Bug Fixes

**Version:** 1.0  
**Date:** January 4, 2026  
**Priority:** High (1-2 week iteration)  
**Phase:** Phase 2 - UI/UX Enhancement + Bug Fixes

---

## 1. Introduction/Overview

This PRD covers critical bug fixes from Phase 1 and the expansion of the HUD system to include player-centric features, unit classification, stats/leveling systems, and debug tools. The goal is to transform the basic RTS foundation into a player-focused RPG/RTS hybrid with proper unit management and customization capabilities.

**Problem Statement:**
- Phase 1 has several critical bugs preventing proper gameplay (WASD, single-click, terrain collision)
- Current HUD is minimal and doesn't support the planned RPG elements (stats, levels, player focus)
- No way to distinguish between player, friendly, neutral, and enemy units
- Missing settings system for UI customization
- No debug tools for testing game mechanics during development

**Solution:**
Fix all Phase 1 bugs and implement a comprehensive HUD system with top bar menu, settings panel, unit stats display, and debug tools.

---

## 2. Goals

1. **Fix all critical bugs** from Phase 1 to ensure stable gameplay foundation
2. **Implement player-centric HUD** that prioritizes player information when no units are selected
3. **Create settings system** for UI customization (health bars, names, visibility options)
4. **Add unit classification** (Player, Friendly, Neutral, Enemy) with visual distinction
5. **Implement stats and leveling system** with base stats and manual point distribution
6. **Build debug menu** for efficient testing and iteration during development
7. **Display floating health bars and names** on map view with configurable visibility

---

## 3. User Stories

### Bug Fixes
- As a player, I want single-click selection to work so I can quickly select individual units
- As a player, I want WASD controls to work so I can move the camera easily
- As a player, I want the HUD to be visible even when no units are selected so I can always see relevant information
- As a player, I want units to spawn on top of the terrain (not inside it) so the game looks correct from the start
- As a developer, I want proper collision without pathfinding as a foundation for future navigation systems

### HUD & Settings
- As a player, I want a top menu bar with a settings button so I can customize my UI preferences
- As a player, I want to control health bar visibility (never/always/injured only) so I can reduce screen clutter
- As a player, I want to toggle name display for different unit types so I can focus on relevant information
- As a player, I want to choose health bar number display format (numbers/percent/bar only) so I can see the information I prefer
- As a player, I want to always see my player unit's information in the HUD when nothing is selected so I stay aware of my character's status

### Unit System
- As a player, I want to see my player unit displayed differently so I can easily identify it
- As a player, I want enemy units to be colored red and neutral units yellow so I can quickly assess threats
- As a player, I want to see stats (STR, CON, DEX, AGI, INT, WIS) so I understand my unit's capabilities
- As a player, I want to see attack damage and armor so I can evaluate combat readiness
- As a player, I want to see experience and level so I can track progression

### Debug Tools
- As a developer, I want a debug panel to add levels to units so I can test leveling mechanics
- As a developer, I want to add experience to units so I can test experience gain
- As a developer, I want to spawn neutral/enemy units so I can test interactions
- As a developer, I want to modify unit stats so I can test balance changes

---

## 4. Functional Requirements

### 4.1 Bug Fixes (Priority 1)

**BUG-001: Fix Single-Click Selection**
- Single left-click on a unit must select that unit immediately
- Root cause likely: Box selection threshold too large or selection logic issue
- Expected: Click registers as selection, not box selection start

**BUG-002: Fix WASD Camera Controls**
- WASD keys must move the camera in cardinal directions
- Root cause likely: Input map or _process logic issue
- Expected: Consistent camera movement matching arrow key behavior

**BUG-003: Fix HUD Always Visible**
- HUD must display default content when no units are selected
- When no selection: Display player unit information
- Expected: HUD never shows empty/blank state

**BUG-004: Fix Unit Spawn Height**
- Units must spawn at Y=0.5 (half capsule height) or calculated from terrain
- Root cause: Spawning at Y=0 causes units to be half-buried in terrain
- Expected: Units visible and standing on terrain surface from spawn

**BUG-005: Document Collision/Pathfinding Status**
- Collision is working as expected (units block each other)
- Pathfinding is out of scope for this phase
- Expected: Units avoid obstacles but may get stuck (acceptable for now)

### 4.2 Unit Classification System

**UNIT-001: Implement Unit Types**
- Use Godot groups for classification: "unit_player", "unit_friendly", "unit_neutral", "unit_enemy"
- Each unit must have exactly one classification group
- Add unit_type: String property for editor reference ("Player", "Friendly", "Neutral", "Enemy")

**UNIT-002: Visual Distinction by Type**
- Player unit: Blue color (#4A90E2), special marker/glow effect
- Friendly units: Green color (#50C878)
- Neutral units: Yellow color (#FFD700)
- Enemy units: Red color (#E74C3C)
- Apply color to unit mesh material or add colored indicator mesh

**UNIT-003: Unit Naming**
- Each unit must have a display_name: String property
- Player unit default: "Hero"
- Friendly units: "Ally", "Soldier", "Knight"
- Neutral units: "Villager", "Merchant", "Critter"
- Enemy units: "Bandit", "Goblin", "Skeleton"

### 4.3 Stats and Leveling System

**STATS-001: Core Stats Structure**
- Add stats dictionary to unit with base values:
  - strength: int (base 10, affects attack damage)
  - constitution: int (base 10, affects health)
  - dexterity: int (base 10, affects armor)
  - agility: int (base 10, affects movement speed)
  - intelligence: int (base 10, future: magic damage)
  - wisdom: int (base 10, future: mana)

**STATS-002: Derived Stats**
- attack_damage: int = base_damage + (strength * 2)
- armor: int = base_armor + dexterity
- max_health: int = base_health + (constitution * 10)
- Calculate derived stats when base stats change

**STATS-003: Leveling System**
- level: int (default 1, max 100)
- experience: int (default 0, only for player units)
- experience_to_next_level: int = level * 100 (simple formula)
- unspent_stat_points: int (gained on level up)
- On level up: Grant 5 stat points to distribute

**STATS-004: NPC Level Handling**
- NPCs (friendly/neutral/enemy) have level but no experience
- NPC stats are pre-calculated based on level: base + (level * 2) per stat
- NPCs don't gain levels during gameplay (set in editor)

### 4.4 HUD Expansion

**HUD-001: Top Menu Bar**
- Add HBoxContainer at top of screen (height: 40px)
- Background: Dark semi-transparent (#1A1A1A, alpha 0.9)
- Include "Menu" button (left side, opens settings panel)
- Reserve space for future buttons (inventory, skills, etc.)

**HUD-002: Settings Panel**
- Modal panel (400x500px, centered) opened by Menu button
- Close button (X) in top-right corner
- Scroll container for settings sections

**HUD-003: Health Bar Settings Section**
- Label: "Unit Health Bars"
- OptionButton (dropdown) with options:
  - "Never Show"
  - "Always Show"
  - "Show When Injured Only" (default)

**HUD-004: Name Display Settings Section**
- Label: "Name Display"
- CheckBox: "Show Friendly NPC Names" (default: true)
- CheckBox: "Show Neutral Names" (default: true)
- CheckBox: "Show Hostile Names" (default: true)
- CheckBox: "Show Boss Names" (default: true, note: no bosses yet)
- CheckBox: "Show Own Health" (default: true)
- CheckBox: "Show Own Mana" (default: false, note: no mana yet)
- CheckBox: "Show Other Players Health" (default: false, note: single player for now)
- CheckBox: "Show Other Players Mana" (default: false)
- CheckBox: "Show Level" (default: true)

**HUD-005: Health Bar Format Settings**
- Label: "Health Bar Numbers"
- OptionButton (dropdown) with options:
  - "Show Numbers" (e.g., "85/100")
  - "Show Percent" (e.g., "85%")
  - "Show Bar Only" (default)

**HUD-006: Enhanced Unit Info Display**
- Restructure bottom HUD panel (increase height to 250px)
- Left section: Unit portrait placeholder (100x100px, ColorRect for now)
- Right section: Unit details in VBoxContainer:
  - Unit Name (Label, large font)
  - Level (Label, "Level X" or "Level X - XP: Y/Z" for player)
  - Health bar (ProgressBar with current/max display based on settings)
  - Stats display (GridContainer, 2 columns):
    - STR: [value], CON: [value]
    - DEX: [value], AGI: [value]
    - INT: [value], WIS: [value]
  - Combat stats:
    - Attack Damage: [value]
    - Armor: [value]

**HUD-007: Player-Centric Display**
- When no units selected: Display player unit information in HUD
- When player unit selected: Display player information (same as no selection)
- When other unit selected: Display that unit's information
- Player unit reference must be cached on _ready()

### 4.5 Map View Overlays

**OVERLAY-001: Floating Health Bars**
- Add Sprite3D or Label3D above each unit (Y offset: 2.0)
- Health bar: ProgressBar or custom shader bar
- Size: 1.0 unit wide, 0.15 units tall
- Color: Green (healthy) → Yellow (injured) → Red (critical)
- Visibility controlled by settings (NEVER/ALWAYS/INJURED)
- Update only when health changes (optimization)

**OVERLAY-002: Floating Name Labels**
- Add Label3D above health bar (Y offset: 2.3)
- Font size: 12-14
- Color matches unit type (blue/green/yellow/red)
- Visibility controlled by settings checkboxes per unit type
- Billboard mode: Enabled (always face camera)

**OVERLAY-003: Level Display**
- Show level next to name or below health bar
- Format: "Lv. X"
- Visibility controlled by "Show Level" setting
- Font size: 10

### 4.6 Debug Menu

**DEBUG-001: Debug Panel UI**
- Panel on right side of screen (width: 300px, height: 400px)
- Title: "Debug Tools"
- Background: Dark semi-transparent (#2A2A2A, alpha 0.95)
- VBoxContainer for buttons and controls
- Add collapse/expand button or drag handle for repositioning

**DEBUG-002: Level Manipulation**
- Button: "Add 1 Level"
- Requires: Selected unit
- Action: Increase unit.level by 1, add 5 stat points, recalculate derived stats
- Feedback: Update HUD immediately

**DEBUG-003: Experience Manipulation**
- HBoxContainer: Label "Add XP:" + LineEdit (numbers only) + Button "Apply"
- LineEdit validation: Only accept integers (0-9999)
- Requires: Selected player unit
- Action: Add specified XP, check for level up, update HUD

**DEBUG-004: Spawn Units**
- Button: "Spawn Neutral Unit"
- Button: "Spawn Enemy Unit"
- Action: Spawn unit at random position near player (radius 5-10 units)
- Unit spawns at appropriate level (same as player or player-1)

**DEBUG-005: Stat Manipulation**
- HBoxContainer: OptionButton (stat dropdown) + LineEdit (number) + Button "Add to Stat"
- Dropdown options: STR, CON, DEX, AGI, INT, WIS
- LineEdit validation: Only accept integers (1-100)
- Requires: Selected unit
- Action: Add specified amount to chosen stat, recalculate derived stats, update HUD

**DEBUG-006: Debug Menu Persistence**
- Debug settings and stat changes do NOT persist across game restarts
- All debug modifications are temporary for testing purposes
- No save/load functionality for debug changes

---

## 5. Non-Goals (Out of Scope)

- **Pathfinding/Navigation System**: Collision is sufficient for this phase
- **Combat System**: Damage calculation, attacks, and death are Phase 3
- **Inventory System**: Item management comes later
- **Skill/Ability System**: Not included in this iteration
- **Mana System**: Placeholder settings only, no implementation
- **Boss Units**: Settings checkbox present, but no boss mechanics
- **Multiplayer**: "Other Players" settings are placeholders
- **Save/Load System**: Stats and levels don't persist yet
- **Equipment System**: Attack/armor are flat stats for now
- **Animations**: No level up effects, stat increase VFX, etc.
- **Sound Effects**: No audio for UI interactions
- **Mobile/Controller Support**: Mouse + keyboard only

---

## 6. Design Considerations

### UI Layout

```
┌─────────────────────────────────────────────────────┐
│ [Menu] [Future] [Buttons]                  Top Bar │ 40px
├─────────────────────────────────────┬───────────────┤
│                                     │               │
│                                     │  Debug Panel  │
│         Game View                   │               │
│                                     │  - Add Level  │
│                                     │  - Add XP     │
│                                     │  - Spawn Unit │
│                                     │  - Add Stat   │
│                                     │               │
│                                     │               │
├─────────────────────────────────────┴───────────────┤
│ Bottom HUD Panel - Unit Information          250px │
│ ┌────────┐ ┌──────────────────────────────┐        │
│ │Portrait│ │ Unit Name          Level X   │        │
│ │        │ │ [======= Health =======]     │        │
│ │ 100x100│ │ STR: 12  CON: 14             │        │
│ │        │ │ DEX: 10  AGI: 13             │        │
│ │        │ │ INT: 8   WIS: 9              │        │
│ └────────┘ │ Attack: 28  Armor: 15        │        │
│            └──────────────────────────────┘        │
└─────────────────────────────────────────────────────┘
```

### Settings Panel Structure

```
┌────────────────────────────────┐
│  Game Settings            [X]  │
├────────────────────────────────┤
│                                │
│ Unit Health Bars:              │
│  [Always Show           ▼]     │
│                                │
│ Name Display:                  │
│  [✓] Show Friendly NPC Names   │
│  [✓] Show Neutral Names        │
│  [✓] Show Hostile Names        │
│  [✓] Show Boss Names           │
│  [✓] Show Level                │
│  [✓] Show Own Health           │
│  [ ] Show Own Mana             │
│  [ ] Show Other Players Health │
│  [ ] Show Other Players Mana   │
│                                │
│ Health Bar Numbers:            │
│  [Show Bar Only         ▼]     │
│                                │
│           [Close]              │
└────────────────────────────────┘
```

### Color Palette

- **Player Unit**: #4A90E2 (blue)
- **Friendly Unit**: #50C878 (emerald green)
- **Neutral Unit**: #FFD700 (gold)
- **Enemy Unit**: #E74C3C (red)
- **UI Background**: #1A1A1A (dark gray, alpha 0.9)
- **Debug Panel**: #2A2A2A (slightly lighter gray, alpha 0.95)

---

## 7. Technical Considerations

### Godot 4 Implementation Notes

**Unit Classification:**
- Use Godot groups for unit types (best practice for querying and filtering)
- Add to group in code: `add_to_group("unit_player")`
- Check group: `is_in_group("unit_player")`
- Query units: `get_tree().get_nodes_in_group("unit_enemy")`

**Stats System:**
- Create `unit_stats.gd` resource or autoload for stat calculations
- Use signals for stat changes: `signal stat_changed(stat_name, old_value, new_value)`
- Derived stats should be calculated properties, not stored values (prevents desyncs)

**HUD Update Optimization:**
- Only update HUD when selection changes or selected unit's stats change
- Use signals to notify HUD of changes rather than polling
- Cache player unit reference to avoid repeated tree searches

**Settings Persistence:**
- Use ConfigFile or Dictionary for settings
- Save to `user://settings.cfg` (future phase)
- For now, settings reset on game restart (acceptable for 1-2 week iteration)

**Debug Menu:**
- Use @export var debug_menu_visible: bool = true for easy toggle
- Consider Input.is_action_just_pressed("toggle_debug") for F12 or ~ key toggle
- Debug modifications should not trigger stat change signals to avoid confusion

**Floating UI (Health Bars/Names):**
- Use Sprite3D with CanvasTexture or Label3D for 3D space UI
- Parent to unit, not to camera (so they move with units)
- Use billboard mode: BILLBOARD_ENABLED for labels
- Consider using SubViewport for complex health bars (may be overkill for this phase)

### Performance Considerations

- Floating health bars update only on health change (not every frame)
- Name labels update only on settings change (static otherwise)
- Limit debug spawn to prevent FPS drop (max 50 total units)
- Use object pooling for spawned units if performance becomes an issue

---

## 8. Success Metrics

**Bug Fix Success:**
- ✅ All 5 bugs resolved and verified in testing
- ✅ No new bugs introduced by fixes

**HUD System Success:**
- ✅ Settings panel opens and closes smoothly
- ✅ All settings options functional and affect game view
- ✅ Player information always visible when no selection
- ✅ HUD updates correctly when selecting different unit types

**Unit System Success:**
- ✅ Can distinguish player from other units at a glance (color/marker)
- ✅ Neutral and enemy units spawn with correct colors and names
- ✅ Stats display correctly in HUD and update when changed
- ✅ Level up grants stat points and updates display

**Debug Tools Success:**
- ✅ Can test all stats and leveling without playing full game loop
- ✅ Can spawn multiple unit types for interaction testing
- ✅ Debug changes reflected immediately in HUD and game view

**Overall Quality:**
- ✅ No errors in console during normal gameplay
- ✅ UI is readable and professionally styled
- ✅ Game runs at 60 FPS with 20 units spawned
- ✅ Junior developer can understand and implement requirements

---

## 9. Open Questions

1. **Stat Point Distribution UI**: When a unit levels up and has unspent stat points, how should the player distribute them?
   - Option A: Click +/- buttons next to each stat in HUD
   - Option B: Dedicated "Level Up" modal dialog
   - Option C: Automatic distribution for now, manual system in Phase 3

2. **Player Unit Spawn**: Should the player unit spawn at a specific location (e.g., center) or in the grid like other units?
   - Suggestion: Spawn player at (0, 0.5, 0) and other units around player

3. **Debug Menu Position**: Should the debug panel be draggable immediately or is fixed right-side position acceptable for this iteration?
   - Suggestion: Fixed position for 1-2 week scope, make draggable in polish phase

4. **Health Bar Style**: Should floating health bars use simple ProgressBar or custom shader for smoother appearance?
   - Suggestion: Start with ProgressBar/Label3D, upgrade to shader if time permits

5. **Unit Icon Placeholder**: Should unit portrait show colored box, unit type initial letter, or simple shape?
   - Suggestion: Colored box with first letter of unit type (P, F, N, E)

6. **Settings Application**: Should settings changes apply immediately or require "Apply" button?
   - Suggestion: Apply immediately for better UX (no confirmation needed)

---

## 10. Implementation Phases

### Phase A: Bug Fixes (Days 1-2)
- Fix single-click selection
- Fix WASD camera controls
- Fix HUD always visible (show player by default)
- Fix unit spawn height
- Test all fixes together

### Phase B: Unit Classification (Days 3-4)
- Implement unit type groups and properties
- Add visual distinction (colors)
- Create enemy and neutral unit scenes
- Update spawn system to support different types
- Test unit spawning and selection

### Phase C: Stats & Leveling Foundation (Days 5-6)
- Implement stats structure in unit script
- Add derived stats calculation
- Implement level and experience properties
- Test stat calculations and level ups

### Phase D: HUD Expansion (Days 7-8)
- Create top menu bar
- Build settings panel UI
- Implement settings logic (health bar visibility, names, etc.)
- Enhance bottom HUD with stats display
- Test player-centric HUD behavior

### Phase E: Map Overlays (Days 9-10)
- Add floating health bars above units
- Add floating name labels
- Implement level display
- Connect to settings system
- Test visibility toggles

### Phase F: Debug Menu (Days 11-12)
- Create debug panel UI
- Implement level/XP manipulation
- Implement stat manipulation
- Implement unit spawning
- Test all debug features

### Phase G: Integration & Polish (Days 13-14)
- Integration testing of all systems
- Bug fixes from testing
- Visual polish (spacing, colors, fonts)
- Performance testing with 50 units
- Update documentation

---

## 11. Acceptance Criteria

### Bug Fixes
- [ ] Single left-click on unit selects it without triggering box selection
- [ ] WASD keys move camera in all four directions
- [ ] HUD shows player unit info when no units are selected
- [ ] Units spawn on top of terrain, fully visible from start
- [ ] Units collide with obstacles and each other

### Settings System
- [ ] Menu button opens settings panel
- [ ] All health bar options work (never/always/injured)
- [ ] All name display checkboxes work
- [ ] Health bar format options work (numbers/percent/bar)
- [ ] Settings changes apply immediately to game view
- [ ] Settings panel can be closed with X button

### Unit System
- [ ] Player unit is blue and visually distinct
- [ ] Friendly units are green
- [ ] Neutral units are yellow
- [ ] Enemy units are red
- [ ] Each unit displays correct name
- [ ] Neutral and enemy units can be spawned

### Stats & Leveling
- [ ] All stats (STR, CON, DEX, AGI, INT, WIS) display in HUD
- [ ] Attack damage and armor display in HUD
- [ ] Player unit shows level and experience
- [ ] NPC units show level only (no experience)
- [ ] Derived stats calculate correctly from base stats
- [ ] Level up grants 5 stat points

### HUD Display
- [ ] Top menu bar visible at all times
- [ ] Bottom HUD displays selected unit or player unit
- [ ] Portrait placeholder visible
- [ ] All stats formatted clearly
- [ ] Health bar updates when health changes

### Map Overlays
- [ ] Health bars float above units
- [ ] Names float above health bars
- [ ] Level displays when setting enabled
- [ ] Visibility matches settings configuration
- [ ] Labels face camera (billboard)

### Debug Menu
- [ ] Debug panel visible on right side
- [ ] Add Level button increases selected unit's level
- [ ] Add XP input adds experience to player unit
- [ ] Spawn buttons create neutral/enemy units
- [ ] Add to Stat increases selected stat by specified amount
- [ ] Debug changes update HUD immediately

### Quality
- [ ] No console errors during normal gameplay
- [ ] Game runs at 60 FPS with 20 units
- [ ] All UI elements properly aligned and readable
- [ ] Code follows project conventions (see .github/copilot-instructions.md)
- [ ] All new features have doc comments

---

**Next Steps:**
1. Review and approve PRD
2. Create task breakdown for implementation phases
3. Begin Phase A: Bug Fixes
