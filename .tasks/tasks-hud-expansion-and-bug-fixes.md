# Tasks: HUD Expansion and Critical Bug Fixes

**Based on:** [prd-hud-expansion-and-bug-fixes.md](prd-hud-expansion-and-bug-fixes.md)  
**Timeline:** 1-2 weeks (14 days)  
**Phase:** Phase 2 - UI/UX Enhancement + Bug Fixes

---

## Relevant Files

- `scripts/units/rts_unit.gd` - Unit script needs stats, leveling, classification, floating UI
- `scripts/systems/selection_manager.gd` - Selection logic needs fixes, player unit tracking
- `scripts/camera_controller.gd` - Camera WASD controls need fixing
- `scenes/units/rts_unit.tscn` - Unit scene needs colored materials, floating health bars/names
- `scenes/units/player_unit.tscn` - New player unit variant (blue, special marker)
- `scenes/units/enemy_unit.tscn` - New enemy unit variant (red)
- `scenes/units/neutral_unit.tscn` - New neutral unit variant (yellow)
- `scripts/ui/hud.gd` - HUD needs major expansion for stats, settings
- `scenes/ui/hud.tscn` - HUD scene needs top bar, enhanced bottom panel
- `scenes/ui/settings_panel.tscn` - New settings panel scene
- `scripts/ui/settings_panel.gd` - Settings logic and persistence
- `scenes/ui/debug_panel.tscn` - New debug menu scene
- `scripts/ui/debug_panel.gd` - Debug tools logic
- `scripts/autoloads/game_settings.gd` - New autoload for global settings state
- `scripts/components/floating_ui.gd` - New script for health bars/names above units

### Notes

- Use GUT (Godot Unit Test) framework for testing if tests are required
- Run game with F5 to test changes in Godot editor
- Use Debug > Visible Debug Information (F3) for performance monitoring
- Commit frequently with conventional commit messages

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

---

## Tasks

- [x] 0.0 Create feature branch
  - [x] 0.1 Create and checkout new branch `feature/phase-2-hud-expansion`
  - [x] 0.2 Push branch to GitHub remote

- [x] 1.0 Fix Critical Bugs (Phase A: Days 1-2)
  - [x] 1.1 **BUG-001: Fix single-click selection**
    - [x] 1.1.1 Read `scripts/systems/selection_manager.gd` _input method
    - [x] 1.1.2 Identify box selection threshold issue (likely `box_select_start` vs `box_select_end` distance check)
    - [x] 1.1.3 Reduce threshold to 5 pixels or add proper single-click detection
    - [x] 1.1.4 Test single-click on unit (should select immediately)
    - [x] 1.1.5 Commit fix: "fix(selection): Fix single-click unit selection threshold"
  - [x] 1.2 **BUG-002: Fix WASD camera controls**
    - [x] 1.2.1 Read `scripts/camera_controller.gd` _process method
    - [x] 1.2.2 Check Input.is_action_pressed for "move_up", "move_down", "move_left", "move_right"
    - [x] 1.2.3 Verify input actions are mapped in project.godot
    - [x] 1.2.4 Fix WASD input handling (likely missing or incorrect action names)
    - [x] 1.2.5 Test all four directions (W=forward, A=left, S=back, D=right)
    - [x] 1.2.6 Commit fix: "fix(camera): Fix WASD camera movement controls"
  - [x] 1.3 **BUG-003: Fix HUD always visible with player info**
    - [x] 1.3.1 Read `scripts/ui/hud.gd` and `scripts/systems/selection_manager.gd`
    - [x] 1.3.2 Add `player_unit` reference in selection_manager (cache in _ready)
    - [x] 1.3.3 Modify `update_hud()` to show player info when `selected_units.size() == 0`
    - [x] 1.3.4 Test: HUD shows player info on game start (no selection)
    - [x] 1.3.5 Commit fix: "fix(hud): Display player unit info when no units selected"
  - [x] 1.4 **BUG-004: Fix unit spawn height**
    - [x] 1.4.1 Read `scripts/systems/selection_manager.gd` spawn_unit and spawn_units_in_grid methods
    - [x] 1.4.2 Change spawn position Y from 0 to 0.5 (half capsule height)
    - [x] 1.4.3 Test: Units spawn fully visible on terrain surface
    - [x] 1.4.4 Commit fix: "fix(spawn): Set unit spawn height to 0.5 to prevent terrain clipping"
  - [x] 1.5 **BUG-005: Document collision/pathfinding status**
    - [x] 1.5.1 Add comment in rts_unit.gd noting collision works, pathfinding is future work
    - [x] 1.5.2 Update README.md Known Limitations section
    - [x] 1.5.3 Commit: "docs: Document collision behavior and pathfinding scope"
  - [x] 1.6 **Test all bug fixes together**
    - [x] 1.6.1 Run game (F5) and verify all 5 bugs are resolved
    - [x] 1.6.2 Check for any new errors in console

