library(dplyr)

load("../data/cleaned_data.Rda")

# linear regression
doubly_robust_model <- lm(abortper1000 ~ highlyrestrictive + distmiles,
  weights = p_weight, data = abortion_data
)

save(doubly_robust_model, file = "../data/doubly_robust.Rda")
