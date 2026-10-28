# R Programming — Lab & Practice Work

Coursework for the R Programming course, B.Tech Computer Engineering, Vidyalankar Institute of Technology (VIT), Mumbai.

**Author:** Vijay S Hanumandla · 23102C0071

The repository has two parts: weekly practice notebooks that follow the lectures, and lab experiments that apply R to real datasets.

## Repository structure

```
.
├── weekly-practice/
│   ├── week-02-data-types-and-vectors.ipynb
│   ├── week-03-vector-operations.ipynb
│   ├── week-04-matrices.ipynb
│   ├── week-04-matrix-operations.R
│   ├── week-05-missing-values-and-conditionals.ipynb
│   ├── week-06-loops-and-functions.ipynb
│   ├── week-07-sequences-repetition-and-dates.ipynb
│   ├── week-08-lists-and-factors.ipynb
│   ├── week-09-strings-and-data-frames.ipynb
│   └── week-10-pattern-matching-rpy2.ipynb
└── lab-experiments/
    ├── lab-02-data-cleaning/
    ├── lab-03-retail-sales-sql/
    ├── lab-04-image-classification-keras/
    ├── lab-05-social-network-analysis/
    ├── lab-06-statistical-analysis-penguins/
    ├── lab-07-customer-segmentation/
    └── lab-08-big-data-analytics/
```

## Weekly practice

| Week | Topic |
| --- | --- |
| 2 | Data types, modes and basic vector arithmetic |
| 3 | Vector operations and built-in math/summary functions |
| 4 | Matrices: creation, naming, transpose, row/column operations |
| 5 | Missing values (`NA`), `which`, `if` and `switch` |
| 6 | `for`/`while` loops and user-defined functions |
| 7 | `seq`, `rep`, sorting and date handling |
| 8 | Lists and factors |
| 9 | String functions (`grep`, `sub`, `gsub`) on data frames |
| 10 | Pattern matching, run from Python via `rpy2` |

## Lab experiments

| Lab | Title | Key packages |
| --- | --- | --- |
| 2 | Data cleaning — control flow (UCI Heart Disease) and missing-data handling (UCI Adult) | `dplyr`, `naniar`, `skimr` |
| 3 | Retail sales analysis with multi-source integration and SQL storage | `dplyr`, `RSQLite`, `DBI`, `jsonlite`, `readxl` |
| 4 | Binary image classification (car vs plane) with a neural network | `keras3`, `jpeg` |
| 5 | Social network analysis — centrality, hubs/authorities, community detection | `igraph` |
| 6 | Statistical analysis of Palmer Penguins — descriptive stats, t-tests, ANOVA | `palmerpenguins`, `tidyverse`, `car` |
| 7 | Customer segmentation and high-value customer prediction (UCI Online Retail) | K-Means, hierarchical clustering, PCA, Random Forest, SVM |
| 8 | High-performance big data analytics (NYC Taxi trips) | `data.table`, `foreach`, `doParallel`, `nanoparquet` |

## Running the notebooks

Most notebooks use the R kernel (`ir`) and were run on Google Colab (Runtime → Change runtime type → R). Week 10 and Lab 7 use a Python kernel. Install the packages listed in each notebook's first cell before running it.

Generated files such as the Lab 3 SQLite database (`*.db`) are not committed; running the notebook recreates them.

## Credits

The Week 4–10 notebooks and Labs 3, 5, 6, 7 and 8 were developed with lab partner [Dhruv D. Bhrasadiya](https://github.com/Dhruv-D-Bhrasadiya/R_programming).
