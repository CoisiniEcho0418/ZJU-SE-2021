{smcl}
{* *! version 1.0.1  07jul2011}{...}
{vieweralsosee "[SEM] sem path notation" "mansection SEM sempathnotation"}{...}
{vieweralsosee "[SEM] intro 2" "mansection SEM intro2"}{...}
{vieweralsosee "[SEM] intro 5" "mansection SEM intro5"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_path_notation##syntax"}{...}
{viewerjumpto "Description" "sem_path_notation##description"}{...}
{viewerjumpto "Options" "sem_path_notation##options"}{...}
{viewerjumpto "Remarks" "sem_path_notation##remarks"}{...}
{viewerjumpto "Examples" "sem_path_notation##examples"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col:{manlink SEM sem path notation} {hline 2}}Command syntax for path
diagrams{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {it:paths} {cmd:... }[{cmd:,} {opt covariance()} {opt variance()} 
{opt means()} [{opt group()}]]

{pstd}
{it:paths} specifies the direct paths between the variables of your model.

{pstd}
The model to be fit is fully described by {it:paths}, 
{opt covariance()}, {opt variance()}, and {opt means()}.

{pstd}
The syntax of these elements is modified (generalized) when option 
{opt group()} is specified.


{marker description}{...}
{title:Description}

{pstd}
The command syntax for describing your structural equation models is fully
specified by {it:paths}, {opt covariance()}, {opt variance()}, and 
{opt means()}.  How this works is described below.


{marker options}{...}
{title:Options}

{phang}
{opt covariance()} is used to

{phang2}
1.  specify that a particular covariance path of your model that usually is
assumed to be 0 be estimated,

{phang2}
2.  specify that a particular covariance path that usually is assumed to be
nonzero is not to be estimated (to be constrained to be 0),

{phang2}
3.  constrain a covariance path to a fixed value, such as 0, 0.5, 1, etc., and

{phang2}
4.  constrain two or more covariance paths to be equal.

{phang}
{opt variance()} does the same as {opt covariance()} except it does it with
variances.

{phang}
{opt means()} does the same as {opt covariance()} except it does it with
means.

{phang}
{opt group()} is mentioned here only because the syntax of {it:paths} and the
arguments of {opt covariance()}, {opt variance()}, and {opt means()} gains an
extra syntactical piece when {opt group()} is specified.


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

{phang2}
{help sem_path_notation##remark1: Model notation when option group() is not specified}{p_end}
{phang3}
{help sem_path_notation##basicsyntax: Basics of path notation}{p_end}
{phang3}
{help sem_path_notation##varcov: Specifying variances and covariances}{p_end}
{phang3}
{help sem_path_notation##means: Specifying means}{p_end}
{phang3}
{help sem_path_notation##constraints: Specifying constraints}{p_end}
{phang3}
{help sem_path_notation##intercepts: Specifying intercepts}{p_end}
{phang3}
{help sem_path_notation##initialvalues: Specifying starting values}{p_end}
{phang2}
{help sem_path_notation##remark2: Added syntax when option group() is specified}{p_end}
{phang3}
{help sem_path_notation##varypath: Specify a different path for a specific group value}{p_end}
{phang3}
{help sem_path_notation##varycovvar: Specify different covariance, variance, or mean for a specific group value}{p_end}


{marker remark1}{...}
{title:Model notation when option group() is not specified}

{pstd}
Path notation is used by the {cmd:sem} command to specify the model to be
estimated, for example,

{phang2}{cmd:. sem (x1 x2 x3 x4 <- X)}{p_end}

{phang2}{cmd:. sem (L1 -> x1 x2 x3 x4 x5)}
{cmd: (L2 -> x6 x7 x8 x9 x10)}{p_end}


{marker basicsyntax}{...}
{space 4}{title:Basics of path notation}

{pstd}
In the path notation,

{phang}
1.  Latent variables are indicated by a {it:name} in which at least the first
letter is capitalized.

{phang}
2.  Observed variables are indicated by a {it:name} in which at least the first
letter is lowercased.  Observed variables correspond to variable names in the
dataset.

{phang}
3.  Error variables, while mathematically a special case of latent variables,
are considered in a class by themselves.  Every endogenous variable (whether
observed or latent) automatically has an error variable associated with it.
The error variable associated with endogenous variable {it:name} is
{cmd:e.}{it:name}.

{phang}
4.  Paths between variables are written as

{phang3}{cmd:(}{it:name1} {cmd: <- } {it:name2}{cmd:)}{p_end}

{p 8 8 2}
or

{phang3}{cmd:(}{it:name2} {cmd: -> } {it:name1}{cmd:)}{p_end}

{p 8 8 2}
There is no significance to which coding is used.

{phang}
5.  Paths between the same variables can be combined: The paths

{phang3}{cmd:(}{it:name1}{cmd: <- }{it:name2}{cmd:) (}{it:name1}
{cmd: <- }{it:name3}{cmd:)}{p_end}

{p 8 8 2}
can be combined as

{phang3}{cmd:(}{it:name1} {cmd: <- }{it:name2 name3}{cmd:)}{p_end}

{p 8 8 2}
or as

{phang3}{cmd:(}{it:name2 name3} {cmd: ->  }{it:name1}{cmd:)}{p_end}

{p 8 8 2}
The paths

{phang3}{cmd:(}{it:name1 <- name3}{cmd:) (}{it:name2} {cmd: <- }
{it:name3}{cmd:)}{p_end}

{p 8 8 2}
can be combined as

{phang3}{cmd:(}{it:name1 name2} {cmd: <- } {it:name3}{cmd:)}{p_end}


{marker varcov}{...}
{space 4}{title:Specifying variances and covariances}

{phang}
6.  Variances and covariances (curved paths) between variables are indicated
by options.  Variances are indicated by

{phang3}{cmd:..., ... var(}{it:name1}{cmd:)}{p_end}

{p 8 8 2}
Covariances are indicated by

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:)}{p_end}

{phang3}{cmd:..., ... cov(}{it:name2}{cmd:*}{it:name1}{cmd:)}{p_end}

{p 8 8 2}
There is no significance to the order of the names.

{p 8 8 2}
The actual names of the options are {opt variance()} and {opt covariance()},
but they are invariably abbreviated.

{p 8 8 2}
The {opt var()} and {opt cov()} options are the same option, so a variance can
be typed as

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:)}{p_end}

{p 8 8 2}
and a covariance can be typed as

{phang3}{cmd:..., ... var(}{it:name1}{cmd:*}{it:name2}{cmd:)}{p_end}

{phang}
7.  Variances may be combined, covariances may be combined, and variances and
covariances may be combined.

{p 8 8 2}
If you have
 
{phang3}{cmd:..., ... var(}{it:name1}{cmd:) var(}{it:name2}{cmd:)}{p_end}

{p 8 8 2}
you may code this as

{phang3}{cmd:..., ... var(}{it:name1 name2}{cmd:)}{p_end}

{p 8 8 2}
If you have

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:) cov(}{it:name2}{cmd:*}{it:name3}{cmd:)}{p_end}

{p 8 8 2}
you may code this as

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2 name2}{cmd:*}{it:name3}{cmd:)}{p_end}

{p 8 8 2}
All of the above combined can be coded as

{phang3}{cmd:..., ... var(}{it:name1 name2 name1}{cmd:*}{it:name2 name2}{cmd:*}{it:name3}{cmd:)}{p_end}

{p 8 8 2}
or as

{phang3}{cmd:..., ... cov(}{it:name1 name2 name1}{cmd:*}{it:name2 name2}{cmd:*}{it:name3}{cmd:)}{p_end}

{phang}
8.  All variables except endogenous variables are assumed to have a variance;
it is only necessary to code the {cmd:var()} option if you wish to place a
constraint on the variance or specify an initial value.  See items 11, 12,
13, and 16 below.

{p 8 8 2}
Endogenous variables have a variance, of course, but that is the variance
implied by the model.  If {it:name} is an endogenous variable,
then {cmd:var(}{it:name}{cmd:)} is invalid.  The error variance of the
endogenous variable is {cmd:var(e.}{it:name}{cmd:)}.

{phang}
9.  Variables mostly default to being correlated:

{phang3}
a.  All exogenous variables are assumed to be correlated with each other,
whether observed or latent.

{phang3}
b.  Endogenous variables are never directly correlated, although their
associated error variables can be.

{phang3}
c.  All error variables are assumed to be uncorrelated with each other.

{p 8 8 2}
You can override these defaults on a variable-by-variable basis using the
{cmd:cov()} option.

{p 8 8 2}
To assert that two variables are uncorrelated that otherwise would be assumed
to be correlated, constrain the covariance to be 0:

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:@0)}{p_end}

{p 8 8 2}
To allow two variables to be correlated that otherwise would be assumed to be
uncorrelated, simply specify the existence of the covariance:

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:)}{p_end}

