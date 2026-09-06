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

| Manuscript | Lean source |
|---|---|
| Lemma 3, intervals surviving a degree-bounded correction | [Intervals.lean](Erdos1152/Intervals.lean), `alternating_interval_bound` |
| Lemma 4, equilibrium density and the scalar integral | [EquilibriumDensity.lean](Erdos1152/EquilibriumDensity.lean), [CauchyIntegral.lean](Erdos1152/CauchyIntegral.lean) |
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
