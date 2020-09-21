FROM ubuntu:20.04
RUN apt-get update -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN pip3 install flask
RUN apt-get install nano -y
COPY ./flask-demo-app.py /flask-demo-app.py
ENTRYPOINT ["python3", "flask-demo-app.py"]
#CMD [ "python3 flask-demo-app.py" ]

