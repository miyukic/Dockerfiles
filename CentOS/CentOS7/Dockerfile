#docker build . -t rlr01/centos:centos7-basic-x86
# CentOS7の最新イメージを使う
FROM centos:centos7

#RUN yum update -y && \
#    yum install -y epel-release && \


# インストール
RUN yum -y install openssh-server sudo vim less git make

# sshでログインできるようにする 
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

#ユーザー追加
RUN useradd -m yumeno
#wheelグループに追加
RUN usermod -aG wheel yumeno

# パスワードを 設定
RUN echo 'yumeno:pass' | chpasswd

RUN yum install -y gcc ncurses-devel make
RUN cd /home/yumeno && ls
RUN git clone https://github.com/vim/vim.git vim
# RUN cd ./vim
# RUN /bin/bash ./configure --prefix=/home/yumeno/usr && \
#     make && make install && cd ../

RUN cd /home/yumeno && git clone https://github.com/miyukic/dotfiles.git dotfiles
RUN /bin/bash /home/yumeno/dotfiles/bootstrap.sh all


# 使わないにしてもここに公開鍵を登録しておかないとログインできない 
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key

# sshd の使うポートを公開する
EXPOSE 22

# sshd を起動する
CMD ["/usr/sbin/sshd", "-D"]
