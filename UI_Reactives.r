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



###############################################################################
# Define UI Reactives
###############################################################################

# Update Sliders When Reset Button Pressed

observeEvent(input$reset_1, {
  
  updateSliderInput(inputId="androscogginCoSlider1", value=AndroCo1Default)
  updateSliderInput(inputId="androscogginCoSlider2", value=AndroCo2Default)
  
}) # End observeEvent reset_1


observeEvent(input$reset_1a, {
  
  updateSliderInput(inputId="androscogginCoSlider3", value=AndroCo3Default)
  
}) # End observeEvent reset_1a


observeEvent(input$reset_1b, {
  
  updateSliderInput(inputId="androscogginCoSlider4", value=AndroCo4Default)
  #updateSliderInput(inputId="androscogginCoSlider5", value=AndroCo5Default)
  
}) # End observeEvent reset_1b


observeEvent(input$reset_1c, {
  
  #updateSliderInput(inputId="androscogginCoSlider4", value=AndroCo4Default)
  updateSliderInput(inputId="androscogginCoSlider5", value=AndroCo5Default)
  
}) # End observeEvent reset_1c


observeEvent(input$reset_2, {
  
  updateSliderInput(inputId="hancockCoSlider1", value=HancockCo1Default)
  updateSliderInput(inputId="hancockCoSlider2", value=HancockCo2Default)
  
}) # End observeEvent reset_2

observeEvent(input$reset_2a, {
  
  updateSliderInput(inputId="hancockCoSlider3", value=HancockCo3Default)
  
}) # End observeEvent reset_2a


observeEvent(input$reset_2b, {
  
  updateSliderInput(inputId="hancockCoSlider4", value=HancockCo4Default)
  #updateSliderInput(inputId="hancockCoSlider5", value=HancockCo5Default)
  
}) # End observeEvent reset_2b


observeEvent(input$reset_2c, {
  
  #updateSliderInput(inputId="hancockCoSlider4", value=HancockCo4Default)
  updateSliderInput(inputId="hancockCoSlider5", value=HancockCo5Default)
  
}) # End observeEvent reset_2c


observeEvent(input$reset_3, {
  
  updateSliderInput(inputId="oxfordCoSlider1", value=OxfordCo1Default)
  updateSliderInput(inputId="oxfordCoSlider2", value=OxfordCo2Default)
  
}) # End observeEvent reset_3


observeEvent(input$reset_3a, {
  
  updateSliderInput(inputId="oxfordCoSlider3", value=OxfordCo3Default)
  
}) # End observeEvent reset_3a


observeEvent(input$reset_3b, {
  
  updateSliderInput(inputId="oxfordCoSlider4", value=OxfordCo4Default)
  #updateSliderInput(inputId="oxfordCoSlider5", value=OxfordCo5Default)
  
}) # End observeEvent reset_3b


observeEvent(input$reset_3c, {
  
  #updateSliderInput(inputId="oxfordCoSlider4", value=OxfordCo4Default)
  updateSliderInput(inputId="oxfordCoSlider5", value=OxfordCo5Default)
  
}) # End observeEvent reset_3c


observeEvent(input$reset_4, {
  
  updateSliderInput(inputId="somersetCoSlider1", value=SomerCo1Default)
  updateSliderInput(inputId="somersetCoSlider2", value=SomerCo2Default)
  
}) # End observeEvent reset_4


observeEvent(input$reset_4a, {
  
  updateSliderInput(inputId="somersetCoSlider3", value=SomerCo3Default)
  
}) # End observeEvent reset_4a


observeEvent(input$reset_4b, {
  
  updateSliderInput(inputId="somersetCoSlider4", value=SomerCo4Default)
  #updateSliderInput(inputId="somersetCoSlider5", value=SomerCo5Default)
  
}) # End observeEvent reset_4b


observeEvent(input$reset_4c, {
  
  #updateSliderInput(inputId="somersetCoSlider4", value=SomerCo4Default)
  updateSliderInput(inputId="somersetCoSlider5", value=SomerCo5Default)
  
}) # End observeEvent reset_4c


observeEvent(input$reset_5, {
  
  updateSliderInput(inputId="aroostookCoSlider1", value=AroostCo1Default)
  updateSliderInput(inputId="aroostookCoSlider2", value=AroostCo2Default)
  
}) # End observeEvent reset_5


