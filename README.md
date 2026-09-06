# Erdős Problem #1152: almost everywhere divergence of polynomial interpolation with sublinear excess degree

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22312935.svg)](https://doi.org/10.5281/zenodo.22312935)
[![Lean](https://github.com/FireflySentinel/erdos-1152/actions/workflows/lean.yml/badge.svg?branch=main)](https://github.com/FireflySentinel/erdos-1152/actions/workflows/lean.yml)

Preprint claiming a proof of the divergence assertion in
[Erdős Problem #1152](https://www.erdosproblems.com/1152), in the stronger form of almost
everywhere unboundedness.

**Qiyuan Gu**, University of Chicago

[Preprint PDF](PROOF.pdf) · [LaTeX source](PROOF.tex) ·
[Lean formalization](Erdos1152/Main.lean) · [Build instructions](FORMALIZATION.md)

## The problem

Erdős Problem #1152 (from *[Va99, 2.42]*) asks: for $n \ge 1$ fix a sequence of $n$
distinct numbers $x_{1n},\ldots,x_{nn} \in [-1,1]$, and let $\epsilon = \epsilon(n) \to 0$.
Does there always exist a continuous $f : [-1,1] \to \mathbb{R}$ such that if $p_n$ is
a sequence of polynomials with $\deg p_n < (1+\epsilon(n))n$ and
$p_n(x_{kn}) = f(x_{kn})$ for all $1 \le k \le n$, then $p_n(x) \not\to f(x)$ for
almost all $x \in [-1,1]$?

The complementary regime is due to Erdős, Kroó and Szabados *[EKS89]*: for fixed
$\epsilon > 0$ there are node sequences for which every continuous $f$ admits
interpolants of degree $< (1+\epsilon)n$ converging uniformly. Theorem 1 shows this
breaks down as soon as $\epsilon(n) \to 0$, for every node sequence.

## Main theorem

**Theorem 1.** For each $n \ge 1$, let $X_n \subset [-1,1]$ consist of $n$ distinct
points. Suppose that $r_n \ge 0$ are integers and $r_n/n \to 0$. There exists
$f \in C([-1,1];\mathbb{R})$ such that every sequence satisfying

$$p_n \in \Pi_{n+r_n}, \qquad p_n(x) = f(x) \quad (x \in X_n)$$

also satisfies

$$\limsup_{n\to\infty}|p_n(x)| = \infty \qquad \text{for almost every } x \in [-1,1].$$

The same $f$ works for every admissible interpolation sequence; the exceptional
null set may depend on $(p_n)$. Taking $r_n = \lfloor \epsilon(n)\, n \rfloor$ with
$\epsilon(n) \to 0$ answers Erdős Problem #1152 in the affirmative, with
unboundedness in place of mere non-convergence.

Localized Bernstein functions and uniform asymptotics for weighted
Christoffel–Darboux kernels produce interpolation data that force large values on
intervals. Alternating signs and polynomial zero counts control every admissible
correction of degree up to $n + r_n$. A finite construction combines data from
several rows, and the Baire category theorem yields a single continuous function
with the stated property.

Main external inputs: Kriecherbauer–Schubert–Schüler–Venker,
*Global asymptotics for the Christoffel–Darboux kernel of random matrix theory*
([arXiv:1401.6772](https://arxiv.org/abs/1401.6772)); Olevskii–Ulanovskii,
*On irregular sampling and interpolation in Bernstein spaces*
([doi:10.1134/S0081543818080151](https://doi.org/10.1134/S0081543818080151)).

## Lean formalization

The Lean project verifies the sign-change argument, elementary identities for
the field and density in Lemma 4, and the finite construction and Baire argument.
The final theorem assumes the local amplification conclusion of Section 6;
its analytic derivation remains in the manuscript. See
[the exact statement and proof correspondence](FORMALIZATION.md).

## AI tool disclosure

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
