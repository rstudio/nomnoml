

# nomnoml -----------------------------------------------------------------

nomnoml_js <-  
  readLines(
    "https://raw.githubusercontent.com/skanaar/nomnoml/master/dist/nomnoml.js",
    warn = FALSE
  )


idx <- grep("nomnoml.version", nomnoml_js)
nomnoml_version <- gsub("^.*nomnoml.version = '(.*?)';$", "\\1", nomnoml_js[idx])

message("Updating to nomnoml version: ", nomnoml_version)

writeLines(
  nomnoml_js,
  file.path("inst", "htmlwidgets", "lib", "nomnoml", "nomnoml.js")
)

config_file <- file.path("inst", "htmlwidgets", "nomnoml.yaml")
config <- yaml::read_yaml(config_file)
config$dependencies[[3]]$version <- nomnoml_version
yaml::write_yaml(config, config_file)



# dagre -------------------------------------------------------------------


dagre_js <-  
  readLines(
    "https://raw.githubusercontent.com/skanaar/nomnoml/master/lib/dagre.min.js",
    warn = FALSE
  )


dagre_version <- gsub('^.*t.exports="(.*?)".*', "\\1", dagre_js)
dagre_version

message("Updating to dagre version: ", dagre_version)

writeLines(
  dagre_js,
  file.path("inst", "htmlwidgets", "lib", "dagre", "dagre.min.js")
)

config_file <- file.path("inst", "htmlwidgets", "nomnoml.yaml")
config <- yaml::read_yaml(config_file)
config$dependencies[[1]]$version <- dagre_version
yaml::write_yaml(config, config_file)



# lodash ------------------------------------------------------------------



lodash_version <- "4.17.15"

lodash_js <-  
  readLines(
    sprintf("https://raw.githubusercontent.com/lodash/lodash/%s-npm/lodash.js", lodash_version),
    warn = FALSE
  )


lodash_version

message("Updating to lodash version: ", lodash_version)

writeLines(
  lodash_js,
  file.path("inst", "htmlwidgets", "lib", "lodash", "lodash.js")
)

config_file <- file.path("inst", "htmlwidgets", "nomnoml.yaml")
config <- yaml::read_yaml(config_file)
config$dependencies[[2]]$version <- lodash_version
yaml::write_yaml(config, config_file)
