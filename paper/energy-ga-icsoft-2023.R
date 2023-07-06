## ----r pinpoint, echo=F-------------------------------------------------------
library(ggplot2)
library(ggthemes)
test.pinpoint <- read.csv("../code/data/pinpoint-sets-29-Mar-21-06-12.csv")


## ----r pinpoint.gpu, echo=F, fig.cap="Boxplot of measurements of energy expenditures by the GPU in the sets problem. GPU energy consumption is measured in Joules.\\protect\\label{fig:gpu}"----
test.pinpoint$size <- as.factor(test.pinpoint$size)
ggplot(test.pinpoint, aes(x=size,y=GPU,group=size))+geom_boxplot()


## ----r likwid, echo=F, fig.cap="Boxplot of (differential) measurements of energy consumption as measured by the CORE and PKG (package) registers, both measured in Joules.\\protect\\label{fig:likwid}"----
test.likwid <- read.csv("../code/data/likwid-sets-10-Apr-12-54-28.csv")
test.likwid$size <- as.factor(test.likwid$size)
ggplot(test.likwid, aes(x=size,y=CORE,group=size))+geom_boxplot()
ggplot(test.likwid, aes(x=size,y=PKG,group=size))+geom_boxplot()


## ----r pkg.core, echo=F, fig.cap="Relationship between CORE and PACKAGE consumption (x and y axis, respectively.\\protect\\label{fig:corepkg}"----
ggplot(test.likwid, aes(x=PKG,y=CORE,color=size))+geom_point()


## ----r pinpoint.likwid, echo=F, fig.cap="Relationship between PKG measurements taken by pinpoint and likwid.\\protect\\label{fig:pinlik}"----
pinlik <- data.frame(tool=c(rep("pinpoint",45),rep("likwid",48)),
                     size=c(c(rep("1024",15),rep("2048",15),rep("4096",15)),c(rep("1024",16),rep("2048",16),rep("4096",16))),
                     PKG=c(test.pinpoint$PKG,test.likwid$PKG))
ggplot(pinlik, aes(x=tool,y=PKG))+geom_boxplot(aes(fill=size))


## ----r perf, echo=F, fig.cap="Relationship between PKG measurements taken by pinpoint and perf, with boxplots with values for the three set sizes.\\protect\\label{fig:pinperf}"----
test.perf <- read.csv("../code/data/perfstat-deno-sets-30-Mar-14-51-25.csv")
pinperf <- data.frame(tool=c(rep("pinpoint",45),rep("perf",47)),
                     size=c(c(rep("1024",15),rep("2048",15),rep("4096",15)),c(rep("1024",16),rep("2048",16),rep("4096",15))),
                     PKG=c(test.pinpoint$PKG,test.perf$PKG))
ggplot(pinperf, aes(x=tool,y=PKG))+geom_boxplot(aes(fill=size))


## ----r sets.vms, echo=F, fig.cap="PKG measurements for the set problem and the three different virtual machines.\\protect\\label{fig:testvms}"----
sets.vms <- read.csv("../code/data/pinpoint-vms-sets-10-Apr-17-59-56.csv")
sets.vms$size <- as.factor(sets.vms$size)
ggplot(sets.vms, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))
sets.vms$Joules.Second <- sets.vms$PKG / sets.vms$seconds


## ----r sets.vms.jouls, echo=F, fig.cap="Boxplot of energy consumption per second, in Joules/s.\\protect\\label{fig:jouls}"----
ggplot(sets.vms, aes(x=size,y=Joules.Second))+geom_boxplot(aes(fill=VM))


## ----r onemax, echo=F, fig.cap="Boxplot of energy consumption vs. time taken for all three sizes and VMs.\\protect\\label{fig:onemax}"----
onemax <- read.csv("../code/data/pinpoint-vms-onemax-11-Apr-10-19-29.csv")
onemax$size <- as.factor(onemax$size)
ggplot(onemax, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+theme_tufte()


## ----r onemax.vms, echo=F, fig.cap="Boxplot of PKG measurements OneMax problem and the three different virtual machines.\\protect\\label{fig:onemax:energy}"----
ggplot(onemax, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()
onemax$kwh <- onemax$PKG * 2.77778e-7
onemax$cost.Spain <- onemax$kwh * 20


## ----r onemax.cost, echo=F, message=F-----------------------------------------
library(dplyr)
onemax.cost <- onemax %>% group_by( size, VM) %>% summarise( average = mean( cost.Spain ), sd = sd( cost.Spain))
library(kableExtra)
kable(onemax.cost, caption="Estimated cost of the OneMax runs for every VM and size, in €-cents. \\protect\\label{tab:onemax:cost}")


## ----r crossover, echo=F, fig.cap="PKG consumption, in Joules, vs. time in seconds, for the crossover and the three different virtual machines.\\protect\\label{fig:xover}"----
crossover <- read.csv("../code/data/pinpoint-vms-crossover-11-Apr-17-06-52.csv")
crossover$size <- as.factor(crossover$size)
ggplot(crossover, aes(x=seconds,y=PKG))+geom_point(size=3,aes(color=size,fill=size,shape=VM))+theme_tufte()


## ----r crossover.energy, echo=F, fig.cap="Boxplot of PKG measurements for the crossover operator and the three different virtual machines.\\protect\\label{fig:crossover:energy}"----
ggplot(crossover, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()

