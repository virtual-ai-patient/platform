# Meeting Overview & Action Points

## Mentor Meeting — April 23, 2026

---

## 1. Summary

The team demonstrated significant progress toward MVP:

- **Lab tests ordering & results** – fully functional in the frontend: select tests, order them, receive results with reference range highlighting (normal vs out-of-range values). Results are displayed in a dedicated tab.
- **Chat with LLM** – integrated and working. The mentor tested it live with a chest pain scenario; the LLM responded plausibly (described pressure sensation, duration, breathing instructions). The mentor commented: *"Interesting, it even signs off. Good prompt."*
- **Chat UI** – includes patient summary, orders, notes placeholders (partially implemented).

**Areas still in progress:**
- New case structure (JSON schema) not yet merged into `main` – waiting for testing.
- Russian language prompts not yet implemented (English is currently used).
- Session persistence: lab test orders are stored in local memory and lost on page refresh (backend persistence planned).
- Case finalisation / diagnosis submission – not yet implemented; the mentor agreed this is needed to complete the clinical workflow.

---

## 2. Key Decisions

| Decision | Rationale |
|:---|:---|
| **MVP is nearly ready** – core features (chat + tests + case library) work. | The team can present a working prototype by the final presentation (May 12). |
| **Add diagnosis submission** – the learner must be able to submit a final diagnosis before ending a session. | Completes the clinical reasoning loop. |
| **Schedule a separate presentation meeting** – Monday evening (April 27). | To review the presentation draft and task board. |
| **Deploy test orders persistently** – move from local memory to backend storage. | So orders survive page refresh. |

---
