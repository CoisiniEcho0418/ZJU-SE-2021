{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[TS] tssmooth" "mansection TS tssmooth"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] arima" "help arima"}{...}
{vieweralsosee "[R] smooth" "help smooth"}{...}
{vieweralsosee "[TS] sspace" "help sspace"}{...}
{vieweralsosee "[TS] tsfilter" "help tsfilter"}{...}
{viewerjumpto "Syntax" "tssmooth##syntax"}{...}
{viewerjumpto "Description" "tssmooth##description"}{...}
{viewerjumpto "Examples" "tssmooth##examples"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink TS tssmooth} {hline 2}}Smooth and forecast univariate 
   time-series data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:tssmooth} {it:smoother} {dtype} {newvar} {cmd:=} {it:{help exp}}
   {ifin} [{cmd:,} {it:...}]

{synoptset 28 tabbed}{...}
{p2coldent :Smoother category}{it:smoother}{p_end}
{synoptline}
{syntab:Moving average}
{synopt :with uniform weights}{helpb tssmooth ma:ma}{p_end}
{synopt :with specified weights}{helpb tssmooth ma:ma}{p_end}

{syntab:Recursive}
{synopt :exponential}{helpb tssmooth exponential:exponential}{p_end}
{synopt :double exponential}{helpb tssmooth dexponential:dexponential}{p_end}
{synopt :nonseasonal Holt-Winters}{helpb tssmooth hwinters:hwinters}{p_end}
{synopt :seasonal Holt-Winters}{helpb tssmooth shwinters:shwinters}{p_end}

{p2coldent :Nonlinear filter}{helpb tssmooth nl:nl}{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:tssmooth} creates new variable {newvar} and fills it in by passing the
specified expression (usually a variable name) through the requested smoother.


{marker examples}{...}
{title:Example of tssmooth ma}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sales1}{p_end}
{phang2}{cmd:. tsset}{p_end}

{pstd}Create uniformly weighted moving average of {cmd:sales} by using two
lagged terms, using three forward terms, and including the current observation
in the filter{p_end}
{phang2}{cmd:. tssmooth ma sm1=sales, window(2 1 3)}


{title:Example of tssmooth exponential}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sales1, clear}{p_end}

{pstd}Perform single-exponential smoothing on {cmd:sales}{p_end}
{phang2}{cmd:. tssmooth exponential double sm2a=sales}


{title:Example of tssmooth dexponential}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sales2, clear}{p_end}

{pstd}Perform double-exponential smoothing on {cmd:sales}{p_end}
{phang2}{cmd:. tssmooth dexponential double sm2a=sales}


{title:Example of tssmooth hwinters}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse bsales, clear}{p_end}

{pstd}Perform Holt-Winters nonseasonal smoothing on {cmd:sales}{p_end}
{phang2}{cmd:. tssmooth hwinters hw1=sales}


{title:Example of tssmooth shwinters}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse turksales, clear}{p_end}

{pstd}Perform Holt-Winters seasonal smoothing on {cmd:sales}{p_end}
{phang2}{cmd:. tssmooth shwinters shw1=sales}


{title:Example of tssmooth nl}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sales2, clear}{p_end}

{pstd}Perform nonlinear smoothing on {cmd:sales} using a median smoother of
span 5{p_end}
{phang2}{cmd:. tssmooth nl nl1=sales, smoother(5)}{p_end}
