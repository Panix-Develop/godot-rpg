<!-- .github/copilot-instructions.md -->

# Project Development Guidelines

You are an expert software engineer assistant. Follow these guidelines strictly for all code generation, modifications, and suggestions.

---

## Project Configuration

> **Instructions:** Check the boxes and fill in details for your project stack.

### Languages
- [ ] TypeScript
- [ ] JavaScript
- [ ] Python
- [X] GDScript (Godot 4)
- [ ] C#
- [ ] Rust
- [ ] Go
- [ ] Other: _____________

### Frameworks & Libraries
- [ ] React
- [ ] Next.js
- [ ] Vue
- [ ] Svelte
- [ ] Node.js / Express
- [ ] FastAPI
- [X] Godot 4 Engine
- [ ] Unity
- [ ] Other: _____________

### Databases
- [ ] PostgreSQL
- [ ] MongoDB
- [ ] SQLite
- [ ] Redis
- [ ] Firebase
- [ ] Supabase
- [ ] None
- [ ] Other: _____________

### Testing Frameworks
- [ ] Jest
- [ ] Vitest
- [ ] Pytest
- [X] GUT (Godot Unit Test)
- [ ] Other: _____________

### Additional Tools & Libraries
- _____________
- _____________
- _____________

### Project Notes
> Add any project-specific context, requirements, or constraints here.

[Write your project-specific notes here]

---

## 1. Core Principles

- Write clean, readable, and maintainable code
- Follow the principle of least surprise
- Keep it simple (KISS)
- Do not repeat yourself (DRY)
- You are not gonna need it (YAGNI)
- Fail fast and fail loudly
- Make it work, make it right, make it fast (in that order)

---

## 2. Code Quality & Clean Code

### General Rules
- Write self-documenting code with meaningful names
- Keep functions small and focused (max 20-30 lines)
- Follow the Single Responsibility Principle (SRP)
- Prefer composition over inheritance
- Avoid deep nesting (max 3 levels)
- No magic numbers or strings - use named constants
- Remove dead code, never comment out code blocks
- One concept per function

### Naming Conventions
- Variables/Functions: camelCase or snake_case (match language convention)
- Classes/Types: PascalCase - nouns describing the entity
- Constants: UPPER_SNAKE_CASE
- Booleans: prefix with is, has, can, should
- Functions: descriptive verbs (get_user_by_id, calculate_total)
- Files: kebab-case or snake_case (match project convention)

### Code Smells to Avoid
- God classes/functions that do too much
- Duplicate code - extract into reusable functions
- Long parameter lists (max 3-4, otherwise use objects/dictionaries)
- Tight coupling between modules
- Premature optimization
- Deep inheritance hierarchies
- Global mutable state

---

## 3. Design Patterns & Architecture

### Preferred Patterns
- Repository Pattern for data access
- Factory Pattern for complex object creation
- Strategy Pattern over switch statements for behavior
- Dependency Injection for loose coupling
- Observer/Event Pattern for decoupled communication
- State Pattern for state machines (especially in games)
- Command Pattern for undo/redo and action queuing

### Architecture Guidelines
- Separate concerns: UI / Business Logic / Data Access
- Use interfaces/protocols to define contracts
- Keep external dependencies at the edges
- Follow the Dependency Inversion Principle
- Layer your architecture appropriately

### General File Structure

project/
├── src/                    # Source code
│   ├── components/         # UI components
│   ├── services/           # Business logic
│   ├── repositories/       # Data access
│   ├── models/             # Types, interfaces, data classes
│   ├── utils/              # Pure helper functions
│   └── constants/          # App-wide constants
├── tests/                  # Test files
├── docs/                   # Documentation
└── config/                 # Configuration files

---

## 4. Error Handling

- Never swallow errors silently
- Use custom error classes for domain errors
- Always provide meaningful error messages
- Handle errors at appropriate boundaries
- Log errors with context for debugging
- Validate inputs at system boundaries
- Use early returns for guard clauses

Good: throw ValidationError("Invalid email format: " + email)
Bad: throw Error("Error")

---

## 5. Testing Requirements

### Test Coverage
- Write tests for all new functions and features
- Aim for minimum 80% code coverage on critical paths
- Test edge cases and error scenarios
- Tests are mandatory, not optional
- Test behavior, not implementation details

