library(tidyverse)
source("cv_printing_functions.R")
cv_data <- create_CV_object(
  data_location = "https://docs.google.com/spreadsheets/d/1rcU-da7rHyNJdmyoNKk2Z-MdjWkxvwjFLIOrmg147Ao/edit?usp=sharing"
)

readr::write_rds(cv_data, 'cached_positions.rds')
cache_data <- TRUE


# Knit the HTML version
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "cv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = paste0("ssalazar_cv_", Sys.Date(), ".pdf"))
