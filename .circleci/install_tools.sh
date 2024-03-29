#!/usr/bin/env bash

set -o errexit

readonly HELM_VERSION=2.13.1
readonly CHART_RELEASER_VERSION=0.1.4

echo "Installing Helm..."
curl -LO "https://kubernetes-helm.storage.googleapis.com/helm-v$HELM_VERSION-linux-amd64.tar.gz"
sudo mkdir -p "/usr/local/helm-v$HELM_VERSION"
sudo tar -xzf "helm-v$HELM_VERSION-linux-amd64.tar.gz" -C "/usr/local/helm-v$HELM_VERSION"
sudo ln -s "/usr/local/helm-v$HELM_VERSION/linux-amd64/helm" /usr/local/bin/helm
rm -f "helm-v$HELM_VERSION-linux-amd64.tar.gz"
helm init --client-only

echo "Installing chart-releaser..."
curl -LO "https://github.com/helm/chart-releaser/releases/download/v${CHART_RELEASER_VERSION}/chart-releaser_${CHART_RELEASER_VERSION}_Linux_x86_64.tar.gz"
sudo mkdir -p "/usr/local/chart-releaser-v$CHART_RELEASER_VERSION"
sudo tar -xzf "chart-releaser_${CHART_RELEASER_VERSION}_Linux_x86_64.tar.gz" -C "/usr/local/chart-releaser-v$CHART_RELEASER_VERSION"
sudo ln -s "/usr/local/chart-releaser-v$CHART_RELEASER_VERSION/chart-releaser" /usr/local/bin/chart-releaser
rm -f "chart-releaser_${CHART_RELEASER_VERSION}_Linux_x86_64.tar.gz"

echo "Install Kustomize..."
curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases |\
  grep browser_download |\
  grep linux |\
  cut -d '"' -f 4 |\
  grep /kustomize/v |\
  sort | tail -n 1 |\
  xargs curl -O -L
sudo mkdir -p /usr/local/kustomize
sudo tar -xzf ./kustomize_v*_linux_amd64.tar.gz -C /usr/local/kustomize
sudo ln -s /usr/local/kustomize/kustomize /usr/local/bin/kustomize
rm -f ./kustomize_v*_linux_amd64.tar.gz

