# weighting-plot
* This program is used only for https://github.com/shin-kinos/seq-weighting

## description 
* Visualize sequence weighting in MSA with circular barplot

## Dependencies

### R

Version `4.1.0` or more.

```
> version
version.string R version 4.1.0 (2021-05-18)
```

### Tidyverse
* https://www.tidyverse.org/

Vesion `1.3.1` or more.

``` 
> packageVersion("tidyverse")
[1] ‘1.3.1’
```

### ggplot2
* https://ggplot2.tidyverse.org/ 

Version `` or more.

```
> packageVersion("ggplot2")
[1] ‘3.3.5’
``` 
## Input file format

An output file of https://github.com/shin-kinos/seq-weighting

See some example input files in `demo` directory.

## Utility

Available options :

* `-i` : Input file name, REQUIRED.
* `-o` : Output file name. REQUIRED.
* `-c` : Types of colour gradient.
* `-w` : Size of width (px).
* `-h` : Size of height (px).
* `-C` : Size of circle.

[e.g]

```
% Rscript weighting-plot.r -i input_file.txt -o output_plot -c 2 -w 2500 -h 2250 -C 2.5
```
## Output 
A graph in `JPG` format.

### Example 1

```
% Rscript weighting-plot.r -i demo_03.txt -o demo_03_plot -c 3
```
![demo_03_plot](https://user-images.githubusercontent.com/83740080/127841283-0c0447da-93db-4cdc-b0ca-fb97f9b28486.jpg)

### Example 2

```
% Rscript weighting-plot.r -i ace2_human_aligned.fasta_output.txt -o ace2_human_plot -c 2 -C 2.25
```

![ace2_human_plot](https://user-images.githubusercontent.com/83740080/127841590-6cc038ca-bb5c-4001-a4fd-3f773eb20d89.jpg)

### Example 3

```
% Rscript weighting-plot.r -i pfk_human_align.fasta_output.txt -o pfk_human_plot -c 4 -w 2500 -h 2250 -C 3
```

![pfk_human_plot](https://user-images.githubusercontent.com/83740080/127841790-48bda6d6-526b-47ff-8131-5b6b9de9e746.jpg)

Enjoy 🤟 
