// Pastebin System - Canvas Design Data
// Contains predefined system designs using available canvas icons

import 'package:flutter/material.dart';
import 'system_design_icons.dart';

/// Provides predefined Pastebin system designs for the canvas
class PastebinCanvasDesigns {
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
    int color = 0xFF795548,
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

  // DESIGN 1: Basic Pastebin
  static Map<String, dynamic> get basicArchitecture => {
    'name': 'Basic Pastebin',
    'description': 'Simple text sharing with unique URLs',
    'explanation': '''
## Basic Pastebin Architecture

### What This System Does
Pastebin lets users share text snippets via unique URLs. User pastes code, gets a link like paste.io/abc123, shares it, anyone with the link can view the content.

### How It Works Step-by-Step

**Step 1: User Submits Paste**
User types or pastes text into the web form:
- Content: "function hello() { return 'world'; }"
- Options: Expiration (1 hour, 1 day, never)
- Optional: Syntax highlighting (JavaScript)

**Step 2: Server Generates Unique ID**
The Paste Service generates a short, unique ID:
- Method 1: Random string (abc123)
- Method 2: Base62 encoded counter
- Length: 6-8 characters = billions of combinations

**Step 3: Content Stored**
The paste is stored in the database:
```json
{
  "id": "abc123",
  "content": "function hello()...",
  "created_at": 1642000000,
  "expires_at": 1642086400,
  "syntax": "javascript",
  "views": 0
}
```

**Step 4: URL Returned**
User receives the shareable URL:
- https://paste.io/abc123
- Can be copied and shared immediately

**Step 5: Viewer Requests Paste**
Someone visits https://paste.io/abc123:
- Server looks up ID in database
- Checks if expired
- Returns content with syntax highlighting

**Step 6: Expiration Cleanup**
Background job runs periodically:
- Find all pastes where expires_at < now
- Delete expired pastes
- Reclaim storage space

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Web Client | User interface | Create and view pastes |
| Paste Service | Core paste logic | Business logic |
| ID Generator | Creates unique IDs | URL generation |
| Database | Stores paste content | Persistence |
| Cleanup Job | Removes expired pastes | Storage management |
| Syntax Highlighter | Formats code | Readability |

### ID Generation Strategies
```
Strategy        Example      Collisions    Predictable
───────────────────────────────────────────────────────
Random          "xK9mPq"     Possible      No
Counter+Base62  "1a2B"       Never         Yes (bad)
UUID (short)    "a1b2c3d4"   Very rare     No
Hashids         "NkKQ9"      Never         No
```

### Storage Calculation
```
Average paste size: 5 KB
Pastes per day: 100,000
Storage per day: 500 MB
Storage per year: 180 GB
With compression: ~60 GB
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('API Gateway', 'Networking', 250, 350),
      _createIcon('Paste Service', 'Application Services', 450, 350),
      _createIcon('ID Generator', 'System Utilities', 450, 550),
      _createIcon('SQL Database', 'Database & Storage', 650, 350),
      _createIcon('Cleanup Job', 'System Utilities', 650, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Create Paste'),
      _createConnection(1, 2, label: 'Process'),
      _createConnection(2, 3, label: 'Generate ID'),
      _createConnection(2, 4, label: 'Store'),
      _createConnection(5, 4, label: 'Delete Expired'),
    ],
  };

  // DESIGN 2: Scalable Pastebin
  static Map<String, dynamic> get scalableArchitecture => {
    'name': 'Scalable Pastebin',
    'description': 'High-traffic pastebin with caching and CDN',
    'explanation': '''
## Scalable Pastebin Architecture

### What This System Does
When a paste goes viral (linked on Reddit/HN), it might get millions of views. This architecture handles massive read traffic through caching and CDN.

### How It Works Step-by-Step

**Step 1: Paste Created Normally**
User creates paste as before. Content stored in database.

**Step 2: First View Triggers Cache**
When first viewer accesses the paste:
- Check cache (miss)
- Fetch from database
- Store in Redis cache
- Return to user

**Step 3: Subsequent Views Hit Cache**
All following requests:
- Check cache (hit!)
- Return immediately
- Database not touched
- 10x faster, less DB load

**Step 4: Popular Pastes Hit CDN**
For extremely popular pastes:
- Content pushed to CDN edge servers
- Viewers served from nearest CDN node
- Origin server barely touched

**Step 5: Write-through Caching**
When paste is created:
- Write to database
- Also write to cache immediately
- Cache always has latest data

**Step 6: Cache Invalidation on Expiry**
When paste expires:
- Database record deleted
- Cache entry invalidated
- CDN cache purged

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Load Balancer | Distributes traffic | Handle spikes |
| Redis Cache | In-memory storage | Fast reads |
| CDN | Edge caching | Global performance |
| Database Cluster | Replicated storage | Durability |
| Cache Warmer | Pre-populates cache | Reduce cold starts |

### Read Path Optimization
```
Request: GET /abc123

1. Check CDN edge cache → Hit? Return (5ms)
2. Check Redis cache → Hit? Return (10ms)
3. Check database → Return (50ms)

Most requests served in <10ms
```

### Cache Hit Rates
```
Scenario          Cache Hit Rate
──────────────────────────────────
Normal traffic    70-80%
Viral paste       95-99%
Just created      0% (cold)
After warmup      90%+
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('CDN', 'Networking', 200, 350),
      _createIcon('Global Load Balancer', 'Networking', 400, 350),
      _createIcon('Paste Service', 'Application Services', 600, 250),
      _createIcon('Redis', 'Caching,Performance', 600, 450),
      _createIcon('SQL Database', 'Database & Storage', 800, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Request'),
      _createConnection(1, 2, label: 'Cache Miss'),
      _createConnection(2, 3, label: 'Route'),
      _createConnection(3, 4, label: 'Check Cache'),
      _createConnection(4, 5, label: 'Cache Miss'),
      _createConnection(3, 5, label: 'Store'),
    ],
  };

  // DESIGN 3: Content Moderation
  static Map<String, dynamic> get moderationArchitecture => {
    'name': 'Content Moderation',
    'description': 'Detecting and removing harmful content',
    'explanation': '''
## Content Moderation Architecture

### What This System Does
Pastebin can be abused for malware, phishing, or illegal content. This system automatically detects and removes harmful pastes while allowing legitimate use.

### How It Works Step-by-Step

**Step 1: Paste Submitted**
User submits paste. Before storing, moderation begins.

**Step 2: Automated Scanning**
Content is analyzed by multiple detectors:
- Malware signatures (virus patterns)
- Phishing keywords (account, password, verify)
- Personal data (SSN, credit card patterns)
- Banned domains (known malicious URLs)
- Profanity filter (configurable)

**Step 3: Risk Score Calculated**
Each detector returns a score:
- Malware detector: 0.9 (high risk)
- Phishing detector: 0.1 (low)
- Combined score: 0.7 (concerning)

**Step 4: Decision Made**
Based on score:
- Score < 0.3: Auto-approve
- Score 0.3-0.7: Flag for human review
- Score > 0.7: Auto-reject

**Step 5: Human Review Queue**
Flagged pastes go to moderators:
- View content and context
- Approve, reject, or escalate
- Feedback improves ML models

**Step 6: Takedown System**
If illegal content found later:
- DMCA/legal requests processed
- Content removed immediately
- IP/account may be banned

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Scan Service | Runs all detectors | Multi-layer check |
| Malware Scanner | Virus/malware patterns | Security |
| PII Detector | Personal data detection | Privacy |
| URL Scanner | Check linked domains | Phishing prevention |
| Review Queue | Human moderation | Accuracy |
| Ban Service | Block bad actors | Repeat offenders |

### Detection Patterns
```
Pattern Type      Examples
─────────────────────────────────────
Malware           "eval(base64_decode", ".exe download"
Phishing          "verify your account", "login expired"
PII               SSN: XXX-XX-XXXX, Credit card patterns
Spam              Repeated URLs, lottery scams
```

### False Positive Handling
```
Legitimate code might trigger detectors:
- "password" in a tutorial about auth
- eval() in JavaScript examples

Solutions:
1. Context-aware detection
2. User reputation scoring
3. Human review for edge cases
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('API Gateway', 'Networking', 200, 350),
      _createIcon('Scan Service', 'Security,Monitoring', 400, 350),
      _createIcon('Malware Scanner', 'Security,Monitoring', 600, 200),
      _createIcon('PII Detector', 'Security,Monitoring', 600, 350),
      _createIcon('URL Scanner', 'Security,Monitoring', 600, 500),
      _createIcon('Review Queue', 'Application Services', 800, 350),
      _createIcon('Ban Service', 'Security,Monitoring', 800, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Submit'),
      _createConnection(1, 2, label: 'Scan'),
      _createConnection(2, 3, label: 'Check'),
      _createConnection(2, 4, label: 'Check'),
      _createConnection(2, 5, label: 'Check'),
      _createConnection(3, 6, label: 'Flag'),
      _createConnection(4, 6, label: 'Flag'),
      _createConnection(6, 7, label: 'Ban'),
    ],
  };

