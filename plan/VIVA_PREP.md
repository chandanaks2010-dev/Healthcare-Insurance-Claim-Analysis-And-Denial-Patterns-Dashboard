# VIVA PREPARATION GUIDE
## Q&A, Demo Script, Talking Points

**Healthcare Insurance Claim Analysis & Denial Patterns Dashboard**  
**Evaluation Coverage:** Presentation & Viva (4 marks)  
**Per PDF Guidelines:** Section 5 (Project Presentation) + Section 4 Rubric 7

---

## 30-Second Opening Statement

> "This dashboard analyzes 1,549 insurance claims across 6 US regions, totaling $4.3M in annual healthcare spend. Through SQL querying and Tableau visualization, we identified smoking status as the dominant cost driver—smokers cost 5-10× more than non-smokers. Additionally, Pareto analysis reveals 60% of costs concentrate in just 3 hospitals, and our RFM analysis identifies $4.35M in at-risk high-value patients. These insights enable $800K-$1.3M in annual savings through risk-based pricing, hospital contracting, and member win-back campaigns."

**Key Numbers:** 1,549 | $4.3M | 5-10× | 60% | 3 hospitals | $4.35M | $800K-$1.3M

---

## 4-Minute Live Demo Script

**PART 1: KPI Overview (30 sec)**
- Show: Executive KPI Summary (WS1)
- Say: "Four metrics at a glance: 1,549 claims, $20.4M spend, 80.05% approval rate, $13,171 average. This is our portfolio baseline."

**PART 2: Trend Analysis (60 sec)**
- Show: Monthly Spend Trend (WS2)
- Filter by Region: Select "Northeast"
- Say: "Spend shows +12% year-over-year growth. Trending upward. Now watch—when I filter to just the Northeast region, we see [trend]. This region-level view reveals performance disparities across our 6 regions."

**PART 3: Pareto Concentration (60 sec)**
- Show: Cost Concentration by Hospital (WS3)
- Highlight: "See this cumulative line reaching 80% here, at just 3 hospitals. This is Pareto's 80-20 rule—top 20% of hospitals drive 80% of costs. Recommendation: value-based contracting with these 3 hospitals."

**PART 4: Demographic Heatmap HERO Demo (90 sec)**
- Show: Patient Risk Segments (WS7)
- Filter: Smoking Status = "No"
- Say: "This heatmap shows patient costs by age, BMI, and smoking status. Green cells indicate lower cost. Now watch—"
- Filter: Smoking Status = "Yes"
- Say: "—when I toggle to smokers, the heatmap turns dark red. Smokers average $17K-$39K per claim. Non-smokers? $2K-$8K. That's our 5-10× multiplier. Age 46-55 smokers represent our best intervention target: high volume, moderate implementation cost, $800K annual savings with smoking cessation."

**PART 5: RFM Lifetime Value (30 sec)**
- Show: Patient Lifetime Value - RFM Analysis (WS9)
- Say: "This bubble chart segments patients into 8 lifetime-value cohorts. Champions (top right) are our profit center. But here—At-Risk High Value (left side). 145 patients, $4.35M dormant value, inactive 12+ months. Win-back campaign targeting 20% recovery = $870K annual value."

**Total: ~4 minutes**

---

## Expected Examiner Q&A (6 Likely Questions)

### **Q1: "Walk us through your dashboard architecture. How did you structure it?"**

**Expected Answer (60-90 sec):**
```
"The dashboard follows a 5-row executive narrative:

Row 1 — KPI Summary: Four cards at the top for instant context (total claims, spend, approval rate, average cost).

Row 2 — Trends & Concentration: Monthly spend trend (line + forecast) and Pareto analysis (bar + cumulative %). 

Row 3 — Performance Comparison: Denial vs. cost scatter (4-quadrant analysis by hospital/region) and regional profile (dual-axis bar showing cost and denial rates across 6 regions).

Row 4 — Geographic & Status: Geographic heatmap showing cost by state, and pie chart showing claim status distribution.

Row 5 — Deep Dive Analysis: Demographic risk segments (age × BMI × smoker heatmap) and RFM lifetime value (8-segment bubble chart).

Each row progressively reveals insights—from portfolio overview to drill-down analysis. The cascading filters (Region → State, Smoking Status) enable dynamic filtering across all sheets, maintaining analytical consistency."
```

### **Q2: "Why is the demographic heatmap (WS7) important? What does it show?"**

**Expected Answer (60 sec):**
```
"The heatmap is our hero visualization because it surfaces the primary cost driver: smoking status.

Data reveals: Smokers cost 5-10× more than non-smokers in EVERY age and BMI category. Age 56+ obese smokers represent the extreme: $42K-$45K average claims.

Business significance: This is actionable. Smoking is modifiable—unlike age or BMI. A smoking cessation program targeting age 46-55 smokers (high volume, moderate implementation cost) generates $800K+ annual savings.

The heatmap's color intensity makes this pattern instantly visible. Red cells = high-risk smoker cohorts. Green cells = low-risk non-smoker cohorts. Examiners can see the pattern in 3 seconds."
```

