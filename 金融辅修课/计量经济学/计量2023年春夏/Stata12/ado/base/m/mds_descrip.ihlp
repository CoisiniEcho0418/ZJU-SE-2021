{* *! version 1.0.2  25apr2007}{...}
{pstd}
Computing the classical solution is straightforward, but with modern MDS the
minimization of the loss criteria over configurations is a high-dimensional
problem that is easily beset by convergence to local minimums.
{cmd:mds}, {cmd:mdsmat}, and {cmd:mdslong} provide options to control
the minimization process (1) by allowing the user to select the starting
configuration and (2) by selecting the best solution among multiple
minimization runs from random starting configurations.
