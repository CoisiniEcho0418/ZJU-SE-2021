{smcl}
{* *! version 2.1.2  11feb2011}{...}
{findalias asgsmviewer}{...}
{findalias asgsuviewer}{...}
{findalias asgswviewer}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "net_mnu" "net_mnu"}{...}
{vieweralsosee "[R] news" "help news"}{...}
{vieweralsosee "[R] search" "help search"}{...}
{vieweralsosee "[R] hsearch" "help hsearch"}{...}
{vieweralsosee "searchadvice" "searchadvice"}{...}
{vieweralsosee "[R] update" "help update"}{...}
{vieweralsosee "[R] view" "help view"}{...}
{viewerjumpto "Description" "help_advice##description"}{...}
{viewerjumpto "Details on using the Viewer" "help_advice##viewer"}{...}
{viewerjumpto "Finding text within the Viewer" "help_advice##text"}{...}
{marker description}{...}
{title:Description}

{pstd}
To obtain help, click

{p2colset 9 19 20 2}{...}
{p2col: {help contents}}  for a list of command categories, advice on
          language syntax, and links to datasets from the reference manuals.
	  {p_end}

{p2col: {cdialog:help}}  for help for a Stata command with 
          examples, options list, and syntax guide. 
	  {p_end}

{p2col: {sdialog:search}} to search help files by {it:keyword(s)} and,
          optionally, the Internet.
          Also see {help searchadvice:Advice on specifying search}.

{p2col: {dialog hsearch}}  to search text of help files for specific words.
	  {p_end}
{p2colreset}{...}

{pstd}
You can also

{p 8 12 2}1.  {help net_mnu:Find and install} SJ, STB, and user-written programs
		from the net

{p 8 12 2}2.  {help net_mnu:Review, manage, and uninstall} user-written programs

{p 8 12 2}3.  Check for and optionally install {update:official updates}

{p 8 12 2}4.  {vdialog:View} your logs or any file

{p 8 12 2}5.  Launch your {browse "http://www.stata.com":browser}

{p 8 12 2}6.  Obtain the {news:latest news} from www.stata.com{p_end}


{marker viewer}{...}
{title:Details on using the Viewer}

{pstd}
Results from help and searches are displayed in the Viewer.

{pstd}
You usually use the Viewer 
by clicking, but you can also type commands in the Viewer's edit window.
The Viewer commands are used to

{pmore}see help for contents or help for any Stata command{p_end}
{p 16 20 2}{cmd:help} {cmd:contents}{p_end}
{p 16 20 2}{cmd:help} {it:command-name}

{pmore}search help files, documentation, and FAQs{p_end}
{p 16 20 2}{cmd:search} {it:keyword(s)}

{pmore}find and install SJ, STB, and user-written programs from the net{p_end}
{p 16 20 2}{cmd:net search} {it:keyword(s)}{p_end}
{p 16 20 2}{cmd:net} {cmd:from} {it:http://www.stata.com}

{pmore}review, manage, and uninstall user-written programs{p_end}
{p 16 20 2}{cmd:ado}

{pmore}check for and optionally install official updates{p_end}
{p 16 20 2}{cmd:update} {cmd:query}

{pmore}view your logs or any file{p_end}
{p 16 20 2}{cmd:view} {it:filename}{cmd:.smcl}{p_end}
{p 16 20 2}{cmd:view} {it:anyfilename} {bind: or } {cmd:view} {cmd:"}{it:anyfilename}{cmd:"}

{pmore}launch your browser{p_end}
{p 16 20 2}{cmd:browse} {it:URL}

{pmore}see the latest news from www.stata.com{p_end}
{p 16 20 2}{cmd:news}


{marker text}{...}
{title:Finding text within the Viewer}

{pstd}
To 
search for text within the Viewer, click on
the Find button, which looks like a pair of binoculars.
The Find toolbar will appear at the bottom of the Viewer.
{p_end}
