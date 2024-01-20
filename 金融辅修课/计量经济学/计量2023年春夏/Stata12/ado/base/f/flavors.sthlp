{smcl}
{* *! version 1.2.3  23jun2011}{...}
{findalias asfrflavors}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Small Stata" "help small_stata"}{...}
{vieweralsosee "Stata/IC" "help stataic"}{...}
{vieweralsosee "Stata/SE" "help statase"}{...}
{vieweralsosee "Stata/MP" "help statamp"}{...}
{title:Title}

{pstd}
{findalias frflavors}


{title:Contents}

        {help flavors##platforms:5.1 Platforms}

        {help flavors##flavors:5.2 Stata/MP, Stata/SE, Stata/IC, and Small Stata}
            {help flavors##version_own:5.2.1 Determining which version you own}
            {help flavors##version_installed:5.2.2 Determining which version is installed}

        {help flavors##limits:5.3 Size limits of Stata/MP, SE, IC, and Small Stata}

        {help flavors##speed:5.4 Speed comparison of Stata/MP, SE, IC, and Small Stata}

        {help flavors##comparison:5.5 Feature comparison of Stata/MP, SE, and IC}


{marker platforms}{...}
{title:5.1 Platforms}

{pstd}
Stata is available for a variety of computers, including

        Stata for Windows, 64-bit {it:x}86-64
        Stata for Windows, 32-bit {it:x}86

        Stata for Mac, 64-bit Intel
        Stata for Mac, 32-bit Intel
        Stata for Mac, PowerPC

        Stata for Linux, 64-bit {it:x}86-64
        Stata for Linux, 32-bit {it:x}86
        Stata for Solaris, 64-bit SPARC
        Stata for Solaris, 64-bit {it:x}86-64

{pstd}
Which version of Stata you run does not matter -- Stata is Stata.  You
instruct Stata in the same way and Stata produces the same results, right down
to the random-number generator.  Even files can be shared.  A dataset created
on one computer can be used on any other computer, and the same goes for
graphs, programs, or any file Stata uses or produces.  Moving files
across platforms is simply a matter of copying them; no translation is
required.

{pstd}
Some computers, however, are faster than others.  Some computers have more
memory than others.  Computers with more memory, and faster computers, are
better.

{pstd}
The list above includes both 64- and 32-bit computers.  64-bit Stata runs
faster than 32-bit Stata and 64-bit Stata will allow processing data in
excess of 2 gigabytes, assuming you have enough memory.  
32-bit Stata will run on 64-bit hardware.

{pstd}
When you purchase Stata, you may install it on any of the above platforms.
Stata licenses are not locked to a single operating system.


{marker flavors}{...}
{title:5.2 Stata/MP, Stata/SE, Stata/IC, and Small Stata}

{pstd}
Stata is available in four flavors, although perhaps sizes would be a better
word.  The flavors are, from largest to smallest, Stata/MP, Stata/SE,
Stata/IC, and Small Stata.

{pstd}
Stata/MP is the multiprocessor version of Stata.  It runs on multiple 
CPUs or on multiple cores, from 2 to 64.  Stata/MP uses however many
cores you tell it to use (even one),  up to the number of cores for which you
are licensed.  Stata/MP is the fastest version of Stata.  Even so, all the
details of parallelization are handled internally and you use Stata/MP just
like you use any other flavor of Stata.  You can read about how
Stata/MP works and see how its speed increases with more cores in the Stata/MP
performance report at
{browse "http://www.stata.com/statamp/report.pdf":http://www.stata.com/statamp/report.pdf}.

{pstd}
Stata/SE is like Stata/MP, but for single CPUs.  Stata/SE will run on
multiple CPUs or multiple core computers, but it will use only one of
the CPUs or cores.  SE stands for special edition.

{pstd}
Both Stata/MP and Stata/SE have the same limits and the same capabilities and
are intended for those who work with large datasets.  You may have up to
32,767 variables with either.  Statistical models may have up to 11,000
variables.

{pstd}
Stata/IC is standard Stata.  IC stands for intercooled, a name used before
the introduction of Stata/SE and later of Stata/MP to indicate that it was 
at the time the top version of Stata.  Up to 2,047 variables are allowed.
Statistical models may have up to 800 variables.

{pstd}
Stata/MP, Stata/SE, and Stata/IC all allow up to 2,147,583,647 observations,
assuming you have enough memory.

{pstd}
Small Stata is intended for students and limited to 99 variables and 
1,200 observations.


{marker version_own}{...}
    {title:5.2.1 Determining which version you own}

{pstd}
Check your License and Authorization Key.  Included with every copy of Stata is
a paper License and Authorization Key that contains codes that you will input
during installation.  This determines which flavor of Stata you have and for
which platform.

{pstd}
Contact us or your distributor if you want to upgrade from one flavor to
another.  Usually, all you need is an upgraded paper License and Authorization
Key with the appropriate codes.  All flavors of Stata are on the same DVD.  

{pstd}
If you purchased one flavor of Stata and want to use a lessor version, you
may.  You might want to do this if you had a large computer at work and a
smaller one at home.  Please remember, however, that you have only one
license (or however many licenses you purchased).  You may, both legally and
ethically, install Stata on both computers and then use one or the other, but
you should not use them both simultaneously.


{marker version_installed}{...}
    {title:5.2.2 Determining which version is installed}

{pstd}
If Stata is already installed, you can find out which Stata
you are using by entering Stata as you normally do and typing {cmd:about}:

        . about

        Stata/IC 12.0 for Windows (64-bit x86-64)
        Born {it:date}
        Copyright (C) 1985-2011 StataCorp LP

        Total physical memory:     8388608 KB
        Available physical memory:  937932 KB

        10-user 32-core Stata network perpetual license:
               Serial number:  5012041234
                 Licensed to:  Alan R. Riley
                      StataCorp


{marker limits}{...}
{title:5.3 Size limits of Stata/MP, SE, IC, and Small Stata}

{pstd}
Here are some of the different size limits for Stata/MP, Stata/SE, Stata/IC,
and Small Stata.  See {help limits} for a longer list.

{center:{bf:Maximum size limits for Stata/MP, Stata/SE, Stata/IC, and Small Stata}}

                             Stata/MP and /SE     Stata/IC      Small Stata
    {hline}
    # observations                        *              *   fixed at 1,200
    # variables                      32,767          2,047      fixed at 99
    Width of a dataset              393,192         24,564              800
    Maximum matrix size ({cmd:matsize})    10,998            798               99
    # characters in a macro       1,081,511        165,200            8,681
    # characters in a command     1,081,527        165,216            8,697
    {hline}
    * Limited only by memory

{pstd}
Stata/MP and Stata/SE allow more variables, larger models, longer
macros, and a longer command line than Stata/IC.  The longer command line and
macro length are required because of the greater number of variables allowed.
The larger model means that Stata/MP and Stata/SE can fit
statistical models with more independent variables.

{pstd}
Small Stata is limited.  It is intended for student use and often 
used in undergraduate labs.


{marker speed}{...}
{title:5.4 Speed comparison of Stata/MP, SE, IC, and Small Stata}

{pstd}
We have written a white paper comparing the performance of Stata/MP with
Stata/SE; see 
{browse "http://www.stata.com/statamp/report.pdf"}.  The white paper includes
command-by-command performance measurements.

{pstd}
In summary, on a 2-CPU or dual-core computer, Stata/MP will run
commands in 71% of the time required by Stata/SE.  There is variation; some
commands run in half the time and others are not sped up at all.  Statistical
estimation commands run in 59% of the time.  Numbers quoted are medians.
Average performance gains are higher because commands that take longer to
execute are generally sped up more.

{pstd}
Stata/MP running on four CPUs runs in 50% (all commands) and 35%
(estimation commands) of the time required by Stata/SE.  Both numbers are
median measures.

{pstd}
Stata/MP supports up to 64 cores.

{pstd}
Stata/IC is a slower than Stata/SE, but those differences emerge only
when processing datasets that are pushing the limits of Stata/IC.
Stata/SE has a larger memory footprint and uses that
extra memory for larger look-aside tables to more efficiently process large
datasets.  The real benefits of the larger tables become apparent  
only after exceeding
the limits of Stata/IC.  Stata/SE was designed for processing large datasets.

{pstd}
Small Stata is, by comparison to all of the above, slow, but given its limits,
no one notices.  Small Stata was designed to have a minimal memory footprint,
and to achieve that, different logic is sometimes used.  For instance, in
Stata's {cmd:test} command, it must compute the matrix calculation
{bf:R}{bf:Z}{bf:R'} (where {bf:Z}=({bf:X'}{bf:X})^{-1}).  Stata/MP, Stata/SE,
and Stata/IC make the calculation in a straightforward way, which is to form
{bf:T}={bf:R}{bf:Z} and then calculate ${bf:T}{bf:R'}.  This requires
temporarily storing the matrix {bf:T}.  Small Stata, on the other hand, goes
into more complicated code to form the result directly -- code that requires
temporary storage of only one scalar.  This code, in effect, recalculates
intermediate results over and over again, and so it is slower.

{pstd}
In all cases, the differences are all technical and internal.  From the user's
point of view, Stata/MP, Stata/SE, Stata/IC, and Small Stata work the same way.


{marker comparison}{...}
{title:5.5 Feature comparison of Stata/MP, SE, and IC}

{pstd}
The features of all flavors of Stata on all platforms are the same.
The differences are in speed and in limits.  The differences in 
limits are

                                  Stata/IC               Stata/SE and /MP
          Parameter  {c |}  Default    min    max  {c |}  Default    min     max
          {hline 11}{c +}{hline 54}
          {helpb maxvar}     {c |}    2,047  2,047  2,047  {c |}    5,000  2,047  32,767
          {helpb matsize}    {c |}      400     10    800  {c |}      400     10  11,000
                     {c |}                         {c |}
          {helpb processors} {c |}        1      1      1  {c |}        1      1       1 /SE
                     {c |}                         {c |}        2      1      64 /MP
          {hline 11}{c BT}{hline 54}
          Note:  The default number of processors for Stata/MP is the minimum
                 of processors licensed and processors available.

{pstd}
The limits on Stata/MP and /SE are settable.  You reset the limits 
temporarily by typing 

        {cmd:. set maxvar} {it:#}
        {cmd:. set matsize} {it:#}
        {cmd:. set processors} {it:#}

{pstd}
Concerning the last, Stata/MP users sometimes want to use fewer processors to
leave some free for other applications.

{pstd}
You reset the limits permanently by typing

        {cmd:. set maxvar} {it:#}{cmd:, permanently}
        {cmd:. set matsize} {it:#}{cmd:, permanently}

{pstd}
If you use Stata/SE or Stata/MP, see
{bf:{help statase:help stata/se}}
or
{bf:{help statamp:help stata/mp}}
to learn more.
