import Erdos1152

/-! The conditional theorem with all local-input quantifiers expanded.
Row `n` has `n + 1` nodes. The hypothesis `r(n) = o(n)` is needed to derive
this local input analytically; it is not a premise of the implication checked here. -/

open Polynomial MeasureTheory Set Filter Topology

example (X : ∀ n : ℕ, Fin (n + 1) → Icc (-1 : ℝ) 1)
    (hX : ∀ n, Function.Injective (X n)) (r : ℕ → ℕ)
    (hlocal : ∀ H : ℝ, 1 < H → ∃ c : ℝ, 0 < c ∧ c ≤ 1 ∧
      ∀ᵐ x ∂volume.restrict (Ioo (-1 : ℝ) 1), ∀ ε > (0 : ℝ),
        ∃ h : ℝ, 0 < h ∧ h ≤ ε ∧
          ∀ S : Finset (Icc (-1 : ℝ) 1), ∀ N : ℕ, ∃ n ≥ N,
            ∃ v : Icc (-1 : ℝ) 1 → ℝ,
              (∀ i, X n i ∉ S → |v (X n i)| ≤ 1) ∧
              ∀ p : ℝ[X], p.natDegree ≤ n + 1 + r n →
                (∀ i, X n i ∉ S → p.eval (X n i : ℝ) = v (X n i)) →
                volume.real ({y | |p.eval y| ≤ H} ∩ Ioo (x - h) (x + h)) ≤
                  (1 - c) * volume.real (Ioo (x - h) (x + h))) :
    ∃ f : C(Icc (-1 : ℝ) 1, ℝ), ∀ p : ℕ → ℝ[X],
      (∀ n, (p n).natDegree ≤ n + 1 + r n ∧
        ∀ i, (p n).eval (X n i : ℝ) = f (X n i)) →
      ∀ᵐ x ∂volume.restrict (Icc (-1 : ℝ) 1),
        limsup (fun n => ((|(p n).eval x| : ℝ) : EReal)) atTop = ⊤ := by
  exact Erdos1152.ae_limsup_eq_top_of_localAmplification ⟨X, hX⟩ r hlocal
