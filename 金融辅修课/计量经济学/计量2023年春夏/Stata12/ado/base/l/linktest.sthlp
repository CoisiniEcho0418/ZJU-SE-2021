{smcl}
{* *! version 1.1.7  07jul2011}{...}
{viewerdialog linktest "dialog linktest"}{...}
{vieweralsosee "[R] linktest" "mansection R linktest"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress postestimation" "help regress_postestimation"}{...}
{viewerjumpto "Syntax" "linktest##syntax"}{...}
{viewerjumpto "Description" "linktest##description"}{...}
{viewerjumpto "Option" "linktest##option"}{...}
{viewerjumpto "Examples" "linktest##examples"}{...}
{viewerjumpto "Saved results" "linktest##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink R linktest} {hline 2}}Specification link test for single-equation models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:linktest} {ifin} [{cmd:,} {it:cmd_options}]

{phang}
When {cmd:if} and {cmd:in} are not specified, the link
test is performed on the same sample as the previous estimation.


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Tests >}
     {bf:Specification link test for single-equation models}


{marker description}{...}
{title:Description}

{pstd}
{cmd:linktest} performs a link test for model specification after any
single-equation estimation command, such as 
{cmd:logistic}, {cmd:regress}, {cmd:stcox}, etc.


{marker option}{...}
{title:Option}

{dlgtab:Main}

{phang}
{it:cmd_options} must be the same options specified with the underlying
estimation command, except the {it:display_options} may differ.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Fit linear regression{p_end}
{phang2}{cmd:. regress mpg weight displacement foreign}{p_end}

{pstd}Perform link test{p_end}
{phang2}{cmd:. linktest}{p_end}

{pstd}Generate new variable, {cmd:wgt}{p_end}
{phang2}{cmd:. generate wgt = weight/100}{p_end}

{pstd}Fit tobit model with right-censoring limit at 2,400 pounds{p_end}
{phang2}{cmd:. tobit mpg wgt, ul(24)}{p_end}

{pstd}Perform link test, specifying right-censoring limit{p_end}
{phang2}{cmd:. linktest, ul(24)}{p_end}

{pstd}Fit quantile regression model{p_end}
{phang2}{cmd:. qreg mpg weight displ foreign}{p_end}

{pstd}Perform link test{p_end}
{phang2}{cmd:. linktest}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:linktest} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(t)}}t statistic on {cmd:_hatsq}{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
