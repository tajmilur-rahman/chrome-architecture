\set ECHO ALL
drop table if exists git_commit_release;
create table git_commit_release(
	commit text,
	release text
);
create index commit_idx on git_commit_release(commit);
