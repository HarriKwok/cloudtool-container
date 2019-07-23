FROM alpine:3.7

RUN apk add --no-cache jq nano bash python3 terraform openssh-keygen openssh-client git groff less make rsync zsh && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s /usr/bin/pip3 /usr/bin/pip; fi && \
    if [ ! -e /usr/bin/python ]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    mkdir /root/.pip && \
    pip install --upgrade awscli kube-shell aws-shell && \
    rm -r /root/.cache && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i 's/root:\/bin\/ash/root:\/bin\/zsh/' /etc/passwd && \
    mkdir -p /root/repositories && cd /root/repositories && \
    echo "export AWS_PROFILE=Harri" >> /root/.bash_profile  && \
    echo "export DATASTORE_TYPE=kubernetes" >> /root/.bash_profile  && \
    echo "export KUBECONFIG=~/.kube/config" >> /root/.bash_profile

ADD https://raw.githubusercontent.com/HarriKwok/workroot/master/cloudtoolfr_defaults /root/
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl /usr/local/bin/
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator /usr/local/bin
ADD https://github.com/projectcalico/calicoctl/releases/download/v3.4.0/calicoctl /usr/local/bin

RUN chmod +x /usr/local/bin/kubectl /usr/local/bin/aws-iam-authenticator /usr/local/bin/calicoctl

RUN wget -q https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf linux-amd64

WORKDIR /root

