################################################################################

####################    Workforce Estimation Tool   ############################

################################################################################

# This Shiny Application can be used to understand how changing assumptions
# about workforce participation, % self-employment, % commuting outside 
# county of residence for work, or % working more than one job can change the 
# balance between population and employment at the county level in Maine
# and New England.

################################################################################
# Version 0.2 July 14, 2022
# Written by Abraham Dailey

# Greater Portland Council of Governments
# PACTS Travel Demand Model Update for Connect 2045



################################################################################
################################################################################
# Load Libraries
################################################################################
################################################################################

# install.packages("shiny")
library("shiny")
library(DT)
library(markdown)
# library(ggplot2)

################################################################################
################################################################################
# End Load Libraries
################################################################################
################################################################################



################################################################################
################################################################################
# Load Data
################################################################################
################################################################################

# Load the 2045 Population forecast
population_forecast <- read.csv(file="Tables/1_maine_county_population_forecast_2045.csv", head=TRUE,sep=",")

# Load the 2045 Maine County Age Structure csv file
ageStructure <- read.csv(file="Tables/2_maine_county_age_structure_2045.csv", head=TRUE,sep=",")

# Load the 2019 Maine County Workforce flows csv file
workforceOutflows <- read.csv(file="Tables/3_maine_county_workforce_flows_2019.csv", head=TRUE,sep=",")

# Load the 2045 Maine County Employment Forecast csv file
employment <- read.csv(file="Tables/4_maine_county_employment_forecast_2045.csv", head=TRUE,sep=",")

# Load the 2019 Maine County Workforce Participation Rate csv file
laborParticipation <- read.csv(file="Tables/5_maine_county_workforce_participation_rate_2019.csv", head=TRUE,sep=",")

# Load the 2019 County/State Origin-Destination csv file
# This file shows the percent of workers that commute from their home county (by column)
# to work county (by row)
workforce_OD <- data.frame(read.csv(file="Tables/county_workforce_outflows_by_destination_county.csv", head=TRUE,sep=",", stringsAsFactors = FALSE))

# Load the 2019 County/State Destination-Origin csv file
# This file shows the percent of employees that commute to a county for work (by row)
# from a home county (by column)
employment_DO <- data.frame(read.csv(file="Tables/county_employment_inflows_by_origin_county.csv", head=TRUE,sep=",", stringsAsFactors = FALSE))

# Load the 2019 Trip Table csv file
trip_table_2019 <- data.frame(read.csv(file="Tables/7_trip_table_2019.csv", head=TRUE,sep=",", stringsAsFactors = FALSE))


# Load the 2020 Population data
population_2019 <- read.csv(file="Tables/maine_county_population_2020.csv", head=TRUE,sep=",")

# Load the 2019 Maine County Age Structure csv file
ageStructure_2019 <- read.csv(file="Tables/maine_county_age_structure_2020.csv", head=TRUE,sep=",")


## ToDo: Move this into a reactive function somewhere.
## This may be redundant. Check on that.

## Commenting this out to see if it makes a difference. 

# Calculate the baseline working age population
# population_forecast <- cbind(population_forecast,ageStructure$Population_Age_15_and_Over)
# 
# working_age_population <- population_forecast$Forecast_2045_Population * ageStructure$Population_Age_15_and_Over
# 
# working_age_population <- cbind(population_forecast, working_age_population)

## End of commented out section

################################################################################
################################################################################
# End Load Data
################################################################################
################################################################################



###############################################################################
################################################################################
# Define Constants
################################################################################
###############################################################################

source('Constants.r', local=TRUE) 

###############################################################################
################################################################################
# End Define Constants
################################################################################
###############################################################################



###############################################################################
###############################################################################
# Load UI and Server scripts
###############################################################################
###############################################################################

# Not used since we moved the UI and Server into this file
# source("ui.R")
# source("server.r")

###############################################################################
###############################################################################
# End Load UI and Server scripts
###############################################################################
###############################################################################



###############################################################################
###############################################################################
# Define UI
###############################################################################
###############################################################################

