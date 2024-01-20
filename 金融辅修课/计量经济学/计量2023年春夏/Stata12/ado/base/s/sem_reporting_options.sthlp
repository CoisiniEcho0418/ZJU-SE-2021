{smcl}
{* *! version 1.0.0  07jul2011}{...}
{vieweralsosee "[SEM] sem reporting options" "mansection SEM semreportingoptions"}{...}
{findalias assembequal}{...}
{findalias assemcorr}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_reporting_options##syntax"}{...}
{viewerjumpto "Description" "sem_reporting_options##description"}{...}
{viewerjumpto "Options" "sem_reporting_options##options"}{...}
{viewerjumpto "Remarks" "sem_reporting_options##remarks"}{...}
{viewerjumpto "Examples" "sem_reporting_options##examples"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col:{manlink SEM sem reporting options} {hline 2}}Options affecting
reporting of results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {it:paths} {cmd:... , ...} {it:reporting_options}

{p 8 12 2}
{cmd:sem,} {it:reporting_options}


{synoptset 19}{...}
{synopthdr:reporting_options}
{synoptline}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt stand:ardized}}display standardized coefficients and values{p_end}
{synopt :{opt coefl:egend}}display coefficient legend{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{opt nodes:cribe}}do not display variable classification table{p_end}
{synopt :{opt nohead:er}}do not display header above parameter table{p_end}
{synopt :{opt nofoot:note}}do not display footnotes below parameter table{p_end}
{synopt :{opt notable}}do not display parameter tables{p_end}
{synopt :{opt nolab:el}}display group values rather than value labels{p_end}
{synopt :{opt wrap(#)}}allow long group label to wrap the first {it:#} lines
{p_end}
{synopt :{opt showg:invariant}}report all estimated parameters{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
These options control how {cmd:sem} displays estimation results.


{marker options}{...}
{title:Options}

{phang}
{opt level(#)}; see {manlink R estimation options}.

{phang}
{opt standardized} displays standardized values, which is to say, "beta"
values for coefficients, correlations for covariances, and 1s for variances.
Standardized values are obtained using model-fitted variances
({help sem_references##Bollen1989:Bollen 1989}, 124-125).
We recommend caution in the
interpretation of standardized values, especially with multiple groups.

{phang}
{opt coeflegend} displays the legend that reveals how to specify estimated
coefficients in {opt _b[]} notation, which you are sometimes required to
type in specifying postestimation commands.

{phang}
{opt nocnsreport} suppresses the display of the constraints.
Fixed-to-zero constraints that are automatically set by {cmd:sem} are not
shown in the report in order to keep the output manageable.

{phang}
{opt nodescribe} suppresses display of the variable classification table.

{phang}
{opt noheader} suppresses the header above the parameter table, the display
that reports the final log-likelihood value, number of observations, etc.

{phang}
{opt nofootnote} suppresses the footnotes displayed below the parameter table.

{phang}
{opt notable} suppresses the parameter table.

{phang}
{opt nolabel} displays group values rather than value labels.

{phang}
{opt wrap(#)} allows long group labels to wrap the first {it:#} lines in the
parameter table.  The default is {cmd:wrap(0)}, which means that long group
labels will be abbreviated to fit on a single line.

{phang}
{opt showginvariant} specifies that each estimated parameter be reported in the
parameter table.  The default is to report each invariant parameter only once.


{marker remarks}{...}
{title:Remarks}

{pstd}
Any of the above options may be specified when you fit the model or when you
redisplay results, which you do by specifying nothing but options after the
{cmd:sem} command:

{phang2}{cmd:. sem (...) (...), ...}{p_end}
{phang2}{it:(original output displayed)}

{phang2}{cmd:. sem}{p_end}
{phang2}{it:(output redisplayed)}

{phang2}{cmd:. sem, standardized}{p_end}
{phang2}{it:(standardized output displayed)}

{phang2}{cmd:. sem, coeftable}{p_end}
{phang2}{it:(coefficient table displayed)}

{phang2}{cmd:. sem}{p_end}
{phang2}{it:(output redisplayed)}

{pstd}
See {findalias sembequal} and {findalias semcorr}.  


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmmby}{p_end}
{phang2}{cmd:. sem (Peer -> peerrel1 peerrel2 peerrel3 peerrel4)}{break}
	{cmd: (Par -> parrel1 parrel2 parrel3 parrel4), group(grade)}{p_end}

{pstd}Display standardized coefficients{p_end}
{phang2}{cmd:. sem, standardized}{p_end}

{pstd}Display coefficient legend{p_end}
{phang2}{cmd:. sem, coeflegend}{p_end}

{pstd}Only display the parameter table{p_end}
{phang2}{cmd:. sem, nofootnote noheader nocnsreport}{p_end}

{pstd}Report all estimated parameters{p_end}
{phang2}{cmd:. sem, showginvariant}{p_end}
