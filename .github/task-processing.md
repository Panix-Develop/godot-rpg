# Task Processing Instructions

You are processing a task list for a vibe coding session. Follow these rules strictly.

---

## Task List Format

Task lists use this structure:

- [ ] Parent Task 1
  - [ ] Subtask 1.1
  - [ ] Subtask 1.2
  - [ ] Subtask 1.3
- [ ] Parent Task 2
  - [ ] Subtask 2.1
  - [ ] Subtask 2.2

---

## Processing Rules

### Rule 1: Work in Logical Groups

- Do NOT automatically complete all subtasks of a parent task
- Group subtasks that logically belong together
- Complete one logical group at a time
- Ask or wait for confirmation before moving to the next group
- Example: If subtasks 1.1 and 1.2 are related (e.g., both about UI), do them together. If 1.3 is about backend, do it separately.

### Rule 2: Mark Subtasks as Complete

After finishing a subtask:
- Immediately mark it as done by changing [ ] to [x]
- Show the updated task list
- Format: - [x] Completed subtask description

### Rule 3: Check Parent Task Completion

After marking any subtask as complete:
1. Check if ALL subtasks of that parent task are now [x]
2. If ALL subtasks are complete, mark the parent task as [x]
3. If some subtasks remain [ ], leave the parent task as [ ]

### Rule 4: Error Checking (MANDATORY)

After EVERY implementation, before marking as complete:

1. Check for syntax errors in the code
2. Check for type errors (if using typed language)
3. Check for import/reference errors
4. Check for logical errors and bugs
5. Run the linter if available
6. Run the build/compile if applicable
7. Run tests if they exist for the modified code

Error Check Commands by Project Type:

TypeScript/JavaScript:
- npm run lint OR npx eslint .
- npm run build OR npx tsc --noEmit
- npm run test (if applicable)

Python:
- python -m py_compile <file>
- pylint <file> OR flake8 <file>
- mypy <file> (if using type hints)
- pytest (if applicable)

Godot 4 / GDScript:
- Open the project in Godot and check the Errors tab
- Look for red error indicators in the script editor
- Check the Output panel for runtime errors
- Run the scene to verify no crashes

General:
- Review all modified files for obvious errors
- Check that all imports/dependencies exist
- Verify function signatures match their calls
- Ensure no undefined variables or typos

DO NOT mark a subtask as complete if errors exist.
DO NOT proceed to the next subtask if errors exist.
FIX all errors first, then mark as complete.

### Rule 5: Pre-Commit Validation (MANDATORY)

Before ANY commit, perform this checklist:

1. LINT: Run the project linter
   - Fix all linting errors
   - Fix all linting warnings (or justify ignoring)

2. BUILD: Verify the project builds/compiles
   - No build errors allowed
   - No type errors allowed

3. TEST: Run the test suite
   - All tests must pass
   - No skipped tests without justification

4. REVIEW: Manual code review
   - Check for console.log/print statements that should be removed
   - Check for commented-out code
   - Check for TODO comments that should be addressed
   - Check for hardcoded values that should be constants

5. RUN: If possible, run the application
   - Verify no runtime errors
   - Verify the feature works as expected

Pre-Commit Checklist Format:

## Pre-Commit Checklist
- [ ] Linter passed (no errors)
- [ ] Build/compile successful
- [ ] Tests passing
- [ ] No debug code remaining
- [ ] No commented-out code
- [ ] Feature tested manually

If ANY check fails:
- DO NOT commit
- Fix the issues first
- Re-run all checks
- Only commit when all checks pass

### Rule 6: Commit After Parent Task Completion

When a parent task is fully completed (all subtasks done):
1. Run the full pre-commit validation (Rule 5)
2. Fix any errors found
3. Mark the parent task as [x]
4. Create a git commit
5. Use commit message format: feat(<scope>): <parent task description>
6. Show the commit command to execute
7. Then proceed to the next parent task

### Rule 7: Show Progress

