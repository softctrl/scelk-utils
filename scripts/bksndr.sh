#!/bin/sh
## Author: carlostimoshenkorodrigueslopes@gmail.com
## Just to send a big file as bulk insert/update into the Elasticsearch server

# Show a little help to the user, and exit the script with non success status
Help(){
        echo "Usage: bksndr.sh file_name server_name"
        exit 1;
}

if [ $# -eq 0 ]
then
    Help
fi

FOLDER="_AUX-`date +%Y%m%d%H%M`_"

cd ${FOLDER} && split -l 100000 ${1}

for f in `ls`; do
  echo "##`date +%Y_%m_%d_%H_%M` - starting to import file(${f})"
  curl -s -XPOST ${2}/_bulk --data-binary @${f} && echo "##`date +%Y_%m_%d_%H_%M` - Done(${f})"
  mv ${f} _OK_${f};
done
