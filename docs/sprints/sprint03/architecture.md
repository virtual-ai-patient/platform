---
layout: default
title: Sprint 03 Architecture
section: sprints
parent: Sprint 03
---

![Architecture diagram](https://github.com/user-attachments/assets/f32e1675-e55e-4566-a2c7-aea89bc63945)

Two clients — **Telegram bot** (primary) and **Web frontend** (secondary) — route through **nginx** to a single **Backend**.

The backend connects to two abstraction interfaces in a **Dependencies layer**:

- **Database interaction interface** → swappable between **Mock database** (for dev/testing) and **PostgreSQL** (production)
- **LLM interface** → swappable between a real **LLM** and a **Mock LLM**

The dashed lines indicate the swappable/pluggable implementations behind each interface.
