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
# Define Constants
################################################################################

PctWorkingAge <- ageStructure$Population_Age_15_and_Over
PctLaborForce <- laborParticipation$Workforce_Participation_Rate_2019
PctOutflow <- workforceOutflows$Workforce_Percent_Outflows

# This vector is equal to the percent wage and salary employment by county from 2019
# This percentage is calculated by dividing the Census wage and salary employment 
# from 2019 by the total Woods and Poole employment from 2019
PctWSEmp <- employment$PCT_2019_Wage_Salary_Employment

# This can be used to change percent of employment that is self-employment
# PctWSEmp <- employment$PCT_2019_Self_Employment


# First Block of Maine Counties
# These set the default values for the percent of working age population for each county
# The values are ratios representing percents, so need to be multiplied by 100
AndroCo1Default <- PctWorkingAge[1] * 100
HancockCo1Default <- PctWorkingAge[5] * 100
OxfordCo1Default <- PctWorkingAge[9] * 100
SomerCo1Default <- PctWorkingAge[13] * 100

# These set the default values for the labor force participation rate for each county
# The values are ratios representing percents, so need to be multiplied by 100
AndroCo2Default <- PctLaborForce[1] * 100
HancockCo2Default <- PctLaborForce[5] * 100
OxfordCo2Default <- PctLaborForce[9] * 100
SomerCo2Default <- PctLaborForce[13] * 100

# These set the default values for the percent of county workforce commuting outside county of residence for work
# The values are ratios representing percents, so need to be multiplied by 100
AndroCo3Default <- PctOutflow[1] * 100
HancockCo3Default <- PctOutflow[5] * 100
OxfordCo3Default <- PctOutflow[9] * 100
SomerCo3Default <- PctOutflow[13] * 100

# These set the default values for the percent of total employment that is wage and salary employment
# The values are ratios representing percents, so need to be multiplied by 100
AndroCo4Default <- PctWSEmp[1] * 100
HancockCo4Default <- PctWSEmp[5] * 100
OxfordCo4Default <- PctWSEmp[9] * 100
SomerCo4Default <- PctWSEmp[13] * 100

# These set the default values for the % of labor force working more than one job in each county
# There's no good data on this, we've estimated from Census employment data at the 
# Portland-Lewiston-South Portland LMA level roughly 2% of workforce has more than one job
AndroCo5Default <- 2
HancockCo5Default <- 0
OxfordCo5Default <- 0
SomerCo5Default <- 0


# Second Block of Maine Counties

# These set the default values for the percent of working age population for each county
# The values are ratios representing percents, so need to be multiplied by 100
AroostCo1Default <- PctWorkingAge[2] * 100
KennebCo1Default <- PctWorkingAge[6] * 100
PenobCo1Default <- PctWorkingAge[10] * 100
WaldoCo1Default <- PctWorkingAge[14] * 100

# These set the default values for the labor force participation rate for each county
# The values are ratios representing percents, so need to be multiplied by 100
AroostCo2Default <- PctLaborForce[2] * 100
KennebCo2Default <- PctLaborForce[6] * 100
PenobCo2Default <- PctLaborForce[10] * 100
WaldoCo2Default <- PctLaborForce[14] * 100

# These set the default values for the percent of county workforce commuting outside county of residence for work
# The values are ratios representing percents, so need to be multiplied by 100
AroostCo3Default <- PctOutflow[2] * 100
KennebCo3Default <- PctOutflow[6] * 100
PenobCo3Default <- PctOutflow[10] * 100
WaldoCo3Default <- PctOutflow[14] * 100

# These set the default values for the percent of total employment that is wage and salary employment
# The values are ratios representing percents, so need to be multiplied by 100
AroostCo4Default <- PctWSEmp[2] * 100
KennebCo4Default <- PctWSEmp[6] * 100
PenobCo4Default <- PctWSEmp[10] * 100
WaldoCo4Default <- PctWSEmp[14] * 100

# These set the default values for the % of labor force working more than one job in each county
# There's no good data on this, we've estimated from Census employment data at the 
# Portland-Lewiston-South Portland LMA level roughly 2% of workforce has more than one job
AroostCo5Default <- 0
KennebCo5Default <- 0
PenobCo5Default <- 2
WaldoCo5Default <- 0


# Third Block of Maine Counties

# These set the default values for the percent of working age population for each county
# The values are ratios representing percents, so need to be multiplied by 100
CumberCo1Default <- PctWorkingAge[3] * 100
KnoxCo1Default <- PctWorkingAge[7] * 100
PiscatCo1Default <- PctWorkingAge[11] * 100
WashinCo1Default <- PctWorkingAge[15] * 100

# These set the default values for the labor force participation rate for each county
# The values are ratios representing percents, so need to be multiplied by 100
CumberCo2Default <- PctLaborForce[3] * 100
KnoxCo2Default <- PctLaborForce[7] * 100
PiscatCo2Default <- PctLaborForce[11] * 100
WashinCo2Default <- PctLaborForce[15] * 100

