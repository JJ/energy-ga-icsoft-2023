## ----evostar.zig.gen, echo=F, message=F, fig.pos="h!tb", fig.height=3, fig.cap="Average running time and PKG energy consumption generating 40K chromosomes for the different parametrizations used (represented with different colors); dot shape represents the chromosome size."----
library(ggplot2)

generate.chromosomes <- read.csv("../data/evostar-zig-gen-19-Mar-09-31-21.csv")
generate.chromosomes$size <- as.factor(generate.chromosomes$size)

generate.chromosomes.bool <- read.csv("../data/evostar-zig-gen-bool-19-Mar-09-30-40.csv")
generate.chromosomes.bool$size <- as.factor(generate.chromosomes.bool$size)

generate.chromosomes.bitset <- read.csv("../data/evostar-zig-bitset-gen-20-Mar-12-18-47.csv")
generate.chromosomes.bitset$size <- as.factor(generate.chromosomes.bitset$size)

generate.chromosomes.mac <- read.csv("../data/evostar-mac-gen-19-Mar-11-05-41.csv")
generate.chromosomes.mac$PKG <- generate.chromosomes.mac$ECPU + generate.chromosomes.mac$PCPU + generate.chromosomes.mac$RAM
generate.chromosomes.mac$size <- as.factor(generate.chromosomes.mac$size)

generate.chromosomes.mac.bool <- read.csv("../data/evostar-mac-gen-bool-19-Mar-10-33-29.csv")
generate.chromosomes.mac.bool$PKG <- generate.chromosomes.mac.bool$ECPU + generate.chromosomes.mac.bool$PCPU + generate.chromosomes.mac.bool$RAM
generate.chromosomes.mac.bool$size <- as.factor(generate.chromosomes.mac.bool$size)

ggplot(generate.chromosomes, aes(x=seconds, y=PKG, color="Baseline", shape=size,size=2)) +
  geom_point() +
  geom_point(data=generate.chromosomes.bitset, aes(x=seconds, y=PKG, color="BitSet", shape=size)) +
  geom_point(data=generate.chromosomes.bool, aes(x=seconds, y=PKG, color="Boolean", shape=size)) +
  geom_point(data=generate.chromosomes.mac, aes(x=seconds, y=PKG, color="Mac Baseline", shape=size)) +
  geom_point(data=generate.chromosomes.mac.bool, aes(x=seconds, y=PKG, color="Mac Boolean", shape=size)) +
  scale_color_manual(values=c("black", "red", "blue", "green","pink")) +
  labs(title="Running time and PKG energy consumption generating 40K chromosomes",
       x="Running time (s)", y="PKG (Joules)") +
  theme(axis.text=element_text(size=14), axis.title=element_text(size=17), legend.text=element_text(size=14))
  theme_minimal()
save(generate.chromosomes,file="zig-evostar-Fig-1-generate-chromosomes.RData")

## ----evostar.combined.ops.base, echo=F, message=F, fig.pos="h!tb", fig.height=3, fig.cap="Boxplot of PKG energy consumption processing 40K chromosomes via crossover, mutation and ONEMAX for different combinations of optimization techniques and platforms in Zig"----
library(dplyr)

generate.chromosomes %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.avg
generate.avgs.seconds <- c(rep( generate.chromosomes.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.avg$mean.seconds[3], 15))
generate.avgs.pkg <- c(rep( generate.chromosomes.avg$mean.pkg[1], 15),
                           rep( generate.chromosomes.avg$mean.pkg[2], 15),
                           rep( generate.chromosomes.avg$mean.pkg[3], 15))

combined.ops <- read.csv("../data/evostar-zig-ops-19-Mar-09-32-38.csv")
combined.ops$size <- as.factor(combined.ops$size)

combined.ops$diff.seconds <- combined.ops$seconds - generate.avgs.seconds
combined.ops$diff.PKG <- combined.ops$PKG - generate.avgs.pkg

generate.chromosomes.bool %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.bool.avg
generate.bool.avgs.seconds <- c(rep( generate.chromosomes.bool.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.bool.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.bool.avg$mean.seconds[3], 15))
generate.bool.avgs.pkg <- c(rep( generate.chromosomes.bool.avg$mean.pkg[1], 15),
                           rep( generate.chromosomes.bool.avg$mean.pkg[2], 15),
                           rep( generate.chromosomes.bool.avg$mean.pkg[3], 15))

combined.ops.bool <- read.csv("../data/evostar-zig-ops-bool-19-Mar-09-29-42.csv")
combined.ops.bool$size <- as.factor(combined.ops.bool$size)

combined.ops.bool$diff.seconds <- combined.ops.bool$seconds - generate.bool.avgs.seconds
combined.ops.bool$diff.PKG <- combined.ops.bool$PKG - generate.bool.avgs.pkg

