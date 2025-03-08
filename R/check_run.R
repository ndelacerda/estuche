#' Check for cached results or run a function
#'
#' This function checks if an RDS file exists at the specified path. If it does,
#' it loads and returns the content. If not, it runs the provided function with any
#' additional arguments, saves the result as an RDS file, and returns the result.
#'
#' @param rds_path Character string specifying the file path where the RDS file is/should be saved
#' @param func A function to execute if the RDS file doesn't exist
#' @param ... Additional arguments to pass to `func`
#'
#' @return The content of the RDS file if it exists, or the result of running `func`
#' @export
#'
#' @examples
#' \dontrun{
#'   # Example usage:
#'   result <- check_and_run("outputs/my_analysis.rds", function() {
#'     # Some expensive computation
#'     return(mtcars[1:10, ])
#'   })
#' }
check_and_run <- function(rds_path, func, ...) {
  # Check if the RDS file exists
  if (file.exists(rds_path)) {
    message("RDS file already exists at: ", rds_path)
    # Return the loaded RDS file
    return(readRDS(rds_path))
  } else {
    message("RDS file not found. Running function...")
    # Run the provided function with any additional arguments
    result <- func(...)
    # Save the result as an RDS file
    saveRDS(result, file = rds_path)
    message("Function completed. Results saved to: ", rds_path)
    # Return the result
    return(result)
  }
}
