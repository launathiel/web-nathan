FROM python:3.6

# create and set working directory
RUN mkdir /web-nathan
WORKDIR /web-nathan

# Add current directory code to working directory
ADD . /web-nathan/

# set default environment variables
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive 

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# install environment dependencies
RUN pip3 install --upgrade pip 

# Install project dependencies
RUN pip install -r ./requirements.txt
RUN python ./manage.py makemigrations
RUN python ./manage.py migrate

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]