FROM eclipse-temurin:11-jdk

COPY [".", "/usr/src"]

WORKDIR /usr/src

RUN chmod +x mvnw
RUN ./mvnw clean verify

EXPOSE 8080

CMD ["java", "-jar","target/react-and-spring-data-rest-0.0.1-SNAPSHOT.jar"]