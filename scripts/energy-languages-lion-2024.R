## ----lion.setup, echo=F, message=F, fig.pos="h!tb", fig.height=4, fig.cap="Average running time and PKG (CPUs and memory) energy consumption generating 40K chromosomes for the three languages (represented with different colors); dot size is proportional to the logarithm of the chromosome size."----
library(dplyr)
library(ggplot2)
library(ggthemes)
generate.chromosomes.bun <- read.csv("../data/generate-chromosomes-bun-lion-24.csv")
generate.chromosomes.bun  %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.bun.avg

generate.chromosomes.zig <- read.csv("../data/lion-zig-gen-23-Feb-12-03-41.csv")
generate.chromosomes.zig %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.zig.avg

generate.chromosomes.kotlin <- read.csv("../data/generate-chromosomes-kotlin-lion-24.csv")
generate.chromosomes.kotlin %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.kotlin.avg

# Add labels for x and y axes
generate.chromosomes.bun.avg$size <- as.factor(generate.chromosomes.bun.avg$size)
generate.chromosomes.zig.avg$size <- as.factor(generate.chromosomes.zig.avg$size)
generate.chromosomes.kotlin.avg$size <- as.factor(generate.chromosomes.kotlin.avg$size)
ggplot(generate.chromosomes.bun.avg, aes(x=mean.seconds,y=mean.pkg,color="Bun"))+ geom_point(data=generate.chromosomes.bun.avg, aes(x=mean.seconds,y=mean.pkg,color="Bun",shape=size),size=4)+geom_line(linewidth=1)+geom_point(data=generate.chromosomes.zig.avg,aes(x=mean.seconds,y=mean.pkg,color="Zig",shape=size), size=4)+geom_line(data=generate.chromosomes.zig.avg,aes(x=mean.seconds,y=mean.pkg,color="Zig"),linewidth=1)+geom_point(data=generate.chromosomes.kotlin.avg,aes(x=mean.seconds,y=mean.pkg,color="Kotlin",shape=size),size=4)+geom_line(data=generate.chromosomes.kotlin.avg,aes(x=mean.seconds,y=mean.pkg,color="Kotlin"), linewidth=1)+ theme_clean()+scale_fill_manual(values=c("blue", "cyan4","pink"))+xlab("Average in seconds")+ylab("Average CPU+Memory consumption (Joules)")+ ggtitle("Baseline:chromosome generation")
ggsave("../preso/img/fig1-gen-PKG-vs-seconds.png", width=6, height=4.5)

## ----lion.combined.ops, echo=F, message=F, fig.pos="h!tb", fig.height=4, fig.cap="Running time and PKG energy consumption processing 40K chromosomes via crossover, mutation and ONEMAX for the three languages (represented with different colors); dot shape represents the chromosome size."----

combined.ops.bun <- read.csv("../data/lion-bun-22-Feb-13-55-23.csv")
generate.bun.avgs.seconds <- c(rep( generate.chromosomes.bun.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.bun.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.bun.avg$mean.seconds[3], 15))
combined.ops.bun$diff.seconds <- combined.ops.bun$seconds - generate.bun.avgs.seconds
generate.bun.avgs.pkg <- c(rep( generate.chromosomes.bun.avg$mean.pkg[1], 15),
                            rep( generate.chromosomes.bun.avg$mean.pkg[2], 15),
                            rep( generate.chromosomes.bun.avg$mean.pkg[3], 15))
combined.ops.bun$diff.PKG <- combined.ops.bun$PKG - generate.bun.avgs.pkg
combined.ops.bun$size <- as.factor(combined.ops.bun$size)

combined.ops.bun  %>% group_by( size ) %>% summarise( mean.pkg = mean( diff.PKG ), sd.pkg = sd(diff.PKG), mean.seconds = mean( diff.seconds ) ) -> combined.ops.bun.avg

combined.ops.zig <- read.csv("../data/lion-zig-ops-24-Feb-20-08-58.csv")
generate.zig.avgs.seconds <- c(rep( generate.chromosomes.zig.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.zig.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.zig.avg$mean.seconds[3], 15))
combined.ops.zig$diff.seconds <- combined.ops.zig$seconds - generate.zig.avgs.seconds
generate.zig.avgs.pkg <- c(rep( generate.chromosomes.zig.avg$mean.pkg[1], 15),
                            rep( generate.chromosomes.zig.avg$mean.pkg[2], 15),
                            rep( generate.chromosomes.zig.avg$mean.pkg[3], 15))
