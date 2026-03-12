# Feature Addition: Email Notifications on Registration

## Prompt

> Add email notifications when a new user registers. Use the existing mailer service. Include a welcome template and admin alert.

## What Happens

Standard full pipeline — the feature touches multiple layers (service, templates, config) and requires design decisions.

### Pipeline: Research → Design → Implement

**Research phase** maps:
- `src/services/mailer.ts` — existing mailer with `sendTemplate()` API
- `src/services/auth.ts` — `registerUser()` is the registration entry point
- `src/templates/` — existing email templates use Handlebars
- `src/config/email.ts` — SMTP config, has `adminEmail` field
- No existing notification service — this is net-new

**Design phase** produces:
- Two new templates: `welcome-user.hbs`, `admin-new-registration.hbs`
- New `src/services/notifications.ts` wrapping the mailer for domain events
- Hook into `registerUser()` post-commit (not inline — keeps auth clean)
- Config additions: `notifications.enabled`, `notifications.adminAlerts`

**Implementation phase** executes:
- Creates the notification service and templates
- Adds the post-registration hook
- Writes tests for both email paths
- Updates config schema

## Why This Needed Design

Multiple files, a new service boundary, and config decisions. The researcher surfaces the landscape; the designer makes structural choices before any code is written.
