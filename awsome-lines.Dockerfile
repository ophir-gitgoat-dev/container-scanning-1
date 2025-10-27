FROM python:3.9.11

WORKDIR /usr/src/app

RUN pip install awscli
RUN aws --version

RUN pip install requests==2.22.0 # oh no we might have cves ;-)

RUN echo "Arnica is awesome!!!"

COPY . .

RUN cat /etc/os-release

CMD ["echo", "hello", "world"]
