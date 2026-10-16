## ----options, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 7,
                      fig.height = 4.5, fig.align = "center", dpi = 96)
old_options <- options(digits = 3, width = 100)

## ----setup----------------------------------------------------------------------------------------
library(latents)

## ----first-week-----------------------------------------------------------------------------------
first_week <- subset(student_esm, day <= 6)

## ----activities-----------------------------------------------------------------------------------
activities <- c("time_with_friends", "on_social_media", "tv_video_games",
                "listened_music", "sports", "walking", "reading",
                "part_time_job")

## ----lca------------------------------------------------------------------------------------------
lca <- multilca(first_week, vars = activities, id = "student",
                n_profiles = 2, n_group_classes = 2, n_starts = 3,
                tol = 1e-10, seed = 1)
lca

## ----responses------------------------------------------------------------------------------------
get_results(lca, "responses")

## ----responses-plot-------------------------------------------------------------------------------
plot(lca, what = "responses")

## ----profile-probabilities------------------------------------------------------------------------
get_results(lca, "profile_probabilities")

## ----probability-plot-----------------------------------------------------------------------------
plot(lca, what = "probabilities")

## ----entropy--------------------------------------------------------------------------------------
get_results(lca, "entropy")

## ----mixed----------------------------------------------------------------------------------------
mixed <- multilpa(first_week,
                  vars = c("happy", "relaxed", "exhausted", activities),
                  categorical = activities, id = "student", n_profiles = 2,
                  n_group_classes = 2, n_starts = 3, seed = 1)

## ----mixed-results--------------------------------------------------------------------------------
get_results(mixed)
get_results(mixed, "responses")

## ----ordinal--------------------------------------------------------------------------------------
affect <- c("happy", "relaxed", "worried", "exhausted")
ordinal <- multilpa(first_week, vars = c(affect, activities), id = "student",
                    ordinal = affect, categorical = activities, n_profiles = 2,
                    n_group_classes = 2, n_starts = 3, seed = 1)
ordinal

## ----ordinal-results------------------------------------------------------------------------------
head(get_results(ordinal, "ordinal"), 7)

## ----reference, eval = FALSE----------------------------------------------------------------------
# get_results(lca, "classification")               # class sizes and average posteriors
# get_results(lca, "residuals")                    # residual association within profiles
# parameter_inference(lca)                         # standard errors and intervals
# enumerate_classes(first_week, vars = activities, categorical = activities,
#                   id = "student", n_profiles = 2:3,
#                   n_group_classes = 1:2, seed = 1)  # compare numbers of classes (slow)
# plot(mixed)                                      # means of the continuous indicators
# plot(mixed, what = "responses")                  # answers to the categorical ones
# multilca(first_week, vars = activities, id = "student", n_profiles = 2,
#          n_group_classes = 2, missing = "fiml")  # incomplete answers, if any

## ----restore-options, include = FALSE-----------------------------------------
options(old_options)

