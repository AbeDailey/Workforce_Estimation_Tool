

################################################################################
# Bike Rack
################################################################################

# The Bike Rack is a place for storing things that we don't need for the time being.

# We may want these items later.

################################################################################



###############################################################################
# Reactive Calculations Bike Rack
###############################################################################


###############################################################################
# Adjust Employment Forecast Reactive (Version 1)
###############################################################################

# This version of the Adjust Employment Forecast Reactive works with two
# sliders to adjust self-employment statewide. One slider is for 2019
# and the other slider is for 2045. This feature was abandoned when we implemented
# county level self-employment adjustments.

adjustEmploymentForecast_1 <- reactive({
  
  
  
  #############################################################################################################
  # Old functionality     
  
  # These were used in an earlier version, where we had just one slider for all of Maine in 2019 and 2045
  #self_employment_ratio_1 <- employmentRatioSliderValue2019()
  #self_employment_ratio_2 <- employmentRatioSliderValue2045()
  
  employment_forecast <- data.frame(employment)
  
  names(employment_forecast) <- c('County','Census_2019_WS_Employment','BEA_2019_Total_Employment','BEA_2019_WS_Employment','BEA_2019_Self_Employment','BEA_2019_Other_Employment','WP_2019_Jobs','WP_2019_Other_Employment','PCT_2019_Wage_Salary_Employment','PCT_2019_Self_Employment','PCT_2019_BEA_Other_Employment','PCT_2019_WP_Other_Employment','WP_2045_Jobs')
  
  
  #############################################################################################################
  # Old functionality     
  
  # These versions were used with state wide self-employment sliders for 2019 and 2045
  # WP_2019_Jobs_Adjusted <- employment_forecast$WP_2019_Jobs / ( 1 + self_employment_ratio_1)
  
  # WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs / ( 1 + self_employment_ratio_2)
  
  # end of old functionality
  ############################################################################################################    
  
  
  #WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs * self_employment_ratio_2
  
  
  #employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, employment_forecast$WP_2045_Jobs, self_employment_ratio_2, two_jobs_percentage, WP_2045_Jobs_Adjusted)
  
  
  #############################################################################################################
  # Old functionality     
  
  # This was used in the version that has WP_2019_Jobs_Adjusted
  # employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, employment_forecast$WP_2045_Jobs, WP_2019_Jobs_Adjusted, WP_2045_Jobs_Adjusted)
  # end of old functionality
  ############################################################################################################ 
  
  
  employment_forecast
  
})

###############################################################################
# End Adjust Employment Forecast Reactive  (Version 1)
###############################################################################


###############################################################################
# End Reactive Calculations Bike Rack
###############################################################################



###############################################################################
# Render UI Output
############################################################################### 



##############################################################################
# Render Trip Table (outdated?)
##############################################################################

# Here we render a data table showing county trip tables
# ToDo: Investigate if we can delete this section
# These may be duplicative with a reactive function