After each work session, display:
1. The updated task list with current completion status
2. Summary of what was completed
3. Error check results
4. What logical group comes next
5. Suggested commit message if a parent task was completed

---

## Workflow Example

Given this task list:

- [ ] User Authentication
  - [ ] Create login form UI
  - [ ] Create registration form UI
  - [ ] Implement login API endpoint
  - [ ] Implement registration API endpoint
  - [ ] Add form validation
- [ ] Dashboard
  - [ ] Create dashboard layout
  - [ ] Add user stats widget

Step 1: Work on logical group (UI forms)
- Complete: Create login form UI
- ERROR CHECK: Verify no errors in login form
- Complete: Create registration form UI
- ERROR CHECK: Verify no errors in registration form
- Mark both as [x]
- Parent still [ ] (not all subtasks done)
- Show updated list

Step 2: Work on next logical group (API endpoints)
- Complete: Implement login API endpoint
- ERROR CHECK: Verify no errors, test endpoint
- Complete: Implement registration API endpoint
- ERROR CHECK: Verify no errors, test endpoint
- Mark both as [x]
- Parent still [ ] (validation remains)
- Show updated list

Step 3: Complete remaining subtask
- Complete: Add form validation
- ERROR CHECK: Verify validation works, no errors
- Mark as [x]
- ALL subtasks now [x]
- PRE-COMMIT VALIDATION:
  - Run linter: PASSED
  - Run build: PASSED
  - Run tests: PASSED
  - Manual review: PASSED
- Mark parent "User Authentication" as [x]
- COMMIT: feat(auth): implement user authentication
- Show updated list

Step 4: Move to next parent task (Dashboard)
- Continue with same process...

---

## Task List Update Format

Always show the task list in this format after changes:

## Current Task List

- [x] Completed Parent Task
  - [x] Completed subtask
  - [x] Completed subtask
- [ ] In Progress Parent Task
  - [x] Completed subtask
  - [ ] Pending subtask
  - [ ] Pending subtask
- [ ] Pending Parent Task
  - [ ] Pending subtask

### Just Completed
- Subtask name 1
- Subtask name 2

### Error Check Results
- Linter: PASSED / FAILED (details)
- Build: PASSED / FAILED (details)
- Tests: PASSED / FAILED (details)
- Issues Found: None / List of issues

### Next Up
- Subtask name (logical group description)

### Commit Required
> If parent task completed and all checks passed:
> git commit -m "feat(scope): description"

---

## Error Handling Workflow

When an error is found:

1. STOP current work
2. IDENTIFY the error clearly
   - What is the error message?
   - Which file and line?
   - What is the cause?
3. FIX the error
4. VERIFY the fix worked
5. CHECK for any new errors caused by the fix
6. CONTINUE only when error-free

Error Report Format:

## Error Found

**Type:** Syntax / Type / Runtime / Logic / Lint
**File:** path/to/file.ext
**Line:** 42
**Message:** Description of the error
**Cause:** Why this happened
**Fix:** How it was fixed
**Verified:** Yes / No

---

## Important Reminders

- NEVER skip error checking
- NEVER commit code with errors
- NEVER mark a task complete if errors exist
- Never skip marking tasks as complete
- Never forget to check parent task status after subtask completion
- Never forget to commit after parent task completion
- Never rush through all subtasks without logical grouping
- Always show the updated task list
- Always run linter before commits
- Always verify build succeeds before commits
- Always wait for user input before starting the next logical group unless explicitly told to continue

---

## Commands the User May Give

- "continue" - Proceed with the next logical group
- "do all" - Complete all remaining subtasks (still follow commit rules)
- "skip" - Skip current subtask, move to next
- "show tasks" - Display current task list status
- "commit now" - Force a commit at current state (still run pre-commit checks)
- "what's next" - Show what the next logical group would be
- "check errors" - Run full error check on current state
- "lint" - Run linter and show results
- "fix errors" - Focus on fixing any existing errors