{p 8 8 2}
This latter is especially commonly done with errors:

{phang3}{cmd:..., .. cov(e.}{it:name1}{cmd:*e.}{it:name2}{cmd:)}{p_end}


{marker means}{...}
{space 4}{title:Specifying means}

{phang}
10.  Means of variables are indicated by option:

{phang3}{cmd:..., ... means(}{it:name}{cmd:)}{p_end}

{p 8 8 2}
Variables mostly default to having nonzero means:

{phang2}
a.  All observed exogenous variables are assumed to have nonzero means.
The means can be constrained using the {cmd:means()} option, but only if you are
performing {cmd:noxconditional} estimation; see {helpb sem_option_noxconditional:[SEM] sem noxconditional option}.

{phang2}
b.  Latent exogenous variables are assumed to have mean 0.  Means of latent
variables are not estimated by default.  If you specify enough normalization
constraints to identify the mean of a latent exogenous variable, you can
specify {opt means(Name)} to indicate that the mean should be estimated.

{phang2}
c.  Endogenous variables have no separate mean.  Their means are those based
on the model.  Option {cmd:means()} may not be used with endogenous variables.

{phang2}
d.  Error variables have mean 0 and this cannot be modified.  Option
{cmd:means()} may not be used with error variables.

{p 8 8 2}
To constrain the mean to a fixed value, such as 57, code

