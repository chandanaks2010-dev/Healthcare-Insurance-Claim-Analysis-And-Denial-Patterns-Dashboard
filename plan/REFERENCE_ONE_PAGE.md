# TABLEAU QUICK REFERENCE CARD
## One-Page Memory Aid (Print & Post on Monitor)

**Healthcare Insurance Claim Analysis Dashboard**  
**Build Time: 3.5-4 hours | Total Worksheets: 9 | Total Cost: ~$4.3M | Total Claims: 1,591**

---

## 🚀 QUICK BUILD SEQUENCE (In Order)

| # | Worksheet | Time | Type | Complexity |
|---|-----------|------|------|-----------|
| 1 | Executive KPI Summary | 25 min | 4 cards | ⭐ |
| 2 | Monthly Spend Trend | 20 min | Line + trend | ⭐⭐ |
| 3 | Pareto Cost Concentration | 20 min | Bar + % | ⭐⭐ |
| 4 | Denial vs Cost by Hospital | 20 min | Bubble | ⭐⭐⭐ |
| 5 | Regional Profile | 15 min | Dual-axis | ⭐⭐ |
| 6 | Status Distribution | 10 min | Pie | ⭐ |
| 7 | Demographic Heatmap | 45 min | Heatmap | ⭐⭐⭐⭐ HERO |
| 8 | Geographic Heatmap | 15 min | Map | ⭐⭐ |
| 9 | RFM Analysis | 45 min | Bubble | ⭐⭐⭐⭐ HERO |
| — | Dashboard + Filters | 45 min | Layout | — |

**→ For detailed steps:** [TABLEAU_WORKSHEET_BUILD_CHECKLIST.md](TABLEAU_WORKSHEET_BUILD_CHECKLIST.md)

---

## 📊 KEY METRICS (Memorize These)

| Metric | Value | Insight |
|--------|-------|---------|
| **Total Claims** | 1,591 | Database size |
| **Total Cost** | $4.3M | Annual spend |
| **Approval Rate** | 82% | Industry standard: 75-80% |
| **Denial Rate** | 13% | $590k opportunity |
| **Avg Cost/Claim** | $2,689 | Range: $1.8k - $45k |
| **Top 5 Hospitals** | 80% of cost | Pareto principle |
| **Smoker Multiplier** | 5-10× | Biggest cost driver |
| **At-Risk High Value** | $4.35M | RFM opportunity |

---

## 🔧 QUICK FIXES (Common Issues)

| Issue | Fix | Time |
|-------|-----|------|
| Data won't load | `SELECT COUNT(*) FROM view_name;` in MySQL | 2 min |
| KPI shows wrong value | Check aggregate (SUM, COUNT DISTINCT, AVG) | 2 min |
| Pareto line at 0% | Reference Line value = 80 (not 0.8) | 1 min |
| Heatmap blank cells | Normal for sparse matrix (not all combos have data) | — |
| Smoker filter broken | Drag to FILTERS shelf → Show Filter checkbox | 3 min |
| Map not colored | Geographic Role → State/Province on State field | 2 min |
| Slow load (>5s) | Remove tooltip fields; add database indexes | 5 min |

---

## 🎤 30-SECOND VIVA PITCH

*"This dashboard analyzes 1,591 insurance claims worth $4.3M across 6 regions. The key insight: **smokers cost 5-10× more than non-smokers** in every demographic segment. Our 46-55 year-old smokers represent $800k+ annual savings opportunity with smoking cessation. The RFM analysis identifies $4.35M in dormant high-value patients—a win-back campaign achieves 9-18x ROI. That's the investment I'd prioritize."*

**Key Numbers to Say:** 1,591 | $4.3M | 5-10× | $800k | $4.35M | 9-18x

---

## ✅ SUCCESS CRITERIA

**Quick Wins (Day 1-2)**
- [ ] WS1, WS6, WS2 complete (Quick Wins: 55 min)
- [ ] KPI values: 1,591 claims, $4.3M, 82%, $2,689
- [ ] Trend shows month-over-month pattern

**Core Analysis (Day 3)**
- [ ] WS3 (Pareto reaches 80% at correct hospital)
- [ ] WS4 (4-quadrant scatter with 3 hospitals highlighted)
- [ ] WS5 (6 regional bars with denial line)

**Advanced Viz (Day 4)**
- [ ] WS8 map colored by state cost
- [ ] WS7 heatmap shows smoker premium (dark red)
- [ ] WS9 shows 8 RFM segments with "At-Risk High" largest

**Dashboard (Day 5)**
- [ ] All 9 worksheets visible
- [ ] Filters work: Region → State cascade, Smoker checkbox
- [ ] Click region → all sheets update
- [ ] Loads in <5 seconds
- [ ] File saved (.twb) and exported (.twbx)

---

## 📍 NAVIGATION GUIDE

