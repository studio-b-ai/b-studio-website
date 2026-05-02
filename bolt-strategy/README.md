# Bolt Strategy + Roadmap — Mirror

**Snapshot date:** 2026-05-02
**Source session:** 2026-04-29 → 2026-05-02 master GTM + roadmap session (canonical thread in Claude Code)

## Canonical vs mirror

The Claude Code auto-memory directory (`~/.claude/projects/.../memory/`) is the **canonical** store for Bolt strategy state. This directory is a **mirror snapshot** for human contributors — it gives repo-path entry points and version control for the strategy layer without duplicating the live ratchet.

Per CLAUDE.md Rule #30: auto-memory is canonical; in-repo copies are mirrors for human contributors.

Update cadence: mirror is refreshed at each session close-out (rigby) when `project_bolt-master-plan-v1.md` changes.

---

## File index

| File | Description |
|------|-------------|
| `master-plan-v1.md` | Locked strategy snapshot — pricing, ICP, sales motion, milestones (M1–M6), M4 fully-live gate (Q-S3), and change-log. Amend only on quarterly lock or explicit strategy pivot. |
| `q3-redesign-brief.md` | Q3 redesign workstream brief — 5 label/concept collisions + 7 strategic IA questions from Kevin's 2026-04-29 PM walkthrough. Gated on UX practitioner engagement + 6–8 weeks nav-event analytics post-fully-live. |

---

## Locked decisions summary

### Pricing (locked 2026-04-29)

| Tier | $/mo (per Acumatica instance) | Annual prepay (10% off) | Setup (one-time) |
|------|------------------------------|------------------------|------------------|
| Core | $1,200 | $12,960/yr | $5,000 |
| Pro | $1,750 | $18,900/yr | $10,000 |
| Enterprise | $2,500 | $27,000/yr | $15,000 |
| VAR white-label add-on | $500–1,000/mo | — | $2,000–5,000 |

Pricing unit: per Acumatica instance/month. One subscription covers all tenants + branches on that instance. VAR wholesale: 75% of list (25% margin). White-label add-on stays 100% to Studio B.

Note: `bolt.b.studio/pricing.html` (this repo) still shows legacy pricing ($800/$1,200/$1,800). Public page update is held until the M4 fully-live milestone. Do not update the pricing page before fully-live.

### ICP (locked 2026-04-29)

$10–100M revenue Acumatica continuous-goods distributors. Vertical entry sequence: Carpet → Wire & Cable → Hose → Paper/Vinyl. Reference customer: Ästhetik / Heritage Fabrics on `wms.asthetik.com`.

### Sales motion (locked 2026-04-29)

Hybrid forever. Direct stays open for Studio B holdco brands + exceptional inbound. VAR channel is the primary new-customer path after VAR-deck-ready (mid-Feb to early-Mar 2027). No exclusivity.

### Milestones

M1 Foundation ✅ → M2 Imports ✅ → M3 Ops + ATP + CMC ✅ → **M4 Heritage Live** (mid-Aug to early-Sep 2026, NEXT) → M5 Prove + Scale → M6 VAR (mid-Feb to early-Mar 2027).

M4 requires all 10 fully-live gate items (Q-S3). Key items: Imports Dashboard + Operations Hub + CMC flags live; ATP write-back validated; cert-free 3-layer browser-native notification stack operational on every inbound CS call (Primary: in-page DOM overlay in heritage-wms tab; Secondary: Web Notifications API OS-level toast; Tertiary: Service Worker + Push API); Android floor surface used daily by warehouse team.

**Bolt Pickup desktop tray DEFERRED to Q3 (2026-05-02 decision).** The browser-native 3-layer stack covers Chrome-minimized + Chrome-closed scenarios, making the tray redundant for HF reps at fully-live. No Apple Dev ID or Windows OV cert work in critical path. Pickup chip remains at `memory/prompt_bolt-pickup-mvp-impl.md` with DEFERRED header for Q3 reactivation if HF pilot shows >5% browser-notification miss-rate.

### Q3 redesign (post-fully-live)

Five label/concept collisions from Kevin's PM walkthrough are resolved via chip prompts before fully-live. Full IA refactor (Proposal A + C-style home) is gated on 6–8 weeks nav-event analytics and a ~$3–5K UX practitioner audit at Wks 4–6 post-flag-flip. See `q3-redesign-brief.md` for the full brief.

---

## Cross-references

| Resource | Location |
|----------|----------|
| Bolt product spec (canonical) | `studio-b-ai/bolt-wms` — `docs/bolt-product-master-design.md` (PR #365, merged 2026-04-29) |
| Executable chip prompts (17) | `memory/prompt_*.md` in auto-memory — dispatched 2026-04-29 |
| Per-workstream engineering docs | `studio-b-ai/bolt-wms/docs/plans/` |
| Public pricing page (stale — hold) | `bolt.b.studio/pricing.html` (this repo — update after fully-live) |
| Auto-memory canonical master plan | `~/.claude/projects/.../memory/project_bolt-master-plan-v1.md` |
| Auto-memory canonical redesign brief | `~/.claude/projects/.../memory/project_bolt-product-redesign.md` |
