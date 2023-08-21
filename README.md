# LFI_Searcher
This script automates the search for a defined file as part of a LFI to searching for non-standard files. 

The count of directories searched is defined in the code, this script will then append as many ../ as has been defined.


**Explination of adjustable arguments**

There are 3 adjustable arguments in this script, they are:

**{NUMBER..NUMBER}** - This tells the script the range of ../ to attempt, for example if the argument is set as {1..10} then a total of 10 ../ will be used

**url="[{TARGET URL}]"** - This is the target url we are looking for E.g. a **passwd** file\n

**{PARAMETER}** - This is the parameters to fuzz, such as a page=/

**Useage**

```
Options:
  -u, --url       target URL        Example: http://google.com/parameter?search=
  -f, --file      target file       Example: /etc/passwd
  -a, --attempts  number of attempts (default: 10)         
  -h, --help      display help text
```

