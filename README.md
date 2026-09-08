# Erdős Problem #1152: almost everywhere divergence with sublinear excess degree

Lean 4 formalization for [Erdős Problem #1152](https://www.erdosproblems.com/1152),
in the stronger form of almost everywhere unboundedness.
[`Erdos1152.ae_limsup_eq_top_of_cardinalGrowth_minimal`](Erdos1152/Main.lean) proves the
conclusion from Remez's inequality, sublinear excess degree, and two analytic inputs that
remain hypotheses: cardinal-polynomial growth and the minimum-potential argument.
[VERIFICATION.md](VERIFICATION.md) separates the published inputs from the remaining
applications.

## Build and check

With [Elan](https://github.com/leanprover/elan) installed, run from the repository root:

```sh
lake exe cache get
lake build
lake test
LEAN_NUM_THREADS=2 lake env leanchecker -v Erdos1152
```

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

[Statement.lean](checks/Statement.lean) expands the full conditional statement,
including every quantifier of the remaining inputs.

## Use of generative AI

An earlier round with GPT-5.6 developed the sign-change mechanism, the Remez argument on
regions of higher logarithmic potential, and the local external-field model near the
minimum-potential set. Building on those notes, GPT-6 Astra connected the model to
weighted polynomial spaces through Christoffel–Darboux kernel asymptotics and developed
the finite construction combining data from multiple rows.
The Lean formalization was generated with OpenAI Codex (GPT-6).
The author checked the arguments against the cited sources and is responsible for the content.
