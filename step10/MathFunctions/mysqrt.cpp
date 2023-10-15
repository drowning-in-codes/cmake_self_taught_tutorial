#include<iostream>
#include<cmath>
#include "MathFunctions.h"
#ifdef USE_MYMATH
#include "mysqrt.h"
#endif
namespace mathfunctions {
    int sqrt(int x) {
        return x*x;
    }
}

int main() {
  const double x = 10.2;
    #ifdef USE_MYMATH
    return std::sqrt(10);
    #else
    return mathfunctions::sqrt(10);
    #endif

    #if defined(HAVE_LOG) && defined(HAVE_EXP)
  double result = std::exp(std::log(x) * 0.5);
  std::cout << "Computing sqrt of " << x << " to be " << result
            << " using log and exp" << std::endl;
#else
  double result = x;

  // do ten iterations
  for (int i = 0; i < 10; ++i) {
    if (result <= 0) {
      result = 0.1;
    }
    double delta = x - (result * result);
    result = result + 0.5 * delta / result;
    std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
  }
#endif
}