FROM python:3.9.11

WORKDIR /usr/src/app

COPY ofir/requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

RUN echo "Arnica is awesome!!!"

COPY . .

RUN cat /etc/os-release

CMD ["echo", "hello", "world"]
