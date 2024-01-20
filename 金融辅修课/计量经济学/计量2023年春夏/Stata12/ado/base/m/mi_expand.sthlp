{smcl}
{* *! version 1.0.7  31mar2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi expand" "mansection MI miexpand"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] expand" "help expand"}{...}
{viewerjumpto "Syntax" "mi_expand##syntax"}{...}
{viewerjumpto "Description" "mi_expand##description"}{...}
{viewerjumpto "Options" "mi_expand##options"}{...}
{viewerjumpto "Remarks" "mi_expand##remarks"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink MI mi expand} {hline 2}}Expand mi data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:mi expand}
[{cmd:=}] {it:{help exp}} [{help if}]
[{cmd:,} {it:options}]

{synoptset 18}{...}
{synopthdr}
{synoptline}
{synopt:{opth gen:erate(newvar)}}create {it:newvar}; 0=original,
   1=expanded{p_end}

{synopt:{cmdab:noup:date}}see {bf:{help mi_noupdate_option:[MI] noupdate option}}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:expand} is {bf:{help expand:expand}} for {cmd:mi} data.
The syntax is identical to {cmd:expand} except that {cmd:in} {it:range} is not
allowed and the {cmd:noupdate} option is allowed.

{p 4 4 2}
{cmd:mi} {cmd:expand} replaces each observation in the dataset with {it:n}
copies of the observation, where {it:n} is equal to the required expression
rounded to the nearest integer.  If the expression is less than 1 or equal to
missing, it is interpreted as if it were 1, meaning that the observation is
retained but not duplicated.


{marker options}{...}
{title:Options}

{p 4 8 2}
{opth generate(newvar)}
    creates new variable {it:newvar} containing 0 if the observation 
    originally appeared in the dataset and 1 if the observation is
    a duplication.

{p 4 8 2}
{cmd:noupdate}
    in some cases suppresses the automatic {cmd:mi} {cmd:update} this 
    command might perform; 
    see {bf:{help mi_noupdate_option:[MI] noupdate option}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:mi} {cmd:expand} amounts to performing {cmd:expand} on {it:m}=0, then
duplicating the result on {it:m}=1, {it:m}=2, ..., {it:m}={it:M}, and then
combining the result back into {cmd:mi} format.
Thus if the requested expansion specified by {it:exp} is a function of an
imputed, passive, varying, or super-varying variable, then it is the values 
of the variable in {it:m}=0 that will be used to produce the result 
for {it:m}=1, {it:m}=2, ..., {it:m}={it:M}, too.
{p_end}
