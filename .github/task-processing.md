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

### Rule 4: Commit After Parent Task Completion

When a parent task is fully completed (all subtasks done):
1. Mark the parent task as [x]
2. Create a git commit immediately
3. Use commit message format: feat(<scope>): <parent task description>
4. Show the commit command to execute
5. Then proceed to the next parent task

### Rule 5: Show Progress

After each work session, display:
1. The updated task list with current completion status
2. Summary of what was completed
3. What logical group comes next
4. Suggested commit message if a parent task was completed

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
- Complete: Create registration form UI
- Mark both as [x]
- Parent still [ ] (not all subtasks done)
- Show updated list

Step 2: Work on next logical group (API endpoints)
- Complete: Implement login API endpoint
- Complete: Implement registration API endpoint
- Mark both as [x]
- Parent still [ ] (validation remains)
- Show updated list

Step 3: Complete remaining subtask
- Complete: Add form validation
- Mark as [x]
- ALL subtasks now [x]
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

### Next Up
- Subtask name (logical group description)

### Commit Required
> If parent task completed, show:
> git commit -m "feat(scope): description"

---

## Important Reminders

- Never skip marking tasks as complete
- Never forget to check parent task status after subtask completion
- Never forget to commit after parent task completion
- Never rush through all subtasks without logical grouping
- Always show the updated task list
- Always wait for user input before starting the next logical group unless explicitly told to continue

---

## Commands the User May Give

- "continue" - Proceed with the next logical group
- "do all" - Complete all remaining subtasks (still follow commit rules)
- "skip" - Skip current subtask, move to next
- "show tasks" - Display current task list status
- "commit now" - Force a commit at current state
- "what's next" - Show what the next logical group would be