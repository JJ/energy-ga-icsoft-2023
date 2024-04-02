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
