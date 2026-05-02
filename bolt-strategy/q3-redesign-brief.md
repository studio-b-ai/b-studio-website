---
name: Bolt Q3 Product Redesign Brief
description: Q3 2026 IA redesign workstream — seeded by Kevin's PM walkthrough on 2026-04-29. 5 collisions + 7 strategic IA questions surfaced on the live bolt-wms app. Pre-design work only — full redesign gated on UX practitioner output + 6-8 weeks of nav-event analytics.
type: project
originSessionId: a1b2c3d4-e5f6-7890-abcd-ef1234567890
---
# Bolt Q3 Product Redesign Brief

## Status
**DRAFT — Q3 redesign brief seed, captured 2026-04-29.** Source: master GTM + roadmap session for Bolt (canonical thread). Q3 work runs Aug–Oct 2026. Gated on:
- UX practitioner engagement (~$3–5K, ~1 week external audit) at Wks 4-6 post-fully-live
- 6-8 weeks of nav-event analytics from the live `imports_events` instrumentation + a shell-level event table
- Kevin's "fully-live" milestone itself (path A: mid-Aug/early-Sep 2026)

Companion files: `feedback_milestone-progress-bar.md`, `project_bolt-packaging.md`, master plan v1 in the GTM thread.

## Why this exists

During mid-July fully-live planning, Kevin put on a PM hat and walked the live `bolt-wms` web app. Five label/concept collisions and seven strategic IA questions emerged. **Some collisions are implementation drift from the already-locked master design (PR #365, merged 2026-04-29)** — those got chip prompts to resolve before fully-live. Net-new IA decisions and product-content-design work need real usage data and an external UX practitioner pass before locking. This file seeds that Q3 workstream.

Master design doc: `/Users/kevin/Library/CloudStorage/OneDrive-HeritageFabrics,LLC/.claude/worktrees/quirky-chaum-b6cd1f/docs/bolt-product-master-design.md` (PR #365).

## Kevin's PM walkthrough — 5 collisions (verbatim)

These were stated during the 2026-04-29 GTM session against the live app. Paraphrased faithfully; no verbatim transcript available.

| # | Collision | Where it surfaces |
|---|-----------|------------------|
| 1 | **Three "Dashboards"** — Imports Dashboard, Operations Dashboard, Warehouse Floor Dashboard all route to `/` equivalents generically and use "dashboard" in their H1/page titles. | `/imports`, `/operations`, `/` |
| 2 | **"In-Flight" / "In Flight" twice** — Purchase Orders uses "In-Flight POs" and Containers also has an "In Flight" state. Same phrase, different objects, no disambiguation. | `/imports` sidebar + container status taxonomy |
| 3 | **Vendor info in 3 places** — Vendors top-level nav (`/vendors`), Signals > Vendor Scorecard, and Imports > Email Review all surface vendor data with no clear ownership signal. | Nav rail + `/signals` + `/imports` |
| 4 | **Operations / Warehouse Floor / Warehouse — three near-synonymous parents.** The nav has all three as peer items with no clear hierarchy or distinction. | Nav rail |
| 5 | **Wave Config (Planning) vs Waves (Operations) + Cutoffs (Operations) vs Carrier Cutoffs (Settings).** Same noun, different parent. Waves appear in two rail sections; Cutoffs appear in two rail sections. | Nav rail |

## Kevin's 7 strategic IA questions (verbatim)

Stated as open questions during the walkthrough. No session resolution — these are the questions that make the UX practitioner engagement worth $3–5K.

1. **Q1 — Who lands here most?** Which persona opens bolt-wms first thing in their day, and is the current `/` home matching that persona?
2. **Q2 — Cross-pollination real or imagined?** Do imports managers actually navigate into Operations, or does the nav offer false promise of a shared workspace that isn't used?
3. **Q3 — Android vs web boundary.** Is the floor surface actually a separate product (Android WMS) or is it a section of the bolt-wms web app, and does the nav structure reflect that correctly?
4. **Q4 — Frequency map.** What are the 3-5 nav items each persona actually clicks daily vs weekly vs never?
5. **Q5 — Samples — sub-flow of what?** Sample requests live somewhere between Imports (inbound physical items) and CS (customer-originated requests). Which parent owns them?
6. **Q6 — Settings vs Admin same audience?** Are the people who touch Settings also the people who touch Admin, or is this a supervisor vs IT-admin split?
7. **Q7 — TV Displays placement.** Is "Cast to TV" a button inside Operations, or does TV Display configuration belong as its own admin sub-page?

## Claude's first-cut answers (2026-04-29 session)

These are session-derived estimates. Nav-event analytics will refine. Treat as hypotheses, not decisions.

| Q | First-cut answer |
|---|-----------------|
| Q1 | Imports manager (Melanie) likely. Master design §3 persona-default routing sends `imports_manager` → `/imports`. CS rep is close second (highest-frequency intraday). |
| Q2 | Cross-pollination probably imagined for now. Heritage has no supervisor who also runs imports. Persona routing (PR #374) already separates entry points — nav rail still over-offers. |
| Q3 | Android is a separate runtime (Android WMS app). "Warehouse Floor" in the web nav is the supervisor's view into floor activity, not the picker/packer interface. Master design §6 documents this; nav labels should reflect the distinction. |
| Q4 | Imports manager: In-Flight POs, Reorder Suggestions, Containers daily; Vendors weekly. CS rep: Order Entry, Active Orders daily. Supervisor: Operations Hub, Watchlist daily. Real answer requires analytics. |
| Q5 | Sub-flow of CS (customer-originated), with a hand-off into Imports for physical fulfillment. Master design §8 defers this question explicitly. |
| Q6 | Different audiences. Settings = supervisor-level (carrier cutoffs, wave config, notification prefs). Admin = IT/onboarding (API keys, LPN ranges, user management). Should split. |
| Q7 | "Cast to TV" button inside Operations is sufficient for now. TV Display admin sub-page warranted only if multi-display config or layout customization is requested by users. |

## Three IA proposals (Kevin's framing)

Kevin named these during the session as candidate directions. Not all three survive pushback (see below).

- **Proposal A — Persona-first apps.** Top-level nav items are the personas (CS Hub, Imports, Operations, Admin). Everything lives under one of these. Rail is persona-driven, not feature-driven.
- **Proposal B — Verb-first workflow.** Nav items are actions (Receive, Ship, Order, Review). Discards persona framing entirely.
- **Proposal C — Today-first home + Cmd-K.** Landing page is a unified "Today" pane surfacing each persona's top-3 items. Cmd-K (command palette) replaces deep nav for power users.

**Kevin's starting recommendation going into Q3:** A + C-style home (persona-first rail with a Today pane as the default landing content within each persona app).

## Claude's pushback table

| Push | Rationale |
|------|-----------|
| **Settings split (Admin tray + Ops Settings)** | Q6 answer above: different audiences, different security posture. Admin tray (gear icon, bottom of rail) for IT tasks; Settings section inside each persona app for day-to-day config (carrier cutoffs, wave defaults). Avoids one monolithic Settings rail item that IT admin and supervisor both have to scroll through. |
| **Operations Hub IS the supervisor persona app — don't separate it** | PR #292 already ships `/operations` as the supervisor entry point with its own role gate. Repackaging it as "Operations persona app" in Proposal A is a rename + nav-label exercise, not a rebuild. Don't ship two parallel structures. |
| **App switcher belongs top-of-page (breadcrumb/header), not top-of-rail** | If bolt-wms serves 3-4 personas and each has their own rail section, a persona switcher in the rail competes with the rail items. Header-level switcher (like Basecamp's "switch project") is cleaner; rail stays within the active persona's scope. |
| **Drop Proposal B entirely** | Verb-first nav destroys the persona routing investment (PR #374). Cmd-K (Proposal C) already gives power users a verb-first entry point without restructuring the nav. B adds cost, zero benefit. |

## Risk classification of the 5 collisions

### Consolidate before fully-live (chip prompts shipped 2026-04-29)
All five collisions, plus two adjacent items, were chipped as pre-fully-live fixes against the master design. Session created chips for:
- Collision 1 — Rename page H1s: "Imports" (not "Imports Dashboard"), "Operations" (not "Operations Dashboard"), floor supervisor view labeled distinctly
- Collision 2 — Disambiguate "In-Flight": PO list → "Open POs" or "In-Flight Orders"; containers keep "In Flight" as a status badge, not a section title
- Collision 3 — Vendor Scorecard consolidation: Signals > Vendor Scorecard becomes the canonical vendor view; `/vendors` top-level is a list/search entry; Imports Email Review vendor panel is a sidebar pull-through, not a separate surface
- Collision 4 — Nav rail consolidation: collapse Operations / Warehouse Floor / Warehouse into one "Operations" parent with sub-items
- Collision 5 — Rename disambiguation: Wave Config → "Wave Templates" (Planning); Carrier Cutoffs stays under Settings; Cutoffs (Operations) → "Today's Cutoffs" (daily countdown, not config)
- Cmd-K command palette — ships at fully-live
- Persona-default home content design — ships with persona routing (PR #374 skeleton, content design Q3)

### Defer to Q3 (gated on UX practitioner + analytics)
- Full IA refactor (Proposal A + C-style home landing) based on UX practitioner redesign spec
- Persona-content refinements for CS hub home, Imports today-pane, Operations today-pane after 4-6 weeks of real usage
- Samples placement decision (Q-R2 below)
- Agentic gradient for Email Review parser (Q-R3 below)

## Locked decisions (2026-04-29 session)

| Decision | Detail |
|----------|--------|
| **Path A fully-live timeline** | Mid-Aug/early-Sep 2026. No expedited path. |
| **VAR-deck-ready cascade** | Mid-Feb/early-Mar 2027 (flows from fully-live + Q3 redesign completion) |
| **All 5 collisions consolidate before fully-live** | Chip prompts created 2026-04-29; implementation in the current sprint |
| **Cmd-K palette ships at fully-live** | Command palette scoped to entity search (POs, Vendors, Items, Customers, Containers, Sessions). PRD for Cmd-K already in master design §7. |
| **Persona-default home content design ships with persona routing** | Routing skeleton exists (PR #374); content (Today-pane layout per persona) is a Q3 design + implementation task |
| **Email Review stays in imports queue (human-in-the-loop)** | Agentic gradient (auto-action on confidence threshold) deferred to Q3 — Q-R3 below |

## Open Q3 questions

| ID | Question | Gating signal |
|----|----------|---------------|
| **Q-R1** | **Final IA direction** — is Proposal A + C-style home locked, or does the UX practitioner surface a better structure? | 6-8 weeks nav-event analytics + practitioner audit |
| **Q-R2** | **Samples placement** — sub-flow of Imports, sub-flow of CS, or fifth standalone persona app? Master design §8 explicitly defers. | Design session after Samples pilot (no timeline yet) |
| **Q-R3** | **Email Review agentic gradient** — auto-action confidence threshold, audit trail, rollback semantics. Pattern-mirror: Note Intelligence 85% threshold. | 8+ weeks of triage-correction data from imports team |
| **Q-R4** | **Persona-content refinements** — once CS hub home + Imports today-pane + Operations today-pane have 4-6 weeks of real usage, refine based on actual click patterns. | 4-6 weeks post-flag-flip |
| **Q-R5** | **TV Displays placement** — is "Cast to TV" button inside Operations sufficient, or does multi-display config warrant an admin sub-page? | User request signal post-fully-live |

## Q3 workstream sequence

| Window | Work |
|--------|------|
| Wks 0–8 (post fully-live) | Collect nav-event analytics in production. No IA changes — let usage stabilize. |
| Wks 4–6 | Engage external UX practitioner (~$3–5K, ~1 week audit). Input: this file + master design + analytics export. Output: redesign spec. |
| Wks 6–10 | Implementation chips for redesign. Specific scope determined by UX practitioner output, not pre-decided here. |
| Wks 10–12 | Ship + iterate. Post-ship: re-measure nav-event analytics vs pre-redesign baseline. |

## Master plan tie-in

This file connects to the GTM + roadmap master plan (canonical thread, 2026-04-29):
- **§ 6 Q3 line** — "IA redesign gated on UX practitioner + analytics" is the one-liner
- **§ 9 open questions** — Q-R1 through Q-R5 above map to the open-questions table in the master plan
- **§ 10 change-log** — entry dated 2026-04-29: "PM walkthrough surfaced 5 collisions + 7 IA questions; consolidation chips shipped; Q3 brief filed"

## Reading list (when Q3 session opens)

Read in this order:

1. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/project_bolt-product-redesign.md` (this file)
2. `bolt-wms/docs/bolt-product-master-design.md` (PR #365, merged 2026-04-29 — the locked design this brief extends)
3. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/project_imports-dashboard.md`
4. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/project_operations-hub.md`
5. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/project_phase3-container-mission-control.md`
6. All chip prompts shipped 2026-04-29 (the collision-consolidation chips — search session history for "collision" + "chip" on 2026-04-29)
7. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/feedback_milestone-progress-bar.md`
8. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/feedback_continuation-prompt-format.md`
9. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/feedback_quality-over-speed.md`
10. `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/feedback_recommend-best-architecture.md`
