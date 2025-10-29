gauss_cov <- function(x1, x2, theta)
{
  d = dim(x1)
  cov = 1
  for (i in 1:d[2]) {cov = cov * exp(-1/2*((x1[i]-x2[i])/theta[i])^2) }
  return(cov)
}
  
exp_cov <- function(x1, x2, theta)
{
  d = dim(x1)
  cov = 1
  for (i in 1:d[2]) {cov = cov * exp(-abs(x1[i]-x2[i])/theta[i]) }
  return(cov)
}

matern_cov <- function(x1, x2, theta)
{
  d = dim(x1)
  cov = 1
  for (i in 1:d[2]) {cov = cov *( (1+sqrt(5)*abs(x1[i]-x2[i])/theta[i]+(1/3)*5*(abs(x1[i]-x2[i])/theta[i])^2)
  *exp(-sqrt(5)*abs(x1[i]-x2[i])/theta[i]) )}
  return(cov)
}