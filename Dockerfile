FROM ubuntu
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gnupg software-properties-common curl jq yq postgresql dnsutils && \
    curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg && \
    install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/ && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt install terraform -y
    curl https://dl.min.io/client/mc/release/linux-$(uname -m)/mc \
      --create-dirs \
      -o /usr/local/bin
    chmod +x /usr/local/bin/mc

COPY srv-curl /bin/
