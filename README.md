# NLG - Natural Language Generation

## Introduction

NLG is a natural language generation system implemented as a MAVEN project in JAVA (JDK). The NLG software consists of 3 submodules, namely NLG Commons, NLG Core and NLG Service. These submodules are publicly available on GitHub at https://github.com/WELCOME-project/NLG.

## Installation, Deployment, and Execution

### Installation and Deployment

#### Software Requirements

The WELCOME NLG installation requires the use of Docker and Docker Compose. Docker is used to package NLG as an image that can be run in a container. The `.yml` configuration file and Docker Compose are used to instantiate Docker images as containers. The `.yml` file specifies the virtual network details and other necessary configurations.
Additionally, a service with a GET endpoint that provides templates in json format is required.
Here is an example of the output format this service must have:
```
{
   "TInformRegistrationProcedure":[
      "In addition to that, you can register online to your personal doctor at the Greek Ministry of Health's website.<s_end>\n<welcome:webURL>\nThe personal doctor is your first point of contact with the National Health System and, among other roles, it acts as your health advisor and navigator."
   ]
}
``` 

#### Hardware Requirements

The NLG image requires a maximum of 4 GB of memory to run. It can utilize multiple threads, so having several CPU cores available is preferred. In the example configuration provided below, up to 4 CPU cores are used.

#### Deployment

The configuration of the NLG deployment is specified in the `.yml` file. One can use an existing image by specifying its name and tag in the `.yml` file to run the NLG container.

To create the image from scratch, access the project directory and run the command:
```
docker build -f Dockerfile -t name_of_the_image:tag .
```
Then upload it to a Maven repository with the command:
```
docker push name_of_the_image:tag
```
Use this image inside the `.yml` file.

#### Example `compose.yml` for Deployment

Here is an example `compose.yml` file that can be used for deployment. Adjust the image tag and port mapping as required:

```
version: '3.2'
nlg:
  image: registry.gitlab.com/talnupf/welcome/nlg:2023-02-01
  deploy:
    replicas: 1
    resources:
      limits:
        cpus: "4"
        memory: 4GB
    ports:
      - "8080:8080"
	environment:
      - CONTENTDB_URL=<url_of_templates_service>
```

### Execution

The deployed NLG component can run in the cloud infrastructure of the installed WELCOME platform or be deployed externally. Make the corresponding adjustments in the dispatcher configuration to point to the appropriate service URL.

The service is accessible through a REST-like API at `http://<base_url>/nlg-service/` where `<base_url>` corresponds to the location of the deployment. For example, `http://nlg:8080/nlg-service/` or `https://welcome-project.upf.edu/nlg-service/`. Swagger documentation is available at that endpoint.