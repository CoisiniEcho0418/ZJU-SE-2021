{smcl}
{* *! version 1.2.4  17mar2011}{...}
{viewerdialog estat "dialog estat"}{...}
{vieweralsosee "[R] estat" "mansection R estat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] estat programming" "help estat_programming"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{vieweralsosee "[R] summarize" "help summarize"}{...}
{viewerjumpto "Syntax" "estat##syntax"}{...}
{viewerjumpto "Description" "estat##description"}{...}
{viewerjumpto "Option for estat ic" "estat##option_estat_ic"}{...}
{viewerjumpto "Options for estat summarize" "estat##options_estat_summarize"}{...}
{viewerjumpto "Options for estat vce" "estat##options_estat_vce"}{...}
{viewerjumpto "Examples" "estat##examples"}{...}
{viewerjumpto "Saved results" "estat##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink R estat} {hline 2}}Postestimation statistics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    {title:Common subcommands}

	Display information criteria

	    {cmd:estat ic} [{cmd:,} {opt n(#)}]


	Summarize estimation sample

	    {cmd:estat} {cmdab:su:mmarize} [{it:eqlist}] [{cmd:,} {help estat##estat_summ_options:{it:estat_summ_options}}]


	Display covariance matrix estimates

	    {cmd:estat} {cmd:vce} [{cmd:,} {help estat##estat_vce_options:{it:estat_vce_options}}]


    {title:Command-specific subcommands}

	{cmd:estat} {it:subcommand1} [{cmd:,} {it:options1} ]

	{cmd:estat} {it:subcommand2} [{cmd:,} {it:options2} ]

		{it:...}


{marker estat_summ_options}{...}
{synoptset 21}
{p2coldent:{it:estat_summ_options}}Description{p_end}
{synoptline}
{synopt:{opt eq:uation}}display summary by equation{p_end}
{synopt:{opt gro:up}}display summary by group; only after {cmd:sem}{p_end}
{synopt:{opt lab:els}}display variable labels{p_end}
{synopt:{opt nohea:der}}suppress the header{p_end}
{synopt:{opt nowei:ghts}}ignore weights{p_end}
{synopt :{it:{help estat##display_options:display_options}}}control spacing
           and display of omitted variables and base and empty cells{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{it:eqlist} is rarely used and specifies the variables, with optional equation
name, to be summarized.  {it:eqlist} may be {varlist} or ({it:eqname1}{cmd::}
{it:varlist}) ({it:eqname2}{cmd::} {it:varlist}) {it:...}.  {it:varlist} may
contain time-series operators; see {help tsvarlist}.
{p_end}

{marker estat_vce_options}{...}
{synoptset 21}
{p2coldent:{it:estat_vce_options}}Description{p_end}
{synoptline}
{synopt:{opt cov:ariance}}display as covariance matrix; the default{p_end}
{synopt:{opt cor:relation}}display as correlation matrix{p_end}
{synopt:{opt eq:uation(spec)}}display only specified equations{p_end}
{synopt:{opt b:lock}}display submatrices by equation{p_end}
{synopt:{opt d:iag}}display submatrices by equation; diagonal blocks
only{p_end}
{synopt:{opth f:ormat(%fmt)}}display format for covariances and
correlations{p_end}
{synopt:{opt nolin:es}}suppress lines between equations{p_end}
{synopt :{it:{help estat##display_options:display_options}}}control 
           display of omitted variables and base and empty cells{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker description}{...}
{title:Description}

{pstd}
{opt estat} displays scalar- and matrix-valued statistics after estimation; it
complements {cmd:predict}, which calculates variables after estimation.
Exactly what statistics {opt estat} can calculate depends on
the previous estimation command.

{pstd}
Three sets of statistics are so commonly used that they are available after
all estimation commands that store the model log likelihood.  {opt estat ic}
displays the Akaike's and Schwarz's Bayesian information criteria. 
{opt estat summarize} summarizes the variables used by the command and
automatically restricts the sample to {cmd:e(sample)}; it also summarizes the
weight variable and cluster structure, if specified.  {opt estat vce} displays
the covariance or correlation matrix of the parameter estimates of the
previous model.


{marker option_estat_ic}{...}
{title:Option for estat ic}

{phang}
{opt n(#)} specifies the {it:N} to be used in calculating BIC; see
{manhelp bic_note R:BIC note}.


{marker options_estat_summarize}{...}
{title:Options for estat summarize}

{phang}
{opt equation} requests that the dependent variables and the independent
variables in the equations be displayed in the equation-style format of
estimation commands, repeating the summary information about variables entered
in more than one equation.

{phang}
{opt group} displays summary information separately for each group.
{opt group} is only allowed after {cmd:sem} with a {opt group()} variable
specified.

{phang}
{opt labels} displays variable labels.

{phang}
{opt noheader} suppresses the header.

{phang}
{opt noweights} ignores the weights, if any, from the previous estimation
command.  The default when weights are present is to perform a weighted
{cmd:summarize} on all variables except the weight variable itself.  An
unweighted {cmd:summarize} is performed on the weight variable.

{marker display_options}{...}
{phang}
{it:display_options}:
{opt noomit:ted},
{opt vsquish},
{opt noempty:cells},
{opt base:levels},
{opt allbase:levels};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker options_estat_vce}{...}
{title:Options for estat vce}

{phang}
{opt covariance} displays the matrix as a variance{c -}covariance matrix; this
is the default.

{phang}
{opt correlation} displays the matrix as a correlation matrix rather than a
variance-covariance matrix.  {opt rho} is a synonym.

{phang}
{opt equation(spec)} selects part of the VCE to be displayed.  If {it:spec} is 
{it:eqlist}, the VCE for the listed equations is displayed.  If {it:spec} is 
{it:eqlist1} {cmd:\} {it:eqlist2}, the part of the VCE associated with the
equations in {it:eqlist1} (rowwise) and {it:eqlist2} (columnwise) is
displayed.  If {it:spec} is {cmd:*}, all equations are displayed.
{opt equation()} implies {opt block} if {opt diag} is not specified.

{phang}
{opt block} displays the submatrices pertaining to distinct equations
separately.

{phang}
{opt diag} displays the diagonal submatrices pertaining to distinct equations
separately.

{phang}
{opth format(%fmt)} specifies the number format for displaying the elements of
the matrix.  The default is {cmd:format(%10.0g)} for covariances and
{cmd:format(%8.4f)} for correlations.  See {manhelp format D} for more
information.  

{phang}
{opt nolines} suppresses lines between equations.

{marker display_options}{...}
{phang}
{it:display_options}:
{opt noomit:ted},
{opt noempty:cells},
{opt base:levels},
{opt allbase:levels};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress price headroom trunk length mpg}{p_end}

{pstd}Obtain AIC and BIC{p_end}
{phang2}{cmd:. estat ic}{p_end}

{pstd}Obtain summary of estimation sample{p_end}
{phang2}{cmd:. estat summarize}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse klein}{p_end}
{phang2}{cmd:. reg3 (consump wagep wageg) (wagep consump govt capital)}{p_end}

{pstd}Obtain summary of estimation sample for each equation{p_end}
{phang2}{cmd:. estat summarize, equation}{p_end}

{pstd}Display VCE for each equation separately, using {cmd:%7.2f} format{p_end}
{phang2}{cmd:. estat vce, block format(%7.2f)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat ic} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(S)}}1 x 6 matrix of results:{p_end}
{synopt:}{space 2}1. sample size{space 19}4. degrees of freedom{p_end}
{synopt:}{space 2}2. log likelihood of null model{space 2}5. AIC{p_end}
{synopt:}{space 2}3. log likelihood of full model{space 2}6. BIC{p_end}

{pstd}
{cmd:estat summarize} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:r(N_groups)}}number of groups ({cmd:group} only){p_end}

{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(stats)}}k x 4 matrix of means, standard deviations, minimums,
and maximums{p_end}
{synopt:{cmd:r(stats}[{cmd:_}{it:#}]{cmd:)}}k x 4 matrix of means, standard
	deviations, minimums, and maximums for group {it:#}
        ({cmd:group} only){p_end}

{pstd}
{cmd:estat vce} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(V)}}VCE or correlation matrix{p_end}
{p2colreset}{...}
