
# 
# library(ggplot2)
# 
# fluidPage(
#   titlePanel("Basic DataTable"),
#   
#   # Create a new row for the table.
#   DT::dataTableOutput("populationForecast")
# )


library(markdown, DT)


# Define Constants

ageStructure <- read.csv(file="Tables/2_maine_county_age_structure_2045.csv", head=TRUE,sep=",")
laborParticipation <- read.csv(file="Tables/5_maine_county_workforce_participation_rate_2019.csv", head=TRUE,sep=",")
workforceOutflows <- read.csv(file="Tables/3_maine_county_workforce_flows_2019.csv", head=TRUE,sep=",")
employment <- read.csv(file="Tables/4_maine_county_employment_forecast_2045.csv", head=TRUE,sep=",")

PctWorkingAge <- ageStructure$Population_Age_15_and_Over
PctLaborForce <- laborParticipation$Workforce_Participation_Rate_2019
PctOutflow <- workforceOutflows$Workforce_Percent_Outflows

PctWSEmp <- employment$PCT_2019_Wage_Salary_Employment

# First Block
AndroCo1Default <- PctWorkingAge[1] * 100
HancockCo1Default <- PctWorkingAge[5] * 100
OxfordCo1Default <- PctWorkingAge[9] * 100
SomerCo1Default <- PctWorkingAge[13] * 100

AndroCo2Default <- PctLaborForce[1] * 100
HancockCo2Default <- PctLaborForce[5] * 100
OxfordCo2Default <- PctLaborForce[9] * 100
SomerCo2Default <- PctLaborForce[13] * 100

AndroCo3Default <- PctOutflow[1] * 100
HancockCo3Default <- PctOutflow[5] * 100
OxfordCo3Default <- PctOutflow[9] * 100
SomerCo3Default <- PctOutflow[13] * 100

AndroCo4Default <- PctWSEmp[1] * 100
HancockCo4Default <- PctWSEmp[5] * 100
OxfordCo4Default <- PctWSEmp[9] * 100
SomerCo4Default <- PctWSEmp[13] * 100

AndroCo5Default <- 0
HancockCo5Default <- 0
OxfordCo5Default <- 0
SomerCo5Default <- 0

                             
# Second Block
AroostCo1Default <- PctWorkingAge[2] * 100
KennebCo1Default <- PctWorkingAge[6] * 100
PenobCo1Default <- PctWorkingAge[10] * 100
WaldoCo1Default <- PctWorkingAge[14] * 100

AroostCo2Default <- PctLaborForce[2] * 100
KennebCo2Default <- PctLaborForce[6] * 100
PenobCo2Default <- PctLaborForce[10] * 100
WaldoCo2Default <- PctLaborForce[14] * 100

AroostCo3Default <- PctOutflow[2] * 100
KennebCo3Default <- PctOutflow[6] * 100
PenobCo3Default <- PctOutflow[10] * 100
WaldoCo3Default <- PctOutflow[14] * 100

AroostCo4Default <- PctWSEmp[2] * 100
KennebCo4Default <- PctWSEmp[6] * 100
PenobCo4Default <- PctWSEmp[10] * 100
WaldoCo4Default <- PctWSEmp[14] * 100

AroostCo5Default <- 0
KennebCo5Default <- 0
PenobCo5Default <- 2
WaldoCo5Default <- 0
                             

# Third Block
CumberCo1Default <- PctWorkingAge[3] * 100
KnoxCo1Default <- PctWorkingAge[7] * 100
PiscatCo1Default <- PctWorkingAge[11] * 100
WashinCo1Default <- PctWorkingAge[15] * 100

CumberCo2Default <- PctLaborForce[3] * 100
KnoxCo2Default <- PctLaborForce[7] * 100
PiscatCo2Default <- PctLaborForce[11] * 100
WashinCo2Default <- PctLaborForce[15] * 100

CumberCo3Default <- PctOutflow[3] * 100
KnoxCo3Default <- PctOutflow[7] * 100
PiscatCo3Default <- PctOutflow[11] * 100
WashinCo3Default <- PctOutflow[15] * 100

CumberCo4Default <- PctWSEmp[3] * 100
KnoxCo4Default <- PctWSEmp[7] * 100
PiscatCo4Default <- PctWSEmp[11] * 100
WashinCo4Default <- PctWSEmp[15] * 100

