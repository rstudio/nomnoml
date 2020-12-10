

# nomnoml -----------------------------------------------------------------

nomnoml_js <-  
  readLines(
    "https://raw.githubusercontent.com/skanaar/nomnoml/master/dist/nomnoml.js",
    warn = FALSE
  )



idx <- grep("^\\s*var version", nomnoml_js)
nomnoml_version <- gsub("^\\s*var version = '(.*?)';$", "\\1", nomnoml_js[idx])

message("Updating to nomnoml version: ", nomnoml_version)

writeLines(
  nomnoml_js,
  file.path("inst", "htmlwidgets", "lib-raw", "nomnoml.js")
)

# config_file <- file.path("inst", "htmlwidgets", "nomnoml.yaml")
# config <- yaml::read_yaml(config_file)
# config$dependencies[[4]]$version <- nomnoml_version
# yaml::write_yaml(config, config_file)



# graphre -----------------------------------------------------------------


graphre_js <-  
  readLines(
    "https://raw.githubusercontent.com/skanaar/graphre/master/dist/graphre.js",
    warn = FALSE
  )


graphre_version <- gsub('^.*e.version="(.*?)".*', "\\1", graphre_js)
graphre_version

message("Updating to graphre version: ", graphre_version)

writeLines(
  graphre_js,
  file.path("inst", "htmlwidgets", "lib-raw", "graphre.js")
)

# config_file <- file.path("inst", "htmlwidgets", "nomnoml.yaml")
# config <- yaml::read_yaml(config_file)
# config$dependencies[[3]]$version <- graphre_version
# yaml::write_yaml(config, config_file)

