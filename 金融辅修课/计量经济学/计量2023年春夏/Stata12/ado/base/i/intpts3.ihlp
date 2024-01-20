{* *! version 1.0.6  06may2011}{...}
{marker intmethod()}{...}
{dlgtab:Integration}

{phang}
{opt intmethod(intmethod)} specifies the integration method to be used
for the random-effects model.  It accepts one of three arguments:
{opt mvaghermite}, the default, performs mean and variance adaptive
Gauss-Hermite quadrature first on every and then on alternate iterations;
{opt aghermite} performs mode and curvature adaptive Gauss-Hermite quadrature
on the first iteration only; {opt ghermite} performs nonadaptive Gauss-Hermite
quadrature. 

{phang} {opt intpoints(#)} specifies the number of integration points to use
for integration by quadrature.  The default is {cmd:intpoints(12)}; the
maximum is {cmd:intpoints(195)}.  Increasing this value improves accuracy but
also increases computation time.  Computation time is roughly proportional to
its value.
