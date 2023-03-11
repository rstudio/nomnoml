# notes

devtools::check_win_devel(args = c("--compact-vignettes=both"))
# pak::pkg_install("r-lib/revdepcheck")
# revdepcheck::revdep_reset()
revdepcheck::revdep_check()
rhub::check_for_cran(check_args = c("--as-cran", "--compact-vignettes=both"))
devtools::release(args = c("--compact-vignettes=both"))