observeEvent(input$reset_5a, {
  
  updateSliderInput(inputId="aroostookCoSlider3", value=AroostCo3Default)
  
}) # End observeEvent reset_5a


observeEvent(input$reset_5b, {
  
  updateSliderInput(inputId="aroostookCoSlider4", value=AroostCo4Default)
  #updateSliderInput(inputId="aroostookCoSlider5", value=AroostCo5Default)
  
}) # End observeEvent reset_5b


observeEvent(input$reset_5c, {
  
  #updateSliderInput(inputId="aroostookCoSlider4", value=AroostCo4Default)
  updateSliderInput(inputId="aroostookCoSlider5", value=AroostCo5Default)
  
}) # End observeEvent reset_5c


observeEvent(input$reset_6, {
  
  updateSliderInput(inputId="kennebecCoSlider1", value=KennebCo1Default)
  updateSliderInput(inputId="kennebecCoSlider2", value=KennebCo2Default)
  
}) # End observeEvent reset_6


observeEvent(input$reset_6a, {
  
  updateSliderInput(inputId="kennebecCoSlider3", value=KennebCo3Default)
  
}) # End observeEvent reset_6a


observeEvent(input$reset_6b, {
  
  updateSliderInput(inputId="kennebecCoSlider4", value=KennebCo4Default)
  #updateSliderInput(inputId="kennebecCoSlider5", value=KennebCo5Default)
  
}) # End observeEvent reset_6b


observeEvent(input$reset_6c, {
  
  #updateSliderInput(inputId="kennebecCoSlider4", value=KennebCo4Default)
  updateSliderInput(inputId="kennebecCoSlider5", value=KennebCo5Default)
  
}) # End observeEvent reset_6c


observeEvent(input$reset_7, {
  
  updateSliderInput(inputId="penobscotCoSlider1", value=PenobCo1Default)
  updateSliderInput(inputId="penobscotCoSlider2", value=PenobCo2Default)
  
}) # End observeEvent reset_7


observeEvent(input$reset_7a, {
  
  updateSliderInput(inputId="penobscotCoSlider3", value=PenobCo3Default)
  
}) # End observeEvent reset_7a


observeEvent(input$reset_7b, {
  
  updateSliderInput(inputId="penobscotCoSlider4", value=PenobCo4Default)
  #updateSliderInput(inputId="penobscotCoSlider5", value=PenobCo5Default)
  
}) # End observeEvent reset_7b


observeEvent(input$reset_7c, {
  
  #updateSliderInput(inputId="penobscotCoSlider4", value=PenobCo4Default)
  updateSliderInput(inputId="penobscotCoSlider5", value=PenobCo5Default)
  
}) # End observeEvent reset_7c


observeEvent(input$reset_8, {
  
  updateSliderInput(inputId="waldoCoSlider1", value=WaldoCo1Default)
  updateSliderInput(inputId="waldoCoSlider2", value=WaldoCo2Default)
  
}) # End observeEvent reset_8


observeEvent(input$reset_8a, {
  
  updateSliderInput(inputId="waldoCoSlider3", value=WaldoCo3Default)
  
}) # End observeEvent reset_8a


observeEvent(input$reset_8b, {
  
  updateSliderInput(inputId="waldoCoSlider4", value=WaldoCo4Default)
  #updateSliderInput(inputId="waldoCoSlider5", value=WaldoCo5Default)
  
}) # End observeEvent reset_8b


observeEvent(input$reset_8c, {
  
  #updateSliderInput(inputId="waldoCoSlider4", value=WaldoCo4Default)
  updateSliderInput(inputId="waldoCoSlider5", value=WaldoCo5Default)
  
}) # End observeEvent reset_8c


observeEvent(input$reset_9, {
  
  updateSliderInput(inputId="cumberlandCoSlider1", value=CumberCo1Default)
  updateSliderInput(inputId="cumberlandCoSlider2", value=CumberCo2Default)
  
}) # End observeEvent reset_9


observeEvent(input$reset_9a, {
  
  updateSliderInput(inputId="cumberlandCoSlider3", value=CumberCo3Default)
  
}) # End observeEvent reset_9a


observeEvent(input$reset_9b, {
  
  updateSliderInput(inputId="cumberlandCoSlider4", value=CumberCo4Default)
  #updateSliderInput(inputId="cumberlandCoSlider5", value=CumberCo5Default)
  
}) # End observeEvent reset_9b


