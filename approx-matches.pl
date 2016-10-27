#!/usr/local/bin/perl
# Mike McQuade
# approx-matches.pl
# Takes in an integer, a string and a pattern from an input file,
# then outputs the number of approximate matches, allowing as many
# mismatches as the given integer.
# The matching locations for this are put into an array, then printed out.

use strict;
use warnings;

# Define local variables
my ($pattern,$text,$d,@locations);
my $distance = 0;

# Open the file to read
open(my $fh,"<ba1h.txt") or die $!;

# Initialize the two string variables with the first two lines in the file
# and the integer variable with the third line
$pattern = <$fh>;
$text = <$fh>;
$d = <$fh>;
chomp($pattern);
chomp($text);
chomp($d);

# Iterate through the genome string
for (my $i = 0; $i <= (length($text)-length($pattern)); $i++){
	for (my $k = 0; $k < length($pattern); $k++){
		# If there is a mismatch in the strings, increment the Hamming distance by 1
		if (substr($text,$i+$k,1) ne substr($pattern,$k,1)) {$distance++;}
	}
	
	# If the Hamming distance is less than or equal to the given integer,
	# the location is added to the array
	if ($distance <= $d) {push(@locations,$i);}
	
	# Reset the Hamming distance after each iteration
	$distance = 0;
}

# Close the file
close($fh) || die "Couldn't close file properly";

# Define output string for locations found
my $output = "@locations\n";
chomp($output); # Remove whitespace after last number

# Print locations where the pattern was found
print $output;