FROM pytorch/pytorch

ARG USER_ID=1001
ARG GROUP_ID=101
RUN addgroup --gid $GROUP_ID app
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID app
WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
    ffmpeg \
    gcc \
    libcairo2-dev \
    libffi-dev \
    libpango1.0-dev \
    pkg-config \
    texlive texlive-latex-extra texlive-fonts-extra \
    texlive-latex-recommended texlive-science texlive-fonts-extra tipa \
    make \
    wget



RUN mkdir /app/.jupyter
RUN mkdir /app/.jupyter/custom
RUN echo "div video { max-width: 60vw; }" > /app/.jupyter/custom/custom.css

RUN pip install \
        easydev    \
        matplotlib \
        palettable \
        colormap  \
        manim

RUN conda config --add channels conda-forge 
RUN conda install --yes \
	#nodejs'>=12.0.0' \
	matplotlib \
	pandas \
	scikit-learn \
    scipy \
	jupyterlab  \
    ipywidgets && \
	conda clean -ya
# Custom repodata a temporary fix. See:
# https://stackoverflow.com/questions/62325068/cannot-install-latest-nodejs-using-conda-on-mac
RUN conda install --yes -c conda-forge nodejs'>=12.0.0' --repodata-fn=repodata.json
RUN conda install -c conda-forge jupyterlab-spellchecker
RUN jupyter labextension install @axlair/jupyterlab_vim


COPY --chown=$USER_ID ./ ./

USER app


