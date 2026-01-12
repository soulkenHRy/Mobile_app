# Online Leaderboard Setup Guide

This guide explains how to set up the real-time online leaderboard for the Quiz Game.

## Architecture Overview

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Flutter App   │────▶│  Node.js API    │────▶│    MongoDB      │
│  (Mobile/Web)   │◀────│   (Railway)     │◀────│  (Atlas/Cloud)  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

## Files Created/Modified

### New Files:
- `backend/` - Node.js + Express backend server
  - `server.js` - Main API server with MongoDB integration
  - `package.json` - Dependencies
  - `README.md` - Backend deployment instructions
  - `.env.example` - Environment variable template
  - `railway.toml` - Railway deployment config
  - `Procfile` - Process configuration

- `lib/leaderboard_api_service.dart` - Flutter service for API communication

### Modified Files:
- `lib/leaderboard_screen.dart` - Updated to fetch online leaderboard (falls back to bots if offline)
- `lib/system_description_notebook.dart` - Submits scores to online API
- `lib/unlimited_design_screen.dart` - Submits scores to online API

## Step 1: Set Up MongoDB Atlas (Free Tier)

1. Go to https://cloud.mongodb.com and create a free account
2. Create a new **Free Tier** cluster (M0)
3. In "Database Access", create a database user with read/write permissions
4. In "Network Access", add `0.0.0.0/0` to allow access from anywhere
5. Click "Connect" → "Connect your application" → Copy the connection string
6. Replace `<password>` with your database user's password

Your connection string should look like:
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/quiz_leaderboard?retryWrites=true&w=majority
```

## Step 2: Deploy Backend to Railway

### Option A: Deploy from GitHub (Recommended)

1. Create a new GitHub repository for the backend:
   ```bash
   cd /home/shaken/quiz_game/backend
   git init
   git add .
   git commit -m "Initial backend setup"
   git remote add origin https://github.com/YOUR_USERNAME/quiz-game-backend.git
   git push -u origin main
   ```

2. Go to https://railway.app and sign in with GitHub

3. Click "New Project" → "Deploy from GitHub repo"

4. Select your `quiz-game-backend` repository

5. Add environment variable:
   - Variable name: `MONGODB_URI`
   - Value: Your MongoDB Atlas connection string from Step 1

6. Railway will automatically deploy your backend

7. Go to Settings → Domains → Generate Domain
   - You'll get a URL like: `https://quiz-game-backend-production.up.railway.app`

### Option B: Deploy from Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Create new project
cd /home/shaken/quiz_game/backend
railway init

# Add MongoDB URI
railway variables set MONGODB_URI="your-mongodb-connection-string"

# Deploy
railway up
```

## Step 3: Update Flutter App Configuration

Open `lib/leaderboard_api_service.dart` and update the base URL:

```dart
class LeaderboardApiConfig {
  /// UPDATE THIS with your Railway URL!
  static const String baseUrl = 'https://YOUR-RAILWAY-URL.up.railway.app';
  
  // ... rest of config
}
```

## Step 4: Test the Integration

1. Run the Flutter app
2. Complete a system design to submit a score
3. Go to the Leaderboard screen
4. You should see your name among other real users (or bots if no other users yet)

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Health check |
| `/api/users/register` | POST | Register/update user |
| `/api/scores/submit` | POST | Submit score for a system |
| `/api/scores/sync` | POST | Sync all scores |
| `/api/leaderboard` | GET | Get global leaderboard |
| `/api/users/:userId` | GET | Get user profile |
| `/api/leaderboard/around/:userId` | GET | Get users around a specific user |

## Offline Mode (Fallback to Bots)

If the online leaderboard is unavailable:
- The app automatically falls back to the local bot system
- All original bot code is preserved in `leaderboard_screen.dart`

To manually disable online leaderboard:
```dart
// In lib/leaderboard_api_service.dart
static const bool useOnlineLeaderboard = false;
```

## Data Model

Users are stored in MongoDB with this structure:
```json
{
  "userId": "unique-device-id",
  "username": "PlayerName",
  "country": "United States",
  "totalScore": 450,
  "systemsDesigned": 5,
  "averageScore": 90,
  "systemScores": [
    {
      "systemName": "URL Shortener (e.g., TinyURL)",
      "score": 95,
      "timestamp": "2024-01-15T10:30:00Z"
    }
  ],
  "createdAt": "2024-01-01T00:00:00Z",
  "lastActive": "2024-01-15T10:30:00Z"
}
```

## Troubleshooting

### "Connection refused" or "Network error"
- Check that your Railway service is running
- Verify the `baseUrl` in `LeaderboardApiConfig` is correct
- Make sure your device has internet access

### "User not found"
- The user needs to register first (happens automatically on first leaderboard visit)
- Try syncing scores from the leaderboard screen

### Scores not updating
- Check that `LeaderboardApiConfig.useOnlineLeaderboard` is `true`
- Verify MongoDB connection is working (check Railway logs)

### Local Development
To test the backend locally:
```bash
cd /home/shaken/quiz_game/backend
npm install
cp .env.example .env
# Edit .env with your MongoDB URI
npm run dev
```

Then update Flutter to use `http://localhost:3000` (or `http://10.0.2.2:3000` for Android emulator).

## Security Notes

- User IDs are device-generated UUIDs (anonymous)
- No personal data is stored beyond username and country
- Scores can only be improved, not decreased (server-side validation)
- CORS is enabled for all origins (adjust in production if needed)

## Cost

- **MongoDB Atlas M0**: Free (512MB storage, shared cluster)
- **Railway**: Free tier includes 500 hours/month ($5 credit)
- For a quiz game leaderboard, this should be more than sufficient!
