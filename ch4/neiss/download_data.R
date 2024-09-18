dir.create("ch4/neiss")
#> Warning in dir.create("neiss"): 'neiss' already exists
download <- function(name) {
  url <- "https://raw.githubusercontent.com/hadley/mastering-shiny/main/neiss/"
  download.file(paste0(url, name), paste0("ch4/neiss/", name), quiet = TRUE)
}
download("injuries.tsv.gz")
download("population.tsv")
download("products.tsv")
