
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Travis-CI Build
Status](https://api.travis-ci.org/PolMine/europarl.svg?branch=master)](https://travis-ci.org/PolMine/europarl)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/PolMine/europarl?branch=master&svg=true)](https://ci.appveyor.com/project/PolMine/europarl)

## About the ‘europarl’ R package

This is a R data package that includes minimal functionality to download
a subset of the Europarl Corpus (Koehn 2005), version 3, pre-indexed for
the IMS Open Corpus Workbench (Evert and Hardie 2011). It is based on
the POS-tagged, lemmatised and sentence-aligned distribution offered by
the [OPUS project](http://urd.let.rug.nl/tiedeman/OPUS/Europarl3.php)
and covers the languages English, Dutch, French, German, Italian and
Spanish. The six corpora are available under the CWB names EUROPARL-EN,
EUROPARL-NL, EUROPARL-FR, EUROPARL-DE, EUROPARL-IT and EUROPARL-ES.

## Installation

The easiest way to install the *europarl* package is to install it from
the
[drat](https://cran.r-project.org/web/packages/drat/vignettes/DratFAQ.html)-repository
of the [PolMine Project](http://www.polmine.de).

``` r
install.packages("europarl", repos = "https://polmine.github.io/drat")
```

The package includes only a simple installer function
`europarl_download()` that will download the Europarl corpus from the
default location (a server of the University of Erlangen).

``` r
europarl::europarl_download()
```

Note that the tarball that is downloaded is larger than 2GB. A good
internet connection and some patience will be an advantage.

The indexed corpus will be stored in a subdirectory of the package
(./extdata/cwb/).

## Usage

The idea to use R packages for shipping corpora has been developed in
the context of the PolMine Project (Blätte 2018). The most convenient
way to use the data will be to use the
[polmineR](https://CRAN.R-project.org/package=polmineR) package. To be
able to access that data within the package, call the
`use()`-function.

``` r
if (!"polmineR" %in% rownames(installed.packages())) install.packages("polmineR")
library(polmineR)
use("europarl")
```

If the corpora have been downloaded, you should see something like this.

    ## ... activating corpus: EUROPARL-DE

    ## ... activating corpus: EUROPARL-EN

    ## ... activating corpus: EUROPARL-ES

    ## ... activating corpus: EUROPARL-FR

    ## ... activating corpus: EUROPARL-IT

    ## ... activating corpus: EUROPARL-NL

The polmineR package offers a basic vocabulary for corpus analysis
(counting, keyword-in-context analysis, cooccurrences, keyword
extraction etc.). To learn more about the polmineR package, consult the
[package documentation](http://polmine.github.io/polmineR/). To get
started, you might want to perform a simple counting operation, such as
counting the number of occurrences of “European integration” using the
syntax of the Corpus Query Processor (CQP).

``` r
count("EUROPARL-EN", query = '"European" "Integration" %c', cqp = TRUE)
```

    ##                          query count         freq
    ## 1: "European" "Integration" %c  1639 4.156537e-05

## Achknowledgements and Citation

The effort necessary to write this package has been fairly limited. The
original work has been done by Philipp Koehn (University of Edinburgh),
see the [website of the OPUS
project](http://opus.nlpl.eu/Europarl3.php), and the [Wikipedia entry on
the Europarl Corpus](https://en.wikipedia.org/wiki/Europarl_Corpus).

Following the advice on the [website of the OPUS
project](http://opus.nlpl.eu/Europarl3.php), the paper “Parallel Data,
Tools and Interfaces in OPUS” (Tiedemann 2012) should be quoted as a
reference to the Europarl corpus.

Last but not least, Stefan Evert’s efforts to prepare and host the
linguistically annotated version of Europarl as a CWB indexed corpus is
gratefully acknowledged.

## References

<div id="refs" class="references">

<div id="ref-blaette2018">

Blätte, Andreas. 2018. “Using Data Packages to Ship Annotated Corpora of
Parliamentary Protocols: The Germaparl R Package.” In *Proceedings of
the Eleventh International Conference on Language Resources and
Evaluation (Lrec 2018)*, edited by Darja Fišer, Maria Eskevich, and
Franciska de Jong. Paris, France: European Language Resources
Association (ELRA).

</div>

<div id="ref-EvertHardie2011">

Evert, Stefan, and Andrew Hardie. 2011. “Twenty-First Century Corpus
Workbench: Updating a Query Architecture for the New Millennium.” In
*Proceedings of the Corpus Linguistics 2011 Conference*. University of
Birmingham, UK.

</div>

<div id="ref-koehn2005epc">

Koehn, Philipp. 2005. “Europarl: A Parallel Corpus for Statistical
Machine Translation.” In *Conference Proceedings: the tenth Machine
Translation Summit*, 79–86. Phuket, Thailand: AAMT; AAMT.
<http://mt-archive.info/MTS-2005-Koehn.pdf>.

</div>

<div id="ref-tiedemann2012">

Tiedemann, Jörg. 2012. “Parallel Data, Tools and Interfaces in Opus.” In
*Proceedings of the Eight International Conference on Language Resources
and Evaluation (Lrec’12)*, edited by Nicoletta Calzolari (Conference
Chair), Khalid Choukri, Thierry Declerck, Mehmet Ugur Dogan, Bente
Maegaard, Joseph Mariani, Jan Odijk, and Stelios Piperidis. Istanbul,
Turkey: European Language Resources Association (ELRA).

</div>

</div>
