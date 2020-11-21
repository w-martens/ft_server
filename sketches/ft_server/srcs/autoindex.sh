red='\033[0;31m'
green='\033[0;32m'
nc='\033[0m'

if ! [ -n "$1" ]; then
     echo "no input, use either 'autoindex on' or 'autoindex off'"
     exit 1
fi

if  [ $1 != "on" ] && [ $1 != "off" ]; then
echo "wrong input, use either 'autoindex on' or 'autoindex off'"
exit 1
fi

if [ $1 = "on" ]; then 
cd /etc/nginx/sites-available/ && sed -i 's/autoindex off/autoindex on/g' nginxconf
service nginx restart 1> /dev/null
echo -e "\t Autoindex set to ${green}on${nc}"
fi

if [ $1 = "off" ]; then 
cd /etc/nginx/sites-available/ && sed -i 's/autoindex on/autoindex off/g' nginxconf 
echo -e "\t Autoindex set to ${red}off${nc}"
service nginx restart 1> /dev/null
fi
