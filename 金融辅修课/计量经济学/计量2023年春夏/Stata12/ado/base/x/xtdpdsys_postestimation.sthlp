{smcl}
{* *! version 1.1.6  28apr2011}{...}
{viewerdialog predict "dialog xtdpd_p"}{...}
{viewerdialog estat "dialog xtdpd_estat"}{...}
{vieweralsosee "[XT] xtdpdsys postestimation" "mansection XT xtdpdsyspostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtdpdsys" "help xtdpdsys"}{...}
{viewerjumpto "Description" "xtdpdsys postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "xtdpdsys postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "xtdpdsys postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtdpdsys postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat abond" "xtdpdsys postestimation##syntax_estat_abond"}{...}
{viewerjumpto "Options for estat abond" "xtdpdsys postestimation##options_estat_abond"}{...}
{viewerjumpto "Remarks for estat abond" "xtdpdsys postestimation##remarks_estat_abond"}{...}
{viewerjumpto "Syntax for estat sargan" "xtdpdsys postestimation##syntax_estat_sargan"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "xtdpdsys postestimation##examples"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink XT xtdpdsys postestimation} {hline 2}}Postestimation tools for xtdpdsys{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after 
{cmd:xtdpdsys}:

{synoptset 16}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb xtdpdsys postestimation##estatabond:estat abond}}test for
autocorrelation{p_end}
{synopt :{helpb xtdpdsys postestimation##estatsargan:estat sargan}}Sargan test
of overidentifying restrictions{p_end}
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
{p2col :{helpb xtdpdsys postestimation##predict:predict}}predictions, residuals,
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
{phang2}{cmd:. xtdpdsys n w k}{p_end}
{phang2}{cmd:. estat abond}{p_end}

{pstd}Request a higher order than originally computed{p_end}
{phang2}{cmd:. estat abond, artests(3)}{p_end}

{pstd}Obtain the Sargan test{p_end}
{phang2}{cmd:. estat sargan}{p_end}

{pstd}Compute the linear prediction{p_end}
{phang2}{cmd:. predict nhat, xb}

{pstd}Test that the coefficients on the first-difference of {cmd:w} and the
lagged first difference of {cmd:w} are jointly zero{p_end}
{phang2}{cmd:. test w = 0, notest}{p_end}
{phang2}{cmd:. test k = 0, accumulate}{p_end}
