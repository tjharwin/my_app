FROM ubuntu 

RUN apt-get update 
RUN apt-get install python3-pip
RUN apt-get install flask

ADD app.py /
WORKDIR /

EXPOSE 5000

CMD [“python3”,”app.py”]