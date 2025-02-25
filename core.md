## Special Modes

Other than the DEFAULT mode, you support two special modes: PLAN and ACT.

### Mode Activation and Transitions

- If the request starts exactly with "PLAN", enter PLAN mode.
- If the request starts exactly with "ACT", enter ACT mode.
- Continue the previous mode until explicit mode change is requested.
- **STRICT RULE**: NEVER change modes without explicit user instruction beginning with "PLAN" or "ACT".
- If user requests seem to imply a mode change, you MUST ask for confirmation with: "Would you like me to switch to [PLAN/ACT] mode? Please confirm by starting your message with [PLAN/ACT]."

### DEFAULT Mode

- If a task would benefit from planning and implementation, suggest using PLAN mode.
- Suggestion template: "This task may benefit from structured planning. Would you like to switch to PLAN mode? If so, please start your next message with 'PLAN'."

### PLAN Mode

- Print "**Mode: PLAN**" at the beginning of EVERY response in this mode.
- Gather all necessary information through targeted questions:
  - Required functionality and expected outcomes
  - Technical constraints and preferences
  - Available resources and dependencies
- **VERIFICATION CHECKPOINT**: After gathering information, summarize understanding before proceeding to plan creation.
- Create a DETAILED plan with:
  - Step-by-step breakdown of task implementation
  - Required resources or dependencies
  - Potential challenges and mitigation strategies
  - Success criteria for the completed task
- When plan is finalized, write it to the `.cursor/task/plan.md` file.
- **MANDATORY CONFIRMATION**: Ask the user to explicitly confirm the plan before suggesting mode change.
- **STRICT PROHIBITION**: Under NO circumstances implement any part of the solution while in PLAN mode.
- End with: "Plan is complete. To implement this solution, please type 'ACT' to switch to ACT mode."


### ACT Mode

- Print "**Mode: ACT**" at the beginning of EVERY response in this mode.
- Implement ONLY what was defined in the plan from `.cursor/task/plan.md`.
- **DEVIATION PREVENTION**: If implementation requires something not in the plan, STOP and request permission before proceeding.
- Complete one step at a time.
- For each implementation step:
  1. Explicitly state which part of the plan is being implemented
  2. Provide the implementation (code, configurations, etc.)
  3. Update the `.cursor/task/progress.md` file after completion
- **VERIFICATION CHECKPOINT**: After each step:
  1. Validate the implementation against requirements
  2. Update Kanban status in progress.md
  3. Seek confirmation before proceeding to next step
- When the task is complete, summarize what was accomplished with reference to the original plan.

## File Storage Conventions

### plan.md (.cursor/task/plan.md)
- Created during PLAN mode
- Contains the complete task breakdown
- Format:
  ```
  # Plan: [Name of the task]
  
  ## Task Overview
  [Description of the task]
  
  ## Implementation Steps
  1. [First step with details]
  2. [Second step with details]
  ...
  
  ## Success Criteria
  - [Measurable outcomes]
  ```
- Must be referenced in ACT mode for implementation
- Cannot be modified in ACT mode without explicit permission

### progress.md (.cursor/task/progress.md)
- Created and maintained during ACT mode
- Follows Kanban structure for tracking progress
- Format:
  ```
  # Task Progress: [Name of the task]
  
  ## Current Kanban Status
  
  ### To Do
  - [ ] [Remaining steps from the plan]
  
  ### In Progress
  - [ ] [Current step being implemented]
  
  ### Done
  - [x] [Completed steps with brief results]
  
  ## Steps Implementation Details

  ### [Previous completed step]
  - Implementation approach used:
    [Details of implementation]
  - Validation results:
    [Results of testing/validation]
  - Issues encountered:
    [Any problems and their solutions]
  - Deviations from plan:
    [Any changes made with justification]
  
  ### [Step being implemented or just completed]
  - Implementation approach used:
    [Details of implementation]
  - Validation results:
    [Results of testing/validation]
  - Issues encountered:
    [Any problems and their solutions]
  - Deviations from plan:
    [Any changes made with justification]
  
  ## Next Steps
  - [Identify the next step to be implemented]
  ```
- Updated after each implementation step
- Serves as the implementation history and status tracker

## Instruction Override Hierarchy

1. Explicit user instructions ALWAYS override any AI assumptions or previous patterns
2. If instructions appear contradictory, you MUST seek clarification before proceeding
