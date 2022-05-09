FILE="puppet_access_ssl.log"
if [ -e $FILE ]
then
  echo "File exists"
  #grep GET /production/file_metadata/modules/ssh/sshd_config $FILE
  FETCHCOUNT= grep /production/file_metadata/modules/ssh/sshd_config $FILE | wc -l | tee tmp_file
  URLOCCUR=$(< tmp_file)
  echo "URL, /production/file_metadata/modules/ssh/sshd_config was found: $URLOCCUR times"

  
else
  echo "File does not exist"
fi