combined.ops.zig$diff.PKG <- combined.ops.zig$PKG - generate.zig.avgs.pkg
combined.ops.zig$size <- as.factor(combined.ops.zig$size)
combined.ops.zig %>% group_by( size ) %>% summarise( mean.pkg = mean( diff.PKG ), sd.pkg = sd( diff.PKG), mean.seconds = mean( diff.seconds ) ) -> combined.ops.zig.avg

combined.ops.kotlin <- read.csv("../data/lion-kt-ops-25-Feb-13-34-30.csv")
generate.kotlin.avgs.seconds <- c(rep( generate.chromosomes.kotlin.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.kotlin.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.kotlin.avg$mean.seconds[3], 15))
combined.ops.kotlin$diff.seconds <- combined.ops.kotlin$seconds - generate.kotlin.avgs.seconds
generate.kotlin.avgs.pkg <- c(rep( generate.chromosomes.kotlin.avg$mean.pkg[1], 15),
                            rep( generate.chromosomes.kotlin.avg$mean.pkg[2], 15),
                            rep( generate.chromosomes.kotlin.avg$mean.pkg[3], 15))
combined.ops.kotlin$diff.PKG <- combined.ops.kotlin$PKG - generate.kotlin.avgs.pkg
combined.ops.kotlin$size <- as.factor(combined.ops.kotlin$size)

combined.ops.kotlin %>% group_by( size ) %>% summarise( mean.pkg = mean( diff.PKG ), sd.pkg = sd(diff.PKG), mean.seconds = mean( diff.seconds ) ) -> combined.ops.kotlin.avg

ggplot(combined.ops.bun, aes(x=diff.seconds, y=diff.PKG, shape=size, color="bun")) +
  geom_point() +
  geom_point(data=combined.ops.zig, aes(x=diff.seconds, y=diff.PKG, shape=size, color="zig")) +
  geom_point(data=combined.ops.kotlin, aes(x=diff.seconds, y=diff.PKG, shape=size, color="kotlin"))+theme_economist()+xlab("Difference in seconds")+ylab("Difference in PKG, Joules")+ggtitle("Time/energy consumption combined ops")+scale_shape_manual(values=c(1,2,3))+scale_color_manual(values=c("bun"="red","zig"="blue","kotlin"="green"))
ggsave("../preso/img/fig2-ops-PKG-vs-seconds.png", width=6, height=4.5)


## ----lion.combined.ops.joules, echo=F, message=F--------------------------------------
library(kableExtra)

combined.ops.bun.avg$language <- "bun"
combined.ops.zig.avg$language <- "zig"
combined.ops.kotlin.avg$language <- "kotlin"

combined.ops <- rbind(combined.ops.bun.avg, combined.ops.zig.avg, combined.ops.kotlin.avg)
combined.ops$ops.joules <- 40000/ combined.ops$mean.pkg 
combined.ops$sd.ops.joules <- 40000/ combined.ops$sd.pkg
combined.ops %>% select( language, size, mean.pkg, sd.pkg, ops.joules ) %>% kable( digits = 2, col.names = c("Language","Size","PKG average","PKG SD", "Ops/Joule average"), caption = "Average operations per Joule in the combined operations experiment for the three languages." )


## ----lion.hiff, echo=F, message=F, fig.pos="h!tb", fig.height=4, fig.cap="Running time and PKG energy consumption computing the HIFF fitness function for 40K chromosomes for the three languages (represented with different colors); dot shape represents the chromosome size."----

hiff.bun <- read.csv("../data/pinpoint-v3-HIFF-13-Dec-09-06-34.csv")
hiff.bun %>% mutate( delta.pkg = PKG - generate.chromosomes.bun.avg$mean.pkg[ match( size, generate.chromosomes.bun.avg$size ) ], delta.seconds = seconds - generate.chromosomes.bun.avg$mean.seconds[ match( size, generate.chromosomes.bun.avg$size ) ] ) -> hiff.bun.delta
hiff.bun.delta$size <- as.factor(hiff.bun.delta$size)

