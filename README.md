# win host

* allow file sharing on docker options
* mount a local folder to /tes on guest (c:/tes used here): `-v c:/tes:/tes`
* either mount a .ssh folder to guest /root/.ssh : `-v ~/.ssh:/root/.ssh`, or provide a valid one under the /tes (as described previously) folder (/tes/.ssh). On a bash login it will be copied and used

## TODO
* install all required node versions during build
* bosco config generation based on provided info (?)
* samba fileshare for cloud based develepoment

### build
``` 
docker build . -t tes 
``` 

### run

 ```
 docker run -it -v c:/tes:/tes -v /var/run/docker.sock:/var/run/docker.sock tes bash
 ```
