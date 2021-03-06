% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/popsize_cond.R
\name{popsize_cond}
\alias{popsize_cond}
\title{Estimate total population size and capture probability using user provided set of models conditioned on an attribute.}
\usage{
popsize_cond(
  List_matrix,
  K = 2,
  filterrows = FALSE,
  funcname = c("rangerlogit"),
  condvar,
  nfolds = 2,
  eps = 0.005,
  TMLE = TRUE,
  PLUGIN = TRUE,
  ...
)
}
\arguments{
\item{List_matrix}{The data frame in capture-recapture format for which total population is to be estimated.
The first K columns are the capture history indicators for the K lists. The remaining columns are covariates in numeric format.}

\item{K}{The number of lists in the data. typically the first \code{K} rows of List_matrix.}

\item{filterrows}{A logical value denoting whether to remove all rows with only zeroes.}

\item{funcname}{The vector of estimation function names to obtain the population size.}

\item{condvar}{The covariate for which conditional estimates are required.}

\item{nfolds}{The number of folds to be used for cross fitting.}

\item{eps}{The minimum value the estimates can attain to bound them away from zero.}

\item{TMLE}{The logical value to indicate whether TMLE has to be computed.}

\item{PLUGIN}{The logical value to indicate whether the plug-in estimates is returned.}
}
\value{
A list of estimates containing the following components for each list-pair, model and method (PI = plug-in, DR = doubly-robust, TMLE = targeted maximum likelihood estimate):
\item{result}{  A dataframe of the below estimated quantities.
\itemize{
\item{psi}{  The estimated capture probability.}
\item{sigma}{  The efficiency bound.}
\item{n}{  The estimated population size n.}
\item{sigman}{  The estimated standard deviation of the population size.}
\item{cin.l}{  The estimated lower bound of a 95\% confidence interval of \code{n}.}
\item{cin.u}{  The estimated upper bound of a 95\% confidence interval of \code{n}.}}}
\item{N}{  The number of data points used in the estimation after removing rows with missing data.}
\item{ifvals}{  The estimated influence function values for the observed data.}
\item{nuis}{  The estimated nuisance functions (q12, q1, q2) for each element in funcname.}
\item{nuistmle}{  The estimated nuisance functions (q12, q1, q2) from tmle for each element in funcname.}
}
\description{
Estimate total population size and capture probability using user provided set of models conditioned on an attribute.
}
\examples{
data = matrix(sample(c(0,1), 2000, replace = TRUE), ncol = 2)
x = matrix(rnorm(nrow(data)*3, 2,1), nrow = nrow(data))
ss = sample(1:6, nrow(data), replace = TRUE)

data = cbind(data, x, ss)
psin_estimate = popsize_cond(List_matrix = data, funcname = c("logit", "sl"), condvar = 'ss', nfolds = 2, twolist = FALSE, eps = 0.005)
#this returns the plug-in, the bias-corrected and the tmle estimate for the two models conditioned on column ss
}
\references{
Gruber, S., & Van der Laan, M. J. (2011). tmle: An R package for targeted maximum likelihood estimation.

van der Laan, M. J., Polley, E. C. and Hubbard, A. E. (2008) Super Learner, Statistical Applications of Genetics and Molecular Biology, 6, article 25.
}
