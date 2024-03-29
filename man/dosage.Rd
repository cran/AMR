% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{dosage}
\alias{dosage}
\title{Data Set with Treatment Dosages as Defined by EUCAST}
\format{
A \link[tibble:tibble]{tibble} with 503 observations and 9 variables:
\itemize{
\item \code{ab}\cr Antibiotic ID as used in this package (such as \code{AMC}), using the official EARS-Net (European Antimicrobial Resistance Surveillance Network) codes where available
\item \code{name}\cr Official name of the antimicrobial drug as used by WHONET/EARS-Net or the WHO
\item \code{type}\cr Type of the dosage, either "high_dosage", "standard_dosage", or "uncomplicated_uti"
\item \code{dose}\cr Dose, such as "2 g" or "25 mg/kg"
\item \code{dose_times}\cr Number of times a dose must be administered
\item \code{administration}\cr Route of administration, either "im", "iv", or "oral"
\item \code{notes}\cr Additional dosage notes
\item \code{original_txt}\cr Original text in the PDF file of EUCAST
\item \code{eucast_version}\cr Version number of the EUCAST Clinical Breakpoints guideline to which these dosages apply, either 13, 12, or 11
}
}
\usage{
dosage
}
\description{
EUCAST breakpoints used in this package are based on the dosages in this data set. They can be retrieved with \code{\link[=eucast_dosage]{eucast_dosage()}}.
}
\details{
Like all data sets in this package, this data set is publicly available for download in the following formats: R, MS Excel, Apache Feather, Apache Parquet, SPSS, SAS, and Stata. Please visit \href{https://msberends.github.io/AMR/articles/datasets.html}{our website for the download links}. The actual files are of course available on \href{https://github.com/msberends/AMR/tree/main/data-raw}{our GitHub repository}.
}
\examples{
dosage
}
\keyword{datasets}
