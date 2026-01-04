# Product Requirements Document (PRD)
## Warcraft 3-Style RTS Game

**Project Name:** Untitled RTS Game  
**Engine:** Godot 4.x  
**Document Version:** 1.0  
**Last Updated:** January 4, 2026  
**Status:** Draft

---

## 1. Executive Summary

This document outlines the requirements for developing a real-time strategy (RTS) game inspired by Warcraft 3, built in Godot 4. The game features isometric camera perspective, unit control mechanics, selection systems, and a comprehensive HUD for unit management. Future iterations will include combat systems, experience progression, unit abilities, and hero mechanics.

---

## 2. Project Goals

### Primary Goals
- Create a functional RTS foundation with smooth unit control and selection
- Implement an intuitive camera system matching Warcraft 3's isometric perspective
- Develop a professional HUD system displaying unit information
- Establish a scalable architecture for future feature expansion

### Success Criteria
- Players can seamlessly select and command multiple units
- Camera movement feels responsive and natural
- HUD provides clear, actionable unit information
- Codebase supports easy addition of combat and progression systems

---

## 3. Target Audience

- **Primary:** RTS enthusiasts familiar with Warcraft 3, Age of Empires, StarCraft
- **Secondary:** Strategy game players looking for tactical gameplay
- **Skill Level:** Casual to competitive players

---

## 4. Core Features (MVP - Phase 1)

### 4.1 Camera System

#### Requirements
- **Isometric Perspective:** 45° horizontal rotation, 35-45° vertical angle
- **Movement Controls:**
  - WASD/Arrow keys for keyboard movement
  - Edge scrolling (mouse near screen borders)
  - Middle mouse button drag (optional)
- **Zoom Controls:**
  - Mouse wheel zoom in/out
  - Configurable min/max zoom distance
- **Camera Bounds:**
  - Constrain camera to playable map area
  - Smooth boundary collision

#### Technical Specifications
- Camera speed: 20 units/second (configurable)
- Edge scroll margin: 20 pixels
- Zoom range: 10-30 units
- Smooth interpolation for all movements

---

### 4.2 Unit Selection System

#### Requirements
- **Single Unit Selection:**
  - Left-click on unit to select
  - Visual feedback: Green selection indicator beneath unit
  - Deselects previous selection (unless Shift held)
  
- **Box Selection:**
  - Click and drag to create selection rectangle
  - All units within box are selected
  - Visual feedback: Semi-transparent selection box overlay
  
- **Multi-Selection:**
  - Shift+Click adds units to current selection
  - Shift+Drag adds box selection to current selection
  - Display count when multiple units selected
  
- **Selection Limits:**
  - No hard limit on selection count
  - Performance optimization for 100+ units

#### Visual Feedback
- Selected units: Green circular indicator at feet
- Hovered units: Subtle highlight or outline
- Selection box: Semi-transparent blue overlay with border

---

### 4.3 Unit Movement System

#### Requirements
- **Right-Click Movement:**
  - Right-click on terrain to issue move command
  - All selected units move to target location
  - Visual feedback: Movement destination indicator (temporary)
  
- **Pathfinding:**
  - Units navigate around obstacles
  - Group movement maintains formation
  - Units stop when reaching destination
  
- **Movement Animation:**
  - Units rotate to face movement direction
  - Smooth acceleration/deceleration
  - Idle animation when stationary

#### Technical Specifications
- Movement speed: 5 units/second (base, varies by unit type)
- Pathfinding: Godot's NavigationAgent or A* algorithm
- Formation: Basic spread to avoid unit overlap

---

### 4.4 HUD System (Bottom Panel)

#### Layout Design
```
┌─────────────────────────────────────────────────────────────┐
│                    [Viewport Area]                          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
┌──────────────────────────────────────────────────────────────┐
│ [Unit Portrait] │ [Unit Info]      │ [Control Panel]        │
│                 │ Name: Warrior    │ [Abilities]            │
│   [Image]       │ HP: 100/100      │ [ ] [ ] [ ] [ ]        │
│                 │ Type: Infantry   │ [ ] [ ] [ ] [ ]        │
└──────────────────────────────────────────────────────────────┘
```

#### Single Unit Display
- **Unit Portrait:** 80x80px unit image/icon
- **Unit Name:** Display unit type name
- **Health Bar:** Visual bar showing current/max HP
- **Health Text:** "HP: 100/100" format
- **Unit Type:** Display unit classification
- **Additional Stats:** (Future: Armor, Attack, etc.)

