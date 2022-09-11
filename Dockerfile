FROM python:3.8

LABEL maintainer="cybera.3s@gmail.com"
LABEL version="1.0.0"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /management

# copy and install requirements
ADD user_management/requirements.txt .
# RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
ADD user_management/user_manager/ .

# RUN python -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt

# Create user with associated group and assign permissions of current directory to it
RUN groupadd -r manager && useradd --no-log-init -r -s /bin/bash -g manager manager && \
    chown -R manager /management && chmod -R 777 /management
USER manager

# Generate protobufs from user proto schema
RUN python3 -m grpc_tools.protoc -I . --python_out=. --grpc_python_out=. ./grpc_utils/protos/user.proto

EXPOSE 50051
CMD python3 manage.py makemigrations && python3 manage.py migrate && python3 manage.py grpcrunserver --dev

