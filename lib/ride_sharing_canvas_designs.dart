// Ride Sharing System - Canvas Design Data
// Contains predefined system designs using available canvas icons

import 'package:flutter/material.dart';
import 'system_design_icons.dart';

/// Provides predefined Ride Sharing system designs for the canvas
class RideSharingCanvasDesigns {
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
    int color = 0xFF4CAF50,
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

  // DESIGN 1: Basic Ride Matching
  static Map<String, dynamic> get basicArchitecture => {
    'name': 'Basic Ride Matching',
    'description': 'Core functionality for matching riders with drivers',
    'explanation': '''
## Basic Ride Matching Architecture

### What This System Does
This is the core of Uber/Lyft. A rider requests a ride, the system finds nearby available drivers, and matches them. Simple concept, complex execution.

### How It Works Step-by-Step

**Step 1: Rider Opens App**
Rider opens the app. The app sends their GPS location (latitude, longitude) to the server. Example: lat=37.7749, lng=-122.4194 (San Francisco).

**Step 2: Rider Requests Ride**
Rider enters destination and taps "Request Ride". The Ride Service receives:
- Pickup location: 37.7749, -122.4194
- Dropoff location: 37.7849, -122.4094
- Ride type: UberX (standard car)

**Step 3: Find Nearby Drivers**
The Driver Location Service finds drivers within a radius:
- Query: "Find all available drivers within 3 km of pickup"
- Uses geospatial indexing (like Redis GEO or PostGIS)
- Returns: [Driver A: 0.5 km, Driver B: 1.2 km, Driver C: 2.1 km]

**Step 4: Match Algorithm Selects Best Driver**
The Matching Service scores each driver:
- Distance to pickup (closer = better)
- Driver rating (higher = better)
- Time since last ride (fairness)
- Vehicle type match

Driver A is selected (closest with good rating).

**Step 5: Driver Notified**
Driver A's app receives a ride request notification. They have 15 seconds to accept. If they decline or timeout, Driver B is notified.

**Step 6: Ride Confirmed**
Driver A accepts. Both rider and driver apps update:
- Rider sees: "Driver arriving in 3 minutes"
- Driver sees: Route to pickup location

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Rider App | Rider interface | Request rides |
| Driver App | Driver interface | Accept rides |
| Ride Service | Core ride logic | Manages requests |
| Driver Location Service | Tracks driver positions | Find nearby drivers |
| Matching Service | Pairs riders with drivers | Optimization |
| Notification Service | Sends push notifications | Real-time alerts |

### Geospatial Query Example
```
Redis GEO commands:
GEOADD drivers -122.4194 37.7749 "driver_A"
GEOADD drivers -122.4100 37.7800 "driver_B"

GEORADIUS drivers -122.4194 37.7749 3 km
Result: ["driver_A", "driver_B"]
```

### Matching Criteria Weights
```
Factor              Weight   Example
─────────────────────────────────────
Distance            40%      0.5 km = high score
Driver rating       25%      4.9 stars = high
Wait time           20%      Driver idle 10 min = boost
Acceptance rate     15%      90% = reliable
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        300,
        id: 'Rider App',
      ),
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        450,
        id: 'Driver App',
      ),
      _createIcon('API Gateway', 'Networking', 250, 375),
      _createIcon('Ride Service', 'Application Services', 450, 300),
      _createIcon('Driver Location Service', 'Application Services', 450, 450),
      _createIcon('Matching Service', 'Data Processing', 650, 375),
      _createIcon('Redis', 'Caching,Performance', 850, 300),
      _createIcon('Notification Service', 'Message Systems', 850, 450),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Request Ride'),
      _createConnection(1, 2, label: 'Update Location'),
      _createConnection(2, 3, label: 'Create Ride'),
      _createConnection(2, 4, label: 'Location Update'),
      _createConnection(3, 5, label: 'Find Match'),
      _createConnection(4, 6, label: 'Store Position'),
      _createConnection(5, 6, label: 'Query Nearby'),
      _createConnection(5, 7, label: 'Notify Driver'),
    ],
  };

  // DESIGN 2: Real-time Location Tracking
  static Map<String, dynamic> get locationTrackingArchitecture => {
    'name': 'Real-time Location Tracking',
    'description': 'Continuous GPS tracking for drivers and active rides',
    'explanation': '''
## Real-time Location Tracking Architecture

### What This System Does
During a ride, both rider and driver see each other's location updating in real-time. Uber processes over 1 million location updates per second. This architecture handles that scale.

### How It Works Step-by-Step

**Step 1: Driver App Sends Location**
Every 3-4 seconds, the driver's app sends their current GPS coordinates:
```json
{
  "driver_id": "D123",
  "lat": 37.7749,
  "lng": -122.4194,
  "timestamp": 1642000000,
  "heading": 45,
  "speed": 25
}
```

**Step 2: Location Gateway Receives**
Specialized location servers handle the high throughput. They use UDP (faster than TCP) for location updates.

**Step 3: Stream Processor Processes**
Apache Kafka (or similar) ingests location events:
- Validates data (is this a real driver?)
- Enriches data (add ride_id if driver has active ride)
- Routes to appropriate consumers

**Step 4: Location Store Updates**
Redis GEO stores current positions:
- GEOADD available_drivers -122.4194 37.7749 "D123"
- Index updates in <10ms
- Old positions automatically overwritten

**Step 5: Active Ride Tracking**
For active rides, locations also go to:
- Time Series Database (for route history)
- WebSocket Gateway (for real-time push to rider)

**Step 6: Rider Sees Live Map**
The rider's app maintains a WebSocket connection. When driver's location updates, it's pushed immediately. The car icon moves smoothly on the map.

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Location Gateway | Receives GPS updates | High-throughput ingestion |
| Stream Processor | Processes location events | Real-time pipeline |
| Location Store (Redis) | Current positions | Fast geospatial queries |
| Time Series DB | Historical positions | Route tracking |
| WebSocket Gateway | Real-time push | Live map updates |
| Map Tile Service | Provides map imagery | Visualization |

### Location Update Frequency
```
Scenario              Frequency    Why
──────────────────────────────────────────────
Driver waiting        30 seconds   Save battery
Driver en route       3 seconds    Accurate ETA
Driver in ride        4 seconds    Rider tracking
Driver in traffic     2 seconds    More accuracy
```

### Scale Considerations
```
Active drivers: 5 million
Updates per driver: 1 per 4 seconds
Total updates: 5M / 4 = 1.25M updates/second
Storage per day: 100GB+ of location data
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        250,
        id: 'Driver App',
      ),
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        450,
        id: 'Rider App',
      ),
      _createIcon('Location Gateway', 'Networking', 250, 300),
      _createIcon('Stream Processor', 'Data Processing', 450, 300),
      _createIcon('Redis', 'Caching,Performance', 650, 200),
      _createIcon('Time Series Database', 'Database & Storage', 650, 400),
      _createIcon('WebSocket Gateway', 'Networking', 450, 500),
      _createIcon('Map Service', 'Application Services', 250, 500),
    ],
    'connections': [
      _createConnection(0, 2, label: 'GPS Updates'),
      _createConnection(2, 3, label: 'Process'),
      _createConnection(3, 4, label: 'Current Position'),
      _createConnection(3, 5, label: 'History'),
      _createConnection(3, 6, label: 'Push to Rider'),
      _createConnection(6, 1, label: 'Live Location'),
      _createConnection(7, 1, label: 'Map Tiles'),
    ],
  };

  // DESIGN 3: Dynamic Pricing (Surge)
  static Map<String, dynamic> get surgePricingArchitecture => {
    'name': 'Dynamic Pricing (Surge)',
    'description': 'Supply-demand based price multipliers',
    'explanation': '''
## Dynamic Pricing (Surge) Architecture

### What This System Does
When demand exceeds supply, prices increase. This "surge pricing" encourages more drivers to work and helps riders who really need a ride get one (at a premium). The system calculates fair multipliers in real-time.

### How It Works Step-by-Step

**Step 1: Monitor Supply and Demand**
The Demand Aggregator continuously tracks:
- Ride requests per area per minute
- Available drivers per area
- Completed rides per area

**Step 2: Divide City into Hexagons**
The city is divided into small hexagonal zones (H3 geo-indexing):
- Each hexagon is ~500m across
- Demand and supply calculated per hexagon
- Adjacent hexagons influence each other

**Step 3: Calculate Supply/Demand Ratio**
For each hexagon every minute:
```
Supply = Available drivers in zone
Demand = Ride requests in zone
Ratio = Demand / Supply
```

If Demand = 50 and Supply = 20, Ratio = 2.5x

**Step 4: Smooth the Multiplier**
Raw ratios are too volatile. The Pricing Engine:
- Smooths over 5-minute windows
- Caps maximum multiplier (e.g., 3.0x max)
- Considers nearby zones
- Prevents sudden spikes

**Step 5: Display to User**
When rider requests a ride:
- Check surge multiplier for pickup zone
- Show: "1.5x surge pricing in effect"
- User can accept or wait

**Step 6: Adjust Driver Incentives**
Surge zones are shown to drivers as "heat maps":
- Bright red = high surge = go here for more money
- Drivers naturally move toward high-demand areas

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Demand Aggregator | Counts ride requests | Demand signal |
| Supply Tracker | Counts available drivers | Supply signal |
| Geo Indexer (H3) | Divides city into zones | Location granularity |
| Pricing Engine | Calculates multipliers | Core algorithm |
| Cache | Stores current prices | Fast lookups |
| Heat Map Service | Shows surge to drivers | Supply redistribution |

### Surge Multiplier Tiers
```
Ratio (Demand/Supply)    Multiplier    Display
────────────────────────────────────────────────
1.0 or less              1.0x          Normal pricing
1.0 - 1.5                1.2x          Low surge
1.5 - 2.0                1.5x          Moderate
2.0 - 3.0                2.0x          High surge
3.0 - 4.0                2.5x          Very high
4.0+                     3.0x (cap)    Extreme demand
```

### Ethical Considerations
```
Concern: Price gouging during emergencies?
Solution: Surge caps during declared emergencies

Concern: Unfair to poor neighborhoods?
Solution: Minimum driver coverage requirements

Concern: Drivers gaming the system?
Solution: Detect and penalize artificial shortages
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        350,
        id: 'Rider App',
      ),
      _createIcon('API Gateway', 'Networking', 200, 350),
      _createIcon('Demand Aggregator', 'Data Processing', 400, 200),
      _createIcon('Supply Tracker', 'Data Processing', 400, 500),
      _createIcon('Geo Indexer', 'Application Services', 600, 350),
      _createIcon('Pricing Engine', 'Data Processing', 800, 350),
      _createIcon('Redis', 'Caching,Performance', 800, 200),
      _createIcon('Heat Map Service', 'Application Services', 800, 500),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Request Ride'),
      _createConnection(1, 2, label: 'Count'),
      _createConnection(1, 3, label: 'Track'),
      _createConnection(2, 4, label: 'By Zone'),
      _createConnection(3, 4, label: 'By Zone'),
      _createConnection(4, 5, label: 'Calculate'),
      _createConnection(5, 6, label: 'Cache'),
      _createConnection(5, 7, label: 'Heat Map'),
    ],
  };

  // DESIGN 4: Payment Processing
  static Map<String, dynamic> get paymentArchitecture => {
    'name': 'Payment Processing',
    'description': 'Handling payments, fare calculation, and driver payouts',
    'explanation': '''
## Payment Processing Architecture

### What This System Does
At the end of each ride, the rider is charged and the driver is credited. This system calculates fares, processes payments, handles tips, and manages driver payouts.

### How It Works Step-by-Step

**Step 1: Ride Ends, Fare Calculated**
When driver ends the ride, the Fare Calculator computes:
- Base fare: \$2.50
- Per-mile: 5.2 miles × \$1.25 = \$6.50
- Per-minute: 18 min × \$0.35 = \$6.30
- Surge multiplier: 1.2x
- Booking fee: \$2.75
- **Subtotal: (\$2.50 + \$6.50 + \$6.30) × 1.2 + \$2.75 = \$21.11**

**Step 2: Apply Promotions**
The Promo Service checks for discounts:
- First ride: -\$10
- Promo code "SAVE20": -20%
- Credit balance: -\$5

**Step 3: Charge Rider**
The Payment Service:
- Retrieves saved payment method
- Sends charge to Payment Gateway (Stripe, Braintree)
- Handles 3D Secure if required
- Records transaction

**Step 4: Handle Failures**
If payment fails:
- Retry with backup payment method
- If all fail, mark as unpaid
- Block future rides until resolved

**Step 5: Split Revenue**
Revenue is split:
- Uber/Lyft commission: 25% = \$5.28
- Driver earnings: 75% = \$15.83

**Step 6: Driver Payout**
Weekly (or instant with a fee):
- Aggregate all rides
- Deduct any loans/advances
- Transfer to driver's bank account

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Fare Calculator | Computes ride cost | Pricing |
| Promo Service | Applies discounts | Marketing |
| Payment Service | Coordinates payment | Transaction management |
| Payment Gateway | Processes cards | Money movement |
| Wallet Service | Manages balances | Credits/debits |
| Payout Service | Pays drivers | Driver compensation |

### Fare Breakdown Example
```
Component           Amount
─────────────────────────────
Base fare           \$2.50
Distance (5.2 mi)   \$6.50
Time (18 min)       \$6.30
Surge (1.2x)        +\$3.06
Booking fee         \$2.75
─────────────────────────────
Subtotal            \$21.11
Promo (-20%)        -\$4.22
─────────────────────────────
Total charged       \$16.89
Tip                 \$3.00
─────────────────────────────
Driver receives     \$14.89 (75% + tip)
```

### Fraud Prevention
```
Check for:
- Card testing (small amounts, many cards)
- Stolen cards (chargeback patterns)
- Fake rides (driver-rider collusion)
- Promo abuse (multiple accounts)
```
''',
    'icons': [
      _createIcon('Ride Service', 'Application Services', 50, 350),
      _createIcon('Fare Calculator', 'Data Processing', 250, 250),
      _createIcon('Promo Service', 'Application Services', 250, 450),
      _createIcon('Payment Service', 'Application Services', 450, 350),
      _createIcon('Payment Gateway', 'Networking', 650, 250),
      _createIcon('Wallet Service', 'Application Services', 650, 450),
      _createIcon('Payout Service', 'Application Services', 850, 350),
      _createIcon('SQL Database', 'Database & Storage', 850, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Ride Data'),
      _createConnection(1, 3, label: 'Base Fare'),
      _createConnection(2, 3, label: 'Discounts'),
      _createConnection(3, 4, label: 'Charge'),
      _createConnection(3, 5, label: 'Credit'),
      _createConnection(5, 6, label: 'Weekly'),
      _createConnection(4, 7, label: 'Record'),
      _createConnection(6, 7, label: 'Record'),
    ],
  };

  // DESIGN 5: ETA and Routing
  static Map<String, dynamic> get routingArchitecture => {
    'name': 'ETA and Routing',
    'description': 'Calculating arrival times and optimal routes',
    'explanation': '''
## ETA and Routing Architecture

### What This System Does
When you request a ride, you see "Driver arriving in 4 minutes." When the ride starts, you see the route and arrival time. This system calculates accurate ETAs considering real-time traffic.

### How It Works Step-by-Step

**Step 1: Request ETA**
User opens app. Before requesting, we need to show:
- ETA for nearest driver to arrive
- ETA for trip to destination
- Estimated fare (based on route)

**Step 2: Routing Engine Calculates Path**
The Routing Engine (like OSRM or Valhalla) computes:
- Shortest path (fewest miles)
- Fastest path (considering speed limits)
- Avoiding restricted roads

**Step 3: Traffic Service Adds Real-time Data**
Historical travel times aren't enough. The Traffic Service provides:
- Current congestion levels
- Accident reports
- Construction zones
- Event-based closures

**Step 4: ML Model Predicts ETA**
Raw routing + traffic still isn't accurate enough. An ML Model trained on millions of past trips predicts actual ETA considering:
- Time of day patterns
- Weather conditions
- Driver behavior patterns
- Pickup/dropoff quirks (e.g., airport takes longer)

**Step 5: Continuous Re-routing**
During the ride, the system:
- Monitors progress vs. predicted
- Detects traffic changes
- Suggests alternative routes
- Updates ETA in real-time

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Routing Engine | Calculates paths | Core navigation |
| Map Data Service | Road network data | Graph for routing |
| Traffic Service | Real-time conditions | Accurate timing |
| ML ETA Predictor | Learns from history | Better accuracy |
| Navigation Service | Turn-by-turn guidance | Driver directions |
| Route Optimizer | Finds alternatives | Avoid delays |

### ETA Accuracy Improvements
```
Method                      Accuracy
──────────────────────────────────────────
Basic routing only          ±30% error
+ Historical traffic        ±20% error
+ Real-time traffic         ±10% error
+ ML model                  ±5% error
Uber/Lyft current           <5% error
```

### Why ETA Matters
```
Bad ETA experience:
- "4 minutes" → Actually 12 minutes
- User frustration
- Cancellations
- Bad ratings

Good ETA experience:
- "4 minutes" → Actually 4-5 minutes
- User trust
- Higher completion rates
- Better ratings
```
''',
    'icons': [
      _createIcon('Mobile Client', 'Client & Interface', 50, 350),
      _createIcon('API Gateway', 'Networking', 200, 350),
      _createIcon('Routing Engine', 'Data Processing', 400, 250),
      _createIcon('Traffic Service', 'Application Services', 400, 450),
      _createIcon('Map Data Service', 'Database & Storage', 600, 200),
      _createIcon('ML Pipeline', 'Data Processing', 600, 350),
      _createIcon('Navigation Service', 'Application Services', 600, 500),
      _createIcon('Route Cache', 'Caching,Performance', 800, 350),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Get ETA'),
      _createConnection(1, 2, label: 'Calculate'),
      _createConnection(2, 4, label: 'Road Data'),
      _createConnection(2, 3, label: 'Traffic'),
      _createConnection(2, 5, label: 'Predict'),
      _createConnection(5, 7, label: 'Cache'),
      _createConnection(2, 6, label: 'Navigate'),
    ],
  };

  // DESIGN 6: Driver Management
  static Map<String, dynamic> get driverManagementArchitecture => {
    'name': 'Driver Management',
    'description': 'Driver onboarding, documents, ratings, and compliance',
    'explanation': '''
## Driver Management Architecture

### What This System Does
Before someone can drive for Uber/Lyft, they must be verified. This system handles driver applications, document verification, background checks, ongoing compliance, and performance management.

### How It Works Step-by-Step

**Step 1: Driver Applies**
Prospective driver submits application with:
- Personal information
- Driver's license photo
- Vehicle registration
- Insurance documents
- Profile photo

**Step 2: Document Verification**
The Document Verification Service:
- Uses OCR to extract text from documents
- Validates format and expiration dates
- Checks against databases (license valid?)
- May require human review for edge cases

**Step 3: Background Check**
Third-party background check service reviews:
- Criminal history
- Driving record
- Sex offender registry
- Terrorist watchlist

Takes 3-7 days. Results determine eligibility.

**Step 4: Vehicle Inspection**
Driver schedules vehicle inspection:
- In-person at hub, or
- Virtual video inspection
- Checks: Safety features, cleanliness, age limits

**Step 5: Onboarding Complete**
Once approved:
- Account activated
- Training materials provided
- First ride bonus offered

**Step 6: Ongoing Compliance**
The Compliance Service monitors:
- Document expiration (renew license!)
- Rating thresholds (below 4.6 = warning)
- Cancellation rates
- Safety incidents

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Application Service | Collects applications | Entry point |
| Document Verification | Validates documents | Fraud prevention |
| Background Check | Criminal/driving history | Safety |
| Inspection Service | Vehicle verification | Quality control |
| Compliance Engine | Ongoing monitoring | Standards |
| Rating Service | Aggregates feedback | Performance |

### Driver Rating System
```
Rating    Status        Action
────────────────────────────────────────
4.9-5.0   Excellent     Bonus rewards
4.6-4.9   Good          Normal
4.4-4.6   At risk       Warning + coaching
4.2-4.4   Probation     Limited rides
<4.2      Deactivation  Account suspended
```

### Document Lifecycle
```
Document            Valid For    Reminder
─────────────────────────────────────────────
Driver's License    2-6 years    30 days before
Vehicle Reg         1 year       30 days before
Insurance           6 months     14 days before
Background Check    1 year       Auto-renewal
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        350,
        id: 'Driver App',
      ),
      _createIcon('Application Service', 'Application Services', 250, 350),
      _createIcon('Document Verification', 'Security,Monitoring', 450, 200),
      _createIcon('Background Check', 'Security,Monitoring', 450, 350),
      _createIcon('Inspection Service', 'Application Services', 450, 500),
      _createIcon('Compliance Engine', 'Data Processing', 650, 350),
      _createIcon('Rating Service', 'Application Services', 850, 350),
      _createIcon('SQL Database', 'Database & Storage', 850, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Apply'),
      _createConnection(1, 2, label: 'Documents'),
      _createConnection(1, 3, label: 'BGC'),
      _createConnection(1, 4, label: 'Inspection'),
      _createConnection(2, 5, label: 'Status'),
      _createConnection(3, 5, label: 'Status'),
      _createConnection(4, 5, label: 'Status'),
      _createConnection(5, 6, label: 'Monitor'),
      _createConnection(6, 7, label: 'Store'),
    ],
  };

  // DESIGN 7: Safety System
  static Map<String, dynamic> get safetyArchitecture => {
    'name': 'Safety System',
    'description': 'Emergency response, trip sharing, and safety features',
    'explanation': '''
## Safety System Architecture

### What This System Does
Rider and driver safety is paramount. This system provides emergency assistance, trip sharing with contacts, ride verification, and real-time monitoring for dangerous situations.

### How It Works Step-by-Step

**Step 1: Share Trip with Contacts**
Before or during a ride, rider shares trip:
- Contacts receive a link
- Link shows live map with vehicle location
- Shows driver info, license plate
- ETA to destination

**Step 2: Emergency Button Pressed**
If rider taps "Emergency":
- App immediately dials 911
- Sends location to emergency services
- Records audio (in some regions)
- Alerts Uber's Safety Team

**Step 3: Anomaly Detection**
Background AI monitors for anomalies:
- Route deviation: Is driver going the wrong way?
- Long stops: Car stopped for 10 minutes mid-ride
- Speed anomaly: Going 100 mph on surface streets
- Ride too long: Trip taking 3x expected time

**Step 4: Safety Check-in**
If anomaly detected, rider receives:
- Push notification: "Is everything okay?"
- Option to report issue
- Option to share with contact
- Emergency button prominent

**Step 5: Incident Response**
If incident confirmed:
- Trip flagged for review
- Driver may be temporarily deactivated
- Insurance notified if accident
- Law enforcement involved if needed

**Step 6: Post-Ride Safety**
After ride:
- Both parties can report issues
- 24/7 support available
- Insurance claims processed
- Pattern analysis for repeat offenders

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Trip Sharing Service | Shares live location | Loved ones can monitor |
| Emergency Service | 911 integration | Immediate help |
| Anomaly Detection | AI monitoring | Proactive safety |
| Check-in Service | Prompts during issues | User confirmation |
| Incident Response | Handles emergencies | Crisis management |
| Support Service | Post-ride help | Resolution |

### Safety Features List
```
Feature               When Used
────────────────────────────────────────────
Ride verification     Before entering car
PIN matching          High-value rides
Trip sharing          Any ride
Emergency button      Danger situation
Audio recording       Some markets
RideCheck            AI-detected anomaly
Trusted contacts     Automatic sharing
```

### Anomaly Detection Triggers
```
Trigger              Threshold           Action
────────────────────────────────────────────────────
Route deviation      >1 km off route     Check-in
Unexpected stop      >5 minutes          Check-in
High speed          >100 mph             Alert + check
Long ride           >2x expected         Check-in
Crash detection     Accelerometer spike  Emergency call
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        300,
        id: 'Rider App',
      ),
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        450,
        id: 'Driver App',
      ),
      _createIcon('Safety Service', 'Security,Monitoring', 250, 375),
      _createIcon('Trip Sharing Service', 'Application Services', 450, 200),
      _createIcon('Anomaly Detection', 'Data Processing', 450, 375),
      _createIcon('Emergency Service', 'Security,Monitoring', 450, 550),
      _createIcon('Notification Service', 'Message Systems', 650, 300),
      _createIcon('Incident Response', 'Application Services', 650, 450),
      _createIcon('Support Service', 'Application Services', 850, 375),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Share/SOS'),
      _createConnection(1, 2, label: 'Location'),
      _createConnection(2, 3, label: 'Share'),
      _createConnection(2, 4, label: 'Monitor'),
      _createConnection(2, 5, label: 'Emergency'),
      _createConnection(4, 6, label: 'Check-in'),
      _createConnection(5, 7, label: 'Escalate'),
      _createConnection(7, 8, label: 'Resolve'),
    ],
  };

  // DESIGN 8: Carpooling (Shared Rides)
  static Map<String, dynamic> get carpoolingArchitecture => {
    'name': 'Carpooling (Shared Rides)',
    'description': 'Matching multiple riders going the same direction',
    'explanation': '''
## Carpooling (Shared Rides) Architecture

### What This System Does
UberPool/Lyft Shared matches multiple riders going in the same direction. One driver picks up and drops off multiple passengers. Riders save money, drivers earn more, fewer cars on the road.

### How It Works Step-by-Step

**Step 1: First Rider Requests Pool**
Rider A requests a Pool ride from Downtown to Airport. The system finds a driver and starts the trip.

**Step 2: Search for Compatible Riders**
While en route, the Pool Matching Service searches for additional riders:
- Origin/destination overlap with current route
- Minimal detour (<5 minutes)
- Seats available (usually max 2 pool riders)

**Step 3: Match Found**
Rider B requests Pool from Business District to Airport. The Route Optimizer calculates:
- Current ETA for Rider A: 25 minutes
- With Rider B pickup: 28 minutes (+3 min detour)
- Acceptable! Offer the match.

**Step 4: Both Riders Notified**
- Rider A sees: "Picking up another rider, +3 min"
- Rider B sees: "You're matched! Driver arriving in 4 min"

**Step 5: Dynamic Routing**
Driver's navigation updates in real-time:
1. Current location
2. → Pick up Rider A (original)
3. → Pick up Rider B (new)
4. → Drop off Rider A (Airport Terminal 1)
5. → Drop off Rider B (Airport Terminal 3)

**Step 6: Split Fare**
Each rider pays less than solo:
- Solo fare: \$30 each
- Pool fare: \$18 each
- Driver still earns ~\$40 total
- Platform saves on driver time

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Pool Matching Service | Finds compatible riders | Core matching |
| Route Optimizer | Calculates efficient routes | Minimize detours |
| Detour Calculator | Measures time impact | Fair to existing riders |
| Fare Splitter | Divides cost | Pricing |
| Real-time Coordinator | Updates all parties | Communication |
| Seat Manager | Tracks capacity | Don't overbook |

### Matching Criteria
```
Criterion                   Weight
─────────────────────────────────────
Route overlap              High
Pickup detour              High
Total trip time increase   High
Pickup wait time           Medium
Rider preferences          Low
```

### Pool Economics
```
Scenario: 20-mile airport trip

Solo Ride:
- Rider pays: \$35
- Driver earns: \$26
- Platform: \$9

Pool Ride (2 riders):
- Rider A pays: \$22
- Rider B pays: \$20
- Driver earns: \$31 (more!)
- Platform: \$11 (more!)

Everyone wins except traffic.
```
''',
    'icons': [
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        300,
        id: 'Rider A',
      ),
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        50,
        450,
        id: 'Rider B',
      ),
      _createIcon('API Gateway', 'Networking', 200, 375),
      _createIcon('Pool Matching Service', 'Application Services', 400, 375),
      _createIcon('Route Optimizer', 'Data Processing', 600, 250),
      _createIcon('Fare Splitter', 'Data Processing', 600, 500),
      _createIcon('Real-time Coordinator', 'Application Services', 800, 375),
      _createIcon(
        'Mobile Client',
        'Client & Interface',
        1000,
        375,
        id: 'Driver',
      ),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Request Pool'),
      _createConnection(1, 2, label: 'Request Pool'),
      _createConnection(2, 3, label: 'Match'),
      _createConnection(3, 4, label: 'Optimize'),
      _createConnection(3, 5, label: 'Calculate'),
      _createConnection(4, 6, label: 'Route'),
      _createConnection(5, 6, label: 'Fares'),
      _createConnection(6, 7, label: 'Navigate'),
    ],
  };

  // DESIGN 9: Analytics and Machine Learning
  static Map<String, dynamic> get analyticsArchitecture => {
    'name': 'Analytics and Machine Learning',
    'description': 'Data-driven optimization and predictions',
    'explanation': '''
## Analytics and Machine Learning Architecture

### What This System Does
Every Uber/Lyft ride generates valuable data. This system collects, processes, and uses that data for demand prediction, fraud detection, driver scoring, and platform optimization.

### How It Works Step-by-Step

**Step 1: Event Collection**
Every interaction generates events:
- App opened, location sent
- Ride requested, matched, completed
- Rating given, tip added
- Payment processed

Billions of events per day flow into the Event Collector.

**Step 2: Real-time Processing**
Stream processors analyze live data:
- Current demand by area
- Active driver count
- System health metrics
- Fraud signals

**Step 3: Batch Processing**
Nightly jobs analyze historical data:
- Demand patterns (Fridays at 6 PM are busy)
- Driver behavior trends
- Market performance
- Financial reconciliation

**Step 4: Feature Engineering**
Raw data becomes ML features:
- Driver feature: avg_rating, trips_last_week, acceptance_rate
- Market feature: day_of_week, hour, is_holiday, weather
- Rider feature: ride_frequency, avg_tip, cancellation_rate

**Step 5: Model Training**
ML models are trained for various predictions:
- Demand forecasting (how many rides at 6 PM?)
- ETA prediction (how long will this trip take?)
- Fraud detection (is this a fake ride?)
- Pricing optimization (optimal surge level?)

**Step 6: Model Serving**
Trained models are deployed for real-time inference:
- <10ms prediction latency
- A/B testing of model versions
- Continuous retraining with new data

### Component Breakdown

| Component | What It Does | Why It's Needed |
|-----------|--------------|-----------------|
| Event Collector | Ingests all events | Data capture |
| Stream Processor | Real-time analysis | Live metrics |
| Batch Processor | Historical analysis | Deep patterns |
| Feature Store | ML feature storage | Consistent features |
| Training Pipeline | Trains ML models | Model creation |
| Model Server | Serves predictions | Real-time inference |

### Key ML Models
```
Model                   Purpose
───────────────────────────────────────────
Demand Forecasting      Predict ride demand
ETA Predictor           Accurate trip times
Surge Pricing           Optimal multipliers
Fraud Detection         Catch bad actors
Driver Churn           Predict who will quit
Pool Matching          Optimize shared rides
```

### Data Scale
```
Metric                  Scale
───────────────────────────────────────
Rides per day           25 million
Events per second       1 million+
Data stored             Petabytes
Models in production    100+
```
''',
    'icons': [
      _createIcon('Event Collector', 'Data Processing', 50, 350),
      _createIcon('Message Queue', 'Message Systems', 250, 350),
      _createIcon('Stream Processor', 'Data Processing', 450, 250),
      _createIcon('Batch Processor', 'Data Processing', 450, 450),
      _createIcon('Feature Store', 'Database & Storage', 650, 350),
      _createIcon('ML Pipeline', 'Data Processing', 850, 250),
      _createIcon('Model Server', 'Application Services', 850, 450),
      _createIcon('Data Warehouse', 'Database & Storage', 650, 550),
    ],
    'connections': [
      _createConnection(0, 1, label: 'Publish'),
      _createConnection(1, 2, label: 'Stream'),
      _createConnection(1, 3, label: 'Batch'),
      _createConnection(2, 4, label: 'Features'),
      _createConnection(3, 4, label: 'Features'),
      _createConnection(4, 5, label: 'Train'),
      _createConnection(5, 6, label: 'Deploy'),
      _createConnection(3, 7, label: 'Store'),
    ],
  };

  // DESIGN 10: Complete Ride Sharing Platform
  static Map<String, dynamic> get completeArchitecture => {
    'name': 'Complete Ride Sharing Platform',
    'description': 'Full Uber/Lyft-like architecture',
    'explanation': '''
## Complete Ride Sharing Platform Architecture

### What This System Does
This is the complete Uber/Lyft architecture combining all subsystems: matching, location tracking, routing, payments, safety, and analytics into one massive, real-time platform.

### How It Works Step-by-Step

**Step 1: Request Phase**
Rider opens app → Location detected → Surge checked → ETA displayed → Ride requested

**Step 2: Matching Phase**
Nearby drivers queried → Best match selected → Driver notified → Driver accepts → Match confirmed

**Step 3: Pickup Phase**
Driver navigates to pickup → Location shared in real-time → Rider verifies car → Ride starts

**Step 4: Trip Phase**
Route navigation → Real-time tracking → Safety monitoring → ETA updates

**Step 5: Dropoff Phase**
Arrive at destination → Fare calculated → Payment processed → Both parties rate

**Step 6: Post-Ride Phase**
Tip added → Analytics recorded → Driver available for next ride

### Full Component List

| Category | Components |
|----------|------------|
| Client | Rider App, Driver App |
| Ingress | API Gateway, Load Balancer |
| Core | Ride Service, Matching, Routing |
| Location | GPS Ingestion, Real-time Tracking |
| Money | Payments, Pricing, Payouts |
| Safety | Emergency, Anomaly Detection |
| Intelligence | ML Models, Analytics |
| Support | Driver Management, Support |

### System Scale (Uber-like)
```
Metric                      Scale
────────────────────────────────────────
Active riders              130 million
Active drivers             5 million
Rides per day              25 million
Countries                  70+
Cities                     10,000+
Engineers                  6,000+
Microservices              4,000+
```

### Architecture Principles
1. **Real-time First**: Everything must be instant
2. **Reliability**: 99.99% uptime required
3. **Scalability**: Handle 10x spikes gracefully
4. **Safety**: Never compromise on safety
5. **Fairness**: Balance rider and driver needs
''',
    'icons': [
      _createIcon('Mobile Client', 'Client & Interface', 50, 200, id: 'Rider'),
      _createIcon('Mobile Client', 'Client & Interface', 50, 350, id: 'Driver'),
      _createIcon('Global Load Balancer', 'Networking', 200, 275),
      _createIcon('API Gateway', 'Networking', 350, 275),
      _createIcon('Ride Service', 'Application Services', 500, 175),
      _createIcon('Location Service', 'Application Services', 500, 275),
      _createIcon('Matching Service', 'Application Services', 500, 375),
      _createIcon('Payment Service', 'Application Services', 700, 175),
      _createIcon('Routing Engine', 'Data Processing', 700, 275),
      _createIcon('Safety Service', 'Security,Monitoring', 700, 375),
      _createIcon('Redis', 'Caching,Performance', 900, 225),
      _createIcon('SQL Database', 'Database & Storage', 900, 375),
      _createIcon('Analytics Engine', 'Data Processing', 1100, 300),
    ],
    'connections': [
      _createConnection(0, 2, label: 'Request'),
      _createConnection(1, 2, label: 'Location'),
      _createConnection(2, 3, label: 'Route'),
      _createConnection(3, 4, label: 'Ride'),
      _createConnection(3, 5, label: 'Track'),
      _createConnection(3, 6, label: 'Match'),
      _createConnection(4, 7, label: 'Pay'),
      _createConnection(6, 8, label: 'Route'),
      _createConnection(5, 9, label: 'Monitor'),
      _createConnection(5, 10, label: 'Cache'),
      _createConnection(4, 11, label: 'Store'),
      _createConnection(11, 12, label: 'Analyze'),
    ],
  };

  static List<Map<String, dynamic>> getAllDesigns() {
    return [
      basicArchitecture,
      locationTrackingArchitecture,
      surgePricingArchitecture,
      paymentArchitecture,
      routingArchitecture,
      driverManagementArchitecture,
      safetyArchitecture,
      carpoolingArchitecture,
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
          'color': conn['color'] ?? 0xFF4CAF50,
          'strokeWidth': conn['strokeWidth'] ?? 2.0,
          'label': conn['label'],
        });
      }
    }
    return lines;
  }
}
