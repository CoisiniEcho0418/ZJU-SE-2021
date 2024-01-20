{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[P] automation" "mansection P automation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] plugin" "help plugin"}{...}
{viewerjumpto "Description" "automation##description"}{...}
{viewerjumpto "Remarks" "automation##remarks"}{...}
{title:Title}

    {manlink P automation} {hline 2} Automation


{marker description}{...}
{title:Description}

{pstd}
Automation (formerly known as OLE Automation) is a communication
mechanism between Microsoft Windows applications.  It provides an
infrastructure whereby Windows applications (automation clients) can access
and manipulate functions and properties implemented in another application
(automation server).  A Stata Automation object exposes internal Stata methods
and properties so that Windows programmers can write automation clients to
directly use the services provided by Stata.


{marker remarks}{...}
{title:Remarks}

{pstd} 
A Stata Automation object is most useful for situations that require the
greatest flexibility to interact with Stata from user-written applications.
A Stata Automation object enables users to directly access Stata macros,
scalars, saved results, and dataset information in ways besides the
usual log files.

{pstd}
For documentation on using a Stata Automation object, see

{pin}
	{browse "http://www.stata.com/automation/"}

{pstd}
Note that the standard Stata end-user license agreement (EULA)
does not permit Stata to be used as an embedded engine in a production
setting.  If you wish to use Stata in such a manner, please contact
StataCorp at {browse "mailto:service@stata.com":service@stata.com}.
{p_end}
