FROM rocker/verse

RUN apt-get install -y --no-install-recommends texlive-latex-extra \
	&& install2.r --error --deps TRUE \
    stargazer

WORKDIR /opt/report
COPY . /opt/report

CMD make
