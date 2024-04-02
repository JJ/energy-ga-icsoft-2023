# Examining energy consumption of evolutionary algorithms in different platforms

[![Test zig](https://github.com/JJ/energy-ga-icsoft-2023/actions/workflows/zig.yml/badge.svg)](https://github.com/JJ/energy-ga-icsoft-2023/actions/workflows/zig.yml)

This is the repo for the code, experimental data and papers related to analysis
of energy consumption in different platforms, interpreter, and languages. It's
main objective is to make all papers and results maximally reproducible, so it
should contain everything needed for doing so (although the sequence might not
be clear at first sight, just ask through the issues).

The repository is organized as follows:

- [`code`](code/) contains precisely that, code used in the different papers for
  obtaining the results. Every directory corresponds to a different language (or
  version of a language), with [`code/scripts`](code/scripts/) containing the
Perl scripts that are used for running the different experiments.
- [`data`](data/) contains experimental data, in R form, with prefixes that
  are related to the specific conference they were presented,
  [`data-raw`](data-raw/) contains the same in the original form, CSV or JSON.
- [`preso`](preso/) contains different presentations used in conferences.
- [`paper`](paper/) contains the source code for the different papers.


## Papers published so far.

Here are the papers published so far; the rest are work-in-progress, submitted,
or accepted and waiting for publication.


### An Analysis of Energy Consumption of JavaScript Interpreters with Evolutionary Algorithm Workloads

This paper was accepted and [presented](preso/index.html) in ICSOFT 2023, and is
[available online](https://www.scitepress.org/Documents/2023/121281/).

I kindly ask you to cite this paper if you use the code in this repository:

```bibtex
@conference{icsoft23,
author={Juan J. Merelo-Guervós and Mario García-Valdez and Pedro Castillo},
title={An Analysis of Energy Consumption of JavaScript Interpreters with Evolutionary Algorithm Workloads},
booktitle={Proceedings of the 18th International Conference on Software Technologies - Volume 1: ICSOFT},
year={2023},
pages={175-184},
publisher={SciTePress},
organization={INSTICC},
doi={10.5220/0012128100003538},
isbn={978-989-758-665-1},
}
```

The paper, data and code used for this paper is [tagged with
`0.99`](https://github.com/JJ/energy-ga-icsoft-2023/releases/tag/v0.99) an you
can retrieve it via the published tarfile or checking out the tag in the repo
cloned locally.

### Energy Consumption of Evolutionary Algorithms in JavaScript

In this case, we check different versions of JavaScript runtimes, as well as
check differences between different computers (and their implementation of RAPL)
and operating systems. 

This paper was [recently published in the Wivace 2023
proceedings](https://link.springer.com/chapter/10.1007/978-3-031-57430-6_1);
here is [the presentation used at the
conference](https://jj.github.io/energy-ga-icsoft-2023/preso/wivace2023.html)
(with lots of pictures from Venice).

Please use [this reference](https://citation-needed.springer.com/v2/references/10.1007/978-3-031-57430-6_1?format=bibtex&flavour=citation) when re-using code of papers from this version:

```bibtex
@InProceedings{10.1007/978-3-031-57430-6_1,
author="Merelo-Guerv{\'o}s, Juan J.
and Garc{\'i}a-Valdez, Mario
and Castillo, Pedro A.",
editor="Villani, Marco
and Cagnoni, Stefano
and Serra, Roberto",
title="Energy Consumption of Evolutionary Algorithms in JavaScript",
booktitle="Artificial Life and Evolutionary Computation",
year="2024",
publisher="Springer Nature Switzerland",
address="Cham",
pages="3--15",
abstract="Green computing is a methodology for saving energy when implementing algorithms. In environments where the runtime is an integral part of the application, it is essential to measure their energy efficiency so that researchers and practitioners have enough choice. In this paper, we will focus on JavaScript runtime environments for evolutionary algorithms; although not the most popular language for scientific computing, it is the most popular language for developers, and it has been used repeatedly to implement all kinds of evolutionary algorithms almost since its inception. In this paper, we will focus on the importance of measuring different versions of the same runtimes, as well as extending the EA operators that will be measured. We also like to remark on the importance of testing the operators in different architectures to have a more precise picture that tips the balance towards one runtime or another.",
isbn="978-3-031-57430-6"
}
```

This version is tagged
[v1.0.1ICSoft](https://github.com/JJ/energy-ga-icsoft-2023/releases/tag/v1.0.1ICSoft),
and you can download the zipped file or checkout from the repo, as usual.

