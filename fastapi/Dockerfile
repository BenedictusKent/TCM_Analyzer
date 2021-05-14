# Use nvidia cuda container image with cudnn and cuda library
FROM tensorflow/tensorflow:2.4.1-gpu

WORKDIR /app

# Copy the current directory contents into the container at app
ADD . /app

RUN apt-get clean \
    && apt-get -y update \
    && apt-get -y upgrade

RUN apt-get -y install build-essential \
    && apt-get -y install libgl1-mesa-dev \
    && apt-get -y install libglib2.0-0

# Install python 3.8, the base image comes with 3.6 by default
RUN apt-get install -y software-properties-common wget \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get -y update \
    && apt-get install -y python3.8 python3.8-distutils\
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3.8 get-pip.py \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.8 /usr/bin/python3

# Install python dependency
RUN pip install six \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r docker-requirements.txt

# https://github.com/tiangolo/uvicorn-gunicorn-docker/blob/master/docker-images/python3.8.dockerfile

RUN pip install --no-cache-dir "uvicorn[standard]" gunicorn
RUN chmod +x /app/uvicorn-gunicorn/start.sh
RUN chmod +x /app/uvicorn-gunicorn/start-reload.sh


EXPOSE 8888

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["app/uvicorn-gunicorn/start.sh"]
