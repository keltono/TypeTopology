Martin Escardo, 7 May 2014.

For any function f : ℕ∞ → ℕ, it is decidable whether f is non-continuous. 

  Π(f : ℕ∞ → ℕ). ¬(continuous f) + ¬¬(continuous f).

Based on the paper 

 "Constructive decidability of classical continuity".
  http://www.cs.bham.ac.uk/~mhe/papers/wlpo-and-continuity-revised.pdf

which is published in MSCS. 

The title of this paper is a bit misleading. It should have been
called "Decidability of non-continuity".

\begin{code}

{-# OPTIONS --without-K --exact-split --safe #-}

open import SpartanMLTT
open import UF-FunExt

module DecidabilityOfNonContinuity (fe : FunExt U₀ U₀) where

open import DiscreteAndSeparated
open import GenericConvergentSequence
open import ADecidableQuantificationOverTheNaturals (fe)
open import DecidableAndDetachable

Lemma-3·1 : (q : ℕ∞ → ℕ∞ → 𝟚) 
          → decidable((m : ℕ) → ¬((n : ℕ) → q (under m) (under n) ≡ ₁))
Lemma-3·1 q = claim₄
 where
  A : ℕ∞ → U₀ ̇
  A u = (n : ℕ) → q u (under n) ≡ ₁
  claim₀ :  (u : ℕ∞) → decidable(A u)
  claim₀ u = Theorem-8·2 (q u)
  p : ℕ∞ → 𝟚
  p = pr₁ (indicator claim₀)
  p-spec : (x : ℕ∞) → (p x ≡ ₀ → A x) × (p x ≡ ₁ → ¬(A x))
  p-spec = pr₂ (indicator claim₀)
  claim₁ : decidable((n : ℕ) → p(under n) ≡ ₁)
  claim₁ = Theorem-8·2 p
  claim₂ : ((n : ℕ) → ¬ A (under n)) → (n : ℕ) → p(under n) ≡ ₁
  claim₂ φ n = Lemma[b≢₀→b≡₁] (λ v → φ n (pr₁ (p-spec (under n)) v)) 
  claim₃ : decidable((n : ℕ) → p(under n) ≡ ₁) → decidable((n : ℕ) → ¬(A(under n)))
  claim₃ (inl f) = inl (λ n → pr₂ (p-spec (under n)) (f n))
  claim₃ (inr u) = inr (contrapositive claim₂ u)
  claim₄ : decidable((n : ℕ) → ¬(A(under n)))
  claim₄ = claim₃ claim₁

\end{code}

Omitting the inclusion function, or coercion,

   under : ℕ → ℕ∞, 

a map f : ℕ∞ → ℕ is called continuous iff
 
   ∃ m. ∀ n ≥ m. f n ≡ ∞, 

where m and n range over the natural numbers.     

The negation of this statement is equivalent to

   ∀ m. ¬ ∀ n ≥ m. f n ≡ ∞.

We can implement ∀ y ≥ x. A y as ∀ x. A(max x y), so that the
continuity of f amounts to

   ∃ m. ∀ n. f(max m n) ≡ ∞,

and its negation to 

   ∀ m. ¬ ∀ n. f(max m n) ≡ ∞.

\begin{code}

non-continuous : (ℕ∞ → ℕ) → U₀ ̇
non-continuous f = (m : ℕ) → ¬((n : ℕ) → f(max (under m) (under n)) ≡[ℕ] f ∞)

Theorem-3·2 : (f : ℕ∞ → ℕ) → decidable(non-continuous f)
Theorem-3·2 f = Lemma-3·1 ((λ x y → χ≡ (f(max x y)) (f ∞)))

\end{code}

(Maybe) to be continued (see the paper for the moment). 

   * MP gives that continuity and doubly negated continuity agree. 

   * WLPO is equivalent to the existence of a non-continuous function ℕ∞ → ℕ.

   * ¬WLPO is equivalent to the doubly negated continuity of all functions ℕ∞ → ℕ.

   * If MP and ¬WLPO then all functions ℕ∞ → ℕ are continuous.

For future use:

\begin{code}

continuous : (ℕ∞ → ℕ) → U₀ ̇
continuous f = Σ \(m : ℕ) → (n : ℕ) → f(max (under m) (under n)) ≡ f ∞

\end{code}
