{smcl}
{* *! version 1.2.9  28apr2011}{...}
{viewerdialog stcurve "dialog stcurve"}{...}
{vieweralsosee "[ST] stcurve" "mansection ST stcurve"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] stcox" "help stcox"}{...}
{vieweralsosee "[ST] stcox postestimation" "help stcox_postestimation"}{...}
{vieweralsosee "[ST] stcrreg" "help stcrreg"}{...}
{vieweralsosee "[ST] stcrreg postestimation" "help stcrreg_postestimation"}{...}
{vieweralsosee "[ST] streg" "help streg"}{...}
{vieweralsosee "[ST] streg postestimation" "help streg_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] sts" "help sts"}{...}
{vieweralsosee "[ST] stset" "help stset"}{...}
{viewerjumpto "Syntax" "stcurve##syntax"}{...}
{viewerjumpto "Description" "stcurve##description"}{...}
{viewerjumpto "Options" "stcurve##options"}{...}
{viewerjumpto "Examples" "stcurve##examples"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink ST stcurve} {hline 2}}Plot survivor, hazard, cumulative hazard, or cumulative incidence function{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:stcurve} [{cmd:,} {it:options}]

{synoptset 34 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{p2coldent :* {opt sur:vival}}plot survivor function{p_end}
{p2coldent :* {opt haz:ard}}plot hazard function{p_end}
{p2coldent :* {opt cumh:az}}plot cumulative hazard function{p_end}
{p2coldent :* {opt cif}}plot cumulative incidence function{p_end}
{synopt :{cmd:at(}{varname}{cmd:=}{it:#} [{varname}{cmd:=}{it:# ...}]{cmd:)}}value of the specified covariates and{p_end}
{p2col 7 43 43 2:[{cmd:at1(}{varname}{cmd:=}{it:#} [{varname}{cmd:=}{it:# ...}]{cmd:)}}mean of unspecified covariates{p_end}
{synopt :[{cmd:at2(}{varname}{cmd:=}{it:#} [{varname}{cmd:=}{it:# ...}]{cmd:)}}{p_end}
{synopt :[...]]]}

{syntab:Options}
{synopt :{opt alpha:1}}conditional frailty model{p_end}
{synopt :{opt uncond:itional}}unconditional frailty model{p_end}
{synopt :{opt r:ange(# #)}}range of analysis time{p_end}
{synopt :{cmdab:out:file:(}{it:{help filename}} [{cmd:,} {opt replace}]{cmd:)}}save values used to plot the curves{p_end}
{synopt :{opt width(#)}}override "optimal" width; use with {opt hazard}{p_end}
{synopt :{opth k:ernel(kdensity##kernel:kernel)}}kernel function; use with {opt hazard}{p_end}
{synopt :{opt nob:oundary}}no boundary correction; use with {opt hazard}{p_end}

{syntab:Plot}
{synopt :{it:{help connect_options:connect_options}}}affect rendition of plotted survivor, hazard, or cumulative hazard function{p_end}

{syntab:Add plots}
{synopt :{opth "addplot(addplot_option:plot)"}}add other plots to the generated graph{p_end}

{syntab:Y axis, X axis, Titles, Legend, Overall}
{synopt :{it:twoway_options}}any options other than {opt by()} documented in
         {manhelpi twoway_options G-3}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* One of {opt survival}, {opt hazard}, {opt cumhaz}, or 
{opt cif} must be specified.{p_end}
{p 4 6 2}{cmd:survival} and {cmd:hazard} are not allowed after estimation with {helpb stcrreg}.{p_end}
{p 4 6 2}{cmd:cif} is allowed only after estimation with {helpb stcrreg}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Survival analysis > Regression models >}
    {bf:Plot survivor, hazard, cumulative hazard, or cumulative incidence function}


{marker description}{...}
{title:Description}

{pstd}
{cmd:stcurve} plots the survivor, hazard, or cumulative hazard function after
{cmd:stcox} or {cmd:streg} and plots the cumulative subhazard or cumulative 
incidence function after {cmd:stcrreg}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt survival} requests that the survivor function be plotted.  
{opt survival} is not allowed after estimation with {cmd:stcrreg}.

{phang}
{opt hazard} requests that the hazard function be plotted.
{opt hazard} is not allowed after estimation with {cmd:stcrreg}.

{phang}
{opt cumhaz} requests that the cumulative hazard function be plotted 
when used after {cmd:stcox} or {cmd:streg} and requests that the 
cumulative subhazard function be plotted when used after {cmd:stcrreg}.

{phang}
{opt cif} requests that the cumulative incidence function be plotted.  
This option is available only after estimation with {cmd:stcrreg}.

{phang}
{cmd:at(}{varname}{cmd:=}{it:# ...}{cmd:)} requests that the
covariates specified by {it:varname} be set to {it:#}. By default,
{cmd:stcurve} evaluates the function by setting each covariate to its mean
value.  This option causes the function to be evaluated at the value of the
covariates listed in {opt at()} and at the mean of all unlisted covariates.

{pmore}
{cmd:at1(}{it:varname}{cmd:=}{it:# ...}{cmd:)},
{cmd:at2(}{it:varname}{cmd:=}{it:# ...}{cmd:)}, ...,
{cmd:at10(}{it:varname}{cmd:=}{it:# ...}{cmd:)} specify that multiple curves
(up to 10) be plotted on the same graph.  {opt at1()}, {opt at2()}, ...,
{opt at10()} work like the {opt at()} option.  They request that the function
be evaluated at the value of the covariates specified and at the mean of
all unlisted covariates.  {opt at1()} specifies the values of the covariates
for the first curve, {opt at2()} specifies the values of the covariates for
the second curve, and so on.

{dlgtab:Options}

{phang}
{opt alpha1}, when used after fitting a frailty model, plots curves
that are conditional on a frailty value of one.  This is the default for
shared-frailty models.

{phang}
{opt unconditional}, when used after fitting a frailty model, plots
curves that are unconditional on the frailty; that is, the curve is "averaged"
over the frailty distribution.  This is the default for unshared-frailty
models.

{phang}
{opt range(# #)} specifies the range of the time axis to be plotted.  If this
option is not specified, {cmd:stcurve} plots the desired curve on an
interval expanding from the earliest to the latest time in the data.

{phang}
{cmd:outfile(}{it:{help filename}} [{cmd:,} {opt replace}]{cmd:)} saves in
{it:filename}{cmd:.dta} the values used to plot the curve(s).

{phang}
{opt width(#)} is for use with {opt hazard} (and applies only after
{cmd:stcox}) and is used to specify the bandwidth to be used in the kernel
smooth used to plot the estimated hazard function.  If left unspecified, a
default bandwidth is used, as described in {manhelp kdensity R}.

{phang}
{opt kernel(kernel)} is for use with
{opt hazard} and is for use only after {cmd:stcox} because, for Cox
regression, an estimate of the hazard function is obtained by smoothing the
estimated {it:hazard contributions}.  {opt kernel()} specifies the kernel
function for use in calculating the weighted kernel-density estimate required
to produce a smoothed hazard-function estimator.  The default is
{cmd:kernel(Epanechnikov)}, yet {it:kernel} may be any of the kernels
supported by {cmd:kdensity}; {manhelp kdensity R}.

{phang}
{opt noboundary} is for use with {opt hazard} and applies only to the 
plotting of smoothed hazard functions after {cmd:stcox}.
It specifies that no boundary-bias adjustments are to be made when 
calculating the smoothed hazard-function estimator.  By default, the 
smoothed hazards are adjusted near the boundaries; see
{manlink ST sts graph}.
If the {opt epan2}, {opt biweight}, or {opt rectangular} kernel is used, 
the bias correction near the boundary is performed using boundary kernels.  
For other kernels, the plotted range of the smoothed hazard function is
restricted to be inside of one bandwidth from each endpoint.  For these
other kernels, specifying {opt noboundary} merely removes this range
restriction.

{dlgtab:Plot}

{phang}
{it:connect_options} affect the rendition of the plotted survivor, hazard, or
cumulative hazard function; see {manhelpi connect_options G-3}.

{dlgtab:Add plots}

{phang}
{opt addplot(plot)} provides a way to add other plots to the generated
graph; see {manhelpi addplot_option G-3}.

{dlgtab:Y axis, X axis, Titles, Legend, Overall}

{phang}
{it:twoway_options} are any of the options documented in
{manhelpi twoway_options G-3}, excluding {opt by()}.  These include options for
titling the graph (see {manhelpi title_options G-3}) and for saving the
graph to disk (see {manhelpi saving_option G-3}).


{marker examples}{...}
{title:Examples after stcox}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse drugtr}

{pstd}Fit Cox model{p_end}
{phang2}{cmd:. stcox age drug}

{pstd}Plot the estimated survivor function{p_end}
{phang2}{cmd:. stcurve, survival}

{pstd}Plot the estimated survivor function for the placebo group and for the
treatment group{p_end}
{phang2}{cmd:. stcurve, survival at1(drug=0) at2(drug=1)}

{pstd}Plot the estimated hazard function for the placebo group and for the
treatment group on a log scale{p_end}
{phang2}{cmd:. stcurve, hazard at1(drug=0) at2(drug=1) kernel(gauss)}
           {cmd:yscale(log)}{p_end}


{title:Examples after streg}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse cancer}

{pstd}Map values for {cmd:drug} into 0 for placebo and 1 for nonplacebo{p_end}
{phang2}{cmd:. replace drug = drug == 2 | drug == 3}

{pstd}Fit a loglogistic survival model{p_end}
{phang2}{cmd:. streg age drug, d(llog)}

{pstd}Plot the survivor function{p_end}
{phang2}{cmd:. stcurve, survival ylabels(0 .5 1)}

{pstd}Plot the hazard function{p_end}
{phang2}{cmd:. stcurve, hazard}

{pstd}Plot the survivor function for the placebo group and for the treatment
group{p_end}
{phang2}{cmd:. stcurve, survival at1(drug=0) at2(drug=1) ylabels(0 .5 1)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse catheter, clear}

{pstd}Declare data to be survival-time data{p_end}
{phang2}{cmd:. stset time infect}

{pstd}Fit a Weibull/inverse-Gaussian shared-frailty model{p_end}
{phang2}{cmd:. streg age female, d(weibull) frailty(invgauss) shared(patient)}
{p_end}

{pstd}Plot the individual hazard function for females at mean age{p_end}
{phang2}{cmd:. stcurve, hazard at(female=1) alpha1}

{pstd}Plot the population hazard function for females at mean age{p_end}
{phang2}{cmd:. stcurve, hazard at(female=1) unconditional}{p_end}
    {hline}


{title:Example after stcrreg}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse hypoxia}

{pstd}Declare data to be survival-time data{p_end}
{phang2}{cmd:. stset dftime, failure(failtype==1)}

{pstd}Fit competing-risks model{p_end}
{phang2}{cmd:. stcrreg ifp tumsize pelnode, compete(failtype==2)}

{pstd}Compare cumulative incidence functions for two groups with 
remaining covariates held at their mean values{p_end}
{phang2}{cmd:. stcurve, cif at1(pelnode=0) at2(pelnode=1)}{p_end}
