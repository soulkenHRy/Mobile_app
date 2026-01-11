// News Feed System - Canvas Design Data
// Contains predefined system designs using available canvas icons

import 'package:flutter/material.dart';
import 'system_design_icons.dart';

/// Provides predefined News Feed system designs for the canvas
class NewsFeedCanvasDesigns {
  static Map<String, dynamic> _createIcon(
    String name,
    String category,
    double x,
    double y, {
    String? id,
  }) {
    final iconData = SystemDesignIcons.getIcon(name);
    return {
      'id': id ?? name,
      'name': name,
      'iconCodePoint': iconData?.codePoint ?? Icons.help.codePoint,
      'iconFontFamily': iconData?.fontFamily ?? 'MaterialIcons',
      'category': category,
      'positionX': x,
      'positionY': y,
    };
  }

  static Map<String, dynamic> _createConnection(
    int from,
    int to, {
    String? label,
    int color = 0xFF3F51B5,
    double strokeWidth = 2.0,
  }) {
    return {
      'fromIconIndex': from,
      'toIconIndex': to,
      'label': label,
      'color': color,
      'strokeWidth': strokeWidth,
    };
  }

  // DESIGN 1: Basic News Feed
  static Map<String, dynamic> get basicArchitecture => {
    'name': 'Basic News Feed',
    'description': 'Simple chronological feed of posts',
    'explanation': '''
## Basic News Feed Architecture

### What This System Does
A news feed shows posts from people you follow, like Facebook, Twitter, or Instagram. This basic version shows posts in chronological order (newest first).

### How It Works Step-by-Step

**Step 1: User Opens App**
User opens the app and requests their feed.

**Step 2: Get Following List**
System fetches who this user follows:
```json
{
  "user_id": "alice",
  "following": ["bob", "carol", "dave", "eve"]
}
```

**Step 3: Fetch Posts from Each**
For each followed user, get recent posts:
```sql
SELECT * FROM posts 
WHERE author_id IN ('bob', 'carol', 'dave', 'eve')
ORDER BY created_at DESC
LIMIT 100
```

**Step 4: Merge and Sort**
All posts combined and sorted by time:
```
1. Eve's post (2 min ago)
2. Bob's post (5 min ago)
3. Carol's post (12 min ago)
4. Dave's post (1 hour ago)
...
```

**Step 5: Return to Client**
Feed sent to app, rendered as scrollable list.

**Step 6: Pagination**
When user scrolls, fetch more:
- Cursor-based: "Get posts before this timestamp"
- Offset-based: "Get posts 100-200"

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Mobile App | User interface | Display feed |
| Feed Service | Fetches and merges posts | Core logic |
| Follow Graph | Stores who follows whom | Relationships |
| Post Store | Stores all posts | Content storage |
| User Cache | Caches user profiles | Performance |

### The Problem with This Approach
```
User follows 500 people
Need posts from 500 users
500 database queries!
Very slow for popular users

Solution: Pre-compute feeds (fan-out)
```

### Feed Query Pattern
```sql
-- Simple but slow for large follows
SELECT posts.*, users.name, users.avatar
FROM posts
JOIN users ON posts.author_id = users.id
WHERE posts.author_id IN (
  SELECT following_id 
  FROM follows 
  WHERE follower_id = 'current_user'
)
ORDER BY posts.created_at DESC
LIMIT 20
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('API Gateway', 'Networking', 200, 350),
      _createIcon('Feed Service', 'Application Services', 400, 350),
      _createIcon('Follow Graph', 'Database & Storage', 600, 200),
      _createIcon('Post Store', 'Database & Storage', 600, 350),
      _createIcon('User Cache', 'Caching,Performance', 600, 500),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Request Feed'),
      _createConnection(1, 2, label: 'Get Feed'),
      _createConnection(2, 3, label: 'Who I Follow'),
      _createConnection(2, 4, label: 'Their Posts'),
      _createConnection(2, 5, label: 'User Info'),
    ],
  };

  // DESIGN 2: Fan-out on Write
  static Map<String, dynamic> get fanoutWriteArchitecture => {
    'name': 'Fan-out on Write',
    'description': 'Pre-compute feeds when posts are created',
    'explanation': '''
## Fan-out on Write Architecture

### What This System Does
Instead of computing feed on every read (slow), we pre-compute feeds when posts are created. When Bob posts, we add it to all his followers' feeds immediately.

### How It Works Step-by-Step

**Step 1: User Creates Post**
Bob writes: "Hello World!"
Post stored in Posts table.

**Step 2: Get All Followers**
Fetch Bob's follower list:
```json
{
  "followers": ["alice", "carol", "dave", ...1000 more]
}
```

**Step 3: Fan Out to Feeds**
Add Bob's post ID to each follower's feed:
```
alice_feed: [bob_post_123, ...]
carol_feed: [bob_post_123, ...]
dave_feed: [bob_post_123, ...]
```

**Step 4: Feed Stored in Cache**
Each user's feed is a list in Redis:
```
LPUSH alice_feed bob_post_123
LTRIM alice_feed 0 999  # Keep last 1000
```

**Step 5: User Requests Feed**
When Alice opens app:
- Read her pre-computed feed from Redis
- Fetch post content for each ID
- Return instantly!

**Step 6: Trade-off**
Write is slow (fan to many followers)
Read is fast (just read from cache)
Great for apps with more reads than writes.

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Post Service | Handles new posts | Create posts |
| Fan-out Service | Distributes to feeds | Pre-computation |
| Follower Index | Quick follower lookup | Fast fan-out |
| Feed Cache | Stores user feeds | Fast reads |
| Post Store | Stores post content | Content storage |

### The Celebrity Problem
```
Elon Musk posts something
He has 180 million followers
Fan-out to 180M feeds = VERY SLOW!

Solution: Hybrid approach for celebrities
(See Design 4)
```

### Fan-out Time Analysis
```
Followers    Fan-out Time
─────────────────────────────
100          ~10ms
1,000        ~100ms
10,000       ~1 second
1,000,000    ~100 seconds ❌

Celebrities break fan-out-on-write!
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('Post Service', 'Application Services', 200, 250),
      _createIcon('Fan-out Service', 'Application Services', 400, 250),
      _createIcon('Follower Index', 'Database & Storage', 400, 450),
      _createIcon('Feed Cache', 'Caching,Performance', 600, 250),
      _createIcon('Post Store', 'Database & Storage', 600, 450),
    ],
    'connections': [
      _createConnection(0, 1, label: 'New Post'),
      _createConnection(1, 2, label: 'Fan Out'),
      _createConnection(2, 3, label: 'Get Followers'),
      _createConnection(2, 4, label: 'Write Feeds'),
      _createConnection(1, 5, label: 'Store Post'),
      _createConnection(0, 4, label: 'Read Feed'),
    ],
  };

  // DESIGN 3: Fan-out on Read
  static Map<String, dynamic> get fanoutReadArchitecture => {
    'name': 'Fan-out on Read',
    'description': 'Compute feed when user requests it',
    'explanation': '''
## Fan-out on Read Architecture

### What This System Does
Instead of pre-computing feeds (expensive for celebrities), we compute the feed when the user requests it. Good for users who follow celebrities.

### How It Works Step-by-Step

**Step 1: Post Created Simply**
Bob posts → Just store in Posts table.
No fan-out, no extra work.
Post creation is instant.

**Step 2: User Requests Feed**
Alice opens app, requests her feed.

**Step 3: Get Following List**
Fetch who Alice follows:
```json
["bob", "carol", "celebrity_with_10M_followers"]
```

**Step 4: Fetch Recent Posts**
For each followed user, get their recent posts:
- Parallel requests to each user's posts
- Or single query with IN clause

**Step 5: Merge and Rank**
Combine all posts, sort by relevance:
- Time-based sorting
- Or ML-based ranking

**Step 6: Return Feed**
Send merged feed to client.

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Feed Service | Computes feed on request | Core logic |
| Post Cache | Caches recent posts | Speed up reads |
| Follow Service | Gets following list | Relationships |
| Merge Engine | Combines and sorts | Final feed |
| Ranking Service | Scores posts | Relevance |

### Read Time Analysis
```
Following    Read Time
─────────────────────────────
10           ~50ms ✓
100          ~200ms ✓
500          ~1 second ❌
1000         ~2 seconds ❌

Too slow for users following many people!
```

### When to Use
```
Good for:
- Users following few accounts
- Celebrity accounts (no fan-out needed)
- Apps with more writes than reads

Bad for:
- Users following hundreds of accounts
- Apps where users refresh constantly
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('Feed Service', 'Application Services', 250, 350),
      _createIcon('Follow Service', 'Application Services', 450, 200),
      _createIcon('Post Cache', 'Caching,Performance', 450, 350),
      _createIcon('Merge Engine', 'Data Processing', 450, 500),
      _createIcon('Post Store', 'Database & Storage', 650, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Get Feed'),
      _createConnection(1, 2, label: 'Following'),
      _createConnection(1, 3, label: 'Posts'),
      _createConnection(3, 5, label: 'Fetch'),
      _createConnection(2, 4, label: 'Merge'),
      _createConnection(3, 4, label: 'Merge'),
      _createConnection(4, 0, label: 'Feed'),
    ],
  };