output$tripMatrix <- DT::renderDataTable(DT::datatable(caption = 'Table 4: Trip Matrix for 2045.',{
  
  
  county_flows <- data.frame(adjustCountyOutflows())
  
  workforce <- data.frame(read.csv(file="Tables/county_workforce_outflows_by_destination_county.csv", head=TRUE,sep=",", stringsAsFactors = FALSE))
  
  destinations <- workforce[,1]
  
  androscoggin_origins_pct <- as.numeric(workforce[,2])
  aroostook_origins_pct <- as.numeric(workforce[,3])
  cumberland_origins_pct <- as.numeric(workforce[,4])
  franklin_origins_pct <- as.numeric(workforce[,5])
  hancock_origins_pct <- as.numeric(workforce[,6])
  kennebec_origins_pct <- as.numeric(workforce[,7])
  knox_origins_pct <- as.numeric(workforce[,8])
  lincoln_origins_pct <- as.numeric(workforce[,9])
  oxford_origins_pct <- as.numeric(workforce[,10])
  penobscot_origins_pct <- as.numeric(workforce[,11])
  piscataquis_origins_pct <- as.numeric(workforce[,12])
  sagadahoc_origins_pct <- as.numeric(workforce[,13])
  somerset_origins_pct <- as.numeric(workforce[,14])
  waldo_origins_pct <- as.numeric(workforce[,15])
  washington_origins_pct <- as.numeric(workforce[,16])
  york_origins_pct <- as.numeric(workforce[,17])
  
  #revised_workforce <- as.numeric(county_flows$revised_workforce_forecast)
  
  revised_workforce <- as.numeric(county_flows[,3])
  
  # revised_outflows <- as.numeric(county_flows$revised_county_workforce_outflows_2045)
  
  outflows_matrix <- rbind(revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce)
  
  androscoggin_origins <- androscoggin_origins_pct * outflows_matrix[,1]
  aroostook_origins <- aroostook_origins_pct * outflows_matrix[,2]
  cumberland_origins <- cumberland_origins_pct * outflows_matrix[,3]
  franklin_origins <- franklin_origins_pct * outflows_matrix[,4]
  hancock_origins <- hancock_origins_pct * outflows_matrix[,5]
  kennebec_origins <- kennebec_origins_pct * outflows_matrix[,6]
  knox_origins <- knox_origins_pct * outflows_matrix[,7]
  lincoln_origins <- lincoln_origins_pct * outflows_matrix[,8]
  oxford_origins <- oxford_origins_pct * outflows_matrix[,9]
  penobscot_origins <- penobscot_origins_pct * outflows_matrix[,10]
  piscataquis_origins <- piscataquis_origins_pct * outflows_matrix[,11]
  sagadahoc_origins <- sagadahoc_origins_pct * outflows_matrix[,12]
  somerset_origins <- somerset_origins_pct * outflows_matrix[,13]
  waldo_origins <- waldo_origins_pct * outflows_matrix[,14]
  washington_origins <- washington_origins_pct * outflows_matrix[,15]
  york_origins <- york_origins_pct * outflows_matrix[,16]
  
  outflow_trips <- cbind(androscoggin_origins, aroostook_origins, cumberland_origins, franklin_origins, hancock_origins, kennebec_origins, knox_origins, lincoln_origins, oxford_origins, penobscot_origins, piscataquis_origins, sagadahoc_origins, somerset_origins, waldo_origins, washington_origins, york_origins)
  
  colnames(outflow_trips) <- c('Androscoggin Origins', 'Aroostook Origins', 'Cumberland Origins', 'Franklin Origins', 'Hancock Origins', 'Kennebec Origins', 'Knox Origins', 'Lincoln Origins', 'Oxford Origins', 'Penobscot Origins', 'Piscataquis Origins', 'Sagadahoc Origins', 'Somerset Origins', 'Waldo Origins', 'Washington Origins', 'York Origins')
  
  #rownames(outflow_trips) <- c('Androscoggin', 'Aroostook', 'Cumberland')
  
  #outflows_matrix <- rbind(revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows, revised_outflows)
  
  #outflows_matrix <- data.frame(outflows_matrix)
  
  # colnames(outflows_matrix) <- c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York')
  
  # rownames(outflows_matrix) <- c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York', 'New Hampshire', 'Masssachusetts', 'CT-RI-VT', 'Outside New England')
  
  rownames(outflow_trips) <- c('Androscoggin County', 'Aroostook County', 'Cumberland County', 'Franklin County', 'Hancock County', 'Kennebec County', 'Knox County', 'Lincoln County', 'Oxford County', 'Penobscot County', 'Piscataquis County', 'Sagadahoc County', 'Somerset County', 'Waldo County', 'Washington County', 'York County', 'New Hampshire', 'Masssachusetts', 'CT-RI-VT', 'Outside New England')
  
  Andro_destinations <- sum(outflow_trips[1,])
  Aroostook_destinations <- sum(outflow_trips[2,])
  Cumberland_destinations <- sum(outflow_trips[3,])
  Franklin_destinations <- sum(outflow_trips[4,])
  Hancock_destinations <- sum(outflow_trips[5,])
  Kennebec_destinations <- sum(outflow_trips[6,])
  Knox_destinations <- sum(outflow_trips[7,])
  Lincoln_destinations <- sum(outflow_trips[8,])
  Oxford_destinations <- sum(outflow_trips[9,])
  Penobscot_destinations <- sum(outflow_trips[10,])
  Piscataquis_destinations <- sum(outflow_trips[11,])
  Sagadahoc_destinations <- sum(outflow_trips[12,])
  Somerset_destinations <- sum(outflow_trips[13,])
  Waldo_destinations <- sum(outflow_trips[14,])
  Washington_destinations <- sum(outflow_trips[15,])
  York_destinations <- sum(outflow_trips[16,])
  x1 <- sum(outflow_trips[17,])
  x2 <- sum(outflow_trips[18,])
  x3 <- sum(outflow_trips[19,])
  x4 <- sum(outflow_trips[20,])
  
  destinations <- rbind(Andro_destinations,Aroostook_destinations,Cumberland_destinations,Franklin_destinations,Hancock_destinations,Kennebec_destinations,Knox_destinations,Lincoln_destinations,Oxford_destinations,Penobscot_destinations,Piscataquis_destinations,Sagadahoc_destinations,Somerset_destinations, Waldo_destinations, Washington_destinations,York_destinations,x1,x2,x3,x4)
  
  outflow_trips <- cbind(outflow_trips,destinations)
  
  colnames(outflow_trips) <- c('Androscoggin Origins', 'Aroostook Origins', 'Cumberland Origins', 'Franklin Origins', 'Hancock Origins', 'Kennebec Origins', 'Knox Origins', 'Lincoln Origins', 'Oxford Origins', 'Penobscot Origins', 'Piscataquis Origins', 'Sagadahoc Origins', 'Somerset Origins', 'Waldo Origins', 'Washington Origins', 'York Origins','Total Destinations')
  
  
  # outflows_matrix 
  
  # outflow_trips <- as.numeric(unlist(outflows_matrix)) * as.numeric(unlist(workforce))
  
  outflow_trips
  
  
  
  
}, extensions = 'Buttons', 
options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
) 

%>% formatRound(c('Androscoggin Origins', 'Aroostook Origins', 'Cumberland Origins', 'Franklin Origins', 'Hancock Origins', 'Kennebec Origins', 'Knox Origins', 'Lincoln Origins', 'Oxford Origins', 'Penobscot Origins', 'Piscataquis Origins', 'Sagadahoc Origins', 'Somerset Origins', 'Waldo Origins', 'Washington Origins', 'York Origins', 'Total Destinations'), 0) 


# %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 

# %>% formatPercentage('Pct Workforce Outflows 2045',1)

)

##############################################################################
# End Render Trip Table (outdated?)
##############################################################################



###############################################################################
# End Render UI Output
############################################################################### 


################################################################################
# End Bike Rack
################################################################################