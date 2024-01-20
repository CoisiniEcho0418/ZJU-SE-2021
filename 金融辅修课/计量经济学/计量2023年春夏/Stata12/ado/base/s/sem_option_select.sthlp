{smcl}
{* *! version 1.0.1  07jul2011}{...}
{vieweralsosee "[SEM] sem option select()" "mansection SEM semoptionselect()"}{...}
{vieweralsosee "[SEM] intro 10" "mansection SEM intro10"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "[SEM] ssd" "help ssd"}{...}
{viewerjumpto "Syntax" "sem_option_select##syntax"}{...}
{viewerjumpto "Description" "sem_option_select##description"}{...}
{viewerjumpto "Option" "sem_option_select##option"}{...}
{viewerjumpto "Remarks" "sem_option_select##remarks"}{...}
{viewerjumpto "Examples" "sem_option_select##examples"}{...}
{title:Title}

{p2colset 5 34 36 2}{...}
{p2col:{manlink SEM sem option select()} {hline 2}}Using sem with summary
statistics data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:... }[{cmd:, ...} {cmd: select(}{it:#} [{it:#} {cmd: ...}]{cmd:) ...}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:sem} may be used with summary statistics data (SSD), data containing
only summary statistics such as the means, standard deviations or variances,
and correlations and covariances of the underlying, raw data.

{pstd}
You enter SSD using the {cmd:ssd} command; see {helpb ssd:[SEM] ssd}.

{pstd}
To fit a model with {cmd:sem}, there is nothing special you have to do
except specify the {opt select()} option where you would usually specify
{cmd:if} {it:{help exp}}.


{marker option}{...}
{title:Option}

{phang}
{opt select(# [# ...])}
is allowed only when you have SSD in memory.  It specifies which groups should
be used.

{marker remarks}{...}
{title:Remarks}

{pstd}
See {manlink SEM intro 10}.

{pstd}
{cmd:sem} option {opt select()} is the SSD alternative for {cmd:if} 
{it:exp} if only you had the underlying, raw data in memory.  With the
underlying raw data, where you would usually type

{phang2}{cmd:. sem ... if agegrp==1 | agegrp==3, ...}{p_end}

{pstd}
with SSD in memory, you type

{phang2}{cmd:. sem ..., ... select(1 3)}{p_end}

{pstd}
You may select only groups for which you have separate summary statistics
recorded in your summary statistics dataset; the {cmd:ssd describe} command
will list the group variable, if any.  See {helpb ssd:[SEM] ssd}.

{pstd}
By the way, {opt select()} may be combined with {cmd:sem} option 
{opt group()}.  Where you might usually type

{phang2}{cmd:. sem ... if agegrp==1 | agegrp==3, ... group(agegrp)}{p_end}

{pstd}
you type

{phang2}{cmd:. sem ..., ... select(1 3) group(agegrp)}{p_end}

{pstd}
The above restricts {cmd:sem} to age groups 1 and 3, so the result will be
estimation of a combined model of age groups 1 and 3 with some coefficients
allowed to vary between the groups and other coefficients constrained to be
equal across the groups.  See {helpb sem_group options:[SEM] sem group options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmmby}{p_end}
{phang2}{cmd:. ssd describe}{p_end}

{pstd}Two-factor measurement model with groups{p_end}
{phang2}{cmd:. sem (Peer -> peerrel1 peerrel2 peerrel3 peerrel4)}{break}
	{cmd: (Par -> parrel1 parrel2 parrel3 parrel4), group(grade)}{p_end}

{pstd}Use option {opt select()} to perform analysis only on group 1{p_end}
{phang2}{cmd:. sem (Peer -> peerrel1 peerrel2 peerrel3 peerrel4)}{break}
	{cmd: (Par -> parrel1 parrel2 parrel3 parrel4), group(grade) select(1)}{p_end}
