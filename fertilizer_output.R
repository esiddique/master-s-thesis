path = file.path('/Users/emaansiddique/Desktop/Emaan\ Siddique/Work/LSE/extended\ essay/output/')
setwd(path)
data <- read.csv('fertilizer_output.csv')

# AGL/FFC+FFBL #
jpeg(file.path(path,"graphs/fertilizer/fertilizer_output.jpg"), width = 750, height = 475)
plot(data$year, data$AGL, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Production (tonnes)',
     ylim=c(min(data$AGL,data$FFC_FFBL),
            max(data$AGL,data$FFC_FFBL)))
par(new = TRUE)
plot(data$year, data$FFC_FFBL, type='l', lty='dotted', lwd=2,
     xlab='Year', ylab='Production (tonnes)',
     ylim=c(min(data$AGL,data$FFC_FFBL),
            max(data$AGL,data$FFC_FFBL)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topright",legend=c("AGL","FFC/FFBL"),col=c("black","black"),
       lty=2:3, cex=1, text.width=1.25)
dev.off()