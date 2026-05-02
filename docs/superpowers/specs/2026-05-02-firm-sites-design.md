# Firm Sites Design — consulting.b.studio · capital.b.studio · benchmarks.b.studio

**Date:** 2026-05-02  
**Priority:** Capital (deadline 2026-05-05) → Consulting → Benchmarks  
**Status:** Approved, ready for implementation

---

## Overview

Three separate GitHub Pages sites, each a single landing page for one Studio B firm. They share the Billboard DNA from b.studio but are not clones — each firm gets its own palette register (Direction A) while inheriting the same typographic and structural system.

---

## Visual System

**Direction A — palette rotation, existing colors only**

| Firm | Ground | Type | Accent |
|------|--------|------|--------|
| Consulting | Yolk `#F7D344` | Ink `#0D0D0D` | Vermillion `#D94425` |
| Capital | Forest `#1A3328` | Paper `#F4F1EB` | Yolk `#F7D344` |
| Benchmarks | Paper `#F4F1EB` | Ink `#0D0D0D` | Forest `#1A3328` |

**Shared DNA (non-negotiable):**
- Fraunces 900 display headlines (italic for accent word)
- JetBrains Mono for labels, tags, metadata
- Inter for body copy
- Diagonal caution stripe (`-45deg`, 8px alternating) — full weight on Consulting + Benchmarks, thinner treatment on Capital
- Hard borders (`3px solid`), no border-radius
- Ink `#0D0D0D` as structural separator

---

## Capital — capital.b.studio (Priority 1)

### Copy

**Headline:** Not sourced. Surfaced.

**Body:** The businesses we back have been in our network for years — advised, measured, and run alongside. We're not introduced to the opportunity. We're already trusted by the operator.

**CTA:** LP Inquiry

**Tag:** Investment firm · $100M target · lower middle market · capital.b.studio

### Page Structure

1. **Hero** — full-viewport, forest ground, headline + body + scroll-to-form CTA
2. **LP Inquiry form** — name, email, firm, message (optional). On submit: creates HubSpot contact with `lp_stage = prospect`, triggers HubSpot workflow that emails Docsend data room link
3. **Newsletter strip** — Beehiiv embed, SDLI Brief ("Ground-level intelligence on lower middle market operators. Monthly.")
4. **Footer** — links to Consulting, Benchmarks, b.studio

### Lead Flow

```
LP clicks "LP Inquiry"
→ scrolls to form
→ submits (name, email, firm, note)
→ HubSpot contact created: lp_stage=prospect, newsletter_source=capital-site
→ HubSpot workflow fires: sends Docsend data room link via email
→ LP enters sales funnel
```

**Dependencies before go-live:**
- Docsend data room must exist
- HubSpot workflow must be built (form → Docsend email)
- HubSpot form embed code or API endpoint

### Repo + DNS

- Repo: `studio-b-ai/capital-b-studio` (GitHub Pages)
- CNAME file: `capital.b.studio`
- GoDaddy: add `capital` CNAME → `studio-b-ai.github.io`

---

## Consulting — consulting.b.studio (Priority 2)

### Copy (draft — pending copy review)

**Headline:** We build for operators who can't justify a senior team *full time.*

**Body:** Studio B Consulting embeds directly into your operation — strategy, systems, and execution without the overhead of a full-time hire. We work with lower middle market companies running on complexity.

**CTA:** Start a conversation

**Tag:** Services firm · consulting.b.studio

### Page Structure

1. **Hero** — yolk ground, headline + body + CTA (mailto or Calendly)
2. **Services strip** — three brief columns: Strategy / Systems / Execution (no pricing)
3. **Footer** — links to Capital, Benchmarks, b.studio

### Repo + DNS

- Repo: `studio-b-ai/consulting-b-studio`
- CNAME: `consulting` → `studio-b-ai.github.io`

---

## Benchmarks — benchmarks.b.studio (Priority 3)

### Copy (draft — pending copy review)

**Headline:** Ground truth for the lower *middle market.*

**Body:** Studio B Benchmarks measures what operators actually want to know — performance, throughput, and unit economics across the lower middle market. Not survey data. Not proxies. Observed signal from real operations.

**CTA:** Get early access

**Tag:** Measurement firm · benchmarks.b.studio

### Page Structure

1. **Hero** — paper ground, headline + body + CTA (email capture)
2. **What we measure** — brief signal list (3–4 items)
3. **Footer** — links to Consulting, Capital, b.studio

### Repo + DNS

- Repo: `studio-b-ai/benchmarks-b-studio`
- CNAME: `benchmarks` → `studio-b-ai.github.io`

---

## Shared Infrastructure

**Cross-site navigation:** Each footer links to all three firms + b.studio. No top nav (single page, nothing to navigate to).

**OG tags (required on all three per Rule #47):** `og:type`, `og:site_name`, `og:title`, `og:description`, `og:url`, `twitter:card=summary_large_image`

**Analytics:** Add to master-plan.md once decided (Fathom / Plausible / none)

**Fonts:** Load from Google Fonts (same as b.studio): Fraunces, JetBrains Mono, Inter

---

## Open Decisions

- Consulting CTA destination: mailto vs. Calendly embed
- Benchmarks CTA destination: email capture (Beehiiv?) or static mailto
- Analytics provider
- Consulting + Benchmarks copy needs a review pass (Capital copy is locked)
