library(dplyr)

abortion_data <- read.csv("../data/abortion_data.csv")

# propensity weights for being in restrictive state
propensity_model <- glm(
  highlyRestrictive ~ White + Hispanic + Black + Native + Asian +
    Pacific + MedianIncome + PopFemale + PctDem,
  family = binomial(), data = abortion_data
)

abortion_data <- abortion_data %>%
  mutate(
    propensity_score = predict(propensity_model, type = "response"),
    p_weight = ifelse(highlyRestrictive == 1,
      1 / propensity_score, 1 / (1 - propensity_score)
    )
  )

# linear regression
doubly_robust_model <- lm(abortPer1000 ~ highlyRestrictive + distMiles,
  weights = p_weight, data = abortion_data
)

save(doubly_robust_model, file = "../data/doubly_robust.Rda")
