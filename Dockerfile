FROM relateiq/oracle-java8

MAINTAINER www.flex-solution.com

COPY ./src/alfresco /home/alfresco/configs

RUN apt-get update \
      && apt-get install -y wget mc \
      && rm -rf /var/lib/apt/lists/*.


RUN wget https://svwh.dl.sourceforge.net/project/alfresco/Alfresco%20201707%20Community/alfresco-community-installer-201707-linux-x64.bin \
     && chmod +x ./*.bin \
     && ./alfresco-community-installer-201707-linux-x64.bin --optionfile /home/alfresco/configs/install_opts \
     && echo "\n" >> /opt/alfresco/tomcat/shared/classes/alfresco-global.properties \
     && cat /home/alfresco/configs/alfresco-global.properties >> /opt/alfresco/tomcat/shared/classes/alfresco-global.properties

RUN rm alfresco-community-installer-201707-linux-x64.bin

COPY ./lib/*.jar /opt/alfresco/tomcat/lib/
COPY ./src/amps/* /opt/alfresco/amps/
COPY ./src/amps_share/* /opt/alfresco/amps_share/

RUN rm /opt/alfresco/amps_share/*.md
RUN rm /opt/alfresco/amps/*.md

RUN /opt/alfresco/bin/apply_amps.sh -force nowait

EXPOSE 21 8443 8080 21000-21500

VOLUME /opt/alfresco/alf_data

CMD service alfresco start && tail -f /opt/alfresco/tomcat/logs/catalina.out
