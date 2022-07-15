path = file.path('/Users/emaansiddique/Desktop/Emaan\ Siddique/Work/LSE/extended\ essay/output/')
setwd(path)
data <- read.csv('public_fertilizer.csv')
data2 <- read.csv('public_fertilizer_output.csv')

# OUTPUT #

jpeg(file.path(path,"graphs/fertilizer/nbp_fertilizer_output.jpg"), width = 750, height = 475)
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
jpeg(file.path(path,"graphs/fertilizer/nbp_fertilizer_profit.jpg"), width = 750, height = 475)
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
jpeg(file.path(path,"graphs/fertilizer/nbp_fertilizer_rev.jpg"), width = 750, height = 475)
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
jpeg(file.path(path,"graphs/fertilizer/nbp_fertilizer_cost.jpg"), width = 750, height = 475)
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

