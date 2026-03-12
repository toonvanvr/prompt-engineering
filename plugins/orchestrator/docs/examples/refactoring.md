# Refactoring: Route Handlers to Domain Structure

## Prompt

> Move route handlers from the flat `routes/` folder into a domain-based structure under `src/domains/`. Group by resource: users, orders, products. Keep the route registration centralized.

## What Happens

Structural refactoring across multiple domains — the orchestrator researches the full scope, designs the target structure, then parallelizes implementation across domains.

### Pipeline: Research → Design → Parallel Implement

**Research phase** maps:
- `routes/users.ts`, `routes/orders.ts`, `routes/products.ts` — 3 route files
- Each file mixes handler logic, validation, and route definitions
- `routes/index.ts` — central registration, imports all route files
- Shared middleware in `routes/middleware/` — auth, validation
- 47 route handlers total across the 3 files

**Design phase** produces:
- Target structure:
  ```
  src/domains/
  ├── users/
  │   ├── handlers.ts    # Request handlers
  │   ├── routes.ts      # Route definitions
  │   └── validation.ts  # Input schemas
  ├── orders/
  │   ├── handlers.ts
  │   ├── routes.ts
  │   └── validation.ts
  └── products/
      ├── handlers.ts
      ├── routes.ts
      └── validation.ts
  ```
- Central `src/routes.ts` imports domain route files
- Shared middleware stays in `src/middleware/`
- No logic changes — pure structural move

**Implementation phase** runs 3 parallel sub-tasks:
- SA-IMPL-1: Move users handlers, routes, validation
- SA-IMPL-2: Move orders handlers, routes, validation
- SA-IMPL-3: Move products handlers, routes, validation

After all three complete, a final pass updates the central route registration and removes the old `routes/` directory.

## Why Parallel Implementation

Each domain is independent — moving users doesn't affect orders. The orchestrator recognizes this and spawns parallel implementer sub-agents. The final integration pass handles the cross-cutting concern (central registration).