observeEvent(input$reset_9c, {
  
  #updateSliderInput(inputId="cumberlandCoSlider4", value=CumberCo4Default)
  updateSliderInput(inputId="cumberlandCoSlider5", value=CumberCo5Default)
  
}) # End observeEvent reset_9c


observeEvent(input$reset_10, {
  
  updateSliderInput(inputId="knoxCoSlider1", value=KnoxCo1Default)
  updateSliderInput(inputId="knoxCoSlider2", value=KnoxCo2Default)
  
}) # End observeEvent reset_10


observeEvent(input$reset_10a, {
  
  updateSliderInput(inputId="knoxCoSlider3", value=KnoxCo3Default)
  
}) # End observeEvent reset_10a


observeEvent(input$reset_10b, {
  
  updateSliderInput(inputId="knoxCoSlider4", value=KnoxCo4Default)
  #updateSliderInput(inputId="knoxCoSlider5", value=KnoxCo5Default)
  
}) # End observeEvent reset_10b


observeEvent(input$reset_10c, {
  
  #updateSliderInput(inputId="knoxCoSlider4", value=KnoxCo4Default)
  updateSliderInput(inputId="knoxCoSlider5", value=KnoxCo5Default)
  
}) # End observeEvent reset_10c


observeEvent(input$reset_11, {
  
  updateSliderInput(inputId="piscataquisCoSlider1", value=PiscatCo1Default)
  updateSliderInput(inputId="piscataquisCoSlider2", value=PiscatCo2Default)
  
}) # End observeEvent reset_11


observeEvent(input$reset_11a, {
  
  updateSliderInput(inputId="piscataquisCoSlider3", value=PiscatCo3Default)
  
}) # End observeEvent reset_11a


observeEvent(input$reset_11b, {
  
  updateSliderInput(inputId="piscataquisCoSlider4", value=PiscatCo4Default)
  #updateSliderInput(inputId="piscataquisCoSlider5", value=PiscatCo5Default)
  
}) # End observeEvent reset_11b


observeEvent(input$reset_11c, {
  
  #updateSliderInput(inputId="piscataquisCoSlider4", value=PiscatCo4Default)
  updateSliderInput(inputId="piscataquisCoSlider5", value=PiscatCo5Default)
  
}) # End observeEvent reset_11c


observeEvent(input$reset_12, {
  
  updateSliderInput(inputId="washingtonCoSlider1", value=WashinCo1Default)
  updateSliderInput(inputId="washingtonCoSlider2", value=WashinCo2Default)
  
}) # End observeEvent reset_12


observeEvent(input$reset_12a, {
  
  updateSliderInput(inputId="washingtonCoSlider3", value=WashinCo3Default)
  
}) # End observeEvent reset_12a


observeEvent(input$reset_12b, {
  
  updateSliderInput(inputId="washingtonCoSlider4", value=WashinCo4Default)
  #updateSliderInput(inputId="washingtonCoSlider5", value=WashinCo5Default)
  
}) # End observeEvent reset_12b


observeEvent(input$reset_12c, {
  
  #updateSliderInput(inputId="washingtonCoSlider4", value=WashinCo4Default)
  updateSliderInput(inputId="washingtonCoSlider5", value=WashinCo5Default)
  
}) # End observeEvent reset_12c


observeEvent(input$reset_13, {
  
  updateSliderInput(inputId="franklinCoSlider1", value=FrankCo1Default)
  updateSliderInput(inputId="franklinCoSlider2", value=FrankCo2Default)
  
}) # End observeEvent reset_13


observeEvent(input$reset_13a, {
  
  updateSliderInput(inputId="franklinCoSlider3", value=FrankCo3Default)
  
}) # End observeEvent reset_13a


observeEvent(input$reset_13b, {
  
  updateSliderInput(inputId="franklinCoSlider4", value=FrankCo4Default)
  #updateSliderInput(inputId="franklinCoSlider5", value=FrankCo5Default)
  
}) # End observeEvent reset_13b


observeEvent(input$reset_13c, {
  
  #updateSliderInput(inputId="franklinCoSlider4", value=FrankCo4Default)
  updateSliderInput(inputId="franklinCoSlider5", value=FrankCo5Default)
  
}) # End observeEvent reset_13c


