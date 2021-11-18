library(tidyverse)

raw_data <- read_csv("../data/abortion_data.csv")

# make all column names lowercase
abortion_data <- raw_data %>%
  rename_all(tolower)

# create model for propensity_scores
propensity_model <- glm(
  highlyrestrictive ~ white + hispanic + black + native + asian +
    pacific + medianincome + popfemale + pctdem,
  family = binomial(), data = abortion_data
)

# add propensity score columns to data
abortion_data <- abortion_data %>%
  mutate(
    propensity_score = predict(propensity_model, type = "response"),
    p_weight = ifelse(highlyrestrictive == 1,
      1 / propensity_score, 1 / (1 - propensity_score)
    )
  )

# check that no rows were deleted
stopifnot(nrow(abortion_data) == nrow(raw_data))

save(abortion_data, file = "../data/cleaned_data.Rda")
