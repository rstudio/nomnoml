library(testthat)
library(nomnoml)

# longer delay to wait until chrome starts on GHA
# https://github.com/rstudio/chromote/issues/114#issuecomment-1675406196
options(chromote.timeout = 120)

test_check("nomnoml")