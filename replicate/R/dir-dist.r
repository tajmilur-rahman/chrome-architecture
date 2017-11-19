select median(dist) as dir_dist from directory_dist where release=5.0 group by switch_set;

fDDist5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_dir-5.rpt",header=T,sep="|")
fDDist13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_dir-13.rpt",header=T,sep="|")
fDDist22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_dir-22.rpt",header=T,sep="|")
fDDist34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_dir-34.rpt",header=T,sep="|")
beanplot(
    data.frame(fDDist5$dir_dist),
    data.frame(fDDist13$dir_dist),
    data.frame(fDDist22$dir_dist),
    data.frame(fDDist34$dir_dist),
    what = c(0,1,1,0),
    overallline = "median",
    bw=0.5,
    axis=false,
    col = list(c("black")),
    names = c('rel 5.0 ','rel 13.0', 'rel 22.0', 'rel 34.0'),
    xlab='Dir-Dist Per Release',
    ylab = ''
)
