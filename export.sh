# this will run after helm chart has been modified
export CHART=$1
export REPO=kamradtfamily.net
export TOKEN=$2
echo "updating chart for $CHART"
# get stuffs
echo 'http://dl-cdn.alpinelinux.org/alpine/v3.11/community' >> /etc/apk/repositories
apk update
apk add git
apk add perl
apk add openssh
wget https://github.com/mikefarah/yq/releases/download/v4.30.6/yq_linux_amd64 -O /usr/bin/yq
chmod +x /usr/bin/yq
helm plugin install --version=v0.9.0 https://github.com/chartmuseum/helm-push.git
helm repo add ${REPO} https://gitlab.com/api/v4/projects/42119870/packages/helm/stable --username rkamradt --password ${TOKEN}
# Add SSH key to root
mkdir -p /root/.ssh
cp "$SSH_PRIVATE_KEY" /root/.ssh/id_rsa
ssh-keyscan -H gitlab.com > /root/.ssh/known_hosts
chmod 600 /root/.ssh/id_rsa
mkdir work
cd work
# Git
git clone git@gitlab.com:kamradtfamily.net/helm-charts.git
cd helm-charts/$CHART
git config user.name "gitlab.runner"
git config user.email "gitlab.runner@gitlab.com"
# Helm
export OLD_VERSION=`yq e .version Chart.yaml`
export VERSION=`echo $OLD_VERSION | perl -pe 's/^((\d+\.)*)(\d+)(.*)$/$1.($3+1).$4/e'`
yq e .version=\"${VERSION}\" -i Chart.yaml
cat Chart.yaml
git commit -am "[skip ci] update $CHART chart from ${OLD_VERSION} to ${VERSION}" && git push
cd ..
helm package $CHART
helm push ${CHART}*.tgz ${REPO}