- [ ] 2.0 Implement Unit Classification System (Phase B: Days 3-4)
  - [ ] 2.1 **Add unit type properties and groups**
    - [ ] 2.1.1 Read `scripts/units/rts_unit.gd`
    - [ ] 2.1.2 Add `@export var unit_type: String = "Friendly"` (options: Player, Friendly, Neutral, Enemy)
    - [ ] 2.1.3 Add `@export var display_name: String = "Unit"`
    - [ ] 2.1.4 In _ready(), add to group based on unit_type: `add_to_group("unit_" + unit_type.to_lower())`
    - [ ] 2.1.5 Commit: "feat(units): Add unit_type and display_name properties with group assignment"
  - [ ] 2.2 **Create colored materials for unit types**
    - [ ] 2.2.1 In Godot editor, create 4 StandardMaterial3D resources
    - [ ] 2.2.2 Set colors: Player=#4A90E2, Friendly=#50C878, Neutral=#FFD700, Enemy=#E74C3C
    - [ ] 2.2.3 Save as: `assets/materials/mat_player.tres`, `mat_friendly.tres`, `mat_neutral.tres`, `mat_enemy.tres`
    - [ ] 2.2.4 Commit: "feat(materials): Add colored materials for unit type distinction"
  - [ ] 2.3 **Update rts_unit.gd to apply colors**
    - [ ] 2.3.1 Add `@onready var mesh: MeshInstance3D = $MeshInstance3D` (or correct path)
    - [ ] 2.3.2 In _ready(), load appropriate material based on unit_type
    - [ ] 2.3.3 Apply material to mesh: `mesh.material_override = loaded_material`
    - [ ] 2.3.4 Commit: "feat(units): Apply unit type color to mesh based on classification"
  - [ ] 2.4 **Create unit scene variants**
    - [ ] 2.4.1 Duplicate `scenes/units/rts_unit.tscn` to `player_unit.tscn`
    - [ ] 2.4.2 In player_unit.tscn Inspector, set unit_type="Player", display_name="Hero"
    - [ ] 2.4.3 Duplicate rts_unit.tscn to `enemy_unit.tscn`, set unit_type="Enemy", display_name="Bandit"
    - [ ] 2.4.4 Duplicate rts_unit.tscn to `neutral_unit.tscn`, set unit_type="Neutral", display_name="Villager"
    - [ ] 2.4.5 Commit: "feat(scenes): Create player, enemy, and neutral unit scene variants"
  - [ ] 2.5 **Update spawn system to use player unit**
    - [ ] 2.5.1 Read `scripts/systems/selection_manager.gd` spawn_units_in_grid
    - [ ] 2.5.2 Spawn first unit as player: `load("res://scenes/units/player_unit.tscn")`
    - [ ] 2.5.3 Spawn remaining units as friendly (existing rts_unit.tscn)
    - [ ] 2.5.4 Cache player_unit reference after spawning
    - [ ] 2.5.5 Test: First unit is blue (player), others are green (friendly)
    - [ ] 2.5.6 Commit: "feat(spawn): Spawn first unit as player, cache player reference"
  - [ ] 2.6 **Test unit classification**
    - [ ] 2.6.1 Run game, verify player unit is blue
    - [ ] 2.6.2 Check console for correct group assignment messages (optional debug prints)
    - [ ] 2.6.3 Verify other units are green

