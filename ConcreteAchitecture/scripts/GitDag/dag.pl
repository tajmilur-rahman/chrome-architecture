#!/usr/bin/perl
use warnings;
use strict;

use DBI;
use Config::General;

my $config_path = shift @ARGV;

if (!defined $config_path) {
	$config_path = 'config';
}
die "Config file \'$config_path\' does not exist" unless (-e $config_path);

my %config =  Config::General::ParseConfig($config_path);

my $dbh_ref = DBI->connect("dbi:Pg:database=$config{db_name}", '', '', {AutoCommit => 0});

my $get_revisions = $dbh_ref->prepare(q{
	select	commit, path as release from git_refs_tags order by major, minor, micro, rc
});

$get_revisions->execute or die;
while ( my($commit, $release) = $get_revisions->fetchrow_array) {
	#if($release eq 'linuxv2.6.18'){
	print "Starting from: $commit\n\n";
	my $r = _isExistsInCommitRelease($commit);
	if($r eq ''){
		_storeCommit($commit, $release);
		_lookupAndStoreParent($commit, $release);
	}else{
		print "Commit already exists: $commit\n";
	}
	#}
}

sub _lookupAndStoreParent{
	my ($commit, $release) = @_;
	
	my $get_parent = $dbh_ref->prepare(q{
		select parent from git_dag where child = ?
	});
	$get_parent->execute($commit) or die;
	
	my ($num_parent) = $get_parent->rows;

	print "$num_parent Parent(s) found\n";
	
	if($num_parent > 0){
	    while ( my($parent) = $get_parent->fetchrow_array ){
		if(_hasReleaseTag($parent)==1){
		    print "stopping: there is a release tag at $parent\n";
		    $dbh_ref->commit;
		    return 1;
		}else{
		    print "storing commit $parent\n";
		    my $r = _isExistsInCommitRelease($parent);
		    if($r eq ''){
		    	_storeCommit($parent, $release);
		    	_lookupAndStoreParent($parent, $release);
		    }else{
			if(not $release eq $r){
				my $comp = _compareReleases($release, $r);
				if($comp == 1){
				    print "Updating release. $parent : $r >> $release\n";
				    _updateRelease($parent, $release);
				}
			}
		    }
		}
	    }
	}
	$get_parent->finish;
	return 0;
}

#0 := equal, 2 := $r1 > $r2, 1 := $r1 < $r2
sub _compareReleases{
	my ($r1, $r2) = @_;
	my $query = $dbh_ref->prepare(q{
		select path,rc from git_refs_tags where path in(?, ?) order by major,minor,micro,rc asc;
	});
	$query->execute($r1, $r2);
	my $r = $query->fetchrow_array;

	$query->finish;

	if($r1 eq $r){
	    return 1;
	}
	if($r2 eq $r){
	    return 2;
	}
}

sub _storeCommit{
	my ($commit, $release) = @_;
	
	my $insert = $dbh_ref->prepare(q{
		insert into git_commit_release(commit,release) values(?, ?);
	});
	
	if($insert->execute($commit, $release)){
		$insert->finish;
		return 1;
	}else{
		$insert->finish;
		return '';
	}
}

sub _updateRelease{
	my ($commit, $release) = @_;
	
	my $update = $dbh_ref->prepare(q{
		update git_commit_release set release = ? where commit = ?;
	});
	if($update->execute($release, $commit)){
		$update->finish;
		return 1;
	}else{
		$update->finish;
		return '';
	}
}

sub _hasReleaseTag{
	my ($commit) = @_;
	my $query = $dbh_ref->prepare(q{
		select count(*) from git_refs_tags where commit = ?
	});
	$query->execute($commit) or die;
	if($query->fetchrow_array > 0){
		$query->finish;
		return 1;
	}else{
		$query->finish;
		return 0;
	}
}

sub _isExistsInCommitRelease{
	my ($commit) = @_;
	
	my $query = $dbh_ref->prepare(q{
		select release from git_commit_release where commit = ?
	});
	$query->execute($commit) or die;
	if(my ($release) = $query->fetchrow_array){
		$query->finish;
		return $release;
	}else{
		$query->finish;
		return '';
	}
}


$dbh_ref->commit;

$get_revisions->finish;
$dbh_ref->disconnect;

__END__
see git_commit_release.sql
