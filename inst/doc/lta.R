## ----options, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 7,
                      fig.height = 4.5, fig.align = "center", dpi = 96)
old_options <- options(digits = 3, width = 100)

## ----setup----------------------------------------------------------------------------------------
library(latents)

## ----fit------------------------------------------------------------------------------------------
moves <- lta(course_engagement,
             vars = c("browse", "lectures", "forum_read", "forum_post",
                      "attendance"),
             id = "student", time = "sequence",
             n_profiles = 3, n_group_classes = 2, n_starts = 3, seed = 1)
moves

## ----starts---------------------------------------------------------------------------------------
get_results(moves, "starts")

## ----profiles-------------------------------------------------------------------------------------
plot(moves)

## ----heatmap--------------------------------------------------------------------------------------
plot(moves, what = "heatmap")

## ----initial--------------------------------------------------------------------------------------
get_results(moves, "initial")

## ----transitions----------------------------------------------------------------------------------
get_results(moves, "transitions")

## ----transition-plot------------------------------------------------------------------------------
plot(moves, what = "transitions")

## ----sequences, fig.height = 6--------------------------------------------------------------------
plot(moves, what = "sequences")

## ----entropy--------------------------------------------------------------------------------------
get_results(moves, "entropy")

## ----entropy-plot---------------------------------------------------------------------------------
plot(moves, what = "entropy")

## ----posteriors-plot------------------------------------------------------------------------------
plot(moves, what = "posteriors")

## ----networks, message = FALSE, eval = requireNamespace("tna", quietly = TRUE)--------------------
plot(get_tna(moves))
plot(get_group_tna(moves))

## ----grade----------------------------------------------------------------------------------------
activity <- c("browse", "lectures", "forum_read", "forum_post", "attendance")
homogeneous <- lta(course_engagement, activity, "student", n_profiles = 2,
                   time = "sequence", seed = 1)
grade <- lta(course_engagement, activity, "student", n_profiles = 2,
             time = "sequence", transition_covariates = "previous_grade",
             seed = 1)
get_results(grade, "transition_coefficients")

## ----second-order---------------------------------------------------------------------------------
second <- lta(course_engagement, activity, "student", n_profiles = 2,
              time = "sequence", order = 2, seed = 1)
BIC(homogeneous, grade, second)

## ----check-extensions, include = FALSE------------------------------------------------------------
slopes <- subset(get_results(grade, "transition_coefficients"),
                 term == "previous_grade")
stopifnot(all(slopes$conf_low < 0 & slopes$conf_high > 0),
          BIC(homogeneous) < BIC(grade), BIC(homogeneous) < BIC(second))

## ----restore-options, include = FALSE-----------------------------------------
options(old_options)

