docker run -it --runtime=nvidia --net=host --privileged=true -v /data2:/data2 --shm-size=16GB demon:cuda9.cudnn7.pytorch1.0 /bin/bash