  // DESIGN 4: Syntax Highlighting System
  static Map<String, dynamic> get syntaxHighlightingArchitecture => {
    'name': 'Syntax Highlighting System',
    'description': 'Server and client-side code formatting',
    'explanation': '''
## Syntax Highlighting System Architecture

### What This System Does
Code pastes look better with syntax highlighting - keywords in blue, strings in green, comments in gray. This system detects languages and applies appropriate highlighting.

### How It Works Step-by-Step

**Step 1: User Selects Language (or Auto-detect)**
User can specify language or let system guess:
- Explicit: "JavaScript"
- Auto-detect from content patterns

**Step 2: Language Detection**
If auto-detect, the Detector analyzes:
- File extension hints (if provided)
- Keywords: "def", "function", "public class"
- Syntax patterns: indentation, brackets
- Common library names

**Step 3: Tokenizer Parses Code**
The Tokenizer breaks code into tokens:
```javascript
function hello() { return "world"; }
→ [KEYWORD:function, IDENTIFIER:hello, LPAREN, RPAREN, 
   LBRACE, KEYWORD:return, STRING:"world", SEMICOLON, RBRACE]
```

**Step 4: Highlighter Applies Styles**
Each token type maps to a color:
- KEYWORD → blue
- STRING → green
- COMMENT → gray
- IDENTIFIER → default

**Step 5: Output as HTML**
Result is HTML with styled spans:
```html
<span class="keyword">function</span> 
<span class="identifier">hello</span>() { 
  <span class="keyword">return</span> 
  <span class="string">"world"</span>; 
}
```

**Step 6: Client-side Rendering**
CSS provides the actual colors. Different themes available (dark mode, light mode, etc.)

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Language Detector | Identifies programming language | Auto-detection |
| Tokenizer | Parses into tokens | Syntax analysis |
| Highlighter | Applies color styles | Visual formatting |
| Theme Engine | Provides color schemes | Customization |
| Line Numberer | Adds line numbers | Navigation |

### Supported Languages
```
Popular: JavaScript, Python, Java, C++, Go, Rust
Web: HTML, CSS, JSON, YAML, XML
Systems: C, Assembly, Shell, PowerShell
Data: SQL, GraphQL, Markdown
And 100+ more...
```

### Performance Optimization
```
Strategy              When to Use
─────────────────────────────────────
Server-side render    Small pastes (<1MB)
Client-side render    Large pastes (offload server)
Virtual scrolling     Very large (>10k lines)
Lazy highlighting     Huge files (only visible)
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('Paste Service', 'Application Services', 250, 350),
      _createIcon('Language Detector', 'Data Processing', 450, 200),
      _createIcon('Tokenizer', 'Data Processing', 450, 350),
      _createIcon('Highlighter', 'Application Services', 450, 500),
      _createIcon('Theme Engine', 'Application Services', 650, 350),
      _createIcon('Cache', 'Caching,Performance', 650, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'View Paste'),
      _createConnection(1, 2, label: 'Detect'),
      _createConnection(2, 3, label: 'Tokenize'),
      _createConnection(3, 4, label: 'Highlight'),
      _createConnection(4, 5, label: 'Theme'),
      _createConnection(4, 6, label: 'Cache'),
      _createConnection(5, 0, label: 'Render'),
    ],
  };

  // DESIGN 5: Private and Encrypted Pastes
  static Map<String, dynamic> get encryptedArchitecture => {
    'name': 'Private and Encrypted Pastes',
    'description': 'Password protection and end-to-end encryption',
    'explanation': '''
## Private and Encrypted Pastes Architecture

### What This System Does
Some pastes contain sensitive info. This system provides password protection and client-side encryption where even the server can't read the content.

### How It Works Step-by-Step

**Step 1: User Chooses Privacy Level**
Options:
- Public: Anyone with URL
- Unlisted: URL only (not searchable)
- Password: Requires password to view
- Encrypted: End-to-end encrypted

**Step 2: Password Protection**
If password chosen:
- User sets password: "secret123"
- Server stores hash: bcrypt("secret123")
- Viewer must enter password to decrypt

**Step 3: End-to-End Encryption**
For maximum security:
- Client generates encryption key
- Content encrypted in browser
- Only encrypted blob sent to server
- Key is in URL fragment (never sent to server!)

**Step 4: URL with Key**
URL format: paste.io/abc123#encryptionKey
- "abc123" sent to server (paste ID)
- "encryptionKey" stays in browser (fragment)
- Server never sees the decryption key

**Step 5: Viewer Decrypts**
Viewer opens URL:
- Browser extracts key from fragment
- Fetches encrypted blob from server
- Decrypts locally in browser
- Server only ever saw encrypted data

**Step 6: Burn After Reading**
Optional one-time view:
- After first successful view
- Paste is immediately deleted
- Guarantees single recipient

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Crypto Service | Client-side encryption | Privacy |
| Password Hasher | Secure password storage | Authentication |
| Burn Service | One-time view management | Security |
| Access Logger | Tracks view attempts | Audit |
| Key Generator | Creates encryption keys | Cryptography |

### Encryption Flow
```
CREATE:
1. Generate AES-256 key in browser
2. Encrypt content with key
3. Send encrypted blob to server
4. Return URL with key in fragment

VIEW:
1. Parse fragment for key
2. Fetch encrypted blob
3. Decrypt with key locally
4. Display plaintext
```

### Security Levels
```
Level         Server Sees     URL Reveals
──────────────────────────────────────────────
Public        Content         Content
Unlisted      Content         Content
Password      Content         Nothing without password
Encrypted     Only blob       Content (key in fragment)
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('Crypto Service', 'Security,Monitoring', 200, 250),
      _createIcon('API Gateway', 'Networking', 200, 450),
      _createIcon('Paste Service', 'Application Services', 400, 350),
      _createIcon('Password Hasher', 'Security,Monitoring', 600, 250),
      _createIcon('Burn Service', 'Application Services', 600, 450),
      _createIcon('Database', 'Database & Storage', 800, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Encrypt'),
      _createConnection(1, 2, label: 'Send Blob'),
      _createConnection(2, 3, label: 'Store'),
      _createConnection(3, 4, label: 'Hash Pass'),
      _createConnection(3, 5, label: 'Burn Flag'),
      _createConnection(3, 6, label: 'Store'),
    ],
  };

  // DESIGN 6: API and Integrations
  static Map<String, dynamic> get apiArchitecture => {
    'name': 'API and Integrations',
    'description': 'Developer API for programmatic paste creation',
    'explanation': '''
## API and Integrations Architecture

### What This System Does
Developers integrate paste functionality into their tools - CLI tools, IDE extensions, chat bots. This system provides a REST API with authentication, rate limiting, and usage tracking.

### How It Works Step-by-Step

**Step 1: Developer Gets API Key**
Developer signs up and creates an API key:
- Key: "pk_live_abc123..."
- Associated with their account
- Can create multiple keys for different apps

**Step 2: API Request Made**
CLI tool creates paste:
```bash
curl -X POST https://api.paste.io/v1/pastes \\
  -H "Authorization: Bearer pk_live_abc123" \\
  -d "content=Hello World" \\
  -d "syntax=text"
```

**Step 3: Rate Limiter Checks**
Before processing:
- Check requests in last minute
- Free tier: 60/minute
- Paid tier: 1000/minute
- Over limit: Return 429 Too Many Requests

**Step 4: Request Processed**
If within limits:
- Create paste as normal
- Return JSON response with URL
- Log usage for billing

**Step 5: Usage Tracked**
Every API call is logged:
- Timestamp, endpoint, response time
- Used for rate limiting
- Used for billing (if paid tier)
- Analytics dashboards

**Step 6: Webhooks Notify**
Optional: Send webhook on paste events:
- Paste created/viewed/expired
- POST to customer's URL
- Enables real-time integrations

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| API Gateway | Routes API requests | Entry point |
| Auth Service | Validates API keys | Security |
| Rate Limiter | Enforces usage limits | Fair usage |
| Usage Tracker | Logs all requests | Billing/analytics |
| Webhook Service | Sends notifications | Integrations |
| SDK Generator | Creates client libraries | Developer experience |

### API Endpoints
```
POST   /v1/pastes           Create paste
GET    /v1/pastes/:id       Get paste
DELETE /v1/pastes/:id       Delete paste
GET    /v1/pastes           List user's pastes
GET    /v1/usage            Get usage stats
```

### Rate Limit Headers
```
HTTP/1.1 200 OK
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 45
X-RateLimit-Reset: 1642000060
```
''',
    'icons': [
      _createIcon('CLI Tool', 'Client & Interface', 50, 250),
      _createIcon('IDE Plugin', 'Client & Interface', 50, 450),
      _createIcon('API Gateway', 'Networking', 250, 350),
      _createIcon('Auth Service', 'Security,Monitoring', 450, 200),
      _createIcon('Rate Limiter', 'Networking', 450, 350),
      _createIcon('Paste Service', 'Application Services', 450, 500),
      _createIcon('Usage Tracker', 'Data Processing', 650, 350),
      _createIcon('Webhook Service', 'Message Systems', 850, 350),
    ],
    'connections': [
      _createConnection(0, 2, label: 'API Call'),
      _createConnection(1, 2, label: 'API Call'),
      _createConnection(2, 3, label: 'Verify Key'),
      _createConnection(2, 4, label: 'Check Rate'),
      _createConnection(4, 5, label: 'Process'),
      _createConnection(5, 6, label: 'Log'),
      _createConnection(5, 7, label: 'Notify'),
    ],
  };

  // DESIGN 7: Search and Discovery
  static Map<String, dynamic> get searchArchitecture => {
    'name': 'Search and Discovery',
    'description': 'Finding public pastes by content or metadata',
    'explanation': '''
## Search and Discovery Architecture

### What This System Does
Users can search public pastes by content, title, or tags. Recent/trending pastes are shown on the homepage.

### How It Works Step-by-Step

**Step 1: Paste Indexed on Creation**
When a public paste is created:
- Content tokenized and indexed
- Title, tags, syntax added to metadata
- Added to search index (Elasticsearch)

**Step 2: User Searches**
User searches for "python sort algorithm":
- Query sent to Search Service
- Elasticsearch finds matching documents
- Results ranked by relevance

**Step 3: Relevance Scoring**
Results ranked by:
- Title matches (highest weight)
- Tag matches (high weight)
- Content matches (medium weight)
- Recency boost (newer = slightly higher)
- Popularity boost (more views = higher)

**Step 4: Results Returned**
Top results returned with snippets:
- Matching text highlighted
- Preview of content shown
- Metadata (syntax, date, author)

**Step 5: Trending Algorithm**
Homepage shows trending pastes:
- Views in last hour / age
- High ratio = trending
- Updated every minute

**Step 6: Browse by Category**
Users can browse:
- By syntax: All Python pastes
- By tag: #tutorial, #snippet
- By date: Today, this week

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Search Service | Handles search queries | Core search |
| Search Index | Stores indexed documents | Fast lookups |
| Indexer | Adds new pastes to index | Keeps index current |
| Trending Service | Calculates trending pastes | Discovery |
| Category Service | Organizes by type | Browsing |

### Search Query Examples
```
Query                    Matches
───────────────────────────────────────────
"python sort"            Content contains both
title:quicksort          Title contains word
syntax:javascript        All JS pastes
author:johndoe           Pastes by user
created:today            Created today
```

### Trending Score
```
score = views_last_hour / (age_hours + 2)^1.5

Example:
Paste A: 1000 views, 1 hour old = 1000 / 3^1.5 = 192
Paste B: 500 views, 0.5 hour old = 500 / 2.5^1.5 = 126
Paste A is trending higher
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('API Gateway', 'Networking', 200, 350),
      _createIcon('Search Service', 'Application Services', 400, 350),
      _createIcon('Search Index', 'Database & Storage', 600, 250),
      _createIcon('Trending Service', 'Data Processing', 600, 450),
      _createIcon('Category Service', 'Application Services', 800, 350),
      _createIcon('Indexer', 'Data Processing', 400, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Search'),
      _createConnection(1, 2, label: 'Query'),
      _createConnection(2, 3, label: 'Search'),
      _createConnection(2, 4, label: 'Trending'),
      _createConnection(4, 5, label: 'Categories'),
      _createConnection(6, 3, label: 'Index'),
    ],
  };