#### Multiple Units Display
- **Group Indicator:** "Multiple Units (X selected)"
- **Unit Type Summary:** Count by type (e.g., "3 Warriors, 2 Archers")
- **Average Health:** Overall group health percentage
- **Portrait Grid:** Small icons of selected unit types

#### No Selection Display
- **Empty State:** Minimized panel or placeholder text
- **Game Info:** (Optional) Resources, time, etc.

#### Technical Requirements
- HUD positioned at bottom, 200px height
- Responsive to different screen resolutions
- Update in real-time (every frame or on selection change)
- Smooth transitions between states

---

### 4.5 Unit System

#### Base Unit Properties
Each unit must have:
- **Name:** String identifier (e.g., "Warrior", "Archer")
- **Max Health:** Integer (e.g., 100)
- **Current Health:** Integer (0 to max_health)
- **Unit Type:** Enum (Infantry, Ranged, Cavalry, Hero, etc.)
- **Move Speed:** Float (units per second)
- **Visual Representation:** 3D mesh or sprite

#### Unit Behavior
- **Idle State:** Default animation when not moving
- **Moving State:** Walk/run animation toward target
- **Selection Response:** Visual indicator appears when selected
- **Click Detection:** Proper collision shape for mouse picking

---

### 4.6 Terrain & Environment

#### Requirements
- **Playable Terrain:** 50x50 unit flat plane (expandable)
- **Visual Style:** Simple textured ground (grass/dirt)
- **Collision:** Static body for mouse raycasting
- **Lighting:** Directional light for day/night atmosphere
- **Boundaries:** Clear visual or invisible walls

---

## 5. Future Features (Post-MVP)

### Phase 2: Combat System
- **Unit Attacks:**
  - Right-click on enemy to attack
  - Auto-attack when enemies in range
  - Attack animations and sound effects
  
- **Damage System:**
  - Base damage values per unit type
  - Armor/defense calculations
  - Critical hits (optional)
  
- **Unit Death:**
  - Death animation
  - Corpse remains (temporary)
  - Remove from selection on death

### Phase 3: Experience & Progression
- **Experience Points (XP):**
  - Gain XP from killing enemies
  - XP shared within range or by participation
  
- **Leveling System:**
  - Max level 10 (or configurable)
  - Stat increases per level (HP, damage, etc.)
  - Visual level indicator above unit
  
- **Skill Points:**
  - Gain skill points on level up
  - Spend on abilities or stat bonuses

### Phase 4: Abilities & Skills
- **Active Abilities:**
  - 4-8 ability slots per unit
  - Hotkeys (Q, W, E, R, etc.)
  - Cooldowns and mana/resource costs
  
- **Passive Abilities:**
  - Always-active bonuses
  - Unlocked through leveling or items
  
- **Hero Units:**
  - Special powerful units with unique abilities
  - Advanced skill trees
  - Inventory system for items

### Phase 5: Resource Management
- **Resources:**
  - Gold, Wood, Food (population)
  - Resource gathering units
  - Resource display in HUD
  
- **Building System:**
  - Construct buildings for unit production
  - Tech trees and upgrades

### Phase 6: Advanced Features
- **Multiplayer:** Network synchronization
- **AI Opponents:** Computer-controlled enemies
- **Campaign Mode:** Story-driven missions
- **Map Editor:** Custom map creation tools

---

## 6. Technical Requirements

### 6.1 Architecture

```
project/
├── scenes/
│   ├── units/
│   │   ├── rts_unit.tscn (base unit template)
│   │   ├── warrior.tscn
│   │   ├── archer.tscn
│   │   └── hero.tscn
│   ├── ui/
│   │   ├── hud.tscn
│   │   ├── unit_portrait.tscn
│   │   └── ability_button.tscn
│   ├── world.tscn (main game scene)
│   └── terrain.tscn
├── scripts/
│   ├── units/
│   │   ├── rts_unit.gd (base class)
│   │   ├── unit_stats.gd (data class)
│   │   └── unit_abilities.gd
│   ├── systems/
│   │   ├── selection_manager.gd
│   │   ├── input_manager.gd
│   │   ├── combat_manager.gd (future)
│   │   └── experience_manager.gd (future)
│   ├── ui/
│   │   ├── hud.gd
│   │   └── hud_controller.gd
│   ├── camera_controller.gd
│   └── game_manager.gd (autoload singleton)
├── resources/
│   ├── units/ (unit data resources)
│   ├── abilities/ (ability data resources)
│   └── stats/ (stat modifiers)
└── assets/
    ├── models/
    ├── textures/
    ├── audio/
    └── ui/
```

