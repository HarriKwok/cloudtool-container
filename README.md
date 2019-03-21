# cloudtool-container for AWS

#Build the docker Image
docker build -t cloudtool .

#List Docker Image
docker image ls

#Remove docker Image
docker rmi <name/instanceid>

#List Running Containers
docker container ls

#Remove Docker Containers
docker rm $(docker ps -a -q)

#Run Docker image
docker run -it --rm --name cloudtool --env AWS_PROFILE=Harri -v "$HOME/.aws":/root/.aws -v "$HOME/Workspace":/root/Workspace cloudtool zsh
