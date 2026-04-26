---
title: "Tiered session close-out: a Claude Code pattern"
description: "Most session-wrap skills produce one prose dump. We route to three stores with three approval gates — and one of them blocks completion until a domain contract is satisfied."
author: "Kevin Bibelhausen"
publisher: "Studio B"
date: 2026-04-26
status: draft
tags: [claude-code, agent-skills, ops]
---

# Tiered session close-out: a Claude Code pattern

If you run Claude Code seriously, you've written the same prompt half a dozen times: *"Wrap up this session. What did we learn? What's left? What should I commit?"* You get back a tidy summary, you nod, you close the terminal. A week later a production screen breaks for the third time on the same root cause and nothing in your memory files knows about it.

The summary is the wrong artifact. A close-out has to do three jobs at once, and they don't share an output:

1. **Update the rules** — promote anything the user said *"from now on, X"* into instructions that load on every future session.
2. **Persist what was learned** — incidents, vendor quirks, architectural decisions, in a store the agent will actually search before retrying a known mistake.
3. **Hand off the unfinished work** — branch state, follow-ups in other repos, what to tell the next session to pick up.

Most close-out skills currently circulating collapse all three into one prose blob. The blob ages out of context the moment the session ends. What I want — and what the skill described below does — is route each of the three to a different store with a different approval gate, and refuse to finish until a domain-specific contract is satisfied.

## What's already out there

Before I wrote anything, I went looking for prior art. There's plenty.

