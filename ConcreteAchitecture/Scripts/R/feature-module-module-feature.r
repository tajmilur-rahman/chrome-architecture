mfSpread5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/module_feature_spread-5.rpt",header=T,sep="|")
fmSpread5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_module_spread-5.rpt",header=T,sep="|")
mfSpread13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/module_feature_spread-13.rpt",header=T,sep="|")
fmSpread13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_module_spread-13.rpt",header=T,sep="|")
mfSpread22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/module_feature_spread-22.rpt",header=T,sep="|")
fmSpread22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_module_spread-22.rpt",header=T,sep="|")
mfSpread34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/module_feature_spread-34.rpt",header=T,sep="|")
fmSpread34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/feature_module_spread-34.rpt",header=T,sep="|")

par(mar=c(5,5,2,5),cex.axis=1.5,cex.lab=1.5)
beanplot(
    data.frame(fmSpread5$cross_cutting_modules),
    data.frame(mfSpread5$cross_cutting_features),
    data.frame(fmSpread13$cross_cutting_modules),
    data.frame(mfSpread13$cross_cutting_features),
    data.frame(fmSpread22$cross_cutting_modules),
    data.frame(mfSpread22$cross_cutting_features),
    data.frame(fmSpread34$cross_cutting_modules),
    data.frame(mfSpread34$cross_cutting_features),
    what = c(0,1,1,0),
    overallline = "median",
    bw="sj",
    axis=false,
    side = "both",
    col = list(c("black"), c("grey")),
    names = c('rel 5.0 ','rel 13.0', 'rel 22.0', 'rel 34.0'),
    xlab='1 Feature Spans Y Modules/ 1 Module Contains Y Feature',
    ylab = '',
	log = 'y'
)
legend("topleft", lty=c(1,1), lwd=c(8,8), legend = c("1 Feature spans Y modules","1 Module contains Y features"), col=c("black","grey"))