generate.chromosomes.mac %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.mac.avg
generate.mac.avgs.seconds <- c(rep( generate.chromosomes.mac.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.mac.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.mac.avg$mean.seconds[3], 15))
generate.mac.avgs.pkg <- c(rep( generate.chromosomes.mac.avg$mean.pkg[1], 15),
                           rep( generate.chromosomes.mac.avg$mean.pkg[2], 15),
                           rep( generate.chromosomes.mac.avg$mean.pkg[3], 15))

combined.ops.mac <- read.csv("../data/evostar-mac-ops-19-Mar-10-39-59.csv")
combined.ops.mac$PKG <- combined.ops.mac$ECPU + combined.ops.mac$PCPU + combined.ops.mac$RAM
combined.ops.mac$size <- as.factor(combined.ops.mac$size)
combined.ops.mac$diff.seconds <- combined.ops.mac$seconds - generate.mac.avgs.seconds
combined.ops.mac$diff.PKG <- combined.ops.mac$PKG - generate.mac.avgs.pkg
combined.ops.mac$Platform <- combined.ops.mac$Prefix

generate.chromosomes.mac.bool %>% group_by( size ) %>% summarise( mean.pkg = mean( PKG ), mean.seconds = mean( seconds ) ) -> generate.chromosomes.mac.bool.avg
generate.mac.bool.avgs.seconds <- c(rep( generate.chromosomes.mac.bool.avg$mean.seconds[1], 15),
                               rep( generate.chromosomes.mac.bool.avg$mean.seconds[2], 15),
                               rep( generate.chromosomes.mac.bool.avg$mean.seconds[3], 15))
generate.mac.bool.avgs.pkg <- c(rep( generate.chromosomes.mac.bool.avg$mean.pkg[1], 15),
                           rep( generate.chromosomes.mac.bool.avg$mean.pkg[2], 15),
                           rep( generate.chromosomes.mac.bool.avg$mean.pkg[3], 15))
combined.ops.mac.bool <- read.csv("../data/evostar-mac-ops-bool-19-Mar-10-36-18.csv")
combined.ops.mac.bool$PKG <- combined.ops.mac.bool$ECPU + combined.ops.mac.bool$PCPU + combined.ops.mac.bool$RAM
combined.ops.mac.bool$size <- as.factor(combined.ops.mac.bool$size)
combined.ops.mac.bool$diff.seconds <- combined.ops.mac.bool$seconds - generate.mac.bool.avgs.seconds
combined.ops.mac.bool$diff.PKG <- combined.ops.mac.bool$PKG - generate.mac.bool.avgs.pkg
combined.ops.mac.bool$Platform <- combined.ops.mac.bool$Prefix

all.combined.ops <- data.frame( Platform = c( combined.ops.mac$Platform, combined.ops.mac.bool$Platform, combined.ops$Platform, combined.ops.bool$Platform ),
                                size = c( combined.ops.mac$size, combined.ops.mac.bool$size, combined.ops$size, combined.ops.bool$size ),
                                diff.seconds = c( combined.ops.mac$diff.seconds, combined.ops.mac.bool$diff.seconds, combined.ops$diff.seconds, combined.ops.bool$diff.second ),
                                diff.PKG = c( combined.ops.mac$diff.PKG, combined.ops.mac.bool$diff.PKG, combined.ops$diff.PKG, combined.ops.bool$diff.PKG ) )

ds <- ggplot( data = all.combined.ops, aes( x = size, y = diff.PKG, fill=Platform ) ) +
  geom_boxplot()  +
  theme(axis.text=element_text(size=100), axis.title=element_text(size=90), legend.text=element_text(size=90))+
  labs( title = "Energy consumption difference between different platforms/data structures for zig", y = "Energy consumption difference (seconds)" )+
  theme_minimal()
save(all.combined.ops,file="zig-evostar-Fig-2-data-structures.RData")
ggsave("zig-evostar-Fig-2-data-structures.png", width=2400, height=1800, units="px",dpi=300,plot=ds)

## ----evostar.combined.ops.refactor, echo=F, message=F, fig.pos="h!tb", fig.height=3, fig.cap="Boxplot of PKG energy consumption processing 40K chromosomes via crossover, mutation and ONEMAX after crossover has been refactored"----

combined.ops.noalloc <- read.csv("../data/evostar-zig-ops-nx-noalloc-20-Mar-09-46-37.csv")
combined.ops.noalloc$size <- as.factor(combined.ops.noalloc$size)
combined.ops.noalloc$diff.seconds <- combined.ops.noalloc$seconds - generate.avgs.seconds
combined.ops.noalloc$diff.PKG <- combined.ops.noalloc$PKG - generate.avgs.pkg
combined.ops.noalloc$Platform <- "Base"

