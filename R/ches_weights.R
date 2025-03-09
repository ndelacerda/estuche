# Add global variables declaration to avoid R CMD check notes
utils::globalVariables(c("party_obs", "expected_prop", "actual_prop"))

#' Create balanced weights for CHES expert level dataset
#'
#' This function creates weights for a CHES (Chapel Hill Expert Survey) dataset to ensure
#' each country-party combination has equal influence in subsequent analyses.
#'
#' @param data A data frame containing country and party columns from the CHES dataset
#' @param country The name of the column containing country identifiers (default: "country")
#' @param party The name of the column containing party identifiers (default: "party")
#'
#' @return A data frame with additional columns:
#'   \item{party_obs}{Number of observations per party within each country}
#'   \item{weight}{Calculated weight for each observation}
#'
#' @examples
#' \dontrun{
#' ches_data <- read.csv("ches_data.csv")
#' weighted_data <- ches_weights(ches_data)
#'
#' # With custom column names
#' weighted_data <- ches_weights(ches_data, country = "nation", party = "political_party")
#' }
#'
#' @importFrom dplyr group_by mutate ungroup distinct n select
#' @importFrom magrittr %>%
#' @export
ches_weights <- function(data, country = "country", party = "party") {
  # Ensure proper handling of non-standard evaluation with enquo
  country_var <- rlang::ensym(country)
  party_var <- rlang::ensym(party)

  # Step 1: Count observations per party within each country
  data <- data %>%
    dplyr::group_by(!!country_var, !!party_var) %>%
    dplyr::mutate(party_obs = dplyr::n()) %>%
    dplyr::ungroup()

  # Step 2: Calculate the total number of unique parties across all countries
  total_unique_parties <- data %>%
    dplyr::distinct(!!country_var, !!party_var) %>%
    base::nrow()

  # Step 3: Calculate the expected proportion for each country-party combination
  # (Each country-party combination should have equal weight)
  data <- data %>%
    dplyr::mutate(expected_prop = 1/total_unique_parties)

  # Step 4: Calculate the actual proportion of observations for each country-party combination
  data <- data %>%
    dplyr::mutate(actual_prop = party_obs/base::nrow(data))

  # Step 5: Calculate the weight (expected proportion / actual proportion)
  data <- data %>%
    dplyr::mutate(weight = expected_prop/actual_prop) %>%
    dplyr::select(-party_obs, -expected_prop, -actual_prop)

  return(data)
}
