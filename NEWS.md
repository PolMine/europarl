europarl 0.0.4
==============

- The `europarl_download()`-function takes advantage of insights gained in the 
  context of the development of the [cwbtools](https://CRAN.R-project.org/package=cwbtools)
  how R packages can be used to ship corpora in a portable manner. Most importantly,
  moving the corpus into the directory structure of the package and being able to 
  use the corpus will now be more robust in the face of potential oddities of
  path names on Windows systems (whitespace in directory names, special 
  characters in user names).
- The README has been developed into a somewhat telling intoduction.
