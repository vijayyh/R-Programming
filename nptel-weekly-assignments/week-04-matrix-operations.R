# FRS Week 04
# Lecture 13 - Matrix Operations
# Row, Column & Other Operations


# Creating a matrix
x = matrix(nrow = 4, ncol = 3, data = c(1:12))

x

# Renaming row names

rownames(x) = c("r1", "r2", "r3", "r4")

x

# Renaming column names

colnames(x) = c("c1", "c2", "c3")

x

# Assigning a specified number to all matrix elements

x = matrix(nrow = 4, ncol = 2, data = 2)

x


# Identity matrix

d = diag(1, nrow = 3, ncol = 3)

d





# Diagonal matrix with all diagonal elements as 5

d = diag(5, nrow = 3, ncol = 3)

d


# Transpose of a matrix

x = matrix(nrow = 4, ncol = 2, data = 1:8, byrow = T)

x

xt = t(x)

xt



# Row sums

x = matrix(nrow = 4, ncol = 2, data = 1:8)

rowSums(x)


# Column sums

colSums(x)



# Row means

rowMeans(x)

# Column means

colMeans(x)

