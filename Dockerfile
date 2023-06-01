FROM ltdps/edxapp:latest

USER root

RUN apt update -y
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -o Dpkg::Options::="--force-confold" -o Dpkg::Options::="--force-confdef" upgrade -q -y --allow-downgrades --allow-remove-essential --allow-change-held-packages

RUN apt dist-upgrade -y
RUN apt install -y ubuntu-release-upgrader-core
# upgrade to bionic
RUN do-release-upgrade -f DistUpgradeViewNonInteractive

# upgrade to focal
RUN do-release-upgrade -f DistUpgradeViewNonInteractive

RUN apt update -y
RUN apt-get -y install --no-install-recommends python3 python3-venv python3.8 python3.8-minimal libpython3.8 libpython3.8-stdlib libmysqlclient21 libssl1.1 libxmlsec1-openssl lynx ntp git build-essential gettext gfortran graphviz locales swig
RUN apt install -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev libmysqlclient-dev python3-dev libsasl2-dev python-dev libldap2-dev libc6-dev

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN rm -rf /edx/app/edxapp/venvs
ADD venvs.tgz /edx/app/edxapp/

RUN python --version
