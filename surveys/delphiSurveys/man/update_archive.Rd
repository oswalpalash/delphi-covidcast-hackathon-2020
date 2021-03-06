% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/archive.R
\name{update_archive}
\alias{update_archive}
\title{Save data to the archive}
\usage{
update_archive(df, archive, params)
}
\arguments{
\item{df}{a data frame with columns "token", "start_dr" and "ResponseID"}

\item{archive}{a data frame previously loaded by \code{load_archive}}

\item{params}{a named list, read from read_params. Must contain and element named
archive_dir (containing the file "data_agg.Rds").}
}
\description{
Save data to the archive
}
