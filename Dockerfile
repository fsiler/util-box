FROM ubuntu

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata && \
# courtesy https://dev.to/0xbf/set-timezone-in-your-docker-image-d22
    dpkg-reconfigure -f noninteractive tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get install -y acl apt-transport-https curl dnsutils gnupg iputils-ping lsb-release software-properties-common jq postgresql-client wget && \
    curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg && \
    install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/ && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get install terraform consul-template -y && \
    curl https://dl.min.io/client/mc/release/linux-amd64/mc \
      --create-dirs \
      -o /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

COPY srv-curl /bin/
