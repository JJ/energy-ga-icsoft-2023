## ----r onemax, echo=F, fig.show="hold", out.width="30%", fig.cap="Comparison between different versions of the VMs; left: node.js, center: bun, right:deno\\protect\\label{fig:onemax}"----
library(ggplot2)
library(ggthemes)
library(stringr)
onemax.icsoft <- read.csv("../code/data/pinpoint-vms-onemax-11-Apr-10-19-29.csv")
onemax.icsoft$size <- as.factor(onemax.icsoft$size)
onemax.icsoft$VM <- str_trim(onemax.icsoft$VM)
onemax <- read.csv("../code/data/pinpoint-vms-onemax-29-May-17-45-44.csv")
onemax$size <- as.factor(onemax$size)
onemax$VM <- str_trim(onemax$VM)
ggplot(onemax[onemax$VM == "node",], aes(x=seconds,y=PKG, color="May",fill=size,size=4))+geom_point(pch=22, stroke=1)+geom_point(data=onemax.icsoft[onemax.icsoft$VM == "node",],pch=21, stroke=1,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()
ggplot(onemax[onemax$VM == "bun",], aes(x=seconds,y=PKG, color="May",fill=size))+geom_point(pch=22, stroke=2)+geom_point(data=onemax.icsoft[onemax.icsoft$VM == "bun",],pch=21, stroke=2,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()
ggplot(onemax[onemax$VM == "deno",], aes(x=seconds,y=PKG, color="May",fill=size))+geom_point(pch=22, size=4, stroke=2)+geom_point(data=onemax.icsoft[onemax.icsoft$VM == "deno",],pch=21, size=4, stroke=2,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()


## ----r crossoverx, echo=F, fig.show="hold", out.width="30%", fig.cap="Consumption and time for the crossover operator in the three different VMs; node left, bun center, deno right.\\protect\\label{fig:crossover}"----
crossover.icsoft <- read.csv("../code/data/pinpoint-vms-crossover-11-Apr-17-06-52.csv")
crossover.icsoft$size <- as.factor(crossover.icsoft$size)
crossover.icsoft$VM <- str_trim(crossover.icsoft$VM)
crossover <- read.csv("../code/data/pinpoint-vms-crossover-29-May-18-49-13.csv")
crossover$size <- as.factor(crossover$size)
crossover$VM <- str_trim(crossover$VM)
ggplot(crossover[crossover$VM == "node",], aes(x=seconds,y=PKG, color="May",fill=size))+geom_point(pch=22, stroke=2)+geom_point(data=crossover.icsoft[crossover.icsoft$VM == "node",],pch=21, stroke=2,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()
ggplot(crossover[crossover$VM == "bun",], aes(x=seconds,y=PKG, color="May",fill=size))+geom_point(pch=22, stroke=2)+geom_point(data=crossover.icsoft[crossover.icsoft$VM == "bun",],pch=21, stroke=2,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()
ggplot(crossover[crossover$VM == "deno",], aes(x=seconds,y=PKG, color="May",fill=size))+geom_point(pch=22, size=4, stroke=2)+geom_point(data=crossover.icsoft[crossover.icsoft$VM == "deno",],pch=21, size=4, stroke=2,aes(x=seconds,y=PKG,color="March",fill=size))+theme_tufte()


## ----r onemax.vms, echo=F, fig.height=4, fig.cap="Boxplot of PKG measurements for the OneMax fitness function and the three different virtual machines.\\protect\\label{fig:onemax:energy}"----
ggplot(onemax, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()


## ----r crossover, echo=F, fig.height=4, fig.cap="PKG consumption for the crossover and the three different virtual machines, shown as a boxplot.\\protect\\label{fig:xover:vms}"----
ggplot(crossover, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()


## ----r mutation, echo=F, fig.height=4, fig.cap="PKG consumption for the mutation operator and the three different virtual machines, shown as a boxplot.\\protect\\label{fig:mutation:vms}"----
mutation <- read.csv("../code/data/pinpoint-vms-mutation-30-May-09-29-50.csv")
mutation$size <- as.factor(mutation$size)
mutation$VM <- str_trim(mutation$VM)
ggplot(mutation, aes(x=size,y=PKG))+geom_boxplot(aes(fill=VM))+ylim(0, NA)+theme_tufte()


## ----r intel.onemax, echo=F, message=FALSE,fig.show="hold", out.width="50%", fig.height=5, fig.cap="Cores consumption for the onemax fitness function and the three different virtual machines, shown as a notched boxplot; cores component (left) and RAM component (right). Please observe that the scales in the y axes are different.\\protect\\label{fig:onemax:intel}"----
onemax.intel <- read.csv("../code/data/pinpoint-intel-vms-onemax-2-Jun-12-07-14.csv")
onemax.intel$size <- as.factor(onemax.intel$size)
onemax.intel$VM <- str_trim(onemax.intel$VM)
ggplot(onemax.intel, aes(x=size,y=cores))+geom_boxplot(aes(fill=VM),notch=T)+ylim(0, NA)+theme_tufte()
ggplot(onemax.intel, aes(x=size,y=RAM))+geom_boxplot(aes(fill=VM),notch=T)+ylim(0, NA)+theme_tufte()


## ----r times.energy, message=F, echo=F----------------------------------------
library(dplyr)
library(kableExtra)

onemax.intel$PKG <- onemax.intel$RAM+ onemax.intel$cores
onemax.intel.means <- onemax.intel %>% group_by(VM,size) %>% summarise( across(c(seconds,PKG),mean))
onemax.means <- onemax %>% group_by(VM,size) %>% summarise( across(c(seconds,PKG),mean))
onemax.all.means <- onemax.means
onemax.all.means$Intel.seconds <- onemax.intel.means$seconds
onemax.all.means$Intel.PKG <- onemax.intel.means$PKG
kable(onemax.all.means,col.names = c("VM","Size","AMD - s","AMD - J", "Intel - s", "Intel - J"), caption="Comparing times and cost for an AMD desktop and Intel-based laptop (see text for specs). These are average times and energy consumption, in seconds and Joules, respectively.\\protect\\label{tab:onemax}")

