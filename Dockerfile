FROM ubuntu:16.04

# Install system dependencies.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -qq \

    && apt-get install -y --no-install-recommends \
        build-essential \
        software-properties-common \
        wget \

    # Install Git.
    && add-apt-repository ppa:git-core/ppa \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends git \

    # Install Python3.
    && add-apt-repository ppa:jonathonf/python-3.6 \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        python3.6 \
        python3.6-dev \

    # Install Pip3 (autoset Pip3 aliases).
    && wget -qO- https://bootstrap.pypa.io/get-pip.py | python3.6 \

    # Set Python3 aliases.
    && echo 'alias python3=python3.6' | tee -a ~/.bash_aliases \

    # Install Postgresql 9.6.
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | \
        tee -a /etc/apt/sources.list.d/pgdg.list \
    && wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
        apt-key add - \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        postgresql \
        postgresql-contrib \
        libpq-dev \

    # Install NodeJS and Yarn.
    && wget -qO- http://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install --global yarn \

    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working dir.
WORKDIR /home/docker

# Default command.
COPY docker-entrypoint.sh /home/
ENTRYPOINT ["/home/docker-entrypoint.sh"]