{phang3}{cmd:..., ... means(}{it:name}{cmd:@57)}{p_end}

{p 8 8 2}
Separate {cmd:means()} options may be combined:

{phang3}{cmd:..., ... means(}{it:name1}{cmd:@57} {it:name2}{cmd:@100)}{p_end}


{marker constraints}{...}
{space 4}{title:Specifying constraints}

{p 3 8 2}
11.  Fixed-value constraints may be specified for a path, variance, covariance, or mean by using {cmd:@} (the at sign).  For example, {p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@1)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@1} {it:name3}{cmd:@1)}{p_end}

{phang3}{cmd:..., ... var(}{it:name}{cmd:@100)}{p_end}

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:@223)}{p_end}

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:@1} {it:name2}{cmd:@1} {it:name1}{cmd:*}{it:name2}{cmd:@.8)}{p_end}

{phang3}{cmd:..., ... means(}{it:name}{cmd:@57)}{p_end}

{p 3 8 2}
12.  Symbolic constraints may be specified for a path, variance, covariance, or mean by using {cmd:@} (the at sign).  For example,

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@}{it:c1}{cmd:) (}{it:name3}
{cmd:<-} {it:name4}{cmd:@}{it:c1}{cmd:)}{p_end}

{phang3}{cmd:..., ... var(}{it:name1}{cmd:@}{it:c1}
{it:name2}{cmd:@}{it:c1}{cmd:) cov(}{it:name1}{cmd:@1} {it:name2}{cmd:@1}
{it:name3}{cmd:@1} {it:name1}{cmd:*}{it:name2}{cmd:@}{it:c2}
{it:name1}{cmd:*}{it:name3}{cmd:@}{it:c2}{cmd:)}{p_end}

{phang3}{cmd:..., ... means(}{it:name1}{cmd:@}{it:c1} {it:name2}{cmd:@}{it:c1}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@}{it:c1}{cmd:) ..., var(}{it:name3}{cmd:@}{it:c1}{cmd:) means(}{it:name4}{cmd:@}{it:c1}{cmd:)}{p_end}

{p 8 8 2}
Symbolic names are just names from 1 to 32 characters in length.  Symbolic
constraints constrain equality.  For simplicity, all constraints below will
have the notation {it:c1}, {it:c2}, ... 

{p 3 8 2}
13.  Linear combinations of symbolic constraints may be specified for
a path, variance, covariance, or mean by using {cmd:@} (the at sign).  For
example,

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@}{it:c1}{cmd:) (}{it:name3} {cmd:<-}
{it:name4}{cmd:@(2*}{it:c1}{cmd:))}{p_end}

{phang3}{cmd:..., ... var(}{it:name1}{cmd:@}{it:c1} {it:name2}{cmd:@(}{it:c1}{cmd:/2))}{p_end}

