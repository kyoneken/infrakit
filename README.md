# Terraform & Ansible Docker イメージ

[![Build and Push Multi-Architecture Docker Image](https://github.com/kyoneken/infrakit/actions/workflows/docker-build.yml/badge.svg)](https://github.com/kyoneken/infrakit/actions/workflows/docker-build.yml)

インフラストラクチャ自動化のための軽量な Terraform と Ansible を含む Docker イメージです。ARM64 と AMD64（Intel/x86_64）の両方のアーキテクチャをサポートしています。

## 含まれるツール

- Terraform: インフラストラクチャのプロビジョニングとコード化
- Ansible: 構成管理と自動化
- dotenvx: 環境変数管理ツール
- その他の基本ツール: Git, SSH, etc.

## 使用方法

### Docker Hub / GitHub Container Registry から取得

```bash
# Pull the image
docker pull ghcr.io/kyoneken/terraform-ansible:latest

# Run with your current directory mounted
docker run -it --rm -v $(pwd):/workspace ghcr.io/kyoneken/terraform-ansible:latest
```

### Terraform の使用例

```bash
docker run -it --rm -v $(pwd):/workspace ghcr.io/kyoneken/terraform-ansible:latest terraform init
docker run -it --rm -v $(pwd):/workspace ghcr.io/kyoneken/terraform-ansible:latest terraform plan
docker run -it --rm -v $(pwd):/workspace ghcr.io/kyoneken/terraform-ansible:latest terraform apply
```

### Ansible の使用例

```bash
# SSH キーを使用する場合は、それらをマウントします
docker run -it --rm \
  -v $(pwd):/workspace \
  -v ~/.ssh:/root/.ssh \
  ghcr.io/kyoneken/terraform-ansible:latest \
  ansible-playbook playbook.yml
```

### dotenvx の使用例

```bash
# 環境変数ファイルを使用する
docker run -it --rm \
  -v $(pwd):/workspace \
  ghcr.io/kyoneken/terraform-ansible:latest \
  dotenvx load -f .env -- terraform apply
```

## カスタムビルド

```bash
git clone https://github.com/kyoneken/infrakit.git
cd infrakit
docker build -t terraform-ansible:custom .
```

## タグ

- `latest`: 最新の安定版
- `vX.Y.Z`: セマンティックバージョニングタグ（例：`v1.0.0`）
- `main`: メインブランチからの最新ビルド

## ライセンス

MIT

## 注意事項

本イメージは実運用環境での使用を前提に作成されていますが、特定のユースケースに合わせてカスタマイズすることをお勧めします。