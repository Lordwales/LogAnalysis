FILE="puppet_access_ssl.log"
if [ -e $FILE ]
then
  echo "File exists"
  # GET number of times  /production/file_metadata/modules/ssh/sshd_config is found
  FETCHCOUNT= grep /production/file_metadata/modules/ssh/sshd_config $FILE | wc -l | tee tmp_file
  URLOCCUR=$(< tmp_file)
  echo "URL, /production/file_metadata/modules/ssh/sshd_config was requested: $URLOCCUR times"
  rm tmp_file

#count number of times request retuned a 200   /production/file_metadata/modules/ssh/sshd_config? HTTP/1.1" 200
  # FETCHCOUNT2= grep 200 $FILE | wc -l | tee tmp_file
  FETCHCOUNT2= grep /production/file_metadata/modules/ssh/sshd_config $FILE | grep -v 200 | wc -l | tee tmp_file
  UNSUCCESSFUL=$(< tmp_file)
  echo "Unsuccessful requests of /production/file_metadata/modules/ssh/sshd_config: $UNSUCCESSFUL"
  rm tmp_file

#count the number of times a line does not have 200
  FETCHCOUNT3= grep -v 200 $FILE | wc -l | tee tmp_file
  FAIL=$(< tmp_file)
  echo "Apache failed requests: $FAIL"
  rm tmp_file

# GET number of times  PUT /dev/report/ is found
  FETCHCOUNT4= grep 'PUT /dev/report/' $FILE | wc -l | tee tmp_file
  PUTOCCUR=$(< tmp_file)
  echo "REQUEST, PUT /dev/report/ was found: $PUTOCCUR times"
  rm tmp_file 

# Get unique IP addresses that made requests
  FETCHCOUNT5= grep 'PUT /dev/report/' $FILE | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq -c | tee tmp_file 
  UNIQUEIP=$(< tmp_file)
  echo "Breakdown of Unique IP addresses that made PUT /dev/report/ requests: $UNIQUEIP"
  rm tmp_file

  #FETCHCOUNT5= grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $FILE | sort | uniq | wc -l | tee tmp_file  

else
  echo "File does not exist"
fi