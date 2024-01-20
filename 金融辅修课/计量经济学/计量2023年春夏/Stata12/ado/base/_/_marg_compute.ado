*! version 1.0.0  18mar2009
program _marg_compute
	version 11
	syntax anything(name=o id="name") [fw pw iw aw] [if] [, *]
	.`o'.compute `if' [`weight'`exp'], `options'
end
exit
