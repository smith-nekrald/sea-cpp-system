#pragma once

#include "gm_src/gm_interfaces.h"

#include <cassert>
#include <vector>
#include <numeric>
#include <limits>

#include <cppad/ipopt/solve.hpp>

class SteinerQDescriptor : public gm::IQDescriptor {
public:
    SteinerQDescriptor(size_t dimension)
        : dimension(dimension) {
    }
    virtual std::vector<CppAD::AD<double>> makeConstraints(
            const std::vector<CppAD::AD<double>>& /*variables*/) const override {
        return {};
    };
    virtual void initConstraintsLR(
            std::vector<double>* glower, std::vector<double>* gupper) const override {
        assert(glower != nullptr);
        assert(gupper != nullptr);
        glower->clear();
        gupper->clear();
    };
    virtual void initBoundsLR(
            std::vector<double>* vlower, std::vector<double>* vupper) const override {
        assert(vlower != nullptr);
        assert(vupper != nullptr);
        vlower->assign(dimension, 0);
        double INF = std::numeric_limits<double>::max();
        vupper->assign(dimension, INF);
    };
    virtual ~SteinerQDescriptor() {};
private:
    std::size_t dimension;
};



