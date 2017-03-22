FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive \

    # Set software versions.
    PYTHON_VERSION='3.6' \
    POSTGRESQL_VERSION='9.6' \
    NODE_VERSION='6.x' \

    # Install dependencies.
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gettext \
        software-properties-common \
        wget \

    # Install Git.
    && add-apt-repository ppa:git-core/ppa \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends git \

    # Install Python3.
    && add-apt-repository ppa:jonathonf/python-"$PYTHON_VERSION" \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        python"$PYTHON_VERSION" \
        python"$PYTHON_VERSION"-dev \

    # Install Pip3 (autoset Pip3 aliases).
    && wget -qO- https://bootstrap.pypa.io/get-pip.py | python"$PYTHON_VERSION" \

    # Set Python3 aliases.
    && echo "alias python3=python$PYTHON_VERSION" | tee -a ~/.bash_aliases \

    # Install Postgresql.
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | \
        tee -a /etc/apt/sources.list.d/pgdg.list \
    && wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
        apt-key add - \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        postgresql-"$POSTGRESQL_VERSION" \
        postgresql-contrib-"$POSTGRESQL_VERSION" \
        libpq-dev \

    # Install NodeJS and Yarn.
    && wget -qO- http://deb.nodesource.com/setup_"$NODE_VERSION" | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install --global yarn \

    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working dir.
WORKDIR /home/docker

# Default command.
COPY docker-entrypoint.sh /home/
ENTRYPOINT ["/home/docker-entrypoint.sh"]