combined.ops.noalloc.bool <- read.csv("../data/evostar-zig-bool-ops-nx-noalloc-20-Mar-09-45-48.csv")
combined.ops.noalloc.bool$size <- as.factor(combined.ops.noalloc.bool$size)
combined.ops.noalloc.bool$diff.seconds <- combined.ops.noalloc.bool$seconds - generate.bool.avgs.seconds
combined.ops.noalloc.bool$diff.PKG <- combined.ops.noalloc.bool$PKG - generate.bool.avgs.pkg
combined.ops.noalloc.bool$Platform <- "Bool"

combined.ops.mac.noalloc <- read.csv("../data/evostar-zig-mac-ops-nx-noalloc-20-Mar-09-52-13.csv")
combined.ops.mac.noalloc$PKG <- combined.ops.mac.noalloc$ECPU + combined.ops.mac.noalloc$PCPU + combined.ops.mac.noalloc$RAM
combined.ops.mac.noalloc$size <- as.factor(combined.ops.mac.noalloc$size)
combined.ops.mac.noalloc$diff.seconds <- combined.ops.mac.noalloc$seconds - generate.mac.avgs.seconds
combined.ops.mac.noalloc$diff.PKG <- combined.ops.mac.noalloc$PKG - generate.mac.avgs.pkg
combined.ops.mac.noalloc$Platform <- "Mac Base"

combined.ops.mac.noalloc.bool <- read.csv("../data/evostar-zig-mac-bool-ops-nx-noalloc-20-Mar-09-50-15.csv")
combined.ops.mac.noalloc.bool$PKG <- combined.ops.mac.noalloc.bool$ECPU + combined.ops.mac.noalloc.bool$PCPU + combined.ops.mac.noalloc.bool$RAM
combined.ops.mac.noalloc.bool$size <- as.factor(combined.ops.mac.noalloc.bool$size)
combined.ops.mac.noalloc.bool$diff.seconds <- combined.ops.mac.noalloc.bool$seconds - generate.mac.bool.avgs.seconds
combined.ops.mac.noalloc.bool$diff.PKG <- combined.ops.mac.noalloc.bool$PKG - generate.mac.bool.avgs.pkg
combined.ops.mac.noalloc.bool$Platform <- "Mac Bool"

all.combined.ops.noalloc <- data.frame( Platform = c( combined.ops.mac.noalloc$Platform, combined.ops.mac.noalloc.bool$Platform, combined.ops.noalloc$Platform, combined.ops.noalloc.bool$Platform ),
                                size = c( combined.ops.mac.noalloc$size, combined.ops.mac.noalloc.bool$size, combined.ops.noalloc$size, combined.ops.noalloc.bool$size ),
                                diff.seconds = c( combined.ops.mac.noalloc$diff.seconds, combined.ops.mac.noalloc.bool$diff.seconds, combined.ops.noalloc$diff.seconds, combined.ops.noalloc.bool$diff.seconds ),
                                diff.PKG = c( combined.ops.mac.noalloc$diff.PKG, combined.ops.mac.noalloc.bool$diff.PKG, combined.ops.noalloc$diff.PKG, combined.ops.noalloc.bool$diff.PKG ) )

alloc.plot <- ggplot( data = all.combined.ops.noalloc, aes( x = size, y = diff.PKG, fill=Platform ) ) +
  geom_boxplot() +
  labs( title = "Energy consumption after no-alloc refactoring", y = "Energy consumption difference (PKG)" ) +
  theme(axis.text=element_text(size=100), axis.title=element_text(size=90), legend.text=element_text(size=90))+
  theme_minimal()
save(all.combined.ops.noalloc, file="zig-evostar-Fig-3-alloc-crossover.RData")
ggsave("zig-evostar-Fig-3-alloc-crossover.png", width=2400, height=1800, units="px",dpi=300,plot=alloc.plot)

# New for presentation

all.combined.ops <- rbind(all.combined.ops, all.combined.ops.noalloc)
all.combined.ops <- all.combined.ops[grepl("mac", all.combined.ops$Platform, ignore.case = TRUE),]
save(all.combined.ops, file="zig-evostar-Fig-4-mac-ops.RData")
all.combined.ops.plot <- ggplot( data = all.combined.ops, aes( x = size, y = diff.PKG, fill=Platform ) ) +
  geom_boxplot(notch=TRUE) +
  labs( title = "Mac Energy consumption before/after no-alloc refactoring", y = "Energy consumption difference (PKG)" ) +
  theme(axis.text=element_text(size=100), axis.title=element_text(size=90), legend.text=element_text(size=90))+
  theme_minimal()

ggsave("zig-evostar-Fig-4-mac-ops.png", width=2400, height=1800, units="px",dpi=300,plot=all.combined.ops.plot)

all.combined.ops %>% group_by(Platform, size) %>% summarise(mean=mean(diff.PKG), sd=sd(diff.PKG)) %>% arrange(Platform, size) -> summary.all.combined.ops
save(summary.all.combined.ops, file="zig-evostar-Fig-4-mac-ops-summary.RData")
library(knitr)
# 2 precision digits table
summary.all.combined.ops %>% kable(digits=2)
