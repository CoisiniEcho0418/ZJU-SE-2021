{smcl}
{* *! version 1.1.8  11feb2011}{...}
{viewerdialog predict "dialog nlsur_p"}{...}
{vieweralsosee "[R] nlsur postestimation" "mansection R nlsurpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] nlsur" "help nlsur"}{...}
{viewerjumpto "Description" "nlsur postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "nlsur postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "nlsur postestimation##options_predict"}{...}
{viewerjumpto "Examples" "nlsur postestimation##examples"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col :{manlink R nlsur postestimation} {hline 2}}Postestimation tools for nlsur{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:nlsur}:

{synoptset 14 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb estat}}AIC, BIC, VCE, and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
{p2coldent:(1) {bf:{help margins}}}marginal means, predictive margins, marginal
                effects, and average marginal effects{p_end}
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb nlsur postestimation##predict:predict}}predictions and residuals{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}(1) You must specify the {cmd:variables()} option with {cmd:nlsur}.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} 
{dtype} 
{newvar} 
{ifin}
[{cmd:,} {opt eq:uation}{cmd:(#}{it:eqno}{cmd:)}
{opt y:hat} {opt r:esiduals}]

INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{cmd:equation(#}{it:eqno}{cmd:)} specifies to which equation you 
are referring.  {cmd:equation(#1)} would mean the calculation is to be 
made for the first equation, {cmd:equation(#2)} would mean the second, 
and so on.  If you do not specify {opt equation()}, results are the same 
as if you specified {cmd:equation(#1)}.

{phang}
{opt yhat}, the default, calculates the fitted values for the specified
equation.

{phang}
{opt residuals} calculates the residuals for the specified equation.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. nlsur (mpg = {b0} + {b1} / turn) (gear_ratio = {c0} + {c1}*length)}{p_end}

{pstd}Calculate fitted values for the first equation{p_end}
{phang2}{cmd:. predict mpghat, equation(#1)}{p_end}

{pstd}Calculate residuals for the second equation{p_end}
{phang2}{cmd:. predict gearerr, residuals equation(#2)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse mfgcost, clear}{p_end}
{phang2}{cmd:. nlsur (s_k = {c -(}bk{c )-} + {c -(}dkk{c )-}*ln(pk/pm) +}
                       {cmd:{c -(}dkl{c )-}*ln(pl/pm) +}
                       {cmd:{c -(}dke{c )-}*ln(pe/pm))}
                {cmd:(s_l = {c -(}bl{c )-} + {c -(}dkl{c )-}*ln(pk/pm) +}
                       {cmd:{c -(}dll{c )-}*ln(pl/pm) +}
                       {cmd:{c -(}dle{c )-}*ln(pe/pm))}
                {cmd:(s_e = {c -(}be{c )-} + {c -(}dke{c )-}*ln(pk/pm) +}
                       {cmd:{c -(}dle{c )-}*ln(pl/pm) +}
                       {cmd:{c -(}dee{c )-}*ln(pe/pm)),}
                       {cmd:ifgnls variables(pk pm pl pe)}

{pstd}Measure change in energy cost share with respect to change in price of
energy{p_end}
{phang2}{cmd:. margins, dydx(pe) predict(equation(#3))}{p_end}

    {hline}