  // DESIGN 4: Hybrid Approach
  static Map<String, dynamic> get hybridArchitecture => {
    'name': 'Hybrid Approach',
    'description': 'Fan-out on write for regular users, read for celebrities',
    'explanation': '''
## Hybrid News Feed Architecture

### What This System Does
Combines both approaches: Fan-out on write for regular users, fan-out on read for celebrities. Best of both worlds!

### How It Works Step-by-Step

**Step 1: Classify Users**
When user gains followers:
- < 10K followers: Regular user
- ≥ 10K followers: Celebrity

**Step 2: Regular User Posts**
Bob (1000 followers) posts:
- Fan out to all 1000 followers' feeds
- Just like fan-out on write

**Step 3: Celebrity Posts**
Taylor (50M followers) posts:
- DO NOT fan out (too expensive)
- Just store post with "celebrity" flag

**Step 4: User Requests Feed**
When Alice requests feed:
1. Read her pre-computed feed (from regular users)
2. Separately fetch celebrity posts she follows
3. Merge both lists

**Step 5: Merge at Read Time**
```
Pre-computed: [bob_post, carol_post, dave_post]
Celebrity live: [taylor_post, kim_post]
Merged: [taylor_post, bob_post, kim_post, carol_post, ...]
```

**Step 6: Cache Celebrity Posts**
Popular celebrity posts cached heavily:
- CDN for content
- Redis for metadata
- Reduces database load

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| User Classifier | Identifies celebrities | Route differently |
| Fan-out Service | For regular users | Pre-compute |
| Celebrity Cache | Caches popular posts | Fast reads |
| Merge Service | Combines feeds | Final assembly |
| Feed Cache | Pre-computed feeds | Regular users |

### Decision Logic
```python
def on_new_post(post, author):
    if author.followers < 10000:
        # Fan out on write
        fan_out_to_all_followers(post)
    else:
        # Celebrity - just store
        store_with_celebrity_flag(post)

def get_feed(user):
    regular_posts = read_cached_feed(user)
    celebrity_posts = fetch_celebrity_posts(user.following_celebrities)
    return merge_and_rank(regular_posts, celebrity_posts)
```

### Twitter's Approach
```
Twitter uses this hybrid:
- 99% users: Fan-out on write
- 1% celebrities: Fan-out on read

When you open Twitter:
- Read pre-computed timeline
- Inject latest celebrity tweets
- Merge in real-time
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('User Classifier', 'Data Processing', 200, 200),
      _createIcon('Fan-out Service', 'Application Services', 400, 200),
      _createIcon('Feed Cache', 'Caching,Performance', 600, 200),
      _createIcon('Celebrity Cache', 'Caching,Performance', 400, 500),
      _createIcon('Merge Service', 'Data Processing', 600, 350),
      _createIcon('Post Store', 'Database & Storage', 800, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Post'),
      _createConnection(1, 2, label: 'Regular'),
      _createConnection(1, 4, label: 'Celebrity'),
      _createConnection(2, 3, label: 'Write'),
      _createConnection(0, 5, label: 'Read'),
      _createConnection(3, 5, label: 'Cached'),
      _createConnection(4, 5, label: 'Live'),
      _createConnection(5, 6, label: 'Fetch'),
    ],
  };

  // DESIGN 5: Ranked Feed with ML
  static Map<String, dynamic> get rankedFeedArchitecture => {
    'name': 'Ranked Feed with ML',
    'description': 'ML-powered relevance ranking',
    'explanation': '''
## Ranked Feed with ML Architecture

### What This System Does
Instead of chronological order, use machine learning to show the most relevant posts first. Facebook, Instagram, and TikTok all do this.

### How It Works Step-by-Step

**Step 1: Collect Candidates**
Gather potential posts for user's feed:
- Posts from followed accounts
- Suggested posts
- Ads
- Typically 500-1000 candidates

**Step 2: Extract Features**
For each post, compute features:
```json
{
  "post_age_hours": 2.5,
  "author_interaction_score": 0.8,
  "post_engagement_rate": 0.15,
  "content_type": "image",
  "is_from_close_friend": true,
  "user_interest_match": 0.7
}
```

**Step 3: User Features**
User's preferences and behavior:
```json
{
  "prefers_images": true,
  "active_time_of_day": "evening",
  "engagement_rate": 0.3,
  "close_friends": ["bob", "carol"]
}
```

**Step 4: ML Model Scores**
Model predicts probability of engagement:
```
Post A: P(like) = 0.85, P(comment) = 0.12
Post B: P(like) = 0.45, P(comment) = 0.02
Post C: P(like) = 0.92, P(comment) = 0.25

Final score = weighted combination
```

**Step 5: Rank and Diversify**
Sort by score, but add diversity:
- Don't show 10 posts from same author
- Mix content types
- Spread ads evenly

**Step 6: A/B Testing**
Continuously improve:
- Test different ranking formulas
- Measure user engagement
- Update model weights

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Candidate Generator | Gets potential posts | Raw material |
| Feature Extractor | Computes features | Model input |
| ML Ranker | Scores posts | Relevance |
| Diversity Filter | Prevents monotony | User experience |
| A/B Test Framework | Experiments | Improvement |

### Common Features for Ranking
```
Post Features:
- Age, engagement rate, content type
- Author's overall popularity
- Comments, likes, shares

User Features:
- Past interactions with author
- Content type preferences
- Active times

Contextual:
- Time of day
- Device type
- Session length
```

### Ranking Formula Example
```python
score = (
    0.3 * author_interaction_score +
    0.2 * content_type_preference +
    0.2 * engagement_prediction +
    0.15 * recency_score +
    0.1 * social_proof_score +
    0.05 * diversity_bonus
)
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('Candidate Generator', 'Application Services', 200, 350),
      _createIcon('Feature Extractor', 'Data Processing', 400, 200),
      _createIcon('User Features', 'Database & Storage', 400, 350),
      _createIcon('ML Ranker', 'Data Processing', 600, 350),
      _createIcon('Diversity Filter', 'Data Processing', 800, 350),
      _createIcon('A/B Service', 'Application Services', 600, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Request'),
      _createConnection(1, 2, label: 'Posts'),
      _createConnection(1, 3, label: 'User'),
      _createConnection(2, 4, label: 'Features'),
      _createConnection(3, 4, label: 'Features'),
      _createConnection(4, 5, label: 'Ranked'),
      _createConnection(5, 0, label: 'Feed'),
      _createConnection(6, 4, label: 'Experiment'),
    ],
  };

  // DESIGN 6: Real-time Feed Updates
  static Map<String, dynamic> get realtimeArchitecture => {
    'name': 'Real-time Feed Updates',
    'description': 'Push new posts to users instantly',
    'explanation': '''
## Real-time Feed Updates Architecture

### What This System Does
Instead of users refreshing to see new posts, push new posts to them instantly. Like Twitter's "X new posts" notification.

### How It Works Step-by-Step

**Step 1: User Opens App**
User connects via WebSocket:
```javascript
ws.connect("wss://feed.app.com/stream")
ws.send({ type: "subscribe", user_id: "alice" })
```

**Step 2: Connection Registered**
Presence Service tracks connected users:
```
alice: connected to server-5
bob: connected to server-12
carol: offline
```

**Step 3: New Post Created**
Bob posts something.
Post Service publishes event:
```json
{
  "type": "new_post",
  "author": "bob",
  "post_id": "123"
}
```

**Step 4: Find Online Followers**
Stream Service queries:
- Who follows Bob?
- Who is currently online?
- Intersection: [alice, dave]

**Step 5: Push to Connected Users**
Send update via WebSocket:
```javascript
// To Alice's connection
ws.send({ 
  type: "new_post_notification",
  author: "bob",
  preview: "Check out my..."
})
```

**Step 6: Client Updates UI**
App shows notification:
- "1 new post" banner at top
- User taps to refresh feed
- New post appears instantly

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| WebSocket Server | Maintains connections | Real-time |
| Presence Service | Tracks online users | Target delivery |
| Stream Service | Routes updates | Distribution |
| Pub/Sub | Message broadcast | Scale |
| Connection Registry | Maps users to servers | Routing |

### Connection Management
```
Challenges:
- Millions of concurrent connections
- Users reconnect frequently
- Mobile connections unstable

Solutions:
- Sticky sessions to same server
- Automatic reconnection
- Fallback to polling
- Connection heartbeats
```

### Pub/Sub for Scale
```
Without Pub/Sub:
Bob posts → Server 5 notifies followers
But Alice is on Server 12!

With Pub/Sub (Redis):
Bob posts → Publish to "bob_posts" channel
All servers subscribe → Each notifies local users
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('WebSocket Server', 'Networking', 200, 350),
      _createIcon('Presence Service', 'Application Services', 400, 200),
      _createIcon('Post Service', 'Application Services', 400, 350),
      _createIcon('Stream Service', 'Application Services', 400, 500),
      _createIcon('Pub/Sub', 'Message Systems', 600, 350),
      _createIcon('Connection Registry', 'Caching,Performance', 600, 500),
    ],
    'connections': [
      _createConnection(0, 1, label: 'WebSocket'),
      _createConnection(1, 2, label: 'Online'),
      _createConnection(3, 5, label: 'New Post'),
      _createConnection(5, 4, label: 'Event'),
      _createConnection(2, 4, label: 'Who Online'),
      _createConnection(4, 6, label: 'Find Conn'),
      _createConnection(4, 1, label: 'Push'),
    ],
  };

  // DESIGN 7: Notification System
  static Map<String, dynamic> get notificationArchitecture => {
    'name': 'Notification System',
    'description': 'Push notifications for likes, comments, mentions',
    'explanation': '''
## Notification System Architecture

### What This System Does
When someone likes your post, comments, or mentions you, you get a notification. This system handles all notification types and delivery channels.

### How It Works Step-by-Step

**Step 1: Action Occurs**
Bob likes Alice's photo.
Event generated:
```json
{
  "type": "like",
  "actor": "bob",
  "target_user": "alice",
  "object": "photo_123"
}
```

**Step 2: Notification Created**
Notification Service creates record:
```json
{
  "id": "notif_456",
  "user": "alice",
  "type": "like",
  "message": "Bob liked your photo",
  "read": false,
  "created_at": 1642000000
}
```

**Step 3: Aggregation**
Multiple similar notifications grouped:
```
"Bob and 5 others liked your photo"
Instead of 6 separate notifications
```

**Step 4: Delivery Routing**
Check user's preferences:
- In-app: Always
- Push notification: If not active
- Email: Daily digest only
- SMS: Critical only

**Step 5: Push to Device**
Send via APNS (iOS) or FCM (Android):
```json
{
  "to": "device_token_xyz",
  "notification": {
    "title": "New Like",
    "body": "Bob liked your photo"
  }
}
```

**Step 6: Track Delivery**
Monitor notification status:
- Sent, delivered, opened
- Optimize timing for engagement
- Honor do-not-disturb

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Event Collector | Captures actions | Source events |
| Notification Service | Creates notifications | Core logic |
| Aggregator | Groups similar | Reduce noise |
| Router | Decides channels | User preferences |
| Push Service | Sends to devices | Mobile delivery |
| Email Service | Sends emails | Digest/alerts |

### Notification Types
```
Type          Priority    Default Delivery
──────────────────────────────────────────────
Mention       High        Push + In-app
Comment       Medium      Push + In-app
Like          Low         In-app only
Follower      Low         In-app only
Friend post   Low         In-app only
```

### Aggregation Rules
```
Within 1 hour:
- Multiple likes → "X and Y others liked"
- Multiple follows → "X and Y others followed"

Different rules per type:
- Comments: Never aggregate (each unique)
- Likes: Aggregate after 2
- Follows: Aggregate after 5
```
''',
    'icons': [
      _createIcon('Event Collector', 'Data Processing', 50, 350),
      _createIcon('Notification Service', 'Application Services', 200, 350),
      _createIcon('Aggregator', 'Data Processing', 400, 350),
      _createIcon('Router', 'Networking', 600, 350),
      _createIcon('Push Service', 'Application Services', 800, 200),
      _createIcon('Email Service', 'Application Services', 800, 350),
      _createIcon('SMS Service', 'Application Services', 800, 500),
      _createIcon('Notification Store', 'Database & Storage', 400, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Event'),
      _createConnection(1, 2, label: 'Create'),
      _createConnection(2, 7, label: 'Store'),
      _createConnection(2, 3, label: 'Route'),
      _createConnection(3, 4, label: 'Push'),
      _createConnection(3, 5, label: 'Email'),
      _createConnection(3, 6, label: 'SMS'),
    ],
  };

  // DESIGN 8: Feed Caching Strategy
  static Map<String, dynamic> get cachingArchitecture => {
    'name': 'Feed Caching Strategy',
    'description': 'Multi-layer caching for fast feed delivery',
    'explanation': '''
## Feed Caching Strategy Architecture

### What This System Does
Reading from database for every feed request is slow. This system uses multiple cache layers to serve feeds in milliseconds.

### How It Works Step-by-Step

**Step 1: Request Arrives**
Alice opens app, requests feed.

**Step 2: Check Edge Cache (CDN)**
CDN has cached feeds for anonymous/public content.
Not useful for personalized feeds.

**Step 3: Check Application Cache**
Local in-memory cache on app server:
- Very fast (microseconds)
- Limited size
- Contains recent requests

**Step 4: Check Distributed Cache (Redis)**
User's feed cached in Redis:
```
LRANGE alice_feed 0 19
→ ["post_1", "post_2", ..., "post_20"]
```

**Step 5: Cache Miss → Compute**
If not in cache:
- Compute feed (fan-out on read)
- Store in Redis for next time
- Set TTL (e.g., 5 minutes)

**Step 6: Warm Cache on Post**
When new post created:
- Invalidate affected feeds
- Or append to cached feeds
- Keep cache fresh

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| CDN | Edge caching | Static content |
| App Cache | In-memory local | Hot data |
| Redis Cluster | Distributed cache | Shared state |
| Cache Warmer | Pre-populates cache | Cold start |
| Invalidator | Clears stale data | Consistency |

### Cache Hierarchy
```
Layer          Latency    Size      Scope
───────────────────────────────────────────
L1 (App)       <1ms       1GB       Per server
L2 (Redis)     1-5ms      100GB     Shared
L3 (DB)        10-50ms    10TB      Persistent

Request path: L1 → L2 → L3
```

### Cache Keys
```
Feed cache:
feed:{user_id}:latest → [post_ids]
feed:{user_id}:page:{n} → [post_ids]

Post cache:
post:{post_id} → {title, content, author...}

User cache:
user:{user_id} → {name, avatar, followers...}
```

### Invalidation Strategies
```
1. TTL-based:
   - Feed expires every 5 minutes
   - Simple but can be stale

2. Event-based:
   - New post → Invalidate followers' feeds
   - More complex but fresher

3. Append-only:
   - New post → Prepend to cached feed
   - Never invalidate, just update
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('CDN', 'Networking', 200, 350),
      _createIcon('App Cache', 'Caching,Performance', 400, 200),
      _createIcon('Redis Cluster', 'Caching,Performance', 400, 350),
      _createIcon('Feed Service', 'Application Services', 400, 500),
      _createIcon('Cache Warmer', 'System Utilities', 600, 200),
      _createIcon('Database', 'Database & Storage', 600, 450),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Request'),
      _createConnection(1, 2, label: 'Check L1'),
      _createConnection(2, 3, label: 'Check L2'),
      _createConnection(3, 4, label: 'Miss'),
      _createConnection(4, 6, label: 'Fetch'),
      _createConnection(4, 3, label: 'Populate'),
      _createConnection(5, 3, label: 'Warm'),
    ],
  };

  // DESIGN 9: Analytics and Metrics
  static Map<String, dynamic> get analyticsArchitecture => {
    'name': 'Analytics and Metrics',
    'description': 'Tracking engagement and feed performance',
    'explanation': '''
## Analytics and Metrics Architecture

### What This System Does
Measure everything: what users see, what they engage with, how long they stay. This data improves the ranking algorithm and product decisions.

### How It Works Step-by-Step

**Step 1: Impression Logged**
When post appears on screen:
```json
{
  "event": "impression",
  "user": "alice",
  "post": "123",
  "position": 3,
  "timestamp": 1642000000
}
```

**Step 2: Engagement Logged**
When user interacts:
```json
{
  "event": "like",
  "user": "alice",
  "post": "123",
  "time_to_engage": 5.2
}
```

**Step 3: Events Streamed**
All events sent to Kafka:
- High throughput (millions/second)
- Durable for replay
- Partitioned by user

**Step 4: Real-time Processing**
Stream processor computes live metrics:
- Active users right now
- Trending posts
- Engagement rates

**Step 5: Batch Analytics**
Daily/weekly jobs compute:
- Daily active users
- Average session length
- Feed completion rate
- A/B test results

**Step 6: Dashboard & Alerts**
Metrics displayed and monitored:
- Real-time dashboards
- Alerts on anomalies
- Reports for product team

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Event Collector | Captures all events | Data source |
| Kafka | Event streaming | Scale & durability |
| Stream Processor | Real-time metrics | Live data |
| Batch Processor | Historical analytics | Deep analysis |
| Data Warehouse | Stores all data | Query & report |
| Dashboard | Visualizes metrics | Decision making |

### Key Metrics
```
Engagement:
- Likes per post, comments per post
- Engagement rate (actions / impressions)
- Time to first engagement

Feed Health:
- Feed completion rate (% who scroll to end)
- Time spent in feed
- Posts seen per session

Ranking Quality:
- Click-through rate by position
- Engagement vs. prediction
- A/B test lift
```

### Event Volume
```
100M daily active users
Average 50 impressions per session
2 sessions per day

= 10 billion impressions/day
+ billions of actions

Need serious scale!
```
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 350),
      _createIcon('Event Collector', 'Data Processing', 200, 350),
      _createIcon('Kafka', 'Message Systems', 400, 350),
      _createIcon('Stream Processor', 'Data Processing', 600, 200),
      _createIcon('Batch Processor', 'Data Processing', 600, 500),
      _createIcon('Data Warehouse', 'Database & Storage', 800, 350),
      _createIcon('Dashboard', 'Client & Interface', 950, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Events'),
      _createConnection(1, 2, label: 'Stream'),
      _createConnection(2, 3, label: 'Real-time'),
      _createConnection(2, 4, label: 'Batch'),
      _createConnection(3, 5, label: 'Store'),
      _createConnection(4, 5, label: 'Store'),
      _createConnection(5, 6, label: 'Query'),
    ],
  };

  // DESIGN 10: Complete News Feed System
  static Map<String, dynamic> get completeArchitecture => {
    'name': 'Complete News Feed System',
    'description': 'Full-featured social media feed',
    'explanation': '''
## Complete News Feed System Architecture

### What This System Does
This is a production news feed combining: hybrid fan-out, ML ranking, real-time updates, notifications, caching, and analytics. Think Facebook or Twitter scale.

### How It Works Step-by-Step

**Step 1: Post Created**
User creates post → Stored → Fan-out begins (hybrid approach)

**Step 2: Feed Requested**
User opens app → Check cache → Merge regular + celebrity → ML rank → Return

**Step 3: Real-time Updates**
New posts → Push to online users → "N new posts" notification

**Step 4: Engagement**
User likes/comments → Create notification → Update analytics

**Step 5: Continuous Improvement**
Analytics → Train ML → Better ranking → Happier users

### Full Component List

| Category | Components |
|----------|------------|
| Client | Mobile App, Web App |
| Ingestion | Post Service, Media Service |
| Distribution | Fan-out, Merge, Cache |
| Ranking | ML Model, Feature Store |
| Real-time | WebSocket, Pub/Sub |
| Engagement | Likes, Comments, Shares |
| Notifications | Push, Email, In-app |
| Analytics | Events, Metrics, Dashboard |
| Storage | Posts, Feeds, Social Graph |

### Scale Numbers
```
Daily Active Users: 100 million
Posts per day: 50 million
Feed reads per day: 500 million
Notifications per day: 2 billion
Cache hit rate: 95%
Feed latency: <200ms (p99)
```

### Architecture Principles
1. **Hybrid Fan-out**: Balance write and read
2. **Cache Everything**: Feeds, posts, users
3. **Rank Smart**: ML-powered relevance
4. **Push Updates**: Real-time experience
5. **Measure All**: Data-driven decisions
''',
    'icons': [
      _createIcon('Mobile App', 'Client & Interface', 50, 200),
      _createIcon('Web App', 'Client & Interface', 50, 400),
      _createIcon('API Gateway', 'Networking', 200, 300),
      _createIcon('Post Service', 'Application Services', 400, 150),
      _createIcon('Feed Service', 'Application Services', 400, 300),
      _createIcon('Notification Service', 'Application Services', 400, 450),
      _createIcon('Redis Cache', 'Caching,Performance', 600, 200),
      _createIcon('ML Ranker', 'Data Processing', 600, 350),
      _createIcon('Post Store', 'Database & Storage', 800, 200),
      _createIcon('Social Graph', 'Database & Storage', 800, 350),
      _createIcon('Analytics Engine', 'Data Processing', 800, 500),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Request'),
      _createConnection(1, 2, label: 'Request'),
      _createConnection(2, 3, label: 'Create'),
      _createConnection(2, 4, label: 'Feed'),
      _createConnection(3, 8, label: 'Store'),
      _createConnection(4, 6, label: 'Cache'),
      _createConnection(4, 7, label: 'Rank'),
      _createConnection(4, 9, label: 'Graph'),
      _createConnection(5, 0, label: 'Push'),
      _createConnection(4, 10, label: 'Events'),
    ],
  };

  static List<Map<String, dynamic>> getAllDesigns() {
    return [
      basicArchitecture,
      fanoutWriteArchitecture,
      fanoutReadArchitecture,
      hybridArchitecture,
      rankedFeedArchitecture,
      realtimeArchitecture,
      notificationArchitecture,
      cachingArchitecture,
      analyticsArchitecture,
      completeArchitecture,
    ];
  }

  static List<Map<String, dynamic>> connectionsToLines(
    Map<String, dynamic> design,
  ) {
    final icons = design['icons'] as List<dynamic>;
    final connections = design['connections'] as List<dynamic>;
    final lines = <Map<String, dynamic>>[];
    for (final conn in connections) {
      final fromIndex = conn['fromIconIndex'] as int;
      final toIndex = conn['toIconIndex'] as int;
      if (fromIndex >= 0 &&
          fromIndex < icons.length &&
          toIndex >= 0 &&
          toIndex < icons.length) {
        final fromIcon = icons[fromIndex] as Map<String, dynamic>;
        final toIcon = icons[toIndex] as Map<String, dynamic>;
        const iconSize = 70.0;
        lines.add({
          'startX': (fromIcon['positionX'] as num).toDouble() + iconSize / 2,
          'startY': (fromIcon['positionY'] as num).toDouble() + iconSize / 2,
          'endX': (toIcon['positionX'] as num).toDouble() + iconSize / 2,
          'endY': (toIcon['positionY'] as num).toDouble() + iconSize / 2,
          'color': conn['color'] ?? 0xFF3F51B5,
          'strokeWidth': conn['strokeWidth'] ?? 2.0,
          'label': conn['label'],
        });
      }
    }
    return lines;
  }
}
