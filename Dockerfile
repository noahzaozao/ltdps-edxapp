FROM ltdps/edxapp:latest

USER root

RUN apt update -y
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
RUN apt install -y libmysqlclient-dev python3-dev libsasl2-dev python-dev libldap2-dev libssl-dev
ADD Python-3.8.10.tgz /edx/app/edx_ansible/edx_ansible/docker/plays/
RUN cd Python-3.8.10 && \
./configure --enable-optimizations && \
make -j 8 && \
make altinstall

RUN rm /usr/bin/python && rm /usr/bin/python3
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python3
RUN ln -s /usr/local/bin/python3.8 /usr/bin/python3.8

RUN rm -rf /edx/app/edxapp/venvs
ADD venvs.tgz /edx/app/edxapp/

RUN python --version
