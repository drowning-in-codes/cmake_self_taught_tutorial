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
    #ifdef USE_MYMATH
    return std::sqrt(10);
    #else
    return mathfunctions::sqrt(10);
    #endif
}