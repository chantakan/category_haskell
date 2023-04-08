FROM ubuntu:latest

# パッケージリストの更新
RUN apt-get update

# タイムゾーンの設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 必要なパッケージのインストール
RUN apt-get install -y \
        curl \
        libgmp-dev \
        zlib1g-dev \
        git \
        openssh-server \
        libffi-dev \
        build-essential \
	vim

# ssh
RUN apt-get update &&\
    apt-get install -y --no-install-recommends openssh-server && \
    apt-get install -y tzdata && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "root:password" | chpasswd

#
# 一般ユーザ用設定
#
RUN apt-get update && apt-get -y install sudo
# 各種環境変数を設定
ENV USER chan
ENV HOME /home/${USER}
ENV SHELL /bin/bash
# ホストのGROUP_IとUIDを記述しておくと後で便利
ENV GROUP 1002
ENV UID 1002
ARG PASSWORD=pass1
# グループを追加
RUN groupadd -g ${GROUP} ${USER}
# 一般ユーザアカウントを追加
RUN useradd -m -s ${SHELL} -g ${GROUP} -u ${UID} ${USER}
# 一般ユーザのパスワード設定
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN adduser ${USER} sudo
# 日本語環境追加
RUN echo 'export LANG=ja_JP.UTF-8' >> ${HOME}/.bashrc
RUN echo 'export LANGUAGE=ja_JP:ja' >> ${HOME}/.bashrc


# sshdの設定
RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "AllowUsers chan" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

# sudo実行   
RUN echo "${USER}  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
 
# Haskellのインストール
USER chan
RUN sudo apt-get update &&\
	sudo apt-get install -y --no-install-recommends haskell-stack

RUN mkdir /home/chan/work
WORKDIR /home/chan/work
RUN yes | stack upgrade
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> ${HOME}/.bashrc

USER root
RUN sed -i '$d' /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