| Need | File |
|------|------|
| Full build instructions | TABLEAU_WORKSHEET_BUILD_CHECKLIST.md |
| Add filters & actions | TABLEAU_CUSTOM_INTERACTIVE_DASHBOARD.md |
| Add LOD expressions | TABLEAU_LOD_EXPRESSIONS_IMPLEMENTATION.md |
| Create storyboard | TABLEAU_STORYBOARD_IMPLEMENTATION.md |
| Quick action checklist | TABLEAU_CUSTOM_ACTIONS_QUICK_REFERENCE.md |
| Viva Q&A + demo | VIVA_PREPARATION_GUIDE.md |
| Doc navigation | **TABLEAU_DOCUMENTATION_MAP.md** |
| Deep-dive WS7 | WS7_DEMOGRAPHIC_HEATMAP.md |
| Deep-dive WS9 | WS9_RFM_ANALYSIS.md |

---

## 🎯 HERO VISUALIZATIONS (Viva Demo Points)

### **WS7: Demographic Heatmap**
- Filter to Smokers → Cells turn DARK RED (5-10× higher cost)
- Talking point: "Smoking is the single biggest cost driver. Age 46-55 smokers: $45k avg."

### **WS9: RFM Analysis**
- Show "At-Risk High" bubble (large, left side): $4.35M at risk
- Talking point: "20% reactivation = $870k recovery. Win-back ROI: 9-18×."

---

## ⏱️ BUILD TRACKER

```
Quick Wins (WS1, 6, 2) ...................... 35 min
Core Analysis (WS3, 4, 5) .................. 70 min
Advanced Viz (WS8, 7, 9) ................... 90 min
Dashboard Assembly + Filters ................ 45 min
─────────────────────────────────────────────────
TOTAL ................................... 240 min (4 hours)
```

---

## 📋 WORKSHEET CHECKLIST (Track Your Progress)

**Phase 1: Quick Wins (Day 1)**
- [ ] WS1 - KPI Summary (25 min)
- [ ] WS6 - Status Distribution (10 min)  
- [ ] WS2 - Monthly Trend (20 min)

**Phase 2: Core Analysis (Day 2-3)**
- [ ] WS3 - Pareto (20 min)
- [ ] WS4 - Bubble (20 min)
- [ ] WS5 - Regional (15 min)

**Phase 3: Advanced (Day 4)**
- [ ] WS8 - Geographic Map (15 min)
- [ ] WS7 - Demographic Heatmap (45 min) ⭐
- [ ] WS9 - RFM (45 min) ⭐

**Phase 4: Assembly (Day 5)**
- [ ] Create Dashboard sheet
- [ ] Arrange 9 worksheets
- [ ] Add Global filters (Region, State, Smoker, Date, Status)
- [ ] Add Dashboard actions
- [ ] Format colors & styling
- [ ] Save + export .twbx

---

**PRINT THIS PAGE AND POST ON YOUR MONITOR!**

*Healthcare Insurance Dashboard | Executive MTech Data Science & AI*

**Visual ✓**
- All 9 worksheets visible and error-free
- Professional colors, fonts, spacing
- Dashboard loads in <5 seconds

**Functional ✓**
- All filters work (Region, Smoking, Date, Status)
- Dashboard actions cascade correctly
- Tooltips informative on hover

**Data ✓**
- KPI totals match SQL queries
- Pareto reaches 80% at correct hospital
- Smoker heatmap shows 5-10× multiplier
- RFM shows correct segment counts

**Ready ✓**
- Workbook saved (.twb) + exported (.twbx)
- Viva talking points memorized
- Screenshots of hero visualizations captured
- MySQL backup confirmed

---

## 📁 WHERE TO FIND HELP

**Stuck on specific worksheet?**  
→ Open `WS#_WORKSHEET_NAME.md` file in `/report/` folder

**General dashboard help?**  
→ Read `TABLEAU_WORKSHEET_BUILD_CHECKLIST.md` master doc

**Quick reference needed?**  
→ This page! (Print it, post at desk)

**Troubleshooting?**  
→ Search troubleshooting section in relevant WS markdown file

---

## ⏱️ TIME TRACKER

```
Phase 1: Quick Wins ..................... 35 min [████░░░░░]
Phase 2: Core Analysis .................. 70 min [██████░░░]
Phase 3: Advanced Viz ................... 90 min [████████░]
Phase 4: Dashboard Assembly ............. 45 min [████░░░░░]
─────────────────────────────────────────────────────────
TOTAL TIME ESTIMATED .................. 240 min [████████░]
TOTAL TIME ACTUAL ..................... ___ min [░░░░░░░░░]
```

---

## 🏁 FINAL CHECKLIST (Day of Viva)

**30 Minutes Before**
- [ ] Tableau workbook open → all 9 worksheets visible
- [ ] MySQL connection working → test 1 filter
- [ ] Viva script memorized (30-second pitch)
- [ ] Key metrics 3×3 grid visible (print backup copy)

**During Viva**
- [ ] Start with Dashboard overview (WS1 KPI)
- [ ] Narrative flow: KPI → Trend → Pareto → Bubble → Regional → Status
- [ ] Highlight WS7 (demo smoker filter) + WS9 (RFM opportunity)
- [ ] Show interactivity: Click region → all sheets filter
- [ ] Close with ROI: "Demographic targeting = $800k savings; RFM win-back = $870k recovery"

---

**READY TO BUILD?** Open `TABLEAU_QUICK_START_GUIDE.md` for full instructions, then start with WS1! 🚀

*Healthcare Insurance Claims Dashboard | Executive MTech Data Science & AI Program*
