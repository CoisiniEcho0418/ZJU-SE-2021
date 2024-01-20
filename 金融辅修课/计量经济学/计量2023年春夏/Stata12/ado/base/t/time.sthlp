{smcl}
{* *! version 1.1.6  09jun2011}{...}
{vieweralsosee "[TS] time series" "mansection TS timeseries"}{...}
{vieweralsosee "" "--"}{...}
{findalias asfrformatdatetime}{...}
{findalias asfrdatetimedisplay}{...}
{findalias asfrestts}{...}
{vieweralsosee "[TS] intro" "mansection TS intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] datetime" "help datetime"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "[XT] xt" "help xt"}{...}
{vieweralsosee "[U] 11.4 varlists" "help varlist"}{...}
{title:Title}

{pstd}
{manlink TS time series} {hline 2} Introduction to time-series commands{p_end}

{pstd}
(Note:  If you are looking for information on time and date variables, 
see {manhelp datetime D}.)
{p_end}

{title:Description}

{pstd}
Some Stata commands are written directly for performing time-series
analyses.  This entry provides an index to these commands.

{pstd}
Many other Stata commands allow time-series operators in expressions and
varlists (for example, {helpb regress}, {helpb summarize}, {helpb graph},
{helpb list}, ...).

{pstd}
For help with time-series operators and varlists, see {help tsvarlist}.

{pstd}
Before using time-series analysis commands or time-series operators, you
must declare your data to be time series and indicate the time variable.  This
is done using the {cmd:tsset} command; see {manhelp tsset TS}.

{pstd}
If your interest is in analyzing cross-sectional time-series (panel)
datasets, see {manhelp xt XT}.


    {title:Data-management tools and time-series operators}

{p2colset 9 37 39 2}{...}
{p2col :{helpb tsset}}Declare data to be time-series data{p_end}
{p2col :{helpb tsfill}}Fill in gaps in time variable{p_end}
{p2col :{helpb tsappend}}Add observations to a time-series dataset{p_end}
{p2col :{helpb tsreport}}Report time-series aspects of a dataset or estimation sample{p_end}
{p2col :{helpb tsrevar}}Time-series operator programming command{p_end}
{p2col :{helpb haver}}Load data from Haver Analytics database{p_end}
{p2col :{helpb rolling}}Rolling-window and recursive estimation{p_end}
{p2col :{helpb datetime business calendars}}User-definable business calendars{p_end}


    {title:Univariate time-series}

      {bf:Estimators}

{p2col :{helpb arfima}}Autoregressive fractionally integrated moving-average models{p_end}
{p2col :{helpb arfima postestimation}}Postestimation tools for arfima{p_end}
{p2col :{helpb arima}}ARIMA, ARMAX, and other dynamic regression models{p_end}
{p2col :{helpb arima postestimation}}Postestimation tools for arima{p_end}
{p2col :{helpb arch}}Autoregressive conditional heteroskedasticity (ARCH) family of estimators{p_end}
{p2col :{helpb arch postestimation}}Postestimation tools for arch{p_end}
{p2col :{helpb newey}}Regression with Newey-West standard errors{p_end}
{p2col :{helpb newey postestimation}}Postestimation tools for newey{p_end}
{p2col :{helpb prais}}Prais-Winsten and Cochrane-Orcutt regression{p_end}
{p2col :{helpb prais postestimation}}Postestimation tools for prais{p_end}
{p2col :{helpb ucm}}Unobserved-components model{p_end}
{p2col :{helpb ucm postestimation}}Postestimation tools for ucm{p_end}


      {bf:Time-series smoothers and filters}

{p2col :{helpb tsfilter bk}}Baxter-King time-series filter{p_end}
{p2col :{helpb tsfilter bw}}Butterworth time-series filter{p_end}
{p2col :{helpb tsfilter cf}}Christiano-Fitzgerald time-series filter{p_end}
{p2col :{helpb tsfilter hp}}Hodrick-Prescott time-series filter{p_end}
{p2col :{helpb tssmooth ma}}Moving-average filter{p_end}
{p2col :{helpb tssmooth dexponential}}Double-exponential smoothing{p_end}
{p2col :{helpb tssmooth exponential}}Single-exponential smoothing{p_end}
{p2col :{helpb tssmooth hwinters}}Holt-Winters nonseasonal smoothing{p_end}
{p2col :{helpb tssmooth shwinters}}Holt-Winters seasonal smoothing{p_end}
{p2col :{helpb tssmooth nl}}Nonlinear filter{p_end}


      {bf:Diagnostic tools}

