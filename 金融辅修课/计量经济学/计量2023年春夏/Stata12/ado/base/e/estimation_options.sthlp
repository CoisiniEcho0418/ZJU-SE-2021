{smcl}
{* *! version 1.3.9  03may2011}{...}
{vieweralsosee "[R] estimation options" "mansection R estimationoptions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[I] estimation commands" "help estimation_commands"}{...}
{viewerjumpto "Description" "estimation options##description"}{...}
{viewerjumpto "Options" "estimation options##options"}{...}
{viewerjumpto "Examples" "estimation options##examples"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R estimation options} {hline 2}}Estimation options{p_end}


{marker description}{...}
{title:Description}

{pstd}
This entry describes the options common to many estimation commands.
Not all the options documented below work with all estimation commands.
See the documentation for the particular estimation command; if an
option is listed there, it is applicable.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{marker noconstant}{...}
{opt noconstant}
suppresses the constant term (intercept) in the model.

{phang}
{marker offset()}{...}
{opth offset(varname)} specifies that {it:varname} be included in the
model with the coefficient constrained to be 1.

{phang}
{marker exposure()}{...}
{opth exposure(varname)}
specifies a variable that reflects the amount of exposure over
which the {depvar} events were observed for each observation;
ln({it:varname}) with coefficient constrained to be 1 is entered into the
log-link function.

{phang}
{marker constraints()}
{cmd:constraints(}{it:{help numlist}}{c |}{it:matname}{cmd:)}
specifies the linear constraints to be applied during estimation.
The default is to perform unconstrained estimation.
See {manhelp reg3 R} for the use of constraints in multiple-equation contexts.

{pmore}
{opt constraints(numlist)} specifies the constraints by number after they
have been defined by using the {cmd:constraint} command; see
{helpb constraint:[R] constraint}.  Some commands
(for example, {cmd:slogit}) allow only {opt constraints(numlist)}.

{pmore}
{opt constraints(matname)} specifies a matrix containing the constraints;
see {manhelp makecns P}.

