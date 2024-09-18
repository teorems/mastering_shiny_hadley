injuries <- vroom::vroom("injuries.tsv.gz")
products <- vroom::vroom("products.tsv")
population <- vroom::vroom("population.tsv")
prod_codes <- setNames(products$prod_code, products$title)
