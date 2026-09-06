import Erdos1152.LocalToInterval
import Erdos1152.FiniteConstruction
import Erdos1152.Baire

/-! The finite and category part of Theorem 1, with its local analytic input explicit. -/

open Polynomial MeasureTheory Filter
open scoped ENNReal

namespace Erdos1152

theorem finiteAmplification_of_localAmplification (X : NodeArray) (r : ℕ → ℕ)
    (hlocal : LocalAmplification X r) : FiniteAmplification X r := by
  apply finiteAmplification_of_intervalAmplification X r
  intro H hH
  obtain ⟨c, hc, hc1, hlocalH⟩ := hlocal H hH
  refine ⟨c / 2, by positivity, by linarith, fun N => ?_⟩
  exact intervalAmplification_of_localData X r H c hc.le hlocalH N

/-- One continuous function works for every admissible interpolation sequence. -/
theorem ae_limsup_eq_top_of_localAmplification (X : NodeArray) (r : ℕ → ℕ)
    (hlocal : LocalAmplification X r) :
    ∃ f : ContinuousFunction, ∀ p : ℕ → ℝ[X],
      (∀ n, X.Interpolates r f n (p n)) →
      ∀ᵐ x ∂volume.restrict Segment,
        limsup (fun n => ((|(p n).eval x| : ℝ) : EReal)) atTop = ⊤ :=
  ae_limsup_eq_top_of_finiteAmplification X r
    (finiteAmplification_of_localAmplification X r hlocal)

end Erdos1152
