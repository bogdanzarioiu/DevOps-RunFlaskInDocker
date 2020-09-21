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


# Extra part
**`We can go one step further!`**<br/>
In order to use a Docker image in a production app, you need to push/publish it to a repository/registry. Docker has a registry platform where you can push your images called `Docker Hub` but it's public, meaning that anyone can pull your image and run a container with it. For learning purposes this is totally fine but for production images sure it's not recommended.<br/>
I created a private repository in AWS by using ECR(Elastic Container Registry) service and pushed our image created from the Dockerfile on it.<br/>
It's very easy to create a private repository, just keep in mind that one repo stores only versions of the same image and not different images.<br/>
After you create it, you need to check `View Push Commands`. This will tell you exactly what you need to to in order to be able to push an image to a repo.You need to have AWS CLI installed already - info here: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html <br/> <br/>
At this point we have our flask image in a private repo on AWS. We can use a `docker-compose` deployment file to automate this process even more(check **flask-deployment.yaml**)<br/>
We simply run `docker-compose -f flask-deployment.yaml up`. This will pull the image from the repository and spin a container:<br/> <br/>
![image](https://user-images.githubusercontent.com/24807183/93790084-eba14300-fc32-11ea-9a54-6ae6ab549dc1.png)

To verify, we can access once again our application on port 5050 this time(that's the port we specified in the deployment file):<br/> <br/>
![image](https://user-images.githubusercontent.com/24807183/93790330-34f19280-fc33-11ea-93ba-f66692d2ac73.png)





