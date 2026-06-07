---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
---
# TypeScript / JavaScript Rules

> Path-scoped. Extends [coding-style.md](./coding-style.md) and
> [security.md](./security.md) with TypeScript/JavaScript specifics.
> Adapted from ECC (affaan-m/ECC) `rules/typescript/*`.

## Types and Interfaces

- Add explicit parameter and return types to **exported** functions, shared
  utilities, and public class methods. Let TypeScript infer obvious locals.
- Use `interface` for object shapes that may be extended/implemented; use `type`
  for unions, intersections, tuples, mapped and utility types.
- Prefer string-literal unions over `enum` unless an `enum` is required for
  interop.

```typescript
interface User {
  id: string
  email: string
}

type UserRole = 'admin' | 'member'
type UserWithRole = User & { role: UserRole }
```

## Avoid `any`

- Avoid `any` in application code.
- Use `unknown` for external/untrusted input, then narrow safely.
- Use generics when a value's type depends on the caller.

```typescript
// WRONG: any removes type safety
function getErrorMessage(error: any) {
  return error.message
}

// CORRECT: unknown forces safe narrowing
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) return error.message
  return 'Unexpected error'
}
```

## Immutability

Use the spread operator for immutable updates; never mutate inputs.

```typescript
function updateUser(user: Readonly<User>, email: string): User {
  return { ...user, email }
}
```

## Error Handling

- Use `async`/`await` with `try/catch` and narrow `unknown` errors safely.
- Always `throw new Error(...)`, never `throw "string"`.
- Wrap `JSON.parse` in `try/catch`.
- Never leave empty `catch` blocks.

## Input Validation

Validate external data at boundaries with a schema validator (e.g. Zod) and
infer types from the schema:

```typescript
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

type UserInput = z.infer<typeof userSchema>
const validated: UserInput = userSchema.parse(input)
```

## Async Correctness

- No floating promises — `await` or `.catch()` every async call.
- Use `Promise.all` for independent work instead of sequential `await` in loops.
- `array.forEach(async fn)` does not await — use `for...of` or `Promise.all`.

## Secrets

```typescript
// NEVER hardcode
const apiKey = 'sk-proj-xxxxx'

// ALWAYS read from the environment and validate at startup
const apiKey = process.env.API_KEY
if (!apiKey) throw new Error('API_KEY not configured')
```

## Other

- No `console.log` in production code — use a structured logger.
- Use `===`/`!==`, never `==`/`!=`.
- Do not use `React.FC`; type props with a named `interface`/`type`.
- For E2E, prefer Playwright for critical user flows.
