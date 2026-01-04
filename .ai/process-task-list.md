# Task List Management

Guidelines for managing task lists in markdown files to track progress on completing a PRD

## Task Implementation
- **One sub-task at a time:** Do **NOT** start the next sub‑task until you ask the user for permission and they say "yes" or "y"
- **Completion protocol:**  
  1. When you finish a **sub‑task**, immediately mark it as completed by changing `[ ]` to `[x]`.
  2. If **all** subtasks underneath a parent task are now `[x]`, follow this sequence:
    - **First**: Run the full test suite (`pytest`, `npm test`, `bin/rails test`, etc.)
    - **Only if all tests pass**: Stage changes (`git add .`)
    - **Clean up**: Remove any temporary files and temporary code before committing
    - **Commit**: Use a descriptive commit message that:
      - Uses conventional commit format (`feat:`, `fix:`, `refactor:`, etc.)
      - Summarizes what was accomplished in the parent task
      - Lists key changes and additions
      - References the task number and PRD context
      - **Formats the message as a single-line command using `-m` flags**, e.g.:

        ```
        git commit -m "feat: add payment validation logic" -m "- Validates card type and expiry" -m "- Adds unit tests for edge cases" -m "Related to T123 in PRD"
        ```
  3. Once all the subtasks are marked completed and changes have been committed, mark the **parent task** as completed.
- Stop after each sub‑task and wait for the user's go‑ahead.

## Task List Maintenance

1. **Update the task list as you work:**
   - Mark tasks and subtasks as completed (`[x]`) per the protocol above.
   - Add new tasks as they emerge.

2. **Maintain the "Relevant Files" section:**
   - List every file created or modified.
   - Give each file a one‑line description of its purpose.

# AI Instructions

## When working with task lists, the AI must:

1. Regularly update the task list file after finishing any significant work.
2. Follow the completion protocol:
   - Mark each finished **sub‑task** `[x]`.
   - Mark the **parent task** `[x]` once **all** its subtasks are `[x]`.
3. Add newly discovered tasks.
4. Keep "Relevant Files" accurate and up to date.
5. Before starting work, check which sub‑task is next.
6. After implementing a sub‑task, update the file and then pause for user approval.

## 🏗️ ENGINEERING STANDARDS

**Code Quality Requirements:**
1. **No Hardcoded Values**
   - ❌ NEVER hardcode IPs, ports, timeouts
   - ✅ Use configuration files, environment variables, or constants

2. **Externalized Text**
   - ❌ NEVER hardcode user-facing messages in code
   - ✅ Use message catalogs or constants files
   - ✅ Support internationalization (i18n) ready structure

3. **Consistent Response Format**
   - ✅ Always use success/error response wrappers
   - ✅ Standardized error codes and messages
   - ✅ Consistent API response structure

4. **Comprehensive Testing**
   - ✅ Unit tests for ALL business logic (minimum 80% coverage)
   - ✅ Integration tests for API endpoints
   - ✅ Performance tests for critical paths
   - ✅ Security tests for authentication/authorization

5. **Production-Ready Code**
   - ✅ Proper error handling and recovery
   - ✅ Structured logging with correlation IDs
   - ✅ Metrics and monitoring hooks
   - ✅ Graceful degradation patterns
   - ✅ Circuit breakers for external services


**Implementation Checklist:**
- [ ] Remove ALL hardcoded values
- [ ] Create configuration classes/files
- [ ] Implement response wrappers
- [ ] Add comprehensive unit tests
- [ ] Add integration tests
- [ ] Externalize all messages
- [ ] Add proper logging
- [ ] Implement error handling
- [ ] Add performance metrics