{phang3}{cmd:..., ... cov(}{it:name1}{cmd:@1} {it:name2}{cmd:@1}
{it:name3}{cmd:@1} {it:name1}{cmd:*}{it:name2}{cmd:@}{it:c1}
{it:name1}{cmd:*}{it:name3}{cmd:@(}{it:c1}{cmd:/2))}{p_end}

{phang3}{cmd:..., ... means(}{it:name1}{cmd:@}{it:c1} {it:name2}{cmd:@(3*}{it:c1}{cmd:+10))}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:@(}{it:c1}{cmd:/2)) ..., var(}{it:name3}{cmd:@}{it:c1}{cmd:) means(}{it:name4}{cmd:@(2*}{it:c1}{cmd:))}{p_end}


{marker intercepts}{...}
{space 4}{title:Specifying intercepts}

{p 3 8 2}
14.  All equations in the model are assumed to have an intercept (to include
observed exogenous variable {cmd:_cons}) unless the {cmd:noconstant} option
(abbreviation {cmd:nocon}) is specified, and then all equations are assumed
not to have an intercept (not to include {cmd:_cons}).

{p 8 8 2}
Regardless of whether {cmd:noconstant} is specified, you may explicitly refer to
observed exogenous variable {cmd:_cons}.

{p 8 8 2}
The following path specifications are ways of writing the same model:

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:) (}{it:name1} {cmd:<-} {it:name3}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:) (}{it:name1} {cmd:<-} {it:name3}{cmd:) (}{it:name1} {cmd:<-} {cmd:_cons)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3} {cmd:_cons)}{p_end}

{p 8 8 2}
There is no reason to explicitly specify {cmd:_cons} unless (1) you have also
specified option {cmd:noconstant} and want to include {cmd:_cons} in some
equations but not others, or (2) regardless of whether you specified option
{cmd:noconstant}, you wish to place a constraint on its path coefficient.  For
example,

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3} {cmd:_cons@}{it:c1}{cmd:) (}{it:name4} {cmd:<-} {it:name5} {cmd:_cons@}{it:c1}{cmd:)}{p_end}

{p 3 8 2}
15.  The {cmd:noconstant} option may be specified globally or within a path
specification.  That is,

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3}{cmd:) (}{it:name4} {cmd:<-} {it:name5}{cmd:), nocon}{p_end}

{p 8 8 2}
suppresses the intercepts in both equations. Alternatively,

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3}{cmd:, nocon) (}{it:name4} {cmd:<-} {it:name5}{cmd:)}{p_end}

{p 8 8 2}
suppresses the intercept in the first equation but not the second, whereas

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3}{cmd:) (}{it:name4} {cmd:<-} {it:name5}{cmd:, nocon)}{p_end}

{p 8 8 2}
suppresses the intercept in the second equation but not the first.  In
addition, consider the equation

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2} {it:name3}{cmd:, nocon)}{p_end}

{p 8 8 2}
This can be written equivalently as

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:, nocon) (}{it:name1} {cmd:<-} {it:name3}{cmd:, nocon)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:, nocon) (}{it:name1} {cmd:<-} {it:name3}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {it:name2}{cmd:) (}{it:name1} {cmd:<-} {it:name3}{cmd:, nocon)}{p_end}


{marker initialvalues}{...}
{space 4}{title:Specifying starting values}

{p 3 8 2}
16.  Initial values (starting values) may be specified for a path,
variance, covariance, or mean by using the {opt init(#)} suboption:

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:, init(0)))}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:, init(0))} {it:name3}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:, init(0)) (}{it:name3}{cmd:, init(5)))}{p_end}

{phang3}{cmd: ..., ... var((}{it:name3}{cmd:, init(1)))}{p_end}

{phang3}{cmd:..., ... cov((}{it:name4}{cmd:*}{it:name5}{cmd:, init(.5)))}{p_end}

{phang3}{cmd:..., ... means((}{it:name5}{cmd:, init(0)))}{p_end}

{p 8 8 2}
The initial values may be combined with symbolic constraints:

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:@}{it:c1}{cmd:, init(0)))}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:@}{it:c1}{cmd:, init(0))} {it:name3}{cmd:)}{p_end}

{phang3}{cmd:(}{it:name1} {cmd:<-} {cmd:(}{it:name2}{cmd:@}{it:c1}{cmd:, init(0)) (}{it:name3}{cmd:@}{it:c2}{cmd:, init(5)))}{p_end}

