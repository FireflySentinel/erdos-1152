# Verification and scope

The Lean development is partial. Its main entry point now derives the local
amplification conclusion from three separate inputs, with the above-minimum
argument proved through the Remez and Lebesgue-density steps.

## Main statement

[`ae_limsup_eq_top_of_cardinalGrowth_minimal`](Erdos1152/Main.lean) takes a node
array, a sublinear excess degree `r`, a region `A`, and these inputs:

* `RemezChebyshevInequality`, the classical published inequality.
* `CardinalGrowthCover X A`: a countable family of regions covering `A` almost
  everywhere, with the cardinal-polynomial growth estimate on each region.
* `LocalAmplificationMinimal X r A`: the remaining local conclusion on the
  complement of `A`.

In Section 6, `A = {x : V(x) > m₀}`. Its complement inside the interval is the
minimum-potential region. [`LocalRegions.lean`](Erdos1152/LocalRegions.lean)
combines local amplification on the two regions by taking the smaller fraction.
The earlier theorem with the whole `LocalAmplification` premise remains available.

[`checks/Statement.lean`](checks/Statement.lean) expands all three inputs and the
final conclusion. Row `n` has `n + 1` nodes, and `r(n)/(n+1) → 0` is now an
explicit hypothesis used in the Remez argument.

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
measurable set `E ⊆ [-1,1]` of positive measure.

[`CardinalLocal.lean`](Erdos1152/CardinalLocal.lean) connects this deduction to the
main theorem. At almost every point of each growth region, Lebesgue's density
theorem supplies arbitrarily small intervals whose complement in that region
occupies at most one quarter of the interval. The Remez bound makes the low-value
set occupy less than another quarter. This gives `LocalIntervalData` with
fraction `1/2`.

The growth regions and the interval are fixed before choosing the finite set
`S` of assigned nodes. Growth may hold along a row subsequence; its exponent
uses the original row size. The proof counts the removed nodes and uses the
correction budget `r(n) + S.card`. The countable cover lets one discard a single
null set before assembling the above-minimum conclusion.

The exponential growth estimate itself remains a premise. The potential
convergence needed to establish it has not been formalized.

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
published inputs. The cardinal-growth and minimum-region hypotheses remain manuscript inputs.
The current development therefore does not yet give a solution conditional only on published inputs under the
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
discharge theorem parameters such as cardinal growth, minimum-region amplification, or the Remez inequality.
The [workflow](.github/workflows/lean.yml) also replays the project declarations
through the kernel. Tag `v0.3.0` records this partial formalization.
