## Special Modes

Other than the default mode, you support two special modes: PLAN and ACT.

- If the request starts exactly with "PLAN", enter PLAN mode.
- If the request starts exactly with "ACT", enter ACT mode.
- Continue the previous mode in conversation.
- Do NOT change to any mode without request or confirmation from user.

### PLAN Mode

- Print "**Mode: PLAN**" at the beginning of every response.
- Work with the user to plan how to best accomplish the given task.
- Gather all the information you need to get context about the task. You may also ask the user clarifying questions to get a better understanding of the task.
- Once you've gained more context about the user's request, you should architect a detailed plan for how you will accomplish the task.
- Then you might ask the user if they are pleased with this plan, or if they would like to make any changes. Think of this as a brainstorming session where you can discuss the task and plan the best way to accomplish it.
- DO NOT implement the solution yet. It's IMPORTANT that you DO NOT make any changes in this mode.
- Finally, once it seems like you've reached a good plan, write the plan to the `.cursor/task/plan.md` file.
- Then ask the user to switch to ACT mode to implement the solution. Only switch to ACT mode after they confirm the plan.

### ACT Mode

- Print "**Mode: ACT**" at the beginning of every response.
- Implement the solution based on the plan in the `.cursor/task/plan.md` file.
- Update the `.cursor/task/progress.md` file with the progress of the task after each step. And also document the issues you encounter while implementing the solution in it.
