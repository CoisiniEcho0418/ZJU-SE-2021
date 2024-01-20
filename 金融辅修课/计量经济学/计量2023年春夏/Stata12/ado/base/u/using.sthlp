{smcl}
{* *! version 1.1.3  11feb2011}{...}
{findalias asfrsyntax}{...}
{viewerjumpto "Syntax" "using##syntax"}{...}
{viewerjumpto "Description" "using##description"}{...}
{viewerjumpto "Examples" "using##examples"}{...}
{title:Title}

{pstd}
The using modifier (from {findalias frsyntax})


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}{it:command} {cmd:using} {it:filename}


{marker description}{...}
{title:Description}

{pstd}
This part of Stata's syntax is used by only a few commands, such as
{cmd:infile} and {cmd:outfile}.  After the {cmd:using}, you specify a valid
{it:filename}.  You specify the {it:filename} in quotes if it contains blanks
or other special characters.


{marker examples}{...}
{title:Examples}

    {cmd:. infile a b c using myfile.raw}{right:(All platforms)  }
    {cmd:. infile a b c using \mydata\myfile.raw}{right:(Windows)        }
    {cmd:. infile a b c using ~/mydata/myfile.raw}{right:(Unix)           }
    {cmd:. infile a b c using "~:My Data:myfile.raw"}{right:(Mac)            }

{phang}{cmd:. webuse autotech}{p_end}
{phang}{cmd:. describe}{p_end}
{phang}{cmd:. describe using http://www.stata-press.com/data/r12/autocost}
{p_end}
{phang}{cmd:. merge 1:1 make using http://www.stata-press.com/data/r12/autocost}

{phang}{cmd:. webuse kahn, clear}{p_end}
{phang}{cmd:. istdize death pop age using}
                {cmd:http://www.stata-press.com/data/r12/popkahn,}
		{cmd:by(state) pop(deaths pop) print}
{p_end}
