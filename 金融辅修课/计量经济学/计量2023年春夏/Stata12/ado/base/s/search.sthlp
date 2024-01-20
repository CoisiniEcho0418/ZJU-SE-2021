{smcl}
{* *! version 1.2.3  07apr2011}{...}
{viewerdialog search "search_d"}{...}
{vieweralsosee "[R] search" "mansection R search"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{vieweralsosee "[R] hsearch" "help hsearch"}{...}
{vieweralsosee "[P] keyfiles" "help keyfiles"}{...}
{vieweralsosee "[R] net search" "help net"}{...}
{vieweralsosee "[R] sj" "help sj"}{...}
{vieweralsosee "[R] ssc" "help ssc"}{...}
{vieweralsosee "[U] 3.4 The Stata listserver" "help statalist"}{...}
{viewerjumpto "Syntax" "search##syntax"}{...}
{viewerjumpto "Description" "search##description"}{...}
{viewerjumpto "Options" "search##options"}{...}
{viewerjumpto "Option for set searchdefault" "search##options_searchdefault"}{...}
{viewerjumpto "Examples" "search##examples"}{...}
{viewerjumpto "Advice on using search" "search##advice"}{...}
{viewerjumpto "Looking up error messages" "search##error_msgs"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col:{manlink R search} {hline 2}}Search Stata documentation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:search}
{it:word}
[{it:word} {it:...}]
[{cmd:,}
{it:search_options}]

{p 8 11 2}
{cmd:set searchdefault}
{c -(}{opt local}|{opt net}|{opt all}{c )-}
[{cmd:,} {opt perm:anently}]

{p 8 15 2}
{cmd:findit}
{it:word}
[{it:word} {it:...}]

{synoptset 14}
{synopthdr:search_options}
{synoptline}
{synopt:{opt local}}search using Stata's keyword database; the default{p_end}
{synopt:{opt net}}search across materials available via Stata's {opt net}
command{p_end}
{synopt:{opt all}}search across both the local keyword database and the
{opt net} material{p_end}

{synopt:{opt a:uthor}}search by author's name{p_end}
{synopt:{opt ent:ry}}search by entry ID{p_end}
{synopt:{opt ex:act}}search across both the local keyword database and the
{opt net} materials; prevents matching on abbreviations{p_end}
{synopt:{opt faq}}search the FAQs posted to the Stata website{p_end}
{synopt:{opt h:istorical}}search entries that are of historical interest
only{p_end}
{synopt:{opt or}}list an entry if any of the words typed after {opt search}
are associated with the entry{p_end}
{synopt:{opt man:ual}}search the entries in the Stata Documentation{p_end}
{synopt:{opt sj}}search the entries in the Stata Journal and the
STB{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Help > Search...} 


{marker description}{...}
{title:Description}

{pstd}
{opt search} searches a keyword database and the Internet.

{pstd}
Capitalization of words following {opt search} is irrelevant, as is the
inclusion or exclusion of special characters such as commas and hyphens.

{pstd}
{opt set searchdefault} affects the default behavior of the {opt search}
command.  {opt local} is the default.

{pstd}
{opt findit} is equivalent to
{opt search} {it:word} [{it:word} {it:...}]{opt , all}.
{opt findit} results are displayed in the Viewer.
{opt findit} is the best way to search for information on a topic across
all sources, including the online help, the FAQs at the Stata website,
the {bf:Stata Journal}, and all Stata-related Internet sources
including user-written additions.  From {opt findit}, you can click to go to a
source or to install additions.

{pstd}
See {manhelp hsearch R} for a command that searches help files.


{marker options}{...}
{title:Options}

{phang}
{opt local}, the default (unless changed by {opt set searchdefault}),
specifies that the search be performed using only Stata's keyword database.

{phang}
{opt net} specifies that the search be performed across the materials
available via Stata's {opt net} command.  Using
{opt search} {it:word} [{it:word} {it:...}]{opt , net} is equivalent to typing
{opt net search} {it:word} [{it:word} {it:...}] (without options); see 
{manhelp net R}.

{phang}
{opt all} specifies that the search be performed across both the local keyword
database and the {opt net} materials.

{phang}
{opt author} specifies that the search be performed on the basis of the
author's name rather than keywords.  A search with the {opt author} option is
performed on the local keyword database only.

{phang}
{opt entry} specifies that the search be performed on the basis of entry
IDs rather than keywords.  A search with the {opt entry} option is performed
on the local keyword database only.

{phang}
{opt exact} prevents matching on abbreviations.  A search with the {opt exact}
option is performed across both the local keyword database and the {opt net}
materials.

{phang}
{opt faq} limits the search to the FAQs posted on the Stata website:
{browse "http://www.stata.com"}.  A search with the {opt faq} option is
performed on the local keyword database only.

{phang}
{opt historical} adds to the search entries that are of historical
interest only.  By default, such entries are not listed.  Past entries are
classified as historical if they discuss a feature that later became an official
part of Stata.  Updates to historical entries will always be found, even if
{opt historical} is not specified.  A search with the {opt historical} option
is performed on the local keyword database only.

{phang}
{opt or} specifies that an entry be listed if any of the words typed
after {opt search} are associated with the entry.  The default is to list the
entry only if all the words specified are associated with the entry.  A search
with the {opt or} option is performed on the local keyword database only.

{phang}
{opt manual} limits the search to entries in the Stata Documentation;
that is, the search is limited to the {it:User's Guide} and all the
reference manuals.  A search with the {opt manual} option is
performed on the local keyword database only.

{phang}
{opt sj} limits the search to entries in the {it:Stata Journal} and its
predecessor, the {it:Stata Technical Bulletin}; see {manhelp sj R}.  A search
with the {opt sj} option is performed on the local keyword database only.


{marker options_searchdefault}{...}
{title:Option for set searchdefault}

{phang}
{opt permanently} specifies that, in addition to making the change right now,
the {opt searchdefault} setting be remembered and become the default setting
when you invoke Stata.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. search kolmogorov-smirnov equality of distribution test}{p_end}
{phang}{cmd:. search normal distribution}{p_end}
{phang}{cmd:. search linear regression}{p_end}
{phang}{cmd:. search regression}{p_end}
{phang}{cmd:. search [R], entry}{p_end}
{phang}{cmd:. search STB-16, entry historical}{p_end}
{phang}{cmd:. search Salgado-Ugarte, author}


{marker advice}{...}
{title:Advice on using search}

{pstd}
See {help searchadvice} for details.


{marker error_msgs}{...}
{title:Looking up error messages}

{pstd}
In addition to serving as an index, {cmd:search} knows Stata's return codes
and can offer longer explanations than the commands issuing the errors do
themselves.  For instance, say that you use {cmd:test} and,

	{cmd:. test} {it:...}
	{err:not possible with test}
	{search r(131):r(131);}

{pstd}
131 is called the return code.  To obtain more information on 131, type

	{cmd:. search rc 131}
