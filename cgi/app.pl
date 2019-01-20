#!/usr/bin/env perl
use strict;
use warnings;
require File::Temp;

my $job_id            = '';
my $part_id           = '';
my $job_reset         = '';
my $ideal_cycle_time  = '';
my $takt_time         = '';
my $scale_factor      = '';
my $goal_value        = '';
my $count_of_barcodes = '';
my $filename          = '';


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


sub print_variables {
    print "job_id = $job_id<br>\n";
    print "part_id = $part_id<br>\n";
    print "job_reset = $job_reset<br>\n";
    print "ideal_cycle_time = $ideal_cycle_time<br>\n";
    print "takt_time = $takt_time<br>\n";
    print "scale_factor = $scale_factor<br>\n";
    print "goal_value = $goal_value<br>\n";
    print "count_of_barcodes = $count_of_barcodes<br>\n";
    print "filename = $filename<br>\n";
}


sub print_barcodes {
	print <<HTML
	<html>
	<body>
		<table cellpadding="0"
		       cellspacing="0"
		       style="margin-top: 50px; margin-left: 100px;">
HTML
;

	for my $i (1..$count_of_barcodes) {
		print <<HTML
			<tr>
				<td style="border: 1px solid black;">
					<img src="/barcodes/$filename" />
				</td>
			</tr>
HTML
	}


	print <<HTML
		</table>
	</body>
	</html>
HTML
}


my %form_data = get_form_data();
my $method = $ENV{'REQUEST_METHOD'};
if ($method eq 'GET') {
    $job_id            = $form_data{'job_id'};
    $part_id           = $form_data{'part_id'};
	$job_reset         = $form_data{'job_reset'};
	$ideal_cycle_time  = $form_data{'ideal_cycle_time'};
	$takt_time         = $form_data{'takt_time'};
	$scale_factor      = $form_data{'scale_factor'};
	$goal_value        = $form_data{'goal_value'};
	$count_of_barcodes = $form_data{'count_of_barcodes'};
    (undef, $filename) = File::Temp::tempfile('barcodeXXXXXX', DIR => '../barcodes', SUFFIX => '.png', OPEN => 0);

	print "Content-Type: text/html\n\n";

	# print_variables();

    # <SOH> 01h
    # <STX> 02h
	# <ETX> 03h
	my $message = "$job_id;$part_id;$job_reset;$ideal_cycle_time;$takt_time;$scale_factor;$goal_value";
    system("../.venv/bin/pdf417gen encode '\\01\\02$message\\03' -o $filename");

    print_barcodes();
}
