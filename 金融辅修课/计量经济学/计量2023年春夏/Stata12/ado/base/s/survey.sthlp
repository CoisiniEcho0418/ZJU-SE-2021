{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[SVY] survey" "mansection SVY survey"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estat" "help estat"}{...}
{vieweralsosee "[R] jackknife" "help jackknife"}{...}
{vieweralsosee "[R] lincom" "help lincom"}{...}
{vieweralsosee "[R] nlcom" "help nlcom"}{...}
{vieweralsosee "[R] predict" "help predict"}{...}
{vieweralsosee "[R] predictnl" "help predictnl"}{...}
{vieweralsosee "[R] test" "help test"}{...}
{vieweralsosee "[R] testnl" "help testnl"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] _robust" "help _robust"}{...}
{viewerjumpto "Description" "survey##description"}{...}
{viewerjumpto "Examples" "survey##examples"}{...}
{title:Title}

{pstd}
{manlink SVY survey} {hline 2} Introduction to survey commands


{marker description}{...}
{title:Description}

{pstd}
Stata's facilities for survey data are centered around the {cmd:svy} prefix
command.  This overview organizes and presents the commands conceptually, that
is, according to the similarities in the functions that they perform.


{p2colset 5 37 39 2}{...}
{pstd}
{bf:Survey design tools}

{p2col :{manhelp svyset SVY}}Declare survey design for dataset{p_end}
{p2col :{manhelp svydescribe SVY}}Describe survey data{p_end}


{pstd}
{bf:Survey data analysis tools}

{p2col :{manhelp svy SVY}}The survey prefix command{p_end}
{p2col :{manhelp svy_estimation SVY:svy estimation}}Estimation commands for survey data{p_end}
{p2col :{manhelp svy_tabulate_oneway SVY:svy: tabulate oneway}}One-way tables for survey data{p_end}
{p2col :{manhelp svy_tabulate_twoway SVY:svy: tabulate twoway}}Two-way tables for survey data{p_end}
{p2col :{manhelp svy_postestimation SVY:svy postestimation}}Postestimation tools for svy{p_end}
{p2col :{manhelp estat_svy SVY:estat}}Postestimation statistics for survey data, such as
design effects{p_end}
{p2col :{manhelp svy_bootstrap SVY:svy bootstrap}}Bootstrap for survey data{p_end}
{p2col :{manhelpi bootstrap_options SVY}}More options for bootstrap variance
        estimation{p_end}
{p2col :{manhelp svy_brr SVY:svy brr}}Balanced repeated replication for survey data{p_end}
{p2col :{manhelpi brr_options SVY}}More options for BRR variance
        estimation{p_end}
{p2col :{manhelp svy_jackknife SVY:svy jackknife}}Jackknife estimation for survey data{p_end}
{p2col :{manhelpi jackknife_options SVY}}More options for jackknife variance
        estimation{p_end}
{p2col :{manhelp svy_sdr SVY:svy sdr}}Successive difference replication for survey data{p_end}
{p2col :{manhelpi sdr_options SVY}}More options for SDR variance
        estimation{p_end}


{pstd}
{bf:Survey data concepts}

{p2col :{manlink SVY variance estimation}}Variance estimation for survey data{p_end}
{p2col :{manlink SVY subpopulation estimation}}Subpopulation estimation for survey data{p_end}
{p2col :{manlink SVY direct standardization}}Direct standardization of means, proportions,
and ratios{p_end}
{p2col :{manlink SVY poststratification}}Poststratification for survey data{p_end}


{pstd}
{bf:Tools for programmers of new survey commands}{p_end}

{p2col :{manlink SVY ml for svy}}Maximum pseudolikelihood estimation for survey data{p_end}
{p2col :{manhelp svymarkout SVY}}Mark
	observation for exclusion on the basis of survey characteristics{p_end}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse multistage}{p_end}

{pstd}Declare the data to be complex survey data{p_end}
{phang2}{cmd:. svyset county [pw=sampwgt], strata(state) fpc(ncounties)}
             {cmd: || school, fpc(nschools)}{p_end}

{pstd}Estimate the average weight of high school seniors in our
population{p_end}
{phang2}{cmd:. svy: mean weight, over(sex)}{p_end}

{pstd}Test the hypothesis that the average male is 30 pounds heavier than the
average female{p_end}
{phang2}{cmd:. test [weight]male - [weight]female = 30}{p_end}
