#---------  PREPROCESSING DATA -------- # 
# Clean raw data and extract separate data frames for all the tasks and demographics 

# 1. clear environment 

rm(list=ls()) 
graphics.off() # clear plots 

# 2. Get all the data from previous script -- # 1st way 
pathin <- "/Users/japneetbhatia/desktop/thesis/9.PREPROCESSING/scripts"
  
setwd(pathin) 
source("2.CleanRawDataForOneParticipant.R") 

pathout <- "/Users/japneetbhatia/desktop/thesis/10.CLEAN_DATA"

# 3. Loop to extract data for each participant so that
# - it loops through the number of participants we have 
# - create separate dfs for all tests and questionnaire scores 
# - save scores from all participants 
# - save 1 file, called clean_data with all the tests and questionnaire scores in different sheets: 
      # MobilConfig, DemogMed, AMT, CBFS, DRT, SART, iADL, FRT 

for (i in files) 
{  
      # 4. Read the data file into R 
  
      data <- read_excel(path = i)   # read excel 
      names(data)[names(data) == 'Participant'] <- 'StudyID' # change column name from participant to studyID
    
      # 5. Create separate vars for all the tests and questionnaires 
      
      # 1. Mobile Configuration 
      # it stores only the patic. number and answers in 0/1. 
      
      MobilConfig1 <- data %>%
        dplyr::select("StudyID", starts_with("MC_ans")) %>% 
        na.omit()      
      
      MobilConfig <- MobilConfig %>% full_join(MobilConfig1)
      
      # 2. Demographics 
      
      Demographics1 <- data %>%
        dplyr::select("StudyID", "age", "Edu", "gender", starts_with("Profession")) %>%
        na.omit()       # clear the columns with only NA values
    
      Demographics <- Demographics %>% full_join(Demographics1)
    
    
      # 3. Medical questionnaire 
      
      Med1 <- data %>% 
        dplyr::select("StudyID", starts_with("Med"))
    
      Med1 <- filter(Med1, !is.na(Med1$Med_daignosis))  # remove rows with no data 
       
      Med <- Med %>% full_join(Med1)
      
      # 4. AMT
      # 0 = incorrect ans
      # 1 = correct ans
    
      # SCORES
    
      AMT1 <- data %>%
        dplyr::select("StudyID", starts_with("AMT") & ends_with("r"), "AMT_12r_copy1647") %>%
        na.omit()       # clear the columns with only NA values
      
      AMT <- AMT %>% full_join(AMT1)
      
      # RESPONSE TIMES 
      # AMT_rt <- data %>%
      #   dplyr::select(StudyID, starts_with("AMT_rt") ) %>% 
      #   na.omit()    
      # 
      # AMT_rTime <- AMT_rTime %>% full_join(AMT_rt)
    
      # 5. CBFS
      
      # SCORES
      CBSF1 <- data %>%
        dplyr::select(StudyID, starts_with("CBSF_A"), starts_with("CBSF_B"))%>% 
        na.omit()    
      
      CBFS <- CBFS %>% full_join(CBSF1)
      
      # RESPONSE TIMES
      # CBFS_rt <- data %>%
      #   dplyr::select(StudyID, starts_with("bg"), starts_with("bq"))%>% 
      #   na.omit()     
      # 
      # CBFS_rTime <- CBFS_rTime %>% full_join(CBFS_rt)
    
      # 6. DRT
      
      # SCORES
      DRT1 <- data %>%
        dplyr::select("StudyID", starts_with("DRT_r"), -starts_with("DRT_rt")) %>%
        na.omit()
      
      DRT <- DRT %>% full_join(DRT1)
      
      # RESPONSE TIMES
      # DRT_rt <- data %>%
      #   dplyr::select(StudyID, starts_with("DRT_rt")) %>% 
      #   na.omit()    
      # 
      # DRT_rTime <- DRT_rTime %>% full_join(DRT_rt)
      # 
      # 7. SART
      
      # SCORES 
      SART1 <- data %>%
        dplyr::select("StudyID", starts_with("SART_items")) %>%
        na.omit()
    
      # there are 3 info in one column, how to seperate that
      SART1 <- SART1 %>% separate(col = SART_items,
                                into = c('om_err', 'com_err', 'sum_err', 'corr'),
                                sep = ",")
    
      # delete extra text from the cols 
      SART1$om_err<-gsub('[{"omissionErrors":}]','',as.character(SART1$om_err)) 
      SART1$com_err<-gsub('[{"comissionErrors":}]','',as.character(SART1$com_err))
      SART1$sum_err<-gsub('[{"errorSum":}]','',as.character(SART1$sum_err))
      SART1$corr<-gsub('[{"correct":}]','',as.character(SART1$corr))
    
      SART <- SART %>% full_join(SART1)
      
      # NO DATA FOR RESPONSE TIMES 
      
      # 8. iADL
      
      # SCORES
      iADL1 <- data %>%
        dplyr::select(StudyID, starts_with("iADL_item")) %>%
        na.omit()       # clear the columns with only NA values 
      
      iADL <- iADL %>% full_join(iADL1)
      
      # it doesnt have all the values
    
      # RESPONSE TIME
      # iADL_rt <- data %>%
      #   dplyr::select(StudyID, starts_with("iADL_r")) %>% 
      #   na.omit()   
      # 
      # iADL_rTime <- iADL_rTime %>% full_join(iADL_rt)
      # 
      # 9. FRT
      
      # SCORES
      FRT1 <- data %>%
        dplyr::select(StudyID, starts_with("F_ans"), starts_with("F_and")) %>%
        na.omit()
    
      FRT <- FRT %>% full_join(FRT1)
      
      # RESPONSE TIMES 
      # FRT_rt <- data %>% 
      #   dplyr::select(StudyID, starts_with("F_rt")) %>% 
      #   na.omit()   
      # 
      # FRT_rTime <- FRT_rTime %>% full_join(FRT_rt)
      # 
}

# Demographics

# Remove unnecessary vars 

rm("MobilConfig1")
rm("Demographics1")
rm("Med1")
rm("AMT1")
rm("SART1")
rm("iADL1")
rm("FRT1")
rm("DRT1")
rm("CBSF1")
rm("data")
# rm("AMT_rt")
# rm("CBFS_rt")
# rm("DRT_rt")
# rm("FRT_rt")
# rm("iADL_rt")


# # ----- write tables ------ # 

setwd(pathout)

dfs<- ls()[sapply(ls(), function(x) class(get(x))) == 'data.frame']   # extract all the df in R and save as a char vec
dfs <- Filter(function(x) is(x, "data.frame"), mget(ls())) 

# stores data in multiple sheets, in one excel file 

library(openxlsx) 
write.xlsx(dfs, file = 'clean_data.xlsx') 


