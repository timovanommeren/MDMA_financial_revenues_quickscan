# Counting the Returns — MDMA Regulation Through a Financial Lens (Quickscan)

This repository contains a short, transparent **financial quickscan** estimating potential **public revenues under a state-run MDMA monopoly in the Netherlands**. The core calculations are:

**Demand = Number of Consumers x Frequency of Consumption x Intensity of Consumption.**

**Annual revenue = Demand × Market capture × (Price − Variable cost)**.


---

## What’s here

- **`MDMA_financial_revenues.Rmd`** — self-contained R Markdown with assumptions, simulation, and figures. Knit to HTML/PDF to reproduce results.
- **`Party_Panel.csv`** — empirical frequency-of-use data used in the simulation. 
- **Figures** — `revenue_boxplot.png` and `revenue_boxplot_with_outliers.png`.  
- **Project file** — `MDMA_financial_revenues_quickscan.Rproj` for convenience in RStudio.

A short policy report (separate document) motivates the approach and parameter choices.

---

## Main idea & headline numbers

- **Demand** built from prevalence (~550k consumers), frequency (~4.65 uses/year), and intensity (~2 × 80 mg per session).  
- **Market capture** (share moving from illicit to regulated): baseline **80%** (scenarios explore 40–90%).  
- **Price & costs**: baseline **€5.00** per 80 mg pill; variable cost **€2.00**.  
- **Point estimate**: **~€12.3 million/year**; simulation shows most outcomes in the **several-to-tens of millions** range.

---

## How to reproduce

1. Clone the repo and open `MDMA_financial_revenues_quickscan.Rproj` (or open the `.Rmd` directly). 
2. In R/RStudio, install `rmarkdown` if needed, then **Knit** `MDMA_financial_revenues.Rmd`.  
3. Outputs include the revenue distribution figure(s) shown in `/` (PNG files).

---


## Citation

If you use this analysis, please cite:
- *Counting the Returns: MDMA Regulation Through a Financial Lens* (policy note / quickscan). 
- This repository: <https://github.com/timovanommeren/MDMA_financial_revenues_quickscan>.
