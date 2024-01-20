{smcl}
{* *! version 1.1.9  11feb2011}{...}
{viewerdialog predict "dialog glim_p"}{...}
{vieweralsosee "[R] glm postestimation" "mansection R glmpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] glm" "help glm"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress postestimation" "help regress_postestimation"}{...}
{viewerjumpto "Description" "glm postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "glm postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "glm postestimation##options_predict"}{...}
{viewerjumpto "Examples" "glm postestimation##examples"}{...}
{viewerjumpto "References" "glm postestimation##references"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R glm postestimation} {hline 2}}Postestimation tools for glm{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt glm}:

{synoptset 13 notes}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_svy_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_lrtest_star
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb glm postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_suest
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
INCLUDE help post_lrtest_star_msg


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {it:statistic} {it:options}]

{synoptset 16 tabbed}{...}
{marker statistic}{...}
{synopthdr :statistic}
{synoptline}
{syntab :Main}
{synopt :{opt m:u}}expected value of y; the default{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt e:ta}}synonym of {opt xb}{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt a:nscombe}}{help glm postestimation##A1953:Anscombe (1953)} residuals{p_end}
{synopt :{opt c:ooksd}}Cook's distance{p_end}
{synopt :{opt d:eviance}}deviance residuals{p_end}
{synopt :{opt h:at}}diagonals of the "hat" matrix{p_end}
{synopt :{opt l:ikelihood}}a weighted average of standardized deviance and standardized Pearson residuals{p_end}
{synopt :{opt p:earson}}Pearson residuals{p_end}
{synopt :{opt r:esponse}}differences between the observed and fitted
outcomes{p_end}
{synopt :{opt s:core}}first derivative of the log likelihood with respect to
xb{p_end}
{synopt :{opt w:orking}}working residuals{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 16 tabbed}{...}
{marker options}{...}
{synopthdr}
{synoptline}
{syntab :Options}
{synopt :{opt nooff:set}}modify calculations to ignore offset variable{p_end}
{synopt :{opt adj:usted}}adjust deviance residual to speed up convergence{p_end}
{synopt :{opt sta:ndardized}}multiply residual by the factor (1-h)^[-1/2]{p_end}
{synopt :{opt stu:dentized}}multiply residual by one over the square root of
the estimated scale parameter{p_end}
{synopt :{opt mod:ified}}modify denominator of residual to be a reasonable
estimate of the variance of {depvar}{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample
{p 4 6 2}
{opt mu}, {opt xb}, {opt stdp}, and {opt score} are the only statistics
allowed with {cmd:svy} estimation results.{p_end}


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt mu}, the default, specifies that {opt predict} calculate the
expected value of y, equal to the number of trials times the inverse link of
the linear prediction.

{phang}
{opt xb} calculates the linear prediction.

{phang}
{opt eta} is a synonym for {opt xb}.

{phang}
{opt stdp} calculates the standard error of the linear predictor.

{phang}
{opt anscombe} calculates the {help glm postestimation##A1953:Anscombe (1953)}
residuals to produce residuals that closely follow a normal distribution.

{phang}
{opt cooksd} calculates Cook's distance, which measures the aggregate change
in the estimated coefficients when each observation is left out of the
estimation.

{phang}
{opt deviance} calculates the deviance residuals.  Deviance residuals are
recommended by 
{help glm postestimation##MN1989:McCullagh and Nelder (1989)}
and by others as having the best
properties for examining the goodness of fit of a GLM.  They are approximately
normally distributed if the model is correct.  They may be plotted against the
fitted values or against a covariate to inspect the model's fit.  Also see the
{opt pearson} option below.

{phang}
{opt hat} calculates the diagonals of the "hat" matrix as an analog to simple
linear regression.

{phang}
{opt likelihood} calculates a weighted average of standardized deviance
and standardized Pearson residuals.

{phang}
{opt pearson} calculates the Pearson residuals.  Pearson
residuals often have markedly skewed distributions for nonnormal family
distributions.  Also see the {opt deviance} option above.

{phang}
{opt response} calculates the differences between the observed and
fitted outcomes.

{phang}
{opt score} calculates the equation-level score, the derivative of the log
likelihood with respect to the linear prediction.

{phang}
{opt working} calculates the working residuals, which are response residuals
weighted according to the derivative of the link function.

{dlgtab:Options}

{phang}
{opt nooffset} is relevant only if you specified 
{opth offset(varname)} for {opt glm}.  It modifies the calculations made by
{opt predict} so that they ignore the offset variable; the linear prediction
is treated as xb rather than xb + offset.

{phang}
{opt adjusted} adjusts the deviance residual to speed up the
convergence to the limiting normal distribution.
The adjustment deals with adding to the deviance residual a higher-order term
that depends on the variance function family.  This option is allowed only 
when {opt deviance} is specified.

{phang}
{opt standardized} requests that the residual be multiplied by the
factor {bind:(1-h)^[-1/2]}, where h is the diagonal of the hat matrix.
This operation is done to account for the correlation between {depvar} and its
predicted value.

{phang}
{opt studentized} requests that the residual be multiplied by one over
the square root of the estimated scale parameter.

{phang}
{opt modified} requests that the denominator of the residual be
modified to be a reasonable estimate of the variance of {depvar}.
The base residual is multiplied by the factor (k/w)^[-1/2], where k is
either one or the user-specified dispersion parameter and w is the
specified weight (or one if left unspecified).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse ldose}{p_end}

{pstd}Fit model to grouped binomial data{p_end}
{phang2}{cmd:. glm r ldose, family(binomial n) link(logit)}{p_end}

{pstd}Calculate expected number of failures{p_end}
{phang2}{cmd:. predict mu_logit}{p_end}

{pstd}Calculate deviance residuals{p_end}
{phang2}{cmd:. predict dr_logit, deviance}{p_end}

{pstd}Perform link test{p_end}
{phang2}{cmd:. linktest, family(binomial n) link(logit)}{p_end}


{marker references}{...}
{title:References}

{marker A1953}{...}
{phang}
Anscombe, F. J. 1953. Contribution of discussion paper by H. Hotelling
"New light on the correlation coefficient and its transforms".
{it:Journal of the Royal Statistical Society, Series B} 15: 229-230.

{marker MN1989}{...}
{phang}
McCullagh, P., and J. A. Nelder. 1989.
{browse "http://www.stata.com/bookstore/glm.html":{it:Generalized Linear Models}. 2nd ed.}
London: Chapman & Hall/CRC.
