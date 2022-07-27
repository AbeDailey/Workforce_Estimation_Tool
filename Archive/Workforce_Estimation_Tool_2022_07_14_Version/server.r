
library(DT)



# Define Constants

ageStructure <- read.csv(file="Tables/2_maine_county_age_structure_2045.csv", head=TRUE,sep=",")
laborParticipation <- read.csv(file="Tables/5_maine_county_workforce_participation_rate_2019.csv", head=TRUE,sep=",")
workforceOutflows <- read.csv(file="Tables/3_maine_county_workforce_flows_2019.csv", head=TRUE,sep=",")
employment <- read.csv(file="Tables/4_maine_county_employment_forecast_2045.csv", head=TRUE,sep=",")

PctWorkingAge <- ageStructure$Population_Age_15_and_Over
PctLaborForce <- laborParticipation$Workforce_Participation_Rate_2019
PctOutflow <- workforceOutflows$Workforce_Percent_Outflows

PctWSEmp <- employment$PCT_2019_Wage_Salary_Employment

# PctWSEmp <- employment$PCT_2019_Self_Employment


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




server <- function(input, output, session) {
  
  
  # Update Sliders When Reset Button Pressed
  
  observeEvent(input$reset_1, {
    
    updateSliderInput(inputId="androscogginCoSlider1", value=AndroCo1Default)
    updateSliderInput(inputId="androscogginCoSlider2", value=AndroCo2Default)
    #updateSliderInput(inputId="androscogginCoSlider3", value=AndroCo3Default)
    
  }) # End observeEvent reset_1
  
  
  observeEvent(input$reset_1a, {
    
    #updateSliderInput(inputId="androscogginCoSlider1", value=AndroCo1Default)
    #updateSliderInput(inputId="androscogginCoSlider2", value=AndroCo2Default)
    updateSliderInput(inputId="androscogginCoSlider3", value=AndroCo3Default)
    
  }) # End observeEvent reset_1a
  
  
  observeEvent(input$reset_1b, {
    
    updateSliderInput(inputId="androscogginCoSlider4", value=AndroCo4Default)
    updateSliderInput(inputId="androscogginCoSlider5", value=AndroCo5Default)
    
  }) # End observeEvent reset_1b
  
  
  observeEvent(input$reset_2, {
    
    updateSliderInput(inputId="hancockCoSlider1", value=HancockCo1Default)
    updateSliderInput(inputId="hancockCoSlider2", value=HancockCo2Default)
    #updateSliderInput(inputId="hancockCoSlider3", value=HancockCo3Default)
    
  }) # End observeEvent reset_2
  
  observeEvent(input$reset_2a, {
    
    #updateSliderInput(inputId="hancockCoSlider1", value=HancockCo1Default)
    #updateSliderInput(inputId="hancockCoSlider2", value=HancockCo2Default)
    updateSliderInput(inputId="hancockCoSlider3", value=HancockCo3Default)
    
  }) # End observeEvent reset_2a
  
  
  observeEvent(input$reset_2b, {
    
    updateSliderInput(inputId="hancockCoSlider4", value=HancockCo4Default)
    updateSliderInput(inputId="hancockCoSlider5", value=HancockCo5Default)
    
  }) # End observeEvent reset_2b
  
  
  observeEvent(input$reset_3, {
    
    updateSliderInput(inputId="oxfordCoSlider1", value=OxfordCo1Default)
    updateSliderInput(inputId="oxfordCoSlider2", value=OxfordCo2Default)
    #updateSliderInput(inputId="oxfordCoSlider3", value=OxfordCo3Default)
    
  }) # End observeEvent reset_3
  
  
  observeEvent(input$reset_3a, {
    
    #updateSliderInput(inputId="oxfordCoSlider1", value=OxfordCo1Default)
    #updateSliderInput(inputId="oxfordCoSlider2", value=OxfordCo2Default)
    updateSliderInput(inputId="oxfordCoSlider3", value=OxfordCo3Default)
    
  }) # End observeEvent reset_3a
  
  
  observeEvent(input$reset_3b, {
    
    updateSliderInput(inputId="oxfordCoSlider4", value=OxfordCo4Default)
    updateSliderInput(inputId="oxfordCoSlider5", value=OxfordCo5Default)
    
  }) # End observeEvent reset_3b
  
  
  observeEvent(input$reset_4, {
    
    updateSliderInput(inputId="somersetCoSlider1", value=SomerCo1Default)
    updateSliderInput(inputId="somersetCoSlider2", value=SomerCo2Default)
    #updateSliderInput(inputId="somersetCoSlider3", value=SomerCo3Default)
    
  }) # End observeEvent reset_4
  
  
  observeEvent(input$reset_4a, {
    
    #updateSliderInput(inputId="somersetCoSlider1", value=SomerCo1Default)
    #updateSliderInput(inputId="somersetCoSlider2", value=SomerCo2Default)
    updateSliderInput(inputId="somersetCoSlider3", value=SomerCo3Default)
    
  }) # End observeEvent reset_4a
  
  
  observeEvent(input$reset_4b, {
    
    updateSliderInput(inputId="somersetCoSlider4", value=SomerCo4Default)
    updateSliderInput(inputId="somersetCoSlider5", value=SomerCo5Default)
    
  }) # End observeEvent reset_4b
  
  
  observeEvent(input$reset_5, {
    
    updateSliderInput(inputId="aroostookCoSlider1", value=AroostCo1Default)
    updateSliderInput(inputId="aroostookCoSlider2", value=AroostCo2Default)
    #updateSliderInput(inputId="aroostookCoSlider3", value=AroostCo3Default)
    
  }) # End observeEvent reset_5
  
  
  observeEvent(input$reset_5a, {
    
    #updateSliderInput(inputId="aroostookCoSlider1", value=AroostCo1Default)
    #updateSliderInput(inputId="aroostookCoSlider2", value=AroostCo2Default)
    updateSliderInput(inputId="aroostookCoSlider3", value=AroostCo3Default)
    
  }) # End observeEvent reset_5a
  
  
  observeEvent(input$reset_5b, {
    
    updateSliderInput(inputId="aroostookCoSlider4", value=AroostCo4Default)
    updateSliderInput(inputId="aroostookCoSlider5", value=AroostCo5Default)
    
  }) # End observeEvent reset_5b
  
  
  observeEvent(input$reset_6, {
    
    updateSliderInput(inputId="kennebecCoSlider1", value=KennebCo1Default)
    updateSliderInput(inputId="kennebecCoSlider2", value=KennebCo2Default)
    #updateSliderInput(inputId="kennebecCoSlider3", value=KennebCo3Default)
    
  }) # End observeEvent reset_6
  
  
  observeEvent(input$reset_6a, {
    
    #updateSliderInput(inputId="kennebecCoSlider1", value=KennebCo1Default)
    #updateSliderInput(inputId="kennebecCoSlider2", value=KennebCo2Default)
    updateSliderInput(inputId="kennebecCoSlider3", value=KennebCo3Default)
    
  }) # End observeEvent reset_6a
  
  
  observeEvent(input$reset_6b, {
    
    updateSliderInput(inputId="kennebecCoSlider4", value=KennebCo4Default)
    updateSliderInput(inputId="kennebecCoSlider5", value=KennebCo5Default)
    
  }) # End observeEvent reset_6b
  
  
  observeEvent(input$reset_7, {
    
    updateSliderInput(inputId="penobscotCoSlider1", value=PenobCo1Default)
    updateSliderInput(inputId="penobscotCoSlider2", value=PenobCo2Default)
    #updateSliderInput(inputId="penobscotCoSlider3", value=PenobCo3Default)
    
  }) # End observeEvent reset_7
  
  
  observeEvent(input$reset_7a, {
    
    #updateSliderInput(inputId="penobscotCoSlider1", value=PenobCo1Default)
    #updateSliderInput(inputId="penobscotCoSlider2", value=PenobCo2Default)
    updateSliderInput(inputId="penobscotCoSlider3", value=PenobCo3Default)
    
  }) # End observeEvent reset_7a
  
  
  observeEvent(input$reset_7b, {
    
    updateSliderInput(inputId="penobscotCoSlider4", value=PenobCo4Default)
    updateSliderInput(inputId="penobscotCoSlider5", value=PenobCo5Default)
    
  }) # End observeEvent reset_7b
  
  
  observeEvent(input$reset_8, {
    
    updateSliderInput(inputId="waldoCoSlider1", value=WaldoCo1Default)
    updateSliderInput(inputId="waldoCoSlider2", value=WaldoCo2Default)
    #updateSliderInput(inputId="waldoCoSlider3", value=WaldoCo3Default)
    
  }) # End observeEvent reset_8
  
  
  observeEvent(input$reset_8a, {
    
    #updateSliderInput(inputId="waldoCoSlider1", value=WaldoCo1Default)
    #updateSliderInput(inputId="waldoCoSlider2", value=WaldoCo2Default)
    updateSliderInput(inputId="waldoCoSlider3", value=WaldoCo3Default)
    
  }) # End observeEvent reset_8a
  
  
  observeEvent(input$reset_8b, {
    
    updateSliderInput(inputId="waldoCoSlider4", value=WaldoCo4Default)
    updateSliderInput(inputId="waldoCoSlider5", value=WaldoCo5Default)
    
  }) # End observeEvent reset_8b
  
  
  observeEvent(input$reset_9, {
    
    updateSliderInput(inputId="cumberlandCoSlider1", value=CumberCo1Default)
    updateSliderInput(inputId="cumberlandCoSlider2", value=CumberCo2Default)
    #updateSliderInput(inputId="cumberlandCoSlider3", value=CumberCo3Default)
    
  }) # End observeEvent reset_9
  
  
  observeEvent(input$reset_9a, {
    
    #updateSliderInput(inputId="cumberlandCoSlider1", value=CumberCo1Default)
    #updateSliderInput(inputId="cumberlandCoSlider2", value=CumberCo2Default)
    updateSliderInput(inputId="cumberlandCoSlider3", value=CumberCo3Default)
    
  }) # End observeEvent reset_9a
  
  
  observeEvent(input$reset_9b, {
    
    updateSliderInput(inputId="cumberlandCoSlider4", value=CumberCo4Default)
    updateSliderInput(inputId="cumberlandCoSlider5", value=CumberCo5Default)
    
  }) # End observeEvent reset_9b
  
  
  observeEvent(input$reset_10, {
    
    updateSliderInput(inputId="knoxCoSlider1", value=KnoxCo1Default)
    updateSliderInput(inputId="knoxCoSlider2", value=KnoxCo2Default)
    #updateSliderInput(inputId="knoxCoSlider3", value=KnoxCo3Default)
    
  }) # End observeEvent reset_10
  
  
  observeEvent(input$reset_10a, {
    
    #updateSliderInput(inputId="knoxCoSlider1", value=KnoxCo1Default)
    #updateSliderInput(inputId="knoxCoSlider2", value=KnoxCo2Default)
    updateSliderInput(inputId="knoxCoSlider3", value=KnoxCo3Default)
    
  }) # End observeEvent reset_10a
  
  
  observeEvent(input$reset_10b, {
    
    updateSliderInput(inputId="knoxCoSlider4", value=KnoxCo4Default)
    updateSliderInput(inputId="knoxCoSlider5", value=KnoxCo5Default)
    
  }) # End observeEvent reset_10b
  
  
  observeEvent(input$reset_11, {
    
    updateSliderInput(inputId="piscataquisCoSlider1", value=PiscatCo1Default)
    updateSliderInput(inputId="piscataquisCoSlider2", value=PiscatCo2Default)
    #updateSliderInput(inputId="piscataquisCoSlider3", value=PiscatCo3Default)
    
  }) # End observeEvent reset_11
  
  
  observeEvent(input$reset_11a, {
    
    #updateSliderInput(inputId="piscataquisCoSlider1", value=PiscatCo1Default)
    #updateSliderInput(inputId="piscataquisCoSlider2", value=PiscatCo2Default)
    updateSliderInput(inputId="piscataquisCoSlider3", value=PiscatCo3Default)
    
  }) # End observeEvent reset_11a
  
  
  observeEvent(input$reset_11b, {
    
    updateSliderInput(inputId="piscataquisCoSlider4", value=PiscatCo4Default)
    updateSliderInput(inputId="piscataquisCoSlider5", value=PiscatCo5Default)
    
  }) # End observeEvent reset_11b
  
  
  observeEvent(input$reset_12, {
    
    updateSliderInput(inputId="washingtonCoSlider1", value=WashinCo1Default)
    updateSliderInput(inputId="washingtonCoSlider2", value=WashinCo2Default)
    #updateSliderInput(inputId="washingtonCoSlider3", value=WashinCo3Default)
    
  }) # End observeEvent reset_12
  
  
  observeEvent(input$reset_12a, {
    
    #updateSliderInput(inputId="washingtonCoSlider1", value=WashinCo1Default)
    #updateSliderInput(inputId="washingtonCoSlider2", value=WashinCo2Default)
    updateSliderInput(inputId="washingtonCoSlider3", value=WashinCo3Default)
    
  }) # End observeEvent reset_12a
  
  
  observeEvent(input$reset_12b, {
    
    updateSliderInput(inputId="washingtonCoSlider4", value=WashinCo4Default)
    updateSliderInput(inputId="washingtonCoSlider5", value=WashinCo5Default)
    
  }) # End observeEvent reset_12b
  
  
  observeEvent(input$reset_13, {
    
    updateSliderInput(inputId="franklinCoSlider1", value=FrankCo1Default)
    updateSliderInput(inputId="franklinCoSlider2", value=FrankCo2Default)
    #updateSliderInput(inputId="franklinCoSlider3", value=FrankCo3Default)
    
  }) # End observeEvent reset_13
  
  
  observeEvent(input$reset_13a, {
    
    #updateSliderInput(inputId="franklinCoSlider1", value=FrankCo1Default)
    #updateSliderInput(inputId="franklinCoSlider2", value=FrankCo2Default)
    updateSliderInput(inputId="franklinCoSlider3", value=FrankCo3Default)
    
  }) # End observeEvent reset_13a
  
  
  observeEvent(input$reset_13b, {
    
    updateSliderInput(inputId="franklinCoSlider4", value=FrankCo4Default)
    updateSliderInput(inputId="franklinCoSlider5", value=FrankCo5Default)
    
  }) # End observeEvent reset_13b
  
  
  observeEvent(input$reset_14, {
    
    updateSliderInput(inputId="lincolnCoSlider1", value=LincoCo1Default)
    updateSliderInput(inputId="lincolnCoSlider2", value=LincoCo2Default)
    #updateSliderInput(inputId="lincolnCoSlider3", value=LincoCo3Default)
    
  }) # End observeEvent reset_14
  
  
  observeEvent(input$reset_14a, {
    
    #updateSliderInput(inputId="lincolnCoSlider1", value=LincoCo1Default)
    #updateSliderInput(inputId="lincolnCoSlider2", value=LincoCo2Default)
    updateSliderInput(inputId="lincolnCoSlider3", value=LincoCo3Default)
    
  }) # End observeEvent reset_14a
  
  
  observeEvent(input$reset_14b, {
    
    updateSliderInput(inputId="lincolnCoSlider4", value=LincoCo4Default)
    updateSliderInput(inputId="lincolnCoSlider5", value=LincoCo5Default)
    
  }) # End observeEvent reset_14b
  
  
  
  observeEvent(input$reset_15, {
    
    updateSliderInput(inputId="sagadahocCoSlider1", value=SagadaCo1Default)
    updateSliderInput(inputId="sagadahocCoSlider2", value=SagadaCo2Default)
    #updateSliderInput(inputId="sagadahocCoSlider3", value=SagadaCo3Default)
    
  }) # End observeEvent reset_15
  
  
  observeEvent(input$reset_15a, {
    
    #updateSliderInput(inputId="sagadahocCoSlider1", value=SagadaCo1Default)
    #updateSliderInput(inputId="sagadahocCoSlider2", value=SagadaCo2Default)
    updateSliderInput(inputId="sagadahocCoSlider3", value=SagadaCo3Default)
    
  }) # End observeEvent reset_15a
  
  
  observeEvent(input$reset_15b, {
    
    updateSliderInput(inputId="sagadahocCoSlider4", value=SagadaCo4Default)
    updateSliderInput(inputId="sagadahocCoSlider5", value=SagadaCo5Default)
    
  }) # End observeEvent reset_15b
  
  
  observeEvent(input$reset_16, {
    
    updateSliderInput(inputId="yorkCoSlider1", value=YorkCo1Default)
    updateSliderInput(inputId="yorkCoSlider2", value=YorkCo2Default)
    #updateSliderInput(inputId="yorkCoSlider3", value=YorkCo3Default)
    
  }) # End observeEvent reset_16
  
  
  observeEvent(input$reset_16a, {
    
    #updateSliderInput(inputId="yorkCoSlider1", value=YorkCo1Default)
    #updateSliderInput(inputId="yorkCoSlider2", value=YorkCo2Default)
    updateSliderInput(inputId="yorkCoSlider3", value=YorkCo3Default)
    
  }) # End observeEvent reset_16a
  
  
  observeEvent(input$reset_16b, {
    
    updateSliderInput(inputId="yorkCoSlider4", value=YorkCo4Default)
    updateSliderInput(inputId="yorkCoSlider5", value=YorkCo5Default)
    
  }) # End observeEvent reset_16b
  
  
# These are from the older version that had sliders for 2019 and 2045
  
  # # Get the values from the 2019 % self-employment slider
  # employmentRatioSliderValue2019 <- reactive({
  #   
  #   employment_reduction1 <-  as.numeric(input$employmentReductionSlider1)
  #   
  #   employment_reduction1 <- employment_reduction1 / 100
  #   
  #   employment_reduction1
  # })
  
  
  # Get the values from the 2045 % self-employment slider
  # employmentRatioSliderValue2045 <- reactive({
  #   
  #   employment_reduction2 <-  as.numeric(input$employmentReductionSlider2)
  #   
  #   employment_reduction2 <- employment_reduction2 / 100
  #   
  #   employment_reduction2
  # })
  # 
  
  
  
  # Get the values from the 2045 Wage and Salary % of Total Employment Sliders
  WageAndSalarySliderValue2045 <- reactive({
    
    androscogginWageAndSalaryPercentage2045 <-  as.numeric(input$androscogginCoSlider4)
    
    androscogginWageAndSalaryPercentage2045 <- androscogginWageAndSalaryPercentage2045 / 100
    
    
    
    aroostookWageAndSalaryPercentage2045 <-  as.numeric(input$aroostookCoSlider4)
    
    aroostookWageAndSalaryPercentage2045 <- aroostookWageAndSalaryPercentage2045 / 100
    
    
    
    cumberlandWageAndSalaryPercentage2045 <-  as.numeric(input$cumberlandCoSlider4)
    
    cumberlandWageAndSalaryPercentage2045 <- cumberlandWageAndSalaryPercentage2045 / 100
    
    
    
    franklinWageAndSalaryPercentage2045 <-  as.numeric(input$franklinCoSlider4)
    
    franklinWageAndSalaryPercentage2045 <- franklinWageAndSalaryPercentage2045 / 100
    
    
    
    hancockWageAndSalaryPercentage2045 <-  as.numeric(input$hancockCoSlider4)
    
    hancockWageAndSalaryPercentage2045 <- hancockWageAndSalaryPercentage2045 / 100
    
    
    
    kennebecWageAndSalaryPercentage2045 <-  as.numeric(input$kennebecCoSlider4)
    
    kennebecWageAndSalaryPercentage2045 <- kennebecWageAndSalaryPercentage2045 / 100
    
    
    
    knoxWageAndSalaryPercentage2045 <-  as.numeric(input$knoxCoSlider4)
    
    knoxWageAndSalaryPercentage2045 <- knoxWageAndSalaryPercentage2045 / 100
    
    
    
    lincolnWageAndSalaryPercentage2045 <-  as.numeric(input$lincolnCoSlider4)
    
    lincolnWageAndSalaryPercentage2045 <- lincolnWageAndSalaryPercentage2045 / 100
    
    
    
    oxfordWageAndSalaryPercentage2045 <-  as.numeric(input$oxfordCoSlider4)
    
    oxfordWageAndSalaryPercentage2045 <- oxfordWageAndSalaryPercentage2045 / 100
    
    
    
    penobscotWageAndSalaryPercentage2045 <-  as.numeric(input$penobscotCoSlider4)
    
    penobscotWageAndSalaryPercentage2045 <- penobscotWageAndSalaryPercentage2045 / 100
    
    
    
    piscataquisWageAndSalaryPercentage2045 <-  as.numeric(input$piscataquisCoSlider4)
    
    piscataquisWageAndSalaryPercentage2045 <- piscataquisWageAndSalaryPercentage2045 / 100
    
    
    
    sagadahocWageAndSalaryPercentage2045 <-  as.numeric(input$sagadahocCoSlider4)
    
    sagadahocWageAndSalaryPercentage2045 <- sagadahocWageAndSalaryPercentage2045 / 100
    
    
    
    somersetWageAndSalaryPercentage2045 <-  as.numeric(input$somersetCoSlider4)
    
    somersetWageAndSalaryPercentage2045 <- somersetWageAndSalaryPercentage2045 / 100
    
    
    
    waldoWageAndSalaryPercentage2045 <-  as.numeric(input$waldoCoSlider4)
    
    waldoWageAndSalaryPercentage2045 <- waldoWageAndSalaryPercentage2045 / 100
    
    
    
    washingtonWageAndSalaryPercentage2045 <-  as.numeric(input$washingtonCoSlider4)
    
    washingtonWageAndSalaryPercentage2045 <- washingtonWageAndSalaryPercentage2045 / 100
    
    
    
    yorkWageAndSalaryPercentage2045 <-  as.numeric(input$yorkCoSlider4)
    
    yorkWageAndSalaryPercentage2045 <- yorkWageAndSalaryPercentage2045 / 100
    
    
    revisedWageAndSalaryPercentage2045 <-c(androscogginWageAndSalaryPercentage2045, aroostookWageAndSalaryPercentage2045, cumberlandWageAndSalaryPercentage2045, franklinWageAndSalaryPercentage2045,
                                              hancockWageAndSalaryPercentage2045, kennebecWageAndSalaryPercentage2045, knoxWageAndSalaryPercentage2045,lincolnWageAndSalaryPercentage2045,
                                              oxfordWageAndSalaryPercentage2045, penobscotWageAndSalaryPercentage2045, piscataquisWageAndSalaryPercentage2045, sagadahocWageAndSalaryPercentage2045,
                                              somersetWageAndSalaryPercentage2045, waldoWageAndSalaryPercentage2045, washingtonWageAndSalaryPercentage2045, yorkWageAndSalaryPercentage2045)
    
    revisedWageAndSalaryPercentage2045
    
  })# End of Reactive Get values from 2045 Wage and Salary % of Total Employment Sliders
  
  

  
  # Get the values from the 2045 % Working Two Jobs
  WorkingTwoJobsSliderValue2045 <- reactive({
    
    androscogginWorkingTwoJobs2045 <-  as.numeric(input$androscogginCoSlider5)
    
    androscogginWorkingTwoJobs2045 <- androscogginWorkingTwoJobs2045 / 100
    
    
    
    aroostookWorkingTwoJobs2045 <-  as.numeric(input$aroostookCoSlider5)
    
    aroostookWorkingTwoJobs2045 <- aroostookWorkingTwoJobs2045 / 100
    
    
    
    cumberlandWorkingTwoJobs2045 <-  as.numeric(input$cumberlandCoSlider5)
    
    cumberlandWorkingTwoJobs2045 <- cumberlandWorkingTwoJobs2045 / 100
    
    
    
    franklinWorkingTwoJobs2045 <-  as.numeric(input$franklinCoSlider5)
    
    franklinWorkingTwoJobs2045 <- franklinWorkingTwoJobs2045 / 100
    
    
    
    hancockWorkingTwoJobs2045 <-  as.numeric(input$hancockCoSlider5)
    
    hancockWorkingTwoJobs2045 <- hancockWorkingTwoJobs2045 / 100
    
    
    
    kennebecWorkingTwoJobs2045 <-  as.numeric(input$kennebecCoSlider5)
    
    kennebecWorkingTwoJobs2045 <- kennebecWorkingTwoJobs2045 / 100
    
    
    
    knoxWorkingTwoJobs2045 <-  as.numeric(input$knoxCoSlider5)
    
    knoxWorkingTwoJobs2045 <- knoxWorkingTwoJobs2045 / 100
    
    
    
    lincolnWorkingTwoJobs2045 <-  as.numeric(input$lincolnCoSlider5)
    
    lincolnWorkingTwoJobs2045 <- lincolnWorkingTwoJobs2045 / 100
    
    
    
    oxfordWorkingTwoJobs2045 <-  as.numeric(input$oxfordCoSlider5)
    
    oxfordWorkingTwoJobs2045 <- oxfordWorkingTwoJobs2045 / 100
    
    
    
    penobscotWorkingTwoJobs2045 <-  as.numeric(input$penobscotCoSlider5)
    
    penobscotWorkingTwoJobs2045 <- penobscotWorkingTwoJobs2045 / 100
    
    
    
    piscataquisWorkingTwoJobs2045 <-  as.numeric(input$piscataquisCoSlider5)
    
    piscataquisWorkingTwoJobs2045 <- piscataquisWorkingTwoJobs2045 / 100
    
    
    
    sagadahocWorkingTwoJobs2045 <-  as.numeric(input$sagadahocCoSlider5)
    
    sagadahocWorkingTwoJobs2045 <- sagadahocWorkingTwoJobs2045 / 100
    
    
    
    somersetWorkingTwoJobs2045 <-  as.numeric(input$somersetCoSlider5)
    
    somersetWorkingTwoJobs2045 <- somersetWorkingTwoJobs2045 / 100
    
    
    
    waldoWorkingTwoJobs2045 <-  as.numeric(input$waldoCoSlider5)
    
    waldoWorkingTwoJobs2045 <- waldoWorkingTwoJobs2045 / 100
    
    
    
    washingtonWorkingTwoJobs2045 <-  as.numeric(input$washingtonCoSlider5)
    
    washingtonWorkingTwoJobs2045 <- washingtonWorkingTwoJobs2045 / 100
    
    
    
    yorkWorkingTwoJobs2045 <-  as.numeric(input$yorkCoSlider5)
    
    yorkWorkingTwoJobs2045 <- yorkWorkingTwoJobs2045 / 100
    
    
    revisedWorkingTwoJobs2045 <-c(androscogginWorkingTwoJobs2045, aroostookWorkingTwoJobs2045, cumberlandWorkingTwoJobs2045, franklinWorkingTwoJobs2045,
                                           hancockWorkingTwoJobs2045, kennebecWorkingTwoJobs2045, knoxWorkingTwoJobs2045,lincolnWorkingTwoJobs2045,
                                           oxfordWorkingTwoJobs2045, penobscotWorkingTwoJobs2045, piscataquisWorkingTwoJobs2045, sagadahocWorkingTwoJobs2045,
                                           somersetWorkingTwoJobs2045, waldoWorkingTwoJobs2045, washingtonWorkingTwoJobs2045, yorkWorkingTwoJobs2045)
    
    revisedWorkingTwoJobs2045
    
  })# End of Reactive Get values from 2045 % Working Two Jobs
  
  
  
  
  
  
  
  # Get the values from the 2045 % Population Aged 15+ Sliders
  workingAgePopulationSliderValue2045 <- reactive({
    
    androscogginWorkingAgedPopulation2045 <-  as.numeric(input$androscogginCoSlider1)
    
    androscogginWorkingAgedPopulation2045 <- androscogginWorkingAgedPopulation2045 / 100
    
    
    
    aroostookWorkingAgedPopulation2045 <-  as.numeric(input$aroostookCoSlider1)
    
    aroostookWorkingAgedPopulation2045 <- aroostookWorkingAgedPopulation2045 / 100
    
    
    
    cumberlandWorkingAgedPopulation2045 <-  as.numeric(input$cumberlandCoSlider1)
    
    cumberlandWorkingAgedPopulation2045 <- cumberlandWorkingAgedPopulation2045 / 100
    
    
    
    franklinWorkingAgedPopulation2045 <-  as.numeric(input$franklinCoSlider1)
    
    franklinWorkingAgedPopulation2045 <- franklinWorkingAgedPopulation2045 / 100
    
    
    
    hancockWorkingAgedPopulation2045 <-  as.numeric(input$hancockCoSlider1)
    
    hancockWorkingAgedPopulation2045 <- hancockWorkingAgedPopulation2045 / 100
    
    
    
    kennebecWorkingAgedPopulation2045 <-  as.numeric(input$kennebecCoSlider1)
    
    kennebecWorkingAgedPopulation2045 <- kennebecWorkingAgedPopulation2045 / 100
    
    
    
    knoxWorkingAgedPopulation2045 <-  as.numeric(input$knoxCoSlider1)
    
    knoxWorkingAgedPopulation2045 <- knoxWorkingAgedPopulation2045 / 100
    
    
    
    lincolnWorkingAgedPopulation2045 <-  as.numeric(input$lincolnCoSlider1)
    
    lincolnWorkingAgedPopulation2045 <- lincolnWorkingAgedPopulation2045 / 100
    
    
    
    oxfordWorkingAgedPopulation2045 <-  as.numeric(input$oxfordCoSlider1)
    
    oxfordWorkingAgedPopulation2045 <- oxfordWorkingAgedPopulation2045 / 100
    
    
    
    penobscotWorkingAgedPopulation2045 <-  as.numeric(input$penobscotCoSlider1)
    
    penobscotWorkingAgedPopulation2045 <- penobscotWorkingAgedPopulation2045 / 100
    
    
    
    piscataquisWorkingAgedPopulation2045 <-  as.numeric(input$piscataquisCoSlider1)
    
    piscataquisWorkingAgedPopulation2045 <- piscataquisWorkingAgedPopulation2045 / 100
    
    
    
    sagadahocWorkingAgedPopulation2045 <-  as.numeric(input$sagadahocCoSlider1)
    
    sagadahocWorkingAgedPopulation2045 <- sagadahocWorkingAgedPopulation2045 / 100
    
    
    
    somersetWorkingAgedPopulation2045 <-  as.numeric(input$somersetCoSlider1)
    
    somersetWorkingAgedPopulation2045 <- somersetWorkingAgedPopulation2045 / 100
    
    
    
    waldoWorkingAgedPopulation2045 <-  as.numeric(input$waldoCoSlider1)
    
    waldoWorkingAgedPopulation2045 <- waldoWorkingAgedPopulation2045 / 100
    
    
    
    washingtonWorkingAgedPopulation2045 <-  as.numeric(input$washingtonCoSlider1)
    
    washingtonWorkingAgedPopulation2045 <- washingtonWorkingAgedPopulation2045 / 100
    
    
    
    yorkWorkingAgedPopulation2045 <-  as.numeric(input$yorkCoSlider1)
    
    yorkWorkingAgedPopulation2045 <- yorkWorkingAgedPopulation2045 / 100
    
    
    revisedWorkingAgePopulation2045 <-c(androscogginWorkingAgedPopulation2045, aroostookWorkingAgedPopulation2045, cumberlandWorkingAgedPopulation2045, franklinWorkingAgedPopulation2045,
                                            hancockWorkingAgedPopulation2045, kennebecWorkingAgedPopulation2045, knoxWorkingAgedPopulation2045,lincolnWorkingAgedPopulation2045,
                                            oxfordWorkingAgedPopulation2045, penobscotWorkingAgedPopulation2045, piscataquisWorkingAgedPopulation2045, sagadahocWorkingAgedPopulation2045,
                                            somersetWorkingAgedPopulation2045, waldoWorkingAgedPopulation2045, washingtonWorkingAgedPopulation2045, yorkWorkingAgedPopulation2045)
    
    revisedWorkingAgePopulation2045
  })
  
  
  
  

  # Get the values from the 2045 Workforce Participation % Sliders
  WorkforceParticipationSliderValue2045 <- reactive({
    
    androscogginWorkforceParticipationRate2045 <-  as.numeric(input$androscogginCoSlider2)
    
    androscogginWorkforceParticipationRate2045 <- androscogginWorkforceParticipationRate2045 / 100
    
    
    
    aroostookWorkforceParticipationRate2045 <-  as.numeric(input$aroostookCoSlider2)
    
    aroostookWorkforceParticipationRate2045 <- aroostookWorkforceParticipationRate2045 / 100
    
    
    
    cumberlandWorkforceParticipationRate2045 <-  as.numeric(input$cumberlandCoSlider2)
    
    cumberlandWorkforceParticipationRate2045 <- cumberlandWorkforceParticipationRate2045 / 100
    
    
    
    franklinWorkforceParticipationRate2045 <-  as.numeric(input$franklinCoSlider2)
    
    franklinWorkforceParticipationRate2045 <- franklinWorkforceParticipationRate2045 / 100
    
    
    
    hancockWorkforceParticipationRate2045 <-  as.numeric(input$hancockCoSlider2)
    
    hancockWorkforceParticipationRate2045 <- hancockWorkforceParticipationRate2045 / 100
    
    
    
    kennebecWorkforceParticipationRate2045 <-  as.numeric(input$kennebecCoSlider2)
    
    kennebecWorkforceParticipationRate2045 <- kennebecWorkforceParticipationRate2045 / 100
    
    
    
    knoxWorkforceParticipationRate2045 <-  as.numeric(input$knoxCoSlider2)
    
    knoxWorkforceParticipationRate2045 <- knoxWorkforceParticipationRate2045 / 100
    
    
    
    lincolnWorkforceParticipationRate2045 <-  as.numeric(input$lincolnCoSlider2)
    
    lincolnWorkforceParticipationRate2045 <- lincolnWorkforceParticipationRate2045 / 100
    
    
    
    oxfordWorkforceParticipationRate2045 <-  as.numeric(input$oxfordCoSlider2)
    
    oxfordWorkforceParticipationRate2045 <- oxfordWorkforceParticipationRate2045 / 100
    
    
    
    penobscotWorkforceParticipationRate2045 <-  as.numeric(input$penobscotCoSlider2)
    
    penobscotWorkforceParticipationRate2045 <- penobscotWorkforceParticipationRate2045 / 100
    
    
    
    piscataquisWorkforceParticipationRate2045 <-  as.numeric(input$piscataquisCoSlider2)
    
    piscataquisWorkforceParticipationRate2045 <- piscataquisWorkforceParticipationRate2045 / 100
    
    
    
    sagadahocWorkforceParticipationRate2045 <-  as.numeric(input$sagadahocCoSlider2)
    
    sagadahocWorkforceParticipationRate2045 <- sagadahocWorkforceParticipationRate2045 / 100
    
    
    
    somersetWorkforceParticipationRate2045 <-  as.numeric(input$somersetCoSlider2)
    
    somersetWorkforceParticipationRate2045 <- somersetWorkforceParticipationRate2045 / 100
    
    
    
    waldoWorkforceParticipationRate2045 <-  as.numeric(input$waldoCoSlider2)
    
    waldoWorkforceParticipationRate2045 <- waldoWorkforceParticipationRate2045 / 100
    
    
    
    washingtonWorkforceParticipationRate2045 <-  as.numeric(input$washingtonCoSlider2)
    
    washingtonWorkforceParticipationRate2045 <- washingtonWorkforceParticipationRate2045 / 100
    
    
    
    yorkWorkforceParticipationRate2045 <-  as.numeric(input$yorkCoSlider2)
    
    yorkWorkforceParticipationRate2045 <- yorkWorkforceParticipationRate2045 / 100
    
    
    revisedWorkforceParticipationRate2045 <-c(androscogginWorkforceParticipationRate2045, aroostookWorkforceParticipationRate2045, cumberlandWorkforceParticipationRate2045, franklinWorkforceParticipationRate2045,
                                            hancockWorkforceParticipationRate2045, kennebecWorkforceParticipationRate2045, knoxWorkforceParticipationRate2045,lincolnWorkforceParticipationRate2045,
                                            oxfordWorkforceParticipationRate2045, penobscotWorkforceParticipationRate2045, piscataquisWorkforceParticipationRate2045, sagadahocWorkforceParticipationRate2045,
                                            somersetWorkforceParticipationRate2045, waldoWorkforceParticipationRate2045, washingtonWorkforceParticipationRate2045, yorkWorkforceParticipationRate2045)
    
    revisedWorkforceParticipationRate2045
  })
  
  
  

  
  

  # Get the values from the 2045 % Workforce Outflows Sliders
  workforceOutflowsSliderValue2045 <- reactive({
    
    androscogginWorkforceOutflows2045 <-  as.numeric(input$androscogginCoSlider3)
    
    androscogginWorkforceOutflows2045 <- androscogginWorkforceOutflows2045 / 100
    
    
    
    aroostookWorkforceOutflows2045 <-  as.numeric(input$aroostookCoSlider3)
    
    aroostookWorkforceOutflows2045 <- aroostookWorkforceOutflows2045 / 100
    
    
    
    cumberlandWorkforceOutflows2045 <-  as.numeric(input$cumberlandCoSlider3)
    
    cumberlandWorkforceOutflows2045 <- cumberlandWorkforceOutflows2045 / 100
    
    
    
    franklinWorkforceOutflows2045 <-  as.numeric(input$franklinCoSlider3)
    
    franklinWorkforceOutflows2045 <- franklinWorkforceOutflows2045 / 100
    
    
    
    hancockWorkforceOutflows2045 <-  as.numeric(input$hancockCoSlider3)
    
    hancockWorkforceOutflows2045 <- hancockWorkforceOutflows2045 / 100
    
    
    
    kennebecWorkforceOutflows2045 <-  as.numeric(input$kennebecCoSlider3)
    
    kennebecWorkforceOutflows2045 <- kennebecWorkforceOutflows2045 / 100
    
    
    
    knoxWorkforceOutflows2045 <-  as.numeric(input$knoxCoSlider3)
    
    knoxWorkforceOutflows2045 <- knoxWorkforceOutflows2045 / 100
    
    
    
    lincolnWorkforceOutflows2045 <-  as.numeric(input$lincolnCoSlider3)
    
    lincolnWorkforceOutflows2045 <- lincolnWorkforceOutflows2045 / 100
    
    
    
    oxfordWorkforceOutflows2045 <-  as.numeric(input$oxfordCoSlider3)
    
    oxfordWorkforceOutflows2045 <- oxfordWorkforceOutflows2045 / 100
    
    
    
    penobscotWorkforceOutflows2045 <-  as.numeric(input$penobscotCoSlider3)
    
    penobscotWorkforceOutflows2045 <- penobscotWorkforceOutflows2045 / 100
    
    
    
    piscataquisWorkforceOutflows2045 <-  as.numeric(input$piscataquisCoSlider3)
    
    piscataquisWorkforceOutflows2045 <- piscataquisWorkforceOutflows2045 / 100
    
    
    
    sagadahocWorkforceOutflows2045 <-  as.numeric(input$sagadahocCoSlider3)
    
    sagadahocWorkforceOutflows2045 <- sagadahocWorkforceOutflows2045 / 100
    
    
    
    somersetWorkforceOutflows2045 <-  as.numeric(input$somersetCoSlider3)
    
    somersetWorkforceOutflows2045 <- somersetWorkforceOutflows2045 / 100
    
    
    
    waldoWorkforceOutflows2045 <-  as.numeric(input$waldoCoSlider3)
    
    waldoWorkforceOutflows2045 <- waldoWorkforceOutflows2045 / 100
    
    
    
    washingtonWorkforceOutflows2045 <-  as.numeric(input$washingtonCoSlider3)
    
    washingtonWorkforceOutflows2045 <- washingtonWorkforceOutflows2045 / 100
    
    
    
    yorkWorkforceOutflows2045 <-  as.numeric(input$yorkCoSlider3)
    
    yorkWorkforceOutflows2045 <- yorkWorkforceOutflows2045 / 100
    
    
    revisedWorkforceOutflows2045 <-c(androscogginWorkforceOutflows2045, aroostookWorkforceOutflows2045, cumberlandWorkforceOutflows2045, franklinWorkforceOutflows2045,
                                            hancockWorkforceOutflows2045, kennebecWorkforceOutflows2045, knoxWorkforceOutflows2045,lincolnWorkforceOutflows2045,
                                            oxfordWorkforceOutflows2045, penobscotWorkforceOutflows2045, piscataquisWorkforceOutflows2045, sagadahocWorkforceOutflows2045,
                                            somersetWorkforceOutflows2045, waldoWorkforceOutflows2045, washingtonWorkforceOutflows2045, yorkWorkforceOutflows2045)
    
    revisedWorkforceOutflows2045
  })
  
  


  
  ## Here we load the 2045 Population forecast, age structure, and calculate the workforce aged population in 2045
  
  population_forecast <- read.csv(file="Tables/1_maine_county_population_forecast_2045.csv", head=TRUE,sep=",")
  age_structure <- read.csv(file="Tables/2_maine_county_age_structure_2045.csv", head=TRUE,sep=",")
  
  population_forecast <- cbind(population_forecast,age_structure$Population_Age_15_and_Over)
  
  working_age_population <- population_forecast$Forecast_2045_Population * age_structure$Population_Age_15_and_Over
  
  working_age_population <- cbind(population_forecast, working_age_population)
  
  #colnames(working_age_population) <- c("County", "Census 2020 Population", "Forecast 2045 Population", "% of Population Age 15 and Over in 2045", "Working_Age_Population_2045")
  
  
  ## Here we load the 2045 Employment forecast, and we adjust employment based on the user-defined self-employment ratios
  
  employment_forecast <- read.csv(file="Tables/4_maine_county_employment_forecast_2045.csv", head=TRUE,sep=",")

  
  # Here we load the 2019 County Workforce Flows from Census on the Map
  
  county_workforce_flows_2019 <- read.csv(file="Tables/3_maine_county_workforce_flows_2019.csv", head=TRUE,sep=",")
  
  
  # Here we load the 2019 County Workforce Participation Rates from Census ACS 5-year sample
  
  county_workforce_participation_2019 <- read.csv(file="Tables/5_maine_county_workforce_participation_rate_2019.csv", head=TRUE,sep=",")
  
  
  
  adjustEmploymentForecast <- reactive({
    
    # These were used in an earlier version, where we had just one slider for all of Maine in 2019 and 2045
    # self_employment_ratio_1 <- employmentRatioSliderValue2019()
    # self_employment_ratio_2 <- employmentRatioSliderValue2045()
    
    self_employment_ratio_2 <- WageAndSalarySliderValue2045()
    
    two_jobs_percentage <- WorkingTwoJobsSliderValue2045()
    
    
    employment_forecast <- data.frame(employment_forecast)
    
    #names(employment_forecast) <- c('County', 'Census_2019_WS_Employment', 'PCT_2019_Wage_Salary', 'WP_2019_Jobs', 'WP_2045_Jobs')
    
    
    names(employment_forecast) <- c('County','Census_2019_WS_Employment','BEA_2019_Total_Employment','BEA_2019_WS_Employment','BEA_2019_Self_Employment','BEA_2019_Other_Employment','WP_2019_Jobs','WP_2019_Other_Employment','PCT_2019_Wage_Salary_Employment','PCT_2019_Self_Employment','PCT_2019_BEA_Other_Employment','PCT_2019_WP_Other_Employment','WP_2045_Jobs')
    
    # These versions were used with state wide self-employment sliders for 2019 and 2045
    # WP_2019_Jobs_Adjusted <- employment_forecast$WP_2019_Jobs / ( 1 + self_employment_ratio_1)
    
    # WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs / ( 1 + self_employment_ratio_2)
    
    WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs * self_employment_ratio_2
    
    two_jobs_reduction <- two_jobs_percentage * WP_2045_Jobs_Adjusted
    
    WP_2045_Jobs_Adjusted2 <- WP_2045_Jobs_Adjusted - two_jobs_reduction
    
    employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, employment_forecast$WP_2045_Jobs, self_employment_ratio_2, two_jobs_percentage, WP_2045_Jobs_Adjusted, WP_2045_Jobs_Adjusted2)
    
    # This was used in the version that has WP_2019_Jobs_Adjusted
    # employment_forecast <-cbind(employment_forecast$County, employment_forecast$Census_2019_WS_Employment, employment_forecast$PCT_2019_Wage_Salary, employment_forecast$WP_2019_Jobs, employment_forecast$WP_2045_Jobs, WP_2019_Jobs_Adjusted, WP_2045_Jobs_Adjusted)
    
    
    #employment_forecast <-cbind(employment_forecast,WP_2045_Jobs_Adjusted)
    
    employment_forecast
    
  })
  
  
  adjustWorkforcePopulation <- reactive({
    
    #employment_forecast <- adjustEmploymentForecast()
    
    revised_working_age_population_2045_PCT <- workingAgePopulationSliderValue2045()
    revised_workforce_participation_rate_2045 <- WorkforceParticipationSliderValue2045()
    
    revised_employment_forecast <- cbind(employment_forecast, revised_working_age_population_2045_PCT, revised_workforce_participation_rate_2045)
    
    revised_working_age_population_2045 <- population_forecast$Forecast_2045_Population * revised_employment_forecast$revised_working_age_population_2045
    
    revised_county_workforce_2045 <- revised_working_age_population_2045 * revised_employment_forecast$revised_workforce_participation_rate_2045
    
    output_employment_forecast <-cbind(population_forecast$County, population_forecast$Forecast_2045_Population, revised_working_age_population_2045, revised_county_workforce_2045, revised_working_age_population_2045_PCT, revised_workforce_participation_rate_2045)
    
    colnames(output_employment_forecast) <- c('County', 'Forecast_2045_Population', 'revised_working_age_population_2045', 'revised_county_workforce_2045', 'revised_working_age_population_2045_PCT', 'revised_workforce_participation_rate_2045')
    
    output_employment_forecast
    
    
  })
  
  
  adjustCountyOutflows <- reactive({
    
    
    employment_forecast <- data.frame(adjustEmploymentForecast())
    
    revisedWorkforce <- data.frame(adjustWorkforcePopulation())
    
    # tripTable <- generateTripTable()
    
    # workforceTotal <- tripTable[,17]
    
    revised_workforce_outflows_2045 <- workforceOutflowsSliderValue2045()
    
    #revised_county_workforce <- revisedWorkforce$revised_county_workforce_2045
    
    revised_workforce_forecast <- data.frame(cbind(revisedWorkforce$County, employment_forecast$WP_2045_Jobs_Adjusted2, revisedWorkforce$revised_county_workforce_2045, revised_workforce_outflows_2045))
    
    names(revised_workforce_forecast) <- c('County', 'County_Employment_2045', 'County_Workforce_2045', 'Pct_Workforce_outflows_2045')
    
    #revised_workforce_forecast <- cbind(revised_county_workforce, revised_workforce_outflows_2045)
    
    #revised_workforce_forecast <- cbind(revisedWorkforce, revised_workforce_outflows_2045)
    
    revised_county_workforce_outflows_2045 <- as.numeric(revised_workforce_forecast$County_Workforce_2045) * as.numeric(revised_workforce_forecast$Pct_Workforce_outflows_2045)
    
    revised_county_workforce_locals_2045 <- as.numeric(revised_workforce_forecast$County_Workforce_2045) - as.numeric(revised_county_workforce_outflows_2045)
    
    employment_balance <- as.numeric(revised_workforce_forecast$County_Employment_2045) - as.numeric(revised_county_workforce_locals_2045)
    
    #revised_workforce_forecast <- cbind(revised_workforce_forecast, revised_county_workforce_outflows_2045)
    
    revised_workforce_forecast <- cbind(revised_workforce_forecast, revised_county_workforce_outflows_2045, revised_county_workforce_locals_2045, employment_balance)
    
    #names(revised_workforce_forecast) <- c('County', 'County Employment 2045', 'County Workforce 2045', 'Pct Workforce Outflows 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045')
    
    revised_workforce_forecast
    
    
    #colnames(revisedWorkforce) <- c('County', 'Forecast_2045_Population', 'revised_working_age_population_2045', 'revised_county_workforce_2045')
    
    
    
  })


  generateTripTable <- reactive({
    
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
    
    
    
  }) # End generateTripTable Reactive
 			
  
  
  # Here we render a data table showing the baseline and adjusted employment forecasts, adjusted based on user-input
  # New Version
  
  output$employmentForecast2 <- DT::renderDataTable(DT::datatable(caption = 'Table 1: Employment Forecast for 2045.',{
    
    
    employment_forecast3 <- adjustEmploymentForecast()
  
    colnames(employment_forecast3) <- c('County', '2019 Census Wage & Salary Employment', '2019 PCT Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', '2045 PCT Wage & Salary Employment', '2045 PCT Two Jobs', 'WP 2045 Wage and Salary Jobs', 'WP 2045 Wage and Salary Jobs Minus 2 Jobs')
    
    # This version was used when 2019 Jobs Adjusted is included
    # colnames(employment_forecast3) <- c('County', '2019 Census Wage & Salary Employment', '2019 PCT Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', 'WP 2019 Jobs Adjusted', 'WP 2045 Jobs Adjusted')
    
    employment_forecast3
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Employment Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Employment Forecast 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('2019 Census Wage & Salary Employment', 'WP 2019 Jobs',  'WP 2045 Jobs', 'WP 2045 Wage and Salary Jobs', 'WP 2045 Wage and Salary Jobs Minus 2 Jobs'), 0)
  
  %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2045 PCT Wage & Salary Employment', '2045 PCT Two Jobs'),1)
  
  # %>% formatRound(c('2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment',  'WP 2045 Jobs', 'WP 2019 Jobs Adjusted', 'WP 2045 Jobs Adjusted'), 0)
  
  # %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment'),1)
  
  
  
  )
  
  
  
  # Here we render a data table showing the baseline employment forecasts in a separate tab
  
  output$employmentForecast3 <- DT::renderDataTable(DT::datatable(caption = 'Table 1: 2019 Employment Data Compared to Woods and Poole Employment Forecast for 2045.',{
    
    
    #employment_forecast <- adjustEmploymentForecast()
    
    colnames(employment_forecast) <- c('County', '2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment', '2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment', 'WP 2045 Jobs')
    
    employment_forecast
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Employment Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Employment Forecast 2045 Revision 1'))))
  ) %>% formatRound(c('2019 Census Wage & Salary Employment', '2019 BEA Total Employment', '2019 BEA Wage & Salary Employment', '2019 BEA Self-Employment', '2019 BEA Other Employment', 'WP 2019 Jobs', '2019 WP Other Employment',  'WP 2045 Jobs'), 0)
  
  %>% formatPercentage(c('2019 PCT Census Wage & Salary Employment', '2019 PCT Self-Employment', '2019 PCT BEA Other Employment',	'2019 PCT WP Other Employment'),1)
  
  
  
  )
  
  
  
  # Here we render a data table showing the baseline and adjusted workforce forecasts, adjusted based on user-input
  # New Version
  
  output$workforceForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 2: Workforce Forecast for 2045.',{
    
    
    workforce_forecast <- adjustWorkforcePopulation()
    
    colnames(workforce_forecast) <- c('County', 'WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045', 'Revised % Working Age Population 2045', 'Revised Workforce Participation Rate 2045')
    
    workforce_forecast
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Forecast 2045 Revision 1'))))
  ) %>% formatRound(c('WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045'), 0)
  
  %>% formatPercentage(c('Revised % Working Age Population 2045', 'Revised Workforce Participation Rate 2045'),1)
  
  )
  
  
  
  # Here we render a data table showing the baseline and adjusted county flows, adjusted based on user-input
  # New Version
  
  output$countyFlows <- DT::renderDataTable(DT::datatable(caption = 'Table 3: County Outflows and Inflows for 2045.',{
    
    
    county_flows <- adjustCountyOutflows()
    
    names(county_flows) <- c('County', 'County Employment 2045', 'County Workforce 2045', 'Pct Workforce Outflows 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045')
    
    #colnames(county_flows) <- c('County', 'Workforce Population 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045')
    
    county_flows
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
   %>% formatRound(c('County Employment 2045', 'County Workforce 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045'), 0) 
  
  %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  )
  
  
 # 'County', 'County Employment 2045', 'County Workforce 2045', 'Pct Workforce Outflows 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'Employment Balance 2045'
  
  
  
  
  
  
  output$tripMatrix2 <- DT::renderDataTable(DT::datatable(caption = 'Table 4: Trip Matrix for 2045.',{
    
    
    outflow_trips <- generateTripTable()
    

    
    outflow_trips
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
  %>% formatRound(c('Androscoggin Origins', 'Aroostook Origins', 'Cumberland Origins', 'Franklin Origins', 'Hancock Origins', 'Kennebec Origins', 'Knox Origins', 'Lincoln Origins', 'Oxford Origins', 'Penobscot Origins', 'Piscataquis Origins', 'Sagadahoc Origins', 'Somerset Origins', 'Waldo Origins', 'Washington Origins', 'York Origins', 'Total Destinations'), 0) 
  
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  )
  
  # Here we render a data table showing county trip tables
  # New Version
  
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
  
  
  output$balance <- DT::renderDataTable(DT::datatable(caption = 'Table 5: Employment:Workforce Balance for 2045.',{
    
    countyFlows <- adjustCountyOutflows()
    
    outflowTrips <- generateTripTable()
    
    #county <- rownames(outflowTrips)
    
    countyEmployment <- countyFlows[,2]
    
    countyLocals <- countyFlows[,6]
    
    ttEmploymentTotals <- outflowTrips[1:16,17]
    
    countyInflows <- as.numeric(ttEmploymentTotals) - as.numeric(countyLocals)
    
    balance <- as.numeric(countyEmployment) - as.numeric(ttEmploymentTotals)
    
    balanceTable <- cbind(countyEmployment, ttEmploymentTotals, countyLocals, countyInflows, balance)
    
    colnames(balanceTable) <- c('2045 Employment Forecast', '2045 Available Workforce', '2045 Local Workers', '2045 Inflows', 'Balance (Employment-Workforce)')
    
    balanceTable
    
    
    
    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Workforce Outflows 2045 Revision 1')),list(list(extend = 'excel', filename= 'Workforce Outflows 2045 Revision 1'))))
  ) 
  
   %>% formatRound(c('2045 Employment Forecast', '2045 Available Workforce', '2045 Local Workers', '2045 Inflows', 'Balance (Employment-Workforce)'), 0) 
  
  
  # %>% formatRound(c('Androscoggin', 'Aroostook', 'Cumberland', 'Franklin', 'Hancock', 'Kennebec', 'Knox', 'Lincoln', 'Oxford', 'Penobscot', 'Piscataquis', 'Sagadahoc', 'Somerset', 'Waldo', 'Washington', 'York'), 0) 
  
  # %>% formatPercentage('Pct Workforce Outflows 2045',1)
  
  )
  
  
  
  # Here we render a data table showing the baseline and adjusted employment forecasts, adjusted based on user-input
  
  output$employmentForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 1: Workforce and Employment Forecast for 2045.',{
    
    
    # We are turning this code block into standalone function
    # self_employment_ratio_1 <- employmentRatioSliderValue2019()
    # self_employment_ratio_2 <- employmentRatioSliderValue2045()
    # 
    # WP_2019_Jobs_Adjusted <- employment_forecast$WP_2019_Jobs / ( 1+ self_employment_ratio_1)
    # employment_forecast <-cbind(employment_forecast,WP_2019_Jobs_Adjusted)
    # 
    # WP_2045_Jobs_Adjusted <- employment_forecast$WP_2045_Jobs / ( 1+ self_employment_ratio_2)
    # employment_forecast <-cbind(employment_forecast,WP_2045_Jobs_Adjusted)
    
    employment_forecast <- adjustEmploymentForecast()

    # We are turning this code into one standalone function
    revised_working_age_population_2045 <- workingAgePopulationSliderValue2045()
    revised_workforce_participation_rate_2045 <- WorkforceParticipationSliderValue2045()
    
    # This code will go into a different standalone function
    revised_workforce_outflows_2045 <- workforceOutflowsSliderValue2045()
    
    revised_employment_forecast <- cbind(employment_forecast, revised_working_age_population_2045, revised_workforce_participation_rate_2045, revised_workforce_outflows_2045)
    
    # revisedWorkingAgePopulation2045
    # revisedWorkforceParticipationRate2045
    # revisedWorkforceOutflows2045
    
    revised_working_age_population_2045 <- population_forecast$Forecast_2045_Population * revised_employment_forecast$revised_working_age_population_2045
    
    revised_county_workforce_2045 <- revised_working_age_population_2045 * revised_employment_forecast$revised_workforce_participation_rate_2045
    
    #county_workforce_2045 <- working_age_population$Working_Age_Population_2045 * county_workforce_participation_2019$Workforce_Participation_Rate_2019
    
    
    revised_county_workforce_outflows_2045 <- revised_county_workforce_2045 * revised_employment_forecast$revised_workforce_outflows_2045
    
    revised_county_workforce_locals_2045 <- revised_county_workforce_2045 - revised_county_workforce_outflows_2045
    
    
    # county_workforce_outflows_2045 <- county_workforce_2045 * county_workforce_flows_2019$Workforce_Percent_Outflows
    
    # county_workforce_locals_2045 <- county_workforce_2045 * county_workforce_flows_2019$Workforce_Percent_Locals
    
    
    revised_county_employment_locals_2045 <- revised_county_workforce_locals_2045
    
    revised_county_employment_inflows_2045 <- revised_employment_forecast$WP_2045_Jobs_Adjusted - revised_county_employment_locals_2045
    
    
    # county_employment_locals_2045 <- county_workforce_locals_2045
    
    # county_employment_inflows_2045 <- employment_forecast$WP_2045_Jobs_Adjusted - county_employment_locals_2045
    
    total_employment_inflows <- sum(revised_county_employment_inflows_2045)
      
    total_workforce_outflows <- sum(revised_county_workforce_outflows_2045)
    
    net_migration <- total_employment_inflows - total_workforce_outflows
    
    output_employment_forecast <-cbind(employment_forecast, population_forecast$Forecast_2045_Population, revised_working_age_population_2045, revised_county_workforce_2045, revised_county_workforce_outflows_2045, revised_county_workforce_locals_2045, revised_county_employment_locals_2045, revised_county_employment_inflows_2045, total_employment_inflows, total_workforce_outflows, net_migration)

    colnames(output_employment_forecast) <- c('County', 'WP 2019 Jobs', 'WP 2045 Jobs', 'WP 2019 Jobs Adjusted', 'WP 2045 Jobs Adjusted', 'WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045','County Workforce Outflows 2045', 'County Workforce Locals 2045', 'County Employment Locals 2045', 'County Employment Inflows 2045', 'Total Employment Inflows', 'Total Workforce Outflows', 'Maine Net In-migration')
    
    output_employment_forecast
    


    
  }, extensions = 'Buttons', 
  options = list(paging= FALSE, dom = 'Bfrtip', buttons = c('copy', 'pdf', list(list(extend = 'csv', filename= 'Employment Forecast 2045 Revision 1')),list(list(extend = 'excel', filename= 'Employment Forecast 2045 Revision 1'))))
  ) %>% formatRound(c('WP 2019 Jobs','WP 2045 Jobs','WP 2019 Jobs Adjusted','WP 2045 Jobs Adjusted', 'WP 2045 Population', 'Working Age Population 2045', 'Workforce Population 2045', 'Workforce Population 2045', 'County Workforce Outflows 2045', 'County Workforce Locals 2045', 'County Employment Locals 2045', 'County Employment Inflows 2045', 'Total Employment Inflows', 'Total Workforce Outflows', 'Maine Net In-migration'), 0))
  

  
  ## Here we will render a data table with the 2045 Population Forecast and Workforce-Aged Population
  
  output$populationForecast <- DT::renderDataTable(DT::datatable(caption = 'Table 1: Woods and Poole Population Forecast for 2045, based on 2020 Census.',{
    
    colnames(working_age_population) <- c("County", "Census 2020 Population", "Forecast 2045 Population", "% of Population Age 15 and Over in 2045", "Working Age Population 2045")
    
    
    working_age_population
  }, options = list(paging = FALSE))%>% formatRound(c('Census 2020 Population','Forecast 2045 Population', 'Working Age Population 2045'), 0) %>% formatPercentage('% of Population Age 15 and Over in 2045',1))
  
  
  
  ## Here we will render a data table showing the age structure in 2045
  
  output$ageStructure2045 <- DT::renderDataTable(DT::datatable(caption = 'Table 2: Age Structure in 2045.',{
    #age_structure <- read.csv(file="Tables/2_maine_county_age_structure_2045.csv", head=TRUE,sep=",")
    
    colnames(age_structure) <- c('County', 'Population Age 15 to 74','Population Age 75 and Over','Population Age 15 and Over')
    
    age_structure 
  }, options = list(paging = FALSE))%>% formatPercentage(c('Population Age 15 to 74','Population Age 75 and Over','Population Age 15 and Over'), 1))
  
  
  
  ## Here we will render a data table showing the county inflows and outflows in 2019 
  
  output$countyWorkflows2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 4: County Workforce Inflows and Outflows in 2019.',{
    
    colnames(county_workforce_flows_2019) <- c('County','Employment Percent Inflows','Employment Percent Locals','Workforce Percent Outflows','Workforce Percent Locals')
    
    
    county_workforce_flows_2019
  }, options = list(paging = FALSE))%>% formatPercentage(c('Employment Percent Inflows','Employment Percent Locals','Workforce Percent Outflows','Workforce Percent Locals'), 1))
  
  
  
  ## Here we will render a data table showing the county workforce participation in 2019 
  
  output$countyWorkforce2019 <- DT::renderDataTable(DT::datatable(caption = 'Table 5: County Workforce Participation Rates in 2019.',{
    
    colnames(county_workforce_participation_2019) <- c('County', 'Labor Force Participation Rate 2019')
    county_workforce_participation_2019
    
  }, options = list(paging = FALSE))%>% formatPercentage('Labor Force Participation Rate 2019', 1))
  
  
  
  
  ## Used for testing purposes. We can delete later
  
  # output$test <- DT::renderDataTable(DT::datatable(caption = 'Table 5: County Workforce Participation Rates in 2019.',{
  #   
  #   #colnames(county_workforce_participation_2019) <- c('County', 'Labor Force Participation Rate 2019')
  #   
  #   workingAgePopulation2045 <- workingAgePopulationSliderValue2045()
  #   
  #   workingAgePopulation2045
  #   
  # }, options = list(paging = FALSE)))
  
  

  
  

  
}

