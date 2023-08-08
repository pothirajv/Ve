FROM openjdk:17.0.2
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD ./mvnw cargo:run -P tomcat

