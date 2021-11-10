casexwhen=function(input, map_in, map_out, lastelse=NULL, map_df=NULL)
{
  #this function aims to replicate the case x when idea from sql where you have one input and a basic 1-1 or many-1 mapping based on equalities
  #input is the input vector or column from df
  #map_in is the mapping input for the mapping
  #map_out is the output value of the map
  #map_dfis a dataframe with the criteria as column 1 and output as column 2, when specified takes priority over the specified input and output
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
    #remaps to citeria and output
    map_in=unlist(map_df[1])
    map_out=unlist(map_df[2])
  }
  if(class(input)!=class(map_in))
  {
    #checks the input and criteria are of the same type
    stop(paste("Input is ", class(input), "and map_in is ", class(map_in), ". Types must match" ))
  }else
  if(length(map_in)!=length(map_out))
  {
    # checks the criteria and output are of the same length
    stop("Criteria and output are of differing lengths")
  }else
  {
    # uses lapply to do each item of the vector and the unlists and unnames. 
    return(unname(unlist(lapply(input, oneitem, map_in=map_in, map_out=map_out, lastelse=lastelse))))
  }
  
}

