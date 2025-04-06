FROM python:3.11-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache \
    bash \
    curl \
    git \
    openssh-client \
    gnupg \
    unzip \
    make \
    gcc \
    libc-dev \
    libffi-dev \
    openssl-dev

# Terraform のインストール
ENV TERRAFORM_VERSION=1.5.7
RUN curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || echo "amd64").zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || echo "amd64").zip" && \
    mv terraform /usr/local/bin/ && \
    rm "terraform_${TERRAFORM_VERSION}_linux_$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || echo "amd64").zip"

# Ansible のインストール
RUN pip install --no-cache-dir ansible ansible-core && \
    # よく使われる Ansible コレクションをインストール
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install ansible.posix

# 作業ディレクトリの設定
WORKDIR /workspace

# Terraform と Ansible のバージョン確認用のコマンド
RUN terraform version && ansible --version

# イメージメタデータ
LABEL org.opencontainers.image.title="Terraform and Ansible Container"
LABEL org.opencontainers.image.description="A lightweight container with Terraform and Ansible for infrastructure automation"
LABEL org.opencontainers.image.source="https://github.com/OWNER/REPO"
LABEL org.opencontainers.image.licenses="MIT"

# デフォルトコマンド
CMD ["/bin/bash"]