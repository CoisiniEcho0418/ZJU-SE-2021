local fn = subinstr("`c(current_time)'",":","",2)  
log using D:\SkyDrive\cloud\Stata\stata12\ado\personal\stata.log, text replace
cmdlog using D:\SkyDrive\cloud\Stata\stata12\ado\personal\command.log, append
sysdir set PLUS "D:\SkyDrive\cloud\Stata\stata12\ado\plus"
sysdir set OLDPLACE "D:\SkyDrive\cloud\Stata"
sysdir set PERSONAL "D:\SkyDrive\cloud\Stata\stata12\ado\personal"
cd D:\SkyDrive\cloud\Stata
set type double
set memory 50m
set matsize 2000
set more off,perma