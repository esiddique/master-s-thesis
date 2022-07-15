path = file.path('/Users/emaansiddique/Desktop/Emaan\ Siddique/Work/LSE/extended\ essay/output/')
setwd(path)
fertilizer <- read.csv('ff_fertilizer.csv')
data2 <- read.csv('ff_fertilizer_output.csv')

## FERTILIZER ## 

# OUTPUT #

jpeg(file.path(path,"graphs/fertilizer/ff_fertilizer_output.jpg"), width = 750, height = 475)
plot(data2$year, data2$T_output, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Output (tonnes)',
     ylim=c(min(data2$T_output,data2$C_output),
            max(data2$T_output,data2$C_output)))
par(new = TRUE)
plot(data2$year, data2$C_output, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Output (tonnes)',
     ylim=c(min(data2$T_output,data2$C_output),
            max(data2$T_output,data2$C_output)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topright",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# PROFIT #
jpeg("graphs/fertilizer/ff_fertilizer_profit.jpg", width = 750, height = 475)
plot(fertilizer$year, fertilizer$T_profit, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(fertilizer$T_profit,fertilizer$C_profit),
            max(fertilizer$T_profit,fertilizer$C_profit)))
par(new = TRUE)
plot(fertilizer$year, fertilizer$C_profit, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(fertilizer$T_profit,fertilizer$C_profit),
            max(fertilizer$T_profit,fertilizer$C_profit)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# REVENUE #
jpeg("graphs/fertilizer/ff_fertilizer_rev.jpg", width = 750, height = 475)
plot(fertilizer$year, fertilizer$T_rev, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(fertilizer$T_rev,fertilizer$C_rev),
            max(fertilizer$T_rev,fertilizer$C_rev)))
par(new = TRUE)
plot(fertilizer$year, fertilizer$C_rev, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(fertilizer$T_rev,fertilizer$C_rev),
            max(fertilizer$T_rev,fertilizer$C_rev)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# COST #
jpeg("graphs/fertilizer/ff_fertilizer_cost.jpg", width = 750, height = 475)
plot(fertilizer$year, fertilizer$T_cost, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(fertilizer$T_cost,fertilizer$C_cost),
            max(fertilizer$T_cost,fertilizer$C_cost)))
par(new = TRUE)
plot(fertilizer$year, fertilizer$C_cost, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(fertilizer$T_cost,fertilizer$C_cost),
            max(fertilizer$T_cost,fertilizer$C_cost)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()


