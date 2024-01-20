{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog pkcross "dialog pkcross"}{...}
{vieweralsosee "[R] pkcross" "mansection R pkcross"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] pk" "help pk"}{...}
{viewerjumpto "Syntax" "pkcross##syntax"}{...}
{viewerjumpto "Description" "pkcross##description"}{...}
{viewerjumpto "Options" "pkcross##options"}{...}
{viewerjumpto "Remarks" "pkcross##remarks"}{...}
{viewerjumpto "Examples" "pkcross##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R pkcross} {hline 2}}Analyze crossover experiments{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:pkcross} {it:outcome} {ifin} [{cmd:,} {it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Model}
{synopt :{opth seq:uence(varname)}}sequence variable; default is
{cmd:sequence(sequence)}{p_end}
{synopt :{opth tr:eatment(varname)}}treatment variable; default is
{cmd:treatment(treat)}{p_end}
{synopt :{opth per:iod(varname)}}period variable; default is
{cmd:period(period)}{p_end}
{synopt :{opth id(varname)}}ID variable{p_end}
{synopt :{opth car:ryover(varname)}}name of carryover variable; default is
{cmd:carryover(carry)}{p_end}
{synopt :{opt car:ryover}{cmd:(none)}}omit carryover effects from model;
default is {cmd:carryover(carry)}{p_end}
{synopt :{opth m:odel(strings:string)}}specify the model to fit{p_end}
{synopt :{opt se:quential}}estimate sequential instead of partial sums of
squares{p_end}

{syntab :Parameterization}
{synopt :{opt p:aram}{cmd:(3)}}estimate mean and the period, treatment, and
sequence effects; assume no carryover effects exist; the default{p_end}
{synopt :{opt p:aram}{cmd:(1)}}estimate mean and the period, treatment, and
carryover effects; assume no sequence effects exist{p_end}
{synopt :{opt p:aram}{cmd:(2)}}estimate mean, period, treatment, and
period-by-treatment interaction; assume no sequence or carryover effects
exist{p_end}
{synopt :{opt p:aram}{cmd:(4)}}estimate mean, period, treatment, and
period-by-treatment interaction; assume no period or crossover effects
exist{p_end}
{synoptline} 
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Epidemiology and related > Other >}
     {bf:Analyze crossover experiments}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pkcross} analyzes data from a crossover design experiment.  When
analyzing pharmaceutical trial data, if the treatment, carryover, and sequence
variables are known, the omnibus test for separability of the treatment and
carryover effects is calculated.

{pstd}
{cmd:pkcross} is one of the pk commands.  Please read {helpb pk} before reading
this entry.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opth sequence(varname)} specifies the variable that contains the sequence in
which the treatment was administered.  If this option is not specified,
{cmd:sequence(sequence)} is assumed.

{phang}
{opth treatment(varname)} specifies the variable that contains the treatment
information.  If this option is not specified, {cmd:treatment(treat)} is
assumed.

{phang}
{opth period(varname)} specifies the variable that contains the period
information.  If this option is not specified, {cmd:period(period)} is
assumed.

{phang}
{opth id(varname)} specifies the variable that contains the subject
identifiers.  If this option is not specified, {cmd:id(id)} is assumed.

{phang}
{opt carryover}{cmd:(}{varname}{c |}{cmd:none}{cmd:)} specifies the variable
that contains the carryover information.  If {cmd:carry(none)} is specified,
the carryover effects are omitted from the model.  If this option is not
specified, {cmd:carryover(carry)} is assumed.

{phang}
{opth model:(strings:string)} specifies the model to be fit.  For higher-order
crossover designs, this opton can be useful if you want to fit a model other
than the default.  However, {helpb anova} can also be used to fit a crossover
model.  The default model for higher-order crossover designs is outcome
predicted by sequence, period, treatment, and carryover effects.  By default,
the model statement is {cmd:model(sequence period treat carry)}.

{phang}
{opt sequential} specifies that sequential sums of squares be estimated.

{dlgtab:Parameterization}

{phang}
{opt param(#)} specifies which of the four parameterizations to use for the
analysis of a 2 x 2 crossover experiment.  This option is ignored with
higher-order crossover designs.  The default is {cmd:param(3)}.  
See the 
{mansection R pkcrossRemarkstechnote:technical note} in {bf:[R] pkcross} for
{bind:2 x 2} crossover designs for more details.

{pmore}
{cmd:param(3)} estimates the overall mean, the period effects, the treatment
effects, and the sequence effects, assuming that no carryover effects exist.
This is the default parameterization.

{pmore}
{cmd:param(1)} estimates the overall mean, the period effects, the
treatment effects, and the carryover effects, assuming that no sequence
effects exist.

{pmore}
{cmd:param(2)} estimates the overall mean, the period effects, the treatment
effects, and the period-by-treatment interaction, assuming that no sequence
or carryover effects exist.

{pmore}
{cmd:param(4)} estimates the overall mean, the sequence effects, the treatment
effects, and the sequence-by-treatment interaction, assuming that no period or
crossover effects exist.  When the sequence by treatment is equivalent to the
period effect, this reduces to the third parameterization.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:pkcross} is designed to analyze crossover experiments.  Use 
{helpb pkshape} first to reshape your data.  {cmd:pkcross} assumes that the
data were reshaped by {cmd:pkshape} or are organized in the same manner as
produced with {cmd:pkshape}.  Washout periods are indicated by the number 0.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. webuse pkdata3}{p_end}
{phang}{cmd:. pkcross outcome}{p_end}
{phang}{cmd:. pkcross outcome, carryover(none)} (omit carryover effects){p_end}
{phang}{cmd:. pkcross outcome, param(2)}{p_end}
