FROM python:3.10-slim
ENV WORKDIR /app
WORKDIR $WORKDIR

COPY ./src .
COPY requirements.txt .
RUN pip install --no-cache-dir -r ./requirements.txt
COPY *.sh /
RUN chmod +x /*.sh

RUN apt update -y && apt install curl git -y
RUN curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b /usr/local/bin

# code repositories should mount here to initiate the scan
ENV WORKDIR /src 
WORKDIR $WORKDIR
ENTRYPOINT ["/entrypoint.sh"]