install_tidymass <- function() {
  ##download masstools first
  
  utils::download.file(url = "https://github.com/tidymass/packages_repo/raw/main/packages/masscleaner_1.0.6.tar.gz",
                       destfile = "masscleaner_1.0.6.tar.gz")
}
