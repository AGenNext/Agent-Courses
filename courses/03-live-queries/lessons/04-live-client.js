/**
 * Lesson 04: JavaScript WebSocket Live Query Client
 * Uses the surrealdb.js SDK to subscribe to live updates.
 *
 * Install: npm install surrealdb
 * Run: node 04-live-client.js
 */

import Surreal from "surrealdb";

const db = new Surreal();

async function main() {
  await db.connect("ws://localhost:8000/rpc");
  await db.use({ namespace: "courses", database: "live_queries" });

  console.log("Connected to SurrealDB");

  // Subscribe to all objective changes
  const queryUuid = await db.live("SELECT * FROM objective", (action, result) => {
    console.log(`[LIVE] ${action}:`, JSON.stringify(result, null, 2));
  });

  console.log(`Live query active: ${queryUuid}`);
  console.log("Waiting for changes... (Ctrl+C to stop)\n");

  // Simulate some writes after 1 second
  setTimeout(async () => {
    console.log("Creating objective...");
    await db.create("objective", {
      goal: "Write a live query demo",
      status: "pending",
    });

    setTimeout(async () => {
      console.log("Updating to running...");
      await db.query(
        "UPDATE objective SET status = 'running' WHERE goal = 'Write a live query demo'"
      );
    }, 1000);

    setTimeout(async () => {
      console.log("Completing objective...");
      await db.query(
        "UPDATE objective SET status = 'completed' WHERE goal = 'Write a live query demo'"
      );
      // Kill the subscription
      await db.kill(queryUuid);
      await db.close();
      console.log("\nSubscription killed. Done.");
    }, 2000);
  }, 1000);
}

main().catch(console.error);
