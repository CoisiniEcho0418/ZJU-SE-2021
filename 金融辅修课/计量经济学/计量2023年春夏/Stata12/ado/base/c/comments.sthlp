{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[P] comments" "mansection P comments"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] #delimit" "help #delimit"}{...}
{viewerjumpto "Description" "comments##description"}{...}
{viewerjumpto "Remarks" "comments##remarks"}{...}
{viewerjumpto "Technical note" "comments##technote"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P comments} {hline 2}}Add comments to programs{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

This entry provides a quick reference for how to specify comments in
programs.  See {findalias frdocomments} for more details.


{marker remarks}{...}
{title:Remarks}

{pstd}
Comments may be added to programs in three ways:

{phang2}
o begin the line with {cmd:*};

{phang2}
o begin the comment with {cmd://}; or

{phang2}
o place the comment between {cmd:/*} and {cmd:*/} delimiters.

{pstd}
Here are examples of each:

         {cmd}* a sample analysis job
         version {ccl stata_version}
         use census
         /* obtain the summary statistics */
         tabulate region // there are 4 regions in this dataset
         summarize marriage

         * a sample analysis job
         version {ccl stata_version}
         use /* obtain the summary statistics */ census
         tabulate region 
         //  there are 4 regions in this dataset
         summarize marriage{txt}

{pstd}
The comment indicator {cmd:*} may be used only at the
beginning of a line, but it does have the advantage that it can be used
interactively.  {cmd:*} indicates that the line is to be ignored.  The
{cmd:*} comment indicator may not be used within Mata.

{pstd}
The {cmd://} comment indicator may be used at the beginning or at the end of a
line.  However, if the {cmd://} indicator is at the end of a line, it must be
preceded by one or more blanks.  That is, you cannot type the following:

         {cmd:tabulate region// there are 4 regions in this dataset}

{pstd}
{cmd://} indicates that the rest of the line is to be ignored.

{pstd}
The {cmd:/*} and {cmd:*/} comment delimiter has the advantage that it
may be used in the middle of a line, but it is more cumbersome to type
than the other two comment indicators.  What appears inside
{cmd:/*} {cmd:*/} is ignored.


{marker technote}{...}
{title:Technical note}

{pstd}
There is a fourth comment indicator, {cmd:///}, that instructs 
Stata to view from {cmd:///} to the end of a line as a comment and to
join the next line with the current line.  For example,

         {cmd}args a              /// input parameter for a
              b              /// input parameter for b
              c              //  input parameter for c{txt}

{pstd}
is equivalent to 

         {cmd:args a b c}

{pstd}
{cmd:///} is one way to make long lines more readable:

         {cmd}replace final_result =                      ///
                 sqrt(first_side^2 + second_side^2)  ///
                 if type == "rectangle"{txt}

{pstd}
Another popular method is

         {cmd}replace final_result =                         /*
                 */ sqrt(first_side^2 + second_side^2)  /*
                 */ if type == "rectangle"{txt}

{pstd}
Like the {cmd://} comment indicator, the {cmd:///} indicator must be preceded
by one or more blanks.
{p_end}