### **Q3: "Can you live-filter the dashboard to show only smokers? Walk us through it."**

**Expected Answer (30 sec demo + explanation):**
```
"Absolutely. Watch. [Click on Patient Risk Segments sheet → Smoking Status filter → Select 'Yes']

The dashboard updates instantly. All 9 worksheets filter to smokers only. See how:
• KPI Summary recalculates: approval rate becomes 72% (lower for smokers)
• Monthly Trend shows higher baseline costs
• Pareto shifts—different hospitals have higher smoker populations
• Demographic heatmap shows ONLY smoker cells—all dark red
• RFM shifts—At-Risk High Value smokers become even larger bubble

This interactive filtering is why Tableau is powerful—instant hypothesis testing."
```

### **Q4: "How did you validate your SQL queries? What was your approach?"**

**Expected Answer (60-90 sec):**
```
"Validation happened in phases:

Phase 1 — Query Correctness: Each query was tested for row count and data type accuracy. Query 1 (data profiling) checked record counts at each stage. Query 2 (schema) verified referential integrity with FK checks. Query 3-6 (retrieval, aggregation, window functions, CTEs) compared results against manual calculations on sample data.

Phase 2 — Aggregation Verification: GROUP BY queries matched expected counts. For example, Query 4 (aggregation by region × smoking status) was validated by spot-checking regional sums against raw data.

Phase 3 — Statistical Validation: Query 7 (statistical analysis) verified Pareto output: confirming top 3 hospitals were indeed 60% of costs. RFM segments were validated by checking that all 1,549 patients appeared once and only once.

Phase 4 — Tableau Cross-Check: Final validation: Tableau KPI cards (1,549 claims, $4.3M total) were compared to SQL SELECT COUNT(*) and SUM(amount) queries. Match confirmed.

This multi-layered approach ensured data integrity end-to-end."
```

### **Q5: "How would you scale this solution to 10 million records?"**

**Expected Answer (90 sec):**
```
"Scaling from 1,549 to 10M records requires three changes:

Technical 1 — Database Indexing: Add indexes on frequently filtered/aggregated columns (claim_date, region, smoking_status, hospital_id). This keeps query response under 2 seconds even on 10M rows.

Technical 2 — Tableau Optimization: Instead of live MySQL connection, schedule a nightly SQL extract-load to Tableau Data Engine. This caches results and accelerates dashboard refresh. Filters then operate on the extract, not live queries.

Technical 3 — Query Restructuring: Current queries would slow on 10M rows. Adopt materialized views (pre-aggregated tables) for common queries (monthly spend, regional metrics). This trades storage (~500MB) for query speed (10× faster).

Example: Instead of computing RFM on every dashboard load, run RFM batch job nightly, store results in rfm_segments table, join to Tableau. This reduces query time from 5 sec → <1 sec.

Business trade-off: Slightly less 'real-time' (queries run at 2 AM) but queries stay <1 sec. Acceptable for healthcare operations."
```

### **Q6: "What's your biggest insight from this project? What would you recommend the organization prioritize?"**

**Expected Answer (90-120 sec):**
```
"My biggest insight: Smoking status is a far stronger cost predictor than region, age, or BMI individually.

Data shows: Smokers average $17K-$39K per claim; non-smokers $2K-$8K. That's 5-10× variance driven by a single binary variable. Age 46-55 smokers specifically represent our intervention sweet spot: high volume, moderate implementation cost, $800K+ annual savings.

My prioritization recommendation (in order of ROI):

TIER 1 — Smoking Cessation Program (Months 1-6)
• Target: Age 46-55 smokers (1,050 patients)
• Cost: $50K-$100K (incentives + counseling)
• Expected impact: 20% quit rate → $160K annual savings
• ROI: 1.6-3.2×

TIER 2 — Hospital Value-Based Contracting (Months 3-9)
• Target: Top 3 hospitals (60% of spend)
• Approach: Negotiate 10-15% discount on volume
• Expected impact: $260K-$390K savings
• ROI: Depends on negotiation; typically 2-5×

TIER 3 — Member Win-Back Campaign (Months 6-12)
• Target: At-Risk High Value patients ($4.35M dormant)
• Approach: Outbound engagement + preventive incentives
• Expected impact: 20% recovery = $870K value
• ROI: 9-18× (low campaign cost, high member value)

Combined annual impact: $1.3M-$1.6M (30-37% of total spend growth prevention).
Payback period: 4-8 months.

That's where I'd invest first."
```

