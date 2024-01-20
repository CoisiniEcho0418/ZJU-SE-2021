{smcl}
{* *! version 1.1.12  11feb2011}{...}
{viewerdialog predict "dialog glim_p"}{...}
{vieweralsosee "[R] binreg postestimation" "mansection R binregpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] binreg" "help binreg"}{...}
{viewerjumpto "Description" "binreg postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "binreg postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "binreg postestimation##options_predict"}{...}
{viewerjumpto "Examples" "binreg postestimation##examples"}{...}
{viewerjumpto "References" "binreg postestimation##references"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink R binreg postestimation} {hline 2}}Postestimation tools for binreg{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {opt binreg}:

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_linktest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb binreg postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


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
{synopt :{opt e:ta}}synonym for {opt xb}{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt a:nscombe}}{help binreg postestimation##A1953:Anscombe (1953)} residuals{p_end}
{synopt :{opt c:ooksd}}Cook's distance{p_end}
{synopt :{opt d:eviance}}deviance residuals{p_end}
{synopt :{opt h:at}}diagonals of the "hat" matrix as an analog to simple linear
regression{p_end}
{synopt :{opt l:ikelihood}}weighted average of the standardized deviance and
standard Pearson residuals{p_end}
{synopt :{opt p:earson}}Pearson residuals{p_end}
{synopt :{opt r:esponse}}differences between the observed and fitted
outcomes{p_end}
{synopt :{opt sc:ore}}first derivative of the log likelihood with respect to
xb{p_end}
{synopt :{opt w:orking}}working residuals{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 16 tabbed}{...}
{marker options}{...}
{synopthdr :options}
{synoptline}
{syntab :Options}
{synopt :{opt nooff:set}}modify calculations to ignore the offset
variable{p_end}
{synopt :{opt adj:usted}}adjust deviance residual to speed up convergence
{p_end}
{synopt :{opt sta:ndardized}}multiply residual by the factor  (1 - h)^[1/2] {p_end}
{synopt :{opt stu:dentized}}multiply residual by one over the square root of
the estimated scale parameter{p_end}
{synopt :{opt mod:ified}}modify denominator of residual to be a reasonable
estimate of the variance of {depvar}{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


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
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt anscombe} calculates the 
{help binreg postestimation##A1953:Anscombe (1953)} residuals
to produce residuals that closely follow a normal distribution.

{phang}
{opt cooksd} calculates Cook's distance, which measures the aggregate
change in the estimated coefficients when each observation is left out of the
estimation.

{phang}
{opt deviance} calculates the deviance residuals, which are recommended by
{help binreg postestimation##MN1989:McCullagh and Nelder (1989)}
and others as having the best properties for
examining goodness of fit of a GLM.  They are approximately normally
distributed if the model is correct and may be plotted against the fitted
values or against a covariate to inspect the model's fit.  Also see the
{opt pearson} option below.

{phang}
{opt hat} calculates the diagonals of the "hat" matrix as an analog to
simple linear regression.

{phang}
{opt likelihood} calculates a weighted average of the standardized
deviance and standardized Pearson (described below) residuals.

{phang}
{opt pearson} calculates the Pearson residuals, which often have markedly
skewed distributions for nonnormal family distributions.  Also see the
{opt deviance} option above.

{phang}
{opt response} calculates the differences between the observed and
fitted outcomes.

{phang}
{opt score} calculates the equation-level score, the derivative of the log
likelihood with respect to the linear prediction.

{phang}
{opt working} calculates the working residuals, which are response
residuals weighted according to the derivative of the link function.

{dlgtab:Options}

{phang}
{opt nooffset} is relevant only if you specified {opth offset(varname)} for
{opt binreg}.  It modifies the calculations made by {opt predict} so that they
ignore the offset variable; the linear prediction is treated as xb rather
than as xb + offset.

{phang}
{opt adjusted} adjusts the deviance residual to make the convergence to
the limiting normal distribution faster.  The adjustment deals with adding to
the deviance residual a higher-order term depending on the variance
function family.  This option is allowed only when {opt deviance} is
specified.

{phang}
{opt standardized} requests that the residual be multiplied by the
factor (1 - h)^[-1/2], where h is the diagonal of the hat matrix.  This step
is done to take into account the correlation between {depvar} and its
predicted value.

{phang}
{opt studentized} requests that the residual be multiplied by one over
the square root of the estimated scale parameter.

{phang}
{opt modified} requests that the denominator of the residual be modified
to be a reasonable estimate of the variance of {depvar}.  The base residual
is multiplied by the factor (k/w)^[-1/2], where k is either one or the
user-specified dispersion parameter and w is the specified weight (or one if
left unspecified).


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lbw}{p_end}
{phang2}{cmd:. binreg low age lwt race##smoke ptl ht ui, or}{p_end}

{pstd}Predict inverse link of linear prediction{p_end}
{phang2}{cmd:. predict rate, mu}{p_end}

{pstd}Predict deviance residuals{p_end}
{phang2}{cmd:. predict devres, deviance}{p_end}

{pstd}Compute adjusted predicted probabilities for each of the categories of 
{cmd:race} and {cmd:smoke} and their interactions{p_end}
{phang2}{cmd:. margins race##smoke}{p_end}


{marker references}{...}
{title:References}

{marker A1953}{...}
{phang}
Anscombe, F. J.  1953. Contribution of discussion paper by H. Hotelling
"New light on the correlation coefficient and its transform:.
{it:Journal of the Royal Statistical Society, Series B} 15: 229-230.

{marker MN1989}{...}
{phang}
McCullagh, P., and J. A. Nelder. 1989.
{browse "http://www.stata.com/bookstore/glm.html":{it:Generalized Linear Models}. 2nd ed.}
London: Chapman & Hall/CRC.
{p_end}
