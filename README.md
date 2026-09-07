# Erdős Problem #1152: almost everywhere divergence of polynomial interpolation with sublinear excess degree

Preprint claiming a proof of the divergence assertion in
[Erdős Problem #1152](https://www.erdosproblems.com/1152), in the stronger form of almost
everywhere unboundedness.

## Build and check

With [Elan](https://github.com/leanprover/elan) installed, run from the repository root:

```sh
lake exe cache get
lake build
lake test
LEAN_NUM_THREADS=2 lake env leanchecker -v Erdos1152
```

## Exact statement

[`Erdos1152.ae_limsup_eq_top_of_cardinalGrowth_minimal`](Erdos1152/Main.lean) proves
almost everywhere unboundedness from Remez's inequality, sublinear excess degree,
a countable cover by regions of cardinal-polynomial growth, and local amplification
on the complementary region. In the manuscript these are the regions above the
minimum potential and the minimum-potential set.

This is a partial formalization. Cardinal growth is still an analytic input, as is
the minimum-potential argument. The deduction from these inputs through Remez,
Lebesgue density, the finite construction and Baire is proved.
[VERIFICATION.md](VERIFICATION.md) separates the published inputs from the
remaining applications. [Statement.lean](checks/Statement.lean) expands the full
conditional statement, including every quantifier of the three remaining inputs.

## Proof correspondence

| Manuscript | Lean source |
|---|---|
| Lemma 3, intervals surviving a degree-bounded correction | [Intervals.lean](Erdos1152/Intervals.lean), `alternating_interval_bound` |
| Lemma 4, equilibrium density and the scalar integral | [EquilibriumDensity.lean](Erdos1152/EquilibriumDensity.lean), [CauchyIntegral.lean](Erdos1152/CauchyIntegral.lean) |
| Section 6.1, factorization and Remez amplification from a cardinal-polynomial growth estimate | [RemezAmplification.lean](Erdos1152/RemezAmplification.lean), `cardinal_factorization`, `eventually_cardinal_amplification_of_measure_convergence` |
| Section 6.1, density points and local interval data | [CardinalLocal.lean](Erdos1152/CardinalLocal.lean), `localAmplificationAbove_of_cardinalGrowthCover` |
| Combining the above-minimum and minimum-potential regions | [LocalRegions.lean](Erdos1152/LocalRegions.lean), `localAmplification_of_above_minimal` |
| Proposition 9, the finite construction | [Main.lean](Erdos1152/Main.lean), `finiteAmplification_of_localAmplification` |
| Section 8, Baire and the almost-everywhere conclusion | [Main.lean](Erdos1152/Main.lean), `ae_limsup_eq_top_of_localAmplification` |

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