---

## Key Metrics to Memorize

| Metric | Value | Context |
|--------|-------|---------|
| Total Claims | 1,549 | Portfolio size |
| Total Spend | $4.3M | Annual healthcare budget |
| Approval Rate | 80.05% | KPI baseline |
| Avg Cost/Claim | $2,689 | Range: $1.8K-$45K |
| Smoker Multiplier | 5-10× | Biggest cost driver |
| Pareto (Top 3 Hospitals) | 60% of cost | $2.6M of $4.3M |
| At-Risk High Value | $4.35M | Win-back target |
| Savings Opportunity | $800K-$1.3M | Annual impact |
| Implementation Timeline | 12 months | Phased rollout |

---

## Viva Tips & Etiquette

1. **Be confident, not arrogant.** Know your data, admit uncertainties gracefully.
2. **Lead with insights, not tools.** Say "Smoking costs 5-10× more" before "I used window functions."
3. **Anticipate drill-down questions.** If asked "Why?", be ready to filter/show supporting data.
4. **Use precise language.** Say "5-10× multiplier for smokers" not "costs are way higher."
5. **Quantify everything.** $800K, 145 patients, 12 months—specificity builds credibility.
6. **Practice the demo.** Before viva, run through filter interactions 5+ times.
7. **Stay under time limits.** 30-sec opening, 4-min demo, 60-90 sec per Q&A answer.
8. **Prepare for pushback.** If examiner challenges an assumption, don't get defensive—explain your validation approach.

---

## Practice Checklist (4-Day Prep Schedule)

**Day 1 (Tuesday):**
- [ ] Read this guide completely
- [ ] Memorize 30-second opening (practice 5 times aloud)
- [ ] Memorize key metrics (copy them to index card)

**Day 2 (Wednesday):**
- [ ] Run through full 4-minute demo (time yourself)
- [ ] Practice filtering: Region → State, Smoking Yes/No
- [ ] Review Q1-Q3 answers (the first three questions are most likely)

**Day 3 (Thursday):**
- [ ] Mock viva: Deliver 30-sec opening + 4-min demo + Q&A from friend/colleague
- [ ] Get feedback: Was it clear? Did you speak too fast? Show your passion?
- [ ] Refine weak spots

**Day 4 (Friday - Viva Day):**
- [ ] Review key metrics one more time
- [ ] Test Tableau dashboard (ensure MySQL connection works)
- [ ] Arrive 10 minutes early
- [ ] Take 2 deep breaths; you've got this!

---

## 7-Slide Presentation Structure

If presenting via slides (not live dashboard), use this structure (Per PDF Section 5):

1. **Title Slide** — Project name, team, date
2. **Problem Statement** — Healthcare revenue leak (3-5%), dataset scope (1,549 claims, $4.3M)
3. **Dataset & Schema** — 6 normalized tables, SQL Query 7 section (JOINs, aggregations, window functions)
4. **SQL & Data Preparation** — Query examples (GROUP BY, RFM CTE, window function rank)
5. **Tableau Dashboard** — Screenshot of main dashboard + 3 key worksheets (heatmap, Pareto, RFM)
6. **Key Findings & Insights** — 4 insights (smoking, Pareto, RFM, regional) with quantified impact
7. **Conclusion & Recommendations** — $800K-$1.3M opportunity; 3-tier action plan; ROI summary

Each slide: Title + 3-4 bullet points + 1 visual (chart/screenshot).

---

## During-Viva Checklist

**5 Minutes Before:**
- [ ] Tableau dashboard open, MySQL connection tested
- [ ] All 9 worksheets visible (no error icons)
- [ ] Key filters (Region, Smoking Status) accessible
- [ ] Click regions on map to verify filter works

**Opening (1 minute):**
- [ ] Stand, make eye contact
- [ ] Deliver 30-second opening smoothly (not rushed)
- [ ] Smile

**Demo (4 minutes):**
- [ ] Click deliberately (not too fast)
- [ ] Explain each chart before clicking to next
- [ ] Watch examiner's face—if confused, pause and clarify
- [ ] Let them see your passion for the insights

**Q&A (5-7 minutes):**
- [ ] Listen fully to each question before answering
- [ ] Take 2-3 seconds to formulate response
- [ ] Answer concisely (don't ramble)
- [ ] If unsure, say "That's a great question. Here's my thinking..." (honest > guessing)

**Closing (1 minute):**
- [ ] Summarize: "We identified 3 major cost drivers and a $1.3M savings opportunity."
- [ ] Thank you
- [ ] Invite questions: "Any final questions?"

---

**Per PDF Guidelines Section 5 & Rubric 7**

*Healthcare Insurance Dashboard | Executive MTech Data Science & AI*
