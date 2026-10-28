# ============================================================
# ASSIGNMENT 2 - R PROGRAMMING
# LAB 3: CONTROL FLOW FOR DATA CLEANING
# ============================================================

# Load required packages
library(readr)
library(dplyr)
# ============================================================
# LOAD HEART DISEASE DATASET
# ============================================================

heart_url <- "https://archive.ics.uci.edu/static/public/45/data.csv"

heart <- read.csv(
  heart_url,
  header = TRUE,
  na.strings = c("?", "")
)

print(dim(heart))
# Check column names

print(names(heart))

# View first six rows

print(head(heart))


# Check dataset structure

str(heart)


# Summary of resting blood pressure

summary(heart$trestbps)





# ============================================================
# STEP 3 - INTRODUCE BAD BP VALUES
# ============================================================

heart$trestbps[c(5, 10, 15)] <- c(-20, NA, 320)

print(heart$trestbps[c(5, 10, 15)])




# ============================================================
# STEP 4 - BP CLEANING FUNCTION
# ============================================================

clean_bp <- function(bp) {
  
  if (is.na(bp)) {
    return(NA)
    
  } else if (bp < 0) {
    return(NA)
    
  } else if (bp > 250) {
    return(250)
    
  } else {
    return(bp)
  }
}

# Test the cleaning function

print(clean_bp(-20))
print(clean_bp(NA))
print(clean_bp(320))
print(clean_bp(120))



# ============================================================
# STEP 5 - APPLY CLEANING FUNCTION
# ============================================================

heart$trestbps_clean <- sapply(
  heart$trestbps,
  clean_bp
)

print(
  head(
    heart[, c("trestbps", "trestbps_clean")]
  )
)


# ============================================================
# STEP 6 - ERROR HANDLING USING tryCatch()
# ============================================================

safe_mean_bp <- function(bp) {
  
  tryCatch({
    
    if (all(is.na(bp))) {
      stop("Cannot calculate mean: all BP values are missing.")
    }
    
    mean(bp, na.rm = TRUE)
    
  }, error = function(e) {
    
    message("BP mean error: ", e$message)
    
    return(NA)
  })
}

# Test safe mean calculation

print(safe_mean_bp(heart$trestbps_clean))


print(safe_mean_bp(c(NA, NA, NA)))



# ============================================================
# STEP 7 - SAFE CHOLESTEROL / BP RATIO
# ============================================================

safe_ratio <- function(chol, bp) {
  
  tryCatch({
    
    if (is.na(chol) || is.na(bp)) {
      stop("Ratio cannot be calculated because cholesterol or BP is NA.")
    }
    
    if (bp == 0) {
      stop("Ratio cannot be calculated because BP is zero.")
    }
    
    if (bp < 0 || bp > 250) {
      stop("Ratio cannot be calculated because BP is invalid.")
    }
    
    chol / bp
    
  }, error = function(e) {
    
    message("Ratio error: ", e$message)
    
    return(NA)
  })
}



# Test safe ratio

print(safe_ratio(200, 120))
print(safe_ratio(200, 0))
print(safe_ratio(200, NA))
print(safe_ratio(200, -10))
print(safe_ratio(200, 300))


# ============================================================
# STEP 8 - APPLY SAFE RATIO TO DATASET
# ============================================================

heart$chol_bp_ratio <- mapply(
  safe_ratio,
  heart$chol,
  heart$trestbps_clean
)

print(
  head(
    heart[, c("chol", "trestbps_clean", "chol_bp_ratio")]
  )
)


# ============================================================
# STEP 9 - LOOP-BASED CLEANING
# ============================================================

bp_loop <- heart$trestbps

start_loop <- Sys.time()

for (i in seq_along(bp_loop)) {
  
  if (is.na(bp_loop[i])) {
    bp_loop[i] <- NA
    
  } else if (bp_loop[i] < 0) {
    bp_loop[i] <- NA
    
  } else if (bp_loop[i] > 250) {
    bp_loop[i] <- 250
  }
}

end_loop <- Sys.time()

loop_time <- end_loop - start_loop

print(loop_time)


# ============================================================
# STEP 9 - LOOP-BASED CLEANING
# ============================================================

bp_loop <- heart$trestbps

start_loop <- Sys.time()

for (i in seq_along(bp_loop)) {
  
  if (is.na(bp_loop[i])) {
    bp_loop[i] <- NA
    
  } else if (bp_loop[i] < 0) {
    bp_loop[i] <- NA
    
  } else if (bp_loop[i] > 250) {
    bp_loop[i] <- 250
  }
}

end_loop <- Sys.time()

loop_time <- end_loop - start_loop

print(loop_time)


# ============================================================
# STEP 10 - VECTORIZED CLEANING
# ============================================================

bp_vectorized <- heart$trestbps

start_vector <- Sys.time()

bp_vectorized[bp_vectorized < 0] <- NA

bp_vectorized[bp_vectorized > 250] <- 250

end_vector <- Sys.time()

vector_time <- end_vector - start_vector

print(vector_time)



# ============================================================
# STEP 11 - PERFORMANCE COMPARISON
# ============================================================

print("Loop execution time:")
print(loop_time)

print("Vectorized execution time:")
print(vector_time)

if (vector_time < loop_time) {
  
  print("Vectorized approach is faster.")
  
} else if (loop_time < vector_time) {
  
  print("Loop approach is faster for this run.")
  
} else {
  
  print("Both approaches took approximately the same time.")
}




# ============================================================
# STEP 12 - VALIDATE CLEANED BP DATA
# ============================================================

print("Number of missing BP values:")
print(sum(is.na(bp_vectorized)))

print("Minimum BP:")
print(min(bp_vectorized, na.rm = TRUE))

print("Maximum BP:")
print(max(bp_vectorized, na.rm = TRUE))

print("Mean BP:")
print(mean(bp_vectorized, na.rm = TRUE))

print("Median BP:")
print(median(bp_vectorized, na.rm = TRUE))


# Check for invalid BP values

print("Negative BP values remaining:")
print(sum(bp_vectorized < 0, na.rm = TRUE))

print("BP values greater than 250 remaining:")
print(sum(bp_vectorized > 250, na.rm = TRUE))

# ============================================================
# STEP 13 - UPDATE DATASET WITH CLEANED BP
# ============================================================

heart$trestbps <- bp_vectorized

print(
  summary(heart$trestbps)
)


# ============================================================
# STEP 14 - SAVE CLEANED HEART DATA
# ============================================================

write.csv(
  heart,
  "cleaned_heart_data.csv",
  row.names = FALSE
)

print("cleaned_heart_data.csv created successfully.")