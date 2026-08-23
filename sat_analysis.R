# NYC Public High School SAT Performance Analysis
# Sara Tonekaboni
# STAT E-100: Statistical Methods and Data Analysis
# Harvard Extension School
#
# This script analyzes school-level SAT performance across
# New York City public high schools.

# ------------------------------------------------------------
# 1. Load and prepare the data
# ------------------------------------------------------------

nyc_sat <- read.csv(
  "Average NYC SAT Scores.csv",
  stringsAsFactors = FALSE
)

# Convert relevant variables to numeric
nyc_sat$`Average Score (SAT Math)` <-
  as.numeric(nyc_sat$`Average Score (SAT Math)`)

nyc_sat$`Average Score (SAT Reading)` <-
  as.numeric(nyc_sat$`Average Score (SAT Reading)`)

nyc_sat$`Average Score (SAT Writing)` <-
  as.numeric(nyc_sat$`Average Score (SAT Writing)`)

nyc_sat$`Student Enrollment` <-
  as.numeric(nyc_sat$`Student Enrollment`)


# ------------------------------------------------------------
# 2. Prepare SAT Math data
# ------------------------------------------------------------

sat_math <- na.omit(
  nyc_sat$`Average Score (SAT Math)`
)

borough_df <- nyc_sat[
  !is.na(nyc_sat$`Average Score (SAT Math)`),
]


# ------------------------------------------------------------
# 3. One-sample t-test
# H0: Mean SAT Math score = 500
# Ha: Mean SAT Math score < 500
# ------------------------------------------------------------

t_test_result <- t.test(
  sat_math,
  mu = 500,
  alternative = "less"
)

print(t_test_result)


# ------------------------------------------------------------
# 4. One-way ANOVA
# Test whether mean SAT Math scores differ by NYC borough
# ------------------------------------------------------------

anova_fit <- aov(
  `Average Score (SAT Math)` ~ Borough,
  data = borough_df
)

summary(anova_fit)

# Optional post-hoc comparison
TukeyHSD(anova_fit)


# ------------------------------------------------------------
# 5. Pearson correlation and simple linear regression
# SAT Reading vs. SAT Math
# ------------------------------------------------------------

mr <- nyc_sat[
  ,
  c(
    "Average Score (SAT Math)",
    "Average Score (SAT Reading)"
  )
]

mr <- na.omit(mr)

correlation_result <- cor.test(
  mr$`Average Score (SAT Math)`,
  mr$`Average Score (SAT Reading)`,
  method = "pearson"
)

print(correlation_result)

reg_fit <- lm(
  `Average Score (SAT Math)` ~ `Average Score (SAT Reading)`,
  data = mr
)

summary(reg_fit)


# ------------------------------------------------------------
# 6. Chi-square test of independence
# Borough vs. SAT Math score category
# ------------------------------------------------------------

borough_df$Math_500plus <- ifelse(
  borough_df$`Average Score (SAT Math)` >= 500,
  "500 or higher",
  "Below 500"
)

tbl <- table(
  borough_df$Borough,
  borough_df$Math_500plus
)

chisq.test(tbl)


# ------------------------------------------------------------
# 7. Data visualizations
# ------------------------------------------------------------

# Distribution of SAT Math scores
hist(
  sat_math,
  main = "Distribution of Average SAT Math Scores",
  xlab = "Average SAT Math Score"
)

# SAT Math scores by borough
boxplot(
  `Average Score (SAT Math)` ~ Borough,
  data = borough_df,
  main = "SAT Math by Borough",
  xlab = "Borough",
  ylab = "Average SAT Math Score"
)

# SAT Reading vs. SAT Math
plot(
  mr$`Average Score (SAT Reading)`,
  mr$`Average Score (SAT Math)`,
  xlab = "Average SAT Reading",
  ylab = "Average SAT Math",
  main = "SAT Reading vs. SAT Math"
)

abline(reg_fit)
