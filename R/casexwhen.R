
#' Implements the case x when hack from SQL
#' @param input A vector or scalar for the input values
#' @param map_in A vector or scalar for the input for the mapping
#' @param map_out A vector or scalar for the output for the mapping
#' @param lastelse A value to output if there are no matches, if \code{NULL} then no matches will output \code{NA}.
#' @param map_df A dataframe with the map_in as column 1 and map_out as column 2. When specified, takes priority over the specified input and output.
#' @returns A vector of the map_out values that correspond to the inputs.
#' @examples 
#' \dontrun{casexwhen(input=c("a", "c"), map_in=c("a", "b", "c", "d"), mapout=c(1,2,3,4))}
#' \dontrun{c(1,3)}
#' \dontrun{Check https://github.com/sgbstats/caseXwhen/ for more}
#' @export

casexwhen=function(input, map_in=NULL, map_out=NULL, lastelse=NULL, map_df=NULL)
{

  oneitem=function(input, map_in, map_out, lastelse=NULL)
  {
    #deals with the basic case of one item
    
    if(length(which(map_in==input))>0)
    {
      return(map_out[min(which(map_in==input))])
    }else
      if(!is.null(lastelse))
      {
        return(lastelse)
      }else
      {
        return(NA)
      }
    
  }
  if(!is.null(map_df))
  {
    #remaps to map_in and map_out
    map_in=unlist(map_df[1])
    map_out=unlist(map_df[2])
  }else if(is.null(map_in)|is.null(map_out))
  {
    stop("Mapping not spcified")
  }
  if(class(input)!=class(map_in))
  {
    #checks the input and map_in are of the same type
    stop(paste("Input is ", class(input), " and map_in is ", class(map_in), ". Types must match", sep="" ))
  }else
  if(length(map_in)!=length(map_out))
  {
    # checks the map_in and map_out are of the same length
    stop("Map_in and map_out are of differing lengths")
  }else
  {
    # uses lapply to do each item of the vector and the unlists and unnames. 
    return(unname(unlist(lapply(input, oneitem, map_in=map_in, map_out=map_out, lastelse=lastelse))))
  }
  
}

