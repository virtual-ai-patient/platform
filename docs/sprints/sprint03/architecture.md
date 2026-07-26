---
layout: default
title: Sprint 03 Architecture
section: sprints
parent: Sprint 03 Overview
---

> **Historical snapshot (pre-pivot).** This page and its screenshot record the architecture as presented in Sprint 03. The reverse-proxy nginx shown here was removed from the diagrams in a later revision — see [current System Architecture](../../architecture/system-architecture.md) for the up-to-date view.

![Architecture diagram](https://github.com/user-attachments/assets/f32e1675-e55e-4566-a2c7-aea89bc63945)

Two clients — **Telegram bot** (primary) and **Web frontend** (secondary) — routed through **nginx** to a single **Backend** at the time of this sprint.

The backend connects to two abstraction interfaces in a **Dependencies layer**:

- **Database interaction interface** → swappable between **Mock database** (for dev/testing) and **PostgreSQL** (production)
- **LLM interface** → swappable between a real **LLM** and a **Mock LLM**

The dashed lines indicate the swappable/pluggable implementations behind each interface.
