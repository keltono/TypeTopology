Brendan Hart 2019-2020

\begin{code}

{-# OPTIONS --without-K --safe --exact-split --no-sized-types --no-guardedness --auto-inline #-}

open import MLTT.Spartan
open import UF.FunExt
open import UF.PropTrunc
open import UF.Subsingletons

module PCF.ScottModelTypes
        (pt : propositional-truncations-exist)
        (fe : ∀ {𝓤 𝓥} → funext 𝓤 𝓥)
        (pe : propext 𝓤₀)
       where

open import DomainTheory.Basics.Dcpo pt fe 𝓤₀
open import DomainTheory.Basics.Exponential pt fe 𝓤₀
open import DomainTheory.Basics.Pointed pt fe 𝓤₀
open import DomainTheory.Lifting.LiftingSet pt fe 𝓤₀ pe
open import PCF.AbstractSyntax pt
open import UF.Miscelanea

ℕ⊥ : DCPO⊥
ℕ⊥ = 𝓛-DCPO⊥ ℕ-is-set

⟦_⟧ : type → DCPO⊥ {𝓤₁} {𝓤₁}
⟦ ι ⟧     = ℕ⊥
⟦ σ ⇒ τ ⟧ = ⟦ σ ⟧ ⟹ᵈᶜᵖᵒ⊥ ⟦ τ ⟧

\end{code}