{pmore}
{opt constraints(clist)} is used by some estimation commands, such as
{cmd:mlogit}, where {it:clist} has the form
{bind:{it:#}[{cmd:-}{it:#}][{cmd:,}{it:#}[{cmd:-}{it:#}] {it:...} ]}.

{phang}
{marker collinear}
{opt collinear} specifies that the estimation command not omit collinear
variables.  Usually, there is no reason to leave collinear variables in place,
and, in fact, doing so usually causes the estimation to fail because of the
matrix singularity caused by the collinearity.  However, with certain models,
the variables may be collinear, yet the model is fully identified because of
constraints or other features of the model.  In such cases, using the 
{cmd:collinear} option allows the estimation to take place, leaving the
equations with collinear variables intact.  This option is seldom used.

{phang}
{marker force}
{opt force} specifies that estimation be forced even though the time variable
is not equally spaced.  This is relevant only for correlation structures that
require knowledge of the time variable.  These correlation structures require
that observations be equally spaced so that calculations based on lags
correspond to a constant time change.  If you specify a time variable
indicating that observations are not equally spaced, the (time dependent) model
will not be fit.  If you also specify {opt force}, the model will be
fit, and it will be assumed that the lags based on the data ordered by
the time variable are appropriate.

{marker corr()}{...}
{dlgtab:Correlation}

{phang}
{opt corr(correlation)} specifies the within-group correlation
structure; the default corresponds to the equal-correlation model,
{cmd:corr(exchangeable)}.

{pmore}
When you specify a correlation structure that requires a lag, you indicate the
lag after the structure's name with or without a blank; for example,
{cmd:corr(ar 1)} or {cmd:corr(ar1)}.

{pmore}
If you specify the fixed correlation structure, you specify the name of the
matrix containing the assumed correlations following the word {cmd:fixed},
for example, {cmd:corr(fixed myr)}.

{dlgtab:Reporting}

{phang}
{marker level()}{...}
{opt level(#)}
specifies the confidence level, as a percentage, for confidence intervals.
The default is {cmd:level(95)} or as set by {helpb set level}.

{phang}
{marker noskip}
{opt noskip} specifies that a full maximum-likelihood model with only a constant
    for the regression equation be fit.  This model is not displayed but
    is used as the base model to compute a likelihood-ratio test for the model
    test statistic displayed in the estimation header.  By default, the
    overall model test statistic is an asymptotically equivalent Wald test of
    all the parameters in the regression equation being zero (except the
    constant).  For many models, this option can substantially increase
    estimation time.

{marker nocnsreport}{...}
{phang}
{opt nocnsreport} specifies that no constraints be reported.  The default is to
    display user-specified constraints above the coefficient table.

{marker display_options}{...}
{phang}
{opt noomitted} specifies that variables that were omitted because of
collinearity not be displayed.  The default is to include in the table
any variables omitted because of collinearity and to label them as "(omitted)".

{phang}
{opt vsquish} specifies that the blank space separating factor-variable
          terms or time-series-operated variables from other variables
          in the model be suppressed.

{phang}
{opt noemptycells} specifies that empty cells for interactions of factor
variables not be displayed.  The default is to include in the table interaction
cells that do not occur in the estimation sample and to label them as
"(empty)".

{phang}
{opt baselevels} and {opt allbaselevels} control whether the base levels of
factor variables and interactions are displayed.  The default is to exclude
from the table all base categories. 

{phang2}
        {opt baselevels} specifies that base levels be reported for factor
                variables and for interactions whose bases cannot be inferred
                from their component factor variables.

{phang2}
        {opt allbaselevels} specifies that all base levels of factor variables
                and interactions be reported.

{marker cformat}{...}
{phang}
{opth cformat(%fmt)} specifies how to format coefficients, standard errors, and
confidence limits in the coefficient table.

{marker pformat}{...}
{phang}
{opth pformat(%fmt)} specifies how to format p-values in the coefficient table.

{marker sformat}{...}
{phang}
{opth sformat(%fmt)} specifies how to format test statistics in the coefficient
table.

{marker nolstretch}{...}
{phang}
{opt nolstretch} specifies that the width of the coefficient table not be
automatically widened to accommodate longer variable names. The default,
{cmd:lstretch}, is to automatically widen the coefficient table up to
the width of the Results window.  To change the default, use
{helpb lstretch:set lstretch off}. {opt nolstretch} is not shown in the
dialog box.
{p_end}

INCLUDE help intpts3


{pstd}
The following option is not shown in the dialog box:

{marker coeflegend}{...}
{phang}
{opt coeflegend} specifies that the legend of the coefficients and how to
              specify them in an expression be displayed rather than
              displaying the statistics for the coefficients.
{p_end}


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse dollhill3}{p_end}
{phang2}{cmd:. generate lnpyears = ln(pyears)}{p_end}
{phang2}{cmd:. constraint 1 smokes#3.agecat = smokes#4.agecat}

{pstd}Fit a Poisson regression, specifying an exposure of {cmd:pyears}{p_end}
{phang2}{cmd:. poisson deaths smokes i.agecat, exposure(pyears)}

{pstd}Same as above{p_end}
{phang2}{cmd:. poisson deaths smokes i.agecat, offset(lnpyears)}

{pstd}Replay results, but with 99% confidence intervals{p_end}
{phang2}{cmd:. poisson, level(99)}

{pstd}Replay results, suppressing the blank space separating factor-variable
terms from other variables{p_end}
{phang2}{cmd:. poisson, vsquish}

{pstd}Replay results, showing coefficients, standard errors, and confidence
limits to 4 decimal places{p_end}
{phang2}{cmd:. poisson, cformat(%8.4f)}

{pstd}Display coefficient legend, showing how to specify coefficients in an
expression{p_end}
{phang2}{cmd:. poisson, coeflegend}

{pstd}Fit a Poisson regression, constraining the smoking effects on age
categories 3 and 4 to be equal{p_end}
{phang2}{cmd:. poisson deaths c.smokes#agecat i.agecat, exposure(pyears)}
 {cmd:constraints(1)}

{pstd}Same as above, but suppress the display of the constraint above the
coefficient table{p_end}
{phang2}{cmd:. poisson deaths c.smokes#agecat i.agecat, exposure(pyears)}
 {cmd:constraints(1) nocnsreport}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse union, clear}

{pstd}Fit random-effects probit model, using 20 quadrature points instead of
the default of 12{p_end}
{phang2}{cmd:. xtprobit union age grade i.not_smsa south##c.year, intpoints(20)}

{pstd}Fit random-effects probit model, specifying the {cmd:ghermite}
integration method be used{p_end}
{phang2}{cmd:. xtprobit union age grade i.not_smsa south##c.year,}
    {cmd:intmethod(ghermite)}

{pstd}Replay results, showing base levels of {cmd:not_smsa} and {cmd:south}
in the table{p_end}
{phang2}{cmd:. xtprobit, baselevels}

{pstd}Same as above, but also show the base level for {cmd:south#c.year}{p_end}
{phang2}{cmd:. xtprobit, allbaselevels}

    {hline}
