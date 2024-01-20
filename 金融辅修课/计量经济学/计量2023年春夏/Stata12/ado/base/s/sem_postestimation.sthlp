{smcl}
{* *! version 1.0.5  07jul2011}{...}
{vieweralsosee "[SEM] sem postestimation" "mansection SEM sempostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqgof" "help sem_estat_eqgof"}{...}
{vieweralsosee "[SEM] estat eqtest" "help sem_estat_eqtest"}{...}
{vieweralsosee "[SEM] estat framework" "help sem_estat_framework"}{...}
{vieweralsosee "[SEM] estat ggof" "help sem_estat_ggof"}{...}
{vieweralsosee "[SEM] estat ginvariant" "help sem_estat_ginvariant"}{...}
{vieweralsosee "[SEM] estat gof" "help sem_estat_gof"}{...}
{vieweralsosee "[SEM] estat mindices" "help sem_estat_mindices"}{...}
{vieweralsosee "[SEM] estat residuals" "help sem_estat_residuals"}{...}
{vieweralsosee "[SEM] estat scoretests" "help sem_estat_scoretests"}{...}
{vieweralsosee "[SEM] estat stable" "help sem_estat_stable"}{...}
{vieweralsosee "[SEM] estat stdize:" "help sem_estat_stdize"}{...}
{vieweralsosee "[SEM] estat teffects" "help sem_estat_teffects"}{...}
{vieweralsosee "[SEM] lincom" "help sem_lincom"}{...}
{vieweralsosee "[SEM] lrtest" "help sem_lrtest"}{...}
{vieweralsosee "[SEM] nlcom" "help sem_nlcom"}{...}
{vieweralsosee "[SEM] predict" "help sem_predict"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem reporting options" "help sem_reporting_options"}{...}
{vieweralsosee "[SEM] test" "help sem_test"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estat" "help estat"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{viewerjumpto "Description" "sem_postestimation##description"}{...}
{viewerjumpto "Remarks" "sem_postestimation##remarks"}{...}
{title:Title}

{p2colset 5 33 35 2}{...}
{p2col:{manlink SEM sem postestimation} {hline 2}}Postestimation tools for
	sem{p_end}
{p2colreset}{...}


{title:Description}

{pstd}
The following are the postestimation commands that you can use after
estimation by {cmd:sem}:

{synoptset 18}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb sem_command:sem}}without arguments, redisplays results{p_end}
{synopt :{helpb sem_command:sem, coeflegend}}display {cmd:_b[]} notation{p_end}
{synopt :{helpb sem_estat_framework:estat framework}}display results in
modeling framework (matrix form){p_end}

{synopt :{helpb sem_estat_gof:estat gof}}overall goodness of fit{p_end}
{synopt :{helpb sem_estat_ggof:estat ggof}}group-level goodness of fit{p_end}
{synopt :{helpb sem_estat_eqgof:estat eqgof}}equation-level goodness of fit{p_end}
{synopt :{helpb sem_estat_residuals:estat residuals}}matrices of residuals{p_end}
{synopt :{helpb estat:estat ic}}AIC and BIC statistics{p_end}

{synopt :{helpb sem_estat_mindices:estat mindices}}modification indices (score tests){p_end}
{synopt :{helpb sem_estat_scoretests:estat scoretests}}score tests{p_end}
{synopt :{helpb sem_estat_ginvariant:estat ginvariant}}test of invariance of
parameters across groups{p_end}

{synopt :{helpb sem_estat_eqtest:estat eqtest}}equation-level Wald tests{p_end}
{synopt :{helpb sem_lrtest:lrtest}}likelihood-ratio tests {p_end}
{synopt :{helpb sem_test:test}}Wald tests {p_end}
{synopt :{helpb sem_lincom:lincom}}linear combination of parameters {p_end}
{synopt :{helpb sem_nlcom:nlcom}}nonlinear combination of parameters {p_end}
{synopt :{helpb sem_testnl:testnl}}Wald tests of nonlinear hypotheses {p_end}
{synopt :{helpb sem_estat_stdize:estat stdize:}}test standardized parameters{p_end}

{synopt :{helpb sem_estat_teffects:estat teffects}}decomposition of effects{p_end}
{synopt :{helpb sem_estat_stable:estat stable}}assess stability of nonrecursive systems{p_end}
{synopt :{helpb estat:estat summarize}}display estimation-sample summary
statistics {p_end}
{synopt :{helpb estat:estat vce}}display variance-covariance matrix of
estimates {p_end}

{synopt :{helpb sem_predict:predict}}factor scores, predicted values, etc. {p_end}

{synopt :{helpb estimates:estimates}}cataloging estimation results{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
For a summary of postestimation features, see {manlink SEM intro 6}.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:estat ic}, {cmd:estat summarize}, and {cmd:estat vce} are the standard
{cmd:estat} commands available after all estimation commands; see 
{helpb estat:[R] estat}.  Also see {manlink SEM estat summarize} and
{helpb sem estat gof:[SEM] estat gof}.

{pstd}
{cmd:estimates} is another feature available after all estimation commands
that allows the storage and manipulation of estimation results both in memory
and on disk; see {helpb estimates:[R] estimates}.    