### Test Structure (AAA Pattern)

describe("FunctionName"):
    test "should [expected behavior] when [condition]":
        # Arrange - Set up test data
        input = create_test_data()
        
        # Act - Execute the function
        result = function_under_test(input)
        
        # Assert - Verify the outcome
        assert result == expected_output

### Test Naming
- Describe WHAT the function does, not HOW
- Use format: should [expected behavior] when [condition]
- Group related tests with describe/context blocks

### Test Types
- Unit Tests: For pure functions and isolated logic
- Integration Tests: For API endpoints and system interactions
- E2E Tests: For critical user flows
- Game Tests: For game mechanics and state transitions

---

## 6. Documentation

### Code Comments
- Write WHY, not WHAT (code shows what)
- Document complex algorithms and business rules
- Keep comments up-to-date with code changes
- Use doc comments for public APIs
- Document non-obvious performance considerations

### README Requirements
- Project description and purpose
- Installation instructions
- Usage examples
- Configuration options
- Contributing guidelines
- License information

---

## 7. Git Workflow & Commits

### Commit Frequently
- Commit after each logical unit of work
- Never leave work uncommitted at end of session
- Commit working code only (tests should pass)
- Small, atomic commits are preferred
- Each commit should be a single logical change

### Commit Message Format

<type>(<scope>): <short description>

[optional body with details]

[optional footer with breaking changes or issue refs]

### Commit Types

| Type     | Description                                |
|----------|--------------------------------------------|
| feat     | New feature                                |
| fix      | Bug fix                                    |
| refactor | Code restructuring without behavior change |
| test     | Adding or updating tests                   |
| docs     | Documentation changes                      |
| chore    | Build, config, dependencies                |
| style    | Formatting, no code change                 |
| perf     | Performance improvements                   |
| ci       | CI/CD changes                              |

### Commit Examples

feat(auth): add password reset functionality
fix(cart): resolve quantity update race condition
refactor(api): extract validation into middleware
test(user): add edge cases for email validation
docs(readme): update installation instructions
feat(player): implement double jump mechanic

### Branch Naming
- feature/short-description
- bugfix/issue-number-description
- refactor/component-name
- hotfix/critical-issue

### Git Best Practices
- Pull/rebase before pushing
- Write meaningful PR descriptions
- Keep branches short-lived
- Delete merged branches

---

## 8. Security Practices

- Never hardcode secrets, API keys, or passwords
- Validate and sanitize all user inputs
- Use parameterized queries (prevent SQL injection)
- Implement proper authentication/authorization checks
- Keep dependencies updated
- Use environment variables for sensitive config
- Follow the principle of least privilege
- Encrypt sensitive data at rest and in transit

---

## 9. Performance Considerations

- Avoid premature optimization, but be mindful
- Use appropriate data structures
- Implement pagination for large datasets
- Cache expensive operations when appropriate
- Profile before optimizing
- Consider memory usage in loops
- Use lazy loading where appropriate
- Batch operations when possible

---

## 10. Language-Specific Guidelines

### TypeScript / JavaScript
- Enable strict mode in TypeScript
- No any type - use unknown if type is uncertain
- Use type guards for narrowing
- Prefer interfaces over type aliases for objects
- Use enums or const objects for fixed sets of values
- Async/await over callbacks and raw promises
- Use optional chaining and nullish coalescing

### Python
- Follow PEP 8 style guide
- Use type hints for all functions
- Use dataclasses or Pydantic for data structures
- Virtual environments for dependencies
- Use context managers for resources
- Prefer list comprehensions over map/filter when readable

### GDScript / Godot 4

IMPORTANT: Always use Godot 4.x syntax and features. Never use Godot 3.x patterns.

#### Godot 4 Specific Rules
- Use @onready instead of onready
- Use @export instead of export
- Use super() instead of . for parent calls
- Use await instead of yield
- Use typed arrays: Array[Type]
- Use StringName for signals and node paths where appropriate
- Use NOTIFICATION_* constants with _notification() for engine callbacks

#### GDScript Style

class_name ClassName
extends BaseClass

## Brief description of the class.
## More detailed description if needed.

