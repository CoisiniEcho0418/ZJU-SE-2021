{smcl}
{p 0 4}
{help contents:Top}
> {help contents_statistics:Statistics}
> {help contents_special_topics:Special topics}
> {help contents_time_series:Time series}
{bind:> {bf:Smoothers}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help tssmooth:Overview}}{break}
    introduction to {cmd:tssmooth} set of commands

{p 4 8 4}
{bf:{help tssmooth_ma:Moving average filter with uniform weights or specified weights}}{break}
    {cmd:tssmooth ma} command

{p 4 8 4}
{bf:{help tssmooth_exponential:Single exponential smoother}}{break}
    {cmd:tssmooth exponential} command

{p 4 8 4}
{bf:{help tssmooth_dexponential:Double exponential smoother}}{break}
    {cmd:tssmooth dexponential} command

{p 4 8 4}
{bf:{help tssmooth_hwinters:Non-seasonal Holt-Winters smoother}}{break}
    {cmd:tssmooth hwinters} command

{p 4 8 4}
{bf:{help tssmooth_shwinters:Seasonal Holt-Winters smoother}}{break}
    {cmd:tssmooth shwinters} command

{p 4 8 4}
{bf:{help tssmooth_nl:Resistant, nonlinear smoother}}{break}
    {cmd:tssmooth nl} command (a front-end to {help smooth})


{title:Related categories}

{p 4 8}
{help contents_variables_other:Other variable creation and changing commands}
> {bf:{help contents_smoothing:Imputing, smoothing, splines, and polynomials}}
{p_end}

{p 4 8}
{help contents_time_series:Time series}
> {bf:{help contents_ts_filters:Filters for cyclical components}}
{p_end}

{hline}
