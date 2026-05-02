---
name: Bolt Master Plan v1
description: Locked-state snapshot of Bolt's GTM strategy, pricing, ICP, milestones, and roadmap as of 2026-04-29. Survives session compaction. The canonical GTM thread remains the active working surface; this file is the read-only v1 snapshot.
type: project
originSessionId: bolt-gtm-master-session-2026-04-29
---
# Bolt Master Plan v1

## Status

**LOCKED 2026-04-29.** Source: master GTM + roadmap session (canonical thread). This file is a read-only snapshot — strategy state at v1. The GTM thread is the active weekly ratchet. Amend this file only on a quarterly lock or explicit strategy pivot. Companion: `project_bolt-product-redesign.md` (Q3 redesign brief).

## Why this file exists

Session context compacts. The GTM thread holds nuance that doesn't survive a context reset. This file persists the locked strategy so any new session can orient in <5 min without re-deriving pricing logic, milestone targets, or sales-motion decisions from scratch.

---

## § 1 — Positioning (locked)

**"Continuous Goods WMS for Acumatica continuous-goods distributors."**

One product. Two surfaces: web desk (bolt-wms) + Android floor (bolt-android). Reference customer: Ästhetik / Heritage Fabrics on `wms.asthetik.com`. Not "Intel Inside." Distributors buy Bolt as a WMS — it has its own brand posture (Fusion/Fishbowl/Infor model).

## § 2 — Pricing (locked 2026-04-29, supersedes project_bolt-packaging.md)

| Tier | $/mo (per Acumatica instance) | Annual prepay (10% off) | Setup (one-time) |
|---|---|---|---|
| Core | $1,200 | $12,960/yr | $5,000 |
| Pro | $1,750 | $18,900/yr | $10,000 |
| Enterprise | $2,500 | $27,000/yr | $15,000 |
| VAR white-label add-on | $500–1,000/mo | — | $2,000–5,000 |

Pricing unit: per Acumatica instance, per month (all tenants + branches on that instance included — one subscription covers Heritage + Roth + WVH). Pickup included in Pro and Enterprise — no separate SKU.

VAR economics: wholesale at 75% of list; VAR earns 25% margin on every Bolt sale. VAR white-label add-on stays 100% to Studio B. Data migration is a paid SKU ($5K/$10K/$15K by tier).

**Stale data:** `project_bolt-packaging.md` line 21 (Core $800 / Pro $1,200 / Enterprise $1,800) is superseded by the table above. `reference_studio-b-lineup.md`, `bolt.b.studio/pricing.html`, and `WMS_GTM.md` TAM math also carry old numbers — hold public page update until fully-live; update internal refs at next rigby.

## § 3 — ICP (locked)

$10–100M revenue Acumatica continuous-goods distributors. Vertical entry sequence: Carpet → Wire & Cable → Hose → Paper/Vinyl. TAM revised upward from prior $24–45M figure in `WMS_GTM.md` (that math was based on the old $800–1,500/mo range).

## § 4 — Sales motion (locked)

Hybrid forever. Direct stays open for Studio B holdco brands + exceptional inbound. VAR channel is the primary new-customer path after VAR-deck-ready (mid-Feb to early-Mar 2027). No exclusivity: direct and VAR coexist indefinitely.

---

## Milestone bar

```
M1 ─── M2 ─── M3 ───── M4 ──── M5 ──── M6
FOUND  IMPORT  OPSATP  LIVE    PROVE   VAR
                        ◀─── THE EDGE ───▶
████████ ████████ ████████ ▓▓▓▓ ░░░░░ ░░░░░
SHIPPED  SHIPPED  SHIPPED  NEXT
```

Bolt is the Continuous Goods WMS for Acumatica continuous-goods distributors. Reference customer: Ästhetik / Heritage Fabrics. Master plan locked 2026-04-29; the GTM thread is the canonical weekly ratchet. THE EDGE spans M4–M5: Studio B's holdco runs on Bolt daily (M4) and continuously through a 6-month proof window (M5) — that operational credibility is the moat for VAR sales.

| # | Milestone | Target | Status | What it is |
|---|---|---|---|---|
| M1 | **Foundation** | Q1 2026 | ✅ DONE | Sync, RBAC matrix, container tracking, LTL, repo rename heritage-wms → bolt-wms |
| M2 | **Imports** | Q1–Q2 2026 | ✅ DONE | Imports Hub Phase 2 (PR-I1 → I7 merged); DAC endpoint parity — 4 SOOrderExt fields live 2026-04-28 |
| M3 | **Ops + ATP + CMC** | Q2 2026 | ✅ DONE | Operations Hub LIVE 2026-04-21; Time-Phased ATP LIVE 2026-04-21, write-back live 2026-04-29; Phase 3 CMC all 5 PR-C* merged 2026-04-26 |
| M4 | **Heritage Live** | Mid-Aug to early-Sep 2026 | 🔜 NEXT | 10-item "fully live" gate — see § 5 |
| M5 | Prove + Scale | Q3–Q4 2026 | pending | 6-month operational proof; Ästhetik multi-branch (Roth real, WVH, Ferncrest); per-branch Acumatica gateway |
| M6 | VAR | Mid-Feb to early-Mar 2027 | pending | VAR pitch deck + ROI calculator + onboarding playbook + first VAR-referred tenant |

