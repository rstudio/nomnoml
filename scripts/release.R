# notes

devtools::check_win_devel(args = c("--compact-vignettes=both"))
# pak::pkg_install("r-lib/revdepcheck")
# revdepcheck::revdep_reset()
revdepcheck::revdep_check()
devtools::release(args = c("--compact-vignettes=both"))
