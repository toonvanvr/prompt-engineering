# Stream-of-consciousness: Examples

Long, exploratory prompts where you dump everything you're thinking.

## Example 1: Refactor with reasoning

```text
I want you to refactor the reasoning behind how things are set up too:
You create services now as definitions in systemd, but i think we need a layer above: NextCloud, where we define it uses a system image, but also where we define it's open to the firewall in a certain way to friends in the mesh vs admin-only vs only local vs iot vlan vs ....

This approach in layering needs to be present everywhere, where you start from the way a human explains it to others, i guess? Not infrastructure tech stuff, but what why how etc

Keep a brainstorming session and persona simulations about this. Also, wth is the gitops and networking folder still doing outside the src folder? can this be cleaned up? also secrets services and maybe more. I don't know where to start. Convert the mess to a pearl, thank you.
```

**What happens:** The orchestrator identifies multiple threads: (1) architectural layering concept, (2) folder cleanup, (3) brainstorming request. It starts with a researcher to understand the full scope, then a designer for the layering architecture, then parallel implementers for the cleanup. The informal tone ("wth", "Convert the mess to a pearl") is treated as emphasis on the user's frustration with current state — the orchestrator responds with thorough investigation rather than surface-level fixes.

## Example 2: Full repo overhaul

```text
Optimize/refactor/improve/extend/.. after this using subagents.

First go through each folder and make an analysis file of all the files in that folder:
- what/why/.. and reference to it in specs
- refactor the specs from scratch so that it has the old info and update/merged with new info
- then improve the specs, subjectively estimating what the intent is / could also have meant
- index all things that are versionable: plugins/packages/pipelines/..
- then upgrade the repo
- all files should be updated to represent the changes too
- then go through the generated files and find discrepancies
- then again, improve specs etc
- then fix _every_ thing you found, improve, but be intelligent about it: maintainable, secure, performant, optimized results
- then do a second round of all this above using just as many subagents
```

**What happens:** This is a mega-prompt. The orchestrator first dispatches a researcher to create a Work Breakdown Structure (WBS) — decomposing the bullet list into concrete phases. Then it processes the WBS in waves: analysis wave (folder-by-folder), spec refactoring wave, implementation wave, verification wave, and a second pass. Each wave gets parallel sub-agents where concerns are independent. The "using subagents" directive is redundant (the orchestrator always uses them) but confirms the user expects parallelism.
