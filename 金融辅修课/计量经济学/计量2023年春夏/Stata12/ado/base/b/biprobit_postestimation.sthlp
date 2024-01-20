{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog bipr_p"}{...}
{vieweralsosee "[R] biprobit postestimation" "mansection R biprobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] biprobit" "help biprobit"}{...}
{viewerjumpto "Description" "biprobit postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "biprobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "biprobit postestimation##options_predict"}{...}
{viewerjumpto "Examples" "biprobit postestimation##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink R biprobit postestimation} {hline 2}}Postestimation tools for biprobit{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:biprobit}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb biprobit postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
{p 4 6 2}(1) {cmd:lrtest} is not appropriate with {cmd:svy} estimation results.
{p_end}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} 
{dtype}
{newvar} 
{ifin}
[{cmd:,} {it:statistic} {opt nooff:set}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvar:newvar_eq1}} {it:{help newvar:newvar_eq2}}
                     {it:{help newvar:newvar_athrho}}{c )-}
{ifin}
{cmd:,}
{opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt p:11}}Pr({it:depvar1}=1, {it:depvar2}=1); the default{p_end}
{synopt :{opt p10}}Pr({it:depvar1}=1, {it:depvar2}=0){p_end}
{synopt :{opt p01}}Pr({it:depvar1}=0, {it:depvar2}=1){p_end}
{synopt :{opt p00}}Pr({it:depvar1}=0, {it:depvar2}=0){p_end}
{synopt :{opt pmarg1}}Pr({it:depvar1}=1); marginal success probability for equation 1{p_end}
{synopt :{opt pmarg2}}Pr({it:depvar2}=1); marginal success probability for equation 2{p_end}
{synopt :{opt pcond1}}Pr({it:depvar1}=1 | {it:depvar2}=1){p_end}
{synopt :{opt pcond2}}Pr({it:depvar2}=1 | {it:depvar1}=1){p_end}
{synopt :{opt xb1}}linear prediction for equation 1{p_end}
{synopt :{opt xb2}}linear prediction for equation 2{p_end}
{synopt :{opt stdp1}}standard error of the linear prediction for equation 1{p_end}
{synopt :{opt stdp2}}standard error of the linear prediction for equation 2{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{phang}
{opt p11}, the default, calculates the bivariate predicted probability
Pr({it:depvar1}=1, {it:depvar2}=1).

{phang}
{opt p10} calculates the bivariate predicted probability Pr({it:depvar1}=1,
{it:depvar2}=0).

{phang}
{opt p01} calculates the bivariate predicted probability Pr({it:depvar1}=0,
{it:depvar2}=1).

{phang}
{opt p00} calculates the bivariate predicted probability Pr({it:depvar1}=0,
{it:depvar2}=0).

{phang}
{opt pmarg1} calculates the univariate (marginal) predicted probability
of success Pr({it:depvar1}=1).

{phang}
{opt pmarg2} calculates the univariate (marginal) predicted probability
of success Pr({it:depvar2}=1).

{phang}
{opt pcond1} calculates the conditional (on success in equation 2)
predicted probability of success Pr({it:depvar1}=1 | {it:depvar2}=1).

{phang}
{opt pcond2} calculates the conditional (on success in equation 1)
predicted probability of success Pr({it:depvar2}=1 | {it:depvar1}=1).

{phang}
{opt xb1} calculates the probit linear prediction for equation 1.

{phang}
{opt xb2} calculates the probit linear prediction for equation 2.

{phang}
{opt stdp1} calculates the standard error of the linear prediction of
equation 1.

{phang}
{opt stdp2} calculates the standard error of the linear prediction of
equation 2.

{phang}
{opt nooffset} is relevant only if you specified {opth offset1(varname)} or 
{opt offset2(varname)} for
{cmd:biprobit}.  It modifies the calculations made by {opt predict} so that
they ignore the offset variables; the linear predictions are treated as 
xb rather than xb + offset1 and z_[gamma] rather than as
z_[gamma] + offset2.

{phang}
{opt scores} calculates equation-level score variables.

{pmore}
The first new variable will contain the derivative of the log likelihood with
respect to the first regression equation.

{pmore}
The second new variable will contain the derivative of the log likelihood with
respect to the second regression equation.

{pmore}
The third new variable will contain the derivative of the log likelihood with
respect to the third equation ({hi:athrho}).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse school}{p_end}
{phang2}{cmd:. biprobit private vote logptax loginc years}{p_end}

{pstd}Predicted probability {cmd:private} = 1 and {cmd:vote} = 1{p_end}
{phang2}{cmd:. predict both1}

{pstd}Predicted probability {cmd:private} = 1 and {cmd:vote} = 0{p_end}
{phang2}{cmd:. predict prob10, p10}

{pstd}Predicted probability {cmd:private} = 1 given {cmd:vote} = 1{p_end}
{phang2}{cmd:. predict priv_given_vote, pcond1}

{pstd}Test whether the coefficients are equal across equations{p_end}
{phang2}{cmd:. test [private=vote]: logptax loginc years}

{pstd}Test whether the coefficients on {cmd:years} are jointly 0 across
equations{p_end}
{phang2}{cmd:. test [private]years = 0, notest}{p_end}
{phang2}{cmd:. test [vote]years = 0, accumulate}

{pstd}Compute marginal effects of {cmd:logptax} and {cmd:loginc} on the
conditional probability Pr({cmd:vote} = 1|{cmd:private} = 1) at the
regressors' means{p_end}
{phang2}{cmd:. margins, predict(pcond2) dydx(logptax loginc) atmeans}{p_end}
