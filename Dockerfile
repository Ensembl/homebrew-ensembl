# This container (i) disables the DST Root CA X3 certificate 
# because it has experied on September 2021, and (ii) updates 
# the directory /etc/ssl/certs that hold SSLs certificates.

FROM muffato/ensembl-linuxbrew-basic-dependencies

RUN sudo sed -i '/^mozilla\/DST_Root_CA_X3/s/^/!/' /etc/ca-certificates.conf \
 && sudo update-ca-certificates -f

# The above is to avoid the message "Warning: ensembl/external is shallow clone"
RUN brew untap ensembl/external \
 && brew tap ensembl/external

# Unlink linuxbrew's curl as it uses old certificates
RUN brew unlink curl

# clean up
RUN sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && brew cleanup \
 && rm -rf /home/linuxbrew/.cache/Homebrew
