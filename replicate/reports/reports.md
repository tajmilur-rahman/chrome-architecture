==Median directory distance between files that are sharing common feature toggles file (i.e. part of the common feature)==
select median(dist) as dir_dist from directory_dist where release=5.0 group by switch_set;

==Count how many directories a feature is spanned into==
select switch_set, count(distinct path1) from directory_dist group by switch_set;

==Count how many features a directory contains==
select dir, count(feature) as feature_count from feature_dir_crosscut where release=34.0 group by dir;
--
