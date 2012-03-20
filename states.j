# Coherent state manipulation code, in Julia.
# Compare to Smalltalk for single vs multiple dispatch.

# Polynomials

abstract Polynomial

type Term <: Polynomial
	exponents :: Vector
	coefficient
end

type NestedPolynomial <: Polynomial
	coefficients :: Vector
end


abstract State

type CoherentState <: State
	amplitude :: Complex
end

type GeneralState <: State
	prefactor :: Polynomial
	amplitude :: Complex
end
