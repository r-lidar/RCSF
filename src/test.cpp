#include <cmath>
#include <Rcpp.h>
#include <omp.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector loglik_MP(NumericVector beta, NumericVector x, int n_cpu)
{
  double mu = beta[0];
  double sigma = beta[1];
  double ll = 0;
  omp_set_dynamic(0);         // Explicitly disable dynamic teams
  omp_set_num_threads(n_cpu); // Use n_cpu threads for all

  // consecutive parallel regions
  #pragma omp parallel
  {
      double ll_thread = 0;

      #pragma omp for
      for(int i = 0; i < x.length(); i++)
      {
        ll_thread -= (x[i] - mu)*(x[i] - mu);
      }

      #pragma omp critical
      {
        ll += ll_thread;
      }
  }

  ll *= 0.5/sigma/sigma;
  ll -= (0.5*log(2*M_PI) + log(sigma))*x.length();
  NumericVector result(1, ll);
  return result;
}

// [[Rcpp::export]]
NumericVector hello()
{
  int th_id, nthreads;
  #pragma omp parallel private(th_id) shared(nthreads)
  {
    th_id = omp_get_thread_num();
    #pragma omp critical
    {
      Rcpp::Rcout << "Hello World from thread " << th_id << std::endl;
    }
    #pragma omp barrier

    #pragma omp master
    {
      nthreads = omp_get_num_threads();
      Rcpp::Rcout << "There are " << nthreads << " threads" << std::endl;
    }
  }

  return Rcpp::wrap(0);
}

// [[Rcpp::export]]
NumericVector exampleOMP(std::vector<double> x)
{
  size_t n = x.size();
  #pragma omp parallel for shared(x, n)
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