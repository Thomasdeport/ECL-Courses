gauss_vrais <- function(x, y, m,sigma2,theta)
{
  nb_obs = length(x)
  #calcul de la matrice de covariance entre les obs
  matCov_obs = matrix(1, nb_obs,nb_obs)
  for (i in 1:(nb_obs-1)){
    for (j in 1:(nb_obs))
    {
      matCov_obs[i,j] = matern_cov(as.matrix(x[i],1,1),as.matrix(x[j],1,1),theta)
      matCov_obs[j,i] = matCov_obs[i,j]
    }
  }
  residus = matrix(y,nb_obs,1) - matrix(m,nb_obs,1)
  A = t(residus)%*%solve(matCov_obs,residus)
  result = (1/(2*pi*sigma2))^(nb_obs/2)*sqrt(1/det(matCov_obs))*exp(-A/(2*sigma2))
  return(result)
}
