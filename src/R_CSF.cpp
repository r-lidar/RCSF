// ======================================================================================
// Copyright 2017 State Key Laboratory of Remote Sensing Science,
// Institute of Remote Sensing Science and Engineering, Beijing Normal University

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ======================================================================================


#include "CSF.h"
#include <Rcpp.h>
using namespace std;
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector R_CSF(DataFrame data, bool SloopSmooth, float ClothResolution)
{
  NumericVector X = data["X"];
  NumericVector Y = data["Y"];
  NumericVector Z = data["Z"];

  CSF csf;

  //step 2 ???ò???
  csf.params.bSloopSmooth = SloopSmooth;
  csf.params.class_threshold = 0.5;
  csf.params.cloth_resolution = ClothResolution;
  csf.params.interations = 500;
  csf.params.rigidness = 1;
  csf.params.time_step = 0.65;

  std:vector<csf::Point> points(X.size());
  for (int i = 0 ; i < X.size() ; i++)
  {
    csf::Point p;
    p.u[0] = X[i];
    p.u[1] = Y[i];
    p.u[2] = Z[i];

    points[i] = p;
  }

  csf.setPointCloud(points);

  std::vector<int> ground, nonground;
  csf.do_filtering(ground, nonground);

  IntegerVector Rground(wrap(ground));
  return Rground + 1;
}