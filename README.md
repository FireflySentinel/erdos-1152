# Erdős Problem #1152: almost everywhere divergence of polynomial interpolation with sublinear excess degree

Preprint claiming a proof of the divergence assertion in
[Erdős Problem #1152](https://www.erdosproblems.com/1152), in the stronger form of almost
everywhere unboundedness.

## Build and check

With [Elan](https://github.com/leanprover/elan) installed, run from the repository root:

```sh
lake exe cache get
lake build
lake env lean checks/Check.lean
LEAN_NUM_THREADS=2 lake env leanchecker Erdos1152
```

## Exact statement

[`Erdos1152.ae_limsup_eq_top_of_localAmplification`](Erdos1152/Main.lean) deduces almost
everywhere unboundedness from the local amplification conclusion of Section 6, and
`finiteAmplification_of_localAmplification` gives the finite construction and category
argument.

The analytic derivation of the local amplification conclusion is outside this
formalization.

## Proof correspondence

| Manuscript | Lean declaration | Content |
|---|---|---|
| Lemma 3 | [`alternating_interval_bound`](Erdos1152/Intervals.lean) | Whole intervals remaining above the threshold after a degree-bounded correction |
| Section 3, external field | [`externalField_derivative`](Erdos1152/ExternalField.lean), [`artanh_derivative`](Erdos1152/ExternalField.lean) | First and second derivatives of `Q` |
| Uniform logarithmic potential | [`uniformPotential_eq`](Erdos1152/ExternalField.lean) | `V_{du/2} = Q - 1` |
| Lemma 4, density | [`equilibriumDensity_time_derivative`](Erdos1152/EquilibriumDensity.lean), [`equilibriumDensity_mass`](Erdos1152/DensityMass.lean) | Support, time derivative and exact mass |
| Lemma 4, scalar integral | [`cauchy_integral_eq_artanh`](Erdos1152/CauchyIntegral.lean), [`cauchy_integral_lt_artanh`](Erdos1152/CauchyComparison.lean) | Endpoint integral and strict truncated comparison |
| Polynomial corrections | [`interpolation_correction`](Erdos1152/Interpolation.lean) | `p = b + P_Y q`, with the degree bound on `q` |
| Removing assigned nodes | [`degree_budget_after_removal`](Erdos1152/Interpolation.lean), [`LocalIntervalData.extend`](Erdos1152/LocalData.lean) | Exact degree budget and preservation of earlier node values |
| Proposition 9, Vitali covering | [`finite_disjoint_intervals`](Erdos1152/Vitali.lean), [`intervalAmplification_of_localData`](Erdos1152/LocalToInterval.lean) | Finitely many disjoint local intervals and sequential row assignments |
| Proposition 9, boundary bound | [`commonLowSet_boundary_cover`](Erdos1152/Boundary.lean) | At most `2 + 2 Σ d_j` boundary points |
| Proposition 9, fixed partition | [`exists_uniform_partition`](Erdos1152/Partition.lean) | A grid chosen from the degree bounds, uniformly for all polynomial choices |
| Proposition 9, batches | [`one_batch`](Erdos1152/Batches.lean), [`exists_small_low_stage`](Erdos1152/FiniteConstruction.lean) | Uniform contraction and finite iteration |
| Proposition 9, continuous extension | [`FiniteData.exists_continuous_extension`](Erdos1152/FiniteData.lean) | A continuous extension with norm at most one |
| Proposition 9 | [`finiteAmplification_of_localAmplification`](Erdos1152/Main.lean) | The complete finite construction from the stated local input |
| Section 8, open sets and density | [`finiteObstruction_interior`](Erdos1152/FiniteObstruction.lean), [`dense_finiteObstruction_interior`](Erdos1152/Density.lean) | Stability under finite Lagrange corrections and polynomial approximation |
| Section 8, Baire and almost everywhere conclusion | [`ae_limsup_eq_top_of_localAmplification`](Erdos1152/Main.lean) | One function for every admissible sequence |

Section 8 now uses the finite Lagrange-operator bound in both the manuscript
and Lean: an obstruction at height `H` persists at height `M < H` on an
explicit ball of radius `(H - M) / C`. Polynomial approximation gives density.
This removes the closed-set compactness argument from Section 8. Remez
remains in Section 6. The finite data extension uses mathlib's Tietze theorem.

## Use of generative AI

AI tools were used substantially in the development of this work. An earlier round with
GPT-5.6 developed the sign-change mechanism, the Remez argument on regions of higher
logarithmic potential, and the local external-field model near the minimum-potential set.
Building on notes from that round, GPT-6 Astra connected the external-field model to
weighted polynomial spaces through Christoffel–Darboux kernel asymptotics and localization,
and developed the finite construction that combines data from multiple rows. The author
checked the final arguments and the external results they depend on against the cited
sources, and is solely responsible for the mathematical content.

The Lean formalization and the finite-perturbation category argument in
Section 8 were developed with OpenAI Codex (GPT-6).