### 6.2 Design Patterns

- **Singleton Pattern:** GameManager for global state
- **Component Pattern:** Separate selection, movement, combat components
- **Observer Pattern:** Events for unit selection, death, level up
- **State Machine:** Unit states (Idle, Moving, Attacking, Dead)
- **Resource Pattern:** ScriptableObjects for unit data

### 6.3 Performance Targets

- **Target FPS:** 60 FPS
- **Max Units on Screen:** 200+ without performance degradation
- **Camera Movement:** Smooth 60 FPS during all movements
- **Selection Response:** < 50ms selection feedback
- **Pathfinding:** < 16ms per frame for all units

### 6.4 Godot 4 Specific

- **Rendering:** Forward+ or Mobile renderer
- **Physics:** 3D physics for raycasting
- **Signals:** Extensive use for decoupled communication
- **Nodes:** Prefer scene composition over inheritance
- **Resources:** Custom resources for unit data

---

## 7. User Stories & Acceptance Criteria

### Story 1: Camera Control
**As a player, I want to move the camera smoothly so I can view different parts of the battlefield.**

**Acceptance Criteria:**
- [ ] WASD keys move camera in 4 directions
- [ ] Arrow keys move camera in 4 directions
- [ ] Mouse at screen edges scrolls camera
- [ ] Mouse wheel zooms in/out
- [ ] Camera stays within map boundaries
- [ ] Camera movement feels smooth and responsive

---

### Story 2: Unit Selection
**As a player, I want to select units easily so I can give them commands.**

**Acceptance Criteria:**
- [ ] Left-clicking a unit selects it
- [ ] Selected unit shows green indicator
- [ ] Click-dragging creates selection box
- [ ] All units in box are selected
- [ ] Shift+click adds to selection
- [ ] Clicking terrain deselects all units

---

### Story 3: Unit Movement
**As a player, I want to move my units to specific locations so I can position them strategically.**

**Acceptance Criteria:**
- [ ] Right-clicking terrain moves selected units
- [ ] Units navigate around obstacles
- [ ] Multiple units maintain formation
- [ ] Units face movement direction
- [ ] Units stop at destination
- [ ] Visual feedback shows move target

---

### Story 4: Unit Information Display
**As a player, I want to see my selected unit's information so I know their status.**

**Acceptance Criteria:**
- [ ] HUD displays when unit is selected
- [ ] Unit name is clearly visible
- [ ] Health bar shows current/max HP
- [ ] Health updates in real-time
- [ ] Unit type is displayed
- [ ] Multiple units show group info
- [ ] HUD minimizes when nothing selected

---

## 8. Design Considerations

### 8.1 Visual Style
- **Art Direction:** Low-poly 3D or stylized 2D sprites
- **Color Palette:** Vibrant, readable colors (WC3-inspired)
- **UI Theme:** Medieval fantasy aesthetic
- **Selection Colors:** Green (friendly), Red (enemy), Yellow (neutral)

### 8.2 Audio
- **Unit Selection:** Acknowledgment voice lines ("Yes?", "Ready!")
- **Movement:** Footstep sounds
- **UI:** Button clicks, hover sounds
- **Ambient:** Background music, environmental sounds

### 8.3 Accessibility
- **Colorblind Mode:** Alternative selection colors
- **Hotkeys:** Fully customizable key bindings
- **UI Scaling:** Support for different resolutions
- **Text Size:** Adjustable font sizes

---

## 9. Testing Requirements

### 9.1 Functional Testing
- [ ] Camera movement in all directions
- [ ] Camera zoom limits enforced
- [ ] Single unit selection works
- [ ] Box selection selects all units in area
- [ ] Shift-selection adds to group
- [ ] Right-click movement commands work
- [ ] Units navigate around obstacles
- [ ] HUD updates on selection change
- [ ] HUD displays correct unit information
- [ ] Performance with 50+ units

### 9.2 Edge Cases
- [ ] Selecting off-screen units
- [ ] Rapid selection/deselection
- [ ] Moving units to invalid terrain
- [ ] Camera at map boundaries
- [ ] Zero units selected
- [ ] Maximum units selected (stress test)

### 9.3 Performance Testing
- [ ] 60 FPS with 100 units on screen
- [ ] Box selection with 50+ units
- [ ] Camera movement under load
- [ ] Memory usage monitoring

---

## 10. Development Phases

