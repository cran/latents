## ----options, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 7,
                      fig.height = 4.5, fig.align = "center", dpi = 96)
old_options <- options(digits = 3, width = 100)

## ----setup----------------------------------------------------------------------------------------
library(latents)

## ----descriptives---------------------------------------------------------------------------------
descriptives(course_engagement,
             vars = c("browse", "lectures", "forum_read", "forum_post",
                      "attendance"),
             id = "student")

## ----fit------------------------------------------------------------------------------------------
fit <- multilpa(course_engagement,
                vars = c("browse", "lectures", "forum_read", "forum_post",
                         "attendance"),
                id = "student", n_profiles = 2, n_group_classes = 2,
                n_starts = 10, seed = 1)
fit

## ----starts---------------------------------------------------------------------------------------
get_results(fit, "starts")

## ----profiles-------------------------------------------------------------------------------------
get_results(fit)

## ----profile-plot---------------------------------------------------------------------------------
plot(fit)

## ----profile-probabilities------------------------------------------------------------------------
get_results(fit, "profile_probabilities")

## ----probability-plot-----------------------------------------------------------------------------
plot(fit, what = "probabilities")

## ----counts---------------------------------------------------------------------------------------
get_results(fit, "counts")

## ----entropy--------------------------------------------------------------------------------------
get_results(fit, "entropy")

## ----assignments----------------------------------------------------------------------------------
get_results(fit, "assignments", data = course_engagement) |> head()

## ----recovery-------------------------------------------------------------------------------------
get_results(fit, "assignments", data = course_engagement,
            truth = c("engagement", "student_type"))

## ----reference, eval = FALSE----------------------------------------------------------------------
# # Tables: get_results(fit, what)
# get_results(fit, "all")                          # every table, as a named list
# get_results(fit, "covariances")                  # within-profile residual covariances
# get_results(fit, "posteriors")                   # one row per observation and profile
# get_results(fit, "posteriors", format = "wide")  # one row per observation
# get_results(fit, "group_posteriors")             # one row per group and group class
# get_results(fit, "classification")               # class sizes and average posteriors
# get_results(fit, "average_posteriors")           # mean posterior by assigned class
# get_results(fit, "classification_errors")        # P(assigned class | true class)
# get_results(fit, "bch_weights")                  # weights for three-step analysis
# get_results(fit, "residuals")                    # residual correlations within profiles
# get_results(fit, "information_criteria")         # AIC, BIC and the other criteria
# get_results(fit, "model")                        # one row describing the fit
# get_results(fit, "data")                         # the variables used in the fit
# as.data.frame(fit)                               # the profile table
# 
# # Summaries and diagnostics
# descriptives(fit)                    # indicator summaries with the ICC
# descriptives(fit, by = "profile")    # the same, by assigned profile
# diagnostics(fit)                     # every classification diagnostic
# report(fit)                          # summary, diagnostics and plots together
# 
# # Inference and likelihood
# parameter_inference(fit)             # standard errors and Wald intervals
# confint(fit)                         # confidence intervals
# vcov(fit)                            # covariance matrix of the estimates
# logLik(fit)                          # log likelihood
# AIC(fit)                             # Akaike information criterion
# BIC(fit)                             # BIC with the number of groups
# nobs(fit)                            # number of groups
# 
# # Plots: plot(fit, what)
# plot_views()                # every view and what it shows
# plot(fit, what = "bars")             # profile means with 95% intervals
# plot(fit, what = "heatmap")          # means in standard deviations
# plot(fit, what = "sizes")            # effective size of each profile
# plot(fit, what = "entropy")          # per-case classification uncertainty
# plot(fit, what = "posteriors")       # posterior of each assigned profile
# plot(fit, what = "avepp")            # average posteriors, assigned by posterior class
# plot(fit, what = "all")              # every view this fit supports
# 
# # Other functions
# sensitivity(fit, seeds = 1:10)       # refits under several seeds
# starting_values(fit)                 # parameters to start another fit

## ----weights--------------------------------------------------------------------------------------
weighted_data <- transform(course_engagement,
                           survey_weight = ifelse(student_type == "wavering", 2, 1))
weighted_fit <- multilpa(weighted_data,
                         vars = c("browse", "lectures", "forum_read",
                                  "forum_post", "attendance"),
                         id = "student", n_profiles = 2, n_group_classes = 2,
                         weights = "survey_weight", n_starts = 10, seed = 1)
weighted_fit

## ----weights-inference----------------------------------------------------------------------------
head(parameter_inference(weighted_fit), 4)

## ----summary--------------------------------------------------------------------------------------
print(summary(fit), rows = 3)

## ----restore-options, include = FALSE-----------------------------------------
options(old_options)