CumberCo5Default <- 2
KnoxCo5Default <- 0
PiscatCo5Default <- 0
WashinCo5Default <- 0


#Fourth Block
FrankCo1Default <- PctWorkingAge[4] * 100
LincoCo1Default <- PctWorkingAge[8] * 100
SagadaCo1Default <- PctWorkingAge[12] * 100
YorkCo1Default <- PctWorkingAge[16] * 100

FrankCo2Default <- PctLaborForce[4] * 100
LincoCo2Default <- PctLaborForce[8] * 100
SagadaCo2Default <- PctLaborForce[12] * 100
YorkCo2Default <- PctLaborForce[16] * 100

FrankCo3Default <- PctOutflow[4] * 100
LincoCo3Default <- PctOutflow[8] * 100
SagadaCo3Default <- PctOutflow[12] * 100
YorkCo3Default <- PctOutflow[16] * 100

FrankCo4Default <- PctWSEmp[4] * 100
LincoCo4Default <- PctWSEmp[8] * 100
SagadaCo4Default <- PctWSEmp[12] * 100
YorkCo4Default <- PctWSEmp[16] * 100

FrankCo5Default <- 0
LincoCo5Default <- 0
SagadaCo5Default <- 2
YorkCo5Default <- 2
  


navbarPage("Workforce Estimation Tool",
           
           tags$head(tags$link(rel="stylesheet", type = "text/css", href="w3.css")),
           
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
           
           
           tabPanel("Employment Forecast",

                    DT::dataTableOutput("employmentForecast2"),
                    
                    
                    # fluidRow(column(4, sliderInput("employmentReductionSlider1", "% Self-employment in 2019", value=33.85, min=0, max=100, step=0.01)),
                    #          column(4, sliderInput("employmentReductionSlider2", "% Self-employment in 2045", value=40, min=0, max=100, step=0.01))),
                    # fluidRow(column(4, p("We've estimated 33.85% of total employment in the 2019 Woods and Poole data is self-employment")),
                    #          column(4, p("The self-employed ratio is likely to be higher in the future"))),
                    
                    
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
                    
                    
                    fluidRow(column(3, sliderInput("androscogginCoSlider5", h6("% Working Two Jobs in 2045"), value=AndroCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("hancockCoSlider5", h6("% Working Two Jobs in 2045"), value=HancockCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("oxfordCoSlider5", h6("% Working Two Jobs in 2045"), value=OxfordCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("somersetCoSlider5", h6("% Working Two Jobs in 2045"), value=SomerCo5Default, min=0, max=100, step=0.1))
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
                    
                    
                    
                    fluidRow(column(3, sliderInput("aroostookCoSlider5", h6("% Working Two Jobs in 2045"), value=AroostCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("kennebecCoSlider5", h6("% Working Two Jobs in 2045"), value=KennebCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("penobscotCoSlider5", h6("% Working Two Jobs in 2045"), value=PenobCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("waldoCoSlider5", h6("% Working Two Jobs in 2045"), value=WaldoCo5Default, min=0, max=100, step=0.1))
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
                    
                    
                    
                    
                    fluidRow(column(3, sliderInput("cumberlandCoSlider5", h6("% Working Two Jobs in 2045"), value=CumberCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("knoxCoSlider5", h6("% Working Two Jobs in 2045"), value=KnoxCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("piscataquisCoSlider5", h6("% Working Two Jobs in 2045"), value=PiscatCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("washingtonCoSlider5", h6("% Working Two Jobs in 2045"), value=WashinCo5Default, min=0, max=100, step=0.1))
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
                    
                    
                    fluidRow(column(3, sliderInput("franklinCoSlider5", h6("% Working Two Jobs in 2045"), value=FrankCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("lincolnCoSlider5", h6("% Working Two Jobs in 2045"), value=LincoCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("sagadahocCoSlider5", h6("% Working Two Jobs in 2045"), value=SagadaCo5Default, min=0, max=100, step=0.1)),
                             column(3, sliderInput("yorkCoSlider5", h6("% Working Two Jobs in 2045"), value=YorkCo5Default, min=0, max=100, step=0.1))
                    ),
                    
                    fluidRow(column(3, h6(paste("Default: ", FrankCo5Default, "%"))),
                             column(3, h6(paste("Default: ", LincoCo5Default, "%"))),
                             column(3, h6(paste("Default: ", SagadaCo5Default, "%"))),
                             column(3, h6(paste("Default: ", YorkCo5Default, "%"))),
                    ),
                    
                    
                    
           ),
           
           tabPanel("Workforce Forecast",
                    
                    DT::dataTableOutput("workforceForecast"),
                    
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
                    

                    
           ),
           
           tabPanel("County Flows",
                    
                    DT::dataTableOutput("countyFlows"),
                    
                    
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

                    
           ),
           
           
           
           tabPanel("Trip Matrix",
                    
                    DT::dataTableOutput("tripMatrix2"),
                    
                    
                    
           ),
           
           
           tabPanel("Balance",
                    
                    DT::dataTableOutput("balance"),
                    
                    
                    
           ),
           
           
           # 
           # tabPanel("Employment Forecast Old",
           #          fluidRow(column(4, sliderInput("employmentReductionSlider1", "% Self-employment in 2019", value=33.85, min=0, max=100, step=0.01)),
           #                   column(4, sliderInput("employmentReductionSlider2", "% Self-employment in 2045", value=40, min=0, max=100, step=0.01))),
           #          fluidRow(column(4, p("We've estimated 33.85% of total employment in the 2019 Woods and Poole data is self-employment")),
           #                   column(4, p("The self-employed ratio is likely to be higher in the future"))),
           #          DT::dataTableOutput("employmentForecast"),
           #          
           #          
           #          fluidRow(column(3, h5("Androscoggin County")),
           #                   column(3, h5("Hancock County")),
           #                   column(3, h5("Oxford County")),
           #                   column(3, h5("Somerset County")),
           #          ),
           #          
           #          fluidRow(column(3, actionButton("reset_1", "Reset Androscoggin County")),
           #                   column(3, actionButton("reset_2", "Reset Hancock County")),
           #                   column(3, actionButton("reset_3", "Reset Oxford County")),
           #                   column(3, actionButton("reset_4", "Reset Somerset County")),
           #                   
           #          ),
           #          
           #          fluidRow(column(3, sliderInput("androscogginCoSlider1", h6("Percent of Population Aged 15+"), value=AndroCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("hancockCoSlider1", h6("Percent of Population Aged 15+"), value=HancockCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("oxfordCoSlider1", h6("Percent of Population Aged 15+"), value=OxfordCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("somersetCoSlider1", h6("Percent of Population Aged 15+"), value=SomerCo1Default, min=0, max=100, step=0.1)),
           #          ),  
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AndroCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", HancockCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", OxfordCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", SomerCo1Default, "%"))),
           #          ),
           #          
           #          # (column(3, sliderInput("androscogginCoSlider1", "Percent of Population Aged 15+", value=80, min=0, max=100, step=0.1)),
           #          #  column(3, sliderInput("hancockCoSlider1", "Percent of Population Aged 15+", value=86.9, min=0, max=100, step=0.1)),
           #          #  column(3, sliderInput("oxfordCoSlider1", "Percent of Population Aged 15+", value=86.7, min=0, max=100, step=0.1)),
           #          #  column(3, sliderInput("somersetCoSlider1", "Percent of Population Aged 15+", value=86.3, min=0, max=100, step=0.1)),
           #          # ),  
           # 
           #          
           #          fluidRow(column(3, sliderInput("androscogginCoSlider2", h6("Labor Force Participation % in 2045"), value=AndroCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("hancockCoSlider2", h6("Labor Force Participation % in 2045"), value=HancockCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("oxfordCoSlider2", h6("Labor Force Participation % in 2045"), value=OxfordCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("somersetCoSlider2", h6("Labor Force Participation % in 2045"), value=SomerCo2Default, min=0, max=100, step=0.1))
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AndroCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", HancockCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", OxfordCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", SomerCo2Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("androscogginCoSlider2", "Labor Force Participation % in 2045", value=65.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("hancockCoSlider2", "Labor Force Participation % in 2045", value=62.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("oxfordCoSlider2", "Labor Force Participation % in 2045", value=57.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("somersetCoSlider2", "Labor Force Participation % in 2045", value=55.6, min=0, max=100, step=0.1))
           #          # ),
           #          
           #          fluidRow(column(3, sliderInput("androscogginCoSlider3", h6("Labor Force Outflow % in 2045"), value=AndroCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("hancockCoSlider3", h6("Labor Force Outflow % in 2045"), value=HancockCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("oxfordCoSlider3", h6("Labor Force Outflow % in 2045"), value=OxfordCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("somersetCoSlider3", h6("Labor Force Outflow % in 2045"), value=SomerCo3Default, min=0, max=100, step=0.1)),
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AndroCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", HancockCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", OxfordCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", SomerCo3Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("androscogginCoSlider3", "Labor Force Outflow % in 2045", value=45.7, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("hancockCoSlider3", "Labor Force Outflow % in 2045", value=36.1, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("oxfordCoSlider3", "Labor Force Outflow % in 2045", value=62.4, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("somersetCoSlider3", "Labor Force Outflow % in 2045", value=63.1, min=0, max=100, step=0.1)),
           #          # ),
           #          
           # 
           #          
           #          
           #          fluidRow(column(3, h5("Aroostook County")),
           #                   column(3, h5("Kennebec County")),
           #                   column(3, h5("Penobscot County")),
           #                   column(3, h5("Waldo County")),
           #          ),
           #          
           #          fluidRow(column(3, actionButton("reset_5", "Reset Aroostook County")),
           #                   column(3, actionButton("reset_6", "Reset Kennebec County")),
           #                   column(3, actionButton("reset_7", "Reset Penobscot County")),
           #                   column(3, actionButton("reset_8", "Reset Waldo County")),
           #                   
           #          ),
           #          
           #          fluidRow(column(3, sliderInput("aroostookCoSlider1", h6("Percent of Population Aged 15+"), value=AroostCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("kennebecCoSlider1", h6("Percent of Population Aged 15+"), value=KennebCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("penobscotCoSlider1", h6("Percent of Population Aged 15+"), value=PenobCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("waldoCoSlider1", h6("Percent of Population Aged 15+"), value=WaldoCo1Default, min=0, max=100, step=0.1)),
           #          ),  
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AroostCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", KennebCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", PenobCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", WaldoCo1Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("aroostookCoSlider1", "Percent of Population Aged 15+", value=86.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("kennebecCoSlider1", "Percent of Population Aged 15+", value=84.6, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("penobscotCoSlider1", "Percent of Population Aged 15+", value=85.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("waldoCoSlider1", "Percent of Population Aged 15+", value=85.9, min=0, max=100, step=0.1)),
           #          # ),  
           #          
           #          
           #          fluidRow(column(3, sliderInput("aroostookCoSlider2", h6("Labor Force Participation % in 2045"), value=AroostCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("kennebecCoSlider2", h6("Labor Force Participation % in 2045"), value=KennebCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("penobscotCoSlider2", h6("Labor Force Participation % in 2045"), value=PenobCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("waldoCoSlider2", h6("Labor Force Participation % in 2045"), value=WaldoCo2Default, min=0, max=100, step=0.1))
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AroostCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", KennebCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", PenobCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", WaldoCo2Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("aroostookCoSlider2", "Labor Force Participation % in 2045", value=54.1, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("kennebecCoSlider2", "Labor Force Participation % in 2045", value=61.6, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("penobscotCoSlider2", "Labor Force Participation % in 2045", value=60.9, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("waldoCoSlider2", "Labor Force Participation % in 2045", value=60.7, min=0, max=100, step=0.1))
           #          # ),
           #          
           #          fluidRow(column(3, sliderInput("aroostookCoSlider3", h6("Labor Force Outflow % in 2045"), value=AroostCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("kennebecCoSlider3", h6("Labor Force Outflow % in 2045"), value=KennebCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("penobscotCoSlider3", h6("Labor Force Outflow % in 2045"), value=PenobCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("waldoCoSlider3", h6("Labor Force Outflow % in 2045"), value=WaldoCo3Default, min=0, max=100, step=0.1)),
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", AroostCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", KennebCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", PenobCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", WaldoCo3Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("aroostookCoSlider3", "Labor Force Outflow % in 2045", value=19.7, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("kennebecCoSlider3", "Labor Force Outflow % in 2045", value=40.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("penobscotCoSlider3", "Labor Force Outflow % in 2045", value=28.1, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("waldoCoSlider3", "Labor Force Outflow % in 2045", value=57.1, min=0, max=100, step=0.1)),
           #          # ),
           #          
           # 
           #          
           #          
           #          fluidRow(column(3, h5("Cumberland County")),
           #                   column(3, h5("Knox County")),
           #                   column(3, h5("Piscataquis County")),
           #                   column(3, h5("Washington County")),
           #          ),
           #          
           #          fluidRow(column(3, actionButton("reset_9", "Reset Cumberland County")),
           #                   column(3, actionButton("reset_10", "Reset Knox County")),
           #                   column(3, actionButton("reset_11", "Reset Piscataquis County")),
           #                   column(3, actionButton("reset_12", "Reset Washington County")),
           #                   
           #          ),
           #          
           #          fluidRow(column(3, sliderInput("cumberlandCoSlider1", h6("Percent of Population Aged 15+"), value=CumberCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("knoxCoSlider1", h6("Percent of Population Aged 15+"), value=KnoxCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("piscataquisCoSlider1", h6("Percent of Population Aged 15+"), value=PiscatCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("washingtonCoSlider1", h6("Percent of Population Aged 15+"), value=WashinCo1Default, min=0, max=100, step=0.1)),
           #          ),  
           #          
           #          fluidRow(column(3, h6(paste("Default: ", CumberCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", KnoxCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", PiscatCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", WashinCo1Default, "%"))),
           #          ),
           #          
           #          
           #          # fluidRow(column(3, sliderInput("cumberlandCoSlider1", "Percent of Population Aged 15+", value=85, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("knoxCoSlider1", "Percent of Population Aged 15+", value=86.8, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("piscataquisCoSlider1", "Percent of Population Aged 15+", value=88.1, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("washingtonCoSlider1", "Percent of Population Aged 15+", value=85.2, min=0, max=100, step=0.1)),
           #          # ), 
           #          
           # 
           #          fluidRow(column(3, sliderInput("cumberlandCoSlider2", h6("Labor Force Participation % in 2045"), value=CumberCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("knoxCoSlider2", h6("Labor Force Participation % in 2045"), value=KnoxCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("piscataquisCoSlider2", h6("Labor Force Participation % in 2045"), value=PiscatCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("washingtonCoSlider2", h6("Labor Force Participation % in 2045"), value=WashinCo2Default, min=0, max=100, step=0.1))
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", CumberCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", KnoxCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", PiscatCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", WashinCo2Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("cumberlandCoSlider2", "Labor Force Participation % in 2045", value=69.1, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("knoxCoSlider2", "Labor Force Participation % in 2045", value=61.7, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("piscataquisCoSlider2", "Labor Force Participation % in 2045", value=48.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("washingtonCoSlider2", "Labor Force Participation % in 2045", value=52.6, min=0, max=100, step=0.1))
           #          # ),
           #          
           #          
           #          fluidRow(column(3, sliderInput("cumberlandCoSlider3", h6("Labor Force Outflow % in 2045"), value=CumberCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("knoxCoSlider3", h6("Labor Force Outflow % in 2045"), value=KnoxCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("piscataquisCoSlider3", h6("Labor Force Outflow % in 2045"), value=PiscatCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("washingtonCoSlider3", h6("Labor Force Outflow % in 2045"), value=WashinCo3Default, min=0, max=100, step=0.1)),
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", CumberCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", KnoxCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", PiscatCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", WashinCo3Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("cumberlandCoSlider3", "Labor Force Outflow % in 2045", value=23.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("knoxCoSlider3", "Labor Force Outflow % in 2045", value=37.9, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("piscataquisCoSlider3", "Labor Force Outflow % in 2045", value=50.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("washingtonCoSlider3", "Labor Force Outflow % in 2045", value=35.1, min=0, max=100, step=0.1)),
           #          # ),
           #          
           # 
           #          
           #          
           #          fluidRow(column(3, h5("Franklin County")),
           #                   column(3, h5("Lincoln County")),
           #                   column(3, h5("Sagadahoc County")),
           #                   column(3, h5("York County")),
           #          ),
           #          
           #          fluidRow(column(3, actionButton("reset_13", "Reset Franklin County")),
           #                   column(3, actionButton("reset_14", "Reset Lincoln County")),
           #                   column(3, actionButton("reset_15", "Reset Sagadahoc County")),
           #                   column(3, actionButton("reset_16", "Reset York County")),
           #                   
           #          ),
           #          
           #          fluidRow(column(3, sliderInput("franklinCoSlider1", h6("Percent of Population Aged 15+"), value=FrankCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("lincolnCoSlider1", h6("Percent of Population Aged 15+"), value=LincoCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("sagadahocCoSlider1", h6("Percent of Population Aged 15+"), value=SagadaCo1Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("yorkCoSlider1", h6("Percent of Population Aged 15+"), value=YorkCo1Default, min=0, max=100, step=0.1)),
           #          ),  
           #          
           #          fluidRow(column(3, h6(paste("Default: ", FrankCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", LincoCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", SagadaCo1Default, "%"))),
           #                   column(3, h6(paste("Default: ", YorkCo1Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("franklinCoSlider1", "Percent of Population Aged 15+", value=87.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("lincolnCoSlider1", "Percent of Population Aged 15+", value=88.6, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("sagadahocCoSlider1", "Percent of Population Aged 15+", value=85, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("yorkCoSlider1", "Percent of Population Aged 15+", value=85.7, min=0, max=100, step=0.1)),
           #          # ),  
           #          # 
           #          
           #          
           #          fluidRow(column(3, sliderInput("franklinCoSlider2", h6("Labor Force Participation % in 2045"), value=FrankCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("lincolnCoSlider2", h6("Labor Force Participation % in 2045"), value=LincoCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("sagadahocCoSlider2", h6("Labor Force Participation % in 2045"), value=SagadaCo2Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("yorkCoSlider2", h6("Labor Force Participation % in 2045"), value=YorkCo2Default, min=0, max=100, step=0.1))
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", FrankCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", LincoCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", SagadaCo2Default, "%"))),
           #                   column(3, h6(paste("Default: ", YorkCo2Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("franklinCoSlider2", "Labor Force Participation % in 2045", value=60.8, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("lincolnCoSlider2", "Labor Force Participation % in 2045", value=58.6, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("sagadahocCoSlider2", "Labor Force Participation % in 2045", value=65, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("yorkCoSlider2", "Labor Force Participation % in 2045", value=66.3, min=0, max=100, step=0.1))
           #          # ),
           #          
           #          fluidRow(column(3, sliderInput("franklinCoSlider3", h6("Labor Force Outflow % in 2045"), value=FrankCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("lincolnCoSlider3", h6("Labor Force Outflow % in 2045"), value=LincoCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("sagadahocCoSlider3", h6("Labor Force Outflow % in 2045"), value=SagadaCo3Default, min=0, max=100, step=0.1)),
           #                   column(3, sliderInput("yorkCoSlider3", h6("Labor Force Outflow % in 2045"), value=YorkCo3Default, min=0, max=100, step=0.1)),
           #          ),
           #          
           #          fluidRow(column(3, h6(paste("Default: ", FrankCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", LincoCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", SagadaCo3Default, "%"))),
           #                   column(3, h6(paste("Default: ", YorkCo3Default, "%"))),
           #          ),
           #          
           #          # fluidRow(column(3, sliderInput("franklinCoSlider3", "Labor Force Outflow % in 2045", value=54.8, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("lincolnCoSlider3", "Labor Force Outflow % in 2045", value=60.5, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("sagadahocCoSlider3", "Labor Force Outflow % in 2045", value=67.3, min=0, max=100, step=0.1)),
           #          #          column(3, sliderInput("yorkCoSlider3", "Labor Force Outflow % in 2045", value=56.4, min=0, max=100, step=0.1)),
           #          # ),
           #          
           # 
           #          
           #          
           # ),
           # 

           
           navbarMenu("More Data",
                      
                      tabPanel("Population Forecast",
                               DT::dataTableOutput("populationForecast")),
                      
                       tabPanel("Employment Forecast",
                                DT::dataTableOutput("employmentForecast3")),
                       
                      
                      tabPanel("Age Structure",
                               DT::dataTableOutput("ageStructure2045")
                      ),
                      
                      tabPanel("County Workflows 2019",
                               DT::dataTableOutput("countyWorkflows2019")
                      ),
                      
                      tabPanel("County Laborforce Participation 2019",
                               DT::dataTableOutput("countyWorkforce2019")
                      ),     
            
           )
)

