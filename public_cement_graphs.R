path = file.path('/Users/emaansiddique/Desktop/Emaan\ Siddique/Work/LSE/extended\ essay/output/')
setwd(path)
data <- read.csv('public_cement.csv')

# PROFIT #
jpeg(file.path(path,"graphs/cement/nbp_cement_profit.jpg"), width = 750, height = 475)
plot(data$year, data$T_profit, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(data$T_profit,data$C_profit),
            max(data$T_profit,data$C_profit)))
par(new = TRUE)
plot(data$year, data$C_profit, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(data$T_profit,data$C_profit),
            max(data$T_profit,data$C_profit)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# REVENUE #
jpeg(file.path(path,"graphs/cement/nbp_cement_rev.jpg"), width = 750, height = 475)
plot(data$year, data$T_rev, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(data$T_rev,data$C_rev),
            max(data$T_rev,data$C_rev)))
par(new = TRUE)
plot(data$year, data$C_rev, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(data$T_rev,data$C_rev),
            max(data$T_rev,data$C_rev)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# COST #
jpeg(file.path(path,"graphs/cement/nbp_cement_cost.jpg"), width = 750, height = 475)
plot(data$year, data$T_cost, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(data$T_cost,data$C_cost),
            max(data$T_cost,data$C_cost)))
par(new = TRUE)
plot(data$year, data$C_cost, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(data$T_cost,data$C_cost),
            max(data$T_cost,data$C_cost)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()


