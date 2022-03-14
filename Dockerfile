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

# Setup moonshine
ENV HOMEBREW_ENSEMBL_MOONSHINE_ARCHIVE /home/linuxbrew/ENSEMBL_MOONSHINE_ARCHIVE
ENV HOMEBREW_NO_AUTO_UPDATE 1
RUN mkdir -p $HOMEBREW_ENSEMBL_MOONSHINE_ARCHIVE

# Turn off analytics and tap brew & Ensembl repositories
RUN brew analytics off \
 && brew tap denji/nginx \
 && brew tap ensembl/ensembl \
 && brew tap ensembl/external \
 && brew tap ensembl/moonshine \
 # Disable so far due to the following error: Cannot tap ensembl/web: invalid syntax in tap!
 #&& brew tap ensembl/web \  
 && brew tap ensembl/cask

# cleanning up
RUN brew cleanup \
 && rm -rf /home/linuxbrew/.cache/Homebrew
