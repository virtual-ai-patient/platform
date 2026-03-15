---
layout: default
title: Sprint 02 Overview
parent: Sprints
has_children: true
nav_order: 1
---

### Participants: Speaker 1 (Mentor), Speaker 2 (Team Member/Backend), Speaker 3 (Team Member/PM)

# 1. Progress Update & Team Roles
Current Status: The team has created initial mockups for the browser frontend and a draft data model.

Team Structure: Roles were distributed as follows:

- Backend development

- Browser frontend (Flutter)

- Telegram bot

- Testing (QA)

- Management

Mentor's Feedback on Roles (Key Point):

- The mentor emphasized the importance of the "Two is one, one is none" principle.

- Every role should ideally have a backup person to cover for absences.

- Cross-functional collaboration is crucial for quality. For example, a manager should help with some dev tasks, and a developer should assist with administrative work. This prevents burnout and the feeling that one person is doing all the "visible" work while others feel left out.

# 2. Data Model Discussion
Presentation: The team presented a preliminary database schema designed for the platform.

Core Entities Discussed:

- Users with potential roles (Doctor, Patient (virtual), Admin).

- Clinical cases, split into main data and details for performance reasons.

- Messages for the chat between doctor and virtual patient.

- Lab tests, test results, and their connection to specific cases.

Mentor's Feedback on Roles (Key Point):

- The team identified a missing role: a supervisor, reviewer, or "attending physician" who monitors the intern's progress and reviews completed cases and reports. This is separate from a technical admin. The team should clarify this with the customer (Ilya).

Mentor's Feedback on Design (Key Point):

- Strongly advised the team to practice Domain-Driven Design (DDD).

- Instead of inventing their own technical names for tables and entities, they should research how doctors and hospitals actually structure patient data (e.g., medical records, visits, referrals). This will make the data model more intuitive and accurate.

# 3. UI/UX Discussion
Presentation: The team showed draft mockups for the main interface, including a case library and a chat screen.

Mentor's Feedback:

- The case library view should hide the diagnosis from the intern; they should only see patient names or basic info.

- The main workspace needs to integrate several elements: the chat with the patient, a panel for ordering lab tests, a place to view results, and possibly a section for the doctor's personal notes.

- The mentor suggested a tabbed interface (e.g., switching between "Chat," "Test Results," "Summary") rather than having everything on one crowded screen.

# 4. Strategy and Next Steps
Risk of Delay: The mentor warned that signing the NDA/contract with the customer could take a very long time (potentially months), as seen in previous semesters.

Proactive Development: The team should start building a working prototype immediately without waiting for the customer's data or signature. Synthetic data can be used.

Customer Communication: The team plans to present their current design to the customer to get feedback on their specific needs and terminology.

Roadmap Planning:

- The team should create a roadmap until August.

- This roadmap should factor in non-project commitments (exams, holidays, etc.).

- The immediate technical goal is to have a functional prototype with a chat interface, a basic case, and the ability to "order" a test.