---

## § 5 — M4 "Fully Live" gate (mid-Aug to early-Sep 2026)

Items 1–6 are functional requirements. Items 9–10 are quality requirements. All 10 must pass before the fully-live stamp. The cascade: fully-live mid-Aug/Sep → VAR-deck-ready mid-Feb/Mar 2027 → first VAR tenant late Q1/early Q2 2027.

| # | Gate item |
|---|---|
| 1 | `IMPORTS_DASHBOARD_ENABLED=true` flipped on Railway prod; Sarah + Melanie using imports view daily |
| 2 | Operations Hub flag live (already 2026-04-21); Sarah daily in `/operations` |
| 3 | Phase 3 CMC flag flipped; Melanie daily in container mission control |
| 4 | Time-Phased ATP write-back validated against real CS-quoted ship dates (flags live 2026-04-29) |
| 5 | CS team on cert-free browser-native 3-layer notification stack on every inbound call: **Primary** — in-page DOM overlay in heritage-wms tab (Chrome foregrounded); **Secondary** — Web Notifications API OS-level toast (Chrome minimized or tab in background); **Tertiary** — Service Worker + Push API (Chrome fully closed). **Persistent context** — HubSpot CRM card (unchanged). **Backup channel** — Slack DM (unchanged). Note: Bolt Pickup desktop tray DEFERRED to Q3 per 2026-05-02 decision — browser-native stack covers Chrome-minimized + Chrome-closed scenarios, making tray redundant for HF reps. No Apple Dev ID cert or Windows OV cert work in scope for fully-live. |
| 6 | Floor surface (Android) — receive + putaway + pick + pack used daily by warehouse team |
| 9 | Thorough product review: UI/UX consistency across web + Android + HubSpot card + Pickup tray. Design-review skill pass + external UX practitioner engagement (~$3–5K, ~1 week audit at Wks 4–6 post-flag-flip) |
| 10 | E2E test harness — 5 critical-path scenarios (E1–E5) pass on every PR, blocking merge; web + Android + Acumatica round-trip data integrity verified |

Five IA consolidations, Cmd-K command palette, and persona-default home content are also required before fully-live (chips dispatched 2026-04-29). Target shifted mid-Jul → mid-Aug/Sep because of quality bar expansion (items 9, 10) and floor surface work.

---

## § 6 — Change log (chronological)

| Date | Change |
|---|---|
| 2026-04-29 AM | Pricing locked: $800/$1,200/$1,800 → $1,200/$1,750/$2,500 (option A, compression analysis). ICP $10–100M confirmed. Setup fees tiered $5K/$10K/$15K. VAR wholesale 25% margin. Positioning "for Acumatica continuous-goods distributors" locked. VAR-deck-ready shifted Dec 2026 → mid-Feb/Mar 2027. |
| 2026-04-29 midday | Bolt for Zoom CS sidebar deprecated (project_bolt-cs-sidebar.md). Pickup pulled into M4 fully-live gate — no longer Q3 deferred. |
| 2026-04-29 afternoon | Q-S3 quality bar expanded: UI/UX review + E2E harness added (items 9, 10). Fully-live target shifts mid-Jul → mid-Aug/Sep. IA consolidation + Cmd-K palette + persona-default home content added to fully-live gate. |
| 2026-04-29 evening | 15 chip prompts persisted to `memory/`; floor surface audit returned 🟡 LIKELY-ON-TRACK-WITH-EFFORT (3 floor chips queued). Q3 redesign brief seeded at `project_bolt-product-redesign.md`. Master design doc merged as bolt-wms PR #365. |
| 2026-05-02 | Bolt Pickup desktop tray DEFERRED from fully-live (Q-S3 item 5) to Q3. Reason: in-tab call popup chip extended with Web Notifications API + Service Worker Push layers, covering Chrome-minimized + Chrome-closed scenarios at the browser level. Cert-free fully-live path locked (no Apple Dev ID, no Windows OV). Pickup chip remains on disk at `memory/prompt_bolt-pickup-mvp-impl.md` with DEFERRED header for Q3 reactivation if HF pilot shows >5% browser-notification miss-rate. Calendar impact: ~5–6 wks engineering reclaimed; cert lead times no longer in critical path. Cost saved: ~$400–500/yr in cert fees. Q-S3 item 5 rewritten to 3-layer browser-native stack (Primary: in-page DOM overlay; Secondary: Web Notifications API; Tertiary: Service Worker + Push API). |

