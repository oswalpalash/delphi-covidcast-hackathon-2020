#' Run the entire pipeline
#'
#' See the README.md file in the source directory for more information about how to run
#' this function.
#'
#' @param parameter_path    path to the parameters file
#'
#' @return none
#' @export
run_survey <- function(parameter_path = "params.json")
{
  # read parameters file, load geographic data, load archived data
  params <- read_params(parameter_path)
  cw_list <- produce_crosswalk_list(params$static_dir)
  archive <- load_archive(params)
  msg_df("archive data loaded", archive$data_agg)

  # load all input csv files and filter according to selection criteria
  input_data <- load_responses_all(params)
  input_data <- filter_responses(input_data, archive$seen_tokens, params)
  msg_df("response input data", input_data)

  # create data that will be aggregated for COVIDcast
  data_agg <- create_data_for_aggregatation(input_data)
  data_agg <- filter_data_for_aggregatation(data_agg)
  data_agg <- join_weights(data_agg, params, weights = "step1")
  msg_df("response data to aggregate", data_agg)

  # create "complete" data that will be shared with research partners
  data_full <- create_complete_responses(input_data)
  data_full <- filter_complete_responses(data_full)
  data_full <- join_weights(data_full, params, weights = "full")
  msg_df("full data to share with research partners", data_full)

  # write files for each specific output
  if ( "cids" %in% params$output )
  {
    write_cid(data_full, "full", params)
    write_cid(data_agg, "part_a", params)
  }
  if ( "archive" %in% params$output )
  {
    update_archive(input_data, archive, params)
  }
  if ( "individual" %in% params$output )
  {
    write_individual(data_full, params)
  }
  if ( "covidcast" %in% params$output )
  {
    write_hh_count_data(data_agg, cw_list, params)
  }
  if ( "community" %in% params$output )
  {
    write_binary_variable(
      data_agg, cw_list, "community_yes", params, metric = "nohh_cmnty_cli"
    )

    write_binary_variable(
      data_agg, cw_list, "hh_community_yes", params, metric = "hh_cmnty_cli"
    )
  }

}
