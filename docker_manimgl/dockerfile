FROM ubuntu:20.04

ARG USER_ID=1001
ARG GROUP_ID=101
RUN addgroup --gid $GROUP_ID manim
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID manim
WORKDIR /manim

# tzdata configuration stops for an interactive prompt without the env var.
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
RUN apt-get update && apt-get install --no-install-recommends -y \
     tzdata
RUN apt-get install --no-install-recommends -y \
	 build-essential \
     libpango1.0-dev \
	 freeglut3-dev \
     python3-dev \
     pkg-config \
	 ffmpeg  \
     latexmk \ 
     pip \
     texlive && \ 
	 rm -rf /var/lib/apt/lists/*

RUN pip install manimgl 

USER manim

COPY ./ ./

# Install our own project as a module.
# This is done so the tests can import it.
# RUN pip install .
