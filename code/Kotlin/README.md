# KotlinEO

The same as [Pythoneo](https://github.com/iblancasa/PythonEO), [Luneo](https://github.com/JJ/LunEO) and others.

### What do you need to run this?

You have to install Kotlin language (usually is a package called
kotlinc in Linux systems), but most probably you will need to install
SDKMAN!

    curl -s https://get.sdkman.io | bash

and then run this to install the kotlin compiler

    sdk install kotlin

#### Compiling and run

```bash
#Compliling onemax
kotlinc onemax.kt kotlineo.kt -include-runtime -d onemax.jar

#Compiling bitflip
kotlinc bitflip.kt kotlineo.kt -include-runtime -d bitflip.jar

#Compiling xover
kotlinc xover.kt kotlineo.kt -include-runtime -d xover.jar

#Run onemax
java -jar onemax.jar

#Run bitflip
java -jar bitflip.jar

#Run xover
java -jar xover.jar
```
