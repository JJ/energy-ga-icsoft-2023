library(ggplot2)
library(ggthemes)

onemax <- read.csv("../code/data/pinpoint-vms-onemax-11-Apr-10-19-29.csv")
onemax$size <- as.factor(onemax$size)
ggplot(onemax, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+xlab("Seconds")+ylab("PKG consumption (Joules)") +theme_tufte()
ggsave("../preso/img/fig1-onemax-PKG-vs-seconds.png", width=12, height=8)


ggplot(onemax, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+xlab("Chromosome size")+ylab("PKG consumption (Joules)")+theme_tufte()
ggsave("../preso/img/fig2-onemax-PKG-vs-size.png", width=12, height=8)

crossover <- read.csv("../code/data/pinpoint-vms-crossover-11-Apr-17-06-52.csv")
crossover$size <- as.factor(crossover$size)
ggplot(crossover, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+theme_tufte()
ggsave("../preso/img/fig3-over-PKG-vs-seconds.png", width=12, height=8)

ggplot(crossover, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()
ggsave("../preso/img/fig4-over-PKG-vs-size.png", width=12, height=8)
