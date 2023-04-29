#include "gm_src/ufgm_optimizer.h"
#include "gm_src/gm_prox.h"
#include "gm_src/gm_reg.h"

#include "objective.h"
#include "constraints.h"
#include "fix_cppad.h"

using namespace gm;
using namespace std;

int main() {
    // Steiner Problem Test.
    size_t dimension = 256;
    size_t anchorCount = 512;
    std::shared_ptr<IQDescriptor> qDescriptor = std::make_shared<SteinerQDescriptor>(dimension);

    std::vector<double> lower, upper;
    qDescriptor->initBoundsLR(&lower, &upper);

    std::vector<double> init(lower.size(), 1e-3);

    double coeffReg = 0.1;

    std::shared_ptr<DoubleFunction> regularizer =
        std::make_shared<L2SquaredReg<double>>(coeffReg);
    std::shared_ptr<CppADFunction> adRegularizer = std::make_shared<L2SquaredReg<
        CppAD::AD<double>>>(coeffReg);

    std::shared_ptr<DoubleFunction> prox = std::make_shared<ProxL2Squared<double>>();
    std::shared_ptr<CppADFunction> adProx =
        std::make_shared<ProxL2Squared<CppAD::AD<double>>>();

    std::shared_ptr<SteinerProblem<double>> target =
        std::make_shared<SteinerProblem<double>>(dimension, anchorCount);
    std::shared_ptr<CppADFunction> adTarget =
        std::make_shared<SteinerProblem<CppAD::AD<double>>>(target->getAnchors());

    size_t maxIter = 800;
    double precision = 1e-2;
    double L0 = 10;

    UFGMOptimizer optimizer(target, regularizer, prox,
            adTarget, adRegularizer, adProx, qDescriptor,
            maxIter, precision, L0, false);
    auto result = optimizer.optimize(init);
}
