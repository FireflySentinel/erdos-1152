# Lean formalization

This project formalizes the polynomial sign argument and the finite construction
and category argument in the [v5 manuscript](PROOF.tex). The main Lean theorem
deduces almost everywhere unboundedness from the local amplification conclusion
of Section 6. The analytic derivation of that conclusion is outside the current
formalization.

The manuscript used here is the version at
[`58ee872`](https://github.com/FireflySentinel/erdos-1152/commit/58ee872ddcaa7bdaab07035cb8a8ec9fc6b4e34f).

## Main statement

[`ae_limsup_eq_top_of_localAmplification`](Erdos1152/Main.lean) has the following statement:

```lean
theorem ae_limsup_eq_top_of_localAmplification
    (X : NodeArray) (r : ℕ → ℕ)
    (hlocal : LocalAmplification X r) :
    ∃ f : ContinuousFunction, ∀ p : ℕ → ℝ[X],
      (∀ n, X.Interpolates r f n (p n)) →
      ∀ᵐ x ∂volume.restrict Segment,
        limsup (fun n => ((|(p n).eval x| : ℝ) : EReal)) atTop = ⊤
```

`Segment` is `[-1,1]`, and `ContinuousFunction` is the space of continuous real
functions on this interval. Row `n` contains `n + 1` distinct nodes, with degree
bound `n + 1 + r n`. The continuous function is chosen before the interpolation
sequence; the exceptional null set may depend on that sequence.

## Local analytic input

[`LocalAmplification`](Erdos1152/LocalData.lean) states that for every `H > 1`
there is `0 < c ≤ 1` such that almost every point has arbitrarily small centered
intervals with the following property. After any finite set of previously
assigned nodes is removed, one can choose an arbitrarily late row and data
bounded by one on its remaining nodes. Every polynomial of the allowed degree
interpolating these new data has a low set of measure at most `(1 - c)` times the
interval length. The interval is chosen before the finite set of assigned nodes.

The derivation of this input from `r_n / n → 0` is not formalized. The remaining
analytic work includes the OU sampling construction, the equilibrium density and
uniform KSSV kernel estimates, weighted and sparse localization, logarithmic
potential limits, and the local and discrete outer-field convergence. In
particular, Lemmas 5, 7, 8 and Proposition 6 are not replaced by verified
applications of OU or KSSV in this project.

## Proof correspondence

| Manuscript | Lean declaration | Content |
|---|---|---|
| Lemma 3 | [`alternating_interval_bound`](Erdos1152/Intervals.lean) | Whole intervals remaining above the threshold after a degree-bounded correction |
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

For the category argument, the Lean proof uses the boundedness of the finitely
many Lagrange interpolation operators, with a margin in the height threshold,
to construct dense open sets. This replaces the closed-set argument of Lemma 10;
its Remez and weak-star compactness proof is not separately formalized. The finite
data extension uses mathlib's Tietze theorem.

## Build

The project pins Lean and mathlib to `v4.33.0-rc2`.

```sh
lake exe cache get
lake build
lake env lean Check.lean
lake env leanchecker Erdos1152
```

[`Check.lean`](Check.lean) checks the axiom dependencies of the principal
declarations. The [GitHub workflow](.github/workflows/lean.yml) runs the build,
axiom checks, and kernel replay.
