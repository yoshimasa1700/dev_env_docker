FROM opencv:latest-env

# for nvidia-docker
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# add user.
ENV USERNAME opencv-user
RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod --shell /bin/bash $USERNAME
RUN usermod -aG sudo,adm,cdrom,dip,plugdev,video $USERNAME
RUN usermod  --uid 1000 $USERNAME
RUN groupmod --gid 1000 $USERNAME
RUN echo $USERNAME:$USERNAME | chpasswd

RUN echo root:root | chpasswd

RUN apt-get update && \
    apt-get install -y \
    ipython \
    tmux \
    curl \
    software-properties-common

RUN apt-add-repository ppa:fish-shell/release-2

RUN apt-get update && \
    apt-get install -y \
    fish \
    cheese

RUN chsh -s /usr/bin/fish $USERNAME
USER $USERNAME

WORKDIR /home/opencv-user
RUN git clone https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all
RUN curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
SHELL ["/usr/bin/fish", "fisher fzf"]