- [ ] 3.0 Implement Stats and Leveling System (Phase C: Days 5-6)
  - [ ] 3.1 **Add core stats structure**
    - [ ] 3.1.1 Read `scripts/units/rts_unit.gd`
    - [ ] 3.1.2 Add stats dictionary with base values:
      ```gdscript
      var stats = {
          "strength": 10,
          "constitution": 10,
          "dexterity": 10,
          "agility": 10,
          "intelligence": 10,
          "wisdom": 10
      }
      ```
    - [ ] 3.1.3 Add `@export var base_damage: int = 5`
    - [ ] 3.1.4 Add `@export var base_armor: int = 0`
    - [ ] 3.1.5 Add `@export var base_health: int = 100`
    - [ ] 3.1.6 Commit: "feat(stats): Add core stats structure and base values"
  - [ ] 3.2 **Add derived stats calculations**
    - [ ] 3.2.1 Create computed properties for derived stats:
      - `func get_attack_damage() -> int: return base_damage + (stats.strength * 2)`
      - `func get_armor() -> int: return base_armor + stats.dexterity`
      - `func get_max_health() -> int: return base_health + (stats.constitution * 10)`
    - [ ] 3.2.2 Update health initialization to use get_max_health()
    - [ ] 3.2.3 Commit: "feat(stats): Add derived stats calculation (attack, armor, max_health)"
  - [ ] 3.3 **Add leveling system**
    - [ ] 3.3.1 Add leveling properties:
      ```gdscript
      @export var level: int = 1
      var experience: int = 0
      var unspent_stat_points: int = 0
      ```
    - [ ] 3.3.2 Add computed property: `func get_experience_to_next_level() -> int: return level * 100`
    - [ ] 3.3.3 Add signal: `signal level_up(new_level: int)`
    - [ ] 3.3.4 Create `add_experience(amount: int)` method with level up logic
    - [ ] 3.3.5 On level up: increment level, add 5 stat points, emit signal
    - [ ] 3.3.6 Commit: "feat(leveling): Add experience and level up system"
  - [ ] 3.4 **Handle NPC stat scaling**
    - [ ] 3.4.1 Add `is_player_controlled()` helper: `return is_in_group("unit_player")`
    - [ ] 3.4.2 In _ready(), if NOT player-controlled, scale stats by level: `base_stat + (level * 2)`
    - [ ] 3.4.3 Test with @export level on enemy/neutral units
    - [ ] 3.4.4 Commit: "feat(npcs): Scale NPC stats based on level"
  - [ ] 3.5 **Add stat modification method**
    - [ ] 3.5.1 Create `add_stat(stat_name: String, amount: int)` method
    - [ ] 3.5.2 Validate stat_name exists in stats dictionary
    - [ ] 3.5.3 Add amount to stat, clamp to reasonable max (e.g., 999)
    - [ ] 3.5.4 Emit signal: `signal stat_changed(stat_name: String, new_value: int)`
    - [ ] 3.5.5 Commit: "feat(stats): Add stat modification method with validation"
  - [ ] 3.6 **Test stats and leveling**
    - [ ] 3.6.1 Temporarily add debug print in _ready() showing stats
    - [ ] 3.6.2 Run game, verify stats display in console
    - [ ] 3.6.3 Test add_experience method with test button (temporary)
    - [ ] 3.6.4 Verify level up grants stat points and recalculates derived stats