{phang3}{cmd:..., ... var((}{it:name3}{cmd:@}{it:c1}{cmd:, init(1)))}{p_end}

{phang3}{cmd:..., ... cov((}{it:name4}{cmd:*}{it:name5}{cmd:@}{it:c1}{cmd:, init(.5)))}{p_end}

{phang3}{cmd:..., ... means((}{it:name5}{cmd:@}{it:c1}{cmd:, init(0)))}{p_end}

{pstd}
The above fully describes {it:paths} and the arguments of options
{cmd:means()}, {cmd:variance()}, and {cmd:covariance()} in the case when the 
{cmd:group()} option is not specified.


{marker remark2}{...}
{title:Added syntax when option group() is specified}

{pstd}
The model you wish to fit is fully described by the {it:paths},
{cmd:covariance()}, {cmd:variance()}, and {cmd:means()} that you type. 

{pstd}
The {opt group(varname)} option,

{phang3}{cmd:. sem ..., ... }{opt group(varname)}{p_end}

{pstd}
specifies that the model be estimated separately for the different
values of {it:varname}.  {it:varname} might be {cmd:sex} and then the model
would be fitted separately for males and females, or {it:varname} might be
something else and perhaps take on more than two values.

{pstd}
Whatever {it:varname} is, {opt group(varname)} defaults to letting some of the
path coefficients, covariances, variances, and means of your model vary across
the groups and constrains others to be equal.  Which parameters vary and
which are constrained is described in {helpb sem_group_options:[SEM] sem group options}, but that is a minor detail right now.

{pstd}
In what follows, we will assume that {it:varname} is {cmd:mygrp} and takes on
three values.  Those values are 1, 2, and 3, but they could just as well be 2,
9, and 12.

{pstd}
Consider typing 

{phang3}{cmd:. sem ..., ...}{p_end}

{pstd}
and typing 
 
{phang3}{cmd:. sem ..., ... group(mygrp)}{p_end}

{pstd}
Whatever the {it:paths}, {cmd:covariance()}, {cmd:variance()}, and
{cmd:means()} are that describe the model, there are now three times as many
parameters because each group has its own unique set.  In fact, when you give
the second command, you are not merely asking for three times the parameters,
you are specifying three models, one for each group!  In this case you
specified the same model three times without knowing it.


{marker varypath}{...}
{space 4}{title:Specify a different path for a specific group value}

{pstd}
You can vary the model specified across groups. 

{phang}
1.  Let's write the model you wish to fit as 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:)}{p_end}

{p 8 8 2}
where {it:a}, {it:b}, ..., {it:f} stand for what you type.  In this
generic example, we have two {cmd:cov()} options just because multiple {cmd:cov()} options often occur in real models.  When you type 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
Results are as if you typed 

