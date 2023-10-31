## Extract the data and save in separate matrices for one participant, so it can 
## be used as a base to save data in a loop for all the participants in the next script 

rm(list=ls()) # clear environment 

library(tidyverse) # packages 
library(readxl)
library(dplyr) 
library(writexl)  

# store the file in xlsx format 

# 1. Set path where raw data is stored  
RawData_xlsx <- "/Users/japneetbhatia/desktop/thesis/8.RAW_DATA/main/xlsx"
CleanData <- "/Users/japneetbhatia/desktop/thesis/10.CLEAN_DATA/main" 

setwd(RawData_xlsx) 

# 2. Create a list of all the participant raw data files 
files <- list.files(RawData_xlsx) 
 
# 3. Read the data file into R 
data <- read_excel(files[1])   # read excel 

# Update data labels 
names(data)[names(data) == 'Participant'] <- 'StudyID' # change column name from participant to studyID 

# 4. Create separate vars for all the tests and questionnaires 

  # 1. Mobile Configuration 
        # it stores only the patic. number and answers in 0/1. 

        MobilConfig <- data %>%
          dplyr::select(StudyID, starts_with("MC_ans")) %>% 
          na.omit()      
        
  # 2. Demographics 
        Demographics <- data %>%
          dplyr::select(StudyID, age, Edu, gender, starts_with("Profession")) %>% 
          na.omit()      
        
  # 3. Medical questionnaire 
        Med <- data %>% 
          dplyr::select(StudyID, starts_with("Med")) 

        Med <- filter(Med, !is.na(Med$Med_daignosis))  # remove rows with no data 
        
  # 4. AMT
        # 0 = incorrect ans 
        # 1 = correct ans 
        
        AMT <- data %>%
          dplyr::select(StudyID, starts_with("AMT") & ends_with("r"), "AMT_12r_copy1647") %>% 
          na.omit()      

  # 5. CBFS
        CBFS <- data %>%
          dplyr::select(StudyID, starts_with("CBSF_A"), starts_with("CBSF_B"))%>% 
          na.omit()      
        
  # 6. DRT 
        DRT <- data %>%
          dplyr::select(StudyID, starts_with("DRT_r"), -starts_with("DRT_rt")) %>% 
          na.omit()      
        
  # 7. SART 
        SART <- data %>%
          dplyr::select(StudyID, starts_with("SART_items")) %>% 
          na.omit()      
        
        # there are 3 info in one column, how to seperate that
        SART <- SART %>% separate(col = SART_items, 
                          into = c('om_err', 'com_err', 'sum_err', 'corr'), 
                          sep = ",")
        
        # delete extra text from the cols
        SART$om_err<-gsub('[{"omissionErrors":}]','',as.character(SART$om_err))
        SART$com_err<-gsub('[{"comissionErrors":}]','',as.character(SART$com_err))
        SART$sum_err<-gsub('[{"errorSum":}]','',as.character(SART$sum_err))
        SART$corr<-gsub('[{"correct":}]','',as.character(SART$corr))
        
        
  # 8. iADL
        iADL <- data %>% 
          dplyr::select(StudyID, starts_with("iADL_item")) %>% 
          na.omit()      
        
  # 9. FRT 
        FRT <- data %>% 
          dplyr::select(StudyID, starts_with("F_ans"), starts_with("F_and")) %>% 
          na.omit()      

# ---- Response times (we don't need for the analysis) ------- # 
        
        
        # AMT_rTime <- data %>%
        #   dplyr::select(StudyID, starts_with("AMT_rt") ) %>% 
        #   na.omit()      
        # 
        # # 5. CBFS
        # CBFS_rTime <- data %>%
        #   dplyr::select(StudyID, starts_with("bg"), starts_with("bq"))%>% 
        #   na.omit()      
        # 
        # # 6. DRT 
        # DRT_rTime <- data %>%
        #   dplyr::select(StudyID, starts_with("DRT_rt")) %>% 
        #   na.omit()      
        # 
        # 
        # # 8. iADL
        # iADL_rTime <- data %>%
        #   dplyr::select(StudyID, starts_with("iADL_r")) %>% 
        #   na.omit()      
        # 
        # # it doesnt have all the values 
        # 
        # # 9. FRT 
        # FRT_rTime <- data %>% 
        #   dplyr::select(StudyID, starts_with("F_rt")) %>% 
        #   na.omit()      

