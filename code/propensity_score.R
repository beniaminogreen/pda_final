abortion <- read.csv("../data/abortion_data.csv")
# propensity weights for being in restrictive state
prop.weights <- glm(highlyRestrictive ~ White + Hispanic + Black + Native + Asian +
  Pacific + MedianIncome + PopFemale + PctDem,
family = binomial(), data = abortion
)
abortion$prop <- (predict(prop.weights, type = "response"))
abortion$p.weight <- ifelse(abortion$highlyRestrictive == 1,
  1 / abortion$prop, 1 / (1 - abortion$prop)
)
# linear regression
abortion.lm <- lm(abortPer1000 ~ highlyRestrictive + distMiles,
  weights = p.weight, data = abortion
)
summary(abortion.lm)
