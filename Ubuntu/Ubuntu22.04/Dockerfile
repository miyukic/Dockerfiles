#docker build . --build-arg PASSWD=pass -t rlr01/miyukiubuntu:22.04
#docker run -P -d --name 任意のコンテナ名 miyukiubuntu:22.04

FROM ubuntu:22.04

# aptのミラーサーバーをjpに設定する
RUN sed -i 's@http://archive.ubuntu.com@http://jp.archive.ubuntu.com@g' /etc/apt/sources.list

# 使うコマンドをインストール
RUN \
    apt update && \
    apt -y upgrade && \
    apt install -y build-essential && \
    apt install -y software-properties-common && \
    apt install -y curl git man unzip vim wget sudo less net-tools iputils-ping

# 最小構成を解除
#RUN y | unminimize

# ユーザー作成
RUN useradd -m yumeno
# sudoグループに追加
RUN gpasswd -a yumeno sudo
# パスワードは${PASSWD}に設定
RUN echo "yumeno:pass" | chpasswd
# sshログイン時のシェルをbashに設定
RUN sudo sed -i 's/yumeno:x:1000:1000::\/home\/yumeno:\/bin\/sh/yumeno:x:1000:1000::\/home\/yumeno:\/bin\/bash/g' /etc/passwd

# sshするための設定
RUN apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# 秘密鍵でログインする場合
#COPY id_rsa.pub /root/authorized_keys
#
#RUN mkdir ~/.ssh && \
#    mv ~/authorized_keys ~/.ssh/authorized_keys && \
#    chmod 0600 ~/.ssh/authorized_keys


# 日本語化
RUN \
    apt -y install language-pack-ja && \
    #日本語マニュアル
    apt -y install manpages-ja manpages-ja-dev && \
    update-locale LANG=ja_JP.UTF8

# gitの<CR>がエラー制御文字として^Mになるのを抑制
RUN \
    git config --global core.whitespace cr-at-eol

# dotfiles
RUN \
    cd /home/yumeno && \
    git clone https://github.com/miyukic/dotfiles.git dotfiles && \
    find ./dotfiles | xargs chown yumeno:yumeno && \
    cd dotfiles && \
    /bin/bash ./bootstrap.sh auto


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
