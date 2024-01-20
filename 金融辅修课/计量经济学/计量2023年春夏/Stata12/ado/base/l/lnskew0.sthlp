{smcl}
{* *! version 1.1.6  17mar2011}{...}
{viewerdialog lnskew0 "dialog lnskew0"}{...}
{viewerdialog bcskew0 "dialog bcskew0"}{...}
{vieweralsosee "[R] lnskew0" "mansection R lnskew0"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] boxcox" "help boxcox"}{...}
{vieweralsosee "[R] ladder" "help ladder"}{...}
{vieweralsosee "[R] swilk" "help swilk"}{...}
{viewerjumpto "Syntax" "lnskew0##syntax"}{...}
{viewerjumpto "Description" "lnskew0##description"}{...}
{viewerjumpto "Options" "lnskew0##options"}{...}
{viewerjumpto "Examples" "lnskew0##examples"}{...}
{viewerjumpto "Saved results" "lnskew0##saved_results"}{...}
{viewerjumpto "Reference" "lnskew0##reference"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R lnskew0} {hline 2}}Find zero-skewness log or Box-Cox
transform{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Zero-skewness log transform

{p 8 17 2}
{cmd:lnskew0} {newvar} {cmd:=} {it:{help exp}} {ifin} [{cmd:,} {it:options}]


{phang}
Zero-skewness Box-Cox transform

{p 8 17 2}
{cmd:bcskew0} {newvar} {cmd:=} {it:{help exp}} {ifin} [{cmd:,} {it:options}] 


{synoptset 12 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Main}
{synopt :{opt d:elta(#)}}increment for derivative of skewness function; default
is {cmd:delta(0.02)} for {opt lnskew0} and {cmd:delta(0.01)} for {opt bcskew0}{p_end}
{synopt :{opt z:ero(#)}}value for determining convergence; default is
{cmd:zero(0.001)}{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

    {title:lnskew0}

{phang2}
{bf:Data > Create or change data > Other variable-creation commands >}
      {bf:Zero-skewness log transform}

    {title:bcskew0}

{phang2}
{bf:Data > Create or change data > Other variable-creation commands >}
       {bf:Box-Cox transform}


{marker description}{...}
{title:Description}

{pstd}
{cmd:lnskew0} creates {newvar} = ln(+/-{it:{help exp}} - k), choosing k and the
sign of {it:exp} so that the skewness of {it:newvar} is zero.

{pstd}
{cmd:bcskew0} creates {it:newvar} = ({it:exp}^L - 1)/L, the Box-Cox power
transformation ({help lnskew0##BC1964:Box and Cox 1964}), choosing L so that
the skewness of {it:newvar} is zero.  {it:exp} must be strictly positive.  Also
see {manhelp boxcox R} for maximum likelihood estimation of L.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt delta(#)} specifies the increment used for calculating the derivative of
the skewness function with respect to k ({cmd:lnskew0}) or L ({cmd:bcskew0}).
The default values are 0.02 for {cmd:lnskew0} and 0.01 for {cmd:bcskew0}.

{phang}
{opt zero(#)} specifies a value for skewness to determine convergence that
is small enough to be considered zero and is, by default, 0.001.

{phang}
{opt level(#)} specifies the confidence level for the confidence interval for
k ({cmd:lnskew0}) or L ({cmd:bcskew0}).  The confidence interval is calculated
only if {opt level()} is specified.  {it:#} is specified as an integer; 95
means 95% confidence intervals.  The {opt level()} option is honored only if
the number of observations exceeds 7.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Create {cmd:lnmpg} containing ln({cmd:mpg}-k) with skewness 0{p_end}
{phang2}{cmd:. lnskew0 lnmpg = mpg}{p_end}

{pstd}Same as above and report 95% confidence intervals for k{p_end}
{phang2}{cmd:. lnskew0 lnmpg2 = mpg, level(95)}{p_end}

{pstd}Create {cmd:bcmpg} containing ({cmd:mpg}^L-1)/L with skewness 0{p_end}
{phang2}{cmd:. bcskew0 bcmpg = mpg}{p_end}

{pstd}Same as above and report 90% confidence interval for L{p_end}
{phang2}{cmd:. bcskew0 bcmpg2 = mpg, level(90)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:lnskew0} and {cmd:bcskew0} save the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(gamma)}}gamma({cmd:lnskew0}){p_end}
{synopt:{cmd:r(lambda)}}lambda({cmd:bcskew0}){p_end}
{synopt:{cmd:r(lb)}}lower bound of confidence interval{p_end}
{synopt:{cmd:r(ub)}}upper bound of confidence interval{p_end}
{synopt:{cmd:r(skewness)}}resulting skewness of transformed variable{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker BC1964}{...}
{phang}
Box, G. E. P., and D. R. Cox. 1964. An analysis of transformations.
{it:Journal of the Royal Statistical Society, Series B} 26: 211-252.
{p_end}