signal health_changed(new_health: int)

const MAX_HEALTH: int = 100

@export var speed: float = 200.0
@export_range(0, 100) var health: int = 100

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var _private_variable: int = 0


func _ready() -> void:
    pass


func _process(delta: float) -> void:
    pass


func _physics_process(delta: float) -> void:
    pass


## Public method description.
func public_method(param: Type) -> ReturnType:
    return value


func _private_method() -> void:
    pass

#### Godot 4 Project Structure

project/
├── addons/                 # Third-party addons
├── assets/                 # Art, audio, fonts
│   ├── sprites/
│   ├── audio/
│   └── fonts/
├── scenes/                 # Scene files (.tscn)
│   ├── characters/
│   ├── levels/
│   ├── ui/
│   └── objects/
├── scripts/                # GDScript files (.gd)
│   ├── autoloads/          # Singleton scripts
│   ├── components/         # Reusable components
│   ├── resources/          # Custom resources
│   └── utils/              # Utility functions
├── resources/              # Custom resource files (.tres)
├── shaders/                # Shader files (.gdshader)
└── project.godot

#### Godot 4 Best Practices
- Use signals for decoupled communication
- Use custom resources for data
- Use scene composition over inheritance
- Use groups for batch operations
- Use autoloads sparingly (only for truly global state)
- Cache node references with @onready
- Use is_instance_valid() before accessing freed nodes
- Use set_deferred() for physics-safe property changes
- Prefer move_and_slide() over manual velocity handling
- Use AnimationPlayer or Tween for animations

#### Godot 4 Signals Pattern

# Defining signals
signal health_changed(old_value: int, new_value: int)
signal died

# Emitting signals
func take_damage(amount: int) -> void:
    var old_health := health
    health -= amount
    health_changed.emit(old_health, health)
    if health <= 0:
        died.emit()

# Connecting signals (in code)
func _ready() -> void:
    health_changed.connect(_on_health_changed)
    
func _on_health_changed(old_value: int, new_value: int) -> void:
    print("Health: %d -> %d" % [old_value, new_value])

#### Godot 4 State Machine Pattern

class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}


func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.transitioned.connect(_on_state_transitioned)
    
    if initial_state:
        initial_state.enter()
        current_state = initial_state


func _process(delta: float) -> void:
    if current_state:
        current_state.update(delta)


func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_update(delta)


func _on_state_transitioned(state: State, new_state_name: String) -> void:
    if state != current_state:
        return
    
    var new_state: State = states.get(new_state_name.to_lower())
    if not new_state:
        return
    
    current_state.exit()
    new_state.enter()
    current_state = new_state

### C#
- Follow Microsoft naming conventions
- Use nullable reference types
- Use records for immutable data
- Use LINQ judiciously
- Dispose of resources properly (using statements)

### Rust
- Follow Rust idioms and clippy suggestions
- Use Result for recoverable errors
- Use Option instead of null
- Prefer borrowing over cloning
- Document unsafe blocks

---

## 11. Code Review Checklist

Before considering code complete, verify:

- [ ] Code follows naming conventions
- [ ] Functions are small and focused
- [ ] No code duplication
- [ ] Error handling is implemented
- [ ] Tests are written and passing
- [ ] Documentation is updated
- [ ] No debug/console output in production code
- [ ] No commented-out code
- [ ] No hardcoded secrets or credentials
- [ ] Changes are committed with proper message
- [ ] Edge cases are handled
- [ ] Performance is acceptable

---

## 12. Response Format

When generating or modifying code:

1. Explain the approach briefly
2. Show the implementation with clean, documented code
3. Include relevant tests
4. Suggest a commit message
5. Note any assumptions, alternatives, or potential issues

When suggesting commits:
- Prompt for commits after logical units of work
- Provide the full commit message to use
- Remind about uncommitted changes when ending a session

---

## 13. Communication Style

- Be concise but thorough
- Explain trade-offs when relevant
- Suggest improvements proactively
- Ask clarifying questions when requirements are ambiguous
- Warn about potential issues or anti-patterns
- Provide alternatives when appropriate

---

These guidelines ensure consistent, maintainable, and high-quality code. When in doubt, prioritize readability and simplicity over cleverness.