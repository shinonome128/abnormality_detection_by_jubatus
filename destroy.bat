@ECHO ON

REM ///////////////////////////////////////////////////
REM destroy.bat
REM ///////////////////////////////////////////////////

cd C:\Users\shino\doc\abnormality_detection_by_jubatus  
terraform plan -destroy terraform  
terraform destroy terraform  

Pause
