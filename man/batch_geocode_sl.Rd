% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode_njogis.R
\name{batch_geocode_sl}
\alias{batch_geocode_sl}
\title{Batch geocode addresses in single line format}
\usage{
batch_geocode_sl(df, id, address, crs = 4326)
}
\arguments{
\item{df}{dataframe with addresses to be geocoded}

\item{id}{primary key that uniquely identifies rows}

\item{address}{street address column}

\item{crs}{coordinate reference system to use for output}
}
\value{
a dataframe containing geocoding results
}
\description{
Batch geocode addresses in single line format
}
