#' Install Europarl Corpora
#' 
#' The European Parliament Proceedings Parallel Corpus 1996-2011, known as
#' [Europarl](http://www.statmt.org/europarl/) is a classical resource in the
#' CWB community for demonstration purposes. This package includes minimal
#' functionality to download and install the corpus into the R package.
#' @param verbose A \code{logical} value, whether to output progress messages.
#' @export europarl_download
#' @importFrom cwbtools registry_file_parse registry_file_write pkg_add_corpus
#' @importFrom utils download.file untar
#' @importFrom stringi stri_enc_mark
#' @importFrom curl curl_download
#' @name europarl
europarl_download <- function(verbose = TRUE){
  
  pkg_data_dir <- file.path(system.file(package = "europarl"), "extdata", "cwb", "indexed_corpora")
  pkg_registry_dir <- file.path(system.file(package = "europarl"), "extdata", "cwb", "registry")
  if (!file.exists(pkg_data_dir)) dir.create(path = pkg_data_dir, recursive = TRUE)
  if (!file.exists(pkg_registry_dir)) dir.create(path = pkg_registry_dir, recursive = TRUE)
  
  message("... downloading tarball with Europarl corpus")
  europarl_url <- "http://corpora.linguistik.uni-erlangen.de/demos/download/Europarl3-CWB-2010-02-28.tar.gz"
  europarl_tarball <- file.path(tempdir(), basename(europarl_url), fsep = "/")
  
  if (.Platform$OS.type == "windows"){
    # use download.file because it is able to cope with murky user names / path names
    download.file(url = europarl_url, destfile = europarl_tarball, quiet = !verbose)
  } else {
    curl::curl_download(url = europarl_url, destfile = europarl_tarball, quiet = !verbose)
  }
  
  if (.Platform$OS.type == "windows" && stri_enc_mark(europarl_tarball) != "ASCII")
    europarl_tarball <- utils::shortPathName(europarl_tarball)

  if (verbose) message("... extracting tarball")
  untar(tarfile = europarl_tarball, exdir = tempdir())
  unlink(europarl_tarball)
  
  europarl_registry_dir <- file.path(tempdir(), "Europarl3-CWB", "registry")
  europarl_data_dir <- file.path(tempdir(), "Europarl3-CWB", "data")
  if (.Platform$OS.type == "windows" && stri_enc_mark(europarl_data_dir) != "ASCII")
    europarl_data_dir <- utils::shortPathName(europarl_data_dir)
  
  corpora <- list.files(europarl_registry_dir)
  message("... moving corpora to R package 'europarl'")
  for (corpus in corpora){
    registry_data <- registry_file_parse(corpus = corpus, registry_dir = europarl_registry_dir)
    home_dir <- file.path(europarl_data_dir, tolower(gsub("^europarl-(.*?)$", "\\1", registry_data[["id"]])), fsep = "/")
    if (.Platform$OS.type == "windows" && stri_enc_mark(home_dir) != "ASCII")
      home_dir <- utils::shortPathName(home_dir)
    registry_data[["home"]] <- home_dir
    registry_file_write(data = registry_data, corpus = corpus, registry_dir = europarl_registry_dir)
    pkg_add_corpus(pkg = "europarl", corpus = corpus, registry = europarl_registry_dir)
  }

  unlink(file.path(tempdir(), "Europarl3-CWB"), recursive = TRUE)
  invisible(corpora)
}
