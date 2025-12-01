FROM ubuntu:22.04

# ---------------------------------------------------------
# Prevent APT interactive prompts (tzdata freeze fix)
# ---------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# ---------------------------------------------------------
# Base system packages
# ---------------------------------------------------------
RUN apt update && \
    apt install -y \
      python3 python3-pip \
      git curl wget unzip tar \
      iputils-ping jq gnupg dnsutils \
      zsh bash-completion \
      ca-certificates apt-transport-https \
      software-properties-common \
      openssh-client openssh-server \
      ansible vim nano less tree htop fzf \
      net-tools && \
    rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------------
# Create dev user + docker group
# ---------------------------------------------------------
RUN groupadd -g 999 docker || true && \
    useradd -m -s /usr/bin/zsh dev && \
    usermod -aG sudo dev && \
    usermod -aG docker dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# ---------------------------------------------------------
# Docker CLI (Ubuntu 22.04 safe keyring method)
# ---------------------------------------------------------
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
      | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      > /etc/apt/sources.list.d/docker.list && \
    apt update && apt install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*


# ---------------------------------------------------------
# AWS CLI v2
# ---------------------------------------------------------
RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
      -o awscliv2.zip && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip aws/


# ---------------------------------------------------------
# AWS IAM Authenticator
# ---------------------------------------------------------
RUN curl -sLo /usr/local/bin/aws-iam-authenticator \
    https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/latest/download/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator


# ---------------------------------------------------------
# AWS Session Manager plugin
# ---------------------------------------------------------
RUN curl -sLo session-manager-plugin.deb \
    https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb && \
    dpkg -i session-manager-plugin.deb || apt --fix-broken install -y && \
    rm -f session-manager-plugin.deb


# ---------------------------------------------------------
# kubectl stable version (working)
# ---------------------------------------------------------
RUN curl -LO https://dl.k8s.io/release/v1.30.2/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl


# ---------------------------------------------------------
# Helm
# ---------------------------------------------------------
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash


# ---------------------------------------------------------
# k9s
# ---------------------------------------------------------
RUN curl -sL https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz \
    | tar xz && mv k9s /usr/local/bin/


# ---------------------------------------------------------
# stern
# ---------------------------------------------------------
RUN curl -sL https://github.com/stern/stern/releases/latest/download/stern_linux_amd64 \
      -o /usr/local/bin/stern && chmod +x /usr/local/bin/stern


# ---------------------------------------------------------
# kubectx & kubens
# ---------------------------------------------------------
RUN git clone https://github.com/ahmetb/kubectx /opt/kctx && \
    ln -s /opt/kctx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kctx/kubens /usr/local/bin/kubens


# ---------------------------------------------------------
# eksctl
# ---------------------------------------------------------
RUN ARCH=amd64 && \
    curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_${ARCH}.tar.gz" && \
    tar -xzf eksctl_Linux_${ARCH}.tar.gz && \
    mv eksctl /usr/local/bin/ && rm -f eksctl_Linux_${ARCH}.tar.gz


# ---------------------------------------------------------
# Terraform
# ---------------------------------------------------------
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
      https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/hashicorp.list && \
    apt update && apt install -y terraform


# ---------------------------------------------------------
# Cloudflared
# ---------------------------------------------------------
RUN curl -L --output cloudflared.deb \
    https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb || apt --fix-broken install -y && rm -f cloudflared.deb


# ---------------------------------------------------------
# Azure CLI
# ---------------------------------------------------------
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash


# ---------------------------------------------------------
# Google Cloud CLI
# ---------------------------------------------------------
RUN curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/google-cloud.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/google-cloud.gpg] \
      https://packages.cloud.google.com/apt cloud-sdk main" \
      > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt update && apt install -y google-cloud-cli


# ---------------------------------------------------------
# DigitalOcean doctl
# ---------------------------------------------------------
RUN DOCTL_VERSION=$(curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest \
      | grep tag_name | cut -d '"' -f 4) && \
    curl -sL "https://github.com/digitalocean/doctl/releases/download/${DOCTL_VERSION}/doctl-${DOCTL_VERSION#v}-linux-amd64.tar.gz" \
      -o doctl.tar.gz && \
    tar -xzf doctl.tar.gz && mv doctl /usr/local/bin/ && rm -f doctl.tar.gz


# ---------------------------------------------------------
# SSH server
# ---------------------------------------------------------
RUN mkdir -p /var/run/sshd


# ---------------------------------------------------------
# Oh-My-Zsh + autosuggestions + syntax highlighting
# ---------------------------------------------------------
USER dev
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-/home/dev/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        ${ZSH_CUSTOM:-/home/dev/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    sed -i 's/plugins=(git)/plugins=(git docker kubectl aws zsh-autosuggestions zsh-syntax-highlighting)/' \
        /home/dev/.zshrc && \
    echo "export PATH=\$PATH:/usr/local/bin" >> /home/dev/.zshrc

USER root

WORKDIR /workspace
CMD ["zsh"]

