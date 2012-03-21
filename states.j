# Coherent state manipulation code, in Julia.
# Compare to Smalltalk for single vs multiple dispatch.


abstract State

type CoherentState <: State
	amplitude :: Complex
end

type GeneralState <: State
	prefactor :: Polynomial
	amplitude :: Complex
end
