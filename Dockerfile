ARG BYOND_BASE_IMAGE=i386/ubuntu:bionic

ARG IMG_BUILD_PYTHON=python:3.7-buster
ARG IMG_BUILD_NODE=node:15-buster

FROM ${BYOND_BASE_IMAGE} AS byond
SHELL ["/bin/bash", "-c"]
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y make man curl unzip libssl-dev
ARG BYOND_MAJOR=513
ARG BYOND_MINOR=1536
ARG BYOND_DOWNLOAD_URL=https://secure.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip
RUN curl ${BYOND_DOWNLOAD_URL} -o byond.zip \
    && unzip byond.zip \
	&& rm -rf byond.zip
WORKDIR /byond
RUN make here
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/*

FROM ${IMG_BUILD_PYTHON} AS mapping
COPY tools tools
COPY maps maps
RUN python3 tools/ci/template_dm_generator.py

FROM ${IMG_BUILD_NODE} AS tgui
COPY tgui tgui
RUN chmod u+x tgui/bin/tgui
RUN tgui/bin/tgui

FROM byond AS cm13
COPY . .
ARG DM_PROJECT_NAME=ColonialMarinesALPHA
RUN source /byond/bin/byondsetup && DreamMaker ${DM_PROJECT_NAME}.dme

FROM cm13 AS cm-runner
ENV DREAMDAEMON_PORT=1400
RUN mkdir -p /cm/data
WORKDIR /cm
COPY config config
COPY --from=tgui tgui/public tgui/public
COPY --from=mapping maps maps
ARG RUSTG_VERSION=0.4.7
ARG RUSTG_URL=https://github.com/tgstation/rust-g/releases/download/${RUSTG_VERSION}/librust_g.so
ADD ${RUSTG_URL} librust_g.so
ARG DM_PROJECT_NAME=ColonialMarinesALPHA
COPY --from=cm13 ${DM_PROJECT_NAME}.rsc application.rsc
COPY --from=cm13 ${DM_PROJECT_NAME}.dmb application.dmb
COPY tools/runner-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
