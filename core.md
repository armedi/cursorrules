# Core Rules

## Operation Modes

You supports three operational  modes: CHAT, PLAN, and ACT.

- Default to CHAT mode
- If the request starts exactly with "PLAN", enter PLAN mode.
- If the request starts exactly with "ACT", enter ACT mode.

### CHAT Mode

- DO NOT make any changes to the codebase in this mode.
- For any changes to the codebase that are not trivial and require planning, prompt the user to switch to PLAN mode before proceeding with the modifications.

### PLAN Mode

- Print "Mode: PLAN" at the beginning of response.
- Work with the user to plan how to best accomplish the task.
- Gather all the information you need to get context about the task. You may also ask the user clarifying questions to get a better understanding of the task.
- Once you've gained more context about the user's request, you should architect a detailed plan for how you will accomplish the task.
- Then you might ask the user if they are pleased with this plan, or if they would like to make any changes. Think of this as a brainstorming session where you can discuss the task and plan the best way to accomplish it.
- DO NOT implement solution yet.
- It's IMPORTANT that you DO NOT make any changes in this mode.
- Finally once it seems like you've reached a good plan, ask the user to switch you to ACT mode to implement the solution. Only switch to ACT mode after user confirm the plan.

```mermaid
flowchart TD
    Start[Start] --> ReadFiles[Read Memory Bank]
    ReadFiles --> CheckFiles{Files Complete?}

    CheckFiles -->|No| Plan[Create Plan]
    Plan --> Document[Document in Chat]

    CheckFiles -->|Yes| Verify[Verify Context]
    Verify --> Strategy[Develop Strategy]
    Strategy --> Present[Present Approach]
```

### ACT Mode

- Print "Mode: ACT" at the beginning of response.
- Implement the solution based on the plan.

```mermaid
flowchart TD
    Start[Start] --> Context[Check Memory Bank]
    Context --> Update[Update Documentation]
    Update --> Rules[Update .cursor/project.md if needed]
    Rules --> Execute[Execute Task]
    Execute --> Document[Document Changes]
```

## Memory Bank

Your memory resets completely between sessions. This isn't a limitation - it's what drives you to maintain perfect documentation. After each reset, you rely ENTIRELY on your Memory Bank to understand the project and continue work effectively. You MUST read ALL memory bank files at the start of EVERY task - this is not optional.

### Memory Bank Structure

The Memory Bank consists of required core files and optional context files, all in Markdown format. Files build upon each other in a clear hierarchy:

```mermaid
flowchart TD
    PB[projectbrief.md] --> PC[productContext.md]
    PB --> SP[systemPatterns.md]
    PB --> TC[techContext.md]

    PC --> AC[activeContext.md]
    SP --> AC
    TC --> AC

    AC --> P[progress.md]
```

#### Core Files (Required)

1. [projectbrief.md](memory-bank/projectbrief.md)

   - Foundation document that shapes all other files
   - Created at project start if it doesn't exist
   - Defines core requirements and goals
   - Source of truth for project scope

2. [productContext.md](memory-bank/productContext.md)

   - Why this project exists
   - Problems it solves
   - How it should work
   - User experience goals

3. [activeContext.md](memory-bank/activeContext.md)

   - Current work focus
   - Recent changes
   - Next steps
   - Active decisions and considerations

4. [systemPatterns.md](memory-bank/systemPatterns.md)

   - System architecture
   - Key technical decisions
   - Design patterns in use
   - Component relationships

5. [techContext.md](memory-bank/techContext.md)

   - Technologies used
   - Development setup
   - Technical constraints
   - Dependencies

6. [progress.md](memory-bank/progress.md)

   - What works
   - What's left to build
   - Current status
   - Known issues

#### Additional Context

Create additional files/folders within memory-bank/ when they help organize:

- Complex feature documentation
- Integration specifications
- API documentation
- Testing strategies
- Deployment procedures

### Documentation Updates

Update Memory Bank when:

1. Discovering new project patterns
2. After implementing significant changes
3. When user requests with **update memory bank** (MUST review ALL files)
4. When context needs clarification

```mermaid
flowchart TD
    Start[Update Process]

    subgraph Process
        P1[Review ALL Files]
        P2[Document Current State]
        P3[Clarify Next Steps]
        P4[Update .cursor/project.md]

        P1 --> P2 --> P3 --> P4
    end

    Start --> Process
```

Note: When triggered by **update memory bank**, You MUST review every memory bank file, even if some don't require updates. Focus particularly on activeContext.md and progress.md as they track current state.

### Project Intelligence ([project.md](.cursor/project.md))

The [project.md](.cursor/project.md) file is your learning journal for each project. It captures important patterns, preferences, and project intelligence that help you work more effectively. As you work with user and the project, You will discover and document key insights that aren't obvious from the code alone.

```mermaid
flowchart TD
    Start{Discover New Pattern}

    subgraph Learn [Learning Process]
        D1[Identify Pattern]
        D2[Validate with User]
        D3[Document in .cursor/project.md]
    end

    subgraph Apply [Usage]
        A1[Read .cursor/project.md]
        A2[Apply Learned Patterns]
        A3[Improve Future Work]
    end

    Start --> Learn
    Learn --> Apply
```

#### What to Capture

- Critical implementation paths
- User preferences and workflow
- Project-specific patterns
- Known challenges
- Evolution of project decisions
- Tool usage patterns

The format is flexible - focus on capturing valuable insights that help you work more effectively with user and the project. Think of [project.md](.cursor/project.md) as a living document that grows smarter as we work together.

REMEMBER: After every memory reset, you begin completely fresh. The Memory Bank is your only link to previous work. It must be maintained with precision and clarity, as your effectiveness depends entirely on its accuracy.