---

## § 7 — Artifacts on disk

**Master design doc:** `studio-b-ai/bolt-wms` `docs/bolt-product-master-design.md` (PR #365, merged 2026-04-29, origin/main). Canonical product spec.

**Per-workstream plan docs** (under `bolt-wms/docs/plans/`):
- `2026-04-19-imports-dashboard-design.md`
- `2026-04-20-operations-hub-dashboard-design.md` + `-implementation-plan.md`
- `2026-04-20-phase-3-container-mission-control-design.md`
- `2026-04-20-order-hub-design.md` + `-surface-parity.md`
- `2026-04-20-time-phased-atp-scoping.md` + `-plan.md`
- `2026-04-26-atp-phase5-continuation.md`
- `2026-04-26-imports-dashboard-readiness.md`
- `2026-04-29-bolt-floor-surface-design.md`

**Per-workstream memory files** (all in `/Users/kevin/.claude/projects/-Users-kevin-Library-CloudStorage-OneDrive-HeritageFabrics-LLC/memory/`):
- `project_imports-dashboard.md` — Imports Hub Phase 2 + DAC parity
- `project_operations-hub.md` — Operations Hub
- `project_phase3-container-mission-control.md` — CMC
- `project_time-phased-atp.md` — ATP Phase 4 + Phase 5
- `project_bolt-packaging.md` — packaging history (pricing superseded by § 2 above)
- `project_bolt-pickup.md` — Pickup tray app design
- `project_bolt-cs-sidebar.md` — DEPRECATED 2026-04-29
- `project_bolt-rbac-scoping.md` — RBAC scoping (Phase 1 shipped)
- `project_bolt-product-redesign.md` — Q3 redesign brief (companion)
- `project_dac-endpoint-parity.md` — SOOrderExt 4-field endpoint path
- `project_bolt-master-plan-v1.md` — THIS FILE

**Chip prompts dispatched 2026-04-29** (executable units, all in `memory/`):
- `prompt_in-tab-call-popup-impl.md` (CS in-tab toast)
- `prompt_brand-token-multitenant-impl.md`
- `prompt_persona-default-home-routing-impl.md`
- `prompt_operations-warehouse-consolidation-impl.md`
- `prompt_cmd-k-palette-impl.md`
- `prompt_settings-split-impl.md`
- `prompt_vendor-consolidation-impl.md`
- `prompt_in-flight-relabel-impl.md`
- `prompt_bolt-pickup-mvp-impl.md`
- `prompt_bolt-e2e-harness-impl.md`
- `prompt_pickup-telemetry-endpoint-impl.md`
- `prompt_wms-role-enum-verify-impl.md`
- `prompt_bolt-zoom-deprecation-cleanup-impl.md`
- `prompt_msal-redis-state-impl.md`

**Floor surface chips queued** (per 2026-04-29 audit, 🟡 LIKELY-ON-TRACK-WITH-EFFORT):
- `prompt_bolt-floor-offline-resilience-impl.md` (highest priority)
- `prompt_bolt-e2e-floor-receive-impl.md`
- `prompt_bolt-mobile-signing-and-distribution-impl.md`

---

## § 8 — Cadence going forward

| Frequency | Kevin brings | Claude does |
|---|---|---|
| Weekly | Status update — what shipped, slipped, blockers | Update rolling milestone table + flag risks against mid-Aug gate |
| Quarterly | Strategic question / pivot | Run /recall + verify live state + propose update; lock + amend this file |
| Ad-hoc | Strategy question | /recall + dial-in on specific § above |

---

## § 9 — Stale data flags (for next rigby sweep)

- `project_bolt-packaging.md` line 21 — old pricing $800/$1,200/$1,800
- `reference_studio-b-lineup.md` — old pricing
- `WMS_GTM.md` TAM math (TAM calc used $800–1,500/mo basis)
- `bolt.b.studio/pricing.html` — public page with old pricing (hold until fully-live)
- `Studio_B_Architecture.md` — references retired AcuOps Monitor/Validate/Managed tiers

---

## § 10 — Routing for incoming readers

- "What is Bolt?" → `bolt-wms/docs/bolt-product-master-design.md` (PR #365)
- "How does Bolt make money / when does VAR activate?" → THIS FILE (§ 2, § 4, milestone bar)
- "What's shipped vs in-flight on workstream X?" → `project_X.md`
- "What's the plan for feature Y?" → `bolt-wms/docs/plans/`
- "Which chip do I dispatch?" → `memory/prompt_*.md`
- "What does Q3 redesign cover?" → `project_bolt-product-redesign.md`
- "What's the floor surface status?" → `prompt_bolt-floor-offline-resilience-impl.md` + `project_bolt-product-redesign.md` §3 Q3 open questions Q3
