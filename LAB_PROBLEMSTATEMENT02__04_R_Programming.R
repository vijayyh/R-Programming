# ============================================================
# ASSIGNMENT 2 - R PROGRAMMING
# LAB 4: ADVANCED MISSING DATA HANDLING
# ============================================================

# Install required packages
install.packages("naniar")
install.packages("skimr")
install.packages("readr")

# ============================================================
# LOAD REQUIRED PACKAGES
# ============================================================

library(naniar)
library(skimr)
library(readr)

# ============================================================
# LOAD UCI ADULT DATASET
# ============================================================

adult_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"

adult <- read.csv(
  adult_url,
  header = FALSE,
  na.strings = "?"
)

# Assign column names

names(adult) <- c(
  "age",
  "workclass",
  "fnlwgt",
  "education",
  "education_num",
  "marital_status",
  "occupation",
  "relationship",
  "race",
  "sex",
  "capital_gain",
  "capital_loss",
  "hours_per_week",
  "native_country",
  "income"
)

print(dim(adult))


# View first 6 rows

print(head(adult))



# ============================================================
# REMOVE EXTRA SPACES FROM CHARACTER COLUMNS
# ============================================================

adult[] <- lapply(
  adult,
  function(x) {
    if (is.character(x)) {
      trimws(x)
    } else {
      x
    }
  }
)

print(head(adult))




# ============================================================
# INTRODUCE DIFFERENT TYPES OF MISSING / INVALID DATA
# ============================================================

# NA
adult$age[1] <- NA

# Blank string
adult$workclass[2] <- ""

# NaN
adult$education_num[3] <- NaN

# Impossible age
adult$age[4] <- 999

# Additional missing values
adult$hours_per_week[5] <- NA
adult$occupation[6] <- ""

print(adult[1:6, ])

# ============================================================
# IDENTIFY NA VALUES
# ============================================================

print("Total NA values in dataset:")

print(
  sum(is.na(adult))
)


# ============================================================
# IDENTIFY NaN VALUES
# ============================================================

print("Total NaN values in dataset:")

print(
  sum(is.nan(adult$education_num))
)


# ============================================================
# DEMONSTRATE NULL
# ============================================================

test_object <- NULL

print("Is test_object NULL?")

print(
  is.null(test_object)
)

print("Is adult NULL?")

print(
  is.null(adult)
)


# ============================================================
# IDENTIFY BLANK STRINGS
# ============================================================

print("Blank workclass values:")

print(
  sum(adult$workclass == "", na.rm = TRUE)
)

print("Blank occupation values:")

print(
  sum(adult$occupation == "", na.rm = TRUE)
)


# ============================================================
# IDENTIFY IMPOSSIBLE AGE VALUES
# ============================================================

print("Number of age = 999 values:")

print(
  sum(adult$age == 999, na.rm = TRUE)
)

# ============================================================
# VARIABLE-WISE MISSING VALUE SUMMARY
# ============================================================

missing_summary_before <- naniar::miss_var_summary(adult)

print(missing_summary_before)






# ============================================================
# STEP 14 - BASIC DATA CLEANING
# ============================================================

# Convert impossible age to NA
adult$age[adult$age == 999] <- NA

# Replace blank categorical values with "Unknown"
adult$workclass[adult$workclass == ""] <- "Unknown"
adult$occupation[adult$occupation == ""] <- "Unknown"

# Check the changes
print(adult[1:6, c("age", "workclass", "education_num",
                   "occupation", "hours_per_week")])




# ============================================================
# STEP 15 - CUSTOM MEDIAN IMPUTATION FUNCTION
# ============================================================

median_impute <- function(x) {
  
  if (!is.numeric(x)) {
    stop("Median imputation can only be applied to numeric data.")
  }
  
  med <- median(x, na.rm = TRUE)
  
  x[is.na(x) | is.nan(x)] <- med
  
  return(x)
}




# ============================================================
# STEP 16 - APPLY MEDIAN IMPUTATION
# ============================================================

adult$age <- median_impute(adult$age)

adult$education_num <- median_impute(adult$education_num)

adult$hours_per_week <- median_impute(adult$hours_per_week)

print(
  summary(
    adult[, c("age", "education_num", "hours_per_week")]
  )
)



# ============================================================
# STEP 17 - CHECK MISSING VALUES AFTER IMPUTATION
# ============================================================

print("Missing values after numeric imputation:")

print(
  sum(is.na(adult))
)

print(sum(is.na(adult)))



# ============================================================
# STEP 18 - COMPLETE CASE CHECK
# ============================================================

complete_rows <- complete.cases(adult)

print("Number of complete rows:")
print(sum(complete_rows))

print("Number of incomplete rows:")
print(sum(!complete_rows))



# ============================================================
# STEP 19 - MISSING SUMMARY AFTER CLEANING
# ============================================================

missing_summary_after <- naniar::miss_var_summary(adult)

print(missing_summary_after)



# ============================================================
# STEP 20 - BEFORE VS AFTER COMPARISON
# ============================================================

print("Missing values BEFORE cleaning:")
print(missing_summary_before)

print("Missing values AFTER cleaning:")
print(missing_summary_after)



# ============================================================
# STEP 21 - MISSINGNESS VISUALIZATION
# ============================================================

print("Missingness visualization:")

naniar::vis_miss(adult)


# ============================================================
# STEP 22 - DATASET VALIDATION USING SKIMR
# ============================================================

skim_result <- skimr::skim(adult)

print(skim_result)


# ============================================================
# STEP 23 - FINAL VALIDATION
# ============================================================

print("Final dataset dimensions:")
print(dim(adult))

print("Total missing values:")
print(sum(is.na(adult)))

print("Total NaN values:")
print(sum(is.nan(adult$education_num)))

print("Impossible age values:")
print(sum(adult$age == 999, na.rm = TRUE))

print("Complete rows:")
print(sum(complete.cases(adult)))



# ============================================================
# STEP 24 - SAVE CLEANED ADULT DATASET
# ============================================================

write.csv(
  adult,
  "cleaned_adult_data.csv",
  row.names = FALSE
)

print("cleaned_adult_data.csv created successfully.")