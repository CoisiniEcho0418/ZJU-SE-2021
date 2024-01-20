{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog tsfill "dialog tsfill"}{...}
{vieweralsosee "[TS] tsfill" "mansection TS tsfill"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsappend" "help tsappend"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{viewerjumpto "Syntax" "tsfill##syntax"}{...}
{viewerjumpto "Description" "tsfill##description"}{...}
{viewerjumpto "Option" "tsfill##option"}{...}
{viewerjumpto "Examples" "tsfill##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink TS tsfill} {hline 2}}Fill in gaps in time variable{p_end} 
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:tsfill} [{cmd:,} {opt f:ull}]

{phang}
You must {cmd:tsset} your data before using {cmd:tsfill}; see
{helpb tsset:[TS] tsset}.


{title:Menu}

{phang}
{bf:Statistics > Time series > Setup and utilities >}
   {bf:Fill in gaps in time variable}


{marker description}{...}
{title:Description}

{pstd}
{cmd:tsfill} is used after {cmd:tsset} to fill in gaps in time-series data and
gaps in panel data with new observations, which contain missing values.  For
instance, perhaps observations for 
{bind:{it:timevar} = 1, 3, 5, 6, ..., 22} exist.  {cmd:tsfill} would
create observations for {it:timevar} = 2 and {it:timevar} = 4 containing all
missing values.  There is seldom reason to do this because Stata's time-series
operators consider {it:timevar}, not the observation number.  Referring to
{cmd:L.gnp} to obtain lagged {cmd:gnp} values would correctly produce a
missing value for {it:timevar} = 3, even if the data were not filled in.
Referring to {cmd:L2.gnp} would correctly return the value of {cmd:gnp} in the
first observation for {it:timevar} = 3, even if the data were not filled in.


{marker option}{...}
{title:Option}

{phang}
{cmd:full} is for use with panel data only.  With panel data, {cmd:tsfill} by
default fills in observations for each panel according to the minimum and
maximum values of {it:timevar} for the panel.  Thus if the first panel
spanned the times 5-20 and the second panel the times 1-15, after {cmd:tsfill}
they would still span the same periods; observations would be created to
fill in any missing times from 5-20 in the first panel and from 1-15 in the
second.

{pmore}
If {cmd:full} is specified, observations are created so that both panels span
the time 1-20, the overall minimum and maximum of {it:timevar} across panels.


{marker examples}{...}
{title:Examples}

{pstd}Using {cmd:tsfill} with time-series data{p_end}
{phang2}{cmd:. webuse tsfillxmpl}{p_end}
{phang2}{cmd:. list mdate income}{p_end}
{phang2}{cmd:. tsfill}{p_end}
{phang2}{cmd:. list mdate income}

{pstd}Using {cmd:tsfill} with panel data{p_end}
{phang2}{cmd:. webuse tsfillxmpl2, clear}{p_end}
{phang2}{cmd:. list edlevel year income}{p_end}
{phang2}{cmd:. tsfill}{p_end}
{phang2}{cmd:. list edlevel year income}{p_end}
{phang2}{cmd:. tsfill, full}{p_end}
{phang2}{cmd:. list edlevel year income}{p_end}