- [**dream-skill**](https://github.com/grandamenium/dream-skill) by Eshan Govil runs a four-phase consolidation pass over the user's existing memory files — orient, gather signal from JSONL transcripts, consolidate, prune the index. It's the closest thing to an official answer because it replicates Anthropic's unreleased "auto-dream" feature ([writeup](https://claudefa.st/blog/guide/mechanics/auto-dream)). It runs autonomously every 24 hours; there's no explicit approval gate and no concept of a domain guard.
- [**qmd-sessions**](https://www.williambelk.com/blog/qmd-sessions-claude-code-memory-with-qmd-20260303/) by William Belk converts session JSONL into clean markdown, indexes it with a local hybrid BM25 + vector engine, and exposes it as an MCP server so future sessions can search their own history. Excellent at the *retrieval* problem; orthogonal to the *routing* problem.
- [**claude-mem**](https://github.com/thedotmack/claude-mem) by Alex Newman hooks all five session lifecycle events, AI-compresses tool activity into a SQLite store, and uses a 3-layer progressive disclosure for retrieval. Fully automatic — no approval gates, no tiered output routing, no domain hooks beyond a `<private>` exclusion tag.
- [**gstack**](https://github.com/garrytan/gstack) (Garry Tan's setup) ships ~23 role-specific skills — Release Manager, QA, Doc Engineer — but its session-end story is decentralized across whichever role is active. The [office-hours skill](https://github.com/garrytan/gstack/blob/main/office-hours/SKILL.md), the closest to a structured-output skill in that suite, is a *brainstorming* artifact with mandatory `AskUserQuestion` approval gates — the gating pattern is sound, just pointed at a different problem.
- [**claudekit**](https://github.com/carlrannaberg/claudekit) gives you git checkpoints, real-time test monitoring, and a code-review subagent, plus a community marketplace. The checkpoint primitive is great for *recovery* but doesn't separate "rule" from "knowledge" from "handoff."
- The official [**ralph-wiggum**](https://github.com/anthropics/claude-code/blob/main/plugins/ralph-wiggum/README.md) plugin and [Geoffrey Huntley's original Ralph technique](https://www.youtube.com/watch?v=O2bBWDoxO4s) are about *continuing* a session indefinitely, not ending one — different shape entirely.

So the pattern I'm describing isn't a duplicate of any of these. It borrows from several (qmd-sessions' cross-session search, dream-skill's consolidation pass, gstack's gating discipline) and adds two ideas neither of them carry: **explicit tiered routing** and **blocking domain guards**.

## The four ideas

I called the skill **Rigby**, after the [Silicon Valley S3E1 gag](https://www.youtube.com/watch?v=pF8o3UrwksU) where Gilfoyle compresses "**R**ichard **i**s **g**reat, **b**ut..." into a single syllable — the universal preamble to a softened complaint. Every session is great, *but* — and the buts are where the next outage lives. A close-out skill that doesn't surface them is a victory lap. A generic version of the scaffold is published at [studio-b-ai/tiered-close-out](https://github.com/studio-b-ai/tiered-close-out); what's worth taking is the shape, not my implementation.

### 1. Three outputs, three stores, three gates

A session produces three kinds of artifact. They want three different homes.

**Behavioral rules** the user stated during the session ("never deploy with the sandbox gate disabled," "always use absolute paths") go to `~/.claude/CLAUDE.md` under the `Rules — Non-Negotiable` section. The gate is a diff: I show the proposed addition, the user reads it, the user types Y. These are forever, so they get the slowest, most deliberate review.

**Operational knowledge** — incidents, vendor API quirks, architectural decisions, business rules — goes to a vector store (mine is Qdrant; for you it could be SQLite-FTS or `~/.claude/notes/`, the routing is what matters, not the substrate). The gate is a structured tag check: every entry has to declare `domain`, `client`, `source` before it ingests. The user sees the proposed entries and approves the batch.

**Unfinished work, artifacts, and branch state** stay ephemeral — they go in the close-out summary message itself, then evaporate. There's no point persisting "we left a stash on branch X" because next session can read git directly.

Three stores, three gates, three lifespans. A prose blob can't do this — it commits everything to one place at one approval level, which means either the rules get buried in transient noise or the transient noise pollutes the rules. Rigby's gates are diff (rules), batch-approve (knowledge), display-only (handoff) — and the user can reject any of the three independently.

dream-skill consolidates the memory tier well, but it doesn't separate "promote to rule" from "log as incident." claude-mem captures everything to one SQLite store with no gate at all. The separation is the point.

### 2. Cross-session memory before analyzing the current session

Section 0 of the skill runs *first*, before it looks at what just happened. It pulls the current session's primary topic, embeds it, and queries a vector index of past sessions for the top five matches. The output gets attached to whatever knowledge entries Rigby is about to draft.

This catches recurring patterns automatically. *"Third time this screen has broken with the same root cause"* shows up as a line in the close-out, and it shows up *before* the agent decides whether the current incident deserves a new memory entry or an edit to an existing one.

qmd-sessions does this brilliantly as a general-purpose retrieval surface — past sessions become an MCP-searchable corpus. Rigby's contribution is making the search a *mandatory phase 0 of close-out*, not an opt-in tool the agent might or might not invoke. The wrap-up is the moment you most need to know whether you've seen this before, and the skill structure forces the check.

### 3. Blocking domain guards

This is where the skill stops being a generalized scaffold and starts being mine.

Section 7 is a hard gate. If the session touched any Acumatica customization XML, the close-out cannot complete until a specific contract is satisfied: every new OData-exposed Generic Inquiry block must be added to a corresponding C# allowlist in the same PR. Two-line change in two files. Non-negotiable.

The contract exists because of [a 14-hour outage on 2026-04-17](https://b.studio). We deployed twelve new Generic Inquiries; ten worked, two were stuck at HTTP 403 in production for about a day. The cause was a quirk in Acumatica's customization-publish engine: the first time it processes one of these XML blocks, if role-binding glitches for any of several silent reasons, the block is permanently marked "already applied" and no future deploy will retry. The fix has to be a defensive C# plugin that reattaches role bindings on every publish — which only works if the new screen is in an explicit allowlist.

Code review missed it. Tests passed. Deploy succeeded. The screens 403'd anyway. The lesson, after writing it up, is that some failure modes can't be caught at code-review time — they need a tripwire at the moment of *reflection*. Rigby is that tripwire. If the session edited Acumatica XML and the contract isn't satisfied, the skill prints `❌ FAIL — approval BLOCKED` and refuses to write any of the three tiers until the gap is closed.

Generalize that. Every domain you work in has at least one rule that, when violated, costs you hours. *"Database migrations need a rollback file."* *"Public API changes need a changelog entry."* *"Anything that touches billing needs a feature flag."* These are the things you keep meaning to add to your PR template and never do, because the PR template runs at the wrong time — by the time you're opening the PR, the discipline opportunity is past. Run them at close-out instead, where the agent has full conversational context about *why* the change was made.

None of the surveyed skills have this concept. dream-skill, qmd-sessions, and claude-mem are domain-neutral by design. gstack's office-hours has approval gates but they're conversational, not blocking. The blocking guard is what turns a scaffold into a workflow you can trust.

### 4. Skill composition over reimplementation

When a session ends with uncommitted work in a feature branch or worktree, Rigby doesn't try to handle the merge/PR/keep/abandon decision itself. Section 5 hands off to [`superpowers:finishing-a-development-branch`](https://github.com/obra/superpowers), which already knows that decision tree.

This is small but it matters. The temptation when writing a "comprehensive" skill is to inline everything so the user only invokes one thing. The cost is that you end up reimplementing — and slowly diverging from — primitives someone else maintains better than you. Rigby's composition is explicit: when the conversation hits a branch-disposition decision, jump to the skill that owns that decision, then come back.

claudekit and gstack both compose internally across their own suites; rigby's contribution is composing *across* skill packages. The implication for your own version: write the close-out as a router, not a monolith. Section 1 promotes rules. Section 2 ingests knowledge. Section 5 invokes whoever owns branch state in your stack. Section 7 runs your domain guard. Each section can be replaced independently.

## Comparison

Honest comparison, not a strawman pass:

| | Tiered output routing | Cross-session search | Blocking domain guards | Composition with other skills | Approval model |
|---|---|---|---|---|---|
| **Rigby (this pattern)** | 3 stores, 3 gates | Mandatory phase 0 | Yes, per-domain | Hands off to `superpowers:*` | Per-tier (diff / batch / display) |
| **dream-skill** | Single tier — memory files | Reads recent JSONL signal | None | Standalone | Autonomous (24hr trigger) |
| **claude-mem** | Single tier — SQLite + 3-layer retrieval | Yes, via MCP retrieval | None (modes ≠ guards) | Standalone | None — fully automatic |
| **qmd-sessions** | Single tier — markdown corpus | Yes, the entire point | None | Exposes MCP for others | Install-time only |
| **gstack office-hours** | Single tier — design doc | No | No (gates are advisory) | Within gstack suite | Mandatory `AskUserQuestion` per phase |
| **claudekit checkpoints** | Single tier — git refs | No | None | Within claudekit | Automatic |

What the others do *better* than rigby, fairly:

- **claude-mem's progressive-disclosure retrieval** is more sophisticated than rigby's flat Qdrant query. If you're optimizing for token cost on read, look there.
- **qmd-sessions' BM25 + vector + LLM-rerank** is a stronger search stack than rigby's vector-only.
- **dream-skill's autonomous trigger** is genuinely nicer UX than typing "rigby" — but it trades off the deliberate review window I want.
- **gstack's `AskUserQuestion`-gated phases** were what convinced me to ditch rigby's earlier `[Y/n]` prompt for per-tier `AskUserQuestion` gates. Borrowed straight from office-hours and integrated; the pattern travels.

The differentiation isn't *better*. It's *shape*. Rigby is for someone running production systems where some classes of mistake are expensive enough to justify a tripwire at every wrap-up.

## How to adapt it to your stack

Clone [studio-b-ai/tiered-close-out](https://github.com/studio-b-ai/tiered-close-out) into `~/.claude/skills/tiered-close-out/`. The SKILL.md boots with three `TODO:` markers and one example domain guard; the README walks the fills for three common stacks (CLAUDE.md + claude-mem, CLAUDE.md + qmd-sessions, AGENTS.md + tagged-markdown). On the cold install I timed it at 5–7 minutes end to end.

The five things to be deliberate about while filling it in:

1. **Pick your three tiers.** Behavioral rules → wherever your agent loads them on startup (CLAUDE.md, `.cursorrules`, AGENTS.md). Operational knowledge → whatever you can cheaply search later (a tagged folder of markdown files works fine; you don't need a vector store on day one). Handoff → display-only, no persistence.

2. **Pick three approval shapes.** Rules want a diff review. Knowledge wants batch-approve-with-tags. Handoff wants no approval at all. Use whatever your harness gives you for prompts; the gate matters more than the mechanism.

3. **Run cross-session search before drafting.** Even if "search" is `grep -r` over your knowledge folder, do it before you decide whether the current session's lessons are new. You'll find patterns you forgot you'd already documented.

4. **Write down your domain guards.** What are the failure modes that have cost you a day or more? Each one becomes a section like rigby's §7 — a check that runs only on sessions that touched the relevant code, with a hard fail that blocks the rest of the close-out. Two or three of these is enough to start.

5. **Compose, don't reimplement.** If your harness has a finishing-a-branch skill, hand off to it. If your team uses a separate incident-write-up template, hand off to that. Your close-out skill is a router; its job is to make sure each artifact reaches the right destination, not to own every destination itself.

The shortest version of all of this: most session-wrap skills are written as if the goal is a tidy summary. The goal is to make the next session — the one a week from now, on a different feature, by a different agent — not repeat what this one already learned. That's a routing problem, not a writing problem. The summary is just the receipt.

---

*Kevin Bibelhausen runs [Studio B](https://b.studio), a small consultancy that builds and runs Acumatica-adjacent products including [Bolt WMS](https://bolt.b.studio) and [AcuOps](https://acuops.com). The Rigby skill is part of his personal setup; the [scaffold](https://github.com/studio-b-ai/tiered-close-out) is free to copy.*
