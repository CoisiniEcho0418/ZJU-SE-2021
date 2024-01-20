{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog predict "dialog xtfront_p"}{...}
{vieweralsosee "[XT] xtfrontier postestimation" "mansection XT xtfrontierpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtfrontier" "help xtfrontier"}{...}
{viewerjumpto "Description" "xtfrontier postestimation##description"}{...}
{viewerjumpto "Syntax for predict" "xtfrontier postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "xtfrontier postestimation##options_predict"}{...}
{viewerjumpto "Examples" "xtfrontier postestimation##examples"}{...}
{title:Title}

{p2colset 5 39 41 2}{...}
{p2col :{manlink XT xtfrontier postestimation} {hline 2}}Postestimation tools for xtfrontier{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are available after {cmd:xtfrontier}.

{synoptset 13}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_contrast
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_margins
INCLUDE help post_marginsplot
INCLUDE help post_nlcom
{synopt :{helpb xtfrontier postestimation##predict:predict}}predictions, residuals, influence statistics, and other diagnostic measures{p_end}
INCLUDE help post_predictnl
INCLUDE help post_pwcompare
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic}]

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt xb}}linear prediction; the default{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synopt :{opt u}}minus the natural log of the technical efficiency via E(u_it | e_it){p_end}
{synopt :{opt m}}minus the natural log of the technical efficiency via M(u_it | e_it){p_end}
{synopt :{opt te}}the technical efficiency via E{exp(-su_it | e_it}{p_end}
{synoptline}
{p2colreset}{...}

    where
           s =    1 for production functions
                 -1 for cost functions


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt xb}, the default, calculates the linear prediction.

{phang}
{opt stdp} calculates the standard error of the linear prediction.

{phang}
{opt u} produces estimates of the technical inefficiency via
{it:E}(u[i,t]|e[i,t]).

{phang}
{opt m} produces estimates of the technical inefficiency via the mode,
M(u[i,t]|e[i,t]).

{phang}
{opt te} produces estimates of the technical efficiency, or the cost
efficiency if the {opt cost} option was specified in the model.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse xtfrontier1}{p_end}
{phang2}{cmd:. constraint 1 [eta]_cons = 0}{p_end}
{phang2}{cmd:. xtfrontier lnwidgets lnmachines lnworkers, tvd constraints(1)}

{pstd}Linear prediction{p_end}
{phang2}{cmd:. predict xb}

{pstd}Technical efficiency{p_end}
{phang2}{cmd:. predict efficiency, te}

{pstd}Test for constant returns to scale{p_end}
{phang2}{cmd:. test lnmachines + lnworkers = 1}{p_end}
