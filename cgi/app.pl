#!/usr/bin/env perl
use strict;
use warnings;


sub get_form_data {
	my $method = $ENV{'REQUEST_METHOD'};

	my $text = '';
	if ( $method eq "GET" ) {
		$text = $ENV{'QUERY_STRING'};

	}
	else {    # default to POST
	   	read( STDIN, $text, $ENV{'CONTENT_LENGTH'} );
		# print "Content-type: text/plain\n\n";
	}
	# print "request: $text\n";

	my @value_pairs = split( /&/, $text );

	my %form_results = ();

	foreach my $pair (@value_pairs) {
		( my $key, my $value ) = split( /=/, $pair );
		$value =~ tr/+/ /;
		$value =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
		$value =~ tr/A-Za-z0-9\ \,\.\:\/\@\-\!\"\_\{\}//dc;
		$value =~ s/^\s+//g;
		$value =~ s/\s+$//g;

		$form_results{$key} = $value;    # store the key in the results hash
		# print "$key = $value\n";
	}
	%form_results;
}


my %form_data = get_form_data();
my $method = $ENV{'REQUEST_METHOD'};
if ($method eq 'GET') {
    my $job_id           = $form_data{'job_id'};
    my $part_id          = $form_data{'part_id'};
	my $job_reset        = $form_data{'job_reset'};
	my $ideal_cycle_time = $form_data{'ideal_cycle_time'};
	my $takt_time        = $form_data{'takt_time'};
	my $scale_factor     = $form_data{'scale_factor'};
	my $goal_value       = $form_data{'goal_value'};

	# print "Content-type: text/utf-8\n\n";
	# print "order_no = $order_no\n";
	# print "output = $output\n";

	print "Content-Type: text/html\n\n";
    print "job_id = $job_id<br>\n";
    print "part_id = $part_id<br>\n";
    print "job_reset = $job_reset<br>\n";
    print "ideal_cycle_time = $ideal_cycle_time<br>\n";
    print "takt_time = $takt_time<br>\n";
    print "scale_factor = $scale_factor<br>\n";
    print "goal_value = $goal_value<br>\n";
}