observeEvent(input$reset_14, {
  
  updateSliderInput(inputId="lincolnCoSlider1", value=LincoCo1Default)
  updateSliderInput(inputId="lincolnCoSlider2", value=LincoCo2Default)
  
}) # End observeEvent reset_14


observeEvent(input$reset_14a, {
  
  updateSliderInput(inputId="lincolnCoSlider3", value=LincoCo3Default)
  
}) # End observeEvent reset_14a


observeEvent(input$reset_14b, {
  
  updateSliderInput(inputId="lincolnCoSlider4", value=LincoCo4Default)
  #updateSliderInput(inputId="lincolnCoSlider5", value=LincoCo5Default)
  
}) # End observeEvent reset_14b


observeEvent(input$reset_14c, {
  
  #updateSliderInput(inputId="lincolnCoSlider4", value=LincoCo4Default)
  updateSliderInput(inputId="lincolnCoSlider5", value=LincoCo5Default)
  
}) # End observeEvent reset_14c


observeEvent(input$reset_15, {
  
  updateSliderInput(inputId="sagadahocCoSlider1", value=SagadaCo1Default)
  updateSliderInput(inputId="sagadahocCoSlider2", value=SagadaCo2Default)
  
}) # End observeEvent reset_15


observeEvent(input$reset_15a, {
  
  updateSliderInput(inputId="sagadahocCoSlider3", value=SagadaCo3Default)
  
}) # End observeEvent reset_15a


observeEvent(input$reset_15b, {
  
  updateSliderInput(inputId="sagadahocCoSlider4", value=SagadaCo4Default)
  #updateSliderInput(inputId="sagadahocCoSlider5", value=SagadaCo5Default)
  
}) # End observeEvent reset_15b


observeEvent(input$reset_15c, {
  
  #updateSliderInput(inputId="sagadahocCoSlider4", value=SagadaCo4Default)
  updateSliderInput(inputId="sagadahocCoSlider5", value=SagadaCo5Default)
  
}) # End observeEvent reset_15c


observeEvent(input$reset_16, {
  
  updateSliderInput(inputId="yorkCoSlider1", value=YorkCo1Default)
  updateSliderInput(inputId="yorkCoSlider2", value=YorkCo2Default)
  
}) # End observeEvent reset_16


observeEvent(input$reset_16a, {
  
  updateSliderInput(inputId="yorkCoSlider3", value=YorkCo3Default)
  
}) # End observeEvent reset_16a


observeEvent(input$reset_16b, {
  
  updateSliderInput(inputId="yorkCoSlider4", value=YorkCo4Default)
  #updateSliderInput(inputId="yorkCoSlider5", value=YorkCo5Default)
  
}) # End observeEvent reset_16b


observeEvent(input$reset_16c, {
  
  #updateSliderInput(inputId="yorkCoSlider4", value=YorkCo4Default)
  updateSliderInput(inputId="yorkCoSlider5", value=YorkCo5Default)
  
}) # End observeEvent reset_16c


observeEvent(input$reset_17, {
  
  updateSliderInput(inputId="NH_Slider1", value=NH1Default)
  updateSliderInput(inputId="NH_Slider2", value=NH2Default)
  
}) # End observeEvent reset_17


observeEvent(input$reset_17a, {
  
  updateSliderInput(inputId="NH_Slider3", value=NH3Default)
  
}) # End observeEvent reset_17a


observeEvent(input$reset_17b, {
  
  updateSliderInput(inputId="NH_Slider4", value=NH4Default)
  #updateSliderInput(inputId="NH_Slider5", value=NH5Default)
  
}) # End observeEvent reset_17b


observeEvent(input$reset_17c, {
  
  #updateSliderInput(inputId="NH_Slider4", value=NH4Default)
  updateSliderInput(inputId="NH_Slider5", value=NH5Default)
  
}) # End observeEvent reset_17c


observeEvent(input$reset_18, {
  
  updateSliderInput(inputId="MA_Slider1", value=MA1Default)
  updateSliderInput(inputId="MA_Slider2", value=MA2Default)
  
}) # End observeEvent reset_18


observeEvent(input$reset_18a, {
  
  updateSliderInput(inputId="MA_Slider3", value=MA3Default)
  
}) # End observeEvent reset_18a


observeEvent(input$reset_18b, {
  
  updateSliderInput(inputId="MA_Slider4", value=MA4Default)
  #updateSliderInput(inputId="MA_Slider5", value=MA5Default)
  
}) # End observeEvent reset_18b


