{smcl}
{* *! version 1.0.7  11feb2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi reshape" "mansection MI mireshape"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi replace0" "help mi_replace0"}{...}
{vieweralsosee "[D] reshape" "help reshape"}{...}
{viewerjumpto "Syntax" "mi_reshape##syntax"}{...}
{viewerjumpto "Description" "mi_reshape##description"}{...}
{viewerjumpto "Options" "mi_reshape##options"}{...}
{viewerjumpto "Remarks" "mi_reshape##remarks"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{manlink MI mi reshape} {hline 2}}Reshape mi data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{marker overview}{...}
    Overview

{pmore}
{it}(The words {rm:long} and {rm:wide} in what follows have nothing to do 
with mi styles mlong, flong, flongsep, and wide; they have 
to do with reshape's concepts.){rm}

	       {it:long}
              {c TLC}{hline 12}{c TRC}                  {it:wide}
              {c |} {it:i  j}  {it:stub} {c |}                 {c TLC}{hline 16}{c TRC}
              {c |}{hline 12}{c |}                 {c |} {it:i}  {it:stub}{bf:1} {it:stub}{bf:2} {c |}
              {c |} 1  {bf:1}   4.1 {c |}     reshape     {c |}{hline 16}{c |}
              {c |} 1  {bf:2}   4.5 {c |}   <{hline 9}>   {c |} 1    4.1   4.5 {c |}
              {c |} 2  {bf:1}   3.3 {c |}                 {c |} 2    3.3   3.0 {c |}
              {c |} 2  {bf:2}   3.0 {c |}                 {c BLC}{hline 16}{c BRC}
              {c BLC}{hline 12}{c BRC}


	      To go from long to wide:

{col 52}{it:j} existing variable
{col 51}/
		    {cmd:mi reshape wide} {it:stub}{cmd:, i(}{it:i}{cmd:) j(}{it:j}{cmd:)}


	      To go from wide to long:

		    {cmd:mi reshape long} {it:stub}{cmd:, i(}{it:i}{cmd:) j(}{it:j}{cmd:)}
{col 51}\
{col 52}{it:j} new variable
	

{p 4 8 2}
Basic syntax

{phang2}
Convert mi data from long form to wide form

{p 12 16 2}
{cmd:mi reshape} {helpb mi reshape##overview:wide}
{it:stubnames}{cmd:,}
{cmd:i(}{varlist}{cmd:)}
{cmd:j(}{varname}{cmd:)}
[{it:options}]

{phang2}
Convert mi data from wide form to long form

{p 12 16 2}
{cmd:mi reshape} {helpb mi reshape##overview:long}
{it:stubnames}{cmd:,}
{cmd:i(}{varlist}{cmd:)}
{cmd:j(}{varname}{cmd:)}
[{it:options}]

{col 9}{it:options}{col 29}Description
{col 9}{hline 59}
{...}
{col 9}{cmd:i(}{varlist}{cmd:)}{...}
{col 29}{it:i} variable(s)

{col 9}{cmd:j(}{varname} [{it:values}]{cmd:)}{...}
{col 29}long->wide:  {it:j}, existing variable
{col 29}wide->long:  {it:j}, new variable
{col 29}optionally specify values to subset {it:j} 

{col 9}{cmdab:s:tring}{...}
{col 29}{it:j} is string variable (default numeric)
{col 9}{hline 59}

{col 9}where {it:values} is{...}
{col 29}{it:#}[{cmd:-}{it:#}] [...]{...}
{col 54}if {it:j} is numeric (default)
{col 29}{cmd:"}{it:string}{cmd:"} [{cmd:"}{it:string}{cmd:"} ...]{...}
{col 54}if {it:j} is string

{pmore}
and where {it:stubnames} are variable names (long->wide), or stubs of 
    variable names (wide->long), and either way, may contain {cmd:@}, denoting
    where {it:j} appears or is to appear in the name.

{pmore}
    In the example above, when we wrote "{cmd:mi} {cmd:reshape} {cmd:wide}
    {it:stub}", we could have written "{cmd:mi} {cmd:reshape} {cmd:wide}
    {it:stub}{cmd:@}" because {it:j} by default is used as a suffix.
    Had we written {it:stu}{cmd:@}{it:b}, then the wide variables would 
    have been named {it:stu}{cmd:1}{it:b} and {it:stu}{cmd:2}{it:b}.


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:reshape} is Stata's {cmd:reshape} for {cmd:mi} data;
see {bf:{help reshape:[D] reshape}}.


{marker options}{...}
{title:Options}

{p 4 8 2}
{cmd:noupdate}
    in some cases suppresses the automatic {cmd:mi} {cmd:update} this 
    command might perform; 
    see {bf:{help mi_noupdate_option:[MI] noupdate option}}.

{p 4 4 2}
See {bf:{help reshape:[D] reshape}} for descriptions of the other options.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The {cmd:reshape} command you specify is carried out on the {it:m}=0 data
and then the result is duplicated in {it:m}=1, {it:m}=2, ..., {it:m}={it:M}.
{p_end}
