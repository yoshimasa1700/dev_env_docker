XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
TAG=dev_env:opencv

touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

nvidia-docker run -it \
       --volume=$XSOCK:$XSOCK:rw \
       --volume=$XAUTH:$XAUTH:rw \
       --volume=$HOME:/home/opencv-user/orig_home:rw \
       --volume=$HOME/Programs:/home/opencv-user/Programs:rw \
       --volume=$HOME/Projects:/home/opencv-user/Projects:rw \
       --volume=$HOME/data:/home/opencv-user/data:rw \
       --volume=$HOME/.tmux.conf:/home/opencv-user/.tmux.conf:rw \
       --volume=$HOME/.tmux.conf.linux:/home/opencv-user/.tmux.conf.linux:rw \
       --volume=/mnt:/mnt:rw \
       --env="XAUTHORITY=${XAUTH}" \
       --env="DISPLAY" \
       --env="QT_X11_NO_MITSHM=1" \
       --user=1000 \
       $TAG \
       fish
