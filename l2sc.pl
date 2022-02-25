#!/usr/bin/perl 

use strict;
use warnings;
use LWP::UserAgent;
use Getopt::Long;
use Term::ANSIColor;
use HTTP::Status ;


my $options = GetOptions(
  'l|list=s'   => \my $file, 
  's|status=i'   => \my $response,
) or die "Invalid options passed to $0\n";


if(defined($file) and !defined($response) ){

if(open(LIST,'<', $file)or die $!){
	while(my $list = <LIST>){
			chomp $list;  
			my $req = HTTP::Request->new(GET=>$list);
			my $ua = LWP::UserAgent->new(timeout => 10);
			my $page = $ua->request($req);
			my $sc = $page->code(); # sc === status code

        if (is_info($sc)) { 
	    print color "white" ,"on_black";
	    print "[+] " . $sc . " : " .  status_message($sc) .  " -> ". $list . "\n";
	    print color 'reset';
	    }
       if (is_success($sc)) { 
	    print color "green" ,"on_black";
	    print "[+] " . $sc . " : " .  status_message($sc) .  " -> ". $list . "\n";
	    print color 'reset';
	    }
       if (is_redirect($sc)) { 
	   print color "yellow" ,"on_black";
	   print "[+] " . $sc . " : " .  status_message($sc) .  " -> ". $list . "\n";
	   print color 'reset';
	   }
       if (is_error($sc)) { 
	   print color "cyan" ,"on_black";
	   print "[+] " . $sc . " : " .  status_message($sc) .  " -> ". $list . "\n";
	   print color 'reset';
	  }
}
}
exit 1;}	

if(defined($file) and defined($response) ){

if(open(LIST,'<', $file)or die $!){
	while(my $list = <LIST>){
			# chomp $list;  
			my $req = HTTP::Request->new(GET=>$list);
			my $ua = LWP::UserAgent->new(timeout => 10);
			my $page = $ua->request($req);
			my $sc = $page->code(); # sc === status code

     if($response == $sc ){
	   print $list ;

}
}
}
exit 1;}	

else {

  print color "yellow" , "on_black";
  print "Usage 1: ./l2sc.pl -l/--list  list.txt " ; 
  print color "reset";
  print  "\n"; 

  print color "yellow" , "on_black";
  print "Usage 2: ./l2sc.pl -s/--status 200  -l/--list  list.txt " . "\n";
  print "Usage 3: ./l2sc.pl -s/--status 403  -l/--list  list.txt " ;
  print color "reset";
  print "\n";

  print color "cyan" , "on_black";
  print "Coded By C0braBaghdad1 ";
  print color 'reset';
  print "\n";

exit 1;}