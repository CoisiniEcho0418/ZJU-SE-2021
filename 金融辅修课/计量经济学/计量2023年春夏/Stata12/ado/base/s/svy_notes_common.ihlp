{* *! version 1.0.8  02apr2009}{...}
{p 4 6 2}
{cmd:svy} requires that the survey design variables be identified using
{helpb svyset}.
{p_end}
{p 4 6 2}
See {helpb svy postestimation:[SVY] svy postestimation} for features available
after estimation.
{p_end}
{p 4 6 2}
Warning:  Using {cmd:if} or {cmd:in} restrictions will often not produce correct
variance estimates for subpopulations.  To compute estimates
for subpopulations, use the {cmd:subpop()} option.
{p_end}
