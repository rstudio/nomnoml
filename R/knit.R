resize_image_if_needed <- function(image, max_width, max_height) {
  image_name <- basename(image)
  image_noext <- tools::file_path_sans_ext(image_name)
  image_resized <- file.path(dirname(image), paste0(image_noext, "-resized.png"))
  
  original <- png::readPNG(image)
  org_width <- ncol(original)
  org_height <- nrow(original)
  
  ratio <- org_width / org_height
  max_ratio <- max_width / max_height
  
  output <- grDevices::png(image_resized, width = max_width, height = max_height)
  graphics::plot.new()
  graphics::par(mar=c(0,0,0,0))
  graphics::plot.window(c(0, max_width), c(0, max_height), xaxs = "i", yaxs = "i")
  usr <- graphics::par("usr")
  
  if (max_ratio > 1 && ratio < 1 || max_ratio < 1 && ratio > 1) {
    tar_height <- ratio * max_width
    graphics::rasterImage(
      original, 
      usr[1], 
      usr[3] + (max_height - tar_height) / 2, 
      usr[2], 
      usr[4] - (max_height - tar_height) / 2
    )
    grDevices::dev.off()
  }
  else {
    tar_width <- ratio * max_height
    graphics::rasterImage(
      original, 
      usr[1] + (max_width - tar_width) / 2, 
      usr[3], 
      usr[2] - (max_width - tar_width) / 2, usr[4]
    )
    grDevices::dev.off()
  }
  
  image_resized
}

knit_nomnoml <- function (options) {
  knit_print <- get("knit_print", envir = asNamespace("knitr"))
  engine_output <- get("engine_output", envir = asNamespace("knitr"))
  code <- paste(options$code, collapse = "\n")
  if (isTRUE(options$escape)) 
    usecode <- code
  else {
    usecode <- gsub("'", "\\\\'", code)
    usecode <- eval(parse(text = paste0("'", usecode, "'")))
  }
  widget_width <- options$width
  widget_height <- options$height
  fixed_image <- FALSE
  
  # is_rstudio should only be TRUE if the "knit" button was pressed
  is_rstudio <- 
    identical(.Platform$GUI, "RStudio") && 
    !getOption("knitr.in.progress", FALSE)
  
  if (!is.null(widget_width) && !is.null(widget_width)) {
    fixed_image <- all(grepl("px$", c(widget_width, widget_height)))
  }
  
  if (fixed_image && !is_rstudio) {
    fixed_width <- as.numeric(gsub("px$", "", options$width))
    fixed_height <- as.numeric(gsub("px$", "", options$height))
    
    widget_width <- 2 * fixed_width
    widget_height <- 2 * fixed_height
  }
  
  if ("reactive" %in% class(options$data)) {
    widget <- renderNomnoml({
      nomnoml(
        usecode
      )
    })
  } else {
    widget <- nomnoml(
      code = usecode,
      width = widget_width,
      height = widget_height
    )
  }
  
  code_output <- structure(list(src = code), class = 'source')
  
  if (is_rstudio) { return(widget) }
  
  if (fixed_image) {
    file_name <- tempfile("widget_", fileext = ".html")
    png_name <- tempfile(fileext = ".png")
    url_name <- normalizePath(file_name, winslash = "/", mustWork = FALSE)
    png_name <- normalizePath(png_name, winslash = "/", mustWork = FALSE)
    
    htmlwidgets::saveWidget(widget, file_name, selfcontained = FALSE)
    webshot2::webshot(url = url_name,  file = png_name, 
                      selector = "canvas", 
                      quiet = TRUE)
    
    png <- resize_image_if_needed(png_name, widget_width, widget_height)
    
    res <- readBin(png, "raw", file.info(png)[, "size"])
    image_output <- structure(
      list(image = res, extension = ".png"), 
      class = "html_screenshot"
    )
    
    if (identical(options$echo, FALSE)) {
      render_output <- list(image_output)
    } else {
      render_output <- list(code_output, image_output)
    }
    
    return(
      engine_output(options, out = render_output)
    )
  }
  
  # not fixed image:
  
  widget_output <- knit_print(widget, options = options)
  
  if (identical(options$echo, FALSE)) {
    render_output <- list(widget_output)
  } else {
    render_output <- list(code_output, widget_output)
  }
  
  engine_output(options, out = render_output)
  
}