#include <cmath>
#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector loglik_MP(NumericVector beta, NumericVector x, int n_cpu)
{
  double mu = beta[0];
  double sigma = beta[1];
  double ll = 0;

      double ll_thread = 0;
      for(int i = 0; i < x.length(); i++)
      {
        ll_thread -= (x[i] - mu)*(x[i] - mu);
      }

     ll += ll_thread;
  ll *= 0.5/sigma/sigma;
  ll -= (0.5*log(2*M_PI) + log(sigma))*x.length();
  NumericVector result(1, ll);
  return result;
}

// [[Rcpp::export]]
NumericVector hello()
{
  return Rcpp::wrap(0);
}

// [[Rcpp::export]]
NumericVector exampleOMP(std::vector<double> x)
{
  size_t n = x.size();
  for (size_t i=0; i<n; i++)
  {
    for (int j=0; j< 1000000; j++)
    {
      x[i] += 1;
    }
  }
  return Rcpp::wrap(x);
}

// [[Rcpp::export]]
NumericVector example_non_OMP(std::vector<double> x)
{
  size_t n = x.size();
  for (size_t i=0; i<n; i++)
  {
    for (int j=0; j< 1000000; j++)
    {
      x[i] += 1;
    }
  }
  return Rcpp::wrap(x);
}