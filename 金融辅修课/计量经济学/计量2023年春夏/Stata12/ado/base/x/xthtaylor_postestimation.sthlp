{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog xtht_p"}{...}
{vieweralsosee "[XT] xthtaylor postestimation" "mansection XT xthtaylorpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xthtaylor" "help xthtaylor"}{...}
{viewerjumpto "Description" "xthtaylor postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xthtaylor postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xthtaylor postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xthtaylor postestimation##examples"}{...}
{title:Title}

{p2colset 5 38 40 2}{...}
{p2col :{manlink XT xthtaylor postestimation} {hline 2}}Postestimation tools for xthtaylor{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xthtaylor}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xthtaylor postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]

{synoptset 13 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}B*x[i,t] + G*z[i] fitted values; the default{p_end}
{synopt :{opt stdp}}standard error of the fitted values{p_end}
{synopt :{opt ue}}u[i] + e[i,t], the combined residual{p_end}
{p2coldent :* {opt xbu}}B*x[i,t] + G*z[i] + u[i], prediction including effect{p_end}
{p2coldent :* {opt u}}u[i], the random-error component{p_end}
{p2coldent :* {opt e}}e[i,t], prediction of the idiosyncratic error component{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help unstarred


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction,
that is, B*x[i,t] + G*z[i].

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt ue} calculates the prediction of u[i] + e[i,t].

{phang}
{opt xbu} calculates the prediction of B*x[i,t] + G*z[i] + u[i], the
prediction including the random effect.

{phang}
{opt u} calculates the prediction of u[i], the estimated
random effect.

{phang}
{opt e} calculates the prediction of e[i,t].


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse psidextract}{p_end}
{phang2}{cmd:. xthtaylor lwage wks south smsa ms exp exp2 occ ind union fem}
                {cmd:blk ed, endog(exp exp2 occ ind union ed) i(id)}{p_end}

{pstd}Test that coefficient on {cmd:fem} equals 0{p_end}
{phang2}{cmd:. test fem = 0}

{pstd}Test that coefficients on {cmd:fem} and {cmd:blk} are jointly equal to 0
{p_end}
{phang2}{cmd:. test blk = 0, accumulate}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict xb}

{pstd}Linear prediction including random effect{p_end}
{phang2}{cmd:. predict xbandre, xbu}{p_end}
