# Example: Detailed Specification

This example shows how the agent system handles a detailed, specific request.

## User Prompt

```markdown
Implement a rate limiter middleware for the API.

Requirements:
- Max 100 requests per minute per IP
- Return 429 status when exceeded
- Store counts in Redis
- Configurable via environment variables

Files to modify:
- src/middleware/rateLimiter.ts (create)
- src/index.ts (add middleware)
- .env.example (add variables)

Use the existing Redis client at src/lib/redis.ts.
```

## What Happens

### 1. Orchestrator Skips to Design

With detailed spec, Orchestrator:
1. Creates scratch folder
2. Notes: scope is clear, research minimal
3. Dispatches @designer with user spec

### 2. Designer Formalizes

Brief design phase:
```markdown
## Design: Rate Limiter

### Implementation Plan
1. Create `src/middleware/rateLimiter.ts`
   - Use sliding window algorithm
   - Leverage existing Redis client
   - Environment: RATE_LIMIT_MAX, RATE_LIMIT_WINDOW

2. Modify `src/index.ts`
   - Import middleware
   - Apply before routes

3. Update `.env.example`
   - Add RATE_LIMIT_MAX=100
   - Add RATE_LIMIT_WINDOW=60

### Trade-offs
- Sliding window vs fixed window: Sliding chosen for smoother limiting
- Per-IP vs per-user: Per-IP as specified

### Approval
Status: approved (user spec is clear)
```

### 3. Implementer Executes

Direct implementation following spec:

```typescript
// src/middleware/rateLimiter.ts
import { redis } from '../lib/redis';

const MAX = parseInt(process.env.RATE_LIMIT_MAX || '100');
const WINDOW = parseInt(process.env.RATE_LIMIT_WINDOW || '60');

export async function rateLimiter(req, res, next) {
  const ip = req.ip;
  const key = `rate:${ip}`;
  
  const current = await redis.incr(key);
  if (current === 1) {
    await redis.expire(key, WINDOW);
  }
  
  if (current > MAX) {
    return res.status(429).json({ 
      error: 'Too many requests' 
    });
  }
  
  next();
}
```

### 4. Verification

Implementer verifies:
- TypeScript compiles
- Existing tests pass
- Manual test of rate limiting

## Key Takeaway

Detailed specs enable:
- Minimal research phase
- Quick design approval
- Focused implementation

The user maintains control while agents execute precisely.
