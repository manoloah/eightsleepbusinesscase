# 🚀 Quick Start - EightSleep Business Case

## ⚡ Immediate Deployment

### Option 1: Local Testing (5 minutes)
```bash
# Deploy locally
./deploy.sh

# Access Metabase
open http://localhost:3000
```

### Option 2: V0 Deployment (Recommended)
```bash
# Push to V0
git add .
git commit -m "Setup Metabase for EightSleep business case"
git push

# V0 will automatically deploy your Metabase instance
```

## 🔗 Supabase Connection Details

**Use these exact parameters in Metabase:**

| Parameter | Value |
|-----------|-------|
| **Host** | `db.lmokzxpktcchregvna.supabase.co` |
| **Port** | `5432` |
| **Database** | `postgres` |
| **Username** | `postgres` |
| **Password** | [Get from Supabase Dashboard] |
| **SSL Mode** | `Require` |

## 📍 Get Your Password

1. Go to: https://supabase.com/dashboard/project/lmokzxpktcchregvna/settings/database
2. Copy the **Database Password**
3. Use it in Metabase connection

## ✅ Success Checklist

- [ ] Metabase deployed
- [ ] Initial setup completed  
- [ ] Supabase connected
- [ ] Data visible
- [ ] Dashboard created

**Ready to analyze EightSleep data! 🎯**
