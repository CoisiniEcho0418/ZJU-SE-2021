{smcl}
{* *! version 1.3.0  20may2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] _coef_table_header" "help _coef_table_header"}{...}
{vieweralsosee "[P] ereturn" "help ereturn"}{...}
{vieweralsosee "[P] matrix makeCns" "help matrix_makeCns"}{...}
{vieweralsosee "[R] ml" "help ml"}{...}
{vieweralsosee "[P] return" "help return"}{...}
{vieweralsosee "[U] 20 Estimation and postestimation command (estimation)" "help estcom"}{...}
{vieweralsosee "[U] 20 Estimation and postestimation commands (postestimation)" "help postest"}{...}
{viewerjumpto "Syntax" "_coef_table##syntax"}{...}
{viewerjumpto "Description" "_coef_table##description"}{...}
{viewerjumpto "Options" "_coef_table##options"}{...}
{viewerjumpto "Remarks" "_coef_table##remarks"}{...}
{viewerjumpto "Saved results" "_coef_table##results"}{...}
{title:Title}

{p 4 21 2}
{hi:[P] _coef_table} {hline 2} Displaying estimation results


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:_coef_table} [{cmd:,}
	{opt l:evel(#)}
	{opt f:irst}
	{opt neq(#)}
	{opt pl:us}
	{opt sep:arator(#)}
	{opt notest}
	{opt coeft:itle(title)}
	{opt pt:itle(title)}
	{opt cit:itle(title)}
	{opt offsetonly1}
	{opt nocnsr:eport}
	{opt fullcnsr:eport}
	{opt bmat:rix(matname)}
	{opt vmat:rix(matname)}
	{opt cnsmat:rix(matname)}
	{opt dfmat:rix(matname)}
	{opt sort}
	{opt cformat(format)}
	{opt pformat(format)}
	{opt sformat(format)}
	{it:{help eform_option}}
	{it:diparm_options}
]

{pstd}
{it:diparm_options} is one or more {cmd:diparm(}{it:diparm_args}{cmd:)} options,
where {it:diparm_args} is either {cmd:__sep__} or anything accepted by the
{cmd:_diparm} command; see {manhelp _diparm P}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:_coef_table} is an enhanced version of {cmd:ereturn} {cmd:display}; see
{manhelp ereturn P}


{marker options}{...}
{title:Options}

{phang}
{opt level(#)} supplies the significance level for the confidence intervals of
the coefficients; see {manhelp level R}.

{phang}
{opt first} requests that Stata display only the first equation and
make it appear as if only one equation was estimated.

{phang}
{opt neq(#)} requests that Stata display only the first
{it:#} equations and make it appear as if only {it:#} equations were
estimated.

{phang}
{opt plus} places a {hi:+} symbol at the position of the dividing line between
variable names and results on the bottom separation line produced by
{cmd:estimates display}.  This is useful if you plan on adding more output to
the table.

{phang}
{opt separator(#)} places a horizontal separator line between every {it:#}
auxiliary parameters.

{phang}
{opt notest} suppresses the test statistic and p-value for ancillary
parameters.

{phang}
{opt coeftitle(title)} specifies the title for the coefficient column of the
table.  This option is ignored if {cmd:eform()} is specified.

{phang}
{opt ptitle(title)} specifies the super title for the p-value column of the
table.

{phang}
{opt cititle(title)} specifies the super title for the confidence interval
columns of the table.

{phang}
{opt offsetonly1} requests that {cmd:_coef_table} only report the offset for
the first equation.

{phang}
{opt nocnsreport} suppresses the display of constraints above the coefficient
table.  This option is ignored if constraints were not used to fit the model.

{phang}
{opt fullcnsreport} specifies that all constraints be reported above the
coefficient table.  This includes automatic constraints implied for the
{cmd:o.} and {cmd:b.} variable operators.  This option is ignored if
constraints were not used to fit the model.

{phang}
{opt bmatrix(matname)} specifies that the coefficients are in {it:matname}
instead of in {cmd:e(b)}.

{phang}
{opt vmatrix(matname)} specifies that the VCE matrix is {it:matname}
instead of {cmd:e(V)}.  This option requires the {opt bmatrix()} option.

{phang}
{opt cnsmatrix(matname)} specifies that the constraint matrix is {it:matname}
instead of {cmd:e(Cns)}.  This option requires the {opt bmatrix()} option.

{phang}
{opt dfmatrix(matname)} specifies that the multiple-imputation
degrees-of-freedom values are in {it:matname} instead of in {cmd:e(mi_df)}.
This option requires the {opt vmatrix()} option.

{phang}
{opt sort} specifies that the table be sorted within equation on the
coefficient values.

{phang}
{opth cformat(%fmt)} specifies how to format coefficients, standard errors, and
confidence limits in the coefficient table.

{phang}
{opth pformat(%fmt)} specifies how to format p-values in the coefficient table.

{phang}
{opth sformat(%fmt)} specifies how to format test statistics in the coefficient
table.

{phang}
{it:eform_option} is identified in {help eform_option}.  Also see
{hi:Exponentiated form} below.

{phang}
{it:diparm_options} is one or more {opt diparm(diparm_args)} options, where
{it:diparm_args} is either {opt __sep__} or anything accepted by the
{cmd:_diparm} command; see {manhelp _diparm P}.

{pmore}
Although {it:diparm_options} are allowed, we recommend that you identify
the number of ancillary parameters by setting {cmd:e(k_aux)}; see
{hi:Ancillary parameters}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

          {help _coef_table##remarks1:Automatic behavior}
          {help _coef_table##remarks2:Ancillary parameters}
          {help _coef_table##remarks3:Exponentiated form}


{marker remarks1}{...}
{title:Automatic behavior}

{pstd}
{cmd:_coef_table} uses the following scalars and macros from {cmd:e()}:

{p2colset 9 25 29 2}{...}
{p2col :Scalar}Description{p_end}
{p2line}
{p2col :{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{p2col :{cmd:e(k_aux)}}number of ancillary parameters in {cmd:e(b)}{p_end}
{p2col :{cmd:e(k_extra)}}number
	of extra statistics stored in {cmd:e(b)}{p_end}
{p2col :{cmd:e(k_eform)}}number
	of equations allowed to be affected by an {it:eform_option}; by
	default, only the first equation is affected{p_end}
{p2line}

{p2col :Macro}Description{p_end}
{p2line}
{p2col :{cmd:e(diparm}{it:#}{cmd:)}}arguments
	to be supplied to {cmd:_diparm}{p_end}
{p2col :{cmd:e(diparm_opt}{it:#}{cmd:)}}extra
	options to be added to the call to {cmd:_diparm} for the ancillary
	parameter stored in equation {it:#}, typically {opt noprob}{p_end}
{p2line}
{p2colreset}{...}


{marker remarks2}{...}
{title:Ancillary parameters}

{pstd}
Although {it:diparm_options} are allowed, we recommend that you identify
the number of ancillary parameters by setting {cmd:e(k_aux)}; for example,

{pmore2}
{cmd:ereturn scalar k_aux = 2}

{pstd}
identifies that there are two ancillary parameters.  If you want to display a
transform of one or more ancillary parameters, identify them by setting
{cmd:e(diparm}{it:#}{cmd:)}; for example,

{pmore2}
{cmd:ereturn local diparm1 lnsigma, exp label("sigma")}

{pstd}
specifies the arguments to {cmd:_diparm}, just like {it:diparm_options}.


{marker remarks3}{...}
{title:Exponentiated form}

{pstd}
{cmd:_coef_table} will display the coefficient table in exponentiated form
when supplied with an {it:eform_option}; see {manhelp eform_option R}.

{pstd}
Although the {opt eform} and {opt eform(string)} options are always allowed,
the properties of the commands identified in {cmd:e(cmd)} and {cmd:e(cmd2)}
will determine which other {it:eform_option} is allowed (where the property
matches the option).  Thus, in order for the {opt or} option to be allowed,
{cmd:e(cmd)} must have the "or" property; see {manhelp program P} for
information about setting the properties of programs.

{pstd}
{cmd:e(k_eform)} determines which equations are affected by an
{it:eform_option}; by default, only the first equation is affected.
{p_end}


{marker results}{...}
{title:Saved results}

{pstd}
{cmd:_coef_table} saves the following in {cmd:r()}:

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Scalars}{p_end}
{synopt:{cmd:r(level)}}confidence level of confidence intervals{p_end}

{p2col 5 16 20 2: Macros}{p_end}
{synopt:{cmd:r(label}{it:#}{cmd:)}}label on the {it:#}th coefficient,
        such as {cmd:(base)}, {cmd:(omitted)}, {cmd:(empty)}, or
        {cmd:(constrained)}{p_end}
{synopt:{cmd:r(table)}}information from the coefficient table (see below){p_end}
{p2colreset}{...}


{pstd}
{cmd:r(table)} contains the following information for each coefficient:

{synoptset 16 tabbed}{...}
{synopt:{cmd:b}}coefficient value{p_end}
{synopt:{cmd:se}}standard error{p_end}
{synopt:{cmd:t/z}}test statistic for coefficient{p_end}
{synopt:{cmd:pvalue}}observed significance level for {cmd:t/z}{p_end}
{synopt:{cmd:ll}}lower limit of confidence interval{p_end}
{synopt:{cmd:ul}}upper limit of confidence interval{p_end}
{synopt:{cmd:df}}degrees of freedom associated with coefficient{p_end}
{synopt:{cmd:crit}}critical value associated with {cmd:t/z}{p_end}
{synopt:{cmd:eform}}indicator for exponentiated coefficients{p_end}
{p2colreset}{...}
