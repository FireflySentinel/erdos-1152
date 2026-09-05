# Erdos Problem 1152: almost everywhere divergence, polynomial interpolation, sublinear excess degree

This manuscript presents a proof of the divergence assertion in [Erdős Problem #1152](https://www.erdosproblems.com/1152), with the stronger conclusion of almost everywhere unboundedness.

## Main result

Let $X_n \subset [-1,1]$ be any set of $n$ distinct interpolation nodes, and let $r_n$ be any sequence of nonnegative integers with $r_n=o(n)$. There exists a real continuous function $f$ on $[-1,1]$ such that **every** sequence of polynomials satisfying

$$
\deg p_n \le n+r_n, \qquad p_n(x)=f(x) \quad (x\in X_n)
$$

also satisfies

$$
\limsup_{n\to\infty}|p_n(x)|=\infty
\quad\text{for Lebesgue almost every }x\in[-1,1].
$$

The same function $f$ works for all admissible interpolation sequences. The exceptional null set may depend on the sequence.

## Proof ideas

Localized Bernstein functions and uniform asymptotics for weighted Christoffel-Darboux kernels produce interpolation data that force large values on intervals. Alternating signs and polynomial zero counts control every admissible correction. A finite construction combines data from several rows, and the Baire category theorem yields a single continuous function with the stated property.
