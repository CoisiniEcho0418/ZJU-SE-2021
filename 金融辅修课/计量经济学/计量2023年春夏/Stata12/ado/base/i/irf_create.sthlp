{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog "irf create" "dialog irf_create"}{...}
{vieweralsosee "[TS] irf create" "mansection TS irfcreate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] irf" "help irf"}{...}
{vieweralsosee "[TS] var intro" "help var_intro"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Syntax" "irf_create##syntax"}{...}
{viewerjumpto "Description" "irf_create##description"}{...}
{viewerjumpto "Options" "irf_create##options"}{...}
{viewerjumpto "Examples" "irf_create##examples"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col:{manlink TS irf create} {hline 2}}Obtain IRFs, dynamic-multiplier
functions, and FEVDs{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
After {cmd:var}

{p 8 22 2}
{cmd:irf}
{opt cr:eate}
{it:irfname}
[{cmd:,}
{it:{help irf_create##var_options:var_options}}]


{pstd}
After {cmd:svar}

{p 8 22 2}
{cmd:irf}
{opt cr:eate}
{it:irfname}
[{cmd:,}
{it:{help irf_create##svar_options:svar_options}}]


{pstd}
After {cmd:vec}

{p 8 22 2}
{cmd:irf}
{opt cr:eate}
{it:irfname}
[{cmd:,}
{it:{help irf_create##vec_options:vec_options}}]


{phang}
{it:irfname} is any valid name that does not exceed 15 characters.

{synoptset 32 tabbed}{...}
{marker var_options}{...}
{synopthdr:var_options}
{synoptline}
{syntab:Main}
{synopt:{cmd:set(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}make {it:filename}
active{p_end}
{synopt:{opt replace}}replace {it:irfname} if it already exists{p_end}
{synopt:{opt st:ep(#)}}set forecast horizon to {it:#}; default is {cmd:step(8)}{p_end}
{synopt:{opth o:rder(varlist)}}specify Cholesky ordering of endogenous
variables{p_end}
{synopt:{opt est:imates(estname)}}use previously saved results {it:estname};
default is to use active results{p_end}

{syntab:Std. errors}
{synopt:{opt nose}}do not calculate standard errors{p_end}
{synopt:{opt bs}}obtain standard errors from bootstrapped residuals{p_end}
{synopt:{opt bsp}}obtain standard errors from parametric bootstrap{p_end}
{synopt:{opt nod:ots}}do not display "{cmd:.}" for each bootstrap replication{p_end}
{synopt:{opt r:eps(#)}}use {it:#} bootstrap replications; default is {cmd:reps(200)}{p_end}
{synopt:{cmdab:bsa:ving(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}save bootstrap results in {it:filename}{p_end}
{synoptline}

{marker svar_options}{...}
{synopthdr:svar_options}
{synoptline}
{syntab:Main}
{synopt:{cmd:set(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}make {it:filename} active{p_end}
{synopt:{opt replace}}replace {it:irfname} if it already exists{p_end}
{synopt:{opt st:ep(#)}}set forecast horizon to {it:#}; default is {cmd:step(8)}{p_end}
{synopt:{opt est:imates(estname)}}use previously saved results {it:estname};
default is to use active results{p_end}

{syntab:Std. errors}
{synopt:{opt nose}}do not calculate standard errors{p_end}
{synopt:{opt bs}}obtain standard errors from bootstrapped residuals{p_end}
{synopt:{opt bsp}}obtain standard errors from parametric bootstrap{p_end}
{synopt:{opt nod:ots}}do not display "{cmd:.}" for each bootstrap replication{p_end}
{synopt:{opt r:eps(#)}}use {it:#} bootstrap replications; default is {cmd:reps(200)}{p_end}
{synopt:{cmdab:bsa:ving(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}save bootstrap results in {it:filename}{p_end}
{synoptline}

{marker vec_options}{...}
{synopthdr:vec_options}
{synoptline}
{syntab:Main}
{synopt:{cmd:set(}{it:{help filename}}[{cmd:, replace}]{cmd:)}}make {it:filename}
active{p_end}
{synopt:{opt replace}}replace {it:irfname} if it already exists{p_end}
{synopt:{opt st:ep(#)}}set forecast horizon to {it:#}; default is {cmd:step(8)}{p_end}
{synopt:{opt est:imates(estname)}}use previously saved results {it:estname}; default is to use active results{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}
The default is to use asymptotic standard errors if no options are
   specified.{p_end}
{p 4 6 2}
{opt irf create} is for use after fitting a model with the {cmd:var},
   {cmd:svar}, or {cmd:vec} commands; see {helpb var:[TS] var}, 
   {helpb svar:[TS] var svar}, and {helpb vec:[TS] vec}.{p_end}
{p 4 6 2}
You must {cmd:tsset} your data before using {cmd:var}, {cmd:svar}, or
   {cmd:vec} and, hence, before using {opt irf create}; see
   {helpb tsset:[TS] tsset}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multivariate time series > IRF and FEVD analysis >}
    {bf:Obtain IRFs, dynamic-multiplier functions, and FEVDs}


{marker description}{...}
{title:Description}

{pstd}
{opt irf create} estimates multiple sets of impulse-response functions (IRFs),
dynamic-multiplier functions, and forecast-error variance decompositions
(FEVDs) after estimation by {helpb var}, {helpb svar}, or {helpb vec}.
These estimates and their standard errors are known collectively as IRF
results and are stored in an IRF file under the specified {it:irfname}.

{pstd}
The following types of IRFs and dynamic-multiplier functions are stored:

{p2colset 8 42 44 2}{...}
{p2col:simple IRFs}after {cmd:svar}, {cmd:var}, or {cmd:vec}{p_end}
{p2col:orthogonalized IRFs}after {cmd:svar}, {cmd:var}, or {cmd:vec}{p_end}
{p2col:dynamic multipliers}after {cmd:var}{p_end}
{p2col:cumulative IRFs}after {cmd:svar}, {cmd:var}, or {cmd:vec}{p_end}
{p2col:cumulative orthogonalized IRFs}after {cmd:svar}, {cmd:var}, or {cmd:vec}{p_end}
{p2col:cumulative dynamic multipliers}after {cmd:var}{p_end}
{p2col:structural IRFs}after {cmd:svar} only{p_end}
{p2colreset}{...}

{pstd}
The following types of FEVDs are stored:

{p2colset 8 42 44 2}{...}
{p2col:Cholesky FEVDs}after {cmd:svar}, {cmd:var}, or {cmd:vec}{p_end}
{p2col:structural FEVDs}after {cmd:svar} only{p_end}
{p2colreset}{...}

{pstd}
Once you have created a set of IRF results, use the other {helpb irf} commands
to analyze them.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{cmd:set(}{it:{help filename}}[{cmd:, replace}]{cmd:)}
    specifies the IRF file to be used.  If {opt set()} is not 
    specified, the active IRF file is used; see {manhelp irf_set TS:irf set}.

{pmore}
    If {opt set()} is specified, the specified file becomes the 
    active file, just as if you had issued an {cmd:irf set} command.

{phang}
{opt replace} specifies that the results stored under {it:irfname} may be 
    replaced, if they already exist.  IRF results are saved in files, and
    one file may contain multiple IRF results.

{phang}
{opt step(#)} specifies the step (forecast) horizon; the default is eight
    periods.
    
{phang}
{opth order(varlist)} is allowed only after estimation by 
    {cmd:var}; it specifies the Cholesky ordering of the endogenous variables
    to be used when estimating the orthogonalized IRFs. 
    By default, the order in which the variables were originally
    specified on the {cmd:var} command is used. 

{phang}
{opt estimates(estname)} specifies that estimation results 
    previously estimated by {cmd:svar}, {cmd:var}, or {cmd:vec}, and
    stored by {cmd:estimates}, be used; see {helpb estimates:[R] estimates}.
    This option is rarely specified.

{dlgtab:Std. errors}

{phang}
{opt nose}, {opt bs}, and {opt bsp} are alternatives that specify how
    (whether) standard errors are to be calculated.  If none of these
    options is specified, asymptotic standard errors are calculated, except
    in two cases:  after estimation by {cmd:vec} and after
    estimation by {cmd:svar} in which long-run constraints were applied.
    In those two cases, the default is as if {opt nose} were specified,
    although in the second case, you could specify {opt bs} or {opt bsp}.
    After estimation by {cmd:vec}, standard errors are simply not
    available.

{phang2}
    {opt nose} specifies that no standard errors be calculated.

{phang2}
    {opt bs} specifies that standard errors be calculated by bootstrapping
    the residuals.  {opt bs} may not be specified if there are gaps in the
    data.

{phang2}
    {opt bsp} specifies that standard errors be calculated via a
    multivariate-normal parametric bootstrap.  {opt bsp} may not be
    specified if there are gaps in the data.

{phang}
{opt nodots}, {opt reps(#)}, and
{cmd:bsaving(}{it:{help filename}}[, {cmd:replace}]{cmd:)}
   are relevant only if {opt bs} or {opt bsp} is specified.

{phang2}
    {opt nodots} specifies that dots not be displayed each time 
    {opt irf create} performs a bootstrap replication.

{phang2}
    {opt reps(#)}, {it:#} > 50, specifies the number of bootstrap
    replications to be performed.  {cmd:reps(200)} is the default.

{phang2}
    {cmd:bsaving(}{it:filename}[{cmd:, replace}]{cmd:)} specifies that
    file {it:filename} be created and that the bootstrap replications be saved 
    in it.  New file {it:filename} is just a {opt .dta} dataset that can 
    be loaded later using {helpb use}.  If {it:filename} is specified
    without an extension, {opt .dta} is assumed.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}{p_end}

{pstd}Fit a vector autoregressive model{p_end}
{phang2}{cmd:. var dln_inv dln_inc dln_consump if qtr<=tq(1978q4), lags(1/2)}
        {cmd: dfk}

{pstd}Estimate IRFs and FEVDs and save under {cmd:order1} in {cmd:myirf1.irf}
{p_end}
{phang2}{cmd:. irf create order1, set(myirf1)}

{pstd}Same as above, but set forecast horizon to 10 and save under
{cmd:order1b}{p_end}
{phang2}{cmd:. irf create order1b, step(10) set(myirf1)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse urates}{p_end}

{pstd}Fit a vector error-correction model{p_end}
{phang2}{cmd:. vec missouri indiana kentucky illinois, trend(rconstant)}
             {cmd:rank(2) lags(4)}

{pstd}Estimate IRFs and FEVDs using 50 as forecast horizon and save under 
{cmd:vec1} in {cmd:vecirfs.irf}{p_end}
{phang2}{cmd:. irf create vec1, step(50) set(vecirfs)}{p_end}
    {hline}