# These set the default values for the percent of county workforce commuting outside county of residence for work
# The values are ratios representing percents, so need to be multiplied by 100
CumberCo3Default <- PctOutflow[3] * 100
KnoxCo3Default <- PctOutflow[7] * 100
PiscatCo3Default <- PctOutflow[11] * 100
WashinCo3Default <- PctOutflow[15] * 100

# These set the default values for the percent of total employment that is wage and salary employment
# The values are ratios representing percents, so need to be multiplied by 100
CumberCo4Default <- PctWSEmp[3] * 100
KnoxCo4Default <- PctWSEmp[7] * 100
PiscatCo4Default <- PctWSEmp[11] * 100
WashinCo4Default <- PctWSEmp[15] * 100

# These set the default values for the % of labor force working more than one job in each county
# There's no good data on this, we've estimated from Census employment data at the 
# Portland-Lewiston-South Portland LMA level roughly 2% of workforce has more than one job
CumberCo5Default <- 2
KnoxCo5Default <- 0
PiscatCo5Default <- 0
WashinCo5Default <- 0


#Fourth Block of Maine Counties

# These set the default values for the percent of working age population for each county
# The values are ratios representing percents, so need to be multiplied by 100
FrankCo1Default <- PctWorkingAge[4] * 100
LincoCo1Default <- PctWorkingAge[8] * 100
SagadaCo1Default <- PctWorkingAge[12] * 100
YorkCo1Default <- PctWorkingAge[16] * 100

# These set the default values for the labor force participation rate for each county
# The values are ratios representing percents, so need to be multiplied by 100
FrankCo2Default <- PctLaborForce[4] * 100
LincoCo2Default <- PctLaborForce[8] * 100
SagadaCo2Default <- PctLaborForce[12] * 100
YorkCo2Default <- PctLaborForce[16] * 100

# These set the default values for the percent of county workforce commuting outside county of residence for work
# The values are ratios representing percents, so need to be multiplied by 100
FrankCo3Default <- PctOutflow[4] * 100
LincoCo3Default <- PctOutflow[8] * 100
SagadaCo3Default <- PctOutflow[12] * 100
YorkCo3Default <- PctOutflow[16] * 100

# These set the default values for the percent of total employment that is wage and salary employment
# The values are ratios representing percents, so need to be multiplied by 100
FrankCo4Default <- PctWSEmp[4] * 100
LincoCo4Default <- PctWSEmp[8] * 100
SagadaCo4Default <- PctWSEmp[12] * 100
YorkCo4Default <- PctWSEmp[16] * 100

# These set the default values for the % of labor force working more than one job in each county
# There's no good data on this, we've estimated from Census employment data at the 
# Portland-Lewiston-South Portland LMA level roughly 2% of workforce has more than one job
FrankCo5Default <- 0
LincoCo5Default <- 0
SagadaCo5Default <- 2
YorkCo5Default <- 2



# Other New England States and Rest of US

# These set the default values for the percent of working age population for each county
# The values are ratios representing percents, so need to be multiplied by 100
NH1Default <- PctWorkingAge[17] * 100
MA1Default <- PctWorkingAge[18] * 100
CtRiVt1Default <- PctWorkingAge[19] * 100
RestUS1Default <- PctWorkingAge[20] * 100

# These set the default values for the labor force participation rate for each county
# The values are ratios representing percents, so need to be multiplied by 100
NH2Default <- PctLaborForce[17] * 100
MA2Default <- PctLaborForce[18] * 100
CtRiVt2Default <- PctLaborForce[19] * 100
RestUS2Default <- PctLaborForce[20] * 100

# These set the default values for the percent of county workforce commuting outside county of residence for work
# The values are ratios representing percents, so need to be multiplied by 100
NH3Default <- PctOutflow[17] * 100
MA3Default <- PctOutflow[18] * 100
CtRiVt3Default <- PctOutflow[19] * 100
RestUS3Default <- PctOutflow[20] * 100

# These set the default values for the percent of total employment that is wage and salary employment
# The values are ratios representing percents, so need to be multiplied by 100
NH4Default <- PctWSEmp[17] * 100
MA4Default <- PctWSEmp[18] * 100
CtRiVt4Default <- PctWSEmp[19] * 100
RestUS4Default <- PctWSEmp[20] * 100

# These set the default values for the % of labor force working more than one job in each county
# There's no good data on this, we've estimated from Census employment data at the 
# Portland-Lewiston-South Portland LMA level roughly 2% of workforce has more than one job
NH5Default <- 0
MA5Default <- 0
CtRiVt5Default <- 0
RestUS5Default <- 0.047403606258759 * 100

################################################################################
# End Define Constants
################################################################################