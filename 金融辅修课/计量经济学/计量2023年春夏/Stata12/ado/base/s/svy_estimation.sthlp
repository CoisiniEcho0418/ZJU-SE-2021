{smcl}
{* *! version 1.1.9  23mar2011}{...}
{vieweralsosee "[SVY] svy estimation" "mansection SVY svyestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy postestimation" "help svy_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] estat" "help svy_estat"}{...}
{vieweralsosee "[SVY] svy" "help svy"}{...}
{vieweralsosee "[SVY] svyset" "help svyset"}{...}
{viewerjumpto "Description" "svy_estimation##description"}{...}
{viewerjumpto "Examples" "svy_estimation##examples"}{...}
{p2colset 5 27 29 2}{...}
{title:Title}

{pstd}
{manlink SVY svy estimation} {hline 2} Estimation commands for survey data


{marker description}{...}
{title:Description}

{pstd}
Survey data analysis in Stata is essentially the same as standard data
analysis.
The standard syntax applies; you just need to also remember the following:

{phang2}
o  Use {cmd:svyset} to identify the survey design characteristics.

{phang2}
o  Prefix the estimation commands with {cmd:svy:}.

{pstd}
For example,

{pmore2}
{cmd:. webuse nhanes2f}{break}
{cmd:. svyset psuid [pweight=finalwgt], strata(stratid)}{break}
{cmd:. svy: regress zinc age c.age#c.age weight female black orace rural}

{pstd}
See {manhelp svyset SVY} and {manhelp svy SVY}.

{pstd}
The following estimation commands support the {cmd:svy} prefix.

{synoptset 20 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{syntab:Descriptive statistics}
{synopt :{helpb mean}}Estimate means{p_end}
{synopt :{helpb proportion}}Estimate proportions{p_end}
{p2col :{helpb ratio}}Estimate ratios{p_end}
{p2col :{helpb total}}Estimate totals{p_end}

{syntab:Linear regression models}
{p2col :{helpb cnsreg}}Constrained linear regression{p_end}
{p2col :{helpb glm}}Generalized linear models{p_end}
{p2col :{helpb intreg}}Interval regression{p_end}
{p2col :{helpb nl}}Nonlinear least-squares estimation{p_end}
{p2col :{helpb regress}}Linear regression{p_end}
{p2col :{helpb sem}}Structural equation models{p_end}
{p2col :{helpb tobit}}Tobit regression{p_end}
{p2col :{helpb treatreg}}Treatment-effects model{p_end}
{p2col :{helpb truncreg}}Truncated regression{p_end}

{syntab:Survival-data regression models}
{p2col :{helpb stcox}}Cox proportional hazards model{p_end}
{p2col :{helpb streg}}Parametric survival models{p_end}

{syntab:Binary-response regression models}
{p2col :{helpb biprobit}}Bivariate probit regression{p_end}
{p2col :{helpb cloglog}}Complementary log-log regression{p_end}
{p2col :{helpb hetprob}}Heteroskedastic probit regression{p_end}
{p2col :{helpb logistic}}Logistic regression, reporting odds ratios{p_end}
{p2col :{helpb logit}}Logistic regression, reporting coefficients{p_end}
{p2col :{helpb probit}}Probit regression{p_end}
{p2col :{helpb scobit}}Skewed logistic regression{p_end}

{syntab:Discrete-response regression models}
{p2col :{helpb clogit}}Conditional (fixed-effects) logistic regression{p_end}
{p2col :{helpb mlogit}}Multinomial (polytomous) logistic regression{p_end}
{p2col :{helpb mprobit}}Multinomial probit regression{p_end}
{p2col :{helpb ologit}}Ordered logistic regression{p_end}
{p2col :{helpb oprobit}}Ordered probit regression{p_end}
{p2col :{helpb slogit}}Stereotype logistic regression{p_end}

{syntab:Poisson regression models}
{p2col :{helpb gnbreg}}Generalized negative binomial regression{p_end}
{p2col :{helpb nbreg}}Negative binomial regression{p_end}
{p2col :{helpb poisson}}Poisson regression{p_end}
{p2col :{helpb tnbreg}}Truncated negative binomial regression{p_end}
{p2col :{helpb tpoisson}}Truncated Poisson regression{p_end}
{p2col :{helpb zinb}}Zero-inflated negative binomial regression{p_end}
{p2col :{helpb zip}}Zero-inflated Poisson regression{p_end}

{syntab:Instrumental-variables regression models}
{p2col :{helpb ivprobit}}Probit model with endogenous regressors{p_end}
{p2col :{helpb ivregress}}Single-equation instrumental-variables regression{p_end}
{p2col :{helpb ivtobit}}Tobit model with continuous endogenous regressors{p_end}

{syntab:Regression models with selection}
{p2col :{helpb heckman}}Heckman selection model{p_end}
{p2col :{helpb heckprob}}Probit model with sample selection{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Survey data analysis >} ...

{pstd}
Dialog boxes for all statistical estimators that support {cmd:svy} can be
found on the above menu path.  In addition, you can access survey data
estimation from standard dialog boxes on the {bf:SE/Robust} or
{bf:SE/Cluster} tab.


{marker examples}{...}
{title:Examples}

{pstd}
Descriptive statistics
{p_end}
{phang}
{cmd:. webuse nmihs}
{p_end}
{phang}
{cmd:. svyset [pweight=finwgt], strata(stratan)}
{p_end}
{phang}
{cmd:. svy: mean birthwgt}
{p_end}

{pstd}
Regression models
{p_end}
{phang}
{cmd:. webuse nhanes2d}
{p_end}
{phang}
{cmd:. svyset}
{p_end}
{phang}
{cmd:. svy: logistic highbp height weight age age2 female}
{p_end}
{phang}
{cmd:. svy, subpop(female): logistic highbp height weight age age2}
{p_end}

{pstd}
Cox proportional hazards model
{p_end}
{phang}
{cmd:. webuse nhefs}
{p_end}
{phang}
{cmd:. svyset psu2 [pw=swgt2], strata(strata2)}
{p_end}
{phang}
{cmd:. stset age_lung_cancer [pw=swgt2], fail(lung_cancer)}
{p_end}
{phang}
{cmd:. svy: stcox former_smoker smoker male urban1 rural}
{p_end}

{pstd}
Multiple baseline hazards
{p_end}
{phang}
{cmd:. stphplot, strata(revised_race) adjust(former_smoker smoker male urban1 rural) zero legend(col(1))}
{p_end}
{phang}
{cmd:. svy: stcox former_smoker smoker male urban1 rural, strata(revised_race)}
{p_end}
