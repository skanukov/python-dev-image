FROM ubuntu:16.04

# Install system dependencies.
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \

  && apt-get install -y --no-install-recommends \
    build-essential \
    git \

  # Install Python3.
  && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \

  # Install Postgresql.
  && apt-get install -y --no-install-recommends \
    postgresql \
    postgresql-contrib \
    libpq-dev \

  # Install NodeJS and Yarn.
  # && apt-get install -y --no-install-recommends wget \
  # && wget -qO- http://deb.nodesource.com/setup_6.x | bash - \
  # && apt-get install -y --no-install-recommends nodejs \
  # && npm install --global yarn \

  && apt-get clean && rm -rf /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /home/root/

# Set working dir.
WORKDIR /home/root

# Default command.
ENTRYPOINT ["/home/root/docker-entrypoint.sh"]
