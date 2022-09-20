install_tidymass <-
  function(packages = c("core", "all"),
           from = c("gitee", "gitlab", "github")) {
    packages <- match.arg(packages)
    from <- match.arg(from)
    temp_path <- tempdir()
    dir.create(temp_path, showWarnings = FALSE, recursive = TRUE)
    
    file <-
      readr::read_csv(
        "https://raw.githubusercontent.com/tidymass/packages_repo/main/packages/file.csv",
        show_col_types = FALSE
      )
    
    if (packages == "core") {
      package_list <-
        c(
          "masstools",
          "massdataset",
          "metid",
          "massstat",
          "massqc",
          "massprocessor",
          "masscleaner",
          "metpath",
          "tidymass"
        )
    } else{
      package_list <-
        c(
          "masstools",
          "massdataset",
          "metid",
          "massstat",
          "massqc",
          "massprocessor",
          "masscleaner",
          "metpath",
          "tidymass",
          "massconverter",
          "massdatabase"
        )
    }
    
    package_list %>%
      purrr::walk(function(x) {
        message("Install ", x, "...")
        ##install masstools first
        url <-
          paste0(
            "https://github.com/tidymass/packages_repo/raw/main/packages/",
            file$file_name.y[file$package == x]
          )
        utils::download.file(url = url,
                             destfile = file.path(temp_path, file$file_name.y[file$package == x]))
        
        tryCatch(
          detach(name = paste0("package:", x)),
          error = function(e) {
            message(x, " in not loaded")
          }
        )
        
        install.packages(file.path(temp_path, file$file_name.y[file$package == x]),
                         repos = NULL,
                         type = "source")
        
        unlink(file.path(temp_path, file$file_name.y[file$package == x]))
      })
    message("All done.")
  }
