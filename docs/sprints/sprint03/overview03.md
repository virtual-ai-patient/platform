# Meeting Overview: Non-Functional Requirements Deep Dive

**Topic:** Clarifying and refining key Non-Functional Requirements (Performance, Scalability, Availability, Security)

---

## 1. Performance — The "Real Human" Feel

**Discussion:**
The team discussed what the performance target should feel like for the end-user (the medical intern). The goal is for the interaction with the virtual patient to feel natural and close to a real conversation.

**Key Decision:**
- The system's response time should be fast enough that the intern feels they are talking to a real person.
- A delay of more than a few seconds would break immersion and make the simulation feel unrealistic and frustrating.

**How to Prove/Measure:**
- Target response time should likely be in the **1-2 second range** for chat messages to feel instantaneous.
- We can justify this by referencing studies on human conversation pacing or by comparing to other real-time chat applications used in medical settings.

---

## 2. Scalability — Real-World Hospital Context

**Discussion:**
We need to move away from abstract numbers and base our scalability requirements on real-world contexts where the product could be used.

**Proposed Approach:**
- **Use Case 1: A Single Hospital.** We should research how many doctors, interns, or residents might be using a training system concurrently in a large hospital. Is it 50, 100, 200 simultaneous users during peak training hours?
- **Use Case 2: A Medical University Course.** We should look at the size of a typical medical school cohort or a specific clinical skills course. How many students would need to access the system to complete an assignment? This gives us a concrete number of daily active users.

**Key Decision:**
- Scalability requirements will be anchored in these real-world examples, not just arbitrary numbers. This makes the requirement more defensible and meaningful to the client.

**How to Prove/Measure:**
- We need to gather data (or make well-researched estimates) on hospital staff sizes and medical school course enrollments.
- Load testing tools (like Locust) will then be configured to simulate these realistic user loads.

---

## 3. Availability — Balancing Uptime and Complexity

**Discussion:**
Aiming for "five nines" (99.999%) or even 99.9% availability was discussed as being potentially overkill for an MVP and would drastically increase architectural complexity (and cost).

**Proposed Approach:**
- We should define availability based on when the system is actually needed.
- **Idea:** Offer **99.5% availability during working hours (e.g., 9 AM – 9 PM, Monday-Friday)** . This is when training is most likely to occur.
- **Deployment Strategy:** To achieve this without massive complexity, we can plan for updates and maintenance **only on weekends**.
- This means there could be *some* downtime during off-hours, but the system is highly reliable when it matters most.

**Key Decision:**
- Define **"Working Hours Availability"** as the key metric, rather than 24/7 availability. This aligns with the educational use case and simplifies the initial infrastructure.

**How to Prove/Measure:**
- Monitor uptime specifically during defined working hours.
- Document the maintenance windows (weekends) as part of the service definition.

---

## 4. Security — Focusing on Risk, Not Technology

**Discussion:**
The conversation shifted from *what* technology we use (e.g., encryption) to *what bad things could happen* and how to prevent them. This is a more threat-focused approach to security.

**Key Questions and Decisions:**

| Risk/Scenario | Potential Bad Outcome | Mitigation Strategy (How to Solve) |
| :--- | :--- | :--- |
| **Data Leakage of Patient Cases** | The synthetic patient cases themselves are valuable IP. If leaked, competitors could copy our training scenarios. | Strict access control (RBAC) on case authoring tools. Encrypt case data at rest. Separate storage for core case libraries. |
| **Leakage of Doctor/Intern Conversations** | A doctor's line of questioning or diagnostic reasoning, captured in chat logs, could be considered private performance data. If leaked, it could be embarrassing or a privacy violation. | Anonymize chat logs when used for analytics. Strictly control access to raw conversation history. Ensure data deletion policies are in place. |
| **Model Poisoning / Prompt Injection** | A user could potentially trick the LLM into leaving its simulation context, generating inappropriate or harmful content, or revealing its system prompt. | Implement robust input validation and output guardrails (QA-SAFE-01). Log and monitor for unsafe inputs/outputs (QA-SAFE-03). |
| **Unauthorized Access** | A student could access educator tools and change their own scores or case difficulty. | Enforce strict RBAC (QA-SEC-02) with regular audits. |

**Key Decision:**
- Security requirements will be documented by first stating the **risk**, then the **mitigation**. This makes the security choices understandable and justifiable to non-technical stakeholders.

**How to Prove/Measure:**
- Conduct threat modeling exercises.
- Implement and test the specific mitigation strategies (e.g., RBAC, guardrails).
- Regular security audits and penetration testing (post-MVP).
