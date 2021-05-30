FROM pytorch/pytorch
# TODO: switch back to ubuntu:20.04 at some point

ARG USER_ID=1001
ARG GROUP_ID=101
RUN addgroup --gid $GROUP_ID app
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID app
WORKDIR /app


# tzdata configuration stops for an interactive prompt without the env var.
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN apt-get update && apt-get install --no-install-recommends -y \
     tzdata

# For Manim.
RUN apt-get update && apt-get install --no-install-recommends -y \
    ffmpeg \
    gcc \
    libcairo2-dev \
    libffi-dev \
    libpango1.0-dev \
    pkg-config \
	make \
	ca-certificates \
	wget && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

#texlive texlive-latex-extra texlive-fonts-extra \
#texlive-latex-recommended texlive-science texlive-fonts-extra tipa \

# setup a minimal texlive installation
COPY docker/texlive-profile.txt /tmp/
ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
RUN wget -O /tmp/install-tl-unx.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir /tmp/install-tl && \
    tar -xzf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1 && \
    /tmp/install-tl/install-tl --profile=/tmp/texlive-profile.txt \
    && tlmgr install \
        amsmath babel-english cbfonts-fd cm-super ctex doublestroke dvisvgm everysel \
        fontspec frcursive fundus-calligra gnu-freefont jknapltx latex-bin \
        mathastext microtype ms physics preview ragged2e relsize rsfs \
        setspace standalone tipa wasy wasysym xcolor xetex xkeyval

# Might avoid the disabling of Jupyter extensions.
# https://github.com/pangeo-data/helm-chart/issues/48#issuecomment-407740974
RUN conda update conda --yes \
 	&& conda config --remove channels defaults
RUN conda config --add channels conda-forge 

# For Jupyter Lab.
RUN conda install --yes \
	jupyterlab  \
    ipywidgets && \
	conda clean -ya
# Custom repodata a temporary fix. See:
# https://stackoverflow.com/questions/62325068/cannot-install-latest-nodejs-using-conda-on-mac
RUN conda install --yes -c conda-forge nodejs'>=12.0.0' --repodata-fn=repodata.json
RUN conda install -c conda-forge jupyterlab-spellchecker
RUN jupyter labextension install @axlair/jupyterlab_vim
# Custom CSS to increase size of manim videos.
RUN mkdir /app/.jupyter
RUN mkdir /app/.jupyter/custom
RUN echo "div video { max-width: 60vw; }" > /app/.jupyter/custom/custom.css


RUN conda install --yes \
	matplotlib \
	pandas \
	scikit-learn \
    scipy \
	pytest=6.2.3 && \
	conda clean -ya

RUN pip install \
        easydev    \
        palettable \
        colormap  \
        manim



#COPY --chown=$USER_ID src/  ./src
COPY --chown=$USER_ID setup.py  ./

#RUN pip install .

USER app


