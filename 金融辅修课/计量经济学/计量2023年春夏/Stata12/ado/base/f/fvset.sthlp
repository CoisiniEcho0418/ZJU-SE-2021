{smcl}
{* *! version 1.1.6  11feb2011}{...}
{viewerdialog fvset "dialog fvset"}{...}
{vieweralsosee "[R] fvset" "mansection R fvset"}{...}
{viewerjumpto "Syntax" "fvset##syntax"}{...}
{viewerjumpto "Description" "fvset##description"}{...}
{viewerjumpto "Options" "fvset##options"}{...}
{viewerjumpto "Examples" "fvset##examples"}{...}
{viewerjumpto "Saved results" "fvset##saved_results"}{...}
{title:Title}

{pstd}
{manlink R fvset} {hline 2} Declare factor-variable settings


{marker syntax}{...}
{title:Syntax}

{pstd}
Declare base settings

{phang2}
{cmd:fvset} {opt b:ase} {it:base_spec} {varlist}


{pstd}
Declare design settings

{phang2}
{cmd:fvset} {opt d:esign} {it:design_spec} {varlist}


{pstd}
Clear the current settings

{phang2}
{cmd:fvset} {cmd:clear} {varlist}


{pstd}
Report the current settings

{phang2}
{cmd:fvset} {cmd:report} [{varlist}]
	[{cmd:,} {opt b:ase(base_spec)} {opt d:esign(design_spec)}]


{synoptset 14}{...}
{synopthdr:base_spec}
{synoptline}
{synopt :{opt default}}default base{p_end}
{synopt :{opt f:irst}}lowest level value; the default{p_end}
{synopt :{opt l:ast}}highest level value{p_end}
{synopt :{opt freq:uent}}most frequent level value{p_end}
{synopt :{opt n:one}}no base{p_end}
{synopt :{it:#}}nonnegative integer value{p_end}
{synoptline}


{synopthdr:design_spec}
{synoptline}
{synopt :{opt default}}default design{p_end}
{synopt :{opt asbal:anced}}accumulate using 1/k, k = number of levels{p_end}
{synopt :{opt asobs:erved}}accumulate
	using observed relative frequencies; the default{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
{cmd:fvset} declares factor-variable settings.  Factor-variable settings
identify the base level and how to accumulate statistics over levels.

{pstd}
{cmd:fvset} {cmd:base} specifies the base level for each variable in
{varlist}.  The default for factor variables without a declared base level
is {opt first}.

{pstd}
{cmd:fvset} {cmd:design} specifies how to accumulate over the levels of a
factor variable.  The {helpb margins} command is the only command aware of this
setting.  By default, {cmd:margins} assumes that factor variables are
{opt asobserved}, meaning that they are accumulated by weighting by the number
of observations or the sum of the weights if {help weights} have been
specified.

{pstd}
{cmd:fvset} {cmd:clear} removes factor-variable settings for each variable in
{it:varlist}.  {cmd:fvset} {cmd:clear} {cmd:_all} removes all factor-variable
settings from all variables.

{pstd}
{cmd:fvset} {cmd:report} reports the current factor-variable settings for each
variable in {it:varlist}.  {cmd:fvset} without arguments is a synonym for
{cmd:fvset} {cmd:report}.


{marker options}{...}
{title:Options}

{phang}
{opt base(base_spec)} restricts {cmd:fvset} {cmd:report} to report only the
factor-variable settings for variables with the specified {it:base_spec}.

{phang}
{opt design(design_spec)} restricts {cmd:fvset} {cmd:report} to report only
the factor-variable settings for variables with the specified
{it:design_spec}.


{marker examples}{...}
{title:Examples}

{pstd}
Setup
{p_end}
	{cmd:. sysuse auto}

{pstd}
By default, the first level is assumed to be the base
{p_end}
	{cmd:. regress mpg i.rep78}

{pstd}
Set 2 as the base level for {hi:rep78}
{p_end}
	{cmd:. fvset base 2 rep78}
	{cmd:. regress mpg i.rep78}

{pstd}
Set {hi:rep78} to have no base level, and fit a cell-means regression
{p_end}
	{cmd:. fvset base none rep78}
	{cmd:. regress mpg i.rep78, nocons}


{pstd}
By default, {helpb margins} accumulates a margin by using the observed
relative frequencies of the factor levels
{p_end}
	{cmd:. regress mpg i.foreign}
	{cmd:. margins}

{pstd}
Set {hi:foreign} to always accumulate using equal relative frequencies
{p_end}
	{cmd:. fvset design asbalanced foreign}
	{cmd:. regress mpg i.foreign}
	{cmd:. margins}

{pstd}
Report all the variables with the {opt frequent} base setting
{p_end}
	{cmd:. fvset report, base(frequent)}

{pstd}
Report all the variables with the {opt asbalanced} design setting
{p_end}
	{cmd:. fvset report, design(asbalanced)}

{pstd}
Technical note:
{p_end}
{pmore}
{cmd:margins} is aware of a factor variable's design setting only through the
estimation results it is working with.  The design setting is stored by the
estimation command; thus changing the design setting between the estimation
command and {cmd:margins} will have no effect.  For example, the output from
the following two calls to {cmd:margins} yields the same results.
{p_end}
	    {cmd:. fvset clear foreign}
	    {cmd:. regress mpg i.foreign}
	    {cmd:. margins}
	    {cmd:. fvset design asbalanced foreign}
	    {cmd:. margins}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:fvset} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:r(varlist)}}{it:varlist}{p_end}
{synopt:{cmd:r(baselist)}}base
	setting for each variable in {it:varlist}{p_end}
{synopt:{cmd:r(designlist)}}design
	setting for each variable in {it:varlist}{p_end}
