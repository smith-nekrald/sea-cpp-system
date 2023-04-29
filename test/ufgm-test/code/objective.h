#pragma once

#include "gm_src/gm_interfaces.h"
#include "gm_src/gm_common.h"

#include <vector>
#include <memory>
#include <cassert>
#include <cmath>
#include <cstdlib>

#include <cppad/ipopt/solve.hpp>

template<typename Value>
class SteinerProblem : public gm::IOrderOneOracle<Value> {
public:
    SteinerProblem(std::size_t dimension, std::size_t anchorCount, int seed = 7) {
        srand(seed);
        anchors.resize(anchorCount);
        for (std::size_t idx_anchor = 0; idx_anchor < anchorCount; ++idx_anchor) {
            std::vector<double> item(dimension);
            for (std::size_t idx = 0; idx < dimension; ++idx) {
                item[idx] = rand();
            }
            anchors[idx_anchor] = item;
        }
    };

    SteinerProblem(std::vector<std::vector<double>> inAnchors)
            : anchors(inAnchors) {
        assert(anchors.size() > 0);
        auto dimension = anchors.front().size();
        for (const auto& item : anchors) {
            assert(item.size() == dimension);
        }
    };

    std::vector<std::vector<double>> getAnchors() const {
        return anchors;
    }

    virtual Value getValue(const std::vector<Value>& point) const override {
        return computeObjective<Value>(point);
    };

    virtual std::vector<Value> getSubgradient(
            const std::vector<Value>& domain) const override {
        auto adPoint = gm::makeADRoutine(domain);
        std::vector<CppAD::AD<Value>> objective = {
            computeObjective<CppAD::AD<Value>>(adPoint)
        };
        return gm::subgradientRoutine<Value>(domain, adPoint, objective);
    };

private:
    template<typename Type>
    Type computeObjective(const std::vector<Type>& point) const {
        Type result = gm::makeInit<Type>();
        for (const auto& entry: anchors) {
            assert(entry.size() == point.size());
            result += getDistance<Type>(point, entry);
        }
        return result;
    }

    template<typename Type>
    Type getDistance(std::vector<Type> point, std::vector<double> anchor) const {
        assert(point.size() == anchor.size());
        Type answer = gm::makeInit<Type>();
        for (std::size_t idx = 0; idx < point.size(); ++idx) {
            answer += (point[idx] - anchor[idx]) * (point[idx] - anchor[idx]);
        }
        return sqrt(answer);
    }

private:
    std::vector<std::vector<double>> anchors;
};

