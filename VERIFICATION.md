# Verification and scope

The Lean development is partial. The main theorem assumes
[`LocalAmplification`](Erdos1152/LocalData.lean), the local analytic conclusion
obtained in Sections 4–6 of this manuscript. It has not been derived in Lean
from the published analytic inputs.

## Main statement

[`ae_limsup_eq_top_of_localAmplification`](Erdos1152/Main.lean) proves that there
is a continuous function for which every sequence of admissible interpolants
is unbounded almost everywhere. The finite construction and the category
argument are proved.
[`checks/Statement.lean`](checks/Statement.lean) expands the local hypothesis
and the final conclusion into the node maps, polynomial degrees, evaluations,
Lebesgue measures, and quantifiers.

Row `n` has `n + 1` nodes. The hypothesis `r(n) = o(n)` belongs to the missing
analytic derivation of `LocalAmplification`; it is not needed for the conditional
implication from that property to the final conclusion.

## Section 6.1: the Remez application

[`RemezAmplification.lean`](Erdos1152/RemezAmplification.lean) separates the
classical input from its application:

| Declaration | Content |
|---|---|
| `RemezChebyshevInequality` | The classical Remez bound on `[-1,1]`, kept as an explicit hypothesis |
| `remezInequality_of_chebyshev` | Derives the bound `H (8 / |E|)^degree` from the Chebyshev bound |
| `cardinal_factorization` | From cardinal interpolation data, derives `p = ℓ T`, `T(z) = 1`, and the excess-degree bound |
| `eventually_remez_factor_lt_one` | Proves `H exp(-η(n+1)) C^d(n) < 1` eventually when `d(n)/(n+1) → 0` |
| `eventually_cardinal_amplification_of_measure_convergence` | From exponential growth of `ℓ` outside sets whose measures tend to zero, proves uniformly small low-value sets for every admissible interpolant |

The external inequality is the standard Chebyshev form of
[Remes (1936), p. 93, (3)–(4)](https://history-of-approximation-theory.com/fpapers/remezppr.pdf):
`|p(z)| ≤ H T_degree(4 / |E| - 1)` for `z ∈ [-1,1]` and `|p| ≤ H` on a
measurable set `E ⊆ [-1,1]` of positive measure. The exponential growth estimate
for the cardinal polynomials is still a separate premise. The new lemmas do
not assert the potential convergence needed to establish it.

## Remaining analytic applications

| Source or manuscript section | Connection still to be formalized |
|---|---|
| [Olevskii–Ulanovskii (2018), Lemma 4.1](https://doi.org/10.1134/S0081543818080151) | The modified peak function of Lemma 2, including bandwidth, decay, and localization properties |
| [Kriecherbauer–Schubert–Schüler–Venker (2015), Theorems 1.3 and 1.8, Lemma 2.4](https://arxiv.org/abs/1401.6772) | The normalization and uniformity in Lemma 5, and the support-continuity application |
| Section 4, Proposition 6 | Weighted kernel amplification, including localization and the weighted maximum-principle argument |
| Section 5 | Periodization, Fourier support, and the sparse-node amplification argument |
| Section 6.1 | Weak node-measure convergence, logarithmic-potential convergence, and the resulting cardinal-polynomial growth estimate |
| Section 6.2, Lemmas 7–8 | Local convergence of the external fields and its use near the minimum-potential set |

Specifying the OU peak function by Fourier support would still require proving
that the cited construction supplies that condition. Likewise the kernel
estimates used here are consequences of KSSV, not verbatim statements of its
theorems. These applications cannot be replaced by relabeling their outputs as
published inputs. The current development therefore does not yet give a solution
conditional only on published inputs under the
[Erdős Problems database's contribution rules](https://github.com/teorth/erdosproblems/blob/main/CONTRIBUTING.md).

## Reproduction

The toolchain and dependency revisions are pinned in `lean-toolchain` and
`lake-manifest.json`. From the repository root:

```sh
lake exe cache get
lake build
lake test
LEAN_NUM_THREADS=2 lake env leanchecker -v Erdos1152
```

`lake test` checks the expanded statement and axiom dependencies. The guards
require `propext`, `Classical.choice`, and `Quot.sound`; this list does not
discharge theorem parameters such as `LocalAmplification` or the Remez inequality.
The [workflow](.github/workflows/lean.yml) also replays the project declarations
through the kernel. Tag `v0.2.0` records this partial formalization.