observeEvent(input$reset_18c, {
  
  #updateSliderInput(inputId="MA_Slider4", value=MA4Default)
  updateSliderInput(inputId="MA_Slider5", value=MA5Default)
  
}) # End observeEvent reset_18c


observeEvent(input$reset_19, {
  
  updateSliderInput(inputId="CtRiVt_Slider1", value=CtRiVt1Default)
  updateSliderInput(inputId="CtRiVt_Slider2", value=CtRiVt2Default)
  
}) # End observeEvent reset_19


observeEvent(input$reset_19a, {
  
  updateSliderInput(inputId="CtRiVt_Slider3", value=CtRiVt3Default)
  
}) # End observeEvent reset_19a


observeEvent(input$reset_19b, {
  
  updateSliderInput(inputId="CtRiVt_Slider4", value=CtRiVt4Default)
  #updateSliderInput(inputId="CtRiVt_Slider5", value=CtRiVt5Default)
  
}) # End observeEvent reset_19b


observeEvent(input$reset_19c, {
  
  #updateSliderInput(inputId="CtRiVt_Slider4", value=CtRiVt4Default)
  updateSliderInput(inputId="CtRiVt_Slider5", value=CtRiVt5Default)
  
}) # End observeEvent reset_19c


observeEvent(input$reset_20, {
  
  updateSliderInput(inputId="RestUS_Slider1", value=RestUS1Default)
  updateSliderInput(inputId="RestUS_Slider2", value=RestUS2Default)
  
}) # End observeEvent reset_20


observeEvent(input$reset_20a, {
  
  updateSliderInput(inputId="RestUS_Slider3", value=RestUS3Default)
  
}) # End observeEvent reset_20a


observeEvent(input$reset_20b, {
  
  updateSliderInput(inputId="RestUS_Slider4", value=RestUS4Default)
  #updateSliderInput(inputId="RestUS_Slider5", value=RestUS5Default)
  
}) # End observeEvent reset_20b


observeEvent(input$reset_20c, {
  
  #updateSliderInput(inputId="RestUS_Slider4", value=RestUS4Default)
  updateSliderInput(inputId="RestUS_Slider5", value=RestUS5Default)
  
}) # End observeEvent reset_20c



#############################################################################################################
# Old functionality

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

# end of old functionality
############################################################################################################


################################################################################
# 2045 % Wage and Salary Employment Slider Values Reactive
################################################################################  

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
  
  
  
  NH_WageAndSalaryPercentage2045 <-  as.numeric(input$NH_Slider4)
  
  NH_WageAndSalaryPercentage2045 <- NH_WageAndSalaryPercentage2045 / 100
  
  
  
  MA_WageAndSalaryPercentage2045 <-  as.numeric(input$MA_Slider4)
  
  MA_WageAndSalaryPercentage2045 <- MA_WageAndSalaryPercentage2045 / 100
  
  
  
  CtRiVt_WageAndSalaryPercentage2045 <-  as.numeric(input$CtRiVt_Slider4)
  
  CtRiVt_WageAndSalaryPercentage2045 <- CtRiVt_WageAndSalaryPercentage2045 / 100
  
  
  
  RestUS_WageAndSalaryPercentage2045 <-  as.numeric(input$RestUS_Slider4)
  
  RestUS_WageAndSalaryPercentage2045 <- RestUS_WageAndSalaryPercentage2045 / 100
  
  
  revisedWageAndSalaryPercentage2045 <-c(androscogginWageAndSalaryPercentage2045, aroostookWageAndSalaryPercentage2045, cumberlandWageAndSalaryPercentage2045, 
                                         franklinWageAndSalaryPercentage2045, hancockWageAndSalaryPercentage2045, kennebecWageAndSalaryPercentage2045, 
                                         knoxWageAndSalaryPercentage2045,lincolnWageAndSalaryPercentage2045, oxfordWageAndSalaryPercentage2045, 
                                         penobscotWageAndSalaryPercentage2045, piscataquisWageAndSalaryPercentage2045, sagadahocWageAndSalaryPercentage2045,
                                         somersetWageAndSalaryPercentage2045, waldoWageAndSalaryPercentage2045, washingtonWageAndSalaryPercentage2045, 
                                         yorkWageAndSalaryPercentage2045, NH_WageAndSalaryPercentage2045, MA_WageAndSalaryPercentage2045, 
                                         CtRiVt_WageAndSalaryPercentage2045, RestUS_WageAndSalaryPercentage2045)
  
  revisedWageAndSalaryPercentage2045
  
})# End of Reactive Get values from 2045 Wage and Salary % of Total Employment Sliders



