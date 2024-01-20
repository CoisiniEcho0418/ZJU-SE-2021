{smcl}
{* *! version 1.1.8  07jul2011}{...}
{viewerdialog estat "dialog regress_estat"}{...}
{vieweralsosee "[R] regress postestimation time series" "mansection R regresspostestimationtimeseries"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[R] regress postestimation" "help regress postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{viewerjumpto "Description" "regress postestimationts##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "regress postestimationts##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat archlm" "regress postestimationts##syntax_estat_archlm"}{...}
{viewerjumpto "Options for estat archlm" "regress postestimationts##options_estat_archlm"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat bgodfrey" "regress postestimationts##syntax_estat_bgodfrey"}{...}
{viewerjumpto "Options for estat bgodfrey" "regress postestimationts##options_estat_bgodfrey"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat durbinalt" "regress postestimationts##syntax_estat_durbinalt"}{...}
{viewerjumpto "Options for estat durbinalt" "regress postestimationts##options_estat_durbinalt"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat dwatson" "regress postestimationts##syntax_estat_dwatson"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "regress postestimationts##examples"}{...}
{viewerjumpto "Saved results" "regress postestimationts##saved_results"}{...}
{viewerjumpto "References" "regress postestimationts##references"}{...}
{title:Title}

{p2colset 5 47 49 2}{...}
{p2col :{manlink R regress postestimation time series} {hline 2}}Postestimation
tools for regress with time series{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands for time series are available for 
{cmd:regress}:

{synoptset 19}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt: {helpb regress postestimationts##archlm:estat archlm}}test for 
ARCH effects in the residuals{p_end}
{synopt: {helpb regress postestimationts##bgodfrey:estat bgodfrey}}Breusch-Godfrey test for higher-order serial correlation{p_end}
{synopt: {helpb regress postestimationts##durbinalt:estat durbinalt}}Durbin's 
alternative test for serial correlation{p_end}
{synopt: {helpb regress postestimationts##dwatson:estat dwatson}}Durbin-Watson 
d statistic to test for first-order serial correlation{p_end}
{synoptline}
{p2colreset}{...}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
These commands provide regression diagnostic tools specific to time series.
You must {cmd:tsset} your data before using these commands; see
{manhelp tsset TS}.

{pstd}
{cmd:estat archlm} tests for time-dependent volatility.  {cmd:estat dwatson},
{cmd:estat durbinalt}, and {cmd:estat bgodfrey} test for serial correlation in
the residuals of a linear regression.  For non-time-series regression
diagnostic tools, see
{manhelp regress_postestimation R:regress postestimation}.

{pstd}
{cmd:estat archlm} performs Engle's Lagrange multiplier test for the presence
of autoregressive conditional heteroskedasticity.

{pstd}
{cmd:estat bgodfrey} performs the Breusch-Godfrey test for higher-order serial
correlation in the disturbance.  This test does not require that all the
regressors be strictly exogenous.

{pstd}
{cmd:estat durbinalt} performs Durbin's alternative test for serial
correlation in the disturbance.  This test does not require that all the
regressors be strictly exogenous.

{pstd}
{cmd:estat dwatson} computes the Durbin-Watson d statistic
({help regress postestimationts##DW1950:Durbin and Watson 1950}) to test for
first-order serial correlation in the disturbance when all the regressors are
strictly exogenous.


{marker archlm}{...}
{marker syntax_estat_archlm}{...}
{title:Syntax for estat archlm}

{p 8 17 2}
{cmd:estat archlm} 
[{cmd:,} {it:archlm_options}]

{synoptset 16}
{synopthdr:archlm_options}
{synoptline}
{synopt :{opth l:ags(numlist)}}test {it:numlist} lag order{p_end}
{synopt :{opt force}}allow test after {cmd:regress,} {cmd:vce(robust)}{p_end}
{synoptline}
{p2colreset}{...}


{marker options_estat_archlm}{...}
{title:Options for estat archlm}

{phang}
{opth lags(numlist)} specifies a list of numbers, indicating the lag orders to
be tested.  The test will be performed separately for each order.  The default
is order one.

{phang}
{opt force} allows the test to be run after {cmd:regress,} {cmd:vce(robust)}.
The command will not work if the {cmd:vce(cluster} {it:clustvar}{cmd:)} option
is specified with {helpb regress}.


{marker bgodfrey}{...}
{marker syntax_estat_bgodfrey}{...}
{title:Syntax for estat bgodfrey}

{p 8 17 2}
{cmd:estat} {opt bgo:dfrey} 
[{cmd:,} {it:bgodfrey_options}]

{synoptset 19}
{synopthdr:bgodfrey_options}
{synoptline}
{synopt :{opth l:ags(numlist)}}test {it:numlist} lag orders{p_end}
{synopt :{opt nom:iss0}}do not use Davidson and MacKinnon's approach{p_end}
{synopt :{opt s:mall}}obtain p-values using the F or t distribution{p_end}
{synoptline}
{p2colreset}{...}


{marker options_estat_bgodfrey}{...}
{title:Options for estat bgodfrey}

{phang}
{opth lags(numlist)} specifies a list of numbers, indicating the lag orders to
be tested.  The test will be performed separately for each order.  The default
is order one.

{phang}
{opt nomiss0} specifies that Davidson and MacKinnon's approach
({help regress postestimationts##DM1993:1993}, 358), which replaces
the missing values in the initial observations on the lagged residuals in the
auxiliary regression with zeros, not be used.

{phang}
{opt small} specifies that the p-values of the test statistics be obtained
using the F or t distribution instead of the default chi-squared or normal
distribution. 


{marker durbinalt}{...}
{marker syntax_estat_durbinalt}{...}
{title:Syntax for estat durbinalt}

{p 8 17 2}
{cmd:estat} {opt dur:binalt} 
[{cmd:,} {it:durbinalt_options}]

{synoptset 21}
{synopthdr:durbinalt_options}
{synoptline}
{synopt :{opth l:ags(numlist)}}test {it:numlist} lag orders{p_end}
{synopt :{opt nom:iss0}}do not use Davidson and MacKinnon's approach{p_end}
{synopt :{opt r:obust}}compute standard errors using the robust/sandwich
estimator{p_end}
{synopt :{opt s:mall}}obtain p-values using the F or t distribution{p_end}
{synopt :{opt force}}allow test after {cmd:regress,} {cmd:vce(robust)} or
{cmd:newey}{p_end}
{synoptline}
{p2colreset}{...}


{marker options_estat_durbinalt}{...}
{title:Options for estat durbinalt}

{phang}
{opth lags(numlist)} specifies a list of numbers, indicating the lag orders to
be tested.  The test will be performed separately for each order.  The default
is order one.

{phang}
{opt nomiss0} specifies that Davidson and MacKinnon's approach
({help regress postestimationts##DM1993:1993}, 358), which replaces
the missing values in the initial observations on the lagged residuals in the
auxiliary regression with zeros, not be used.

{phang}
{opt robust} specifies that the Huber/White/sandwich robust estimator for the
variance-covariance matrix be used in Durbin's alternative test.

{phang}
{opt small} specifies that the p-values of the test statistics be obtained
using the F or t distribution instead of the default chi-squared or normal
distribution.  This option may not be specified with {cmd:robust}, which
always uses an F or t distribution.

{phang}
{opt force} allows the test to be run after {cmd:regress,} {cmd:vce(robust)}
and after {helpb newey}.  The command will not work if the
{cmd:vce(cluster} {it:clustvar}{cmd:)} option is specified with
{helpb regress}.


{marker dwatson}{...}
{marker syntax_estat_dwatson}{...}
{title:Syntax for estat dwatson}

{p 8 17 2}
{cmd:estat} {opt dwa:tson}


{marker examples}{...}
{title:Examples}

    {hline}
{phang}{cmd:. webuse klein}{p_end}
{phang}{cmd:. tsset yr}{p_end}
{phang}{cmd:. regress consump wagegovt}{p_end}
{phang}{cmd:. estat dwatson}{p_end}
{phang}{cmd:. estat durbinalt, small}{p_end}
    {hline}
{phang}{cmd:. webuse klein}{p_end}
{phang}{cmd:. tsset yr}{p_end}
{phang}{cmd:. regress consump wagegovt L.consump L2.consump}{p_end}
{phang}{cmd:. estat durbinalt, small lags(1/2)}{p_end}
{phang}{cmd:. estat bgodfrey, small lags(1/2)}{p_end}
    {hline}
{phang}{cmd:. webuse klein}{p_end}
{phang}{cmd:. tsset yr}{p_end}
{phang}{cmd:. regress consump wagegovt}{p_end}
{phang}{cmd:. estat archlm, lags(1 2 3)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat archlm} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(k)}}number of regressors{p_end}
{synopt:{cmd:r(N_gaps)}}number of gaps{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(lags)}}lag order{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(arch)}}test statistic for each lag order{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{synopt:{cmd:r(p)}}two-sided p-values{p_end}

{pstd}
{cmd:estat bgodfrey} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(k)}}number of regressors{p_end}
{synopt:{cmd:r(N_gaps)}}number of gaps{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(lags)}}lag order{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared statistic for each lag order{p_end}
{synopt:{cmd:r(F)}}F statistic for each lag order ({cmd:small} only){p_end}
{synopt:{cmd:r(df_r)}}residual degrees of freedom ({cmd:small} only){p_end}
{synopt:{cmd:r(p)}}two-sided p-values{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{p2colreset}{...}

{pstd}
{cmd:estat durbinalt} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(k)}}number of regressors{p_end}
{synopt:{cmd:r(N_gaps)}}number of gaps{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(lags)}}lag order{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared statistic for each lag order{p_end}
{synopt:{cmd:r(F)}}F statistic for each lag order ({cmd:small} only){p_end}
{synopt:{cmd:r(df_r)}}residual degrees of freedom ({cmd:small} only){p_end}
{synopt:{cmd:r(p)}}two-sided p-values{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{p2colreset}{...}

{pstd}
{cmd:estat dwatson} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(k)}}number of regressors{p_end}
{synopt:{cmd:r(N_gaps)}}number of gaps{p_end}
{synopt:{cmd:r(dw)}}Durbin-Watson statistic{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker DM1993}{...}
{phang}
Davidson, R., and J. G. MacKinnon. 1993.
{browse "http://www.stata.com/bookstore/eie.html":{it:Estimation and Inference in Econometrics}.}
New York: Oxford University Press.

{marker DW1950}{...}
{phang}
Durbin, J., and G. S. Watson. 1950. Testing for serial correlation in least
squares regression. I. {it:Biometrika} 37: 409-428.
{p_end}
