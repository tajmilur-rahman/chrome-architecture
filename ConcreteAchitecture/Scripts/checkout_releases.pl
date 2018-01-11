#!/usr/bin/perl -w

##
# Checkout all the different release versions from latest copy of the chromium repository
# Md. Tajmilur Rahman - 10th November 2014
#

#use warnings;
use strict;

use DBI;
use Config::General;
use Cwd;

use utf8; 
use Encode;

use Data::Dumper;

my $config_path = shift @ARGV;

if (!defined $config_path) {
	$config_path = 'config';
}
die "Config file \'$config_path\' does not exist" unless (-e $config_path);
my %config =  Config::General::ParseConfig($config_path);
my $dbh_ref = DBI->connect("dbi:Pg:database=$config{db_name}", '', '', {AutoCommit => 1});
my ($repo_path, $sql) = "";

$sql = $dbh_ref->prepare(q{select s.release, s.release_ends_at, t.commit from stable_releases s, git_refs_tags t where s.release_ends_at=t.path});
$sql->execute or die;

while(my($release, $release_ends_at, $commit) = $sql->fetchrow_array){

    $repo_path = "$config{repo_path}chromium$release_ends_at";

    print "git clone $config{clone_path} $repo_path\n";
    print "git checkout $commit\n";

    system("git clone $config{clone_path} $repo_path");
    chdir $repo_path or die "Cannot cd to $repo_path";
    system("git checkout $commit");
}

$sql->finish;
$dbh_ref->disconnect;

__END__
