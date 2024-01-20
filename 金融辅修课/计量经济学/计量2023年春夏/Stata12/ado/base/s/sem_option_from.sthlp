{smcl}
{* *! version 1.0.1  29jun2011}{...}
{vieweralsosee "[SEM] sem option from()" "mansection SEM semoptionfrom()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem model description options" "help sem_model_options"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] maximize" "help maximize"}{...}
{viewerjumpto "Syntax" "sem_option_from##syntax"}{...}
{viewerjumpto "Description" "sem_option_from##description"}{...}
{viewerjumpto "Option" "sem_option_from##option"}{...}
{viewerjumpto "Remarks" "sem_option_from##remarks"}{...}
{viewerjumpto "Examples" "sem_option_from##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col:{manlink SEM sem option from()} {hline 2}}Specifying starting values{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:...} [{cmd:, ...} {cmd:from(}{it:matname} [{cmd:,}
           {opt skip}]{cmd:)}
{cmd:...}]

{p 8 12 2}
{cmd:sem} {cmd:...} [{cmd:, ...} {cmd:from(}{it:svlist}{cmd:) ...}]

{pstd}
where {it:matname} is the name of a Stata matrix and 

{pstd}
where {it:svlist} is a space-separated list of the form

{phang2}{cmd:eqname:name =} {it:#}{p_end}


{marker description}{...}
{title:Description}

{pstd}
See {manlink SEM intro 3} for a description of starting values.

{pstd}
Starting values are usually not specified.  When there are convergence
problems, it is often necessary to specify starting values.  You can specify
starting values 

{phang2}
1.  using suboption {opt init()} as described in
{helpb sem_path_notation##initialvalues:[SEM] sem path notation}, or

{phang2}
2.  using {cmd:sem} option {opt from()} described here. 

{pstd}
{cmd:sem} option {opt from()} is especially useful when you use  the solution
of one model as starting values for another. 


{marker option}{...}
{title:Option}

{phang}
{cmd:skip} is an option of {opt from(matname)}.  It specifies that parameters
in {it:matname} that do not appear in the model being fit be skipped.
If this option is not specified, the existence of such parameters causes 
{cmd:sem} to issue an error message.  This option is rarely specified.  Usually,
{it:matname} contains a subset, not a superset, of the values being estimated.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {it:{mansection SEM semoptionfrom()Remarks:Remarks}} of
{manlink SEM sem option from()} for further information. 


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_2fmm}{p_end}

{pstd}Fit a reduced two-factor measurement model{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4)}{break}
	{cmd:(Cognitive -> c1 c2 c3 c4)}{p_end}

{pstd}Copy results in {cmd:e(b)}{p_end}
{phang2}{cmd:. matrix b = e(b)}{p_end}

{pstd}Add parameters to the above model and specify starting values{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5)}{break}
	{cmd:(Cognitive -> c1 c2 c3 c4 c5), from(b)}{p_end}

{pstd}Use the alternative notation to specify a list of starting values{p_end}
{phang2}{cmd:. sem (Affective -> a1 a2 a3 a4 a5)}{break}
	{cmd:(Cognitive -> c1 c2 c3 c4 c5),}{break}
	{cmd: from(a2:Affective = 1 a3:Affective = 1)}{p_end}
