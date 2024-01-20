{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog predict "dialog xtdpd_p"}{...}
{viewerdialog estat "dialog xtdpd_estat"}{...}
{vieweralsosee "[XT] xtdpd postestimation" "mansection XT xtdpdpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtdpd" "help xtdpd"}{...}
{viewerjumpto "Description" "xtdpd postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "xtdpd postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "xtdpd postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtdpd postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat abond" "xtdpd postestimation##syntax_estat_abond"}{...}
{viewerjumpto "Options for estat abond" "xtdpd postestimation##options_estat_abond"}{...}
{viewerjumpto "Remarks for estat abond" "xtdpd postestimation##remarks_estat_abond"}{...}
{viewerjumpto "Syntax for estat sargan" "xtdpd postestimation##syntax_estat_sargan"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "xtdpd postestimation##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{manlink XT xtdpd postestimation} {hline 2}}Postestimation tools for xtdpd{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after 
{cmd:xtdpd}:

{synoptset 16}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb xtdpd postestimation##estatabond:estat abond}}test for
autocorrelation{p_end}
{synopt :{helpb xtdpd postestimation##estatsargan:estat sargan}}Sargan test of
overidentifying restrictions{p_end}
{synoptline}
{p2colreset}{...}


{pstd}
The following standard postestimation commands are also available:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{p2col :{helpb estat}}VCE and estimation sample summary{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{p2col :{helpb xtdpd postestimation##predict:predict}}predictions, residuals,
 influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


INCLUDE help xtdpd_postspecial


INCLUDE help xtdpd_predict


INCLUDE help xtdpd_postspecial2a


INCLUDE help xtdpd_postspecial2c


INCLUDE help xtdpd_postspecial2d


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse abdata}{p_end}

{pstd}Fit a model and obtain default AR tests{p_end}
{phang2}{cmd:. xtdpd l(0/1).(n w), dgmmiv(n) lgmmiv(n) div(w) vce(robust)}{p_end}
{phang2}{cmd:. estat abond}{p_end}

{pstd}Request a higher order than originally computed{p_end}
{phang2}{cmd:. estat abond, artests(3)}{p_end}

{pstd}Compute the linear prediction for the levels{p_end}
{phang2}{cmd:. predict xb, xb}

{pstd}Compute the residuals for the first differences{p_end}
{phang2}{cmd:. predict de, e difference}

{pstd}Test a linear hypothesis{p_end}
{phang2}{cmd:. test w = 0}{p_end}
