# Course 03: Live Queries & Real-Time Presence

**Level:** Intermediate | **Duration:** ~1.5 hours | **Prerequisites:** Course 01

## Learning Objectives

1. Use `LIVE SELECT` to subscribe to real-time table changes
2. Build a real-time agent presence system
3. Push live objective status updates to a dashboard
4. Handle CREATE, UPDATE, DELETE events in a live subscription
5. Kill a live query when done

## Lessons

| # | Lesson | File |
|---|---|---|
| 1 | LIVE SELECT basics | [01-live-basics.surql](./lessons/01-live-basics.surql) |
| 2 | Agent presence heartbeat | [02-presence.surql](./lessons/02-presence.surql) |
| 3 | Live objective stream | [03-live-objectives.surql](./lessons/03-live-objectives.surql) |
| 4 | JavaScript WebSocket client | [04-live-client.js](./lessons/04-live-client.js) |

## Key Takeaways

- `LIVE SELECT` opens a WebSocket subscription — changes push to the client instantly
- No polling. No message queue. SurrealDB IS the real-time layer.
- Agent presence = agents write heartbeats; dashboard reads live
- Live queries replace webhooks, SSE, and polling for internal state
