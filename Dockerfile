FROM ubuntu

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata && \
# courtesy https://dev.to/0xbf/set-timezone-in-your-docker-image-d22
    apt-get install -y iputils-ping && \
    apt-get install -y jq && \
    apt-get install -y apt-transport-https && \
    apt-get install -y lsb-release && \
    apt-get install -y wget && \
    apt-get install -y gnupg && \
    dpkg-reconfigure -f noninteractive tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get install -y gnupg software-properties-common wget curl jq postgresql-client dnsutils acl && \
    curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg && \
    install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/ && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get install terraform consul-template -y && \
    curl https://dl.min.io/client/mc/release/linux-amd64/mc \
      --create-dirs \
      -o /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

COPY srv-curl /bin/
