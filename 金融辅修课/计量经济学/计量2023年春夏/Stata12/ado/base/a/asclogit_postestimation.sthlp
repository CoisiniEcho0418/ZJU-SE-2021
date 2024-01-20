{smcl}
{* *! version 1.1.12  27jun2011}{...}
{viewerdialog predict "dialog asclogit_p"}{...}
{viewerdialog estat "dialog asclogit_estat"}{...}
{vieweralsosee "[R] asclogit postestimation" "mansection R asclogitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] asclogit" "help asclogit"}{...}
{viewerjumpto "Description" "asclogit postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "asclogit postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "asclogit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "asclogit postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat alternatives" "asclogit postestimation##syntax_estat_alternatives"}{...}
{viewerjumpto "Syntax for estat mfx" "asclogit postestimation##syntax_estat_mfx"}{...}
{viewerjumpto "Options for estat mfx" "asclogit postestimation##options_estat_mfx"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "asclogit postestimation##examples"}{...}
{viewerjumpto "Saved results" "asclogit postestimation##saved_results"}{...}
{title:Title}

{p2colset 5 36 38 2}{...}
{p2col :{manlink R asclogit postestimation} {hline 2}}Postestimation tools for 
asclogit{p_end} 
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:asclogit}:

{synoptset 20}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb asclogit postestimation##estatalt:estat alternatives}}alternative
	summary statistics{p_end}
{synopt :{helpb asclogit postestimation##estatmfx:estat mfx}}marginal
	effects{p_end}{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_hausman
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_nlcom
{synopt :{helpb asclogit postestimation##predict:predict}}predicted
probabilities, estimated linear predictor and its standard error{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd: estat alternatives} displays summary statistics about the alternatives
in the estimation sample.

{pstd}
{cmd: estat mfx} computes probability marginal effects.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic} {it:options}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvarlist}}{c )-}
{ifin}
{cmd:,} {opt sc:ores}

{synoptset 15 tabbed}{...}
{synopthdr:statistic}
{synoptline}
{syntab:Main}
{synopt :{opt p:r}}probability that each alternative is chosen; the default
{p_end}
{synopt :{opt xb}}linear prediction{p_end}
{synopt :{opt stdp}}standard error of the linear prediction{p_end}
{synoptline}

{synopthdr:options}
{synoptline}
{syntab:Main}
{p2coldent :* {cmd:k(}{it:#}|{cmd:observed)}}condition on {it:#} 
	alternatives per case or on observed number of alternatives{p_end}
{synopt :{opt altwise}}use alternativewise deletion instead of casewise
	deletion when computing probabilities{p_end}
{synopt :{opt nooff:set}}ignore the {cmd:offset()} variable specified in
	{cmd:asclogit}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
*{cmd:k(}{it:#}|{cmd:observed)} may be used only with {opt pr}.{p_end}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr} computes the probability of choosing each alternative conditioned
on each case choosing {opt k()} alternatives.
This is the default statistic with default {cmd:k(1)}; one alternative per 
case is chosen.

{phang} 
{opt xb} computes the linear prediction.

{phang}
{opt stdp} computes the standard error of the linear prediction.

{phang}
{cmd:k(}{it:#}|{cmd:observed)} condition the probability on 
{it:#} alternatives per case or on the observed number of alternatives.
The default is {cmd:k(1)}.  This option may be used only with the {cmd:pr}
option.

{phang}
{opt altwise} specifies that alternativewise deletion be used when
marking out observations due to missing values in your variables.  The default
is to use casewise deletion.  The {cmd:xb} and {cmd:stdp} options always use
alternativewise deletion.

{phang}
{opt nooffset} is relevant only if you specified {cmd:offset({varname})} for
{cmd:asclogit}. It modifies the calculations made by {cmd:predict} so that they
ignore the offset variable; the linear prediction is treated as {cmd:xb} rather
than as {cmd:xb} + {cmd:offset}.  

{phang}
{opt scores} calculates the scores for each coefficient in {cmd:e(b)}.
This option requires a new variable list of length equal to 
the number of columns in {cmd:e(b)}.  Otherwise, use the {it:stub}{cmd:*}
option to have {cmd:predict} generate enumerated variables with
prefix {it:stub}.


{marker syntax_estat_alternatives}{...}
{marker estatalt}{...}
{title:Syntax for estat alternatives}

{p 8 16 2}
{cmd:estat}
{opt alt:ernatives}


INCLUDE help menu_estat


{marker syntax_estat_mfx}{...}
{marker estatmfx}{...}
{title:Syntax for estat mfx}

{p 8 16 2}
{cmd:estat}
{opt mfx}
{ifin}
[{cmd:,} {it:options}]

{synoptset 35 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}

{synopt : {opth var:list(varlist)}}display marginal effects for
	{it:varlist}{p_end}
{synopt : {cmd:at(mean} [{it:{help asclogit postestimation##atlist:atlist}}]|{cmd:median} [{it:{help asclogit postestimation##atlist:atlist}}]{cmd:)}}calculate
	marginal effects at these values{p_end}
{synopt : {opt k(#)}}condition on the number of alternatives chosen to be {it:#}

{syntab:Options}
{synopt : {opt l:evel(#)}}set confidence interval level; default is 
	{cmd:level(95)}{p_end}
{synopt : {opt nodisc:rete}}treat indicator variables as continuous{p_end}
{synopt :{opt noe:sample}}do not restrict calculation of means and medians
	to the estimation sample{p_end}
{synopt :{opt now:ght}}ignore weights when calculating means and medians{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker options_estat_mfx}{...}
{title:Options for estat mfx}

{dlgtab:Main}

{phang}
{opth varlist(varlist)} specifies the variables for which to display marginal
	effects.  The default is all variables.

{* although the code is such that you can type at(mean), at(mean atlist),}{...}
{* at(median), at(median atlist), or just at(atlist); we are documenting}{...}
{* as such that you have to type either mean or median with atlist}{...}
{marker atlist}{...}
{phang}
{cmd:at(}{cmd:mean} [{it:atlist}]|{cmd:median} [{it:atlist}]{cmd:)}
specifies the values at which the marginal effects are to be calculated.
{it:atlist} is 

{pmore2}
[[{it:alternative}{cmd::}{it:variable} {cmd:=} {it:#}] [{it:variable} {cmd:=} {it:#}] [{it:alternative}{cmd::}{it:offset} {cmd:=} {it:#}] [...]]

{pmore}
The default is to calculate the marginal effects at the means of the independent
variables by using the estimation sample, {cmd:at(mean)}.  If {cmd:offset()}
is used during estimation, the means of the offsets (by alternative) are
computed by default.

{pmore}
After specifying the summary statistic, you can specify a series of specific
values for variables.  You can specify values for alternative-specific
variables by alternative, or you can specify one value for all alternatives.
You can specify only one value for case-specific variables.  You specify
values for the {cmd:offset()} variable (if present) the same way as for
alternative-specific variables.  For example, in the {cmd:choice} dataset (car
choice), {cmd:income} is a case-specific variable, whereas {cmd:dealer} is an
alternative-specific variable.  The following would be a legal syntax for
{cmd:estat mfx}:

{p 12 16 2}{cmd:. estat mfx, at(mean American:dealer=18 income=40)}{p_end}

{pmore}
When {opt nodiscrete} is not specified, {cmd:at(mean} [{it:atlist}]{cmd:)} or
{cmd:at(median} [{it:atlist}]{cmd:)} has no effect on computing marginal
effects for indicator variables, which are calculated as the discrete change
in the simulated probability as the indicator variable changes from 0 to 1.

{pmore}
The mean and median computations respect any {cmd:if} or {cmd:in}
qualifiers, so you can restrict the data over which the statistic is 
computed. You can even restrict the values to a specific case, for example, 

{p 12 16 2}{cmd:. estat mfx if case==21}{p_end}

{phang}
{opt k(#)} computes the probabilities conditioned on {it:#} alternatives
chosen.  The default is one alternative chosen.

{dlgtab:Options}

{phang}
{opt level(#)} sets the confidence level; default is {cmd:level(95)}.

{phang}
{opt nodiscrete} specifies that indicator variables be treated as continuous
variables.  An indicator variable is one that takes on the value 0 or 1 in the
estimation sample.  By default, the discrete change in the simulated
probability is computed as the indicator variable changes from 0 to 1.

{phang}
{opt noesample} specifies that the whole dataset be considered instead of only
those marked in the {cmd:e(sample)} defined by the {cmd:asclogit} command.

{phang}
{opt nowght} specifies that weights be ignored when calculating the medians.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse choice}{p_end}

{pstd}Fit alternative-specific logit model{p_end}
{phang2}{cmd:. asclogit choice dealer, case(id) alternatives(car)}
           {cmd:casevars(sex income)}{p_end}

{pstd}Predict probability each alternative is chosen{p_end}
{phang2}{cmd:. predict p if e(sample)}{p_end}

{pstd}Predict probability each alternative is chosen, conditional on each
case choosing two alternatives{p_end}
{phang2}{cmd:. predict p2, k(2)}{p_end}

{pstd}Obtain summary statistics about the alternatives{p_end}
{phang2}{cmd:. estat alt}{p_end}

{pstd}Obtain marginal effects assuming each person is female and there is one
dealership of each nationality in each city{p_end}
{phang2}{cmd:. estat mfx, varlist(sex income) at(sex=0 dealer=1)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{phang}
{cmd:estat mfx} saves the following in {opt r()}:


{phang}
{cmd: r(pr_}{it:alt}{opt )} scalars containing the computed probability
of each alternative evaluated at the value that is labeled X in the table
output.  Here {it:alt} are the labels in the macro {cmd:e(alteqs)}.

{phang}
{cmd: r(}{it:alt}{opt )} matrices containing the computed marginal effects and
associated statistics.  There is one matrix for each alternative, where
{it:alt} are the labels in the macro {cmd:e(alteqs)}.  Column 1 of each matrix
contains the marginal effects; column 2, their standard errors; column 3, their
z statistics; and columns 4 and 5, the confidence intervals.  Column 6 contains
the values of the independent variables used to compute the probabilities 
{cmd:r(pr_}{it:alt}{opt )}.
{p_end}
