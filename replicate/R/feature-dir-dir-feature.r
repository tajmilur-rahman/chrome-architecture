select median(dist) as dir_dist from directory_dist where release=5.0 group by switch_set;

fDirSpan5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-5.rpt", header = T, sep = "|")
fDirSpan13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-13.rpt", header = T, sep = "|")
fDirSpan22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-22.rpt", header = T, sep = "|")
fDirSpan34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-34.rpt", header = T, sep = "|")

fPerDir5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-5.rpt", header = T, sep = "|")
fPerDir13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-13.rpt", header = T, sep = "|")
fPerDir22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-22.rpt", header = T, sep = "|")
fPerDir34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/features_per_dir-34.rpt", header = T, sep = "|")

par(mar=c(5,5,2,5),cex.axis=1.5,cex.lab=1.5)
beanplot(
    data.frame(fDirSpan5$count),
    data.frame(fPerDir5$feature_count),
    data.frame(fDirSpan13$count),
    data.frame(fPerDir13$feature_count),
    data.frame(fDirSpan22$count),
    data.frame(fPerDir22$feature_count),
    data.frame(fDirSpan34$count),
    data.frame(fPerDir34$feature_count),
    what = c(0,1,1,0),
    overallline = "median",
    bw=1,
    axis=false,
    side = "both",
    col = list(c("black"), c("grey")),
    names = c('rel 5.0 ','rel 13.0', 'rel 22.0', 'rel 34.0'),
    xlab='1 feature spans Y dir/ 1 dir contains Y feature',
    ylab = 'Number of Dir / Features (logged)',
    log = 'y'
)
legend("topleft", lty=c(1,1), lwd=c(8,8), legend = c("1 Feature spans Y directories","1 directory contains Y features"), col=c("black","grey"))
