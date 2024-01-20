{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog estat "dialog estat_bootstrap"}{...}
{vieweralsosee "[R] bootstrap postestimation" "mansection R bootstrappostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{viewerjumpto "Description" "bootstrap postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation command" "bootstrap postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "bootstrap postestimation##syntax_predict"}{...}
{viewerjumpto "Syntax for estat bootstrap" "bootstrap postestimation##syntax_estat_bootstrap"}{...}
{viewerjumpto "Options for estat bootstrap" "bootstrap postestimation##options_estat_bootstrap"}{...}
{viewerjumpto "Examples" "bootstrap postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink R bootstrap postestimation} {hline 2}}Postestimation tools for
bootstrap{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation command is of special interest after {cmd:bootstrap}:

{synoptset 19}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb bootstrap postestimation##estatbootstrap:estat bootstrap}}percentile-based 
	and bias-corrected CI tables{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 19 tabbed}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{p2coldent :* {bf:{help contrast}}}contrasts and ANOVA-style joint tests of
                estimates{p_end}
INCLUDE help post_estat
INCLUDE help post_estimates
{p2coldent :* {bf:{help hausman}}}Hausman's specification test{p_end}
{p2coldent :* {bf:{help lincom}}}point estimates, standard errors, testing, and
inference for linear combinations of coefficients{p_end}
{p2coldent :* {bf:{help margins}}}marginal means, predictive margins, marginal
                effects, and average marginal effects{p_end}
{p2coldent:* {bf:{help marginsplot}}}graph the results from margins
            (profile plots, interaction plots, etc.){p_end}
{p2coldent :* {bf:{help nlcom}}}point estimates, standard errors, testing and
inference for nonlinear combinations of coefficients{p_end}
{p2coldent :* {helpb bootstrap postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
{p2coldent :* {helpb predictnl}}point estimates, standard errors, testing, and inference for generalized predictions{p_end}
{p2coldent :* {bf:{help pwcompare}}}pairwise comparisons of estimates{p_end}
{p2coldent :* {bf:{help test}}}Wald tests of simple and composite linear
hypotheses{p_end}
{p2coldent :* {bf:{help testnl}}}Wald tests of nonlinear hypotheses{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* This postestimation command is allowed if it may be used after {it:command}.


{marker special}{...}
{title:Special-interest postestimation command}

{pstd}
{cmd:estat bootstrap} displays a table of confidence intervals for each
statistic from a bootstrap analysis.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{pstd}
The syntax of {cmd:predict} (and even if {cmd:predict} is allowed) following
{cmd:bootstrap} depends upon the {it:command} used with {cmd:bootstrap}.
If {cmd:predict} is not allowed, neither is {cmd:predictnl}.


{marker syntax_estat_bootstrap}{...}
{marker estatbootstrap}{...}
{title:Syntax for estat bootstrap}

{p 8 14 2}
{cmd:estat} {cmdab:boot:strap} [{cmd:,} {it:options}]

{synoptset 14}{...}
{synopthdr}
{synoptline}
{synopt :{opt bc}}bias-corrected CIs; the default{p_end}
{synopt :{opt bca}}bias-corrected and accelerated (BC_a) CIs{p_end}
{synopt :{opt nor:mal}}normal-based CIs{p_end}
{synopt :{opt p:ercentile}}percentile CIs{p_end}
{synopt :{opt all}}all available CIs{p_end}
{synopt :{opt nohead:er}}suppress table header{p_end}
{synopt :{opt noleg:end}}suppress table legend{p_end}
{synopt :{opt v:erbose}}display the full table legend{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt bc}, {opt bca}, {opt normal}, and {opt percentile} may be used
together.


INCLUDE help menu_estat


{marker options_estat_bootstrap}{...}
{title:Options for estat bootstrap}

{phang}
{opt bc} is the default and displays bias-corrected confidence intervals.

{phang}
{opt bca} displays bias-corrected and accelerated confidence intervals.  
This option assumes that you also specified the {cmd:bca} option on the 
{cmd:bootstrap} prefix command.

{phang}
{opt normal} displays normal approximation confidence intervals.

{phang}
{opt percentile} displays percentile confidence intervals.

{phang}
{opt all} displays all available confidence intervals.

{phang}
{opt noheader} suppresses display of the table header.  This option implies
{opt nolegend}.

{phang}
{opt nolegend} suppresses display of the table legend, which identifies the
rows of the table with the expressions they represent.

{phang}
{opt verbose} requests that the full table legend be displayed.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. bootstrap, reps(100) bca: regress mpg weight gear foreign}{p_end}

{pstd}Obtain bias-corrected CIs{p_end}
{phang2}{cmd:. estat bootstrap}

{pstd}Obtain bias-corrected and accelerated CIs{p_end}
{phang2}{cmd:. estat bootstrap, bca}

{pstd}Obtain all available CIs{p_end}
{phang2}{cmd:. estat bootstrap, all}

{pstd}Test that coefficients on {cmd:gear} and {cmd:foreign} sum to 0{p_end}
{phang2}{cmd:. test gear + foreign = 0}

{pstd}Compute estimate, SE, test statistic, significance level, and CI for the
ratio of coefficient of {cmd:gear_ratio} to the coefficient of {cmd:foreign}
{p_end}
{phang2}{cmd:. nlcom _b[gear_ratio] / _b[foreign]}{p_end}
