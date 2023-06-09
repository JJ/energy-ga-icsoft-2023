library(ggplot2)
library(ggthemes)

onemax <- read.csv("../code/data/pinpoint-vms-onemax-11-Apr-10-19-29.csv")
onemax$size <- as.factor(onemax$size)
ggplot(onemax, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+xlab("Seconds")+ylab("PKG consumption (Joules)") +theme_tufte()
ggsave("../preso/img/fig1-onemax-PKG-vs-seconds.png", width=12, height=8)


## ----r onemax.vms, echo=F, fig.cap="Boxplot of PKG measurements OneMax problem and the three different virtual machines.\\protect\\label{fig:onemax:energy}"----
ggplot(onemax, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+xlab("Chromosome size")+ylab("PKG consumption (Joules)")+theme_tufte()
ggsave("../preso/img/fig2-onemax-PKG-vs-size.png", width=12, height=8)

## ----r crossover, echo=F, fig.cap="PKG consumption, in Joules, vs. time in seconds, for the crossover and the three different virtual machines.\\protect\\label{fig:xover}"----
crossover <- read.csv("../code/data/pinpoint-vms-crossover-11-Apr-17-06-52.csv")
crossover$size <- as.factor(crossover$size)
ggplot(crossover, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+theme_tufte()
ggsave("../preso/img/fig3-over-PKG-vs-seconds.png", width=12, height=8)

## ----r crossover.energy, echo=F, fig.cap="Boxplot of PKG measurements for the crossover operator and the three different virtual machines.\\protect\\label{fig:crossover:energy}"----
ggplot(crossover, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()
ggsave("../preso/img/fig4-over-PKG-vs-size.png", width=12, height=8)
