#' Get Europarl
#' 
#' The European Parliament Proceedings Parallel Corpus 1996-2011, known as
#' [Europarl](http://www.statmt.org/europarl/) is a classical resource in the
#' CWB community for demonstration purposes. This package includes minimal
#' functionality to download and install the corpus into the R package.
#' @export europarl_download
#' @importFrom cwbtools registry_file_parse registry_file_write pkg_add_corpus
#' @importFrom utils download.file untar
#' @name europarl
europarl_download <- function(){
  
  pkg_data_dir <- file.path(system.file(package = "europarl"), "extdata", "cwb", "indexed_corpora")
  pkg_registry_dir <- file.path(system.file(package = "europarl"), "extdata", "cwb", "registry")
  if (!file.exists(pkg_data_dir)) dir.create(path = pkg_data_dir, recursive = TRUE)
  if (!file.exists(pkg_registry_dir)) dir.create(path = pkg_registry_dir, recursive = TRUE)
  
  message("... downloading tarball with Europarl corpus")
  europarl_url <- "http://corpora.linguistik.uni-erlangen.de/demos/download/Europarl3-CWB-2010-02-28.tar.gz"
  europarl_tarball <- file.path(tempdir(), basename(europarl_url))
  download.file(url = europarl_url, destfile = europarl_tarball)
  
  message("... extracting tarball")
  untar(tarfile = europarl_tarball, exdir = tempdir())
  
  europarl_registry_dir <- file.path(tempdir(), "Europarl3-CWB", "registry")
  europarl_data_dir <- file.path(tempdir(), "Europarl3-CWB", "data")
  corpora <- list.files(europarl_registry_dir)
  
  message("... moving corpora to R package 'europarl'")
  for (corpus in corpora){
    registry <- registry_file_parse(corpus = corpus, registry_dir = europarl_registry_dir)
    registry[["home"]] <- file.path(europarl_data_dir, gsub("^europarl-(.*)$", "\\1", corpus))
    registry_file_write(data = registry, corpus = corpus, registry_dir = europarl_registry_dir)
    pkg_add_corpus(pkg = "europarl",  corpus = corpus, registry = europarl_registry_dir)
  }

  unlink(file.path(tempdir(), "Europarl3-CWB"), recursive = TRUE)
  invisible(NULL)
}



