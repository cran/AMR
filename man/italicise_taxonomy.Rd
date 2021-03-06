% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/italicise_taxonomy.R
\name{italicise_taxonomy}
\alias{italicise_taxonomy}
\alias{italicize_taxonomy}
\title{Italicise Taxonomic Families, Genera, Species, Subspecies}
\usage{
italicise_taxonomy(string, type = c("markdown", "ansi"))

italicize_taxonomy(string, type = c("markdown", "ansi"))
}
\arguments{
\item{string}{a \link{character} (vector)}

\item{type}{type of conversion of the taxonomic names, either "markdown" or "ansi", see \emph{Details}}
}
\description{
According to the binomial nomenclature, the lowest four taxonomic levels (family, genus, species, subspecies) should be printed in italic. This function finds taxonomic names within strings and makes them italic.
}
\details{
This function finds the taxonomic names and makes them italic based on the \link{microorganisms} data set.

The taxonomic names can be italicised using markdown (the default) by adding \code{*} before and after the taxonomic names, or using ANSI colours by adding \verb{\\033[3m} before and \verb{\\033[23m} after the taxonomic names. If multiple ANSI colours are not available, no conversion will occur.

This function also supports abbreviation of the genus if it is followed by a species, such as "E. coli" and "K. pneumoniae ozaenae".
}
\section{Maturing Lifecycle}{

\if{html}{\figure{lifecycle_maturing.svg}{options: style=margin-bottom:5px} \cr}
The \link[=lifecycle]{lifecycle} of this function is \strong{maturing}. The unlying code of a maturing function has been roughed out, but finer details might still change. Since this function needs wider usage and more extensive testing, you are very welcome \href{https://github.com/msberends/AMR/issues}{to suggest changes at our repository} or \link[=AMR]{write us an email (see section 'Contact Us')}.
}

\section{Read more on Our Website!}{

On our website \url{https://msberends.github.io/AMR/} you can find \href{https://msberends.github.io/AMR/articles/AMR.html}{a comprehensive tutorial} about how to conduct AMR data analysis, the \href{https://msberends.github.io/AMR/reference/}{complete documentation of all functions} and \href{https://msberends.github.io/AMR/articles/WHONET.html}{an example analysis using WHONET data}.
}

\examples{
italicise_taxonomy("An overview of Staphylococcus aureus isolates")
italicise_taxonomy("An overview of S. aureus isolates")

cat(italicise_taxonomy("An overview of S. aureus isolates", type = "ansi"))

# since ggplot2 supports no markdown (yet), use
# italicise_taxonomy() and the `ggtext` pkg for titles:
\donttest{
if (require("ggplot2") && require("ggtext")) {
  ggplot(example_isolates$AMC,
         title = italicise_taxonomy("Amoxi/clav in E. coli")) +
    theme(plot.title = ggtext::element_markdown())
}
}
}
