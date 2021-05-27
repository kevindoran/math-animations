FROM manimcommunity/manim:v0.6.0


RUN mkdir /manim/.jupyter
RUN mkdir /manim/.jupyter/custom
RUN echo "div video { max-width: 60vw; }" > /manim/.jupyter/custom/custom.css

RUN pip install easydev matplotlib palettable colormap

# USER root
# WORKDIR /root
# ENV HOME /

# ARG CONDA_VERSION=py38_4.9.2
# ARG CONDA_MD5=122c8c9beb51e124ab32a0fa6426c656

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -O miniconda.sh && \
#     echo "${CONDA_MD5}  miniconda.sh" > miniconda.md5 && \
# 	if ! md5sum --status -c miniconda.md5; then exit 1; fi && \
# 	mkdir -p /opt && \
# 	sh miniconda.sh -b -p /opt/conda && \
# 	rm miniconda.sh miniconda.md5 && \
# 	ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
# 	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
# 	echo "conda activate base" >> ~/.bashrc && \
# 	find /opt/conda/ -follow -type f -name '*.a' -delete && \
# 	find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
# 	/opt/conda/bin/conda clean -afy
# 
# # RUN wget --quiet \ https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \ && mkdir /root/.conda \ && bash Miniconda3-latest-Linux-x86_64.sh -b \ && rm -f Miniconda3-latest-Linux-x86_64.sh 
# # Usering /manim/... as the manim dockerfile sets /manim to home env var.
# ENV PATH $PATH:/manim/miniconda3/bin
# run /manim/miniconda3/bin --version
# #RUN conda --version
# #RUN conda install --yes nodejs'>=12.0.0'
# #RUN jupyter labextension install @axlair/jupyterlab_vim
# #USER ${NB_USER}
# WORKDIR manim
# USER manimuser

