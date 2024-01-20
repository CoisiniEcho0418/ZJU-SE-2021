{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-2] intro" "mansection M-2 intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-0] intro" "help mata"}{...}
{viewerjumpto "Contents" "m2_intro##contents"}{...}
{viewerjumpto "Description" "m2_intro##description"}{...}
{viewerjumpto "Remarks" "m2_intro##remarks"}{...}
{title:Title}

{phang}
{manlink M-2 intro} {hline 2} Language definition


{marker contents}{...}
{title:Contents}

	[M-2] entry{col 25}Description
	{hline 68}

{col 8}   {c TLC}{hline 8}{c TRC}
{col 8}{hline 3}{c RT}{it: Syntax }{c LT}{hline}
{col 8}   {c BLC}{hline 8}{c BRC}

	{bf:{help m2_syntax:syntax}}{col 25}Grammar and syntax

	{bf:{help m2_subscripts:subscripts}}{col 25}Use of subscripts

	{bf:{help m2_reswords:reswords}}{col 25}Reserved words

	{bf:{help m2_comments:comments}}{col 25}Comments

{col 8}   {c TLC}{hline 25}{c TRC}
{col 8}{hline 3}{c RT}{it: Expressions & operators }{c LT}{hline}
{col 8}   {c BLC}{hline 25}{c BRC}

	{bf:{help m2_exp:exp}}{col 25}Expressions

	{bf:{help m2_op_assignment:op_assignment}}{col 25}Assignment operator

	{bf:{help m2_op_arith:op_arith}}{col 25}Arithmetic operators

	{bf:{help m2_op_increment:op_increment}}{col 25}Increment and decrement operators

	{bf:{help m2_op_logical:op_logical}}{col 25}Logical operators

	{bf:{help m2_op_conditional:op_conditional}}{col 25}Conditional operator

	{bf:{help m2_op_colon:op_colon}}{col 25}Colon operators

	{bf:{help m2_op_join:op_join}}{col 25}Row- and column-join operators

	{bf:{help m2_op_range:op_range}}{col 25}Range operators

	{bf:{help m2_op_transpose:op_transpose}}{col 25}Conjugate transpose operator

	{bf:{help m2_op_kronecker:op_kronecker}}{col 25}Kronecker direct-product operator

{col 8}   {c TLC}{hline 26}{c TRC}
{col 8}{hline 3}{c RT}{it: Declarations & arguments }{c LT}{hline}
{col 8}   {c BLC}{hline 26}{c BRC}

	{bf:{help m2_declarations:declarations}}{col 25}Declarations and types

	{bf:{help m2_optargs:optargs}}{col 25}Optional arguments

	{bf:{help m2_struct:struct}}{col 25}Structures

	{bf:{help m2_class:class}}{col 25}Classes

	{bf:{help m2_pragma:pragma}}{col 25}Suppressing warning messages

	{bf:{help m2_doppelganger:doppelganger}}{col 25}{...}
Library double of built-in function

	{bf:{help m2_version:version}}{col 25}Version control

{col 8}   {c TLC}{hline 17}{c TRC}
{col 8}{hline 3}{c RT}{it: Flow of control }{c LT}{hline}
{col 8}   {c BLC}{hline 17}{c BRC}

	{bf:{help m2_if:if}}{col 25}{...}
{cmd:if (}{it:exp}{cmd:)} ... {cmd:else} ...

	{bf:{help m2_for:for}}{col 25}{...}
{cmd:for (}{it:exp1}{cmd:;} {it:exp2}{cmd:;} {it:exp3}{cmd:)} {it:stmt}

	{bf:{help m2_while:while}}{col 25}{...}
{cmd:while (}{it:exp}{cmd:)} {it:stmt}

	{bf:{help m2_do:do}}{col 25}{...}
{cmd:do} ... {cmd:while (}{it:exp}{cmd:)}

	{bf:{help m2_break:break}}{col 25}{...}
Break out of {cmd:for}, {cmd:while}, or {cmd:do} loop

	{bf:{help m2_continue:continue}}{col 25}{...}
Continue with next iteration of {cmd:for}, {cmd:while}, or {cmd:do} loop

	{bf:{help m2_goto:goto}}{col 25}{cmd:goto} {it:label}

	{bf:{help m2_return:return}}{col 25}{...}
{cmd:return} and {cmd:return(}{it:exp}{cmd:)}

{col 8}   {c TLC}{hline 16}{c TRC}
{col 8}{hline 3}{c RT}{it: Special topics }{c LT}{hline}
{col 8}   {c BLC}{hline 16}{c BRC}

	{bf:{help m2_semicolons:semicolons}}{col 25}Use of semicolons

	{bf:{help m2_void:void}}{col 25}Void matrices

	{bf:{help m2_pointers:pointers}}{col 25}Pointers

	{bf:{help m2_ftof:ftof}}{col 25}Passing functions to functions

{col 8}   {c TLC}{hline 13}{c TRC}
{col 8}{hline 3}{c RT}{it: Error codes }{c LT}{hline}
{col 8}   {c BLC}{hline 13}{c BRC}

	{bf:{help m2_errors:errors}}{col 25}Error codes

	{hline 68}


{marker description}{...}
{title:Description}

{p 4 4 2}
This section defines the Mata programming language.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{bf:{help m2_syntax:[M-2] syntax}} provides an overview, dense and brief,
and the other sections expand on it.

{p 4 4 2}
Also see 
{bf:{help m1_intro:[M-1] intro}} for an introduction to Mata.
{p_end}
