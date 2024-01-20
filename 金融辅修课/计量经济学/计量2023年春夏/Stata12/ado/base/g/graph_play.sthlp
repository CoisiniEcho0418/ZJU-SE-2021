{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-2] graph play" "mansection G-2 graphplay"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-1] graph editor" "help graph_editor##recorder"}{...}
{vieweralsosee "[G-3] play_option" "help play_option"}{...}
{viewerjumpto "Syntax" "graph play##syntax"}{...}
{viewerjumpto "Description" "graph play##description"}{...}
{viewerjumpto "Remarks" "graph play##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink G-2 graph play} {hline 2}}Apply edits from a recording on
current graph{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 30 2}
{cmdab:gr:aph}
{cmd:play}
{it:recordingname}


{marker description}{...}
{title:Description}

{pstd}
{cmd:graph} {cmd:play} applies edits that were previously recorded using the
Graph Recorder to the current graph.


{marker remarks}{...}
{title:Remarks}

{pstd}
Edits made in the Graph Editor (see {manhelp graph_editor G-1:graph editor})
can be saved as a
recording and the edits subsequently played on another graph.  In addition to
being played from the Graph Editor, these recordings can be played on the
currently active graph using the command {cmd:graph} {cmd:play}
{it:recordingname}.

{pstd}
If you have previously created a recording named {cmd:xyz}, you can replay the
edits from that recording on your currently active graph by typing

	{cmd:. graph play xyz}

{pstd}
To learn about creating recordings, see 
{it:{help graph_editor##recorder:Graph Recorder}} in
{manhelp graph_editor G-1:graph editor}.
{p_end}
