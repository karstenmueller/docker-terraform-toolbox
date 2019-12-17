FROM alpine

# --------------------------------------------------------------------------
# terraform
ENV TERRAFORM_VERSION="0.12.18"
RUN apk update && \
  apk upgrade && \
  apk add curl && \
  apk add --virtual=build ca-certificates openssl unzip && \
  curl -o /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip -q /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
  apk del --purge build

# --------------------------------------------------------------------------
# helm
ARG HELM_VERSION="v3.0.1"
RUN apk add --virtual=build bash openssl && \
  curl -o /tmp/get https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get && \
  bash /tmp/get --version "$HELM_VERSION" --no-sudo && \
  apk del --purge build

# --------------------------------------------------------------------------
# kubectl
ARG KUBECTL_VERSION="v1.17.0"
RUN curl -o /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  install -m 0555 /tmp/kubectl /usr/local/bin/kubectl

# --------------------------------------------------------------------------
# gcloud
ARG GCLOUD_VERSION="273.0.0"
RUN apk add python && \
  curl -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
  tar xzf /tmp/google-cloud-sdk.tar.gz -C /usr/local && \
  /usr/local/google-cloud-sdk/install.sh --usage-reporting=false && \
  /usr/local/google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# --------------------------------------------------------------------------
# az-cli
ARG AZURE_CLI_VERSION="2.0.77"
RUN apk add python py-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev make && \
  pip --no-cache-dir install -U pip && \
  pip --no-cache-dir install azure-cli==${AZURE_CLI_VERSION} && \
  apk del --purge build

# --------------------------------------------------------------------------
# aws-cli
ARG AWS_CLI_VERSION="1.16.303"
RUN apk add python py-pip && \
  pip install awscli==${AWS_CLI_VERSION}

# --------------------------------------------------------------------------
# inspec
ARG INSPEC_VERSION="4.18.39"
ARG GEM_SOURCE="https://rubygems.org"

RUN apk add ruby ruby-bundler ruby-bigdecimal && \
  apk add --virtual=build curl-dev ruby-dev build-base libxml2-dev libffi-dev ruby-io-console && \
  gem install --no-document --source ${GEM_SOURCE} --version ${INSPEC_VERSION} inspec-bin && \
  gem install --no-document --source ${GEM_SOURCE} webrick && \
  apk del --purge build && \
  inspec --chef-license=accept --no-enable-telemetry

# --------------------------------------------------------------------------
# cleanup
RUN rm -rf /tmp/* && \
  rm -rf /var/cache/apk/* && \
  rm -rf /var/tmp/*

ENV PATH = $PATH:/usr/local/google-cloud-sdk/bin
VOLUME ["/share"]
WORKDIR /share
