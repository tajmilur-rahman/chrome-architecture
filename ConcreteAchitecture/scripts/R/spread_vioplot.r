mfSpread5<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/module_feature_spread-5.rpt",header=T,sep="|")
fmSpread5<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/feature_module_spread-5.rpt",header=T,sep="|")
mfSpread13<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/module_feature_spread-13.rpt",header=T,sep="|")
fmSpread13<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/feature_module_spread-13.rpt",header=T,sep="|")
mfSpread22<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/module_feature_spread-22.rpt",header=T,sep="|")
fmSpread22<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/feature_module_spread-22.rpt",header=T,sep="|")
mfSpread34<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/module_feature_spread-34.rpt",header=T,sep="|")
fmSpread34<-read.table("/Users/pcr/Dropbox/GitHub/toggle_arch/reports/feature_module_spread-34.rpt",header=T,sep="|")

opar <- par(cex.axis = 1, cex.main = 1.5, cex.lab = 1.5, cex.sub = 1.5)
pdf('~/Dropbox/GitHub/toggle_arch/paper/emse/figure/feature_touches_modules.pdf')
#Left side: 1 Feature touches Y modules"
vioplot2log( 
  fmSpread5$cross_cutting_modules,
  fmSpread13$cross_cutting_modules,
  fmSpread22$cross_cutting_modules,
  fmSpread34$cross_cutting_modules,
  #side = 'left', 
  col = 'white',
  names = c("5.0", "13.0", "22.0", "34.0")
)
title(ylab = 'Number of Modules Touched (log)', xlab = "Release Number")
dev.off()

opar <- par(cex.axis = 1, cex.main = 1.5, cex.lab = 1.5, cex.sub = 1.5)
pdf('~/Dropbox/GitHub/toggle_arch/paper/emse/figure/module_contains_features.pdf')
#1 Module contains Y features
vioplot2log(
  mfSpread5$cross_cutting_features,
  mfSpread13$cross_cutting_features,
  mfSpread22$cross_cutting_features,
  mfSpread34$cross_cutting_features,
  #side = 'right', add = TRUE, rectCol = 'grey',
  col = 'white', 
  names = c("5.0", "13.0", "22.0", "34.0")
)
title(ylab = 'Number of Features Contained (log)', xlab = "Release Number")
dev.off()


#legend("topleft", lty=c(1,1), lwd=c(8,8), 
#  legend = c("Left side: 1 Feature spans Y modules","Right side: 1 Module contains Y features"), col=c("black","grey"))


length(fmSpread5$cross_cutting_modules)
summary(fmSpread5$cross_cutting_modules)
length(fmSpread13$cross_cutting_modules)
summary(fmSpread13$cross_cutting_modules)
length(fmSpread22$cross_cutting_modules)
summary(fmSpread22$cross_cutting_modules)
length(fmSpread34$cross_cutting_modules)
summary(fmSpread34$cross_cutting_modules)
length(mfSpread5$cross_cutting_features)
summary(mfSpread5$cross_cutting_features)
length(mfSpread13$cross_cutting_features)
summary(mfSpread13$cross_cutting_features)
length(mfSpread22$cross_cutting_features)
summary(mfSpread22$cross_cutting_features)
length(mfSpread34$cross_cutting_features)
summary(mfSpread34$cross_cutting_features)