### Phase 1: Foundation (Current - Week 1-2)
**Status:** ✅ Complete

- [x] Project setup and structure
- [x] Basic camera controller with isometric view
- [x] Terrain and world scene
- [x] Basic unit scene with mesh
- [x] Single unit selection
- [x] Box selection system
- [x] Unit movement with right-click
- [x] Basic HUD layout
- [x] HUD shows single unit info correctly
- [x] HUD shows multiple unit info
- [x] Polish and bug fixes

**Deliverable:** ✅ Playable demo with selection and movement

---

### Phase 2: Combat System (Week 3-4)
**Status:** 🔲 Not Started

- [ ] Attack command implementation
- [ ] Damage calculation system
- [ ] Health reduction and death
- [ ] Attack animations
- [ ] Auto-attack behavior
- [ ] Unit aggro and targeting
- [ ] Combat sound effects
- [ ] Death animations and cleanup

**Deliverable:** Units can fight and destroy each other

---

### Phase 3: Progression (Week 5-6)
**Status:** 🔲 Not Started

- [ ] Experience point system
- [ ] Level up mechanics
- [ ] Stat scaling per level
- [ ] Visual level indicators
- [ ] XP sharing algorithms
- [ ] Balance tuning
- [ ] Progression UI elements

**Deliverable:** Units gain experience and level up

---

### Phase 4: Abilities (Week 7-9)
**Status:** 🔲 Not Started

- [ ] Ability system architecture
- [ ] Cooldown management
- [ ] Resource costs (mana/energy)
- [ ] Ability buttons in HUD
- [ ] Targeting system
- [ ] 3-5 example abilities
- [ ] Hero unit template
- [ ] Skill tree UI

**Deliverable:** Units have usable abilities

---

### Phase 5: Polish & Features (Week 10+)
**Status:** 🔲 Not Started

- [ ] Multiple unit types (3-5)
- [ ] Resource gathering
- [ ] Building placement
- [ ] AI opponents
- [ ] Sound and music
- [ ] Visual effects
- [ ] Menu systems
- [ ] Save/load functionality

**Deliverable:** Feature-complete game

---

## 11. Known Issues & Risks

### Technical Risks
- **Pathfinding Performance:** Large unit counts may impact performance
  - *Mitigation:* Use Godot's NavigationServer, optimize pathing frequency
  
- **Network Latency:** Future multiplayer may have sync issues
  - *Mitigation:* Plan for lockstep or rollback netcode early
  
- **Unit Overlap:** Many units in tight spaces may clip
  - *Mitigation:* Implement collision avoidance, formation logic

### Design Risks
- **Complexity Creep:** Too many features too fast
  - *Mitigation:* Strict MVP scope, phased rollout
  
- **Balance Issues:** Combat may be difficult to balance
  - *Mitigation:* Extensive playtesting, data-driven stat system

---

## 12. Success Metrics

### MVP Success Criteria
- [ ] Players can select and move units without confusion
- [ ] Camera feels responsive and intuitive
- [ ] HUD clearly displays unit information
- [ ] No critical bugs in core systems
- [ ] Maintains 60 FPS with 50 units

### Long-term Success Criteria
- [ ] Combat feels satisfying and strategic
- [ ] Progression system encourages continued play
- [ ] Multiple viable unit compositions and strategies
- [ ] Positive playtester feedback
- [ ] Scalable to multiplayer

---

## 13. References & Inspiration

### Games
- **Warcraft 3:** Camera, selection, HUD layout
- **StarCraft II:** Control groups, hotkeys
- **Age of Empires IV:** Pathfinding, formations
- **Company of Heroes:** Squad-based mechanics

### Documentation
- Godot 4 Official Docs: https://docs.godotengine.org/
- RTS Game Design: Classic Game Postmortems
- Pathfinding Algorithms: A* implementation guides

---

## 14. Appendix

### Terminology
- **RTS:** Real-Time Strategy
- **MVP:** Minimum Viable Product
- **HUD:** Heads-Up Display
- **XP:** Experience Points
- **AOE:** Area of Effect
- **DPS:** Damage Per Second

### Contact & Contributors
- **Project Lead:** [Your Name]
- **Repository:** [Git URL]
- **Feedback:** [Contact Method]

---

## 15. Change Log

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2026-01-04 | Initial PRD creation | AI Assistant |

---

**Next Steps:**
1. Complete Phase 1 MVP features
2. Conduct internal playtesting
3. Gather feedback and iterate
4. Plan Phase 2 development sprint