{p2col :{helpb corrgram}}Tabulate and graph autocorrelations{p_end}
{p2col :{helpb xcorr}}Cross-correlogram for bivariate time series{p_end}
{p2col :{helpb cumsp}}Cumulative spectral distribution{p_end}
{p2col :{helpb pergram}}Periodogram{p_end}
{p2col :{helpb psdensity}}Parametric spectral density estimation{p_end}
{p2col :{helpb dfgls}}DF-GLS unit-root test{p_end}
{p2col :{helpb dfuller}}Augmented Dickey-Fuller unit-root test{p_end}
{p2col :{helpb pperron}}Phillips-Perron unit-roots test{p_end}
{p2col :{helpb regress postestimationts##dwatson:estat dwatson}}Durbin-Watson d statistic{p_end}
{p2col :{helpb regress postestimationts##durbinalt:estat durbinalt}}Durbin's alternative test for serial correlation{p_end}
{p2col :{helpb regress_postestimationts##bgodfrey:estat bgodfrey}}Breusch-Godfrey test for higher-order serial correlation{p_end}
{p2col :{helpb regress_postestimationts##archlm:estat archlm}}Engle's LM test for the presence of autoregressive conditional heteroskedasticity{p_end}
{p2col :{helpb wntestb}}Bartlett's periodogram-based test for white noise{p_end}
{p2col :{helpb wntestq}}Portmanteau (Q) test for white noise{p_end}


    {title:Multivariate time series}

      {bf:Estimators}

{p2col :{helpb dfactor}}Dynamic-factor models{p_end}
{p2col :{helpb dfactor postestimation}}Postestimation tools for dfactor{p_end}
{p2col :{helpb mgarch ccc}}Constant conditional correlation multivariate GARCH models{p_end}
{p2col :{helpb mgarch ccc postestimation}}Postestimation tools for mgarch ccc{p_end}
{p2col :{helpb mgarch dcc}}Dynamic conditional correlation multivariate GARCH models{p_end}
{p2col :{helpb mgarch dcc postestimation}}Postestimation tools for mgarch dcc{p_end}
{p2col :{helpb mgarch dvech}}Diagonal vech multivariate GARCH models{p_end}
{p2col :{helpb mgarch dvech postestimation}}Postestimation tools for mgarch dvech{p_end}
{p2col :{helpb mgarch vcc}}Varying conditional correlation multivariate GARCH models{p_end}
{p2col :{helpb mgarch vcc postestimation}}Postestimation tools for mgarch vcc{p_end}
{p2col :{helpb sspace}}State-space models{p_end}
{p2col :{helpb sspace postestimation}}Postestimation tools for sspace{p_end}
{p2col :{helpb var}}Vector autoregressive models{p_end}
{p2col :{helpb var postestimation}}Postestimation tools for var{p_end}
{p2col :{helpb svar}}Structural vector autoregressive models{p_end}
{p2col :{helpb svar postestimation}}Postestimation tools for svar{p_end}
{p2col :{helpb varbasic}}Fit a simple VAR and graph IRFs or FEVDs{p_end}
{p2col :{helpb varbasic postestimation}}Postestimation tools for varbasic{p_end}
{p2col :{helpb vec}}Vector error-correction models{p_end}
{p2col :{helpb vec postestimation}}Postestimation tools for vec{p_end}

      {bf:Diagnostic tools}

{p2col :{helpb varlmar}}Perform LM test for residual autocorrelation{p_end}
{p2col :{helpb varnorm}}Test for normally distributed disturbances{p_end}
{p2col :{helpb varsoc}}Obtain lag-order selection statistics for VARs and VECMs{p_end}
{p2col :{helpb varstable}}Check the stability condition of VAR or SVAR estimates{p_end}
{p2col :{helpb varwle}}Obtain Wald lag-exclusion statistics{p_end}
{p2col :{helpb veclmar}}Perform LM test for residual autocorrelation{p_end}
{p2col :{helpb vecnorm}}Test for normally distributed disturbances{p_end}
{p2col :{helpb vecrank}}Estimate the cointegrating rank of a VECM{p_end}
{p2col :{helpb vecstable}}Check the stability condition of VECM estimates{p_end}


      {bf:Forecasting, inference, and interpretation}

{p2col :{helpb irf create}}Obtain IRFs, dynamic-multiplier functions, and FEVDs{p_end}
{p2col :{helpb fcast compute}}Compute dynamic forecasts of dependent variables{p_end}
{p2col :{helpb vargranger}}Perform pairwise Granger causality tests{p_end}


      {bf:Graphs and tables}

{p2col :{helpb corrgram}}Tabulate and graph autocorrelations{p_end}
{p2col :{helpb xcorr}}Cross-correlogram for bivariate time series{p_end}
{p2col :{helpb pergram}}Periodogram{p_end}
{p2col :{helpb irf graph}}Graph IRFs, dynamic-multiplier functions, and
FEVDs{p_end}
{p2col :{helpb irf cgraph}}Combine graphs of IRFs, dynamic-multiplier functions,
and FEVDs{p_end}
{p2col :{helpb irf ograph}}Graph overlaid IRFs, dynamic-multiplier functions,
and FEVDs{p_end}
{p2col :{helpb irf table}}Create tables of IRFs, dynamic-multiplier functions,
and FEVDs{p_end}
{p2col :{helpb irf ctable}}Combine tables of IRFs, dynamic-multiplier functions, and FEVDs{p_end}
{p2col :{helpb fcast graph}}Graph forecasts of variables computed by fcast compute{p_end}
{p2col :{helpb tsline}}Plot time-series data{p_end}
{p2col :{helpb tsrline}}Plot time-series range plot data{p_end}
{p2col :{helpb varstable}}Check the stability condition of VAR or SVAR estimates{p_end}
{p2col :{helpb vecstable}}Check the stability condition of VECM estimates{p_end}
{p2col :{helpb wntestb}}Bartlett's periodogram-based test for white noise{p_end}


      {bf:Results management tools}

{p2col :{helpb irf add}}Add results from an IRF file to the active IRF file{p_end}
{p2col :{helpb irf describe}}Describe an IRF file{p_end}
{p2col :{helpb irf drop}}Drop IRF results from the active IRF file{p_end}
{p2col :{helpb irf rename}}Rename an IRF result in an IRF file{p_end}
{p2col :{helpb irf set}}Set the active IRF file{p_end}
