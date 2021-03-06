% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{read_params}
\alias{read_params}
\title{Return params file as an R list}
\usage{
read_params(path = "params.json")
}
\arguments{
\item{path}{path to the parameters file; if not present, will try to copy the file
"params.json.template"}
}
\value{
a named list of parameters values
}
\description{
Reads a parameters file. If the file does not exist, the function will create a copy of
'"params.json.template" and read from that.
}