ui<- navbarPage("Workforce Estimation Tool",
           
                
# Load Custom CSS     
           tags$head(tags$link(rel="stylesheet", type = "text/css", href="w3.css")),


  ###############################################################################
  # About Tab
  ###############################################################################

           tabPanel("About",includeMarkdown("about.md")
                    # fluidRow(includeMarkdown("about.md"))
                    # column(6,
                    #    includeMarkdown("about.md")
                    #    ),
                    #  column(3,
                    #  img(class="img-polaroid",
                    #           src=paste0("http://upload.wikimedia.org/","wikipedia/commons/9/92/","1919_Ford_Model_T_Highboy_Coupe.jpg")),
                    #          tags$small(
                    #           "Source: Photographed at the Bay State Antique ",
                    #          "Automobile Club's July 10, 2005 show at the ",
                    #           "Endicott Estate in Dedham, MA by ",
                    #            a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
                    #            "User:Sfoskett")
                    #            )
                    #        )
                    #      )
           ),
           
  ###############################################################################
  # End About Tab
  ############################################################################### 

 
  ###############################################################################
  # Employment Forecast Tab
  ############################################################################### 

           tabPanel("Employment Forecast",
                    
                    h3("1. 2019 Employment and 2045 Employment Forecast"),
                    
                    
                    hr(),
                    DT::dataTableOutput("employmentForecast"),
                    
                    #############################################################################################################
                    # Old functionality
                    # This was used when we had single sliders that could change self-employment rate state wide in 2019 and 2045
                    # fluidRow(column(4, sliderInput("employmentReductionSlider1", "% Self-employment in 2019", value=33.85, min=0, max=100, step=0.01)),
                    #          column(4, sliderInput("employmentReductionSlider2", "% Self-employment in 2045", value=40, min=0, max=100, step=0.01))),
                    # fluidRow(column(4, p("We've estimated 33.85% of total employment in the 2019 Woods and Poole data is self-employment")),
                    #          column(4, p("The self-employed ratio is likely to be higher in the future"))),
                    # end of old functionality
                    ############################################################################################################
                    
                    hr(),
                    p("This tab contains 2019 employment data and the baseline and adjusted employment forecast for 2045."),
                    p("The 2019 Census Wage and Salary Employment data are from the Census on the Map Site."),
                    p("The 2019 % Wage and Salary Employment is the Census 2019 wage and salary employment divided by the Woods and Poole 2019 total employment data."),
                    p("The WP 2019 Jobs and WP 2045 Jobs is the baseline employment forecast from Woods and Poole for those years."),
                    
                    hr(),
                    p("The 2045 Percent wage and salary employment is the value taken from the wage and salary slider for each county."),
                    p("The 2045 Percent two jobs is the value taken from the percent two jobs slider for each county."),
                    p("The WP 2045 Wage and Salary Jobs is the value from the % wage and salary employment slider multiplied by the baseline WP 2045 forecast."),

                    
                    ## ToDo add menu to select which employment total is used in other tabs
                    
                    hr(),
                    
                    fluidRow(column(3, h5("Androscoggin County")),
                             column(3, h5("Hancock County")),
                             column(3, h5("Oxford County")),
                             column(3, h5("Somerset County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_1b", "Reset Androscoggin County")),
                             column(3, actionButton("reset_2b", "Reset Hancock County")),
                             column(3, actionButton("reset_3b", "Reset Oxford County")),
                             column(3, actionButton("reset_4b", "Reset Somerset County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider4", h6("Wage & Salary % Employment in 2045"), value=AndroCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("hancockCoSlider4", h6("Wage & Salary % Employment in 2045"), value=HancockCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("oxfordCoSlider4", h6("Wage & Salary % Employment in 2045"), value=OxfordCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("somersetCoSlider4", h6("Wage & Salary % Employment in 2045"), value=SomerCo4Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", AndroCo4Default, "%"))),
                             column(3, h6(paste("Default: ", HancockCo4Default, "%"))),
                             column(3, h6(paste("Default: ", OxfordCo4Default, "%"))),
                             column(3, h6(paste("Default: ", SomerCo4Default, "%"))),
                    ),
                    
                    
                    # fluidRow(column(3, sliderInput("androscogginCoSlider5", h6("% Working Two Jobs in 2045"), value=AndroCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("hancockCoSlider5", h6("% Working Two Jobs in 2045"), value=HancockCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("oxfordCoSlider5", h6("% Working Two Jobs in 2045"), value=OxfordCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("somersetCoSlider5", h6("% Working Two Jobs in 2045"), value=SomerCo5Default, min=0, max=100, step=0.1))
                    # ),
                    # 
                    # fluidRow(column(3, h6(paste("Default: ", AndroCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", HancockCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", OxfordCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", SomerCo5Default, "%"))),
                    # ),
                    
                    
                    fluidRow(column(3, h5("Aroostook County")),
                             column(3, h5("Kennebec County")),
                             column(3, h5("Penobscot County")),
                             column(3, h5("Waldo County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_5b", "Reset Aroostook County")),
                             column(3, actionButton("reset_6b", "Reset Kennebec County")),
                             column(3, actionButton("reset_7b", "Reset Penobscot County")),
                             column(3, actionButton("reset_8b", "Reset Waldo County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider4", h6("Wage & Salary % Employment in 2045"), value=AroostCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("kennebecCoSlider4", h6("Wage & Salary % Employment in 2045"), value=KennebCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("penobscotCoSlider4", h6("Wage & Salary % Employment in 2045"), value=PenobCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("waldoCoSlider4", h6("Wage & Salary % Employment in 2045"), value=WaldoCo4Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", AroostCo4Default, "%"))),
                             column(3, h6(paste("Default: ", KennebCo4Default, "%"))),
                             column(3, h6(paste("Default: ", PenobCo4Default, "%"))),
                             column(3, h6(paste("Default: ", WaldoCo4Default, "%"))),
                    ),
                    
                    
                    
                    # fluidRow(column(3, sliderInput("aroostookCoSlider5", h6("% Working Two Jobs in 2045"), value=AroostCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("kennebecCoSlider5", h6("% Working Two Jobs in 2045"), value=KennebCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("penobscotCoSlider5", h6("% Working Two Jobs in 2045"), value=PenobCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("waldoCoSlider5", h6("% Working Two Jobs in 2045"), value=WaldoCo5Default, min=0, max=100, step=0.1))
                    # ),
                    # 
                    # fluidRow(column(3, h6(paste("Default: ", AroostCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", KennebCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", PenobCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", WaldoCo5Default, "%"))),
                    # ),
                    # 
                    
                    fluidRow(column(3, h5("Cumberland County")),
                             column(3, h5("Knox County")),
                             column(3, h5("Piscataquis County")),
                             column(3, h5("Washington County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_9b", "Reset Cumberland County")),
                             column(3, actionButton("reset_10b", "Reset Knox County")),
                             column(3, actionButton("reset_11b", "Reset Piscataquis County")),
                             column(3, actionButton("reset_12b", "Reset Washington County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider4", h6("Wage & Salary % Employment in 2045"), value=CumberCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("knoxCoSlider4", h6("Wage & Salary % Employment in 2045"), value=KnoxCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("piscataquisCoSlider4", h6("Wage & Salary % Employment in 2045"), value=PiscatCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("washingtonCoSlider4", h6("Wage & Salary % Employment in 2045"), value=WashinCo4Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", CumberCo4Default, "%"))),
                             column(3, h6(paste("Default: ", KnoxCo4Default, "%"))),
                             column(3, h6(paste("Default: ", PiscatCo4Default, "%"))),
                             column(3, h6(paste("Default: ", WashinCo4Default, "%"))),
                    ),
                    
                    
                    
                    
                    # fluidRow(column(3, sliderInput("cumberlandCoSlider5", h6("% Working Two Jobs in 2045"), value=CumberCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("knoxCoSlider5", h6("% Working Two Jobs in 2045"), value=KnoxCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("piscataquisCoSlider5", h6("% Working Two Jobs in 2045"), value=PiscatCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("washingtonCoSlider5", h6("% Working Two Jobs in 2045"), value=WashinCo5Default, min=0, max=100, step=0.1))
                    # ),
                    # 
                    # fluidRow(column(3, h6(paste("Default: ", CumberCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", KnoxCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", PiscatCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", WashinCo5Default, "%"))),
                    # ),
                    # 
                    # 
                    
                    fluidRow(column(3, h5("Franklin County")),
                             column(3, h5("Lincoln County")),
                             column(3, h5("Sagadahoc County")),
                             column(3, h5("York County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_13b", "Reset Franklin County")),
                             column(3, actionButton("reset_14b", "Reset Lincoln County")),
                             column(3, actionButton("reset_15b", "Reset Sagadahoc County")),
                             column(3, actionButton("reset_16b", "Reset York County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider4", h6("Wage & Salary % Employment in 2045"), value=FrankCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("lincolnCoSlider4", h6("Wage & Salary % Employment in 2045"), value=LincoCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("sagadahocCoSlider4", h6("Wage & Salary % Employment in 2045"), value=SagadaCo4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("yorkCoSlider4", h6("Wage & Salary % Employment in 2045"), value=YorkCo4Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo4Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo4Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo4Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo4Default, "%"))),
                    ),
                    
                    
                    # fluidRow(column(3, sliderInput("franklinCoSlider5", h6("% Working Two Jobs in 2045"), value=FrankCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("lincolnCoSlider5", h6("% Working Two Jobs in 2045"), value=LincoCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("sagadahocCoSlider5", h6("% Working Two Jobs in 2045"), value=SagadaCo5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("yorkCoSlider5", h6("% Working Two Jobs in 2045"), value=YorkCo5Default, min=0, max=100, step=0.1))
                    # ),
                    # 
                    # fluidRow(column(3, h6(paste("Default: ", FrankCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", LincoCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", SagadaCo5Default, "%"))),
                    #          column(3, h6(paste("Default: ", YorkCo5Default, "%"))),
                    # ),
                    
                    
                    fluidRow(column(3, h5("New Hampshire")),
                             column(3, h5("Massachusetts")),
                             column(3, h5("CT-RI-VT")),
                             column(3, h5("Rest of US")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_17b", "Reset New Hampshire")),
                             column(3, actionButton("reset_18b", "Reset Massachusetts")),
                             column(3, actionButton("reset_19b", "Reset CT-RI-VT")),
                             column(3, actionButton("reset_20b", "Reset Rest of US")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("NH_Slider4", h6("Wage & Salary % Employment in 2045"), value=NH4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("MA_Slider4", h6("Wage & Salary % Employment in 2045"), value=MA4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("CtRiVt_Slider4", h6("Wage & Salary % Employment in 2045"), value=CtRiVt4Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("RestUS_Slider4", h6("Wage & Salary % Employment in 2045"), value=RestUS4Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", NH4Default, "%"))),
                             column(3, h6(paste("Default: ", MA4Default, "%"))),
                             column(3, h6(paste("Default: ", CtRiVt4Default, "%"))),
                             column(3, h6(paste("Default: ", RestUS4Default, "%"))),
                    ),
                    
                    
                    # fluidRow(column(3, sliderInput("NH_Slider5", h6("% Working Two Jobs in 2045"), value=NH5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("MA_Slider5", h6("% Working Two Jobs in 2045"), value=MA5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("CtRiVt_Slider5", h6("% Working Two Jobs in 2045"), value=CtRiVt5Default, min=0, max=100, step=0.1)),
                    #          column(3, sliderInput("RestUS_Slider5", h6("% Working Two Jobs in 2045"), value=RestUS5Default, min=0, max=100, step=0.1))
                    # ),
                    # 
                    # fluidRow(column(3, h6(paste("Default: ", NH5Default, "%"))),
                    #          column(3, h6(paste("Default: ", MA5Default, "%"))),
                    #          column(3, h6(paste("Default: ", CtRiVt5Default, "%"))),
                    #          column(3, h6(paste("Default: ", RestUS5Default, "%"))),
                    # ),
                    # 
                    
           ),

  ###############################################################################
  # End Employment Forecast Tab
  ############################################################################### 



  ###############################################################################
  # Workforce Forecast Tab
  ############################################################################### 
           
           tabPanel("Workforce Forecast",
                    
                    h3("2. 2045 Workforce Forecast"),
                    
                    
                    hr(),
                    
                    DT::dataTableOutput("workforceForecast"),
                    
                    hr(),
                    
                    p("This tab contains 2045 Workforce forecast."),
                    p("The 2045 population is from the Woods and Poole forecast."),
                    p("The Working Age Population 2045 is the WP 2045 population multiplied by the value from the Percent of Population Aged 15+ slider.
                      The default value is the percent of population aged 15+ from the Woods and Poole 2045 forecast."),
                    p("The Workforce Population 2045 is the working aged population multiplied by the labor force participation rate from the labor force participation rate slider.
                      The default value for each slider is the labor force participation rate from the 2019 Census ACS 5-year sample."),
                    
                    hr(),
                    p("The Revised % Working Age Population 2045 column contains the values from the % Working Age Population sliders for each county."),
                    p("The Revised Workforce Participation Rate 2045 column contains the values from the % Working Age Population sliders for each county."),
                    p("These values can be saved to record the assumptions you made for this scenario."),
                    
                    hr(),
                    
                    fluidRow(column(3, h5("Androscoggin County")),
                             column(3, h5("Hancock County")),
                             column(3, h5("Oxford County")),
                             column(3, h5("Somerset County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_1", "Reset Androscoggin County")),
                             column(3, actionButton("reset_2", "Reset Hancock County")),
                             column(3, actionButton("reset_3", "Reset Oxford County")),
                             column(3, actionButton("reset_4", "Reset Somerset County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider1", h6("Percent of Population Aged 15+"), value=AndroCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("hancockCoSlider1", h6("Percent of Population Aged 15+"), value=HancockCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("oxfordCoSlider1", h6("Percent of Population Aged 15+"), value=OxfordCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("somersetCoSlider1", h6("Percent of Population Aged 15+"), value=SomerCo1Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", AndroCo1Default, "%"))),
                             column(3, h6(paste("Default: ", HancockCo1Default, "%"))),
                             column(3, h6(paste("Default: ", OxfordCo1Default, "%"))),
                             column(3, h6(paste("Default: ", SomerCo1Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider2", h6("Labor Force Participation % in 2045"), value=AndroCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("hancockCoSlider2", h6("Labor Force Participation % in 2045"), value=HancockCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("oxfordCoSlider2", h6("Labor Force Participation % in 2045"), value=OxfordCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("somersetCoSlider2", h6("Labor Force Participation % in 2045"), value=SomerCo2Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AndroCo2Default, "%"))),
                             column(3, h6(paste("Default: ", HancockCo2Default, "%"))),
                             column(3, h6(paste("Default: ", OxfordCo2Default, "%"))),
                             column(3, h6(paste("Default: ", SomerCo2Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Aroostook County")),
                             column(3, h5("Kennebec County")),
                             column(3, h5("Penobscot County")),
                             column(3, h5("Waldo County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_5", "Reset Aroostook County")),
                             column(3, actionButton("reset_6", "Reset Kennebec County")),
                             column(3, actionButton("reset_7", "Reset Penobscot County")),
                             column(3, actionButton("reset_8", "Reset Waldo County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider1", h6("Percent of Population Aged 15+"), value=AroostCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("kennebecCoSlider1", h6("Percent of Population Aged 15+"), value=KennebCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("penobscotCoSlider1", h6("Percent of Population Aged 15+"), value=PenobCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("waldoCoSlider1", h6("Percent of Population Aged 15+"), value=WaldoCo1Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", AroostCo1Default, "%"))),
                             column(3, h6(paste("Default: ", KennebCo1Default, "%"))),
                             column(3, h6(paste("Default: ", PenobCo1Default, "%"))),
                             column(3, h6(paste("Default: ", WaldoCo1Default, "%"))),
                    ),
                    
                    
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider2", h6("Labor Force Participation % in 2045"), value=AroostCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("kennebecCoSlider2", h6("Labor Force Participation % in 2045"), value=KennebCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("penobscotCoSlider2", h6("Labor Force Participation % in 2045"), value=PenobCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("waldoCoSlider2", h6("Labor Force Participation % in 2045"), value=WaldoCo2Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AroostCo2Default, "%"))),
                             column(3, h6(paste("Default: ", KennebCo2Default, "%"))),
                             column(3, h6(paste("Default: ", PenobCo2Default, "%"))),
                             column(3, h6(paste("Default: ", WaldoCo2Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Cumberland County")),
                             column(3, h5("Knox County")),
                             column(3, h5("Piscataquis County")),
                             column(3, h5("Washington County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_9", "Reset Cumberland County")),
                             column(3, actionButton("reset_10", "Reset Knox County")),
                             column(3, actionButton("reset_11", "Reset Piscataquis County")),
                             column(3, actionButton("reset_12", "Reset Washington County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider1", h6("Percent of Population Aged 15+"), value=CumberCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("knoxCoSlider1", h6("Percent of Population Aged 15+"), value=KnoxCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("piscataquisCoSlider1", h6("Percent of Population Aged 15+"), value=PiscatCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("washingtonCoSlider1", h6("Percent of Population Aged 15+"), value=WashinCo1Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", CumberCo1Default, "%"))),
                             column(3, h6(paste("Default: ", KnoxCo1Default, "%"))),
                             column(3, h6(paste("Default: ", PiscatCo1Default, "%"))),
                             column(3, h6(paste("Default: ", WashinCo1Default, "%"))),
                    ),
                    
                    
                    
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider2", h6("Labor Force Participation % in 2045"), value=CumberCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("knoxCoSlider2", h6("Labor Force Participation % in 2045"), value=KnoxCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("piscataquisCoSlider2", h6("Labor Force Participation % in 2045"), value=PiscatCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("washingtonCoSlider2", h6("Labor Force Participation % in 2045"), value=WashinCo2Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", CumberCo2Default, "%"))),
                             column(3, h6(paste("Default: ", KnoxCo2Default, "%"))),
                             column(3, h6(paste("Default: ", PiscatCo2Default, "%"))),
                             column(3, h6(paste("Default: ", WashinCo2Default, "%"))),
                    ),
                    
                    
                    
                    fluidRow(column(3, h5("Franklin County")),
                             column(3, h5("Lincoln County")),
                             column(3, h5("Sagadahoc County")),
                             column(3, h5("York County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_13", "Reset Franklin County")),
                             column(3, actionButton("reset_14", "Reset Lincoln County")),
                             column(3, actionButton("reset_15", "Reset Sagadahoc County")),
                             column(3, actionButton("reset_16", "Reset York County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider1", h6("Percent of Population Aged 15+"), value=FrankCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("lincolnCoSlider1", h6("Percent of Population Aged 15+"), value=LincoCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("sagadahocCoSlider1", h6("Percent of Population Aged 15+"), value=SagadaCo1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("yorkCoSlider1", h6("Percent of Population Aged 15+"), value=YorkCo1Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo1Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo1Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo1Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo1Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider2", h6("Labor Force Participation % in 2045"), value=FrankCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("lincolnCoSlider2", h6("Labor Force Participation % in 2045"), value=LincoCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("sagadahocCoSlider2", h6("Labor Force Participation % in 2045"), value=SagadaCo2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("yorkCoSlider2", h6("Labor Force Participation % in 2045"), value=YorkCo2Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo2Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo2Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo2Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo2Default, "%"))),
                    ),

                    
                    
                    fluidRow(column(3, h5("New Hampshire")),
                             column(3, h5("Massachusetts")),
                             column(3, h5("CT-RI-VT")),
                             column(3, h5("Rest of US")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_17", "Reset New Hampshire")),
                             column(3, actionButton("reset_18", "Reset Massachusetts")),
                             column(3, actionButton("reset_19", "Reset CT-RI-VT")),
                             column(3, actionButton("reset_20", "Reset Rest of US")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("NH_Slider1", h6("Percent of Population Aged 15+"), value=NH1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("MA_Slider1", h6("Percent of Population Aged 15+"), value=MA1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("CtRiVt_Slider1", h6("Percent of Population Aged 15+"), value=CtRiVt1Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("RestUS_Slider1", h6("Percent of Population Aged 15+"), value=RestUS1Default, min=0, max=100, step=0.1)),
                    ),  
                    
                    fluidRow(column(3, h6(paste("Default: ", NH1Default, "%"))),
                             column(3, h6(paste("Default: ", MA1Default, "%"))),
                             column(3, h6(paste("Default: ", CtRiVt1Default, "%"))),
                             column(3, h6(paste("Default: ", RestUS1Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("NH_Slider2", h6("Labor Force Participation % in 2045"), value=NH2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("MA_Slider2", h6("Labor Force Participation % in 2045"), value=MA2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("CtRiVt_Slider2", h6("Labor Force Participation % in 2045"), value=CtRiVt2Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("RestUS_Slider2", h6("Labor Force Participation % in 2045"), value=RestUS2Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", NH2Default, "%"))),
                             column(3, h6(paste("Default: ", MA2Default, "%"))),
                             column(3, h6(paste("Default: ", CtRiVt2Default, "%"))),
                             column(3, h6(paste("Default: ", RestUS2Default, "%"))),
                    ),                                        
                    
                    
           ),

  ###############################################################################
  # County Outflows Tab
  ###############################################################################
           
           tabPanel("County Outflows",
                    
                    
                    h3("3. 2045 County Outflows"),
                    
                    
                    hr(),
                    
                    DT::dataTableOutput("countyFlows"),
                    
                    hr(),
                    
                    p("This tab contains the calculations for workers that commute outside of their home county for work. 
                      The default value for the Percent Workforce Outflows in 2045 are based on 2019 employment data from Census on the Map."),
                    p("The County Employment 2045 column is based on the the Woods and Poole forecast. 
                      The default value has been modified by the sliders in the Employment Forecast tab."),
                    p("The County Workforce 2045 column is the 2045 Workforce population from the Workforce Forecast tab.
                      The values shown here can be modified by sliders in the Workforce Forecast tab."),
                    p("The Percent Workforce Outflows 2045 column is the values from the County Workforce Outflows % in 2045 slider.
                      The default value for each slider is the County Workforce outflows % from the Census On the Map 2019 employment data."),
                    
                    hr(),
                    p("The County Workforce Outflows 2045 column is the County Workforce 2045 column multiplied by the Percent Workforce Outflows 2045 column. 
                      The values in this column can be modified by the Labor Force Outflow % sliders."),
                    p("The County Workforce Locals 2045 column is the difference between the County Workforce 2045 column 
                      and the County Workforce Outflows 2045 column. The values in this column can be modified by the Labor Force Outflow % Sliders."),
                    p("The Employment Balance 2045 column is the difference between County Employment 2045 and County Workforce Locals 2045. 
                      This employment will have to be filled by inflows from other counties."),
                    
                    hr(),
                    
                    fluidRow(column(3, h5("Androscoggin County")),
                             column(3, h5("Hancock County")),
                             column(3, h5("Oxford County")),
                             column(3, h5("Somerset County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_1a", "Reset Androscoggin County")),
                             column(3, actionButton("reset_2a", "Reset Hancock County")),
                             column(3, actionButton("reset_3a", "Reset Oxford County")),
                             column(3, actionButton("reset_4a", "Reset Somerset County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider3", h6("Labor Force Outflow % in 2045"), value=AndroCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("hancockCoSlider3", h6("Labor Force Outflow % in 2045"), value=HancockCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("oxfordCoSlider3", h6("Labor Force Outflow % in 2045"), value=OxfordCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("somersetCoSlider3", h6("Labor Force Outflow % in 2045"), value=SomerCo3Default, min=0, max=100, step=0.1)),
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AndroCo3Default, "%"))),
                             column(3, h6(paste("Default: ", HancockCo3Default, "%"))),
                             column(3, h6(paste("Default: ", OxfordCo3Default, "%"))),
                             column(3, h6(paste("Default: ", SomerCo3Default, "%"))),
                    ),
                    
                    
                    
                    
                    fluidRow(column(3, h5("Aroostook County")),
                             column(3, h5("Kennebec County")),
                             column(3, h5("Penobscot County")),
                             column(3, h5("Waldo County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_5a", "Reset Aroostook County")),
                             column(3, actionButton("reset_6a", "Reset Kennebec County")),
                             column(3, actionButton("reset_7a", "Reset Penobscot County")),
                             column(3, actionButton("reset_8a", "Reset Waldo County")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider3", h6("Labor Force Outflow % in 2045"), value=AroostCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("kennebecCoSlider3", h6("Labor Force Outflow % in 2045"), value=KennebCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("penobscotCoSlider3", h6("Labor Force Outflow % in 2045"), value=PenobCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("waldoCoSlider3", h6("Labor Force Outflow % in 2045"), value=WaldoCo3Default, min=0, max=100, step=0.1)),
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AroostCo3Default, "%"))),
                             column(3, h6(paste("Default: ", KennebCo3Default, "%"))),
                             column(3, h6(paste("Default: ", PenobCo3Default, "%"))),
                             column(3, h6(paste("Default: ", WaldoCo3Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Cumberland County")),
                             column(3, h5("Knox County")),
                             column(3, h5("Piscataquis County")),
                             column(3, h5("Washington County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_9a", "Reset Cumberland County")),
                             column(3, actionButton("reset_10a", "Reset Knox County")),
                             column(3, actionButton("reset_11a", "Reset Piscataquis County")),
                             column(3, actionButton("reset_12a", "Reset Washington County")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider3", h6("Labor Force Outflow % in 2045"), value=CumberCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("knoxCoSlider3", h6("Labor Force Outflow % in 2045"), value=KnoxCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("piscataquisCoSlider3", h6("Labor Force Outflow % in 2045"), value=PiscatCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("washingtonCoSlider3", h6("Labor Force Outflow % in 2045"), value=WashinCo3Default, min=0, max=100, step=0.1)),
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", CumberCo3Default, "%"))),
                             column(3, h6(paste("Default: ", KnoxCo3Default, "%"))),
                             column(3, h6(paste("Default: ", PiscatCo3Default, "%"))),
                             column(3, h6(paste("Default: ", WashinCo3Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Franklin County")),
                             column(3, h5("Lincoln County")),
                             column(3, h5("Sagadahoc County")),
                             column(3, h5("York County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_13a", "Reset Franklin County")),
                             column(3, actionButton("reset_14a", "Reset Lincoln County")),
                             column(3, actionButton("reset_15a", "Reset Sagadahoc County")),
                             column(3, actionButton("reset_16a", "Reset York County")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider3", h6("Labor Force Outflow % in 2045"), value=FrankCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("lincolnCoSlider3", h6("Labor Force Outflow % in 2045"), value=LincoCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("sagadahocCoSlider3", h6("Labor Force Outflow % in 2045"), value=SagadaCo3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("yorkCoSlider3", h6("Labor Force Outflow % in 2045"), value=YorkCo3Default, min=0, max=100, step=0.1)),
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo3Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo3Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo3Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo3Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("New Hampshire")),
                             column(3, h5("Massachusetts")),
                             column(3, h5("CT-RI-VT")),
                             column(3, h5("Rest of US")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_17a", "Reset New Hampshire")),
                             column(3, actionButton("reset_18a", "Reset Massachusetts")),
                             column(3, actionButton("reset_19a", "Reset CT-RI-VT")),
                             column(3, actionButton("reset_20a", "Reset Rest of US")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("NH_Slider3", h6("Labor Force Outflow % in 2045"), value=NH3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("MA_Slider3", h6("Labor Force Outflow % in 2045"), value=MA3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("CtRiVt_Slider3", h6("Labor Force Outflow % in 2045"), value=CtRiVt3Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("RestUS_Slider3", h6("Labor Force Outflow % in 2045"), value=RestUS3Default, min=0, max=100, step=0.1)),
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", NH3Default, "%"))),
                             column(3, h6(paste("Default: ", MA3Default, "%"))),
                             column(3, h6(paste("Default: ", CtRiVt3Default, "%"))),
                             column(3, h6(paste("Default: ", RestUS3Default, "%"))),
                    ),
                    
           ),
           
  ###############################################################################
  # End County Outflows Tab
  ###############################################################################



  ###############################################################################
  # Workforce Trip Table Tab
  ###############################################################################

           tabPanel("Workforce Trip Table",
                    
                    h3("4. 2045 Workforce Trip Table"),
                    
                    
                    hr(),
                    
                    DT::dataTableOutput("tripMatrix"),
                    
                    hr(),
                    
                    ##ToDo Add 2019 employment origin-destination numbers and percentages to the More Data menu
                    
                    p("This tab contains a trip table showing work trips originating in each county/state/region (by column) to
                    workfplaces located in each county/state/region (by row). 
                      The percentages used to calcuate trips are based on 2019 employment origin-destination data from Census on the Map. 
                      The 2019 employment origin-destination numbers and percentages can also be viewed under the Source Data menu."),
                    
                    hr(),
                    
                    p("The 2045 trip table was calculated by multiplying the 2019 Origin-Destination Percentages matrix
                      by the 2045 Workforce matrix. These are displayed below."),
                    
                    hr(),
                    
                    h4("4a. 2045 Workforce Matrix"),
                    
                    p('Each row of Workforce Matrix is the Revised County Workforce data from the Workforce Forecast tab. 
                      Each column of this matrix is a county, state, or other geographic region. 
                      As you read down each column you will see the same value is repeated in each row. 
                      Each row represents the total work trips originating in the county, designated by the column heading.'),
                    
                    DT::dataTableOutput("workforceMatrix"),
                    
                    hr(),
                    
                    h4("4b. 2019 Origin-Destination Percentages Matrix"),
                    
                    p('The 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data.
                      As you read down each column in the 2019 Origin-Destination Percentages data, 
                      each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region.
                      The 2019 Origin-Destination Trip Table from the Census OTM data can be viewed under the "Source Data" menu.'),
                    
                    DT::dataTableOutput("originDestinationPercentages"),
                    
                    hr(),
                    
                    

     
           ),

  ###############################################################################
  # End Workforce Trip Table Tab
  ###############################################################################   



  ###############################################################################
  # Employment Trip Table Tab
  ###############################################################################

    tabPanel("Employment Trip Table",
         
         h3("4. 2045 Employment Trip Table"),
         
         
         hr(),
         
         DT::dataTableOutput("employmentTripTable"),
         
         hr(),
         
         ##ToDo Add 2019 employment origin-destination numbers and percentages to the More Data menu
         
         p("This tab contains a trip table showing work trips originating in each county/state/region (by column) to
                    workfplaces located in each county/state/region (by row). 
                      The percentages used to calcuate trips are based on 2019 employment origin-destination data from Census on the Map. 
                      The 2019 employment origin-destination numbers and percentages can also be viewed under the Source Data menu."),
         
         hr(),
         
         p("The 2045 employment trip table was calculated by multiplying the 2019 Origin-Destination Percentages matrix
                      by the 2045 Workforce matrix. These are displayed below."),
         
         hr(),
         
         h4("4a. 2045 Employment Matrix"),
         
         p('Each row of Workforce Matrix is the Revised County Workforce data from the Workforce Forecast tab. 
                      Each column of this matrix is a county, state, or other geographic region. 
                      As you read down each column you will see the same value is repeated in each row. 
                      Each row represents the total work trips originating in the county, designated by the column heading.'),
         
         DT::dataTableOutput("employmentMatrix"),
         
         hr(),
         
         h4("4b. 2019 Origin-Destination Percentages Matrix"),
         
         p('The 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data.
                      As you read down each column in the 2019 Origin-Destination Percentages data, 
                      each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region.
                      The 2019 Origin-Destination Trip Table from the Census OTM data can be viewed under the "Source Data" menu.'),
         
         DT::dataTableOutput("destinationOriginPercentages2"),
         
         hr(),
         
         
         
         
),

  ###############################################################################
  # End Employment Trip Table Tab
  ###############################################################################   



  ###############################################################################
  # Employment Balance Tab
  ###############################################################################   
           
           tabPanel("Employment Balance",
                    
                    h3("5. 2045 County Employment Balance"),
                    
                    
                    hr(),
                    
                    DT::dataTableOutput("balance"),
                    
                    hr(),
                    
                    
                    p("This tab compares the workforce commuting to work in each county to employment in each county."), 
                    p("The 2045 Employment Forecast is from the Employment Forecast tab. The 2045 Available Workforce is calculated from the Trip Table tab. 
                      The 2045 Local Workers column is calculated from the County Outflows tab."), 
                    p("The 2045 Inflows is the difference between 2045 Employment Forecast and 2045 Local Workers. 
                      The inflows represent the workforce that commutes into each county for work, based on the available employment in that county."), 
                    
                    p("The 2045 Available Workforce (Minus people working two jobs) shows a reduction in the total workforce, 
                    based on the slider values for the % of people working more than one job.
                    For example, if 2% of the workforce works more than one job, then The 2045 Available Workforce (Minus people working two jobs) is equal to
                    The 2045 Available Workforce minus 2% of the 2045 Available Workforce."),
                    
                    # p("The 2045 Inflows is the difference between 2045 Available Workforce and 2045 Local Workers. 
                    #   Alternatively, we could calculate this as the difference between 2045 Employment Forecast and 2045 Local Workers. 
                    #   This would equal the workforce that commutes to work in each county, based on available employment."), 
                    
                    p("The Balance (Employment - Workforce) column represents the difference between total employment and available workforce (Minus people working two jobs). 
                      In some cases the available workforce exceeds employment, in other cases employment exceeds available workforce."),
                    p("The 2019 employment origin-destination numbers and percentages can be viewed under the Source Data menu."),

                    hr(),
                    
                    fluidRow(column(3, h5("Androscoggin County")),
                             column(3, h5("Hancock County")),
                             column(3, h5("Oxford County")),
                             column(3, h5("Somerset County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_1c", "Reset Androscoggin County")),
                             column(3, actionButton("reset_2c", "Reset Hancock County")),
                             column(3, actionButton("reset_3c", "Reset Oxford County")),
                             column(3, actionButton("reset_4c", "Reset Somerset County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider5", h6("% Working Two Jobs in 2045"), value=AndroCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("hancockCoSlider5", h6("% Working Two Jobs in 2045"), value=HancockCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("oxfordCoSlider5", h6("% Working Two Jobs in 2045"), value=OxfordCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("somersetCoSlider5", h6("% Working Two Jobs in 2045"), value=SomerCo5Default, min=0, max=15, step=0.05))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AndroCo5Default, "%"))),
                             column(3, h6(paste("Default: ", HancockCo5Default, "%"))),
                             column(3, h6(paste("Default: ", OxfordCo5Default, "%"))),
                             column(3, h6(paste("Default: ", SomerCo5Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Aroostook County")),
                             column(3, h5("Kennebec County")),
                             column(3, h5("Penobscot County")),
                             column(3, h5("Waldo County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_5c", "Reset Aroostook County")),
                             column(3, actionButton("reset_6c", "Reset Kennebec County")),
                             column(3, actionButton("reset_7c", "Reset Penobscot County")),
                             column(3, actionButton("reset_8c", "Reset Waldo County")),
                             
                    ),
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider5", h6("% Working Two Jobs in 2045"), value=AroostCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("kennebecCoSlider5", h6("% Working Two Jobs in 2045"), value=KennebCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("penobscotCoSlider5", h6("% Working Two Jobs in 2045"), value=PenobCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("waldoCoSlider5", h6("% Working Two Jobs in 2045"), value=WaldoCo5Default, min=0, max=15, step=0.05))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", AroostCo5Default, "%"))),
                             column(3, h6(paste("Default: ", KennebCo5Default, "%"))),
                             column(3, h6(paste("Default: ", PenobCo5Default, "%"))),
                             column(3, h6(paste("Default: ", WaldoCo5Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("Cumberland County")),
                             column(3, h5("Knox County")),
                             column(3, h5("Piscataquis County")),
                             column(3, h5("Washington County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_9c", "Reset Cumberland County")),
                             column(3, actionButton("reset_10c", "Reset Knox County")),
                             column(3, actionButton("reset_11c", "Reset Piscataquis County")),
                             column(3, actionButton("reset_12c", "Reset Washington County")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider5", h6("% Working Two Jobs in 2045"), value=CumberCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("knoxCoSlider5", h6("% Working Two Jobs in 2045"), value=KnoxCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("piscataquisCoSlider5", h6("% Working Two Jobs in 2045"), value=PiscatCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("washingtonCoSlider5", h6("% Working Two Jobs in 2045"), value=WashinCo5Default, min=0, max=15, step=0.05))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", CumberCo5Default, "%"))),
                             column(3, h6(paste("Default: ", KnoxCo5Default, "%"))),
                             column(3, h6(paste("Default: ", PiscatCo5Default, "%"))),
                             column(3, h6(paste("Default: ", WashinCo5Default, "%"))),
                    ),
                    
                    
                    
                    fluidRow(column(3, h5("Franklin County")),
                             column(3, h5("Lincoln County")),
                             column(3, h5("Sagadahoc County")),
                             column(3, h5("York County")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_13c", "Reset Franklin County")),
                             column(3, actionButton("reset_14c", "Reset Lincoln County")),
                             column(3, actionButton("reset_15c", "Reset Sagadahoc County")),
                             column(3, actionButton("reset_16c", "Reset York County")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider5", h6("% Working Two Jobs in 2045"), value=FrankCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("lincolnCoSlider5", h6("% Working Two Jobs in 2045"), value=LincoCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("sagadahocCoSlider5", h6("% Working Two Jobs in 2045"), value=SagadaCo5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("yorkCoSlider5", h6("% Working Two Jobs in 2045"), value=YorkCo5Default, min=0, max=15, step=0.05))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo5Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo5Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo5Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo5Default, "%"))),
                    ),
                    
                    
                    fluidRow(column(3, h5("New Hampshire")),
                             column(3, h5("Massachusetts")),
                             column(3, h5("CT-RI-VT")),
                             column(3, h5("Rest of US")),
                    ),
                    
                    fluidRow(column(3, actionButton("reset_17c", "Reset New Hampshire")),
                             column(3, actionButton("reset_18c", "Reset Massachusetts")),
                             column(3, actionButton("reset_19c", "Reset CT-RI-VT")),
                             column(3, actionButton("reset_20c", "Reset Rest of US")),
                             
                    ),
                    
                    
                    fluidRow(column(3, sliderInput("NH_Slider5", h6("% Working Two Jobs in 2045"), value=NH5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("MA_Slider5", h6("% Working Two Jobs in 2045"), value=MA5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("CtRiVt_Slider5", h6("% Working Two Jobs in 2045"), value=CtRiVt5Default, min=0, max=15, step=0.05)),
                             column(3, sliderInput("RestUS_Slider5", h6("% Working Two Jobs in 2045"), value=RestUS5Default, min=0, max=10, step=0.01))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", NH5Default, "%"))),
                             column(3, h6(paste("Default: ", MA5Default, "%"))),
                             column(3, h6(paste("Default: ", CtRiVt5Default, "%"))),
                             column(3, h6(paste("Default: ", RestUS5Default, "%"))),
                    ),
     
           ),

  ###############################################################################
  # End Employment Balance Tab
  ###############################################################################


###############################################################################
# 2019 Workforce Forecast Tab
############################################################################### 

tabPanel("2019 Workforce Forecast",
         
         h3("2019 Workforce"),
         
         
         hr(),
         
         DT::dataTableOutput("workforce2019"),
         
         hr(),
         
         p("This tab contains the 2019 Workforce data."),
         p("The 2019 population is from the Woods and Poole forecast."),
         p("The Working Age Population 2019 is the 2019 population multiplied by the percent of population aged 15+ 
           from the Woods and Poole forecast."),
         p("The Workforce Population 2019 is the working aged population multiplied by the labor force participation rate 
           from the labor force participation rate  from the 2019 Census ACS 5-year sample."),
         
         
         
         
),



###############################################################################
# 2019 County Outflows Tab
###############################################################################

tabPanel("2019 County Outflows",


         h3("2019 County Outflows"),


         hr(),

         DT::dataTableOutput("countyFlows2019"),

         hr(),

         p("This tab contains the workers that commute outside of their home county for work, .
                      based on 2019 employment data from Census on the Map."),
         p("The County Employment 2019 column is based on the the Woods and Poole forecast.
                      "),
         p("The County Workforce 2019 column is the 2019 Workforce population from the 2019 Workforce Forecast tab.
                      "),
         p("The Percent Workforce Outflows 2019 column is based on 2019 employment data from Census on the Map.
                      "),


),

###############################################################################
# End 2019 County Outflows Tab
###############################################################################



###############################################################################
# 2019 Workforce Trip Table Tab
###############################################################################
 
tabPanel("2019 Workforce Trip Table",

         h3("2019 Workforce Trip Table"),


         hr(),

         DT::dataTableOutput("tripMatrix2019"),

         hr(),


         p("This tab contains a trip table showing 2019 available workforce trips originating in each county/state/region (by column) to
                    workplaces located in each county/state/region (by row). This is the available workforce, based on the age structure and labor
                    force participation rates in each county. The employed workforce will depend on the number of jobs in each county.
                      The percentages used to calcuate trips are based on 2019 employment origin-destination data from Census on the Map.
                      The 2019 employment origin-destination numbers and percentages can also be viewed under the Source Data menu."),

         hr(),

         p("The 2019 trip table was calculated by multiplying the 2019 Origin-Destination Percentages matrix
                      by the 2019 Workforce matrix. These are displayed below."),

         hr(),

         h4("2019 Workforce Matrix"),

         p('Each row of Workforce Matrix is the Revised County Workforce data from the Workforce Forecast tab.
                      Each column of this matrix is a county, state, or other geographic region.
                      As you read down each column you will see the same value is repeated in each row.
                      Each row represents the total work trips originating in the county, designated by the column heading.'),

         DT::dataTableOutput("workforceMatrix2019"),

         hr(),

         h4("2019 Origin-Destination Percentages Matrix"),

         p('The 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data.
                      As you read down each column in the 2019 Origin-Destination Percentages data,
                      each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region.
                      The 2019 Origin-Destination Trip Table from the Census OTM data can be viewed under the "Source Data" menu.'),

         DT::dataTableOutput("originDestinationPercentages2"),

         hr(),




),

###############################################################################
# End 2019 Workforce Trip Table Tab
###############################################################################



###############################################################################
# 2019 Employment Trip Table Tab
###############################################################################

tabPanel("2019 Employment Trip Table",
         
         h3("2019 Employment Trip Table"),
         
         
         hr(),
         
         DT::dataTableOutput("employmentTripTable2019"),
         
         hr(),
         
         
         p("This tab contains a trip table showing 2019 employment trips originating in each county/state/region (by column) to
                    workplaces located in each county/state/region (by row). The employment totals for each county are the wage and salary
                    employment shown in the 2019 County Outflows tab.
                      The percentages used to calcuate trips are based on 2019 employment origin-destination data from Census on the Map.
                      The 2019 employment origin-destination numbers and percentages can also be viewed under the Source Data menu."),
         
         hr(),
         
         p("The 2019 trip table was calculated by multiplying the 2019 Origin-Destination Percentages matrix
                      by the 2019 Employment matrix. These are displayed below."),
         
         hr(),
         
         h4("2019 Employment Matrix"),
         
         p('Each column of Employment Matrix is the Wage and Salary Employment data from the 2019 Workforce Outflows tab.
                      Each column of this matrix is a county, state, or other geographic region.
                      As you read across each row you will see the same value is repeated in each column.
                      Each row represents the total work trips that end in the row county. Each row will be multiplied by each row
                      in the 2019 Origin-Destinations Percentages matrix to calculate the percentage of work trips that originate in
                      each county/state, designated by the column heading.'),
         
         DT::dataTableOutput("employmentMatrix2019"),
         
         hr(),
         
         h4("2019 Origin-Destination Percentages Matrix"),
         
         p('The 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data.
                      As you read down each column in the 2019 Origin-Destination Percentages data,
                      each row represents the percentage of trips to the destination row that originate in the column county/region.
                      The 2019 Origin-Destination Trip Table from the Census OTM data can be viewed under the "Source Data" menu.'),
         
         DT::dataTableOutput("destinationOriginPercentages"),
         
         hr(),
         
         
         
         
),

###############################################################################
# End 2019 Employment Trip Table Tab
###############################################################################



###############################################################################
# 2019 Employment Balance Tab
###############################################################################   

tabPanel("2019 Employment Balance",

         h3("2019 County Employment Balance"),


         hr(),

         DT::dataTableOutput("balance2019"),

         hr(),


         p("This tab compares the workforce commuting to work in each county to employment in each county."),
         p("The 2019 Employment data is from the 2019 Census OTM employment data. The 2019 Available Workforce is calculated from the 2019 Trip Table tab.
                      The 2019 Local Workers column is calculated from the 2019 County Outflows tab."),
         p("The 2019 Inflows is the difference between 2019 Employment Forecast and 2019 Local Workers.
                      The inflows represent the workforce that commutes into each county for work, based on the available employment in that county."),

         # p("The 2019 Available Workforce (Minus people working two jobs) shows a reduction in the total workforce,
         #            based on the slider values for the % of people working more than one job.
         #            For example, if 2% of the workforce works more than one job, then The 2045 Available Workforce (Minus people working two jobs) is equal to
         #            The 2045 Available Workforce minus 2% of the 2045 Available Workforce."),

         # p("The 2045 Inflows is the difference between 2045 Available Workforce and 2045 Local Workers.
         #   Alternatively, we could calculate this as the difference between 2045 Employment Forecast and 2045 Local Workers.
         #   This would equal the workforce that commutes to work in each county, based on available employment."),

         p("The Balance (Employment - Workforce) column represents the difference between total employment and available workforce (Minus people working two jobs).
                      In some cases the available workforce exceeds employment, in other cases employment exceeds available workforce."),
         p("The 2019 employment origin-destination numbers and percentages can be viewed under the Source Data menu."),



),

###############################################################################
# End 2019 Employment Balance Tab
###############################################################################




  ###############################################################################
  # Source Data Menu
  ###############################################################################

           navbarMenu("Source Data",
                      
                      tabPanel("1. Population Forecast",
                               DT::dataTableOutput("populationForecast"),
                               hr(),
                               
                               HTML("<p>The 2020 Population Totals are from the <a href='https://data.census.gov'>2020 Census</a>.</p>"),
                               
                               HTML("<p>The 2045 Population Totals are from <a href='https://www.woodsandpoole.com/'>Woods and Poole Economics Inc</a>.</p>"),
                               
                               
                               ),
                      
                      tabPanel("2. Employment Forecast",
                                DT::dataTableOutput("employmentForecast2"),
                               
                               hr(),
                               
                               HTML("<p>The 2019 Census Wage and Salary Totals are from the <a href='https://onthemap.ces.census.gov/'>Census On the Map</a>.</p>"),
                               
                               HTML("<p>The 2019 BEA Employment Totals are from <a href='https://www.bea.gov/data/by-place-us'>Bureau of Economic Analysis</a>.</p>"),
                               
                               HTML("<p>The WP 2019 and WP 2045 Employment Totals are from <a href='https://www.woodsandpoole.com/'>Woods and Poole Economics Inc</a>.</p>"),
                               
                               ),
                      
                      tabPanel("3. Age Structure",
                               DT::dataTableOutput("ageStructure2045"),
                               
                               hr(),
                               
                               HTML("<p>The 2045 age structure data are from <a href='https://www.woodsandpoole.com/'>Woods and Poole Economics Inc</a>.</p>"),
                               
                      ),
                      
                      tabPanel("4. County Laborforce Participation 2019",
                               DT::dataTableOutput("countyWorkforce2019"),
                               
                               hr(),
                               
                               HTML("<p>The 2019 Laborce Participation Rate is from the <a href='https://data.census.gov'>2019 American Community Sample 5-year survey</a>.</p>"),
                      ),
                      
                      tabPanel("5. County Workflows 2019",
                               DT::dataTableOutput("countyWorkflows2019"),
                               
                               hr(),
                               
                               HTML("<p>The 2019 Census County Inflows and Outflows are from the <a href='https://onthemap.ces.census.gov/'>Census On the Map</a>.</p>"),
                      ),

                      tabPanel("6. 2019 Trip Table",
                               DT::dataTableOutput("tripTable2019"),
                               
                               hr(),
                               
                               HTML("<p>The 2019 Trip Table Totals are from the <a href='https://onthemap.ces.census.gov/'>Census On the Map</a>.</p>"),
                      ),
                      
                      tabPanel("7. 2019 Origin-Destination %s",
                               DT::dataTableOutput("OD_Percentages2019"),
                               
                               hr(),
                               
                               HTML("<p>The 2019 Origin-Destination %s are calculated from origin-destination data from <a href='https://onthemap.ces.census.gov/'>Census On the Map</a>.</p>"),
                      ),
                      
                      tabPanel("8. Census 2020 vs WP 2019 and 2020",
                               DT::dataTableOutput("populationData"),
                               hr(),
                               
                               HTML("<p>The Census 2020 Population Totals are from the <a href='https://data.census.gov'>2020 Census</a>.</p>"),
                               
                               HTML("<p>The WP 2019 and 2020 Population Totals are from <a href='https://www.woodsandpoole.com/'>Woods and Poole Economics Inc</a>.</p>"),
                               
                               
                      ),
     
                      
           )
)

###############################################################################
# End Source Data Menu
###############################################################################


###############################################################################
###############################################################################
# End UI
###############################################################################
###############################################################################






###############################################################################
###############################################################################
# Define Server Logic
###############################################################################
###############################################################################

server <- function(input, output, session) {
  

###############################################################################
  # Define UI Reactives
###############################################################################

source('UI_Reactives.r', local=TRUE)  

###############################################################################
# End of UI Reactives
###############################################################################
  
  
###############################################################################
# Define Reactive Calculations
###############################################################################
  
  
  ###############################################################################
  # Adjust Employment Forecast Reactive
  ###############################################################################
  
  ## This reactive function will adjust the baseline 2045 employment forecast
  ## based on user defined Percent Wage and Salary employment from the 
  ## wage and salary % employment sliders
  
  adjustEmploymentForecast <- reactive({

    
    # Get the % Wage and Salary Employment from the 2045 Wage and Salary Sliders
    PCT_WageSalary_2045 <- WageAndSalarySliderValue2045()
    
    # The working two jobs slider was moved to the employment balance tab
    # I think it makes more sense there
    #two_jobs_percentage <- WorkingTwoJobsSliderValue2045()
    
    # employment_forecast is a data fram containing the employment data that was 
    # loaded at the beginning of this script
    employment_forecast <- data.frame(employment)
    
    # Assign these column headings to the employment forecast data frame
    names(employment_forecast) <- c('County','Census_2019_WS_Employment','BEA_2019_Total_Employment',
                                    'BEA_2019_WS_Employment','BEA_2019_Self_Employment','BEA_2019_Other_Employment',
                                    'WP_2019_Jobs','WP_2019_Other_Employment','PCT_2019_Wage_Salary_Employment',
                                    'PCT_2019_Self_Employment','PCT_2019_BEA_Other_Employment','PCT_2019_WP_Other_Employment',
                                    'WP_2045_Jobs')
    
    # WP_2045_Jobs_Adjusted is the total 2045 employment multiplied by the % from the wage and salary slider
    # This is equal to the Wage and Salary employment in the 2045 forecast
    WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs * PCT_WageSalary_2045
    
    
    # This is old functionality
    
    # The working two jobs slider was moved to the employment balance tab
    # I think it makes more sense there
    #two_jobs_reduction <- two_jobs_percentage * WP_2045_Jobs_Adjusted
    
    # The working two jobs slider was moved to the employment balance tab
    # I think it makes more sense there
    #WP_2045_Jobs_Adjusted2 <- WP_2045_Jobs_Adjusted - two_jobs_reduction
    
    # This is an earlier version that has the two jobs adjusted column
    #employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, employment_forecast$WP_2045_Jobs, PCT_WageSalary_2045, two_jobs_percentage, WP_2045_Jobs_Adjusted, WP_2045_Jobs_Adjusted2)
    
    #employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, 
                               # employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, 
                               # employment_forecast$WP_2045_Jobs, PCT_WageSalary_2045, 
                               # two_jobs_percentage, WP_2045_Jobs_Adjusted)
    
    # End of old functionality
    
    
    # Create a new data frame with the following columns:
    # County/Region, 2019 Census Wage and Salary Employment, 2019 Census Wage and Salary Employment as % of 2019 Woods and Poole forecast
    # Woods and Poole 2019 total employment, Woods and Poole 2045 total employment, the slider values from the Wage and Salary employment sliders,
    # and the adjusted 2045 Wage and Salary Employment
    employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, 
                                employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, 
                                employment_forecast$WP_2045_Jobs, PCT_WageSalary_2045, 
                                WP_2045_Jobs_Adjusted)
    
    
    # Return the employment_forecast data frame
    employment_forecast
    
  }) # End of adjustEmploymentForecast Reactive
  
  ###############################################################################
  # End Adjust Employment Forecast Reactive
  ###############################################################################

  
  
  ###############################################################################
  # Adjust Workforce Population Reactive
  ############################################################################### 
  
  adjustWorkforcePopulation <- reactive({
    
    ## This reactive function will adjust the baseline 2045 workforce population forecast
    ## based on user defined Percent Working Age Population and Workforce Participation from the 
    ## % working age population and workforce participation rate sliders
    
    
    # revised_working_age_population_2045_PCT is a vector containing the 2045 working age population slider values
    # This vector is updated when the user changes the slider values
    revised_working_age_population_2045_PCT <- workingAgePopulationSliderValue2045()
    
    # revised_workforce_participation_rate_2045 is a vector containing the 2045 workforce participation rate slider values
    # This vector is updated when the user changes the slider values
    revised_workforce_participation_rate_2045 <- WorkforceParticipationSliderValue2045()
    
    
    # The County vector contains the County names from the first column of the
    # population forecast, loaded at the beginning of the script
    County <- population_forecast$County
    
    # The Population vector contains the Woods and Poole 2045 population forecast from the
    # population forecast loaded at the beginning of the script
    Population <- population_forecast$WP_2045_Forecast
    
    # I don't think we need this here
    # ToDo: determine if we need this
    # I've commented it out, think we can delete if the program still works
    #revised_employment_forecast <- cbind(employment, revised_working_age_population_2045_PCT, revised_workforce_participation_rate_2045)
    
    
    # The revised working age population in 2045 is equal to the 2045 forecast times the revised % working age population in 2045
    # The revised % working age population in 2045 is updated when users change the % working age population slider values
    revised_working_age_population_2045 <- Population * revised_working_age_population_2045_PCT
    
    
    # The revised county workforce population in 2045 is equal to the 2045 working age population times the revised 2045 workforce participation rate
    # Both the 2045 working age population and the 2045 workforce participation rate are updated when users change the related slider values
    revised_county_workforce_2045 <- revised_working_age_population_2045 * revised_workforce_participation_rate_2045
    
    # The output workforce forecast is a data frame containing: County/Region name,
    # 2045 Population, Revised Working Age Population 2045, Revised County Workforce Population 2045,
    # Revised % Working Age Population in 2045, Revised Workforce Participation Rate in 2045
    output_workforce_forecast <-cbind(County, Population, revised_working_age_population_2045, 
                                       revised_county_workforce_2045, revised_working_age_population_2045_PCT, 
                                       revised_workforce_participation_rate_2045)
    
    
    # Assign these column names to the output workforce forecast
    colnames(output_workforce_forecast) <- c('County', 'Forecast_2045_Population', 'revised_working_age_population_2045', 
                                             'revised_county_workforce_2045', 'revised_working_age_population_2045_PCT', 
                                             'revised_workforce_participation_rate_2045')
    
    
    # Return the output_workforce_forecast for 2045
    output_workforce_forecast
    
  }) #End Adjust Workforce Population Reactive
  
  ###############################################################################
  # End Adjust Workforce Population Reactive
  ###############################################################################

  
  ###############################################################################
  # 2019 Adjust Workforce Population Reactive
  ############################################################################### 
  
  adjust2019WorkforcePopulation <- reactive({
    
    ## This reactive function will display the baseline 2019 workforce population 
    
    
    # The County vector contains the County names from the first column of the
    # population forecast, loaded at the beginning of the script
    County <- population_forecast$County
    
    # The Population vector contains the Woods and Poole 2045 population forecast from the
    # population forecast loaded at the beginning of the script
    Population <- population_2019$WP_2019_Forecast
    
    working_age_population_2019_PCT <- ageStructure_2019[,4]
    
    labor_force_participation_2019_PCT <- laborParticipation[,2]
    
    # The revised working age population in 2045 is equal to the 2045 forecast times the revised % working age population in 2045
    # The revised % working age population in 2045 is updated when users change the % working age population slider values
    working_age_population_2019 <- Population * working_age_population_2019_PCT
    
    
    # The revised county workforce population in 2045 is equal to the 2045 working age population times the revised 2045 workforce participation rate
    # Both the 2045 working age population and the 2045 workforce participation rate are updated when users change the related slider values
    county_workforce_2019 <- working_age_population_2019 * labor_force_participation_2019_PCT
    
    # The output workforce forecast is a data frame containing: County/Region name,
    # 2045 Population, Revised Working Age Population 2045, Revised County Workforce Population 2045,
    # Revised % Working Age Population in 2045, Revised Workforce Participation Rate in 2045
    output_workforce_forecast2 <-cbind(County, Population, working_age_population_2019, 
                                      county_workforce_2019)
    
    
    # Assign these column names to the output workforce forecast
    colnames(output_workforce_forecast2) <- c('County', 'WP_2019_Population', 'working_age_population_2019', 
                                             'county_workforce_2019')
    
    
    # Return the output_workforce_forecast for 2019
    output_workforce_forecast2
    
  }) #End 2019Adjust Workforce Population Reactive
  
  ###############################################################################
  # End 2019 Adjust Workforce Population Reactive
  ###############################################################################
  
  
  ###############################################################################
  # Adjust County Outflows Reactive
  ###############################################################################  
  
  ## This reactive function will adjust the baseline 2045 workforce population forecast
  ## based on user defined Percent County Workforce that commutes outside county of residence 
  ## from the workforce outflow % sliders
  
  adjustCountyOutflows <- reactive({
    
    
    # The employment_forecast data frame contains the adjusted employment forecast 
    # from the Employment Forecast tab
    employment_forecast <- data.frame(adjustEmploymentForecast())
    
    # The revised workforce data frame contains the adjusted workforce forecast 
    # from the Workforce Forecast tab
    revisedWorkforce <- data.frame(adjustWorkforcePopulation())
    

    # The revised workforce outflows 2045 vector contains the values from the
    # workforce outflows 2045 sliders
    revised_workforce_outflows_2045 <- workforceOutflowsSliderValue2045()
    
    
    # The revised workforce forecast contains the following columns:
    # County/Region name, 2045 Adjusted Employment Forecast, 
    # 2045 Revised County Workforce Population, 2045 Revised Workforce Outflows %
    revised_workforce_forecast <- data.frame(cbind(revisedWorkforce$County, employment_forecast$WP_2045_Jobs_Adjusted, 
                                                   revisedWorkforce$revised_county_workforce_2045, revised_workforce_outflows_2045))
    
    # Assign these column names to the revised workforce forecast data frame
    names(revised_workforce_forecast) <- c('County', 'County_Employment_2045', 'County_Workforce_2045', 'Pct_Workforce_outflows_2045')
    

    ## Calculate the revised county workforce outflows and locals in 2045
    
    # The revised county workforce outflows 2045 is equal to the revised workforce forecast 2045
    # times the revised % workforce outflows 2045
    revised_county_workforce_outflows_2045 <- as.numeric(revised_workforce_forecast$County_Workforce_2045) * as.numeric(revised_workforce_forecast$Pct_Workforce_outflows_2045)
    
    # The revised county workforce locals 2045 is equal to the revised workforce forecast 2045 minus
    # the revised county workforce outflows in 2045
    revised_county_workforce_locals_2045 <- as.numeric(revised_workforce_forecast$County_Workforce_2045) - as.numeric(revised_county_workforce_outflows_2045)
    
    
    # The employment balance is equal to the revised 2045 employment total minus the revised county workforce locals in 2045
    # This balance represents the total inflows from other counties needed to fill the remaining jobs
    employment_balance <- as.numeric(revised_workforce_forecast$County_Employment_2045) - as.numeric(revised_county_workforce_locals_2045)
    

    # The revised workforce forecast contains the following columns:
    # County/Region name, 2045 Adjusted Employment Forecast, 
    # 2045 Revised County Workforce Population, 2045 Revised Workforce Outflows %,
    # Revised County Workforce Outflows 2045, Revised County Workforce Locals 2045, Employment Balance
    revised_workforce_forecast <- cbind(revised_workforce_forecast, revised_county_workforce_outflows_2045, 
                                        revised_county_workforce_locals_2045, employment_balance)
    
    
    # Return the revised workforce forecast data frame
    revised_workforce_forecast
    
    
  }) #End Adjust County Outflows Reactive
  
  ###############################################################################
  # End Adjust County Outflows Reactive
  ###############################################################################
  
  
  
  ###############################################################################
  # 2019 Adjust County Outflows Reactive
  ###############################################################################  
  
  ## This reactive function will adjust the baseline 2045 workforce population forecast
  ## based on user defined Percent County Workforce that commutes outside county of residence 
  ## from the workforce outflow % sliders
  
  CountyOutflows2019 <- reactive({
    
    
    # The employment_forecast data frame contains the adjusted employment forecast 
    # from the Employment Forecast tab
    total_employment_2019 <- employment$WP_2019_Jobs
    
    WS_employment_2019 <- employment$WP_2019_Jobs * employment$PCT_2019_Wage_Salary_Employment
    
    county <- employment$County
    
    # The revised workforce data frame contains the adjusted workforce forecast 
    # from the Workforce Forecast tab
    revisedWorkforce <- data.frame(adjust2019WorkforcePopulation())
    
    
    # The revised workforce outflows 2045 vector contains the values from the
    # workforce outflows 2045 sliders
    workforce_outflows_2019 <- workforceOutflows$Workforce_Percent_Outflows
    
    
    # The revised workforce forecast contains the following columns:
    # County/Region name, 2045 Adjusted Employment Forecast, 
    # 2045 Revised County Workforce Population, 2045 Revised Workforce Outflows %
    workforce_2019 <- data.frame(cbind(county, total_employment_2019, WS_employment_2019, 
                                                   revisedWorkforce$county_workforce_2019, workforce_outflows_2019))
    
    # Assign these column names to the revised workforce forecast data frame
    names(workforce_2019) <- c('County', 'Total_Employment_2019', 'WS_Employment_2019', 'County_Workforce_2019', 'Pct_Workforce_outflows_2019')
    
    
    ## Calculate the revised county workforce outflows and locals in 2045
    
    # The revised county workforce outflows 2045 is equal to the revised workforce forecast 2045
    # times the revised % workforce outflows 2045
    county_workforce_outflows_2019 <- as.numeric(workforce_2019$County_Workforce_2019) * as.numeric(workforce_2019$Pct_Workforce_outflows_2019)
    
    # The revised county workforce locals 2045 is equal to the revised workforce forecast 2045 minus
    # the revised county workforce outflows in 2045
    county_workforce_locals_2019 <- as.numeric(workforce_2019$County_Workforce_2019) - as.numeric(county_workforce_outflows_2019)
    
    
    # The employment balance is equal to the revised 2045 employment total minus the revised county workforce locals in 2045
    # This balance represents the total inflows from other counties needed to fill the remaining jobs
    employment_balance <- as.numeric(workforce_2019$WS_Employment_2019) - as.numeric(county_workforce_locals_2019)
    
    
    # The revised workforce forecast contains the following columns:
    # County/Region name, 2045 Adjusted Employment Forecast, 
    # 2045 Revised County Workforce Population, 2045 Revised Workforce Outflows %,
    # Revised County Workforce Outflows 2045, Revised County Workforce Locals 2045, Employment Balance
    revised_workforce_forecast <- cbind(workforce_2019, county_workforce_outflows_2019, 
                                        county_workforce_locals_2019, employment_balance)
    
    
    # Return the revised workforce forecast data frame
    revised_workforce_forecast
    
    
  }) #End Adjust County Outflows Reactive
  
  ###############################################################################
  # End 2019 Adjust County Outflows Reactive
  ###############################################################################
  
  
  
  ###############################################################################
  # Generate Workforce Matrix Reactive
  ############################################################################### 
  
  generateWorkforceMatrix <- reactive({
    
## This reactive function will create a workforce matrix from the revised workforce forecast
## This matrix will be used to calculate the 2045 trip table
    
    # adjustCountyOutflows is a reactive function that recalculates 
    # the county workforce based on changes to slider values
    #
    # county_flows is a data frame containing the County Outflows table
    # We will extract the revised workforce data from this data frame
    #
    county_flows <- data.frame(adjustCountyOutflows())
    
    
    
    # Get the revised workforce from the third column of the county_flows data frame
    #
    # This is a relative reference that may change if the number/order of columns in the data frame change
    #
    # The revised workforce can be modified by sliders in the Workforce Forecast and/or County Outflows tabs
    #
    # ToDo: Determine if it makes more sense to reference County Outflows or Workforce Forecast
    revised_workforce <- as.numeric(county_flows[,3])
    
    
    
# Create a Workforce Matrix that will be used to calculate the trips from 
# each origin county to each destination county in the 2045 trip table
    
    #
    # Each row of this matrix is the Revised County Workforce data from the county_flows data frame
    # Each column of this matrix is a county, state, or other geographic region
    #
    # As you read down each column you will see the same value is repeated in each row
    # Each row represents the total work trips originating in the county, designated by the column heading
    #
    # This matrix will be multiplied by the 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data
    # As you read down each column in the 2019 Origin-Destination Percentages data,
    # each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region
    #
    # The result of this calculation will be the number of trips originating in each column county/region 
    # that have a destination in each row county/region in 2045
    workforce_matrix <- rbind(revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce)
    
    
    # Add column names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(workforce_matrix) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                              'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                              'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                              'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins')
    
    # Add row names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table    
    rownames(workforce_matrix) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                              'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                              'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                              'Outside New England Destinations')
    
# Return the workforce matrix
    workforce_matrix
    
  }) # end generateWorkforceMatrix Reactive
  
  ###############################################################################
  # End Generate Workforce Matrix Reactive
  ############################################################################### 
  
  
  
  ###############################################################################
  # Generate Employment Matrix Reactive
  ############################################################################### 
  
  generateEmploymentMatrix <- reactive({
    
    ## This reactive function will create a workforce matrix from the revised workforce forecast
    ## This matrix will be used to calculate the 2045 trip table
    
    # adjustCountyOutflows is a reactive function that recalculates 
    # the county workforce based on changes to slider values
    #
    # county_flows is a data frame containing the County Outflows table
    # We will extract the revised workforce data from this data frame
    #
    county_flows <- data.frame(adjustCountyOutflows())
    
    
    
    # Get the revised workforce from the third column of the county_flows data frame
    #
    # This is a relative reference that may change if the number/order of columns in the data frame change
    #
    # The revised workforce can be modified by sliders in the Workforce Forecast and/or County Outflows tabs
    #
    # ToDo: Determine if it makes more sense to reference County Outflows or Workforce Forecast
    
    # This uses the county flows column 3, which is the 2045 wage and salary employment
    # The 2045 wage and salary employment should equal the 2045 employed workforce
    employment_2045 <- as.numeric(county_flows[,2])
    
    
    
    # Create a Workforce Matrix that will be used to calculate the trips from 
    # each origin county to each destination county in the 2045 trip table
    
    #
    # Each row of this matrix is the Revised County Workforce data from the county_flows data frame
    # Each column of this matrix is a county, state, or other geographic region
    #
    # As you read down each column you will see the same value is repeated in each row
    # Each row represents the total work trips originating in the county, designated by the column heading
    #
    # This matrix will be multiplied by the 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data
    # As you read down each column in the 2019 Origin-Destination Percentages data,
    # each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region
    #
    # The result of this calculation will be the number of trips originating in each column county/region 
    # that have a destination in each row county/region in 2045
    employment_matrix_2045 <- cbind(employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, 
                                    employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, 
                                    employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, employment_2045, 
                                    employment_2045, employment_2045)
    
    
    # Add column names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_matrix_2045) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                                          'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                                          'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                                          'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                                          'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins')
    
    # Add row names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table    
    rownames(employment_matrix_2045) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                                          'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                                          'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                                          'Outside New England Destinations')
    
    # Return the workforce matrix
    employment_matrix_2045
    
  }) # end generateEmploymentMatrix Reactive
  
  ###############################################################################
  # End Generate Employment Matrix Reactive
  ############################################################################### 
  
  
  
  ###############################################################################
  # Generate 2019 Workforce Matrix Reactive
  ############################################################################### 
  
  generateWorkforceMatrix2019 <- reactive({
    
    ## This reactive function will create a workforce matrix from the revised workforce forecast
    ## This matrix will be used to calculate the 2045 trip table
    
    # adjustCountyOutflows is a reactive function that recalculates 
    # the county workforce based on changes to slider values
    #
    # county_flows is a data frame containing the County Outflows table
    # We will extract the revised workforce data from this data frame
    #
    county_flows <- data.frame(CountyOutflows2019())
    
    
    
    # Get the revised workforce from the third column of the county_flows data frame
    #
    # This is a relative reference that may change if the number/order of columns in the data frame change
    #
    # The revised workforce can be modified by sliders in the Workforce Forecast and/or County Outflows tabs
    #
    # ToDo: Determine if it makes more sense to reference County Outflows or Workforce Forecast
    # For testing I commented this out, but this is the standard column to use here
    # Commenting this out because this uses the 2019 workforce, which is an estimate, based on age structure and labor force participation rate
    revised_workforce <- as.numeric(county_flows[,4])
    
    # This uses the county flows column 3, which is the 2019 wage and salary employment
    # The 2019 wage and salary employment should equal the 2019 employed workforce
    # Commented this out because this was for testing purposes
    #revised_workforce <- as.numeric(county_flows[,3])
    
    
    
    # Create a Workforce Matrix that will be used to calculate the trips from 
    # each origin county to each destination county in the 2045 trip table
    
    #
    # Each row of this matrix is the Revised County Workforce data from the county_flows data frame
    # Each column of this matrix is a county, state, or other geographic region
    #
    # As you read down each column you will see the same value is repeated in each row
    # Each row represents the total work trips originating in the county, designated by the column heading
    #
    # This matrix will be multiplied by the 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data
    # As you read down each column in the 2019 Origin-Destination Percentages data,
    # each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region
    #
    # The result of this calculation will be the number of trips originating in each column county/region 
    # that have a destination in each row county/region in 2045
    workforce_matrix <- rbind(revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, revised_workforce, 
                              revised_workforce, revised_workforce)
    
    
    # Add column names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(workforce_matrix) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins')
    
    # Add row names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table    
    rownames(workforce_matrix) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                                    'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                                    'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                                    'Outside New England Destinations')
    
    # Return the workforce matrix
    workforce_matrix
    
  }) # end generateWorkforceMatrix Reactive
  
  ###############################################################################
  # End 2019 Generate Workforce Matrix Reactive
  ###############################################################################
  
  
  
  
  ###############################################################################
  # Generate 2019 Employment Matrix Reactive
  ############################################################################### 
  
  generateEmploymentMatrix2019 <- reactive({
    
    ## This reactive function will create a workforce matrix from the revised workforce forecast
    ## This matrix will be used to calculate the 2045 trip table
    
    # adjustCountyOutflows is a reactive function that recalculates 
    # the county workforce based on changes to slider values
    #
    # county_flows is a data frame containing the County Outflows table
    # We will extract the revised workforce data from this data frame
    #
    county_flows <- data.frame(CountyOutflows2019())
    
    
    
    # Get the revised workforce from the third column of the county_flows data frame
    #
    # This is a relative reference that may change if the number/order of columns in the data frame change
    #
    # The revised workforce can be modified by sliders in the Workforce Forecast and/or County Outflows tabs
    #
    # ToDo: Determine if it makes more sense to reference County Outflows or Workforce Forecast
    
    # This uses the county flows column 3, which is the 2019 wage and salary employment
    # The 2019 wage and salary employment should equal the 2019 employed workforce
    employment_2019 <- as.numeric(county_flows[,3])
    
    
    
    # Create a Workforce Matrix that will be used to calculate the trips from 
    # each origin county to each destination county in the 2045 trip table
    
    #
    # Each row of this matrix is the Revised County Workforce data from the county_flows data frame
    # Each column of this matrix is a county, state, or other geographic region
    #
    # As you read down each column you will see the same value is repeated in each row
    # Each row represents the total work trips originating in the county, designated by the column heading
    #
    # This matrix will be multiplied by the 2019 Origin-Destination Percentages calculated from the 2019 Census OTM data
    # As you read down each column in the 2019 Origin-Destination Percentages data,
    # each row represents the percentage of trips that originate in the column county/region and have a destination in the row county/region
    #
    # The result of this calculation will be the number of trips originating in each column county/region 
    # that have a destination in each row county/region in 2045
    employment_matrix_2019 <- cbind(employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, 
                                    employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, 
                                    employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, employment_2019, 
                                    employment_2019, employment_2019)
    
    
    # Add column names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_matrix_2019) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins')
    
    # Add row names to the workforce matrix
    # These names will need to be changed if columns are added/removed from the trip table    
    rownames(employment_matrix_2019) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                                    'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                                    'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                                    'Outside New England Destinations')
    
    # Return the workforce matrix
    employment_matrix_2019
    
  }) # end generateWorkforceMatrix Reactive
  
  ###############################################################################
  # End 2019 Generate Employment Matrix Reactive
  ###############################################################################
  
  
  
  ###############################################################################
  # Generate #Reserved# Reactive
  ############################################################################### 
  
  
  
  ###############################################################################
  # Generate #Reserved# Reactive
  ############################################################################### 
  
  
  
  ###############################################################################
  # Generate Workforce Trip Table Reactive
  ############################################################################### 
  
  generateTripTable <- reactive({
    
    ## This reactive function will generate a trip table for 2045
    ## The result will have columns representing origin counties/states/regions and
    ## rows representing destination counties/states/regions in 2045
    
    ## First we will retrieve the revised workforce for 2045 from another tab
    ## then we will multiply the 2045 workforce by the 2019 Origin-Destinations Percentages matrix
    ## to calculate the number of trips from each origin county to each destination county

    ## Use the generateWorkforceMatrix reactive to generate a matrix of the 2045 workforce
    ## This matrix will be used to calculate the 2045 trip table
    workforce_matrix <- generateWorkforceMatrix()
    
    
    
## Calculate the 2045 Trip Table based on 2019 Origin-Destination data from the Census OTM
    
    ## The workforce_OD datafile was loaded at the beginning of this script
    ## The workforce_OD data are from the Census OTM 2019 Employment Data
    ## Each column represents an origin county/state/region
    ## Each row represents a destination county/state/region
    
    
    # Get the name of the destination counties/states/regions from the Origin-Destination data
    # The names are in the first column. This may change if the number/order of the columns change
    # ToDo: Determine if we need this. It doesn't look like we do so far...
    #destinations <- workforce_OD[,1]
    
    
    
## Create vectors containing the percentage of trips to each destination county/region by origin county/region
    
    #
    ## For example,androscoggin_origins_pct is a vector containing the percentage  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_origins_pct <- as.numeric(workforce_OD[,2])
    aroostook_origins_pct <- as.numeric(workforce_OD[,3])
    cumberland_origins_pct <- as.numeric(workforce_OD[,4])
    franklin_origins_pct <- as.numeric(workforce_OD[,5])
    hancock_origins_pct <- as.numeric(workforce_OD[,6])
    kennebec_origins_pct <- as.numeric(workforce_OD[,7])
    knox_origins_pct <- as.numeric(workforce_OD[,8])
    lincoln_origins_pct <- as.numeric(workforce_OD[,9])
    oxford_origins_pct <- as.numeric(workforce_OD[,10])
    penobscot_origins_pct <- as.numeric(workforce_OD[,11])
    piscataquis_origins_pct <- as.numeric(workforce_OD[,12])
    sagadahoc_origins_pct <- as.numeric(workforce_OD[,13])
    somerset_origins_pct <- as.numeric(workforce_OD[,14])
    waldo_origins_pct <- as.numeric(workforce_OD[,15])
    washington_origins_pct <- as.numeric(workforce_OD[,16])
    york_origins_pct <- as.numeric(workforce_OD[,17])
    nh_origins_pct <- as.numeric(workforce_OD[,18])
    ma_origins_pct <- as.numeric(workforce_OD[,19])
    CtRiVt_origins_pct <- as.numeric(workforce_OD[,20])
    RestUS_origins_pct <- as.numeric(workforce_OD[,21])
    
    
    
## Calculate the destinations to each row county/region for trips originating in each column county/region
    
    #
    ## For example, androscoggin_destinations is a vector containing the number  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_destinations <- androscoggin_origins_pct * workforce_matrix[,1]
    aroostook_destinations <- aroostook_origins_pct * workforce_matrix[,2]
    cumberland_destinations <- cumberland_origins_pct * workforce_matrix[,3]
    franklin_destinations <- franklin_origins_pct * workforce_matrix[,4]
    hancock_destinations <- hancock_origins_pct * workforce_matrix[,5]
    kennebec_destinations <- kennebec_origins_pct * workforce_matrix[,6]
    knox_destinations <- knox_origins_pct * workforce_matrix[,7]
    lincoln_destinations <- lincoln_origins_pct * workforce_matrix[,8]
    oxford_destinations <- oxford_origins_pct * workforce_matrix[,9]
    penobscot_destinations <- penobscot_origins_pct * workforce_matrix[,10]
    piscataquis_destinations <- piscataquis_origins_pct * workforce_matrix[,11]
    sagadahoc_destinations <- sagadahoc_origins_pct * workforce_matrix[,12]
    somerset_destinations <- somerset_origins_pct * workforce_matrix[,13]
    waldo_destinations <- waldo_origins_pct * workforce_matrix[,14]
    washington_destinations <- washington_origins_pct * workforce_matrix[,15]
    york_destinations <- york_origins_pct * workforce_matrix[,16]
    nh_destinations <- nh_origins_pct * workforce_matrix[,17]
    ma_destinations <- ma_origins_pct * workforce_matrix[,18]
    CtRiVt_destinations <- CtRiVt_origins_pct * workforce_matrix[,19]
    RestUS_destinations <- RestUS_origins_pct * workforce_matrix[,20]
    
    
## Create a trip table by combining the above vectors as columns in the trip table
    trip_table <- cbind(androscoggin_destinations, aroostook_destinations, cumberland_destinations, franklin_destinations, hancock_destinations, 
                           kennebec_destinations, knox_destinations, lincoln_destinations, oxford_destinations, penobscot_destinations, 
                           piscataquis_destinations, sagadahoc_destinations, somerset_destinations, waldo_destinations, washington_destinations, 
                           york_destinations, nh_destinations, ma_destinations, CtRiVt_destinations, RestUS_destinations)
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(trip_table) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins', 
                                 'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                                 'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins', 
                                 'CT-RI-VT Origins', 'Outside New England Origins' )
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(trip_table) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                                 'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                                 'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                                 'Outside New England Destinations')
    
    
    
## Calculate the total trips to each row county/region
    
    ## For example, Andro_Totals is the total number of trips from 
    ## each origin county/region to Androscoggin County 
    
    Andro_Totals <- sum(trip_table[1,])
    Aroostook_Totals <- sum(trip_table[2,])
    Cumberland_Totals <- sum(trip_table[3,])
    Franklin_Totals <- sum(trip_table[4,])
    Hancock_Totals <- sum(trip_table[5,])
    Kennebec_Totals <- sum(trip_table[6,])
    Knox_Totals <- sum(trip_table[7,])
    Lincoln_Totals <- sum(trip_table[8,])
    Oxford_Totals <- sum(trip_table[9,])
    Penobscot_Totals <- sum(trip_table[10,])
    Piscataquis_Totals <- sum(trip_table[11,])
    Sagadahoc_Totals <- sum(trip_table[12,])
    Somerset_Totals <- sum(trip_table[13,])
    Waldo_Totals <- sum(trip_table[14,])
    Washington_Totals <- sum(trip_table[15,])
    York_Totals <- sum(trip_table[16,])
    NH_Totals <- sum(trip_table[17,])
    MA_Totals <- sum(trip_table[18,])
    CtRiVt_Totals <- sum(trip_table[19,])
    RestUS_Totals <- sum(trip_table[20,])
    
    # Combine the above vectors into a new column representing
    # total trips to each row destination
    destination_totals <- rbind(Andro_Totals,Aroostook_Totals,Cumberland_Totals,Franklin_Totals,Hancock_Totals,Kennebec_Totals,
                          Knox_Totals,Lincoln_Totals,Oxford_Totals,Penobscot_Totals,Piscataquis_Totals,Sagadahoc_Totals,
                          Somerset_Totals, Waldo_Totals, Washington_Totals,York_Totals,NH_Totals,MA_Totals,CtRiVt_Totals,RestUS_Totals)
    
# Add the destination totals to the trip table
    trip_table <- cbind(trip_table, destination_totals)
    
    # Update column names in trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(trip_table) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                              'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                              'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                              'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations')
    
    
# Return the trip table
    trip_table
    
    
    
  }) # End generateTripTable Reactive
  
  ###############################################################################
  # End Generate Workforce Trip Table Reactive
  ###############################################################################   


  
  ###############################################################################
  # Generate Employment Trip Table Reactive
  ############################################################################### 
  
  generateEmploymentTripTable <- reactive({

      
      ## This reactive function will generate a trip table for 2045
      ## The result will have columns representing origin counties/states/regions and
      ## rows representing destination counties/states/regions in 2045
      
      ## First we will retrieve the revised workforce for 2045 from another tab
      ## then we will multiply the 2045 workforce by the 2019 Origin-Destinations Percentages matrix
      ## to calculate the number of trips from each origin county to each destination county
      
      ## Use the generateWorkforceMatrix reactive to generate a matrix of the 2045 workforce
      ## This matrix will be used to calculate the 2045 trip table
      employment_matrix2045 <- generateEmploymentMatrix()
      
      
      
      ## Calculate the 2045 Trip Table based on 2019 Origin-Destination data from the Census OTM
      
      ## The workforce_OD datafile was loaded at the beginning of this script
      ## The workforce_OD data are from the Census OTM 2019 Employment Data
      ## Each column represents an origin county/state/region
      ## Each row represents a destination county/state/region
      
      
      
      ## Create vectors containing the percentage of trips to each destination county/region by origin county/region
      
      #
      ## For example,androscoggin_origins_pct is a vector containing the percentage  
      ## of trips from Androscoggin County to each destination county/region
      #
      ## The columns are selected using relative references
      ## these references could change if the number/order of columns changes
      
      androscoggin_destinations_pct <- as.numeric(employment_DO[1,2:21])
      aroostook_destinations_pct <- as.numeric(employment_DO[2,2:21])
      cumberland_destinations_pct <- as.numeric(employment_DO[3,2:21])
      franklin_destinations_pct <- as.numeric(employment_DO[4,2:21])
      hancock_destinations_pct <- as.numeric(employment_DO[5,2:21])
      kennebec_destinations_pct <- as.numeric(employment_DO[6,2:21])
      knox_destinations_pct <- as.numeric(employment_DO[7,2:21])
      lincoln_destinations_pct <- as.numeric(employment_DO[8,2:21])
      oxford_destinations_pct <- as.numeric(employment_DO[9,2:21])
      penobscot_destinations_pct <- as.numeric(employment_DO[10,2:21])
      piscataquis_destinations_pct <- as.numeric(employment_DO[11,2:21])
      sagadahoc_destinations_pct <- as.numeric(employment_DO[12,2:21])
      somerset_destinations_pct <- as.numeric(employment_DO[13,2:21])
      waldo_destinations_pct <- as.numeric(employment_DO[14,2:21])
      washington_destinations_pct <- as.numeric(employment_DO[15,2:21])
      york_destinations_pct <- as.numeric(employment_DO[16,2:21])
      nh_destinations_pct <- as.numeric(employment_DO[17,2:21])
      ma_destinations_pct <- as.numeric(employment_DO[18,2:21])
      CtRiVt_destinations_pct <- as.numeric(employment_DO[19,2:21])
      RestUS_destinations_pct <- as.numeric(employment_DO[20,2:21])
      
      
      
      ## Calculate the destinations to each row county/region for trips originating in each column county/region
      
      #
      ## For example, androscoggin_destinations is a vector containing the number  
      ## of trips from Androscoggin County to each destination county/region
      #
      ## The columns are selected using relative references
      ## these references could change if the number/order of columns changes
      
      androscoggin_destinations2045 <- androscoggin_destinations_pct * employment_matrix2045[1,]
      aroostook_destinations2045 <- aroostook_destinations_pct * employment_matrix2045[2,]
      cumberland_destinations2045 <- cumberland_destinations_pct * employment_matrix2045[3,]
      franklin_destinations2045 <- franklin_destinations_pct * employment_matrix2045[4,]
      hancock_destinations2045 <- hancock_destinations_pct * employment_matrix2045[5,]
      kennebec_destinations2045 <- kennebec_destinations_pct * employment_matrix2045[6,]
      knox_destinations2045 <- knox_destinations_pct * employment_matrix2045[7,]
      lincoln_destinations2045 <- lincoln_destinations_pct * employment_matrix2045[8,]
      oxford_destinations2045 <- oxford_destinations_pct * employment_matrix2045[9,]
      penobscot_destinations2045 <- penobscot_destinations_pct * employment_matrix2045[10,]
      piscataquis_destinations2045 <- piscataquis_destinations_pct * employment_matrix2045[11,]
      sagadahoc_destinations2045 <- sagadahoc_destinations_pct * employment_matrix2045[12,]
      somerset_destinations2045 <- somerset_destinations_pct * employment_matrix2045[13,]
      waldo_destinations2045 <- waldo_destinations_pct * employment_matrix2045[14,]
      washington_destinations2045 <- washington_destinations_pct * employment_matrix2045[15,]
      york_destinations2045 <- york_destinations_pct * employment_matrix2045[16,]
      nh_destinations2045 <- nh_destinations_pct * employment_matrix2045[17,]
      ma_destinations2045 <- ma_destinations_pct * employment_matrix2045[18,]
      CtRiVt_destinations2045 <- CtRiVt_destinations_pct * employment_matrix2045[19,]
      RestUS_destinations2045 <- RestUS_destinations_pct * employment_matrix2045[20,]
      
      
      ## Create a trip table by combining the above vectors as columns in the trip table
      employment_trip_table2045 <- rbind(androscoggin_destinations2045, aroostook_destinations2045, cumberland_destinations2045, franklin_destinations2045, hancock_destinations2045, 
                                         kennebec_destinations2045, knox_destinations2045, lincoln_destinations2045, oxford_destinations2045, penobscot_destinations2045, 
                                         piscataquis_destinations2045, sagadahoc_destinations2045, somerset_destinations2045, waldo_destinations2045, washington_destinations2045, 
                                         york_destinations2045, nh_destinations2045, ma_destinations2045, CtRiVt_destinations2045, RestUS_destinations2045)
      
      # Add column names to the trip table
      # These names will need to be changed if columns are added/removed from the trip table
      colnames(employment_trip_table2045) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                                               'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                                               'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                                               'CT-RI-VT Origins', 'Outside New England Origins' )
      
      
      
      
      ## Calculate the total workers in each column county/region
      
      ## For example, Andro_Workers is the total number of workers from 
      ## Androscoggin County to each destination county/state
      
      Andro_Workers2045 <- sum(employment_trip_table2045[,1])
      Aroostook_Workers2045 <- sum(employment_trip_table2045[,2])
      Cumberland_Workers2045 <- sum(employment_trip_table2045[,3])
      Franklin_Workers2045 <- sum(employment_trip_table2045[,4])
      Hancock_Workers2045 <- sum(employment_trip_table2045[,5])
      Kennebec_Workers2045 <- sum(employment_trip_table2045[,6])
      Knox_Workers2045 <- sum(employment_trip_table2045[,7])
      Lincoln_Workers2045 <- sum(employment_trip_table2045[,8])
      Oxford_Workers2045 <- sum(employment_trip_table2045[,9])
      Penobscot_Workers2045 <- sum(employment_trip_table2045[,10])
      Piscataquis_Workers2045 <- sum(employment_trip_table2045[,11])
      Sagadahoc_Workers2045 <- sum(employment_trip_table2045[,12])
      Somerset_Workers2045 <- sum(employment_trip_table2045[,13])
      Waldo_Workers2045 <- sum(employment_trip_table2045[,14])
      Washington_Workers2045 <- sum(employment_trip_table2045[,15])
      York_Workers2045 <- sum(employment_trip_table2045[,16])
      NH_Workers2045 <- sum(employment_trip_table2045[,17])
      MA_Workers2045 <- sum(employment_trip_table2045[,18])
      CtRiVt_Workers2045 <- sum(employment_trip_table2045[,19])
      RestUS_Workers2045 <- sum(employment_trip_table2045[,20])
      
      # Combine the above vectors into a new row representing
      # total workers commuting from to each column origin
      worker_totals2045 <- cbind(Andro_Workers2045,Aroostook_Workers2045,Cumberland_Workers2045,Franklin_Workers2045,Hancock_Workers2045,Kennebec_Workers2045,
                                 Knox_Workers2045,Lincoln_Workers2045,Oxford_Workers2045,Penobscot_Workers2045,Piscataquis_Workers2045,Sagadahoc_Workers2045,
                                 Somerset_Workers2045, Waldo_Workers2045, Washington_Workers2045,York_Workers2045,NH_Workers2045,MA_Workers2045,CtRiVt_Workers2045,RestUS_Workers2045)
      
      
      # Add the destination totals to the trip table
      employment_trip_table2045 <- rbind(employment_trip_table2045, worker_totals2045)
      
      
      
      ## Calculate the total trips to each row county/region
      
      ## For example, Andro_Totals is the total number of trips from 
      ## each origin county/region to Androscoggin County 
      
      Andro_Totals2045 <- sum(employment_trip_table2045[1,])
      Aroostook_Totals2045 <- sum(employment_trip_table2045[2,])
      Cumberland_Totals2045 <- sum(employment_trip_table2045[3,])
      Franklin_Totals2045 <- sum(employment_trip_table2045[4,])
      Hancock_Totals2045 <- sum(employment_trip_table2045[5,])
      Kennebec_Totals2045 <- sum(employment_trip_table2045[6,])
      Knox_Totals2045 <- sum(employment_trip_table2045[7,])
      Lincoln_Totals2045 <- sum(employment_trip_table2045[8,])
      Oxford_Totals2045 <- sum(employment_trip_table2045[9,])
      Penobscot_Totals2045 <- sum(employment_trip_table2045[10,])
      Piscataquis_Totals2045 <- sum(employment_trip_table2045[11,])
      Sagadahoc_Totals2045 <- sum(employment_trip_table2045[12,])
      Somerset_Totals2045 <- sum(employment_trip_table2045[13,])
      Waldo_Totals2045 <- sum(employment_trip_table2045[14,])
      Washington_Totals2045 <- sum(employment_trip_table2045[15,])
      York_Totals2045 <- sum(employment_trip_table2045[16,])
      NH_Totals2045 <- sum(employment_trip_table2045[17,])
      MA_Totals2045 <- sum(employment_trip_table2045[18,])
      CtRiVt_Totals2045 <- sum(employment_trip_table2045[19,])
      RestUS_Totals2045 <- sum(employment_trip_table2045[20,])
      Worker_Totals2045 <- sum(employment_trip_table2045[21,])
      
      # Combine the above vectors into a new column representing
      # total trips to each row destination
      destination_totals2045 <- rbind(Andro_Totals2045,Aroostook_Totals2045,Cumberland_Totals2045,Franklin_Totals2045,Hancock_Totals2045,Kennebec_Totals2045,
                                      Knox_Totals2045,Lincoln_Totals2045,Oxford_Totals2045,Penobscot_Totals2045,Piscataquis_Totals2045,Sagadahoc_Totals2045,
                                      Somerset_Totals2045, Waldo_Totals2045, Washington_Totals2045,York_Totals2045,NH_Totals2045,MA_Totals2045,CtRiVt_Totals2045,RestUS_Totals2045,Worker_Totals2045)
      
      # Add the destination totals to the trip table
      employment_trip_table2045 <- cbind(employment_trip_table2045, destination_totals2045)
      
      
      # Add row names to the trip table
      # These names will need to be changed if columns are added/removed from the trip table
      rownames(employment_trip_table2045) <- c('Androscoggin County Employment', 'Aroostook County Employment', 'Cumberland County Employment', 'Franklin County Employment', 'Hancock County Employment', 'Kennebec County Employment',
                                               'Knox County Employment', 'Lincoln County Employment', 'Oxford County Employment', 'Penobscot County Employment', 'Piscataquis County Employment', 'Sagadahoc County Employment',
                                               'Somerset County Employment', 'Waldo County Employment', 'Washington County Employment', 'York County Employment', 'New Hampshire Employment', 'Masssachusetts Employment', 'CT-RI-VT Employment',
                                               'Outside New England Employment','Total Workforce')
      
      # Update column names in trip table
      # These names will need to be changed if columns are added/removed from the trip table
      colnames(employment_trip_table2045) <- c('Androscoggin County Workers', 'Aroostook County Workers', 'Cumberland County Workers', 'Franklin County Workers',
                                               'Hancock County Workers', 'Kennebec County Workers', 'Knox County Workers', 'Lincoln County Workers',
                                               'Oxford County Workers', 'Penobscot County Workers', 'Piscataquis County Workers', 'Sagadahoc County Workers',
                                               'Somerset County Workers', 'Waldo County Workers', 'Washington County Workers', 'York County Workers',
                                               'New Hampshire Workers', 'Massachusetts Workers', 'CT-RI-VT Workers', 'Outside New England Workers', 'Total Employment')
      
      
      # Return the trip table
      employment_trip_table2045
      
      
    
  }) # End generateEmploymentTripTable Reactive
  
  ###############################################################################
  # End Generate Employment Trip Table Reactive
  ###############################################################################   
  
  
  
    
  ###############################################################################
  # 2019 Generate Workforce Trip Table Reactive
  ############################################################################### 
  
  generateTripTable2019 <- reactive({
    
    ## This reactive function will generate a trip table for 2045
    ## The result will have columns representing origin counties/states/regions and
    ## rows representing destination counties/states/regions in 2045
    
    ## First we will retrieve the revised workforce for 2045 from another tab
    ## then we will multiply the 2045 workforce by the 2019 Origin-Destinations Percentages matrix
    ## to calculate the number of trips from each origin county to each destination county
    
    ## Use the generateWorkforceMatrix reactive to generate a matrix of the 2045 workforce
    ## This matrix will be used to calculate the 2045 trip table
    workforce_matrix2019 <- generateWorkforceMatrix2019()
    
    
    
    ## Calculate the 2045 Trip Table based on 2019 Origin-Destination data from the Census OTM
    
    ## The workforce_OD datafile was loaded at the beginning of this script
    ## The workforce_OD data are from the Census OTM 2019 Employment Data
    ## Each column represents an origin county/state/region
    ## Each row represents a destination county/state/region
    
    
    # Get the name of the destination counties/states/regions from the Origin-Destination data
    # The names are in the first column. This may change if the number/order of the columns change
    # ToDo: Determine if we need this. It doesn't look like we do so far...
    #destinations <- workforce_OD[,1]
    
    
    
    ## Create vectors containing the percentage of trips to each destination county/region by origin county/region
    
    #
    ## For example,androscoggin_origins_pct is a vector containing the percentage  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_origins_pct <- as.numeric(workforce_OD[,2])
    aroostook_origins_pct <- as.numeric(workforce_OD[,3])
    cumberland_origins_pct <- as.numeric(workforce_OD[,4])
    franklin_origins_pct <- as.numeric(workforce_OD[,5])
    hancock_origins_pct <- as.numeric(workforce_OD[,6])
    kennebec_origins_pct <- as.numeric(workforce_OD[,7])
    knox_origins_pct <- as.numeric(workforce_OD[,8])
    lincoln_origins_pct <- as.numeric(workforce_OD[,9])
    oxford_origins_pct <- as.numeric(workforce_OD[,10])
    penobscot_origins_pct <- as.numeric(workforce_OD[,11])
    piscataquis_origins_pct <- as.numeric(workforce_OD[,12])
    sagadahoc_origins_pct <- as.numeric(workforce_OD[,13])
    somerset_origins_pct <- as.numeric(workforce_OD[,14])
    waldo_origins_pct <- as.numeric(workforce_OD[,15])
    washington_origins_pct <- as.numeric(workforce_OD[,16])
    york_origins_pct <- as.numeric(workforce_OD[,17])
    nh_origins_pct <- as.numeric(workforce_OD[,18])
    ma_origins_pct <- as.numeric(workforce_OD[,19])
    CtRiVt_origins_pct <- as.numeric(workforce_OD[,20])
    RestUS_origins_pct <- as.numeric(workforce_OD[,21])
    
    
    
    ## Calculate the destinations to each row county/region for trips originating in each column county/region
    
    #
    ## For example, androscoggin_destinations is a vector containing the number  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_destinations2019 <- androscoggin_origins_pct * workforce_matrix2019[,1]
    aroostook_destinations2019 <- aroostook_origins_pct * workforce_matrix2019[,2]
    cumberland_destinations2019 <- cumberland_origins_pct * workforce_matrix2019[,3]
    franklin_destinations2019 <- franklin_origins_pct * workforce_matrix2019[,4]
    hancock_destinations2019 <- hancock_origins_pct * workforce_matrix2019[,5]
    kennebec_destinations2019 <- kennebec_origins_pct * workforce_matrix2019[,6]
    knox_destinations2019 <- knox_origins_pct * workforce_matrix2019[,7]
    lincoln_destinations2019 <- lincoln_origins_pct * workforce_matrix2019[,8]
    oxford_destinations2019 <- oxford_origins_pct * workforce_matrix2019[,9]
    penobscot_destinations2019 <- penobscot_origins_pct * workforce_matrix2019[,10]
    piscataquis_destinations2019 <- piscataquis_origins_pct * workforce_matrix2019[,11]
    sagadahoc_destinations2019 <- sagadahoc_origins_pct * workforce_matrix2019[,12]
    somerset_destinations2019 <- somerset_origins_pct * workforce_matrix2019[,13]
    waldo_destinations2019 <- waldo_origins_pct * workforce_matrix2019[,14]
    washington_destinations2019 <- washington_origins_pct * workforce_matrix2019[,15]
    york_destinations2019 <- york_origins_pct * workforce_matrix2019[,16]
    nh_destinations2019 <- nh_origins_pct * workforce_matrix2019[,17]
    ma_destinations2019 <- ma_origins_pct * workforce_matrix2019[,18]
    CtRiVt_destinations2019 <- CtRiVt_origins_pct * workforce_matrix2019[,19]
    RestUS_destinations2019 <- RestUS_origins_pct * workforce_matrix2019[,20]
    
    
    ## Create a trip table by combining the above vectors as columns in the trip table
    trip_table2019 <- cbind(androscoggin_destinations2019, aroostook_destinations2019, cumberland_destinations2019, franklin_destinations2019, hancock_destinations2019, 
                        kennebec_destinations2019, knox_destinations2019, lincoln_destinations2019, oxford_destinations2019, penobscot_destinations2019, 
                        piscataquis_destinations2019, sagadahoc_destinations2019, somerset_destinations2019, waldo_destinations2019, washington_destinations2019, 
                        york_destinations2019, nh_destinations2019, ma_destinations2019, CtRiVt_destinations2019, RestUS_destinations2019)
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(trip_table2019) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins', 
                              'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins', 
                              'CT-RI-VT Origins', 'Outside New England Origins' )
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(trip_table2019) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations', 
                              'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations', 
                              'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations', 
                              'Outside New England Destinations')
    
    
    
    ## Calculate the total trips to each row county/region
    
    ## For example, Andro_Totals is the total number of trips from 
    ## each origin county/region to Androscoggin County 
    
    Andro_Totals2019 <- sum(trip_table2019[1,])
    Aroostook_Totals2019 <- sum(trip_table2019[2,])
    Cumberland_Totals2019 <- sum(trip_table2019[3,])
    Franklin_Totals2019 <- sum(trip_table2019[4,])
    Hancock_Totals2019 <- sum(trip_table2019[5,])
    Kennebec_Totals2019 <- sum(trip_table2019[6,])
    Knox_Totals2019 <- sum(trip_table2019[7,])
    Lincoln_Totals2019 <- sum(trip_table2019[8,])
    Oxford_Totals2019 <- sum(trip_table2019[9,])
    Penobscot_Totals2019 <- sum(trip_table2019[10,])
    Piscataquis_Totals2019 <- sum(trip_table2019[11,])
    Sagadahoc_Totals2019 <- sum(trip_table2019[12,])
    Somerset_Totals2019 <- sum(trip_table2019[13,])
    Waldo_Totals2019 <- sum(trip_table2019[14,])
    Washington_Totals2019 <- sum(trip_table2019[15,])
    York_Totals2019 <- sum(trip_table2019[16,])
    NH_Totals2019 <- sum(trip_table2019[17,])
    MA_Totals2019 <- sum(trip_table2019[18,])
    CtRiVt_Totals2019 <- sum(trip_table2019[19,])
    RestUS_Totals2019 <- sum(trip_table2019[20,])
    
    # Combine the above vectors into a new column representing
    # total trips to each row destination
    destination_totals2019 <- rbind(Andro_Totals2019,Aroostook_Totals2019,Cumberland_Totals2019,Franklin_Totals2019,Hancock_Totals2019,Kennebec_Totals2019,
                                Knox_Totals2019,Lincoln_Totals2019,Oxford_Totals2019,Penobscot_Totals2019,Piscataquis_Totals2019,Sagadahoc_Totals2019,
                                Somerset_Totals2019, Waldo_Totals2019, Washington_Totals2019,York_Totals2019,NH_Totals2019,MA_Totals2019,CtRiVt_Totals2019,RestUS_Totals2019)
    
    # Add the destination totals to the trip table
    trip_table2019 <- cbind(trip_table2019, destination_totals2019)
    
    # Update column names in trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(trip_table2019) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                              'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                              'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                              'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations')
    
    
    # Return the trip table
    trip_table2019
    
    
    
  }) # End generateTripTable2019 Reactive
  
  ###############################################################################
  # End 2019 Generate Workforce Trip Table Reactive
  ###############################################################################   
  
  
  
  ###############################################################################
  # 2019 Generate Employment Trip Table Reactive
  ############################################################################### 
  
  generateEmploymentTripTable2019 <- reactive({
    
    ## This reactive function will generate a trip table for 2045
    ## The result will have columns representing origin counties/states/regions and
    ## rows representing destination counties/states/regions in 2045
    
    ## First we will retrieve the revised workforce for 2045 from another tab
    ## then we will multiply the 2045 workforce by the 2019 Origin-Destinations Percentages matrix
    ## to calculate the number of trips from each origin county to each destination county
    
    ## Use the generateWorkforceMatrix reactive to generate a matrix of the 2045 workforce
    ## This matrix will be used to calculate the 2045 trip table
    employment_matrix2019 <- generateEmploymentMatrix2019()
    
    
    
    ## Calculate the 2045 Trip Table based on 2019 Origin-Destination data from the Census OTM
    
    ## The workforce_OD datafile was loaded at the beginning of this script
    ## The workforce_OD data are from the Census OTM 2019 Employment Data
    ## Each column represents an origin county/state/region
    ## Each row represents a destination county/state/region
    
    
    
    ## Create vectors containing the percentage of trips to each destination county/region by origin county/region
    
    #
    ## For example,androscoggin_origins_pct is a vector containing the percentage  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_destinations_pct <- as.numeric(employment_DO[1,2:21])
    aroostook_destinations_pct <- as.numeric(employment_DO[2,2:21])
    cumberland_destinations_pct <- as.numeric(employment_DO[3,2:21])
    franklin_destinations_pct <- as.numeric(employment_DO[4,2:21])
    hancock_destinations_pct <- as.numeric(employment_DO[5,2:21])
    kennebec_destinations_pct <- as.numeric(employment_DO[6,2:21])
    knox_destinations_pct <- as.numeric(employment_DO[7,2:21])
    lincoln_destinations_pct <- as.numeric(employment_DO[8,2:21])
    oxford_destinations_pct <- as.numeric(employment_DO[9,2:21])
    penobscot_destinations_pct <- as.numeric(employment_DO[10,2:21])
    piscataquis_destinations_pct <- as.numeric(employment_DO[11,2:21])
    sagadahoc_destinations_pct <- as.numeric(employment_DO[12,2:21])
    somerset_destinations_pct <- as.numeric(employment_DO[13,2:21])
    waldo_destinations_pct <- as.numeric(employment_DO[14,2:21])
    washington_destinations_pct <- as.numeric(employment_DO[15,2:21])
    york_destinations_pct <- as.numeric(employment_DO[16,2:21])
    nh_destinations_pct <- as.numeric(employment_DO[17,2:21])
    ma_destinations_pct <- as.numeric(employment_DO[18,2:21])
    CtRiVt_destinations_pct <- as.numeric(employment_DO[19,2:21])
    RestUS_destinations_pct <- as.numeric(employment_DO[20,2:21])
    
    
    
    ## Calculate the destinations to each row county/region for trips originating in each column county/region
    
    #
    ## For example, androscoggin_destinations is a vector containing the number  
    ## of trips from Androscoggin County to each destination county/region
    #
    ## The columns are selected using relative references
    ## these references could change if the number/order of columns changes
    
    androscoggin_destinations2019 <- androscoggin_destinations_pct * employment_matrix2019[1,]
    aroostook_destinations2019 <- aroostook_destinations_pct * employment_matrix2019[2,]
    cumberland_destinations2019 <- cumberland_destinations_pct * employment_matrix2019[3,]
    franklin_destinations2019 <- franklin_destinations_pct * employment_matrix2019[4,]
    hancock_destinations2019 <- hancock_destinations_pct * employment_matrix2019[5,]
    kennebec_destinations2019 <- kennebec_destinations_pct * employment_matrix2019[6,]
    knox_destinations2019 <- knox_destinations_pct * employment_matrix2019[7,]
    lincoln_destinations2019 <- lincoln_destinations_pct * employment_matrix2019[8,]
    oxford_destinations2019 <- oxford_destinations_pct * employment_matrix2019[9,]
    penobscot_destinations2019 <- penobscot_destinations_pct * employment_matrix2019[10,]
    piscataquis_destinations2019 <- piscataquis_destinations_pct * employment_matrix2019[11,]
    sagadahoc_destinations2019 <- sagadahoc_destinations_pct * employment_matrix2019[12,]
    somerset_destinations2019 <- somerset_destinations_pct * employment_matrix2019[13,]
    waldo_destinations2019 <- waldo_destinations_pct * employment_matrix2019[14,]
    washington_destinations2019 <- washington_destinations_pct * employment_matrix2019[15,]
    york_destinations2019 <- york_destinations_pct * employment_matrix2019[16,]
    nh_destinations2019 <- nh_destinations_pct * employment_matrix2019[17,]
    ma_destinations2019 <- ma_destinations_pct * employment_matrix2019[18,]
    CtRiVt_destinations2019 <- CtRiVt_destinations_pct * employment_matrix2019[19,]
    RestUS_destinations2019 <- RestUS_destinations_pct * employment_matrix2019[20,]
    
    
    ## Create a trip table by combining the above vectors as columns in the trip table
    employment_trip_table2019 <- rbind(androscoggin_destinations2019, aroostook_destinations2019, cumberland_destinations2019, franklin_destinations2019, hancock_destinations2019, 
                            kennebec_destinations2019, knox_destinations2019, lincoln_destinations2019, oxford_destinations2019, penobscot_destinations2019, 
                            piscataquis_destinations2019, sagadahoc_destinations2019, somerset_destinations2019, waldo_destinations2019, washington_destinations2019, 
                            york_destinations2019, nh_destinations2019, ma_destinations2019, CtRiVt_destinations2019, RestUS_destinations2019)
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_trip_table2019) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                                  'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                                  'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                                  'CT-RI-VT Origins', 'Outside New England Origins' )



    
    ## Calculate the total workers in each column county/region
    
    ## For example, Andro_Workers is the total number of workers from 
    ## Androscoggin County to each destination county/state
    
    Andro_Workers2019 <- sum(employment_trip_table2019[,1])
    Aroostook_Workers2019 <- sum(employment_trip_table2019[,2])
    Cumberland_Workers2019 <- sum(employment_trip_table2019[,3])
    Franklin_Workers2019 <- sum(employment_trip_table2019[,4])
    Hancock_Workers2019 <- sum(employment_trip_table2019[,5])
    Kennebec_Workers2019 <- sum(employment_trip_table2019[,6])
    Knox_Workers2019 <- sum(employment_trip_table2019[,7])
    Lincoln_Workers2019 <- sum(employment_trip_table2019[,8])
    Oxford_Workers2019 <- sum(employment_trip_table2019[,9])
    Penobscot_Workers2019 <- sum(employment_trip_table2019[,10])
    Piscataquis_Workers2019 <- sum(employment_trip_table2019[,11])
    Sagadahoc_Workers2019 <- sum(employment_trip_table2019[,12])
    Somerset_Workers2019 <- sum(employment_trip_table2019[,13])
    Waldo_Workers2019 <- sum(employment_trip_table2019[,14])
    Washington_Workers2019 <- sum(employment_trip_table2019[,15])
    York_Workers2019 <- sum(employment_trip_table2019[,16])
    NH_Workers2019 <- sum(employment_trip_table2019[,17])
    MA_Workers2019 <- sum(employment_trip_table2019[,18])
    CtRiVt_Workers2019 <- sum(employment_trip_table2019[,19])
    RestUS_Workers2019 <- sum(employment_trip_table2019[,20])
    
    # Combine the above vectors into a new row representing
    # total workers commuting from to each column origin
    worker_totals2019 <- cbind(Andro_Workers2019,Aroostook_Workers2019,Cumberland_Workers2019,Franklin_Workers2019,Hancock_Workers2019,Kennebec_Workers2019,
                                    Knox_Workers2019,Lincoln_Workers2019,Oxford_Workers2019,Penobscot_Workers2019,Piscataquis_Workers2019,Sagadahoc_Workers2019,
                                    Somerset_Workers2019, Waldo_Workers2019, Washington_Workers2019,York_Workers2019,NH_Workers2019,MA_Workers2019,CtRiVt_Workers2019,RestUS_Workers2019)
    
    
    # Add the destination totals to the trip table
    employment_trip_table2019 <- rbind(employment_trip_table2019, worker_totals2019)
    
    
    
    ## Calculate the total trips to each row county/region
    
    ## For example, Andro_Totals is the total number of trips from 
    ## each origin county/region to Androscoggin County 
    
    Andro_Totals2019 <- sum(employment_trip_table2019[1,])
    Aroostook_Totals2019 <- sum(employment_trip_table2019[2,])
    Cumberland_Totals2019 <- sum(employment_trip_table2019[3,])
    Franklin_Totals2019 <- sum(employment_trip_table2019[4,])
    Hancock_Totals2019 <- sum(employment_trip_table2019[5,])
    Kennebec_Totals2019 <- sum(employment_trip_table2019[6,])
    Knox_Totals2019 <- sum(employment_trip_table2019[7,])
    Lincoln_Totals2019 <- sum(employment_trip_table2019[8,])
    Oxford_Totals2019 <- sum(employment_trip_table2019[9,])
    Penobscot_Totals2019 <- sum(employment_trip_table2019[10,])
    Piscataquis_Totals2019 <- sum(employment_trip_table2019[11,])
    Sagadahoc_Totals2019 <- sum(employment_trip_table2019[12,])
    Somerset_Totals2019 <- sum(employment_trip_table2019[13,])
    Waldo_Totals2019 <- sum(employment_trip_table2019[14,])
    Washington_Totals2019 <- sum(employment_trip_table2019[15,])
    York_Totals2019 <- sum(employment_trip_table2019[16,])
    NH_Totals2019 <- sum(employment_trip_table2019[17,])
    MA_Totals2019 <- sum(employment_trip_table2019[18,])
    CtRiVt_Totals2019 <- sum(employment_trip_table2019[19,])
    RestUS_Totals2019 <- sum(employment_trip_table2019[20,])
    Worker_Totals2019 <- sum(employment_trip_table2019[21,])
    
    # Combine the above vectors into a new column representing
    # total trips to each row destination
    destination_totals2019 <- rbind(Andro_Totals2019,Aroostook_Totals2019,Cumberland_Totals2019,Franklin_Totals2019,Hancock_Totals2019,Kennebec_Totals2019,
                                    Knox_Totals2019,Lincoln_Totals2019,Oxford_Totals2019,Penobscot_Totals2019,Piscataquis_Totals2019,Sagadahoc_Totals2019,
                                    Somerset_Totals2019, Waldo_Totals2019, Washington_Totals2019,York_Totals2019,NH_Totals2019,MA_Totals2019,CtRiVt_Totals2019,RestUS_Totals2019,Worker_Totals2019)
    
    # Add the destination totals to the trip table
    employment_trip_table2019 <- cbind(employment_trip_table2019, destination_totals2019)
    
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(employment_trip_table2019) <- c('Androscoggin County Employment', 'Aroostook County Employment', 'Cumberland County Employment', 'Franklin County Employment', 'Hancock County Employment', 'Kennebec County Employment',
                                             'Knox County Employment', 'Lincoln County Employment', 'Oxford County Employment', 'Penobscot County Employment', 'Piscataquis County Employment', 'Sagadahoc County Employment',
                                             'Somerset County Employment', 'Waldo County Employment', 'Washington County Employment', 'York County Employment', 'New Hampshire Employment', 'Masssachusetts Employment', 'CT-RI-VT Employment',
                                             'Outside New England Employment','Total Workforce')
    
    # Update column names in trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_trip_table2019) <- c('Androscoggin County Workers', 'Aroostook County Workers', 'Cumberland County Workers', 'Franklin County Workers',
                                  'Hancock County Workers', 'Kennebec County Workers', 'Knox County Workers', 'Lincoln County Workers',
                                  'Oxford County Workers', 'Penobscot County Workers', 'Piscataquis County Workers', 'Sagadahoc County Workers',
                                  'Somerset County Workers', 'Waldo County Workers', 'Washington County Workers', 'York County Workers',
                                  'New Hampshire Workers', 'Massachusetts Workers', 'CT-RI-VT Workers', 'Outside New England Workers', 'Total Employment')

    
    # Return the trip table
    employment_trip_table2019
    
    
    
  }) # End generateEmploymentTripTable2019 Reactive
  
  ###############################################################################
  # End 2019 Generate Employment Trip Table Reactive
  ###############################################################################   
  
  
  
###############################################################################
# End Reactive Calculations
###############################################################################

  
  
  
###############################################################################
# Render UI Output
###############################################################################  
  
  
  ###############################################################################
  # Render Employment Forecast
  ############################################################################### 
  
# Here we render a data table showing the baseline and adjusted employment forecasts, adjusted based on user-input
  
  output$employmentForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 1: Employment Forecast for 2045.',{
    
    # The employment_table is equal to the adjusted Employment Forecast from the Employment Forecast tab
    employment_table <- adjustEmploymentForecast()
    
    # This is from the version that includes the adjusted jobs minus those working two jobs
    #colnames(employment_forecast3) <- c('County', '2019 Census Wage & Salary Employment', '2019 PCT Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', '2045 PCT Wage & Salary Employment', '2045 PCT Two Jobs', 'WP 2045 Wage and Salary Jobs', 'WP 2045 Wage and Salary Jobs Minus 2 Jobs')
    
    # Assign these names to the columns in the employment table
    colnames(employment_table) <- c('County', '2019 Census Wage & Salary Employment', '2019 PCT Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', '2045 PCT Wage & Salary Employment', 'WP 2045 Wage and Salary Jobs')
    
    # This version was used when 2019 Jobs Adjusted is included
    # colnames(employment_forecast3) <- c('County', '2019 Census Wage & Salary Employment', '2019 PCT Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', 'WP 2019 Jobs Adjusted', 'WP 2045 Jobs Adjusted')
    
    # Display the employment table in the data table
    employment_table

  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Employment Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Employment Forecast 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('2019 Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', 'WP 2045 Wage and Salary Jobs'), 0)
  
  %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2045 PCT Wage & Salary Employment'),1)
  
  # %>% formatRound(c('2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment',  'WP 2045 Jobs', 'WP 2019 Jobs Adjusted', 'WP 2045 Jobs Adjusted'), 0)
  
  # %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment'),1)
  
  
  ) # End Render Employment Forecast
  
  ##############################################################################
  # End Render Employment Forecast
  ##############################################################################   

  
  
  ##############################################################################
  # Render Workforce Forecast
  ##############################################################################
  
  # Here we render a data table showing the baseline and adjusted workforce forecasts, adjusted based on user-input
  
  output$workforceForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 2: Workforce Forecast for 2045.',{
    
    # The workforce_forecast data frame contains the result of the adjusted workforce population reactive
    workforce_forecast <- adjustWorkforcePopulation()
    
    
    # Assign these column names to the workforce forecast data frame
    colnames(workforce_forecast) <- c('County', 'WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045', 'Revised % Working Age Population 2045', 'Revised Workforce Participation Rate 2045')
    
    # Display the workforce_forecast in the data table
    workforce_forecast
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Forecast 2045 Revision 1'))))
  ) 
  
   %>% formatRound(c('WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045'), 0)
  
   %>% formatPercentage(c('Revised % Working Age Population 2045', 'Revised Workforce Participation Rate 2045'),1)
  
  ) # End Render Workforce Forecast
  
  ##############################################################################
  # End Render Workforce Forecast
  ##############################################################################
  

  
  
  ##############################################################################
  # Render County Outflows
  ##############################################################################
  
  # Here we render a data table showing the baseline and adjusted county flows, adjusted based on user-input
  # New Version
  
  output$countyFlows <- DT::renderDataTable(DT::datatable(caption = 'Table 3: County Outflows and Inflows for 2045.',{
    
    # The county_flows data frame contains the result of the adjusted county outflows reactive
    county_flows <- adjustCountyOutflows()
    
    
    # Assign these column names to the county_flows data frame
    names(county_flows) <- c('County', 'County Employment 2045', 'County Workforce 2045', 'Pct Workforce Outflows 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045')
    
    
    # Display the county_flows data in the data table
    county_flows

    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('County Employment 2045', 'County Workforce 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045'), 0) 
  
  %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render County Outflows
  
  ##############################################################################
  # End Render County Outflows
  ##############################################################################
  
  
  
  
  ##############################################################################
  # Render Workforce Trip Table
  ############################################################################## 
  
  output$tripMatrix <- DT::renderDataTable(DT::datatable(caption = 'Table 4: Trip Matrix for 2045.',{
    
    # trip_table contains the result of the generate Trip Table reactive
    trip_table <- generateTripTable()
    
    
    # Display the trip table in the data table
    trip_table
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations'), 0) 
  
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render Trip Table
  
  ##############################################################################
  # End Render Workforce Trip Table
  ##############################################################################
  
  
  ##############################################################################
  # Render Employment Trip Table
  ############################################################################## 
  
  output$employmentTripTable <- DT::renderDataTable(DT::datatable(caption = 'Table 4: Employment Trip Table for 2045.',{
    
    # trip_table contains the result of the generate Trip Table reactive
    employmentTripTable2045 <- generateEmploymentTripTable()
    
    
    # Display the trip table in the data table
    employmentTripTable2045
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('Androscoggin County Workers', 'Aroostook County Workers', 'Cumberland County Workers', 'Franklin County Workers', 
                    'Hancock County Workers', 'Kennebec County Workers', 'Knox County Workers', 'Lincoln County Workers', 
                    'Oxford County Workers', 'Penobscot County Workers', 'Piscataquis County Workers', 'Sagadahoc County Workers', 
                    'Somerset County Workers', 'Waldo County Workers', 'Washington County Workers', 'York County Workers', 
                    'New Hampshire Workers', 'Massachusetts Workers', 'CT-RI-VT Workers', 'Outside New England Workers', 'Total Employment'), 0) 
  
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render Trip Table
  
  ##############################################################################
  # End Render Employment Trip Table
  ##############################################################################
  
  
  
  ##############################################################################
  # Render Workforce Matrix
  ############################################################################## 
  
  output$workforceMatrix <- DT::renderDataTable(DT::datatable(caption = 'Table 4a: Workforce Matrix for 2045.',{
    
    # workforceMatrix contains the result of the generate Workforce Matrix function
    workforceMatrix <- generateWorkforceMatrix()
    
    
    # display the workforce matrix in the data table
    workforceMatrix
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
  'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
  'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
  'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
  'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render Workforce Matrix
  
  ##############################################################################
  # End Render Workforce Matrix
  ##############################################################################
  
  ##############################################################################
  # Render Employment Matrix
  ############################################################################## 
  
  output$employmentMatrix <- DT::renderDataTable(DT::datatable(caption = 'Table 4a: Employment Matrix for 2045.',{
    
    # workforceMatrix contains the result of the generate Workforce Matrix function
    employmentMatrix2045 <- generateEmploymentMatrix()
    
    
    # display the workforce matrix in the data table
    employmentMatrix2045
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render Employment Matrix
  
  ##############################################################################
  # End Render Employment Matrix
  ##############################################################################
  
  
  ##############################################################################
  # Render 2019 Origin-Destination Percentages Matrix
  ############################################################################## 
  
  output$originDestinationPercentages <- DT::renderDataTable(DT::datatable(caption = 'Table 4b: 2019 Origin-Destination Percentages Matrix.',{
    
    # The Workforce_OD data frame contains columns 2-21 from the Workforce_OD data file loaded at the beginning of this script
    # The reason for excluding column 1 is this column contains the names of each county/region
    # We don't need to use these names because we rename the rownames below
    workforce_OD <- data.frame(workforce_OD[,2:21])
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(workforce_OD) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                              'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                              'CT-RI-VT Origins', 'Outside New England Origins' )

    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(workforce_OD) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations',
                              'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations',
                              'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations',
                              'Outside New England Destinations')

    # Return the Workforce_OD data frame with row names and column names
    workforce_OD
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= '2019 Origin-Destinations Percentages')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  # %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
  #                   'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
  #                   'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
  #                   'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
  #                   'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  %>% formatPercentage(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
  'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
  'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
  'CT-RI-VT Origins', 'Outside New England Origins' ),1)
  
  ) # End Render 2019 Origin-Destination Percentages Matrix
  
  ##############################################################################
  # End Render 2019 Origin-Destination Percentages Matrix
  ##############################################################################
  
  
  
  ##############################################################################
  # Render 2019 Origin-Destination Percentages Matrix 2
  ############################################################################## 
  
  output$originDestinationPercentages2 <- DT::renderDataTable(DT::datatable(caption = 'Table 4b: 2019 Origin-Destination Percentages Matrix.',{
    
    # The Workforce_OD data frame contains columns 2-21 from the Workforce_OD data file loaded at the beginning of this script
    # The reason for excluding column 1 is this column contains the names of each county/region
    # We don't need to use these names because we rename the rownames below
    workforce_OD <- data.frame(workforce_OD[,2:21])
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(workforce_OD) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                                'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                                'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                                'CT-RI-VT Origins', 'Outside New England Origins' )
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(workforce_OD) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations',
                                'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations',
                                'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations',
                                'Outside New England Destinations')
    
    # Return the Workforce_OD data frame with row names and column names
    workforce_OD
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  # %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
  #                   'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
  #                   'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
  #                   'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
  #                   'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  %>% formatPercentage(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                         'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                         'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                         'CT-RI-VT Origins', 'Outside New England Origins' ),1)
  
  ) # End Render 2019 Origin-Destination Percentages Matrix
  
  ##############################################################################
  # End Render 2019 Origin-Destination Percentages Matrix 2
  ##############################################################################
  
  
  
  ##############################################################################
  # Render 2019 Destination-Origin Percentages Matrix
  ############################################################################## 
  
  output$destinationOriginPercentages <- DT::renderDataTable(DT::datatable(caption = 'Table 4b: 2019 Origin-Destination Percentages Matrix.',{
    
    # The Workforce_OD data frame contains columns 2-21 from the Workforce_OD data file loaded at the beginning of this script
    # The reason for excluding column 1 is this column contains the names of each county/region
    # We don't need to use these names because we rename the rownames below
    employment_OD <- data.frame(employment_DO[,2:21])
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_OD) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                                'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                                'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                                'CT-RI-VT Origins', 'Outside New England Origins' )
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(employment_OD) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations',
                                'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations',
                                'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations',
                                'Outside New England Destinations')
    
    # Return the Workforce_OD data frame with row names and column names
    employment_OD
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  # %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
  #                   'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
  #                   'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
  #                   'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
  #                   'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  %>% formatPercentage(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                         'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                         'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                         'CT-RI-VT Origins', 'Outside New England Origins' ),1)
  
  ) # End Render 2019 Destination-Origin Percentages Matrix
  
  ##############################################################################
  # End Render 2019 Destination-Origin Percentages Matrix
  ##############################################################################
  
  
  ##############################################################################
  # Render 2019 Destination-Origin Percentages Matrix2
  ############################################################################## 
  
  output$destinationOriginPercentages2 <- DT::renderDataTable(DT::datatable(caption = 'Table 4b: 2019 Origin-Destination Percentages Matrix.',{
    
    # The Workforce_OD data frame contains columns 2-21 from the Workforce_OD data file loaded at the beginning of this script
    # The reason for excluding column 1 is this column contains the names of each county/region
    # We don't need to use these names because we rename the rownames below
    employment_OD <- data.frame(employment_DO[,2:21])
    
    # Add column names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    colnames(employment_OD) <- c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                                 'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                                 'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                                 'CT-RI-VT Origins', 'Outside New England Origins' )
    
    # Add row names to the trip table
    # These names will need to be changed if columns are added/removed from the trip table
    rownames(employment_OD) <- c('Androscoggin County Destinations', 'Aroostook County Destinations', 'Cumberland County Destinations', 'Franklin County Destinations', 'Hancock County Destinations', 'Kennebec County Destinations',
                                 'Knox County Destinations', 'Lincoln County Destinations', 'Oxford County Destinations', 'Penobscot County Destinations', 'Piscataquis County Destinations', 'Sagadahoc County Destinations',
                                 'Somerset County Destinations', 'Waldo County Destinations', 'Washington County Destinations', 'York County Destinations', 'New Hampshire Destinations', 'Masssachusetts Destinations', 'CT-RI-VT Destinations',
                                 'Outside New England Destinations')
    
    # Return the Workforce_OD data frame with row names and column names
    employment_OD
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  # %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
  #                   'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
  #                   'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
  #                   'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
  #                   'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0) 
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  %>% formatPercentage(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 'Hancock County Origins', 'Kennebec County Origins',
                         'Knox County Origins', 'Lincoln County Origins', 'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                         'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 'New Hampshire Origins', 'Massachusetts Origins',
                         'CT-RI-VT Origins', 'Outside New England Origins' ),1)
  
  ) # End Render 2019 Destination-Origin Percentages Matrix
  
  ##############################################################################
  # End Render 2019 Destination-Origin Percentages Matrix 2
  ##############################################################################
  
  
  ##############################################################################
  # Render Employment Balance Data Table
  ##############################################################################
  
  output$balance <- DT::renderDataTable(DT::datatable(caption = 'Table 5: Employment:Workforce Balance for 2045.',{
    
    # The countyFlows data frame contains the result of the adjust county outflows reactive
    countyFlows <- adjustCountyOutflows()
    
    # The outflow trips vector
    trip_table <- generateTripTable()
    
    # The two_jobs_percentage vector contains the values from the working two jobs 2045 sliders
    two_jobs_percentage <- WorkingTwoJobsSliderValue2045()
    
    

    # countyEmployment contains the revised 2045 employment, stored in the second column of the countyFlows data frame
    # This is a relative reference that may change if the number/order of columns in the countyFlows data frame change
    countyEmployment <- countyFlows[,2]
    
    # countyLocals contains the revised 2045 workforce locals, stored in the second column of the countyFlows data frame
    # This is a relative reference that may change if the number/order of columns in the countyFlows data frame change
    countyLocals45 <- countyFlows[,6]
    
    # ttEmploymentTotals represents that available workforce in each county
    # This is the 21st column in the trip table
    # This is a relative reference that may change if the number/order of columns in the trip table change
    ttEmploymentTotals <- trip_table[,21]
    
    
    # The two jobs reduction represents a reduction in the available workforce,
    # based on the percent of the workforce working two jobs
    # The logic is the available workforce will be reduced based on the percentage of the workforce
    # that works more than one job
    # This should help balance workforce with employment, 
    # in the cases where the total employment exceeds the total available workforce
    # I've commented this line out in favor of applying the two jobs percentage to total employment
    #two_jobs_reduction <- two_jobs_percentage * ttEmploymentTotals
    
    # Here I've switched to applying the two jobs reduction to the total employment, instead of available workforce
    two_jobs_reduction <- two_jobs_percentage * as.numeric(countyEmployment)
    
    
    # The AvailableWorkforce_Adjusted is the total available workforce minus the number of workers that work two jobs
    # I've commented this line out in favor of applying the two jobs percentage to total employment
    #AvailableWorkforce_Adjusted <- ttEmploymentTotals - two_jobs_reduction
    
    # Here I've switched to applying the two jobs reduction to the total employment, instead of available workforce
    TotalEmployment_Adjusted <- as.numeric(countyEmployment) - two_jobs_reduction
    
    
    
    balance_length <- length(countyEmployment)

    i <- 1

    countyInflows45 <- vector(mode='numeric', length=balance_length)

    AdditionalWorkers45 <- vector(mode= 'numeric', length=balance_length)

    UnemployedWorkers45 <- vector(mode= 'numeric', length=balance_length)

    employedWorkforce45 <- vector(mode= 'numeric', length=balance_length)

    while(i <= balance_length) {

      if(as.numeric(countyLocals45[i]) > as.numeric(TotalEmployment_Adjusted[i])) {

        countyInflows45[i] <- 0

        employedWorkforce45[i] <- as.numeric(TotalEmployment_Adjusted[i])


      }


      if(as.numeric(TotalEmployment_Adjusted[i]) > as.numeric(countyLocals45[i])) {

        countyInflows45[i] <- as.numeric(TotalEmployment_Adjusted[i]) - as.numeric(countyLocals45[i])

        employedWorkforce45[i] <- as.numeric(countyInflows45[i]) + as.numeric(countyLocals45[i])


      }

      i <- i + 1

    }

    
    j <- 1
    
    while(j <= balance_length) {
      
      if(as.numeric(ttEmploymentTotals[j]) > as.numeric(TotalEmployment_Adjusted[j])) {
        
        
        AdditionalWorkers45[j] <- 0
        
        UnemployedWorkers45[j] <- as.numeric(ttEmploymentTotals[j]) - as.numeric(employedWorkforce45[j])
        
      }
      
      
      if(as.numeric(TotalEmployment_Adjusted[j]) > as.numeric(ttEmploymentTotals[j])) {
        
        
        AdditionalWorkers45[j] <- as.numeric(TotalEmployment_Adjusted[j]) - as.numeric(ttEmploymentTotals[j])
        
        UnemployedWorkers45[j] <- 0
        
      }
      
      j <- j + 1
      
    }
    
    
    
    
    
    # This calculates county inflows as the difference between total county employment and county local workers
    # This seems like the logical value to use, since county inflows will exactly equal the demand for labor
    #countyInflows <- as.numeric(countyEmployment) - as.numeric(countyLocals)   
    
    # This calculates county inflows as the difference between total available workforce and county local workers
    #countyInflows <- as.numeric(ttEmploymentTotals) - as.numeric(countyLocals)
    
    
    # Employed workforce is the sum of County In Flows and County Locals
    # This total should, by definition, be exactly equal to total employment
    # The remaining balance of the available workforce will be counted as unemployed
    #employedWorkforce <- countyInflows + as.numeric(countyLocals)
    
    
    # This compares employment total to available workforce, adjusted for people working more than one job
    # I've commented this out in favor of comparing total adjusted employment to available workforce
    #balance <- as.numeric(countyEmployment) - as.numeric(AvailableWorkforce_Adjusted)
    
    # This calculation compares total employment, adjusted for population working two jobs, and available workforce
    #balance <- as.numeric(ttEmploymentTotals) - as.numeric(TotalEmployment_Adjusted) 
    
    # This compares employment total to total available workforce
    #balance <- as.numeric(countyEmployment) - as.numeric(ttEmploymentTotals)
    
    
    # The unemployment rate is the balance of the available workforce that is unemployed, divided by the total available workforce
    unemploymentRate45 <- UnemployedWorkers45 / ttEmploymentTotals
    
    # balanceTable includes the following columns:
    # Revised 2045 employment, Available Workforce 2045, Revised Available Workforce 2045,
    # County Locals 2045, County Inflows 2045, Balance (Employment - Revised Available Workforce)
    balanceTable <- cbind(countyEmployment, TotalEmployment_Adjusted,  employedWorkforce45, ttEmploymentTotals,  
                          UnemployedWorkers45, unemploymentRate45, countyLocals45, countyInflows45, AdditionalWorkers45)
    
    # Assign these column names to the balance table
    colnames(balanceTable) <- c('2045 Employment Forecast', '2045 Employment Forecast (Minus people working two jobs)',
                                '2045 Employed Workforce', '2045 Available Workforce', 'Unemployed Workers', 
                                '2045 Unemployment Rate', '2045 Local Workers', '2045 Inflows', 'Additional Workers Needed')
    
    # Display the balanceTable in the data table
    balanceTable
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Balance 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('2045 Employment Forecast', '2045 Employment Forecast (Minus people working two jobs)',
                    '2045 Employed Workforce', '2045 Available Workforce', 'Unemployed Workers', 
                     '2045 Local Workers', '2045 Inflows', 'Additional Workers Needed'), 0) 
  
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
   %>% formatPercentage('2045 Unemployment Rate',1)
  
  ) # End Render Employment Balance Data Table
  
  ##############################################################################
  # End Render Employment Balance Data Table
  ##############################################################################
  
  

  
  ##############################################################################
  # Render 2019 Workforce Forecast
  ##############################################################################
  
  # Here we render a data table showing the baseline and adjusted workforce forecasts, adjusted based on user-input
  
  output$workforce2019 <- DT::renderDataTable(DT::datatable(caption = 'Workforce Population 2019',{
    
    # The workforce_forecast data frame contains the result of the adjusted workforce population reactive
    workforce_forecast2 <- adjust2019WorkforcePopulation()
    
    
    # Assign these column names to the workforce forecast data frame
    # Need to fix these column names
    colnames(workforce_forecast2) <- c('County', 'WP 2019 Population', 'Working Age Population 2019', 'Workforce Population 2019')

    
    # Display the workforce_forecast in the data table
    workforce_forecast2
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Forecast 2019')),list(list(extend = 'excel', filename= 'Workforce Forecast 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('WP 2019 Population', 'Working Age Population 2019', 'Workforce Population 2019'), 0)
  
  #%>% formatPercentage(c('Revised % Working Age Population 2045', 'Revised Workforce Participation Rate 2045'),1)
  
  ) # End Render Workforce Forecast
  
  ##############################################################################
  # End Render 2019 Workforce Forecast
  ##############################################################################
  
  
  

  
  ##############################################################################
  # Render 2019 County Outflows
  ##############################################################################
  
  # Here we render a data table showing the baseline and adjusted county flows, adjusted based on user-input
  # New Version
  
  output$countyFlows2019 <- DT::renderDataTable(DT::datatable(caption = 'County Outflows and Inflows for 2019',{

    # The county_flows data frame contains the result of the adjusted county outflows reactive
    county_flows <- CountyOutflows2019()


    # Assign these column names to the county_flows data frame
    # ToDo: update these names
    names(county_flows) <- c('County', 'Total Employment 2019', 'Wage & Salary Employment 2019', 'County Workforce 2019', 'Pct Workforce Outflows 2019', 'County Workforce Outflows 2019', 'County Workforce Locals 2019', 'Employment Balance 2019')


    # Display the county_flows data in the data table
    county_flows


  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )

  %>% formatRound(c('Total Employment 2019', 'Wage & Salary Employment 2019', 'County Workforce 2019', 'County Workforce Outflows 2019', 'County Workforce Locals 2019', 'Employment Balance 2019'), 0)

  %>% formatPercentage('Pct Workforce Outflows 2019',1)

  ) # End Render County Outflows

  ##############################################################################
  # End Render 2019 County Outflows
  ##############################################################################
  
  
  
  
  
  ##############################################################################
  # Render 2019 Workforce Trip Table
  ############################################################################## 
  
  output$tripMatrix2019 <- DT::renderDataTable(DT::datatable(caption = 'Trip Matrix for 2019',{

    # trip_table contains the result of the generate Trip Table reactive
    trip_table2019 <- generateTripTable2019()


    # Display the trip table in the data table
    trip_table2019




  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Trip Table 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )

  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins',
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins',
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins',
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations'), 0)


  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0)

  # %>% formatPercentage('Pct Workforce Outflows 2045',1)

  ) # End Render Trip Table

  ##############################################################################
  # End Render 2019 Workforce Trip Table
  ##############################################################################
  
  
  
  
  
  ##############################################################################
  # Render 2019 Employment Trip Table
  ############################################################################## 
  
  output$employmentTripTable2019 <- DT::renderDataTable(DT::datatable(caption = 'Trip Matrix for 2019',{
    
    # trip_table contains the result of the generate Trip Table reactive
    employment_trip_table2019 <- generateEmploymentTripTable2019()
    
    
    # Display the trip table in the data table
    employment_trip_table2019
    
    
    
    
  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Trip Table 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )
  
  %>% formatRound(c('Androscoggin County Workers', 'Aroostook County Workers', 'Cumberland County Workers', 'Franklin County Workers',
                    'Hancock County Workers', 'Kennebec County Workers', 'Knox County Workers', 'Lincoln County Workers',
                    'Oxford County Workers', 'Penobscot County Workers', 'Piscataquis County Workers', 'Sagadahoc County Workers',
                    'Somerset County Workers', 'Waldo County Workers', 'Washington County Workers', 'York County Workers',
                    'New Hampshire Workers', 'Massachusetts Workers', 'CT-RI-VT Workers', 'Outside New England Workers', 'Total Employment'), 0)

  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0)
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render Employment Trip Table
  
  ##############################################################################
  # End Render 2019 Employment Trip Table
  ##############################################################################
  
  
  
  
  
  ##############################################################################
  # Render 2019 Workforce Matrix
  ############################################################################## 
  
  output$workforceMatrix2019 <- DT::renderDataTable(DT::datatable(caption = 'Workforce Matrix for 2019',{

    # workforceMatrix contains the result of the generate Workforce Matrix function
    workforceMatrix <- generateWorkforceMatrix2019()


    # display the workforce matrix in the data table
    workforceMatrix




  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )

  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins',
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins',
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins',
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0)

  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0)

  # %>% formatPercentage('Pct Workforce Outflows 2045',1)

  ) # End Render Workforce Matrix

  ##############################################################################
  # End Render 2019 Workforce Matrix
  ##############################################################################
  
  
  
  ##############################################################################
  # Render 2019 Employment Matrix
  ############################################################################## 
  
  output$employmentMatrix2019 <- DT::renderDataTable(DT::datatable(caption = 'Employment Matrix for 2019',{
    
    # workforceMatrix contains the result of the generate Workforce Matrix function
    employmentMatrix <- generateEmploymentMatrix2019()
    
    
    # display the workforce matrix in the data table
    employmentMatrix
    
    
    
    
  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )
  
  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins',
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins',
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins',
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins',
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 0)
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0)
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  ) # End Render 2019 Employment Matrix
  
  ##############################################################################
  # End Render 2019 Employment Matrix
  ##############################################################################
  
  
  
  ##############################################################################
  # Render 2019 Employment Balance Data Table
  ##############################################################################
  
  output$balance2019 <- DT::renderDataTable(DT::datatable(caption = 'Employment:Workforce Balance for 2019',{

    # The countyFlows data frame contains the result of the adjust county outflows reactive
    countyFlows <- CountyOutflows2019()

    # The outflow trips vector
    trip_table <- generateTripTable2019()





    # countyEmployment contains the 2019 wage and salary employment, stored in the second column of the countyFlows data frame
    # This is a relative reference that may change if the number/order of columns in the countyFlows data frame change
    countyEmployment <- countyFlows[,3]

    # countyLocals contains the revised 2045 workforce locals, stored in the second column of the countyFlows data frame
    # This is a relative reference that may change if the number/order of columns in the countyFlows data frame change
    countyLocals19 <- countyFlows[,7]

    # ttEmploymentTotals represents that available workforce in each county
    # This is the 21st column in the trip table
    # This is a relative reference that may change if the number/order of columns in the trip table change
    ttEmploymentTotals <- trip_table[,21]



    # This calculates county inflows as the difference between total county employment and county local workers
    # This seems like the logical value to use, since county inflows will exactly equal the demand for labor
    
    # if(ttEmploymentTotals > countyEmployment) {
    #   
    #   countyInflows <- as.numeric(countyEmployment) - as.numeric(countyLocals)
    #   
    # }
    # 
    # if(countyEmployment > ttEmploymentTotals) {
    #   
    #   countyInflows <- as.numeric(ttEmploymentTotals) - as.numeric(countyLocals)
    #   
    # }

    
    #countyInflows <- as.numeric(countyEmployment) - as.numeric(countyLocals)
    
    #employedWorkforce19 <- countyInflows + as.numeric(countyLocals)
    
    # I need to write a while statement for these if statements so they compare the values one at a time, not as a vector
    
    # balance_length <- length(countyEmployment)
    # 
    # i <- 1
    # 
    # countyInflows19 <- vector(mode='numeric', length=balance_length)
    # 
    # AdditionalWorkers19 <- vector(mode= 'numeric', length=balance_length)
    # 
    # UnemployedWorkers19 <- vector(mode= 'numeric', length=balance_length)
    # 
    # employedWorkforce19 <- vector(mode= 'numeric', length=balance_length)
    # 
    # while(i <= balance_length) {
    #   
    #   if(ttEmploymentTotals[i] > countyEmployment[i]) {
    #     
    #     countyInflows19[i] <- as.numeric(countyEmployment[i]) - as.numeric(countyLocals19[i])
    #     
    #     employedWorkforce19[i] <- as.numeric(countyInflows19[i]) + as.numeric(countyLocals19[i])
    #     
    #     AdditionalWorkers19[i] <- as.numeric(countyEmployment[i]) - as.numeric(employedWorkforce19[i])
    #     
    #     UnemployedWorkers19[i] <- ttEmploymentTotals[i] - employedWorkforce19[i]
    # 
    #   }
    #   
    #   
    #   if(countyEmployment[i] > ttEmploymentTotals[i]) {
    #     
    #     countyInflows19[i] <- as.numeric(ttEmploymentTotals[i]) - as.numeric(countyLocals19[i])
    #     
    #     employedWorkforce19[i] <- as.numeric(countyInflows19[i]) + as.numeric(countyLocals19[i])
    #     
    #     AdditionalWorkers19[i] <- as.numeric(countyEmployment[i]) - as.numeric(ttEmploymentTotals[i])
    #     
    #     UnemployedWorkers19[i] <- 0
    # 
    #   }
    #   
    #   i <- i + 1
    #   
    # }
    # 

    countyInflows19 <- as.numeric(countyEmployment) - as.numeric(countyLocals19)
    
    employedWorkforce19 <- as.numeric(countyInflows19) + as.numeric(countyLocals19)
    
    AdditionalWorkers19 <- as.numeric(countyEmployment) - as.numeric(employedWorkforce19)
    
    UnemployedWorkers19 <- ttEmploymentTotals - employedWorkforce19
    

    # This calculates county inflows as the difference between total available workforce and county local workers
    #countyInflows <- as.numeric(ttEmploymentTotals) - as.numeric(countyLocals)


    # This compares employent total to available workforce, adjusted for people working more than one job
    #balance <- as.numeric(countyEmployment) - as.numeric(AvailableWorkforce_Adjusted)

    # This compares employment total to total available workforce
    #balance <- as.numeric(countyEmployment) - as.numeric(ttEmploymentTotals)
    
    
    # This compares total available workforce to employment total
    # This equals the number of people who are willing to work but are not employed
    
    #if(ttEmploymentTotals > countyEmployment) {
      
      #balance <- as.numeric(ttEmploymentTotals) - as.numeric(countyEmployment)
      
    #}
    
    #balance <- as.numeric(ttEmploymentTotals) - as.numeric(countyEmployment)
    
    
    
    uRate2019 <- UnemployedWorkers19/ttEmploymentTotals
    

    # balanceTable includes the following columns:
    # Revised 2045 employment, Available Workforce 2045, Revised Available Workforce 2045,
    # County Locals 2045, County Inflows 2045, Balance (Employment - Revised Available Workforce)
    balanceTable <- cbind(countyEmployment, employedWorkforce19, ttEmploymentTotals,  UnemployedWorkers19, uRate2019, countyLocals19, countyInflows19, AdditionalWorkers19)

    
    
    
    # Assign these column names to the balance table
    colnames(balanceTable) <- c('2019 Employment', '2019 Employed Workforce', '2019 Available Workforce', 'Unemployed Workers', 'Unemployment Rate',  '2019 Local Workers', '2019 Inflows', 'Additional Workers Needed')

    # Display the balanceTable in the data table
    balanceTable




  }, extensions = 'Buttons',
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Balance 2019')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  )

  %>% formatRound(c('2019 Employment', '2019 Employed Workforce', '2019 Available Workforce', 'Unemployed Workers',  '2019 Local Workers', '2019 Inflows', 'Additional Workers Needed'), 0)


  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0)

   %>% formatPercentage('Unemployment Rate', 1)

  ) # End Render Employment Balance Data Table

  ##############################################################################
  # End Render 2019 Employment Balance Data Table
  ##############################################################################
  
  
  
  
################################################################################  
################################################################################
  # More Data Section
################################################################################
################################################################################
  
################################################################################
  # This is where we load the content under the Source Data menu
################################################################################

  ##############################################################################
  # Render Population Forecast
  ##############################################################################
  
  ## Render a data table with the 2045 Population Forecast and Workforce-Aged Population
  
  output$populationForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 1: Woods and Poole Population Forecast for 2045, based on 2020 Census.',{
    
    # Assign these column names to the population forecast
    # The population forecast was loaded at the beginning of this script
    colnames(population_forecast) <- c("County", "Census 2020 Population", "WP Forecast 2045 Population", "Absolute Population Change 2020-2045", "% Population Change 2020-2045")
    
    # Display the population forecast in the data table
    population_forecast
    
    
  }, options = list(paging = FALSE))
  %>% formatRound(c('Census 2020 Population','WP Forecast 2045 Population', 'Absolute Population Change 2020-2045'), 0) 
  %>% formatPercentage('% Population Change 2020-2045',1)
 
  ) # End Render populationForecast
  
  ##############################################################################
  # End Render Population Forecast
  ##############################################################################
  
  
  ##############################################################################
  # Render Employment Forecast should go here
  ##############################################################################
  
  # Here we render a data table showing the baseline employment forecasts in a separate tab
  
  output$employmentForecast2 <- DT::renderDataTable(DT::datatable(caption = 'Table 2: 2019 Employment Data Compared to Woods and Poole Employment Forecast for 2045.',{
    
    
    # The employment_forecast data frame contains the employment forecast loaded at the beginning of this script
    employment_forecast <- data.frame(employment)
    
    # Assign these column names to the employment forecast
    colnames(employment_forecast) <- c('County', '2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment', '2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment', 'WP 2045 Jobs')
    
    # Display the employment forecast in the data table
    employment_forecast
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Employment Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Employment Forecast 2045 Revision 1'))))
  ) %>% formatRound(c('2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment',  'WP 2045 Jobs'), 0)
  
  %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment'),1)
  
  
  
  ) # End Render employmentForecast2
  
  ##############################################################################
  # End Render Employment Forecast should go here
  ##############################################################################
  
  
  ##############################################################################
  # Render Age Structure
  ############################################################################## 
  
  ## Here we will render a data table showing the age structure in 2045
  
  output$ageStructure2045 <- DT::renderDataTable(DT::datatable(caption = 'Table 3: Age Structure in 2045.',{
    
    # ageStructure was a data file loaded at the beginning of this script
    
    # Assign these column names to the ageStructure data frame
    colnames(ageStructure) <- c('County', 'Population Age 15 to 74','Population Age 75 and Over','Population Age 15 and Over')
    
    # Display the age structure table in the data table
    ageStructure 
    
    
  }, options = list(paging = FALSE))%>% formatPercentage(c('Population Age 15 to 74','Population Age 75 and Over','Population Age 15 and Over'), 1))

  ##############################################################################
  # End Render Age Structure
  ##############################################################################
  
  
  ##############################################################################
  # Render County Workforce Participation Rate 2019
  ############################################################################## 
  
  ## Here we will render a data table showing the county workforce participation rate in 2019 
  
  output$countyWorkforce2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 4: County Workforce Participation Rates in 2019.',{
    
    # labor participation was a data frame loaded at the beginning of this script
    
    # Assign these names to the labor participation data frame
    colnames(laborParticipation) <- c('County', 'Labor Force Participation Rate 2019')
    
    # Display labor participation data in the data table
    laborParticipation
    
  }, options = list(paging = FALSE))%>% formatPercentage('Labor Force Participation Rate 2019', 1))
 
  ##############################################################################
  # End Render County Workforce Participation Rate 2019
  ############################################################################## 
  
  
  ##############################################################################
  # Render County Outflows
  ############################################################################## 
  
  ## Here we will render a data table showing the county inflows and outflows in 2019 
  
  output$countyWorkflows2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 5: County Workforce Inflows and Outflows in 2019.',{
    
    # workforce outflows was a data file loaded at the beginning of this script
    
    # Assign these column names to workforceOutflows
    colnames(workforceOutflows) <- c('County','Employment Percent Inflows','Employment Percent Locals','Workforce Percent Outflows','Workforce Percent Locals')
    
    
    # Display workforceOutflows in the data table
    workforceOutflows
    
    
  }, options = list(paging = FALSE))%>% formatPercentage(c('Employment Percent Inflows','Employment Percent Locals','Workforce Percent Outflows','Workforce Percent Locals'), 1))
  
  ##############################################################################
  # End Render County Outflows
  ##############################################################################
  
  
  ##############################################################################
  # Render 2019 Trip Table
  ############################################################################## 
  
  ## Here we will render a data table showing the 2019 trip table
  
  output$tripTable2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 6: 2019 Trip Table.',{
    
    # trip_table is a data frame containing the 2019 trip table 2019 loaded at the beginning of this script
    trip_table <- data.frame(trip_table_2019)
    
    # Assign these column names to the 2019 trip table
    colnames(trip_table) <- c('Destinations','Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                              'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                              'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                              'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations')
    
    # Display the 2019 trip table in the data table
    trip_table
    
    
  }, options = list(paging = FALSE))
  
  %>% formatRound(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                    'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                    'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                    'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                    'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins', 'Total Destinations'), 0)
  
  #%>% formatPercentage(c('Employment Percent Inflows','Employment Percent Locals','Workforce Percent Outflows','Workforce Percent Locals'), 1)
  
  ) # End output$tripTable2019
  
  
  ##############################################################################
  # End Render 2019 Trip Table
  ##############################################################################
  
  
  ##############################################################################
  # Render 2019 Origin-Destination Percentages
  ##############################################################################

  ## Here we will render a data table showing the 2019 Origin-Destination Percentages
  
  output$OD_Percentages2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 7: 2019 Origin-Destination Percentages.',{
    
    # The OD_Percentage_table is a dataframe containing the 2019 origin-destination percentages data file loaded at the beginning of this script
    OD_Percentage_table <- data.frame(workforce_OD)
    
    # Add column names to OD_Percentage_table
    # These names will need to be changed if columns are added/removed from the OD_Percentage_table
    colnames(OD_Percentage_table) <- c('Destination','Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                              'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                              'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                              'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                              'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins')
    
    # Display the OD_Percentage_table in the data table
    OD_Percentage_table
    
    
  }, options = list(paging = FALSE))
  
  %>% formatPercentage(c('Androscoggin County Origins', 'Aroostook County Origins', 'Cumberland County Origins', 'Franklin County Origins', 
                         'Hancock County Origins', 'Kennebec County Origins', 'Knox County Origins', 'Lincoln County Origins', 
                         'Oxford County Origins', 'Penobscot County Origins', 'Piscataquis County Origins', 'Sagadahoc County Origins', 
                         'Somerset County Origins', 'Waldo County Origins', 'Washington County Origins', 'York County Origins', 
                         'New Hampshire Origins', 'Massachusetts Origins', 'CT-RI-VT Origins', 'Outside New England Origins'), 1)
  
  ) # End output$OD_Percentages2019
 
  ##############################################################################
  # End Render 2019 Origin-Destination Percentages
  ##############################################################################
  
  

  ##############################################################################
  # Render 2020 Population Data
  ##############################################################################
  
  ## Render a data table with the 2045 Population Forecast and Workforce-Aged Population
  
  output$populationData <- DT::renderDataTable(DT::datatable(caption = 'Table 8: Census 2020 vs Woods and Poole Population Forecast for 2019 and 2020.',{
    
    # Assign these column names to the population forecast
    # The population forecast was loaded at the beginning of this script
    colnames(population_2019) <- c("County", "Census 2020 Population", "WP Forecast 2019 Population", "WP Forecast 2020 Population")
    
    # Display the population forecast in the data table
    population_2019
    
    
  }, options = list(paging = FALSE))
  %>% formatRound(c("Census 2020 Population", "WP Forecast 2019 Population", "WP Forecast 2020 Population"), 0) 
  # %>% formatPercentage('% Population Change 2020-2045',1)
  
  ) # End Render populationForecast
  
  ##############################################################################
  # End Render 2020 Population Data
  ##############################################################################
  
  
  
###############################################################################
# End of Render UI Output
############################################################################### 
  
  
} # End of Server


###############################################################################
###############################################################################
# End Server Logic
###############################################################################
###############################################################################


###############################################################################
###############################################################################
# Define shinyApp UR and Server
###############################################################################
###############################################################################

shinyApp(ui = ui, server = server)


###############################################################################
###############################################################################
# The End
###############################################################################
###############################################################################