{smcl}
{* *! version 1.3.12  03may2011}{...}
{viewerdialog svyset "dialog svyset"}{...}
{vieweralsosee "[SVY] svyset" "mansection SVY svyset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] survey" "help survey"}{...}
{vieweralsosee "[SVY] svy" "help svy"}{...}
{vieweralsosee "[SVY] svydescribe" "help svydescribe"}{...}
{viewerjumpto "Syntax" "svyset##syntax"}{...}
{viewerjumpto "Description" "svyset##description"}{...}
{viewerjumpto "Options" "svyset##options"}{...}
{viewerjumpto "Examples" "svyset##examples"}{...}
{viewerjumpto "Saved results" "svyset##saved_results"}{...}
{viewerjumpto "Reference" "svyset##reference"}{...}
{title:Title}

{pstd}
{manlink SVY svyset} {hline 2} Declare survey design for dataset


{marker syntax}{...}
{title:Syntax}

{pstd}
Single-stage design

{p 8 15 2}
{cmd:svyset}  [{it:{help svyset##psu:psu}}] {weight}
	[{cmd:,} {it:design_options} {it:options}]


{pstd}
Multiple-stage design

{p 8 15 2}
{cmd:svyset} {it:{help svyset##psu:psu}} {weight} [{cmd:,} {it:design_options}] [{cmd:||} {it:{help svyset##ssu:ssu}}
{cmd:,} {it:design_options}] ... [{it:options}]


{pstd}
Clear the current settings

{p 8 15 2}
{cmd:svyset}{cmd:,} {opt clear}


{pstd}
Report the current settings

{p 8 15 2}
{cmd:svyset}


{marker design_options}{...}
{synoptset 26 tabbed}{...}
{synopthdr:design_options}
{synoptline}
{syntab:Main}
{synopt :{opth str:ata(varname)}}variable identifying strata{p_end}
{synopt :{opth fpc(varname)}}finite population correction{p_end}
{synoptline}

{synopthdr:options}
{synoptline}
{syntab:Weights}
{synopt :{opth brr:weight(varlist)}}balanced
	repeated replicate (BRR) weights{p_end}
{synopt :{opt fay(#)}}Fay's adjustment{p_end}
{synopt :{opth bsr:weight(varlist)}}bootstrap replicate weights{p_end}
{synopt :{opt bsn(#)}}bootstrap mean-weight adjustment{p_end}
{synopt :{cmdab:jkr:weight(}{varlist}{cmd:,} ...{cmd:)}}jackknife replicate weights{p_end}
{synopt :{cmdab:sdr:weight(}{varlist}{cmd:,} ...{cmd:)}}successive
	difference replicate (SDR) weights{p_end}

{syntab:SE}
{synopt :{cmd:vce(}{opt linear:ized}{cmd:)}}Taylor
	linearized variance estimation{p_end}
{synopt :{cmd:vce(bootstrap)}}bootstrap variance estimation{p_end}
{synopt :{cmd:vce(brr)}}BRR variance estimation{p_end}
{synopt :{cmd:vce(}{opt jack:knife}{cmd:)}}jackknife
	variance estimation{p_end}
{synopt :{cmd:vce(sdr)}}SDR variance estimation{p_end}
{synopt :{opt dof(#)}}design degrees of freedom{p_end}
{synopt :{opt mse}}use
	the MSE formula with {cmd:vce(bootstrap)}, {cmd:vce(brr)},
	{cmd:vce(jackknife)}, or {cmd:vce(sdr)}{p_end}
{synopt :{opt single:unit(method)}}strata with a single sampling unit;
	{it:method} may be {opt mis:sing}, {opt cer:tainty}, {opt sca:led}, or
	{opt cen:tered} {p_end}

{syntab:Poststratification}
{synopt:{opth posts:trata(varname)}}variable identifying poststrata{p_end}
{synopt:{opth postw:eight(varname)}}poststratum population sizes{p_end}

{synopt:{opt clear}}clear all settings from the data{p_end}
{synopt:{opt noclear}}change
	some of the settings without clearing the others{p_end}
{synopt:{opt clear(opnames)}}clear
	the specified settings without clearing all others; {it:opnames} may
	be one or more of {opt w:eight}, {opt vce}, {opt dof}, {opt mse},
	{opt bsr:weight}, {opt brr:weight}, {opt jkr:weight},
	{opt sdr:weight},
	or {opt post:strata}{p_end}
{synoptline}
{p 4 6 2}
{cmd:pweight}s and {cmd:iweight}s are allowed; see {help weights}.
{p_end}
{p 4 6 2}
The full specification for {opt jkrweight()} is
{p_end}
{phang2}
{opt jkr:weight}{cmd:(}{it:varlist}
	[{cmd:,}
		{opt str:atum}{cmd:(}{it:#} [{it:#} ...]{cmd:)}
		{opt fpc}{cmd:(}{it:#} [{it:#} ...]{cmd:)}
		{opt mult:iplier}{cmd:(}{it:#} [{it:#} ...]{cmd:)}
		{opt reset}
	]{cmd:)}
{p_end}
{p 4 6 2}
The full specification for {opt sdrweight()} is
{p_end}
{phang2}
{opt sdr:weight}{cmd:(}{it:varlist} [{cmd:,} {opt fpc(#)}]{cmd:)}
{p_end}
{p 4 6 2}
{opt clear}, {opt noclear}, and {opt clear()} are not shown in the dialog box.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Survey data analysis > Setup and utilities >}
      {bf:Declare survey design for dataset}


{marker description}{...}
{title:Description}

{pstd}
{cmd:svyset} declares the data to be complex survey data, designates variables
that contain information about the survey design, and specifies the default
method for variance estimation.  You must {cmd:svyset} your data before using
any {cmd:svy} command; see {manhelp svy_estimation SVY:svy estimation}.

{marker psu}{...}
{pstd}
{it:psu} is {cmd:_n} or the name of a variable (numeric or string) that
contains identifiers for the primary sampling units (clusters).  Use {cmd:_n}
to indicate that individuals (instead of clusters) were randomly sampled if
the design does not involve clustered sampling.  In the single-stage syntax,
{it:psu} is optional and defaults to {cmd:_n}.

{marker ssu}{...}
{pstd}
{it:ssu} is {cmd:_n} or the name of a variable (numeric or string) that
contains identifiers for sampling units (clusters) at the subsequent stages of
the survey design.  Use {cmd:_n} to indicate that individuals were randomly
sampled within the last sampling stage.

{pstd}
Settings made by {cmd:svyset} are saved with a dataset.  So, if a dataset is
saved after it has been {cmd:svyset}, it does not have to be set again.

{pstd}
The current settings are reported when {cmd:svyset} is called without
arguments:

	{cmd:. svyset}

{pstd}
Use the {opt clear} option to remove the current settings:

	{cmd:. svyset, clear}

{pstd}
See {manlink SVY poststratification} for a discussion with examples using
the {opt poststrata()} and {opt postweight()} options.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth strata(varname)} specifies the name of a variable (numeric or string)
that contains stratum identifiers.

{phang}
{opth fpc(varname)} requests a finite population correction for the variance
estimates.  If {it:varname} has values less than or equal to 1, it is
interpreted as a stratum sampling rate {it:f}_{it:h} =
{it:n}_{it:h}/{it:N}_{it:h}, where {it:n}_{it:h} = number of units sampled
from stratum {it:h} and {it:N}_{it:h} = total number of units in the
population belonging to stratum {it:h}.  If {it:varname} has values
greater than or equal to {it:n}_{it:h}, it is interpreted as containing
{it:N}_{it:h}.  It is an error for {it:varname} to have values between 1 and
{it:n}_{it:h} or to have a mixture of sampling rates and stratus sizes.

{dlgtab:Weights}

{phang}
{opth brrweight(varlist)} specifies the replicate-weight variables to be used
with {cmd:vce(brr)} or with {cmd:svy} {cmd:brr}.

{phang}
{opt fay(#)} specifies Fay's adjustment ({help svyset##J1990:Judkins 1990}).
The value specified in {opt fay(#)} is used to adjust the BRR weights and is
present in the BRR variance formulas.

{pmore}
The sampling weight of the selected PSUs for a given replicate is multiplied
by {hi:2-}{it:#}, where the sampling weight for the unselected PSUs is
multiplied by {it:#}.  When {opt brrweight(varlist)} is specified, the
replicate-weight variables in {it:varlist} are assumed to be
adjusted using {it:#}.

{pmore}
{cmd:fay(0)} is the default and is equivalent to the original BRR method.
{it:#} must be between 0 and 2, inclusive, and excluding 1.
{cmd:fay(1)} is not allowed because this results in unadjusted weights.

{phang}
{opth bsrweight(varlist)} specifies the replicate-weight variables to be used
with {cmd:vce(bootstrap)} or with {cmd:svy} {cmd:bootstrap}.

{phang}
{opt bsn(#)} specifies that {it:#} bootstrap replicate-weight variables were
used to generate each bootstrap mean-weight variable specified in the
{opt bsrweight()} option.  The default is {cmd:bsn(1)}.
The value specified in {opt bsn(#)} is used to 
adjust the variance estimate to account for mean bootstrap weights.

{phang}
{cmd:jkrweight(}{varlist}{cmd:,} ...{cmd:)} specifies the replicate-weight
variables to be used with {cmd:vce(jackknife)} or with {cmd:svy}
{cmd:jackknife}.

{pmore}
The following options set characteristics on the jackknife replicate-weight
variables.
If one value is specified, all the specified jackknife
replicate-weight variables will be supplied with the same characteristic.
If multiple values are specified, each replicate-weight variable will
be supplied with the corresponding value according to the order specified.
These options are not shown in the dialog box.

{phang2}
{opt stratum(# [# ...])} specifies an identifier for
the stratum in which the sampling weights have been adjusted.

{phang2}
{opt fpc(# [# ...])} specifies the FPC value to
be added as a characteristic of the jackknife replicate-weight variables.
The values set by this suboption have the same interpretation as the
{opth fpc(varname)} option.

{phang2}
{opt multiplier(# [# ...])} specifies the value of a
jackknife multiplier to be added as a characteristic of the jackknife
replicate-weight variables.

{phang2}
{opt reset} indicates that the characteristics for the replicate-weight
variables may be overwritten or reset to the default, if they exist.

{phang}
{cmd:sdrweight(}{varlist}{cmd:,} ...{cmd:)} specifies the replicate-weight
variables to be used with {cmd:vce(sdr)} or with {cmd:svy} {cmd:sdr}.

{phang2}
{opt fpc(#)} specifies the FPC value associated with the SDR weights.
The value set by this suboption has the same interpretation as the
{opth fpc(varname)} option.
This option is not shown in the dialog box.

{dlgtab:SE}

{phang}
{opt vce(vcetype)} specifies the default method for variance estimation; see
{manlink SVY variance estimation}.

{phang2}
{cmd:vce(linearized)} sets the default to Taylor linearization.

{phang2}
{cmd:vce(bootstrap)} sets the default to the bootstrap; also see
{manhelp svy_bootstrap SVY:svy bootstrap}.

{phang2}
{cmd:vce(brr)} sets the default to BRR; also see
{manhelp svy_brr SVY:svy brr}.

{phang2}
{cmd:vce(jackknife)} sets the default to the jackknife;
see {manhelp svy_jackknife SVY:svy jackknife}.

{phang2}
{cmd:vce(sdr)} sets the default to SDR; also see
{manhelp svy_sdr SVY:svy sdr}.

{phang}
{opt dof(#)} specifies the design degrees of freedom, overriding the default
calculation, df = N_psu - N_strata.

{phang}
{opt mse} specifies that the MSE formula be used when {cmd:vce(bootstrap)},
{cmd:vce(brr)}, {cmd:vce(jackknife)}, or {cmd:vce(sdr)}
is specified.  This option requires {cmd:vce(bootstrap)},
{cmd:vce(brr)}, {cmd:vce(jackknife)}, or {cmd:vce(sdr)}.

{phang}
{opt singleunit(method)} specifies how to handle strata with one sampling
unit.

{phang2}
{cmd:singleunit(missing)} results in missing values for the standard errors
and is the default.

{phang2}
{cmd:singleunit(certainty)} causes strata with single sampling units to be
treated as certainty units.  Certainty units contribute nothing to the
standard error.

{phang2}
{cmd:singleunit(scaled)} results in a scaled version of
{cmd:singleunit(certainty)}.  The scaling factor comes from using the average
of the variances from the strata with multiple sampling units for each stratum
with one sampling unit.

{phang2}
{cmd:singleunit(centered)} specifies that strata with one sampling
unit are centered at the grand mean instead of the stratum mean.

{dlgtab:Poststratification}

{phang}
{opth poststrata(varname)} specifies the name of the variable
(numeric or string) that contains poststratum identifiers.

{phang}
{opth postweight(varname)} specifies the name of the numeric
variable that contains poststratum population totals (or sizes),
that is, the number of elementary sampling units in the population within each
poststratum.

{pstd}
The following options are available with {cmd:svyset} but are not shown in the
dialog box:

{phang}
{opt clear} clears all the settings from the data.  Typing

{pmore2}
{cmd:. svyset, clear}

{pmore}
clears the survey design characteristics from the data in memory.  Although
this option may be specified with some of the other {cmd:svyset} options, it
is redundant because {cmd:svyset} automatically clears the previous settings
before setting new survey design characteristics.

{phang}
{opt noclear} allows some of the options in {it:options} to be changed
without clearing all the other settings.  This option is not allowed with
{it:{help svyset##psu:psu}}, {it:{help svyset##ssu:ssu}}, 
{it:{help svyset##design_options:design_options}}, or {opt clear}.

{phang}
{opt clear(opnames)} allows some of the options in {it:options} to
be cleared without clearing all the other settings.  {it:opnames}
refers to an option name and may be one or more of the following:

{pmore2}
{opt weight}{space 2}
{opt vce}{space 2}
{opt dof}{space 2}
{opt mse}{space 2}
{opt brrweight}{space 2}
{opt bsrweight}{space 2}
{opt jkrweight}{space 2}
{opt sdrweight}{space 2}
{opt poststrata}

{pmore}
This option implies the {opt noclear} option.


{marker examples}{...}
{title:Examples}

{pstd}
Setup
{p_end}
{phang2}
{cmd:. webuse stage5a}
{p_end}

{pstd}
Simple random sampling with replacement
{p_end}
{phang2}
{cmd:. svyset _n}
{p_end}

{pstd}
One-stage clustered design with stratification
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], strata(strata)}
{p_end}

{pstd}
Two-stage designs
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], fpc(fpc1) || _n, fpc(fpc2)}
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], fpc(fpc1) || su2, fpc(fpc2)}
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], fpc(fpc1) || su2, fpc(fpc2) strata(strata)}
{p_end}

{pstd}
Multiple-stage designs
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], fpc(fpc1) strata(strata) || su2, fpc(fpc2) || su3, fpc(fpc3)}
{p_end}
{phang2}
{cmd:. svyset su1 [pweight=pw], fpc(fpc1) strata(strata) || su2, fpc(fpc2) || su3, fpc(fpc3) || _n}
{p_end}

{pstd}
Finite population correction (FPC)
{p_end}
{phang2}
{cmd:. webuse fpc}
{p_end}
{phang2}
{cmd:. list}
{p_end}
{phang2}
{cmd:. svyset psuid [pweight=weight], strata(stratid) fpc(Nh)}
{p_end}
{phang2}
{cmd:. svy: mean x}
{p_end}
{phang2}
{cmd:. svyset psuid [pweight=weight], strata(stratid)}
{p_end}
{phang2}
{cmd:. svy: mean x}
{p_end}

{pstd}
Multiple-stage designs and with-replacement sampling
{p_end}
{phang2}
{cmd:. webuse stage5a}
{p_end}
{phang2}
{cmd:. svyset su1 || _n, fpc(fpc2)}
{p_end}

{pstd}
Replication weight variables
{p_end}
{phang2}
{cmd:. webuse stage5a_jkw}
{p_end}
{phang2}
{cmd:. svyset [pweight=pw], jkrweight(jkw_*) vce(jackknife)}
{p_end}
{phang2}
{cmd:. svyset [pweight=pw], jkrweight(jkw_*) vce(jackknife) mse}
{p_end}

{pstd}In your web browser, download the following data from the CDC website{p_end}
{pmore}
{browse "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2001-2002/BPX_B.xpt":ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2001-2002/BPX_B.xpt}{break}
{browse "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2001-2002/DEMO_B.xpt":ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/nhanes/2001-2002/DEMO_B.xpt}{p_end}

{pstd}Rename the files{p_end}
{pmore}
{cmd:. copy BPX_B.xpt bpx_b.xpt}{break}
{cmd:. copy DEMO_B.xpt demo_b.xpt}

{pstd}
Combining datasets from multiple surveys
{p_end}
{phang2}
{cmd:. import sasxport bpx_b.xpt}
{p_end}
{phang2}
{cmd:. sort seqn}
{p_end}
{phang2}
{cmd:. save bpx01_02}
{p_end}
{phang2}
{cmd:. import sasxport demo_b.xpt}
{p_end}
{phang2}
{cmd:. drop wtint?yr}
{p_end}
{phang2}
{cmd:. sort seqn}
{p_end}
{phang2}
{cmd:. merge 1:1 seqn using bpx01_02}
{p_end}
{phang2}
{cmd:. svyset sdmvpsu [pw=wtmec2yr], strata(sdmvstra)}
{p_end}
{phang2}
{cmd:. save bpx01_02, replace}
{p_end}
{phang2}
{cmd:. use bpx99_00}
{p_end}
{phang2}
{cmd:. drop wt?rep*}
{p_end}
{phang2}
{cmd:. append using bpx01_02}
{p_end}
{phang2}
{cmd:. drop wtmec2yr}
{p_end}
{phang2}
{cmd:. svyset sdmvpsu [pw=wtmec4yr], strata(sdmvstra)}
{p_end}
{phang2}
{cmd:. save bpx99_02}
{p_end}
{phang2}
{cmd:. svy jackknife: mean bpxsar}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:svyset} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(stages)}}number of sampling stages{p_end}

{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:r(wtype)}}weight type{p_end}
{synopt:{cmd:r(wexp)}}weight expression{p_end}
{synopt:{cmd:r(wvar)}}weight variable name{p_end}
{synopt:{cmd:r(su}{it:#}{cmd:)}}variable identifying sampling units for stage
                          {it:#}{p_end}
{synopt:{cmd:r(strata}{it:#}{cmd:)}}variable identifying strata for stage {it:#}{p_end}
{synopt:{cmd:r(fpc}{it:#}{cmd:)}}FPC for stage {it:#}{p_end}
{synopt:{cmd:r(brrweight)}}{cmd:brrweight()} variable list{p_end}
{synopt:{cmd:r(fay)}}Fay's adjustment{p_end}
{synopt:{cmd:r(bsrweight)}}{cmd:bsrweight()} variable list{p_end}
{synopt:{cmd:r(bsn)}}bootstrap mean-weight adjustment{p_end}
{synopt:{cmd:r(jkrweight)}}{cmd:jkrweight()} variable list{p_end}
{synopt:{cmd:r(sdrweight)}}{cmd:sdrweight()} variable list{p_end}
{synopt:{cmd:r(sdrfpc)}}{cmd:fpc()} value from within {opt sdrweight()}{p_end}
{synopt:{cmd:r(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:r(dof)}}{opt dof()} value{p_end}
{synopt:{cmd:r(mse)}}{cmd:mse}, if specified{p_end}
{synopt:{cmd:r(poststrata)}}{cmd:poststrata()} variable{p_end}
{synopt:{cmd:r(postweight)}}{cmd:postweight()} variable{p_end}
{synopt:{cmd:r(settings)}}{cmd:svyset} arguments to reproduce the current
settings{p_end}
{synopt:{cmd:r(singleunit)}}{cmd:singleunit()} setting{p_end}


{marker reference}{...}
{title:Reference}

{marker J1990}{...}
{phang}
Judkins, D. R. 1990. Fay's method for variance estimation.
{it:Journal of Official Statistics} 6: 223-239.
{p_end}
