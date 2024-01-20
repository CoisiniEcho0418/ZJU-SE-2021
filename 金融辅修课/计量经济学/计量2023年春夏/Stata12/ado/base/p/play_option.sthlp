{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-3] play_option" "mansection G-3 play_option"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-1] graph editor" "help graph_editor##recorder"}{...}
{vieweralsosee "[G-2] graph play" "help graph_play"}{...}
{viewerjumpto "Syntax" "play_option##syntax"}{...}
{viewerjumpto "Description" "play_option##description"}{...}
{viewerjumpto "Option" "play_option##option"}{...}
{viewerjumpto "Remarks" "play_option##remarks"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlinki G-3 play_option} {hline 2}}Option for playing graph recordings{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 25}{...}
{synopt:{it:play_option}}Description{p_end}
{p2line}
{synopt:{cmdab:play(}{it:recordingname}{cmd:)}}play edits from
    {it:recordingname}{p_end}
{p2line}
{p 4 6 2}{cmd:play()} is {it:unique}; see {help repeated options}.


{marker description}{...}
{title:Description}

{pstd}
Option {cmd:play()} replays edits that were previously recorded using the
{help graph_editor:Graph Recorder}.


{marker option}{...}
{title:Option}

{phang}
INCLUDE help playopt_desc


{marker remarks}{...}
{title:Remarks}

{pstd}
Edits made in the Graph Editor (see {manhelp graph_editor G-1:graph editor})
can be saved as a
recording and the edits subsequently played on another graph.  In addition to
being played from the Graph Editor, these recordings can be played when a
graph is created or used from disk with the option {cmd:play()}.

{pstd}
If you have previously created a recording named {cmd:xyz} and you are drawing
a scatterplot of {cmd:y} on {cmd:x}, you can replay the
edits from that recording on your new graph by adding the option {cmd:play(xyz)}
to your graph command:

	{cmd:. scatter y x, play(xyz)}

{pstd}
To learn about creating recordings, see 
{it:{help graph_editor##recorder:Graph Recorder}} in
{manhelp graph_editor G-1:graph editor}.
{p_end}