{phang3}{cmd:. sem (1: }{it:a}{cmd:) (2: }{it:a}{cmd:) (3: }{it:a}{cmd:)  ///}{p_end}
{p 18 16 2}{cmd: (1: }{it:b}{cmd:) (2: }{it:b}{cmd:) (3: }{it:b}{cmd:)  ///}{p_end}
{p 18 16 2}{cmd: (1: }{it:c}{cmd:) (2: }{it:c}{cmd:) (3: }{it:c}{cmd:), ///}{p_end}
{p 18 16 2}{cmd: cov(1: }{it:d}{cmd:) cov(2: }{it:d}{cmd:) cov(3: }{it:d}{cmd:) ///}{p_end}
{p 18 16 2}{cmd: cov(1: }{it:e}{cmd:) cov(2: }{it:e}{cmd:) cov(3: }{it:e}{cmd:) ///}{p_end}
{p 18 16 2}{cmd: var(1: }{it:f}{cmd:) cov(2: }{it:f}{cmd:) cov(3: }{it:f}{cmd:)  group(mygrp)}{p_end}

{p 8 8 2}
The {cmd:1:}, {cmd:2:}, and {cmd:3:} identify the groups for which paths,
covariances, or variances are being added, modified, or constrained.  

{p 8 8 2}
If {cmd:mygrp} contained the unique values 5, 8, and 10 instead of 1, 2, and
3, then {cmd:5:} would appear in place of {cmd:1:}; {cmd:8:} would appear in
place of {cmd:2:}; and {cmd:10:} would appear in place of {cmd:3:}.

{phang}
2.  Consider the model 

{phang3}{cmd:. sem (y <- x) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
If you wanted to constrain the path coefficient {cmd:(y <- x)} to be the same
across all three groups, you could type 

{phang3}{cmd:. sem (y <- x@}{it:c1}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
See (12) above for more examples of specifying constraints.  This works
because the expansion of {cmd:(y <- x@}{it:c1}{cmd:)} is 

{phang3}{cmd:(1: y <- x@}{it:c1}{cmd:) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:)}{p_end}

{phang}
3.  Consider the model 

{phang3}{cmd:. sem (y <- x) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
If you wanted to constrain the path coefficient {cmd:(y <- x}) to be the same in
groups 2 and 3, you could type

{phang3}{cmd:. sem (1: y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{phang}
4.  Instead of (3), you could type

{phang3}{cmd:. sem (y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
The part {cmd:(y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:)}
expands to 

{phang3}{cmd:(1: y <- x) (2: y <- x) (3: y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:) }{p_end}

{p 8 8 2}
and thus the path is defined twice for group 2 and twice for group 3.  When a
path is defined more than once, the definitions are combined.  In this case,
the second definition adds more information, so the result is as if you
typed 

{phang3}{cmd:(1: y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:)}{p_end}

{phang}
5.  Instead of (3) or (4), you could type 

{phang3}{cmd:. sem (y <- x@}{it:c1}{cmd:) (1: y <- x@}{it:c2}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
The part {cmd:(y <- x@}{it:c1}{cmd:) (1: y <- x@}{it:c2}{cmd:)} expands to 

{phang3}{cmd:(1: y <- x@}{it:c1}{cmd:)  (2: y <- x@}{it:c1}{cmd:)  (3: y <- x@}{it:c1}{cmd:) (1: y <- x@}{it:c2}{cmd:)}{p_end}

{p 8 8 2}
When results are combined from repeated definitions, definitions that appear
later take precedence.  In this case results are as if the expansion read 

{phang3}{cmd:(1: y <- x@}{it:c2}{cmd:) (2: y <- x@}{it:c1}{cmd:)  (3: y <- x@}{it:c1}{cmd:) }{p_end}
             
{p 8 8 2}
Thus coefficients for groups 2 and 3 are constrained.  The group-1 coefficient
is constrained to {it:c2}.  If {it:c2} appears nowhere else in the model
specification, then results are as if the path for group 1 were unconstrained.

{phang}
6.  Instead of (3), (4), or (5), you could {it:not} type

{phang3}{cmd:. sem (y <- x@}{it:c1}{cmd:) (1: y <- x) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(}{it:d}{cmd:) cov(}{it:e}{cmd:) var(}{it:f}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
The expansion of {cmd:(y <- x@}{it:c1}{cmd:) (1: y <- x)} reads

{phang3}{cmd:(1: y <- x@}{it:c1}{cmd:)  (2: y <- x@}{it:c1}{cmd:)  (3: y <- x@}{it:c1}{cmd:) (1: y <- x)}{p_end}

{p 8 8 2}
and you might think that {cmd:2: y <- x} would replace {cmd:1: y <- x@}{it:c1}{cmd:}.
Information, however, is combined, and even though precedence is given to
information appearing later, silence does not count as information.  Thus, the
expanded and reduced specification reads the same as if {cmd:1: y <- x} was
never specified:

{phang3}{cmd:(1: y <- x@}{it:c1}{cmd:)  (2: y <- x@}{it:c1}{cmd:)  (3: y <- x@}{it:c1}{cmd:) }{p_end}


{marker varycovvar}{...}
{space 4}{title:Specify a different covariance, variance, or mean for a specific group value}

{phang}
7.  Items (1)-(6), stated in terms of {it:paths}, apply equally to what is
typed inside the {cmd:means()}, {cmd:variance()}, and {cmd:covariance()}
options.  For instance, if you typed

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), var(e.y@}{it:c1}{cmd:) group(mygrp) }{p_end}

{p 8 8 2}
then you are constraining the variance to be equal across all three groups.

{p 8 8 2}
If you wanted to constrain the variance to be equal in groups 2 and 3, you
could type

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), var(e.y) var(2: e.y@}{it:c1}{cmd:) var(3: e.y@}{it:c1}{cmd:), group(mygrp) }{p_end}

{p 8 8 2}
You could omit typing {cmd:var(e.y)} because it is implied.  Alternatively,
you could type 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), var(e.y@}{it:c1}{cmd:) var(1: e.y@}{it:c2}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
You could {it:not} type 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), var(e.y@}{it:c1}{cmd:) var(1: e.y) group(mygrp)}{p_end}

{p 8 8 2}
because silence does not count as information when specifications are combined.

{p 8 8 2}
Similarly, if you typed, 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(e.y1*e.y2@}{it:c1}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
then you are constraining the covariance to be equal across all groups.  If
you wanted to constrain the covariance to be equal in groups 2 and 3, you
could type 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(e.y1*e.y2) cov(2: e.y1*e.y2@}{it:c1}{cmd:) cov(3: e.y1*e.y2@}{it:c1}{cmd:) group(mygrp)}{p_end}

{p 8 8 2}
You could not omit {cmd:cov(e.y1*e.y2)} because it is not assumed.  By default
error variables are assumed to be uncorrelated.  Omitting the option would
constrain the covariance to be 0 in group 1, and to be equal in groups 2
and 3.

{p 8 8 2}
Alternatively, you could type 

{phang3}{cmd:. sem (}{it:a}{cmd:) (}{it:b}{cmd:) (}{it:c}{cmd:), cov(e.y1*e.y2@}{it:c1}{cmd:) cov(1: e.y1*e.y2@}{it:c2}{cmd:) group(mygrp)}{p_end}

{phang}
8.  In the examples above, we have referred to the groups
using their numeric values, 1, 2, and 3.  Had the values been 5, 8, and 10,
then we would have used those values.

{p 8 8 2}
If the group variable {cmd:mygrp} has a value label, you can use the label to
refer to the group.  For instance, imagine {cmd:mygrp} is labeled as follows:

{phang3}{cmd:. label define grpvals 1 Male  2 Female  3 "Unknown sex"}{p_end}

{phang3}{cmd:. label values mygrp grpvals}{p_end}

{p 8 8 2}
We could type 

{phang3}{cmd:. sem (y <- x) (Female: y <- x@}{it:c1}{cmd:) (Unknown sex: y <- x@}{it:c1}{cmd:) ..., ...}{p_end}

{p 8 8 2}
or we could type 

{phang3}{cmd:. sem (y <- x) (2: y <- x@}{it:c1}{cmd:) (3: y <- x@}{it:c1}{cmd:) ..., ...}{p_end}


{marker examples}{...}
{title:Examples}

{title:Examples: Basic path notation}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}A simple regression model{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length)}{p_end}

{pstd}Same model as above{p_end}
{phang2}{cmd:. sem (mpg <- turn ) (mpg <- trunk) (mpg <- length)}{p_end}

{pstd}Constrain constant to be zero{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length _cons@0)}{p_end}

{pstd}Same as above, but with the {opt noconstant} option{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length), noconstant}{p_end}

{pstd}Specify groups{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length), group(foreign)}{p_end}

