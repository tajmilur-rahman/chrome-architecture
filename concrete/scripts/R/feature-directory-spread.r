# How many directories a feature spreads into

fDirSpan5<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-5.rpt", header = T, sep = "|")
fDirSpan13<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-13.rpt", header = T, sep = "|")
fDirSpan22<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-22.rpt", header = T, sep = "|")
fDirSpan34<-read.table("/media/rupak/3164-9A73/rupak/software_architecture/reports/directory_span_by_feature-34.rpt", header = T, sep = "|")

par(mar=c(5,5,2,5),cex.axis=1.5,cex.lab=1.5)
beanplot(
    data.frame(fDirSpan5$count),
    data.frame(fDirSpan13$count),
    data.frame(fDirSpan22$count),
    data.frame(fDirSpan34$count),
    what = c(0,1,1,0),
    overallline = "median",
    bw=0.5,
    col = list(c("black")),
    names = c('rel 5.0 ','rel 13.0', 'rel 22.0', 'rel 34.0'),
    xlab='Directory Span for Features Per Release',
    ylab = 'Number of Directories (logged)',
    log = 'y'
)