  // DESIGN 8: Analytics and Metrics
  static Map<String, dynamic> get analyticsArchitecture => {
    'name': 'Analytics and Metrics',
    'description': 'Tracking paste views, referrers, and usage patterns',
    'explanation': '''
## Analytics and Metrics Architecture

### What This System Does
Paste creators want to know: How many views? Where from? When? This system tracks detailed analytics for each paste.

### How It Works Step-by-Step

**Step 1: View Event Captured**
Every paste view generates an event:
```json
{
  "paste_id": "abc123",
  "timestamp": 1642000000,
  "ip_hash": "a1b2c3...",
  "referrer": "reddit.com/r/programming",
  "user_agent": "Chrome/97...",
  "country": "US"
}
```

**Step 2: Events Streamed**
Events sent to message queue for processing:
- High throughput (millions per day)
- Async processing (doesn't slow down page load)
- Durable (won't lose events)

**Step 3: Real-time Aggregation**
Stream processor updates counters in real-time:
- Total views: increment
- Views by country: increment US counter
- Views by hour: increment current hour bucket

**Step 4: Batch Analytics**
Nightly jobs compute deeper metrics:
- Unique visitors (IP deduplication)
- Bounce rate (view duration)
- Geographic distribution
- Referrer breakdown

**Step 5: Dashboard Displayed**
Paste creator sees analytics:
- Views over time (line chart)
- Top referrers (bar chart)
- Geographic map (world map)
- Unique vs. total views

**Step 6: Privacy Considerations**
We anonymize data:
- IP addresses hashed
- No personal identification
- Aggregate only, no individual tracking
- GDPR compliant

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Event Collector | Captures view events | Data ingestion |
| Stream Processor | Real-time aggregation | Live counts |
| Batch Processor | Deep analytics | Complex metrics |
| Time Series DB | Stores metrics | Historical data |
| Dashboard API | Serves analytics | User-facing |

### Metrics Tracked
```
Metric              Granularity    Retention
─────────────────────────────────────────────
Total views         Real-time      Forever
Views by hour       Hourly         90 days
Unique visitors     Daily          90 days
Referrer breakdown  Daily          30 days
Country stats       Daily          90 days
```

### Privacy Safeguards
```
✓ IP addresses hashed (not stored raw)
✓ No cookies or tracking
✓ No user identification
✓ Aggregated data only
✓ Minimum data retention
✓ GDPR/CCPA compliant
```
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 350),
      _createIcon('Event Collector', 'Data Processing', 250, 350),
      _createIcon('Message Queue', 'Message Systems', 450, 350),
      _createIcon('Stream Processor', 'Data Processing', 650, 250),
      _createIcon('Batch Processor', 'Data Processing', 650, 450),
      _createIcon('Time Series Database', 'Database & Storage', 850, 350),
      _createIcon('Dashboard API', 'Application Services', 850, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'View Event'),
      _createConnection(1, 2, label: 'Publish'),
      _createConnection(2, 3, label: 'Stream'),
      _createConnection(2, 4, label: 'Batch'),
      _createConnection(3, 5, label: 'Store'),
      _createConnection(4, 5, label: 'Store'),
      _createConnection(5, 6, label: 'Query'),
    ],
  };

  // DESIGN 9: Storage Optimization
  static Map<String, dynamic> get storageArchitecture => {
    'name': 'Storage Optimization',
    'description': 'Compression, deduplication, and tiered storage',
    'explanation': '''
## Storage Optimization Architecture

### What This System Does
Storing millions of pastes requires smart storage. This system compresses content, deduplicates identical pastes, and uses tiered storage for cost optimization.

### How It Works Step-by-Step

**Step 1: Content Compressed**
When paste is stored:
- Apply gzip/zstd compression
- Typical code compresses 3-5x
- 10KB paste → 2-3KB stored

**Step 2: Deduplication Check**
Hash the content:
- SHA-256 of raw content
- Check if hash exists in database
- If exists, reference existing blob instead of duplicating

**Step 3: Hot/Cold Tiering**
Storage tiers by access frequency:
- Hot (SSD): Last 7 days, frequently accessed
- Warm (HDD): 7-90 days
- Cold (Object Storage): 90+ days
- Archive (Glacier): Very old, rarely accessed

**Step 4: Access Patterns Tracked**
Monitor which pastes are accessed:
- Recently created → likely hot
- Old but popular → keep warm
- Old and unused → move to cold

**Step 5: Background Migration**
Cron job moves data between tiers:
- Check access recency
- Move cold data to cheaper storage
- Migrate back to hot if accessed

**Step 6: Cost Savings**
Different tiers have different costs:
- Hot SSD: \$0.20/GB/month
- Warm HDD: \$0.05/GB/month
- Cold Object: \$0.023/GB/month
- Archive: \$0.004/GB/month

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Compression Service | Compresses content | Space savings |
| Dedup Engine | Finds duplicate content | Eliminate copies |
| Tier Manager | Moves data between tiers | Cost optimization |
| Hot Storage | Fast SSD storage | Active pastes |
| Cold Storage | Cheap object storage | Old pastes |
| Access Tracker | Monitors access patterns | Tier decisions |

### Deduplication Example
```
Paste 1: "Hello World" → hash: abc123 → stored
Paste 2: "Hello World" → hash: abc123 → reference paste 1
Paste 3: "Hello World" → hash: abc123 → reference paste 1

Storage: 1 blob instead of 3 = 66% savings
```

### Storage Cost Model
```
1 Million Pastes:
- Average size: 5KB (2KB compressed)
- Total storage: 2GB

Without optimization:
- All on SSD: \$0.40/month

With tiering:
- 10% hot: \$0.04/month
- 30% warm: \$0.03/month
- 60% cold: \$0.028/month
- Total: \$0.098/month (75% savings)
```
''',
    'icons': [
      _createIcon('Paste Service', 'Application Services', 50, 350),
      _createIcon('Compression Service', 'Data Processing', 250, 250),
      _createIcon('Dedup Engine', 'Data Processing', 250, 450),
      _createIcon('Tier Manager', 'System Utilities', 450, 350),
      _createIcon('Object Storage', 'Database & Storage', 650, 200, id: 'Hot'),
      _createIcon('Object Storage', 'Database & Storage', 650, 350, id: 'Warm'),
      _createIcon('Object Storage', 'Database & Storage', 650, 500, id: 'Cold'),
      _createIcon('Access Tracker', 'Data Processing', 850, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Compress'),
      _createConnection(0, 2, label: 'Dedup'),
      _createConnection(1, 3, label: 'Store'),
      _createConnection(2, 3, label: 'Check'),
      _createConnection(3, 4, label: 'Hot'),
      _createConnection(3, 5, label: 'Warm'),
      _createConnection(3, 6, label: 'Cold'),
      _createConnection(7, 3, label: 'Tier'),
    ],
  };

  // DESIGN 10: Complete Pastebin System
  static Map<String, dynamic> get completeArchitecture => {
    'name': 'Complete Pastebin System',
    'description': 'Full-featured pastebin with all components',
    'explanation': '''
## Complete Pastebin System Architecture

### What This System Does
This is a production-ready Pastebin combining all features: scalable storage, content moderation, syntax highlighting, encryption, API access, search, and analytics.

### How It Works Step-by-Step

**Step 1: Create Paste**
Request → Moderate → Compress → Store → Generate URL → Return

**Step 2: View Paste**
Request → Auth (if needed) → Cache check → Fetch → Highlight → Track view → Return

**Step 3: Search**
Query → Search index → Rank results → Return matches

**Step 4: API Access**
Auth → Rate limit → Process → Track usage → Return

**Step 5: Analytics**
Collect events → Process → Store metrics → Display dashboard

### Full Component List

| Category | Components |
|----------|------------|
| Client | Web, Mobile, CLI, API |
| Edge | CDN, Load Balancer |
| Core | Paste Service, ID Generator |
| Content | Syntax Highlighting, Moderation |
| Storage | Database, Cache, Object Storage |
| Security | Encryption, Auth, Rate Limiting |
| Discovery | Search, Trending, Categories |
| Analytics | Events, Metrics, Dashboards |

### Scale Numbers
```
Pastes per day: 500,000
Views per day: 50,000,000
Storage: 500GB (compressed)
Cache hit rate: 85%
API calls: 10,000,000/day
```

### Architecture Principles
1. **Cache Everything**: Reads far exceed writes
2. **Compress Aggressively**: Text compresses well
3. **Tier Storage**: Hot/warm/cold optimization
4. **Moderate Proactively**: Prevent abuse
5. **Privacy by Default**: Minimal data collection
''',
    'icons': [
      _createIcon('Web Viewer', 'Client & Interface', 50, 200),
      _createIcon('CLI Tool', 'Client & Interface', 50, 400),
      _createIcon('CDN', 'Networking', 200, 300),
      _createIcon('API Gateway', 'Networking', 350, 300),
      _createIcon('Rate Limiter', 'Networking', 350, 450),
      _createIcon('Paste Service', 'Application Services', 500, 200),
      _createIcon('Moderation Service', 'Security,Monitoring', 500, 350),
      _createIcon('Search Service', 'Application Services', 500, 500),
      _createIcon('Redis', 'Caching,Performance', 700, 200),
      _createIcon('SQL Database', 'Database & Storage', 700, 350),
      _createIcon('Object Storage', 'Database & Storage', 700, 500),
      _createIcon('Analytics Engine', 'Data Processing', 900, 350),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Request'),
      _createConnection(1, 3, label: 'API'),
      _createConnection(2, 3, label: 'Forward'),
      _createConnection(3, 4, label: 'Check'),
      _createConnection(3, 5, label: 'Create'),
      _createConnection(5, 6, label: 'Moderate'),
      _createConnection(3, 7, label: 'Search'),
      _createConnection(5, 8, label: 'Cache'),
      _createConnection(5, 9, label: 'Store'),
      _createConnection(9, 10, label: 'Blob'),
      _createConnection(9, 11, label: 'Analyze'),
    ],
  };

  static List<Map<String, dynamic>> getAllDesigns() {
    return [
      basicArchitecture,
      scalableArchitecture,
      moderationArchitecture,
      syntaxHighlightingArchitecture,
      encryptedArchitecture,
      apiArchitecture,
      searchArchitecture,
      analyticsArchitecture,
      storageArchitecture,
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
          'color': conn['color'] ?? 0xFF795548,
          'strokeWidth': conn['strokeWidth'] ?? 2.0,
          'label': conn['label'],
        });
      }
    }
    return lines;
  }
}
