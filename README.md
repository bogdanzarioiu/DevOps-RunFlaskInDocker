# DevOps Project - Run a "Hello, world!" Flask app inside a Docker container
This is a project composed of two main parts:<br/>
**`1.Create a basic Flask app and run it inside a Docker container manually.`**<br/>
**`2.Same thing but automated.`**<br/><br/>
# Part 1 - manual work
**`1.1 First of all, install Docker:`**<br/>
`brew cask install docker` --> instalation for macOS using brew. It's very easy to install Docker for Linux & Windows as well.<br/>
You can simply double check that the installation was successful by running `docker --version`. Mine is *Docker version 19.03.12, build 48a66213fe.*<br/>
**`1.2 Create a container running Ubuntu:`**<br/>
`docker run -it -d --name flask-demo-app -p 8080:5000 ubuntu:20.04`<br/>
*We need to map our host(mac) port to the default container port for Flask(5000) so we can access our application in a web browser.*<br/>
**`1.3 Access the container's terminal:`**<br/>
`docker exec -it 650fccba3b18 /bin/bash`<br/>
*650fccba3b18 is my container ID. If you follow this steps, yours will be different for sure* <br/>
**`1.4 Update & Install the necessary tools/packages -to be made in order`**<br/>
`apt-get update -y`<br/>
`apt-get install python3 -y`<br/>
`apt-get install python3-pip -y`<br/>
`pip3 install flask`<br/>
`apt-get install nano -y` *Here I used nano to copy a demo Flask app(**flask-demo-app.py**) from my mac to the container.*<br/>
**`1.5 Run the app`**<br/>
`python3 flask-demo-app.py`<br/>
Now your app should be accessible through `localhost:8080` as you can see below:<br/> <br/>
![image](https://user-images.githubusercontent.com/24807183/93783858-85b1bd00-fc2c-11ea-8859-83ffc76de205.png)


# Part 2 - automation :)
We use a `Dockerfile` that will allow us to build an image for our Flask demo app. All we have to do after this is to run a new container with the new image and test if the deployment was successful.<br/>
**`2.1 Build an image from a Dockerfile:`**<br/>
`docker build -t flask-demo-app:1.0 .` The `.` tells Docker where the Dockerfile is(current directory in this case).<br/>
`-t` flag allows us to tag/name the image that will be created. You can specify any name as long as is lowercase(I got an error when I tried to use uppercase letters inside the name of the image).<br/>
**`2.2 Final test`**<br/>
Now we need to test that we can deploy a container from the image we just built:<br/>
`docker run -it -d --name flask-DEMO -p 5000:5000 099ca57ce8d7` *099ca57ce8d7 is the image ID for the one we just created - you can get it by running `docker images`*<br/>
After all this, we should be able to access the same app but by using the port 5000:<br/> <br/>
![image](https://user-images.githubusercontent.com/24807183/93783972-ab3ec680-fc2c-11ea-9cbc-c9b3278110d4.png)




