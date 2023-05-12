FROM  openjdk:latest
COPY . /root/petclinic
WORKDIR /root/petclinic
ENTRYPOINT java -Dserver.port=8091 -jar target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar


