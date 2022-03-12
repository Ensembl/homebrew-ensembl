# Docker image with linuxbrew matching cluster's linuxbrew version
FROM linuxbrew/brew:3.1.0

# Install some required packages
RUN apt-get update \
 && apt-get -y install build-essential curl pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# switch to the linuxbrew user from root
USER linuxbrew

# avoid autoupdate while testing formulas
ENV HOMEBREW_NO_AUTO_UPDATE 1

# Turn off analytics and tap brew
RUN brew analytics off 

# cleanning up
RUN brew cleanup \
 && rm -rf /home/linuxbrew/.cache/Homebrew
