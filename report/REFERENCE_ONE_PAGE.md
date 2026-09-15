# TABLEAU DASHBOARD BUILD - ONE-PAGE REFERENCE

**Healthcare Insurance Claim Analysis Dashboard | Estimated: 3.5-4 hours**

---

## 🚀 BUILD SEQUENCE (In Order)

| # | Worksheet | Type | Time | Complexity | Status |
|---|-----------|------|------|-----------|--------|
| 1 | Executive KPI Summary | 4 Cards (SUM/AVG/COUNT) | 25 min | ⭐ Easy | ☐ |
| 2 | Monthly Spend Trend | Line + Trend | 20 min | ⭐⭐ | ☐ |
| 3 | Pareto Cost Concentration | Bar + Cumulative % | 20 min | ⭐⭐ | ☐ |
| 4 | Denial vs Cost by Hospital | Bubble (4-quadrant) | 20 min | ⭐⭐⭐ | ☐ |
| 5 | Regional Cost & Denial | Bar + Line (Dual) | 15 min | ⭐⭐ | ☐ |
| 6 | Claims Status Distribution | Pie Chart | 10 min | ⭐ | ☐ |
| 7 | Demographic Risk Segments | Heatmap (Age×BMI) | 45 min | ⭐⭐⭐⭐ | ☐ |
| 8 | Geographic Heatmap by State | US Map | 15 min | ⭐⭐ | ☐ |
| 9 | Patient Lifetime Value RFM | Bubble (8 segments) | 45 min | ⭐⭐⭐⭐ | ☐ |
| — | Dashboard Assembly | Layout + Filters + Actions | 45 min | — | ☐ |

---

## ✅ PRE-FLIGHT CHECKLIST

**Database**
- [ ] MySQL running (port 3306): `mysql -u root -p healthcare_claims_db`
- [ ] Verify views: `SELECT COUNT(*) FROM v_demographic_segmentation;` (expect 20-40 rows)
- [ ] Verify views: `SELECT COUNT(*) FROM v_rfm_analysis;` (expect ~1,591 rows)

**Tableau**
- [ ] MySQL connection configured in Data Source pane
- [ ] 3 data sources available:
  - [ ] v_claims_tableau (for WS 1-6, 8)
  - [ ] v_demographic_segmentation (for WS 7)
  - [ ] v_rfm_analysis (for WS 9)

---

## 📊 WORKSHEET FORMULAS QUICK COPY

### WS1: KPI Calculations
```
Approval Rate = SUM(IF [Claim Status] = "Approved" THEN 1 ELSE 0 END) / COUNTD([Claim ID])
Avg Cost/Claim = SUM([Claim Amount]) / COUNT([Claim ID])
```

### WS3: Pareto
```
Cumulative % = (RUNNING_SUM(SUM([Claim Amount])) / WINDOW_SUM(SUM([Claim Amount]))) * 100
Add Reference Line: Value=80, Label="80% Threshold"
```

### WS4: Denial Rate
```
Denial Rate % = (SUM(IF [Claim Status] = "Denied" THEN 1 ELSE 0 END) / COUNTD([Claim ID])) * 100
Add Reference Lines: 
  - X-axis (Avg Cost): Portfolio average cost
  - Y-axis (Denial %): Portfolio average denial rate
```

### WS5-9: Use view fields directly (no calculations needed)

---

## 🎯 HERO VISUALIZATIONS (Key Talking Points)

### WS7: Demographic Heatmap (Smoker Filter Demo)
```
🔴 Business Insight: Smokers cost 5-10× more than non-smokers
📊 Visual: Toggle smoker filter → cells turn dark red (higher cost)
💰 ROI Opportunity: Age 46-55 smokers = $800k+ annual savings with prevention
🎓 Viva Pitch: "Smoking is the single biggest cost driver. Watch this filter..."
```

### WS9: RFM Analysis (At-Risk Opportunity)
```
🎯 Business Insight: At-Risk High Value = 145 members × $30k = $4.35M at risk
📊 Visual: Large bubble (At-Risk High) on left side; small inactive members
💰 ROI Opportunity: 20% reactivation = $870k annual recovery
🎓 Viva Pitch: "We have $4.35M in dormant high-value revenue. Win-back campaign ROI: 9-18x"
```

---

## 🔧 COMMON ISSUES & FIXES (Quick Ref)

| Issue | Fix | Time |
|-------|-----|------|
| Data won't load (0 rows) | Test view exists: `SELECT COUNT(*) FROM view_name;` | 2 min |
| KPI shows wrong value | Verify aggregate = SUM/COUNT DISTINCT/AVG | 2 min |
| Pareto line doesn't reach 80% | Check Reference Line value = 80 (not 0.8) | 1 min |
| Heatmap cells show blank | Some demographics have zero data (normal sparse matrix) | 0 min |
| Smoker filter doesn't work | Drag Smoker to FILTERS shelf → Show Filter → Checkbox | 3 min |
| Map shows no colors | Right-click State field → Geographic Role → State/Province | 2 min |
| Slow performance (>5s load) | Remove unnecessary tooltip fields; index database columns | 5 min |

---

## 📋 DAILY BUILD LOG

**Session 1: ___/___** (Minutes spent: ____)
- [ ] WS1 - KPI Summary ✓
- [ ] WS6 - Status Distribution ✓
- [ ] WS2 - Monthly Trend ✓
- **Quick win phase complete!**

**Session 2: ___/___** (Minutes spent: ____)
- [ ] WS3 - Pareto ✓
- [ ] WS4 - Bubble Chart ✓
- [ ] WS5 - Regional ✓
- **Analysis phase complete!**

**Session 3: ___/___** (Minutes spent: ____)
- [ ] WS8 - Geographic Map ✓
- [ ] WS7 - Demographic Heatmap ✓ (HERO)
- **Advanced viz #1 complete!**

**Session 4: ___/___** (Minutes spent: ____)
- [ ] WS9 - RFM Analysis ✓ (HERO)
- [ ] Dashboard Assembly ✓
- [ ] Filters & Actions ✓
- [ ] Styling & Polish ✓
- **DASHBOARD COMPLETE!** 🎉

---

## 🎓 VIVA SCRIPT (30 Seconds)

*"This dashboard analyzes 1,591 insurance claims across 20 hospitals and 6 regions. The key innovation is the demographic segmentation—watch this heatmap (point to WS7). Smokers cost 5-10 times more than non-smokers in every age and BMI category. Our 46-55 year-old smokers are the perfect intervention target: high volume, moderate costs, and smoking cessation achieves $800k+ annual savings. The RFM analysis shows we have $4.35M in dormant high-value patients—a win-back program achieves 9-18x ROI. That's where I'd invest next."*

---

## 📊 KEY METRICS (Memorize These)

| Metric | Value | Context |
|--------|-------|---------|
| Total Claims | 1,591 | Base size |
| Total Cost | ~$4.3M | Annual spend |
| Approval Rate | ~82% | Industry standard: 75-80% |
| Denial Rate | ~13% | ~$590k opportunity |
| Avg Cost/Claim | ~$2,689 | Range: $1.8k - $45k |
| Top 5 Hospitals | 80% of cost | Pareto principle |
| Smoker Multiplier | 5-10× | Biggest cost driver |
| At-Risk High Value | $4.35M | Highest ROI opportunity |

---

## 🎊 SUCCESS CRITERIA

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
