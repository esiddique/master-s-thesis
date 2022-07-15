path = file.path('/Users/emaansiddique/Desktop/Emaan\ Siddique/Work/LSE/extended\ essay/output/')
setwd(path)
cement <- read.csv('ff_cement.csv')

## CEMENT ## 

# PROFIT #
jpeg(file.path(path,"graphs/cement/ff_cement_profit.jpg"), width = 750, height = 475)
plot(cement$year, cement$T_profit, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(cement$T_profit,cement$C_profit),
            max(cement$T_profit,cement$C_profit)))
par(new = TRUE)
plot(cement$year, cement$C_profit, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Profit (PKR million)',
     ylim=c(min(cement$T_profit,cement$C_profit),
            max(cement$T_profit,cement$C_profit)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# REVENUE #
jpeg(file.path(path,"graphs/cement/ff_cement_rev.jpg"), width = 750, height = 475)
plot(cement$year, cement$T_rev, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(cement$T_rev,cement$C_rev),
            max(cement$T_rev,cement$C_rev)))
par(new = TRUE)
plot(cement$year, cement$C_rev, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Revenue (PKR million)',
     ylim=c(min(cement$T_rev,cement$C_rev),
            max(cement$T_rev,cement$C_rev)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()

# COST #
jpeg(file.path(path,"graphs/cement/ff_cement_cost.jpg"), width = 750, height = 475)
plot(cement$year, cement$T_cost, type='l', lty='solid', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(cement$T_cost,cement$C_cost),
            max(cement$T_cost,cement$C_cost)))
par(new = TRUE)
plot(cement$year, cement$C_cost, type='l', lty='dashed', lwd=2,
     xlab='Year', ylab='Cost (PKR million)',
     ylim=c(min(cement$T_cost,cement$C_cost),
            max(cement$T_cost,cement$C_cost)))
par(new = TRUE)
abline(v=2007, col='black', lwd=2)
legend("topleft",legend=c("Treated","Comparison"),col=c("black","black"),
       lty=1:2, cex=1, text.width=1.5)
dev.off()
