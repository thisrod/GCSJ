This Julia library represents quantum states of the form P(a†, α*, α) |α〉.   Here |α〉 is a multimode boson coherent state, and P is a multivariate polynomial.  The form is closed under raising and lowering operations, displacement, and differentiation wrt α.

The file <tt>polynomials.j</tt> implements multivariate polynomials.  The way it works is best illustrated by example.  Let f(x) = 4x, and g(x) = x²+1.  Then (f+g)(x)=x²+4x+1, as usual.  However, (fg)(x, y)=4x(y²+1).  The usual product, 4x(x²+1), is given by <tt>identify</tt>(fg, 1, 2).  This feels right, but we'll see how it works out.

Perhaps polynomials should act on nested tuples of arguments, not just tuples?