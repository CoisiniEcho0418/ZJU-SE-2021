{smcl}
{* *! version 1.3.5  12may2011}{...}
{viewerdialog about "dialog about_dlg"}{...}
{vieweralsosee "[R] about" "mansection R about"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] copyright" "help copyright"}{...}
{vieweralsosee "[U] 3 Resources for learning and using Stata" "help stata"}{...}
{vieweralsosee "stata/ic" "help stataic"}{...}
{vieweralsosee "stata/se" "help statase"}{...}
{vieweralsosee "stata/mp" "help statamp"}{...}
{vieweralsosee "[R] which" "help which"}{...}
{viewerjumpto "Syntax" "about##syntax"}{...}
{viewerjumpto "Description" "about##description"}{...}
{viewerjumpto "Example" "about##example"}{...}
{title:Title}

{p 4 19 2}
{manlink R about} {hline 2} Display information about your Stata


{marker syntax}{...}
{title:Syntax}

    {cmd:about}


{title:Menu}

{phang}
{bf:Help > About}


{marker description}{...}
{title:Description}

{pstd}
{cmd:about} displays information about the release number, flavor, serial
number, and license for your Stata.


{marker example}{...}
{title:Example}

    {cmd:. about}

         {res}Stata/MP 12.0 for Windows (64-bit x86-64)
	 Revision 24 Aug 2011
	 Copyright 1985-2011 StataCorp LP

	 Total physical memory:     8388608 KB
	 Available physical memory:  937932 KB

	 10-user 32-core Stata network perpetual license:
	        Serial number:  5012041234
	          Licensed to:  Alan R. Riley
	                        StataCorp{txt}
