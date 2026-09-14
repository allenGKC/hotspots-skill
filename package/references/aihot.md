# AIHOT (optional companion)

This Hotspots skill does **not** bundle AIHOT files. Install the official skill separately:

```bash
bash <(curl -fsSL https://aihot.news/aihot-skill/install.sh) --target agents
```

Docs: https://aihot.news/aihot-skill/README.md  
Terms: https://aihot.news/terms

When present, call AIHOT for the AI-selected section:

- Past 24h selected: `GET https://aihot.news/api/v1/items?mode=selected&window=24h`
- Hot topics: `GET https://aihot.news/api/v1/hot-topics`

Follow the installed `aihot` Skill for User-Agent / Actor ID rules. Title links use `links.aihot`. Times in `Asia/Shanghai`.
