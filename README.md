# estuche: A Pencil Case For My Daily Needs

## Overview

`estuche` (Spanish for "pencil case") is an R package that provides utility functions for daily data analysis needs. The package includes tools for creating balanced weights for Chapel Hill Expert Survey (CHES) data and implementing efficient caching mechanisms for computationally intensive analyses.

## Installation

You can install the development version of estuche from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("ndelacerda/estuche")
```

## Main Functions

### `ches_weights()`

Creates balanced weights for CHES expert-level datasets to ensure each country-party combination has equal influence in subsequent analyses.

```r
ches_weights(data, country = "country", party = "party")
```

#### Arguments:
- `data`: A data frame containing country and party columns from the CHES dataset
- `country`: The name of the column containing country identifiers (default: "country")
- `party`: The name of the column containing party identifiers (default: "party")

#### Returns:
A data frame with an additional column:
- `weight`: Calculated weight for each observation

#### Example:

```r
library(estuche)

# Read CHES data
ches_data <- read.csv("ches_data.csv")

# Apply weights
weighted_data <- ches_weights(ches_data)

# With custom column names
weighted_data <- ches_weights(ches_data, country = "nation", party = "political_party")
```

### `check_and_run()`

Implements a caching mechanism to avoid re-running expensive computations. Checks if results are already cached as an RDS file, and only runs the computation if needed.

```r
check_and_run(rds_path, func, ...)
```

#### Arguments:
- `rds_path`: Character string specifying the file path where the RDS file is/should be saved
- `func`: A function to execute if the RDS file doesn't exist
- `...`: Additional arguments to pass to `func`

#### Returns:
The content of the RDS file if it exists, or the result of running `func`

#### Example:

```r
library(estuche)

result <- check_and_run("outputs/my_analysis.rds", function() {
  # Some expensive computation with CHES data
  ches_data <- read.csv("ches_data.csv")
  weighted_data <- ches_weights(ches_data)
  
  # Further analysis...
  return(weighted_data)
})
```

## Dependencies

- dplyr
- rlang

## About the Chapel Hill Expert Survey

The Chapel Hill Expert Survey (CHES) estimates party positions for national parties across the globe. It is a widely used resource in comparative political research.

For more information on CHES, visit their [official website](https://www.chesdata.eu/).

## License

This package is released under the MIT License.

## Author

Nicolás de la Cerda (ndelacerdacoya@tulane.edu)
ORCID: 0000-0003-2474-9756