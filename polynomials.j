# Multivariate polynomial routines
# 
# For now, coefficients are stored as nested lists.

abstract Polynomial


type Term <: Polynomial
	# A term with no exponents represents a constant, not a polynomial.  This is affords functions polymorphic over polynomials and constants.
	exponents
	coefficient
end

# default case: it's a constant
terms(x) = x == 0 ? [] : [Term([], x)]
vars(x) = 0

vars(f :: Term) = length(f.exponents)
terms(f :: Term) = [f]


type NestedPolynomial <: Polynomial
	# Note: the zero polynomial has coefficients [0], not [].  Among other things, this defines how many variables it takes.
	coefficients :: Vector
end

vars(f :: NestedPolynomial) = 
	let c = f.coefficients[1]
		isa(c, Polynomial) ? vars(c)+1 : 1
	end
	
degree(f :: NestedPolynomial) = length(f.coefficients) - 1
	
terms(f :: NestedPolynomial) = @task termproducer(f)

function termproducer(f)
	for n = 0:degree(f)
		for t in terms(f.coefficients[n+1])
			produce(Term([n, t.exponents], t.coefficient))
		end
	end
end


## Display

variables = ['x':'z', 't':'w', 'a':'s']
supchars = {'0' => '⁰', '1' => '¹', '2' => '²', '3' => '³', '-' => '⁻'}
for c = '4':'9'
	supchars[c] = char(c - '4' + '⁴')
end

printexpt(n :: Integer) = print(map(c -> supchars[c], string(n)))

function printvars(f :: Term)
	let xs = variables[f.exponents > 0], ns = f.exponents[f.exponents > 0] 
		for i = 1:length(ns)
			print(xs[i])
			ns[i] > 1 && printexpt(ns[i])
		end
	end
end

printcft(f :: Term) =
	if f.coefficient != 1 || all(f.exponents == 0)
		print(f.coefficient)
	end

function printlhs(f :: Polynomial)
	for i = 1:vars(f)
		print(variables[i])
		i < vars(f) && print(",")
	end
	print(" -> ")
end

function print(f :: Term)
	printcft(f)
	printvars(f)
end

function show(f :: Polynomial)
	printlhs(f)
	sep = ""
	for t in terms(f)
		print(sep)
		print(t)
		sep = " + "
	end
	sep == "" && print("0")
end