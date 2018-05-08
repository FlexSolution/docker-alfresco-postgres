# docker-alfresco-postgres

Dockerfile to build Alfresco Community with preinstalled Postgres DB. 
We use it for testing purposes

# Installation

Pull the image:

    docker pull flexsolution/alfresco-postgres:201707

Another way is to build from sources

    git clone https://github.com/FlexSolution/docker-alfresco-postgres.git
    cd docker-alfresco-postgres
    docker build . -t flexsolution/alfresco-postgres:201707
    
# Start 

Run docker container:

    docker run --name alfresco -d -p 8080:8080 flexsolution/alfresco-postgres:201707

# Connect to container

    docker exec -it alfresco bash

# Clarifications

**This Docker image exposes the following ports:**

* 8080 - for HTTP protocol
* 8443 - for HTTPS protocol
* 21 - for FTP protocol
* range 21000-21500 to transfer data over FTP

**Alfresco credentials for administrator:**

* username - admin
* password - admin

**Database properties:**

* db name - alfresco
* db root username - postgres
* db root password - postgres

# If you build from sources then you can

* Add additional configuration to alfresco-global.properties. To do that you have to edit file ./src/alfresco/alfresco-global.properties. Here you can add configurations for outbound email or anything else that is supported by Alfresco.
* In the file ./src/alfresco/install_opts you can change properties of jdbc and alfresco admin password. Changing other properties could broke the image
* If you need to add some jar file to ${tomcat_home}/lib then put it into ./lib folder
* You can apply some amps during the build of image, to do that put needed amps into ./src/amps and ./src/amps_share folders

# Contribute

If you want to improve the docker image then please send us a Pull Request
