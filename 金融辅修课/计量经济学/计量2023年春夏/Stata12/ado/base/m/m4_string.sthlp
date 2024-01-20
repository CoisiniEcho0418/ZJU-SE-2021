{smcl}
{* *! version 1.3.3  11feb2011}{...}
{vieweralsosee "[M-4] string" "mansection M-4 string"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] intro" "help m4_intro"}{...}
{viewerjumpto "Contents" "m4_string##contents"}{...}
{viewerjumpto "Description" "m4_string##description"}{...}
{viewerjumpto "Remarks" "m4_string##remarks"}{...}
{title:Title}

{phang}
{manlink M-4 string} {hline 2} String manipulation functions


{marker contents}{...}
{title:Contents}

{col 5}   [M-5]
{col 5}Manual entry{col 22}Function{col 37}Purpose
{col 5}{hline}

{col 5}   {c TLC}{hline 9}{c TRC}
{col 5}{hline 3}{c RT}{it: Parsing }{c LT}{hline}
{col 5}   {c BLC}{hline 9}{c BRC}

{col 7}{bf:{help mf_tokens:tokens()}}{...}
{col 22}{cmd:tokens()}{...}
{col 37}obtain tokens (words) from string

{col 7}{bf:{help mf_invtokens:invtokens()}}{...}
{col 22}{cmd:invtokens()}{...}
{col 37}concatenate string vector into string
{col 37}scalar

{col 7}{bf:{help mf_strmatch:strmatch()}}{...}
{col 22}{cmd:strmatch()}{...}
{col 37}pattern matching

{col 7}{bf:{help mf_tokenget:tokenget()}}{...}
{col 22}...{...}
{col 37}advanced parsing

{col 5}   {c TLC}{hline 19}{c TRC}
{col 5}{hline 3}{c RT}{it: Length & position }{c LT}{hline}
{col 5}   {c BLC}{hline 19}{c BRC}

{col 7}{bf:{help mf_strlen:strlen()}}{...}
{col 22}{cmd:strlen()}{...}
{col 37}length of string

{col 7}{bf:{help mf_fmtwidth:fmtwidth()}}{...}
{col 22}{cmd:fmtwidth()}{...}
{col 37}width of {cmd:%}{it:fmt}

{col 7}{bf:{help mf_strpos:strpos()}}{...}
{col 22}{cmd:strpos()}{...}
{col 37}find substring within string

{col 7}{bf:{help mf_indexnot:indexnot()}}{...}
{col 22}{cmd:indexnot()}{...}
{col 37}find character not in list

{col 5}   {c TLC}{hline 9}{c TRC}
{col 5}{hline 3}{c RT}{it: Editing }{c LT}{hline}
{col 5}   {c BLC}{hline 9}{c BRC}

{col 7}{bf:{help mf_substr:substr()}}{...}
{col 22}{cmd:substr()}{...}
{col 37}extract substring

{col 7}{bf:{help mf_strupper:strupper()}}{...}
{col 22}{cmd:strupper()}{...}
{col 37}convert to uppercase
{col 22}{cmd:strlower()}{...}
{col 37}convert to lowercase
{col 22}{cmd:strproper()}{...}
{col 37}convert to proper case

{col 7}{bf:{help mf_strtrim:strtrim()}}{...}
{col 22}{cmd:stritrim()}{...}
{col 37}replace multiple, consecutive internal blanks
{col 37}with one blank
{col 22}{cmd:strltrim()}{...}
{col 37}remove leading blanks
{col 22}{cmd:strrtrim()}{...}
{col 37}remove trailing blanks
{col 22}{cmd:strtrim()}{...}
{col 37}remove leading and trailing blanks

{col 7}{bf:{help mf_subinstr:subinstr()}}{...}
{col 22}{cmd:subinstr()}{...}
{col 37}substitute text
{col 22}{cmd:subinword()}{...}
{col 37}substitute word

{col 7}{bf:{help mf__substr:_substr()}}{...}
{col 22}{cmd:_substr()}{...}
{col 37}substitute into string

{col 7}{bf:{help mf_strdup:strdup()}}{...}
{col 22}{cmd:*}{...}
{col 37}duplicate string

{col 7}{bf:{help mf_strreverse:strreverse()}}{...}
{col 22}{cmd:strreverse()}{...}
{col 37}reverse string

{col 7}{bf:{help mf_soundex:soundex()}}{...}
{col 22}{cmd:soundex()}{...}
{col 37}convert to soundex code
{col 22}{cmd:soundex_nara()}{...}
{col 37}convert to U.S. Census soundex code

{col 5}   {c TLC}{hline 7}{c TRC}
{col 5}{hline 3}{c RT}{it: Stata }{c LT}{hline}
{col 5}   {c BLC}{hline 7}{c BRC}

{col 7}{bf:{help mf_abbrev:abbrev()}}{...}
{col 22}{cmd:abbrev()}{...}
{col 37}abbreviate strings

{col 7}{bf:{help mf_strtoname:strtoname()}}{...}
{col 22}{cmd:strtoname()}{...}
{col 37}translate strings to Stata names

{col 5}   {c TLC}{hline 19}{c TRC}
{col 5}{hline 3}{c RT}{it: ASCII translation }{c LT}{hline}
{col 5}   {c BLC}{hline 19}{c BRC}

{col 7}{bf:{help mf_strofreal:strofreal()}}{...}
{col 22}{cmd:strofreal()}{...}
{col 37}convert real to string

{col 7}{bf:{help mf_strtoreal:strtoreal()}}{...}
{col 22}{cmd:strtoreal()}{...}
{col 37}convert string to real

{col 7}{bf:{help mf_ascii:ascii()}}{...}
{col 22}{cmd:ascii()}{...}
{col 37}obtain ASCII codes of string
{col 22}{cmd:char()}{...}
{col 37}make string from ASCII codes

{col 5}{hline}


{marker description}{...}
{title:Description}

{p 4 4 2}
The above functions are for manipulating strings.  Strings in Mata are 
strings of ASCII characters, usually the printable characters, but Mata 
enforces no such restriction.  In particular, strings may contain 
binary 0.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
In addition to the above functions, two operators are especially useful 
for dealing with strings.

{p 4 4 2}
The first is {cmd:+}.  Addition is how you concatenate strings:

	: {cmd:"abc" + "def"}
	{res:abcdef}

	: {cmd:command = "list"}
	: {cmd:args = "mpg weight"}
	: {cmd:result = command + " " + args}
	: {cmd:result}
	{res:list mpg weight}

{p 4 4 2}
The second is {cmd:*}.  Multiplication is how you duplicate strings:

	: {cmd:5*"a"}
	{res:aaaaa}

	: {cmd:"b"*3}
	{res:bbb}

	: {cmd:indent = 20}
	: {cmd:title = indent*" " + "My Title"}
	: {cmd:title}
        {res:                    My Title}
