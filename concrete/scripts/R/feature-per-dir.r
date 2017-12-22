# How many features contained by a directory

fPerDir5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-5.rpt", header = T, sep = "|")
fPerDir13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-13.rpt", header = T, sep = "|")
fPerDir22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-22.rpt", header = T, sep = "|")
fPerDir34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-34.rpt", header = T, sep = "|")

par(mar=c(5,5,2,5),cex.axis=1.5,cex.lab=1.5)
beanplot(
    data.frame(fPerDir5$feature_count),
    data.frame(fPerDir13$feature_count),
    data.frame(fPerDir22$feature_count),
    data.frame(fPerDir34$feature_count),
    what = c(0,1,1,0),
    overallline = "median",
    bw=0.5,
    col = list(c("black")),
    names = c('rel 5.0 ','rel 13.0', 'rel 22.0', 'rel 34.0'),
    xlab='Features per directory per Release',
    ylab = 'Number of Features',
    log = 'y'
)
