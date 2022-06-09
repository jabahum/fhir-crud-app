# Installation
This was done on a clean Ubuntu 20.4 server.

## Node JS LTS
```bash
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm
```

## Tomcat
```bash
sudo apt install tomcat9
```
## PostgreSQL
**This must be secured or people will be able to do bad things.**
```bash
sudo apt install postgresql
```

## HAPI FHIR
**This must be secured or people will be able to do bad things.**
### Create Database and User
```bash
sudo -u postgres psql
create database hapi;
create user hapi with encrypted password 'PASS';
grant all privileges on database hapi to hapi;
\q
```
### Install Maven
```bash
sudo apt install maven
```
### Compile HAPI
```bash
git clone https://github.com/hapifhir/hapi-fhir-jpaserver-starter.git
cd hapi-fhir-jpaserver-starter
```
Edit ```pom.xml``` and change the following line from hapi-fhir-jpaserver or ROOT (starting with version 5.1.0):
```xml
    <finalName>hapi</finalName>
```

#### For versions starting with 5.2.0 to the latest
Things were streamlined a bit so the values to edit are simpler.
Edit ```src/main/resources/application.yaml``` and update the following values:

```
spring:
  datasource:
    url: 'jdbc:postgresql://localhost:5432/hapi'
    username: hapi
    password: PASS
    driveClassName: org.postgresql.Driver
  jpa:
    properties:
        hibernate.search.enabled: true

hapi:
  fhir:
    fhir_version: R4
    enable_index_missing_fields: true
    tester:
       home:
        name: iHRIS
        server_address: http://localhost:8080/hapi/fhir/
        refuse_to_fetch_third_party_urls: false
        fhir_version: R4
```


#### Create war file

```bash
sudo apt install default-jdk
mvn clean install -DskipTests
sudo mkdir -p /var/lib/tomcat9/target/lucenefiles
sudo chown -R tomcat:tomcat /var/lib/tomcat9/target
sudo cp target/hapi.war /var/lib/tomcat9/webapps
```

#### Set paths in startup file
Edit ```/etc/systemd/system/multi-user.target.wants/tomcat9.service```

In the security section add the following directory with a ReadWritePath

```
ReadWritePaths=/var/lib/tomcat9/target/
```
#### Access Hapi-fhir server
Test the [hapi-fhir server](http://localhost:8080/hapi) to make sure it's running
```
http://localhost:8080/hapi
```
# Back end server

## Before starting

You'll need to run npm install when additional node modules are installed or updated
and also before starting the first time.

```bash
cd server/
npm install
```

## Development mode
Run the following to start the server in development mode.
```bash
cd server/
npm run dev
```

## Postman API document

https://documenter.getpostman.com/view/8675398/Uz5MEDqW