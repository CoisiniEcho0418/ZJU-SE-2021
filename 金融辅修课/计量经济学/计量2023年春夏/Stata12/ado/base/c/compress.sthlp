{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog compress "dialog compress"}{...}
{vieweralsosee "[D] compress" "mansection D compress"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[D] recast" "help recast"}{...}
{viewerjumpto "Syntax" "compress##syntax"}{...}
{viewerjumpto "Description" "compress##description"}{...}
{viewerjumpto "Remarks" "compress##remarks"}{...}
{viewerjumpto "Example" "compress##example"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink D compress} {hline 2}}Compress data in memory{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:compress} [{varlist}]


{title:Menu}

{phang}
{bf:Data > Data utilities > Optimize variable storage}


{marker description}{...}
{title:Description}

{pstd}
{opt compress} attempts to reduce the amount of memory used by your data.


{marker remarks}{...}
{title:Remarks}

{pstd}
{opt compress} reduces the size of your dataset by considering demoting

{p 8 23 2}{cmd:double}s{space 3}to{space 3}{cmd:long}s, {cmd:int}s, or
	{cmd:byte}s{p_end}
{p 8 23 2}{cmd:float}s{space 4}to{space 3}{cmd:int}s or {cmd:byte}s{p_end}
{p 8 23 2}{cmd:long}s{space 5}to{space 3}{cmd:int}s or {cmd:byte}s{p_end}
{p 8 23 2}{cmd:int}s{space 6}to{space 3}{cmd:byte}s{p_end}
{p 8 23 2}{cmd:str}ings{space 3}to{space 3}shorter {cmd:str}ings

{pin}
See {manhelp data_types D:data types} for an explanation of these storage types.

{pstd}
{opt compress} leaves your data logically unchanged but (probably) appreciably
smaller.  {opt compress} never makes a mistake, results in loss of precision,
or hacks off strings.


{marker example}{...}
{title:Example}

    {cmd:. sysuse auto}
    {cmd:. compress}