hiff.zig <- read.csv("../data/lion-zig-hiff-27-Feb-13-04-04.csv")
hiff.zig %>% mutate( delta.pkg = PKG - generate.chromosomes.zig.avg$mean.pkg[ match( size, generate.chromosomes.zig.avg$size ) ], delta.seconds = seconds - generate.chromosomes.zig.avg$mean.seconds[ match( size, generate.chromosomes.zig.avg$size ) ] ) -> hiff.zig.delta
hiff.zig.delta$size <- as.factor(hiff.zig.delta$size)

hiff.kotlin <- read.csv("../data/lion-kt-hiff-27-Feb-09-41-42.csv")
hiff.kotlin %>% mutate( delta.pkg = PKG - generate.chromosomes.kotlin.avg$mean.pkg[ match( size, generate.chromosomes.kotlin.avg$size ) ], delta.seconds = seconds - generate.chromosomes.kotlin.avg$mean.seconds[ match( size, generate.chromosomes.kotlin.avg$size ) ] ) -> hiff.kotlin.delta
hiff.kotlin.delta$size <- as.factor(hiff.kotlin.delta$size)

ggplot(hiff.bun.delta, aes(x=delta.seconds, y=delta.pkg, shape=size,color="bun")) +
  geom_point() + geom_point(data=hiff.zig.delta, aes(x=delta.seconds, y=delta.pkg, shape=size, color="zig")) + geom_point(data=hiff.kotlin.delta, aes(x=delta.seconds, y=delta.pkg, shape=size, color="kotlin")) +
  labs(title="HIFF", x="Seconds", y="PKG") +
  theme_minimal()

ggsave("../preso/img/fig3-HIFF-PKG-vs-seconds.png", width=6, height=4.5)


## ----lion.hiff.boxplot, echo=F, message=F, warning=F, fig.pos="h!tb", fig.height=4, fig.cap="Boxplot of the energy consumption of the HIFF fitness function for 40K chromosomes for Kotlin and {\\protect\\sf zig}"----
kotlin.zig.hiff <- data.frame(
  language = c(rep("kotlin",nrow(hiff.kotlin.delta)), rep("zig",nrow(hiff.zig.delta))),
  delta.pkg = c(hiff.kotlin.delta$delta.pkg, hiff.zig.delta$delta.pkg),
  size=as.factor(c(hiff.kotlin.delta$size, hiff.zig.delta$size)) 
  )
ggplot(kotlin.zig.hiff, aes(x=size, y=delta.pkg, fill=language)) + geom_boxplot() + labs(title="HIFF", x="Size", y="PKG") + theme_minimal()
ggsave("../preso/img/fig4-HIFF-PKG-vs-size.png", width=6, height=4.5)

# wilcox.test(delta.pkg ~ language, data=kotlin.zig.hiff[kotlin.zig.hiff$size=="512",])
# wilcox.test(delta.pkg ~ language, data=kotlin.zig.hiff[kotlin.zig.hiff$size=="1024",])
# wilcox.test(delta.pkg ~ language, data=kotlin.zig.hiff[kotlin.zig.hiff$size=="2048",])


## ----lion.hiff.joules, echo=F, message=F----------------------------------------------
library(kableExtra)
hiff.bun.delta %>% group_by( size ) %>% summarise( mean.pkg = mean( delta.pkg ), sd.pkg = sd( delta.pkg), mean.seconds = mean( delta.seconds ) ) -> hiff.bun.avg
hiff.zig.delta %>% group_by( size ) %>% summarise( mean.pkg = mean( delta.pkg ), sd.pkg = sd( delta.pkg), mean.seconds = mean( delta.seconds ) ) -> hiff.zig.avg
hiff.kotlin.delta %>% group_by( size ) %>% summarise( mean.pkg = mean( delta.pkg ), sd.pkg = sd( delta.pkg), mean.seconds = mean( delta.seconds ) ) -> hiff.kotlin.avg

hiff.bun.avg$language <- "bun"
hiff.zig.avg$language <- "zig"
hiff.kotlin.avg$language <- "kotlin"

hiff <- rbind(hiff.bun.avg, hiff.zig.avg, hiff.kotlin.avg)
hiff$ops.joules <- 40000/ hiff$mean.pkg 
hiff$sd.ops.joules <- 40000/ hiff$sd.pkg
hiff %>% select( language, size, mean.pkg, sd.pkg, ops.joules ) %>% kable( digits = 2, col.names = c("Language","Size","PKG average","PKG SD", "Ops/Joule average"), caption = "Average operations per Joule in the HIFF experiment for the three languages." )