- [ ] 4.0 Expand HUD System (Phase D: Days 7-8)
  - [ ] 4.1 **Create game settings autoload**
    - [ ] 4.1.1 Create `scripts/autoloads/game_settings.gd`
    - [ ] 4.1.2 Add settings dictionary with defaults:
      ```gdscript
      var health_bar_mode: String = "injured"  # never, always, injured
      var show_friendly_names: bool = true
      var show_neutral_names: bool = true
      var show_hostile_names: bool = true
      var show_boss_names: bool = true
      var show_level: bool = true
      var show_own_health: bool = true
      var show_own_mana: bool = false
      var show_other_health: bool = false
      var show_other_mana: bool = false
      var health_bar_format: String = "bar"  # bar, numbers, percent
      ```
    - [ ] 4.1.3 Add to autoload in Project > Project Settings > Autoload
    - [ ] 4.1.4 Commit: "feat(settings): Create game settings autoload singleton"
  - [ ] 4.2 **Create top menu bar**
    - [ ] 4.2.1 Open `scenes/ui/hud.tscn`
    - [ ] 4.2.2 Add MarginContainer at top (anchor top, height 40px)
    - [ ] 4.2.3 Add Panel child with dark background StyleBoxFlat (#1A1A1A, alpha 0.9)
    - [ ] 4.2.4 Add HBoxContainer with "Menu" Button on left
    - [ ] 4.2.5 Connect Menu button pressed signal to hud.gd
    - [ ] 4.2.6 Commit: "feat(hud): Add top menu bar with Menu button"
  - [ ] 4.3 **Create settings panel scene**
    - [ ] 4.3.1 Create `scenes/ui/settings_panel.tscn` with Panel root (400x500px)
    - [ ] 4.3.2 Add Panel with dark StyleBoxFlat, centered anchors
    - [ ] 4.3.3 Add VBoxContainer with title Label "Game Settings" and close Button (X)
    - [ ] 4.3.4 Add ScrollContainer for settings content
    - [ ] 4.3.5 Add VBoxContainer inside scroll with sections:
      - Label "Unit Health Bars:" + OptionButton
      - Label "Name Display:" + 9 CheckBoxes
      - Label "Health Bar Numbers:" + OptionButton
    - [ ] 4.3.6 Set node names for easy script access
    - [ ] 4.3.7 Commit: "feat(settings): Create settings panel UI layout"
  - [ ] 4.4 **Implement settings panel logic**
    - [ ] 4.4.1 Create `scripts/ui/settings_panel.gd`, attach to settings_panel.tscn
    - [ ] 4.4.2 Add @onready references for all UI elements
    - [ ] 4.4.3 In _ready(), populate OptionButtons and set CheckBox states from GameSettings
    - [ ] 4.4.4 Connect all control signals (item_selected, toggled)
    - [ ] 4.4.5 On changes, update GameSettings autoload immediately
    - [ ] 4.4.6 Connect close button to hide()
    - [ ] 4.4.7 Commit: "feat(settings): Implement settings panel logic and persistence"
  - [ ] 4.5 **Integrate settings panel into HUD**
    - [ ] 4.5.1 In `scenes/ui/hud.tscn`, instance settings_panel.tscn
    - [ ] 4.5.2 Set initially hidden (visible=false)
    - [ ] 4.5.3 In `scripts/ui/hud.gd`, add @onready reference to settings_panel
    - [ ] 4.5.4 Implement `_on_menu_button_pressed()` to show settings_panel
    - [ ] 4.5.5 Test: Menu button opens settings, X closes it
    - [ ] 4.5.6 Commit: "feat(hud): Integrate settings panel with menu button"
  - [ ] 4.6 **Enhance bottom HUD panel layout**
    - [ ] 4.6.1 Open `scenes/ui/hud.tscn`, increase BottomPanel height to 250px
    - [ ] 4.6.2 Replace content with HBoxContainer
    - [ ] 4.6.3 Left side: ColorRect (100x100px) for portrait placeholder
    - [ ] 4.6.4 Right side: VBoxContainer with:
      - HBoxContainer: Unit name Label + Level Label (right-aligned)
      - ProgressBar for health
      - GridContainer (2 columns) for stats labels
      - HBoxContainer for combat stats (Attack, Armor)
    - [ ] 4.6.5 Style labels with appropriate fonts/colors
    - [ ] 4.6.6 Commit: "feat(hud): Enhance bottom panel layout for detailed unit info"
  - [ ] 4.7 **Update HUD script for enhanced display**
    - [ ] 4.7.1 Read `scripts/ui/hud.gd`
    - [ ] 4.7.2 Add @onready references for all new UI elements
    - [ ] 4.7.3 Modify `update_unit_info()` to display:
      - Portrait color (based on unit_type)
      - display_name
      - Level and XP (if player unit)
      - Health bar with format from settings
      - All 6 stats (STR, CON, DEX, AGI, INT, WIS)
      - Attack damage and armor (derived stats)
    - [ ] 4.7.4 Handle multiple selection (show "X units selected")
    - [ ] 4.7.5 Test with player and friendly units
    - [ ] 4.7.6 Commit: "feat(hud): Implement enhanced unit info display with stats"
  - [ ] 4.8 **Test HUD expansion**
    - [ ] 4.8.1 Run game, verify top menu bar visible
    - [ ] 4.8.2 Click Menu, verify settings panel opens
    - [ ] 4.8.3 Test all settings options (should update GameSettings)
    - [ ] 4.8.4 Select player unit, verify stats display correctly
    - [ ] 4.8.5 Deselect all, verify player info still shows (BUG-003 fix)

- [ ] 5.0 Add Map View Overlays (Phase E: Days 9-10)
  - [ ] 5.1 **Create floating UI component script**
    - [ ] 5.1.1 Create `scripts/components/floating_ui.gd` extending Node3D
    - [ ] 5.1.2 Add references for health_bar (Sprite3D or SubViewport) and name_label (Label3D)
    - [ ] 5.1.3 Add method `update_health(current: int, max: int)` to update bar
    - [ ] 5.1.4 Add method `update_visibility(settings: Dictionary)` based on GameSettings
    - [ ] 5.1.5 Commit: "feat(overlay): Create floating UI component script"
  - [ ] 5.2 **Add health bar to unit scene**
    - [ ] 5.2.1 Open `scenes/units/rts_unit.tscn`
    - [ ] 5.2.2 Add Node3D child named "FloatingUI" at position (0, 2.0, 0)
    - [ ] 5.2.3 Add SubViewport child (64x8 size) with ProgressBar
    - [ ] 5.2.4 Add Sprite3D displaying SubViewport texture
    - [ ] 5.2.5 Set Sprite3D size to (1.0, 0.15, 1.0)
    - [ ] 5.2.6 Configure ProgressBar style (green to red gradient)
    - [ ] 5.2.7 Commit: "feat(overlay): Add floating health bar to unit scene"
  - [ ] 5.3 **Add name and level labels**
    - [ ] 5.3.1 In FloatingUI node, add Label3D at (0, 0.3, 0)
    - [ ] 5.3.2 Set billboard mode to BILLBOARD_ENABLED
    - [ ] 5.3.3 Set font size 14, outline color black
    - [ ] 5.3.4 Add second Label3D for level at (0, -0.2, 0)
    - [ ] 5.3.5 Commit: "feat(overlay): Add floating name and level labels"
  - [ ] 5.4 **Integrate floating UI in unit script**
    - [ ] 5.4.1 Read `scripts/units/rts_unit.gd`
    - [ ] 5.4.2 Add @onready references for FloatingUI components
    - [ ] 5.4.3 In _ready(), set name_label.text to display_name
    - [ ] 5.4.4 Set name_label color based on unit_type
    - [ ] 5.4.5 Update health bar when health changes
    - [ ] 5.4.6 Call update_visibility() based on GameSettings
    - [ ] 5.4.7 Commit: "feat(overlay): Integrate floating UI with unit stats"
  - [ ] 5.5 **Connect to settings system**
    - [ ] 5.5.1 In rts_unit.gd, implement `_process()` to check GameSettings
    - [ ] 5.5.2 Show/hide health bar based on health_bar_mode (never/always/injured)
    - [ ] 5.5.3 Show/hide name based on unit type and corresponding setting
    - [ ] 5.5.4 Show/hide level based on show_level setting
    - [ ] 5.5.5 Optimize: only check when settings change (consider signal from GameSettings)
    - [ ] 5.5.6 Commit: "feat(overlay): Connect floating UI visibility to settings"
  - [ ] 5.6 **Test map overlays**
    - [ ] 5.6.1 Run game, verify health bars visible above units
    - [ ] 5.6.2 Verify names display with correct colors
    - [ ] 5.6.3 Open settings, change health bar mode, verify updates
    - [ ] 5.6.4 Toggle name checkboxes, verify visibility changes
    - [ ] 5.6.5 Check performance with 20 units (should be 60 FPS)

- [ ] 6.0 Build Debug Menu (Phase F: Days 11-12)
  - [ ] 6.1 **Create debug panel scene**
    - [ ] 6.1.1 Create `scenes/ui/debug_panel.tscn` with Panel root
    - [ ] 6.1.2 Set anchors: right side, width 300px, height 400px
    - [ ] 6.1.3 Add dark StyleBoxFlat background (#2A2A2A, alpha 0.95)
    - [ ] 6.1.4 Add VBoxContainer with title Label "Debug Tools"
    - [ ] 6.1.5 Add UI elements:
      - Button "Add 1 Level"
      - HBoxContainer: Label "Add XP:" + LineEdit + Button "Apply"
      - Button "Spawn Neutral Unit"
      - Button "Spawn Enemy Unit"
      - HBoxContainer: OptionButton (stats) + LineEdit + Button "Add to Stat"
    - [ ] 6.1.6 Set node names for script access
    - [ ] 6.1.7 Commit: "feat(debug): Create debug panel UI layout"
  - [ ] 6.2 **Implement debug panel logic**
    - [ ] 6.2.1 Create `scripts/ui/debug_panel.gd`, attach to debug_panel.tscn
    - [ ] 6.2.2 Add @onready references for all UI elements
    - [ ] 6.2.3 Get reference to selection_manager (via get_tree().root)
    - [ ] 6.2.4 Validate LineEdit inputs (only numbers, regex filter)
    - [ ] 6.2.5 Populate stat OptionButton with stat names
    - [ ] 6.2.6 Commit: "feat(debug): Create debug panel script with UI references"
  - [ ] 6.3 **Implement level manipulation**
    - [ ] 6.3.1 Connect "Add 1 Level" button pressed signal
    - [ ] 6.3.2 In handler, check if unit selected: `selection_manager.selected_units.size() > 0`
    - [ ] 6.3.3 Get first selected unit, call `unit.level += 1`
    - [ ] 6.3.4 Add 5 stat points: `unit.unspent_stat_points += 5`
    - [ ] 6.3.5 Update HUD via selection_manager.update_hud()
    - [ ] 6.3.6 Test: Select unit, click button, verify level increases
    - [ ] 6.3.7 Commit: "feat(debug): Implement level manipulation tool"
  - [ ] 6.4 **Implement experience manipulation**
    - [ ] 6.4.1 Connect "Apply" button for XP
    - [ ] 6.4.2 Validate selected unit is player-controlled
    - [ ] 6.4.3 Parse LineEdit text to int, validate > 0
    - [ ] 6.4.4 Call `unit.add_experience(amount)`
    - [ ] 6.4.5 Update HUD
    - [ ] 6.4.6 Test: Add 150 XP to level 1 player (should level up)
    - [ ] 6.4.7 Commit: "feat(debug): Implement experience manipulation tool"
  - [ ] 6.5 **Implement unit spawning**
    - [ ] 6.5.1 Connect "Spawn Neutral Unit" button
    - [ ] 6.5.2 In handler, get random position near player (radius 5-10)
    - [ ] 6.5.3 Load and instantiate neutral_unit.tscn at position
    - [ ] 6.5.4 Set level to player level or player level - 1
    - [ ] 6.5.5 Repeat for "Spawn Enemy Unit" with enemy_unit.tscn
    - [ ] 6.5.6 Test: Click buttons, verify units spawn with correct colors
    - [ ] 6.5.7 Commit: "feat(debug): Implement neutral and enemy unit spawning"
  - [ ] 6.6 **Implement stat manipulation**
    - [ ] 6.6.1 Connect "Add to Stat" button
    - [ ] 6.6.2 Validate selected unit exists
    - [ ] 6.6.3 Get selected stat from OptionButton
    - [ ] 6.6.4 Parse amount from LineEdit, validate 1-100
    - [ ] 6.6.5 Call `unit.add_stat(stat_name, amount)`
    - [ ] 6.6.6 Update HUD to reflect stat change
    - [ ] 6.6.7 Test: Add 10 STR, verify attack damage increases
    - [ ] 6.6.8 Commit: "feat(debug): Implement stat manipulation tool"
  - [ ] 6.7 **Integrate debug panel into HUD**
    - [ ] 6.7.1 Open `scenes/ui/hud.tscn`
    - [ ] 6.7.2 Instance debug_panel.tscn
    - [ ] 6.7.3 Add @export var debug_mode: bool = true to hud.gd
    - [ ] 6.7.4 Show/hide debug panel based on debug_mode
    - [ ] 6.7.5 Consider adding F12 key toggle for debug panel
    - [ ] 6.7.6 Test all debug tools together
    - [ ] 6.7.7 Commit: "feat(debug): Integrate debug panel into HUD"

- [ ] 7.0 Integration Testing and Polish (Phase G: Days 13-14)
  - [ ] 7.1 **Comprehensive feature testing**
    - [ ] 7.1.1 Test all bug fixes are still working
    - [ ] 7.1.2 Test unit classification (spawn all 4 types, verify colors)
    - [ ] 7.1.3 Test stats display in HUD for different unit types
    - [ ] 7.1.4 Test leveling: add XP, verify level up, check stat points
    - [ ] 7.1.5 Test settings panel: change all options, verify game view updates
    - [ ] 7.1.6 Test floating UI: verify health bars, names, levels display correctly
    - [ ] 7.1.7 Test debug tools: spawn units, modify stats, add levels/XP
    - [ ] 7.1.8 Document any issues found
  - [ ] 7.2 **Performance testing**
    - [ ] 7.2.1 Set test_unit_count to 50
    - [ ] 7.2.2 Run game, spawn additional units via debug menu
    - [ ] 7.2.3 Monitor FPS (target: 60 FPS with 50 units)
    - [ ] 7.2.4 If FPS drops, identify bottlenecks (likely floating UI updates)
    - [ ] 7.2.5 Optimize if needed (reduce update frequency, object pooling)
    - [ ] 7.2.6 Document performance results
  - [ ] 7.3 **Bug fixes from testing**
    - [ ] 7.3.1 Fix any bugs discovered during integration testing
    - [ ] 7.3.2 Test fixes thoroughly
    - [ ] 7.3.3 Commit each fix individually with descriptive messages
  - [ ] 7.4 **Visual polish**
    - [ ] 7.4.1 Adjust UI spacing and margins for consistency
    - [ ] 7.4.2 Ensure all text is readable (font size, contrast)
    - [ ] 7.4.3 Verify color palette applied consistently
    - [ ] 7.4.4 Add subtle borders or outlines to UI panels
    - [ ] 7.4.5 Commit: "style: Polish UI layout and visual consistency"
  - [ ] 7.5 **Documentation updates**
    - [ ] 7.5.1 Update README.md with new features:
      - Unit types and classification
      - Stats and leveling system
      - Settings menu controls
      - Debug tools usage
    - [ ] 7.5.2 Add screenshots of new UI (optional, if time permits)
    - [ ] 7.5.3 Update controls section with new keybinds (F12 for debug?)
    - [ ] 7.5.4 Document known limitations
    - [ ] 7.5.5 Commit: "docs: Update README with Phase 2 features"
  - [ ] 7.6 **Code quality review**
    - [ ] 7.6.1 Run through all new scripts, add missing doc comments
    - [ ] 7.6.2 Verify all functions have type hints
    - [ ] 7.6.3 Check for magic numbers, replace with named constants
    - [ ] 7.6.4 Remove any debug prints or commented code
    - [ ] 7.6.5 Verify naming conventions followed
    - [ ] 7.6.6 Commit: "refactor: Code cleanup and documentation"
  - [ ] 7.7 **Final acceptance criteria check**
    - [ ] 7.7.1 Go through all acceptance criteria in PRD section 11
    - [ ] 7.7.2 Check off each item as verified
    - [ ] 7.7.3 Document any items not fully met with reasons
  - [ ] 7.8 **Merge to main**
    - [ ] 7.8.1 Ensure all tasks are completed and checked off
    - [ ] 7.8.2 Run final test (F5), play through all features
    - [ ] 7.8.3 Commit any final changes
    - [ ] 7.8.4 Push feature branch: `git push origin feature/phase-2-hud-expansion`
    - [ ] 7.8.5 Merge to main: `git checkout main && git merge feature/phase-2-hud-expansion`
    - [ ] 7.8.6 Push main: `git push origin main`
    - [ ] 7.8.7 Update PRD status to "Completed"
