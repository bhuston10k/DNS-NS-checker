#!/usr/bin/perl
use File::Slurp;
use strict;
use warnings;

#Variable definitions: two strings we aren't concerned about.
#If they're found in the file, we needn't worry.
my $first = "pdns6.ultradns.co.uk";
my $second = "ns4.lpl.com";
my $datestring = localtime();
my $current = "/home/kkinloch/jobs/dns_check/NS_ck/diff_dns.txt";
my $changed = "/home/kkinloch/jobs/dns_check/NS_ck/changed.txt";
my $not_changed = "/home/kkinloch/jobs/dns_check/NS_ck/not_changed.txt";

#Open file that may contain what we seek
open(SOURCE, $current) or die "Cannot open $current!";


#From beginning to end, do we see the known strings?
while (my $line = <SOURCE>) {
	chomp $line;
	if ($line eq $first) {
		open( DESTNC, ">>", $not_changed ) or die "Cannot open $not_changed $!";
		select DESTNC;
		print "All Good\tdatestring\n";
		close DESTNC;
	}
	else if ($line eq $second) {
		open( DESTNC, ">>", $not_changed ) or die "Cannot open $not_changed $!";
		select DESTNC;
		print "All Good\t$datestring\n";
		close DESTNC;
	}
	else 
	{
		open( DESTC, ">>", $changed ) or die "Cannot open $changed $!";
		select DESTC;
		print "The NS for $line changed to: ";
		print $line;
		print ", this was observed at $datestring\n";
		print "\n ***** Investigate why this occurred - it is not normal *****\n";
		close DESTC;
	}
}