{pstd}Alternative notation to above{p_end}
{phang2}{cmd:. sem (0: mpg <- turn trunk length)}{break}
	{cmd: (1: mpg <- turn trunk length), group(foreign)}{p_end}


{title:Examples: Specifying the covariance() and variance() options}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_sm1}{p_end}

{pstd}Fit a nonrecursive structural model{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd:(f_occasp <- r_occasp f_intel f_ses r_ses)}{p_end}

{pstd}Estimate the error covariance between {cmd:r_occasp} and {cmd:f_occasp}{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd:(f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd: covariance(e.r_occasp*e.f_occasp)}{p_end}

{pstd}Constrain error variance of {cmd:r_occasp} and {cmd:f_occasp} to be
equal{p_end}
{phang2}{cmd:. sem (r_occasp <- f_occasp r_intel r_ses f_ses)}{break}
	{cmd: (f_occasp <- r_occasp f_intel f_ses r_ses),}{break}
	{cmd: variance(e.r_occasp@a e.f_occasp@a)}{p_end}


{title:Examples: Specifying the means() option}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Fit a recursive structural model{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length) (trunk <- price)}{p_end}

{pstd}Display fitted means of exogenous variables{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length) (trunk <- price),}{break}
	{cmd: means(turn length price)}{p_end}

{pstd}Constrain the mean of {cmd:length} to be {cmd:180}{p_end}
{phang2}{cmd:. sem (mpg <- turn trunk length) (trunk <- price),}{break}
	{cmd: means(length@180)}{p_end}
