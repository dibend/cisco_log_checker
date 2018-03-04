#!/usr/bin/perl
# <FILE> <DATE>

$numArgs = $#ARGV + 1;
if ($numArgs != 2)
{
    print "incorrect number of arguments \n";
    exit;
}
$filename = $ARGV[0];
$date = $ARGV[1];
open FILE, "<", $filename or die $!;
while (<FILE>)
{
    if ($_ =~ /Deny/ && /$date/)
    {
        @ip = ($_ =~ /\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b\/\d{1,5})/g);
        $list{$ip[0] . ":" . $ip[1]} += 1;
    }
}
print "Source IP     Port #      Dest IP   Port #      Attempts \n";
foreach $i (keys (%list)) 
{
    ($srcip, $destip) = split(/:/, $i, 2);
    print $srcip . "       " . $destip . "       " . $list{$i} . "\n";
} 

