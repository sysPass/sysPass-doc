FROM debian:stretch

LABEL maintainer=nuxsmin@syspass.org

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install python3-sphinx \
  python3-sphinx-bootstrap-theme \
  python3-sphinxcontrib.plantuml \
  python3-sphinx-rtd-theme \
  python3-sphinxcontrib.actdiag \
  python3-sphinxcontrib.blockdiag \
  python3-sphinxcontrib.nwdiag \
  python3-sphinxcontrib.seqdiag \
  openjdk-8-jre \
  make \
	&& apt-get clean \
	&& rm -r /var/lib/apt/lists/*

# RUN pip install sphinx-sitemap sphinx-markdown

WORKDIR /opt/docs

COPY vendor/plantuml.jar /opt/extensions/

USER 1000

CMD ["sphinx-build", "-b", "html", "/opt/docs/source", "/opt/docs/build"]