################################################################################
# Working Two Jobs Slider Values Reactive
################################################################################  

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
  
  
  
  NH_WorkingTwoJobs2045 <-  as.numeric(input$NH_Slider5)
  
  NH_WorkingTwoJobs2045 <- NH_WorkingTwoJobs2045 / 100
  
  
  
  MA_WorkingTwoJobs2045 <-  as.numeric(input$MA_Slider5)
  
  MA_WorkingTwoJobs2045 <- MA_WorkingTwoJobs2045 / 100
  
  
  
  CtRiVt_WorkingTwoJobs2045 <-  as.numeric(input$CtRiVt_Slider5)
  
  CtRiVt_WorkingTwoJobs2045 <- CtRiVt_WorkingTwoJobs2045 / 100
  
  
  
  RestUS_WorkingTwoJobs2045 <-  as.numeric(input$RestUS_Slider5)
  
  RestUS_WorkingTwoJobs2045 <- RestUS_WorkingTwoJobs2045 / 100
  
  
  
  revisedWorkingTwoJobs2045 <-c(androscogginWorkingTwoJobs2045, aroostookWorkingTwoJobs2045, cumberlandWorkingTwoJobs2045, franklinWorkingTwoJobs2045,
                                hancockWorkingTwoJobs2045, kennebecWorkingTwoJobs2045, knoxWorkingTwoJobs2045,lincolnWorkingTwoJobs2045,
                                oxfordWorkingTwoJobs2045, penobscotWorkingTwoJobs2045, piscataquisWorkingTwoJobs2045, sagadahocWorkingTwoJobs2045,
                                somersetWorkingTwoJobs2045, waldoWorkingTwoJobs2045, washingtonWorkingTwoJobs2045, yorkWorkingTwoJobs2045,
                                NH_WorkingTwoJobs2045, MA_WorkingTwoJobs2045, CtRiVt_WorkingTwoJobs2045, RestUS_WorkingTwoJobs2045)
  
  revisedWorkingTwoJobs2045
  
})# End of Reactive Get values from 2045 % Working Two Jobs



################################################################################
# 2045 % Population Aged 15+ Slider Values Reactive
################################################################################  

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
  
  
  
  NH_WorkingAgedPopulation2045 <-  as.numeric(input$NH_Slider1)
  
  NH_WorkingAgedPopulation2045 <- NH_WorkingAgedPopulation2045 / 100
  
  
  
  MA_WorkingAgedPopulation2045 <-  as.numeric(input$MA_Slider1)
  
  MA_WorkingAgedPopulation2045 <- MA_WorkingAgedPopulation2045 / 100
  
  
  
  CtRiVt_WorkingAgedPopulation2045 <-  as.numeric(input$CtRiVt_Slider1)
  
  CtRiVt_WorkingAgedPopulation2045 <- CtRiVt_WorkingAgedPopulation2045 / 100
  
  
  
  RestUS_WorkingAgedPopulation2045 <-  as.numeric(input$RestUS_Slider1)
  
  RestUS_WorkingAgedPopulation2045 <- RestUS_WorkingAgedPopulation2045 / 100
  
  
  revisedWorkingAgePopulation2045 <-c(androscogginWorkingAgedPopulation2045, aroostookWorkingAgedPopulation2045, cumberlandWorkingAgedPopulation2045, 
                                      franklinWorkingAgedPopulation2045,hancockWorkingAgedPopulation2045, kennebecWorkingAgedPopulation2045, 
                                      knoxWorkingAgedPopulation2045,lincolnWorkingAgedPopulation2045,oxfordWorkingAgedPopulation2045, 
                                      penobscotWorkingAgedPopulation2045, piscataquisWorkingAgedPopulation2045, sagadahocWorkingAgedPopulation2045,
                                      somersetWorkingAgedPopulation2045, waldoWorkingAgedPopulation2045, washingtonWorkingAgedPopulation2045, 
                                      yorkWorkingAgedPopulation2045, NH_WorkingAgedPopulation2045, MA_WorkingAgedPopulation2045, 
                                      CtRiVt_WorkingAgedPopulation2045, RestUS_WorkingAgedPopulation2045)
  
  revisedWorkingAgePopulation2045
})


