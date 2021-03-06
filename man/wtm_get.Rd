% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{wtm_get}
\alias{wtm_get}
\title{wtm_get}
\usage{
wtm_get(
  endpoint,
  country = NULL,
  party = NULL,
  limit = NULL,
  skip = NULL,
  selects = NULL,
  sort_by = NULL,
  sort_dir = 1,
  values_in_var = NULL,
  values_nin_var = NULL,
  lt = NULL,
  lte = NULL,
  gt = NULL,
  gte = NULL,
  ne = NULL,
  or = NULL,
  ...,
  raw = F
)
}
\arguments{
\item{endpoint}{the API endpoint you want to retrieve. currently supports: \code{candidates-impressions}, \code{candidates-targeting-methods} and \code{impressions-daily-totals}.}

\item{country}{which country to retrieve data from (ISO2). Examples: \code{"DE"}, \code{"US"} etc.}

\item{party}{which party to retrieve data from. Examples: \code{"CDU"}, \code{"Biden"} etc.}

\item{limit}{will return only the number of results you specify}

\item{skip}{will skip the specified number of results}

\item{selects}{allows to pick which fields to include in the result, chr or vector of chrs}

\item{sort_by}{will sort based on the variable you provide (chr)}

\item{sort_dir}{sort direction (\code{1} ascending, \code{-1} descending) (default = \code{1})}

\item{values_in_var}{find all records where the property does (\verb{$in}) match any of the given values. Input is a list: \code{list(variable = c(1:3))}.}

\item{values_nin_var}{find all records where the property does not (\verb{$nin}) match any of the given values.  Input is a list: \code{list(variable = c(1:3))}.}

\item{lt}{find all records where the value is less (\verb{$lt}) to a given value. Input is a list: \code{list(variable = c(1:3))}.}

\item{lte}{find all records where the value is less and equal (\verb{$lte}) to a given value. Input is a list: \code{list(variable = c(1:3))}.}

\item{gt}{find all records where the value is more (\verb{$gt}) to a given value. Input is a list: \code{list(variable = c(1:3))}.}

\item{gte}{find all records where the value is more and equal (\verb{$gte}) to a given value. Input is a list: \code{list(variable = c(1:3))}.}

\item{ne}{find all records that do not equal the given property value. Input is a list: \code{list(variable = c(1:3))}.}

\item{or}{find all records that match any of the given criteria. Specify the params as chr (vector) that should be combined with an \verb{$or} statement. Example: \code{c("values_in_var", "gt")}.}

\item{...}{additional arguments you can pass to test for equality. Example = \code{facebookName = PragerU} retrieves all entries by advertiser \code{PragerU}.}

\item{raw}{whether to return the raw \code{GET} request or a tidy data frame (defaults to \code{FALSE})}
}
\description{
The goal of \code{wtm_get} is to provide access to the \href{https://data-api.whotargets.me/docs/}{public data API} of \href{https://whotargets.me/en/}{Who Targets Me}.
}
\examples{
# retrieve all advertiser targeting methods in the use
# that have a greater or equal value of `bct = 1`.
wtm_get(endpoint = "candidates-targeting-methods",
        country = "US",
        gte = list(bct = 1))



# retrieve all advertiser targeting methods in the use
# that have a greater or equal value of `bct = 1` OR
# `custom_audiences_lookalike = 20`.
wtm_get(endpoint = "candidates-targeting-methods",
        country = "US",
        gte = list(bct = 1),
        value_in_var = list(custom_audiences_lookalike = 20),
        or = c("gte", "value_in_var"))
}
