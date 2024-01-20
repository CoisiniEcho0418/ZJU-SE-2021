{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog estat "dialog sem_estat, message(-ggof-) name(sem_estat_ggof)"}{...}
{vieweralsosee "[SEM] estat ggof" "mansection SEM estatggof"}{...}
{findalias assemggof}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] estat eqgof" "help sem_estat_eqgof"}{...}
{vieweralsosee "[SEM] estat gof" "help sem_estat_gof"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem group options" "help sem_group_options"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_estat_ggof##syntax"}{...}
{viewerjumpto "Description" "sem_estat_ggof##description"}{...}
{viewerjumpto "Option" "sem_estat_ggof##option"}{...}
{viewerjumpto "Remarks" "sem_estat_ggof##remarks"}{...}
{viewerjumpto "Examples" "sem_estat_ggof##examples"}{...}
{viewerjumpto "Saved results" "sem_estat_ggof##saved_results"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col:{manlink SEM estat ggof} {hline 2}}Group-level goodness-of-fit
	statistics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:estat} {cmd:ggof} [{cmd:,} {opth for:mat(%fmt)}]


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Group statistics > Group-level goodness of fit}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estat ggof} is for use after {cmd:sem,} {opt group()}.  It displays, by
group, the standardized root mean squared residual (SRMR), the coefficient
of determination (CD), and the model versus saturated chi-squared along with
its associated degrees of freedom and p-value. 


{marker option}{...}
{title:Option}

{phang}{opth format(%fmt)}
specifies the display format.  The default is {cmd:format(%9.3f)}.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias semggof}.

{pstd}
{cmd:estat ggof} provides group-level goodness-of-fit statistics
after estimation by {cmd:sem,} {opt group()}; see 
{helpb sem group options:[SEM] sem group options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmmby}{p_end}
{phang2}{cmd:. sem (Peer -> peerrel1 peerrel2 peerrel3 peerrel4)}{break}
	{cmd: (Par -> parrel1 parrel2 parrel3 parrel4), group(grade)}{p_end}

{pstd}Group-level goodness-of-fit statistics{p_end}
{phang2}{cmd:. estat ggof}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat ggof} saves the following in {cmd:r()}:

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups{p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Matrices}{p_end}
{synopt:{cmd:r(gfit)}}fit statistics{p_end}
{p2colreset}{...}
