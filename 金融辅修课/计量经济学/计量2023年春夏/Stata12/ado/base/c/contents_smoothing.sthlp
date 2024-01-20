{smcl}
{p 0 4}
{help contents:Top}
> {help contents_data_management:Data management}
> {help contents_creating_variables:Creating and changing variables}
> {help contents_variables_other:Other variable creation and changing commands}
{bind:> {bf:Imputing, smoothing, splines, and polynomials}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help ipolate:Linearly interpolate or extrapolate values}}{break}
    {cmd:ipolate} creates newvar = yvar, and fills in newvar with
    linearly interpolated or extrapolated values where
    yvar is missing

{p 4 8 4}
{bf:{help lpoly:Local polynomial smoothing}}{break}
    {cmd:lpoly} creates newvar containing the local polynomial smooth of xvar

{p 4 8 4}
{bf:{help lowess:Locally weighted smoothing}}{break}
    {cmd:lowess} creates newvar containing the lowess smooth of xvar

{p 4 8 4}
{bf:{help smooth:Robust nonlinear smoothing}}{break}
    3RSSH,twice; 43RS2H; 43RSR2H,twice; ...

{p 4 8 4}
{bf:{help tssmooth:Smoothing time-series data}}{break}
    moving average, single and double exponential, Holt-Winters seasonal
    and nonseasonal, and robust nonlinear smoothers

{p 4 8 4}
{bf:{help mkspline:Linear and restricted cubic spline construction}}{break}
    {cmd:mkspline age1 40 age2 55 age3 65 = age} creates new variables
    age1, age2, and age3 containing a linear spline of age

{p 4 8 4}
{bf:{help orthog:Orthogonalize a set of variables}}{break}
    create orthogonalized set of variables from a set of variables

{p 4 8 4}
{bf:{help orthog:Create orthogonal polynomials}}{break}
    create orthogonal polynomial variables for a single variable

{p 4 8 4}
{bf:{help fracpoly:Create variables containing fractional polynomial powers}}{break}
    {cmd:fracgen} creates new variables containing fractional polynomial
    powers of a variable

{hline}
