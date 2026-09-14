# SoPilot Hot Tweets RSS

Feed: `https://sopilot.net/rss/hottweets`  
Human page: `https://sopilot.net/hot-tweets`  
Docs: `https://sopilot.net/docs/hot-tweets-monitor-guide`

```bash
curl -fsSL -A "Mozilla/5.0 (compatible; SoPilotSkill/1.0; +https://sopilot.net)" \
  "https://sopilot.net/rss/hottweets"
```

Each `item`:

- `title` — usually `Display Name (@handle)`
- `link` — `https://sopilot.net/hot-tweets?tweetId=...`
- `pubDate` — RFC 822 (interpret in China time)
- `description` — tweet text; may end with engagement counts

Do not call `https://sopilot.net/api/*` (robots Disallow). RSS only.

Default digest: 8–12 items.
