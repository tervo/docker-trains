FROM tensorflow/tensorflow:2.0.1-gpu-py3

RUN mkdir /a
WORKDIR /a

# Basic stuff
RUN echo "deb http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial main" >> /etc/apt/sources.lits
RUN apt-get update

RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# libtiff5-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -yq python3-tk wget graphviz python-gdal curl
# python3-libnvinfer-dev

# Google sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
apt-get install -y apt-transport-https ca-certificates gnupg && \
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
apt-get update && \
apt-get install -y google-cloud-sdk google-cloud-sdk-app-engine-python google-cloud-sdk-app-engine-python-extras google-cloud-sdk-datalab
#gcloud init

#RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
#    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
#    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
#    apt-get update -y && apt-get install google-cloud-sdk google-cloud-sdk-app-engine-python google-cloud-sdk-app-engine-python-extras google-cloud-sdk-datalab -y

# PIP stuff
RUN pip install --upgrade pip && pip install --upgrade pydot graphviz keras-vis opencv-python unicodecsv pyproj requests boto boto3 psycopg2-binary unicodecsv pyproj requests google-cloud google-api-python-client google-auth-httplib2 google-cloud-bigquery[pandas] pyarrow google-cloud-storage scipy keras tensorflow-probability sklearn memory_profiler pympler six>=1.13.9 grakel[lovasz] scikit-learn imbalanced-learn tqdm
#scikit-learn==0.21.2

# eccodes
# RUN cd /tmp && mkdir eccodes && cd eccodes && wget https://software.ecmwf.int/wiki/download/attachments/45757960/eccodes-2.7.0-Source.tar.gz?api=v2 -O e.tar.gz && mkdir es && tar -C /tmp/eccodes -xzvf e.tar.gz && mkdir build && cd build && ls -la /tmp/eccodes/eccodes-2.7.0-Source && cmake -DCMAKE_INSTALL_PREFIX=/usr/local /tmp/eccodes/eccodes-2.7.0-Source && make && make install && rm -R /tmp/eccodes

# ENV PYTHONPATH "/usr/lib/google-cloud-sdk:/usr/lib/google-cloud-sdk/lib:/usr/lib/google-cloud-sdk/lib/yaml"
