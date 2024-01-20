{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[G-3] fitarea_options" "mansection G-3 fitarea_options"}{...}
{viewerjumpto "Syntax" "fitarea_options##syntax"}{...}
{viewerjumpto "Description" "fitarea_options##description"}{...}
{viewerjumpto "Options" "fitarea_options##options"}{...}
{viewerjumpto "Remarks" "fitarea_options##remarks"}{...}
{title:Title}

{p2colset 5 30 32 2}{...}
{p2col :{manlinki G-3 fitarea_options} {hline 2}}Options for specifying the look of confidence interval areas{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 30}{...}
{p2col:{it:fitarea_options}}Description{p_end}
{p2line}
{p2col:{cmdab:acol:or:(}{it:{help colorstyle}}{cmd:)}}outline and fill color
       {p_end}
{p2col:{cmdab:fc:olor:(}{it:{help colorstyle}}{cmd:)}}fill color{p_end}
{p2col:{cmdab:fi:ntensity:(}{it:{help intensitystyle}}{cmd:)}}fill intensity
      {p_end}

{p2col:{cmdab:alc:olor:(}{it:{help colorstyle}}{cmd:)}}outline color{p_end}
{p2col:{cmdab:alw:idth:(}{it:{help linewidthstyle}}{cmd:)}}thickness of
       outline{p_end}
{p2col:{cmdab:alp:attern:(}{it:{help linepatternstyle}}{cmd:)}}outline pattern
       (solid, dashed, etc.){p_end}
{p2col:{cmdab:alsty:le:(}{it:{help linestyle}}{cmd:)}}overall look of outline
       {p_end}

{p2col:{cmdab:asty:le:(}{it:{help areastyle}}{cmd:)}}overall look of area, all
       settings above{p_end}
{p2col:{cmdab:psty:le:(}{it:{help pstyle}}{cmd:)}}overall plot style,
       including areastyle{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}
All options are {it:merged-implicit}; see {help repeated options}.


{marker description}{...}
{title:Description}

{pstd}
The {it:fitarea_options} determine the look of, for instance, the confidence
interval areas created by {helpb twoway fpfitci}, {helpb twoway lfitci},
{helpb twoway lpolyci}, and {helpb twoway qfitci}.


{marker options}{...}
{title:Options}

{phang}
{cmd:acolor(}{it:colorstyle}{cmd:)}
    specifies one color to be used both to outline the shape of the
    area and to fill its interior.
    See {manhelpi colorstyle G-4} for a list of color choices.

{phang}
{cmd:fcolor(}{it:colorstyle}{cmd:)}
    specifies the color to be used to fill the interior of the area.
    See {manhelpi colorstyle G-4} for a list of color choices.

{phang}
{cmd:fintensity(}{it:intensitystyle}{cmd:)}
    specifies the intensity of the color used to fill the interior of the area.
    See {manhelpi intensitystyle G-4} for a list of intensity choices.

{phang}
{cmd:alcolor(}{it:colorstyle}{cmd:)}
    specifies the color to be used to outline the area.
    See {manhelpi colorstyle G-4} for a list of color choices.

{phang}
{cmd:alwidth(}{it:linewidthstyle}{cmd:)}
    specifies the thickness of the line to be used to outline the area.
    See {manhelpi linewidthstyle G-4} for a list of choices.

{phang}
{cmd:alpattern(}{it:linepatternstyle}{cmd:)}
    specifies whether the line used to outline the area is solid, dashed,
    etc.
    See {manhelpi linepatternstyle G-4} for a list of pattern choices.

{phang}
{cmd:alstyle(}{it:linestyle}{cmd:)}
    specifies the overall style of the line used to outline the area, 
    including its pattern (solid, dashed, etc.), thickness, and color.
    The three options listed above allow you to change the line's attributes,
    but {cmd:lstyle()} is the starting point.
    See {manhelpi linestyle G-4} for a list of choices.

{phang}
{cmd:astyle(}{it:areastyle}{cmd:)}
    specifies the overall look of the area.  The options listed above allow
    you to change each attribute, but {cmd:style()} provides a starting
    point.

{pmore}
    You need not specify {cmd:style()} just because there is something you
    want to change.  You specify {cmd:style()} when another style exists that
    is exactly what you desire or when another style would allow you to
    specify fewer changes to obtain what you want.

{pmore}
    See {manhelpi areastyle G-4} for a list of available area styles.

{phang}
{cmd:pstyle(}{it:pstyle}{cmd:)}
    specifies the overall style of the plot, including not only the
    {it:{help areastyle}}, but all other settings for the look of the plot.
    Only the {it:areastyle} affects the look of areas.  See
    {manhelpi pstyle G-4} for a list of available plot styles.


{marker remarks}{...}
{title:Remarks}

{pstd}
{it:fitarea_options} are allowed as options with any {cmd:graph twoway}
plottype that creates shaded confidence interval areas, for example,
{cmd:graph} {cmd:twoway} {cmd:lfitci}, as in

{phang2}
	{cmd:. graph twoway lfitci} {it:yvar} {it:xvar}{cmd:, acolor(blue)}

{pstd}
The above would set the area enclosed by {it:yvar} and the {it:x} axis to be
blue; see {manhelp twoway_area G-2:graph twoway area} and
{manhelp twoway_rarea G-2:graph twoway rarea}.
{p_end}
