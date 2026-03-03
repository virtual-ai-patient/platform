# Integration Overview — Pilot on a Physician Platform

This document describes the intended integration points for embedding Virtual AI Patient into an existing physician platform during the pilot.

## 1. Integration objectives
- Seamless learner access from the partner platform (no separate account creation).
- Ability to launch a specific case or case set for a cohort.
- Consistent reporting of learner progress and outcomes back to the partner platform.

## 2. Authentication options (MVP)
### Option A — OAuth/OIDC SSO (preferred if available)
- Partner platform acts as Identity Provider (IdP) or uses a shared IdP.
- Backend validates ID token, maps user → internal user, creates session.

### Option B — Signed launch token (JWT)
- Partner platform generates a short-lived JWT containing:
  - `sub` (user id), `name` (optional), `role`
  - `cohort_id`
  - optional `case_id` or `case_set_id`
  - `exp` (short TTL)
- Backend verifies signature and creates a case session.

## 3. Embedding patterns
- **Deep-link launch**: partner platform opens the Flutter web/mobile view with a launch token.
- **In-app module**: partner app hosts the training module in a webview (if applicable).

## 4. Data exchanged (minimum)
### From partner → Virtual AI Patient
- user identity (stable id)
- cohort/course identifier
- case assignment (optional)

### From Virtual AI Patient → partner
- session summary:
  - case id + version
  - completion status
  - timestamps and duration
  - total score and sub-scores
  - key flagged errors (especially safety)

## 5. Reporting endpoints (conceptual)
The backend should expose:
- `GET /integrations/partner/cases` (assigned cases for a cohort)
- `POST /integrations/partner/launch` (create session from launch token)
- `GET /integrations/partner/sessions/{id}` (summary + scores)
- `GET /integrations/partner/cohorts/{id}/analytics` (aggregate metrics)

Exact naming/paths are to be aligned with the partner team during pilot implementation.

## 6. Privacy and compliance notes (pilot)
- Do not transmit or store real patient identifiers in cases.
- Only store learner identifiers necessary for pilot reporting.
- Ensure data retention and deletion policies are agreed with the partner.

