FROM jenkins/jenkins:lts-jdk11


ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

USER root
RUN  apt update && apt install maven -y
USER jenkins
COPY --chown=jenkins:jenkins config/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY --chown=jenkins:jenkins config/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins config/casc.yaml /var/jenkins_home/casc.yaml
EXPOSE 8080
EXPOSE 50000
