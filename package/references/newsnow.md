# NewsNow API

Base: `https://newsnow.busiyi.world`

## GET `/api/s?id=<source_id>`

Anonymous JSON. Recommended User-Agent:

```text
Mozilla/5.0 (compatible; NewsNowSkill/1.0; +https://newsnow.busiyi.world)
```

Response:

```json
{
  "status": "success",
  "id": "zhihu",
  "updatedTime": 1789395765695,
  "items": [
    {
      "id": "...",
      "title": "...",
      "url": "https://...",
      "extra": { "info": "热度文案", "hover": "可选长摘要" }
    }
  ]
}
```

`status` may be `success` or `cache`. Convert `updatedTime` (ms) to `Asia/Shanghai`.

## Source IDs

| ID | Platform |
|---|---|
| weibo | 微博热搜 |
| zhihu | 知乎热榜 |
| toutiao | 今日头条 |
| baidu | 百度热搜 |
| douyin | 抖音热点 |
| bilibili | B 站热门 |
| ithome | IT之家 |
| v2ex | V2EX |
| tieba | 百度贴吧 |
| hackernews | Hacker News |
| github | GitHub Trending |
| sspai | 少数派 |
| coolapk | 酷安 |
| thepaper | 澎湃新闻 |
| cls | 财联社 |
| wallstreetcn | 华尔街见闻 |
| jin10 | 金十数据 |
| zaobao | 联合早报 |

Default digest set: `weibo zhihu toutiao baidu douyin bilibili ithome`.

## Batching

Prefer parallel GETs. Do not rely on `POST /api/s/entire` (may return 204).

## Project

https://github.com/ourongxing/newsnow
