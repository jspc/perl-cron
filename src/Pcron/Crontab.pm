#!/usr/bin/env perl
#

use strict;
use warnings;

package Pcron;

my ($minute, $hour, $dom, $mon, $dow);
my $command;
my $line_s;
my @line_a;

my @localtime;
my $timeperiod;

my $self;

sub new {
	# Parse the line, return  an object based on it
	
	($self, $line) = @_;
	
	$line =~ s/^\s+//;
	@line_a = split / +/, $line;
	
	foreach $timeperiod (@line_a[0..4]){
		die "Issue with $line\nThis cron entry is bollocks" if valid_char( $timeperopd ) == 0;
	}

	($minute, $hour, $dom, $mon, $dow) = @line_a[0..4];
	
	$command = join( " ", @line_a[5..-1];
	
	# Now then, lets create an object

	$self = {
			"minute"  =>   $minute,
			"hour"    =>   $hour,
			"dom"     =>   $dom,
			"month"   =>   $mon,
			"dow"     =>   $mon,
			"command" =>   $command
		};
		
	return bless $self;
	
}

sub valid_char {
	# Ensure our character is sane
	
	($self, $timeperiod) = @_;
	
	return 1 if $timeperiod =~ m/0-9\*/;
	return 0;
	
}

sub izit_time {
	# Well... is it? Return command if it is now
	# Time to run it
	
	$self = shift;
	@localtime = localtime(time);
	
	if ( ( $self->{'minute'} =~ /($localtime[1]|\*/ ) and
		 ( $self->{'hour'}   =~ /($localtime[2]|\*/ ) and
		 ( $self->{'dom'}    =~ /($localtime[3]|\*/ ) and
		 ( $self->{'month'}  =~ /($localtime[4]|\*/ ) and
		 ( $self->{'dow'}    =~ /($localtime[6]|\*/ ) ){
			 return $self->{'command'};
		 }
		 
	return 0;
	
}

1;
