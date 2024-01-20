{smcl}
{* *! version 1.0.1  07jul2011}{...}
{vieweralsosee "[SEM] sem option method()" "mansection SEM semoptionmethod()"}{...}
{findalias assemmlmv}{...}
{vieweralsosee "[SEM] intro 3" "mansection SEM intro3"}{...}
{vieweralsosee "[SEM] intro 7" "mansection SEM intro7"}{...}
{vieweralsosee "[SEM] intro 8" "mansection SEM intro8"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_option_method##syntax"}{...}
{viewerjumpto "Description" "sem_option_method##description"}{...}
{viewerjumpto "Options" "sem_option_method##options"}{...}
{viewerjumpto "Remarks" "sem_option_method##remarks"}{...}
{viewerjumpto "Examples" "sem_option_method##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink SEM sem option method()} {hline 2}}Specifying method and
calculation of VCE{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:... }[{cmd:, ...} {opt method(method)} {opt vce(vcetype)}
{cmd:...}] 

{marker method}{...}
{synoptset 30}{...}
{synopthdr:method}
{p2line}
{p2col :{opt ml}}maximum likelihood; the default{p_end}
{p2col :{opt mlmv}}{opt ml} with missing values{p_end}
{p2col :{opt adf}}asymptotic distribution free{p_end}
{p2line}

{marker vcetype}{...}
{synoptset 30}{...}
{synopthdr:vcetype}
{p2line}
{p2col :{opt oim}}observed information matrix; the default{p_end}
{p2col :{opt eim}}expected information matrix{p_end}
{p2col :{opt opg}}outer product of gradients{p_end}
{p2col :{opt r:obust}}Huber/White/sandwich estimator{p_end}
{synopt :{cmdab:cl:uster} {it:clustvar}}clustered sandwich estimator{p_end}
{synopt :{cmdab:boot:strap} [{cmd:,} {it:{help bootstrap:bootstrap_options}}]}bootstrap estimation{p_end}
{synopt :{cmdab:jack:knife} [{cmd:,} {it:{help jackknife:jackknife_options}}]}jackknife estimation{p_end}
{p2line}

{phang}
The following combinations of {opt method()} and {opt vce()} are allowed:

           {c |} {cmd:oim}    {cmd:eim}    {cmd:opg}    {cmd:robust}   {cmd:cluster}   {cmd:bootstrap}   {cmd:jackknife}
      {hline 5}{c +}{hline 62}
      {cmd:ml}   {c |}   x      x      x       x        x          x          x
      {cmd:mlmv} {c |}   x      x      x       x        x          x          x
      {cmd:adf}  {c |}   x      x                                  x          x
      {hline 5}{c BT}{hline 62}


{marker description}{...}
{title:Description}

{pstd}
{cmd:sem} option {opt method()} specifies the method used to obtain the
estimated parameters.

{pstd}
{cmd:sem} option {opt vce()} specifies the technique used to obtain the
variance-covariance matrix of the estimates (VCE), which includes the reported
standard errors.


{marker options}{...}
{title:Options}

{phang}
{opth method:(sem_option_method##method:method)} specifies the method used to
obtain parameter estimates.  {cmd:method(ml)} is the default.

{phang}
{opth vce:(sem_option_method##vcetype:vcetype)} specifies the technique used to
obtain the VCE.  {cmd:vce(oim)} is the default.

  
{marker remarks}{...}
{title:Remarks}

{pstd}
See

{phang2}
1.  
{it:{mansection SEM intro3RemarksAssumptionsandchoiceofestimationmethod:Assumptions and choice of estimation method}}
in {manlink SEM intro 3}.

{phang2}
2.  {manlink SEM intro 7}.

{phang2}
3.  {manlink SEM intro 8}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse cfa_missing}{p_end}

{pstd}Fit a CFA model using maximum likelihood{p_end}
{phang2}{cmd:. sem (test1 test2 test3 test4 <- X), method(ml)}{p_end}

{pstd}Compute robust standard errors{p_end}
{phang2}{cmd:. sem (test1 test2 test3 test4 <- X), method(ml) vce(robust)}{p_end}

{pstd}Fit model using FIML: treat missing values as missing at random{p_end}
{phang2}{cmd:. sem (test1 test2 test3 test4 <- X), method(mlmv)}{p_end}

{pstd}Fit model using the asymptotic distribution free method{p_end}
{phang2}{cmd:. sem (test1 test2 test3 test4 <- X), method(adf)}{p_end}
