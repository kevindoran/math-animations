FROM pytorch/pytorch

ARG USER_ID=1001
ARG GROUP_ID=101
RUN addgroup --gid $GROUP_ID app
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID app
WORKDIR /app

# For Manim.
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
	wget && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* 


# For Jupyter Lab.
RUN conda config --add channels conda-forge 
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


RUN conda config --add channels conda-forge 
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