################################################################################
# 2045 Workforce Participation Rate Slider Values Reactive
################################################################################   

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
  
  
  
  NH_WorkforceParticipationRate2045 <-  as.numeric(input$NH_Slider2)
  
  NH_WorkforceParticipationRate2045 <- NH_WorkforceParticipationRate2045 / 100
  
  
  
  MA_WorkforceParticipationRate2045 <-  as.numeric(input$MA_Slider2)
  
  MA_WorkforceParticipationRate2045 <- MA_WorkforceParticipationRate2045 / 100
  
  
  
  CtRiVt_WorkforceParticipationRate2045 <-  as.numeric(input$CtRiVt_Slider2)
  
  CtRiVt_WorkforceParticipationRate2045 <- CtRiVt_WorkforceParticipationRate2045 / 100
  
  
  
  RestUS_WorkforceParticipationRate2045 <-  as.numeric(input$RestUS_Slider2)
  
  RestUS_WorkforceParticipationRate2045 <- RestUS_WorkforceParticipationRate2045 / 100
  
  
  
  revisedWorkforceParticipationRate2045 <-c(androscogginWorkforceParticipationRate2045, aroostookWorkforceParticipationRate2045, 
                                            cumberlandWorkforceParticipationRate2045, franklinWorkforceParticipationRate2045,
                                            hancockWorkforceParticipationRate2045, kennebecWorkforceParticipationRate2045, knoxWorkforceParticipationRate2045,
                                            lincolnWorkforceParticipationRate2045,oxfordWorkforceParticipationRate2045, penobscotWorkforceParticipationRate2045, 
                                            piscataquisWorkforceParticipationRate2045, sagadahocWorkforceParticipationRate2045,
                                            somersetWorkforceParticipationRate2045, waldoWorkforceParticipationRate2045, washingtonWorkforceParticipationRate2045,
                                            yorkWorkforceParticipationRate2045, NH_WorkforceParticipationRate2045, MA_WorkforceParticipationRate2045, 
                                            CtRiVt_WorkforceParticipationRate2045, RestUS_WorkforceParticipationRate2045)
  
  revisedWorkforceParticipationRate2045
})



################################################################################
# 2045 % Workforce Outflows Slider Values Reactive
################################################################################ 

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
  
  
  
  NH_WorkforceOutflows2045 <-  as.numeric(input$NH_Slider3)
  
  NH_WorkforceOutflows2045 <- NH_WorkforceOutflows2045 / 100
  
  
  
  MA_WorkforceOutflows2045 <-  as.numeric(input$MA_Slider3)
  
  MA_WorkforceOutflows2045 <- MA_WorkforceOutflows2045 / 100
  
  
  
  CtRiVt_WorkforceOutflows2045 <-  as.numeric(input$CtRiVt_Slider3)
  
  CtRiVt_WorkforceOutflows2045 <- CtRiVt_WorkforceOutflows2045 / 100
  
  
  
  RestUS_WorkforceOutflows2045 <-  as.numeric(input$RestUS_Slider3)
  
  RestUS_WorkforceOutflows2045 <- RestUS_WorkforceOutflows2045 / 100
  
  
  
  revisedWorkforceOutflows2045 <-c(androscogginWorkforceOutflows2045, aroostookWorkforceOutflows2045, cumberlandWorkforceOutflows2045, 
                                   franklinWorkforceOutflows2045,hancockWorkforceOutflows2045, kennebecWorkforceOutflows2045, knoxWorkforceOutflows2045,
                                   lincolnWorkforceOutflows2045, oxfordWorkforceOutflows2045, penobscotWorkforceOutflows2045, piscataquisWorkforceOutflows2045, 
                                   sagadahocWorkforceOutflows2045,somersetWorkforceOutflows2045, waldoWorkforceOutflows2045, washingtonWorkforceOutflows2045, 
                                   yorkWorkforceOutflows2045, NH_WorkforceOutflows2045, MA_WorkforceOutflows2045, CtRiVt_WorkforceOutflows2045, 
                                   RestUS_WorkforceOutflows2045)
  
  revisedWorkforceOutflows2045
})

###############################################################################
# End of UI Reactives
###############################################################################

