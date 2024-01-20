{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_special_topics:Special topics}
> {help contents_time_series:Time series}
{bind:> {bf:Basics}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help tsset:Setting time-series data}}{break}
    declare dataset to be time-series data and designate the time variable

{p 4 8 4}
{bf:{help datetime:Overview of dates and times}}{break}
    Stata stores dates and times as # of milliseconds since 01jan1960 00:00:00
    or days since 01jan1960 or # of weeks since 1960w1 or ...

{p 4 8 4}
{bf:{help tsreport:Report time-series aspects of dataset or estimation sample}}{break}
    report on time gaps

{p 4 8 4}
{bf:{help tsappend:Add observations to a time-series dataset}}{break}
    automatically fill in time variable (and panel variable if set)

{p 4 8 4}
{bf:{help tsfill:Fill in missing times with missing observations}}{break}
    automatically fill in gaps in time-series and panel datasets

{p 4 8 4}
{bf:{help tsvarlist:Time-series variable lists}}{break}
    use time-series operators on existing variables in a variable
    list


{title:Related categories}

{p 4 8}
{help contents_expressions:Expressions and functions}
> {help contents_functions:Functions}
> {bf:{help contents_ts_functions:Date and time functions}}
{p_end}

{hline}
