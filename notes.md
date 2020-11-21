## ft_server aantekeningen: 

---
### docker console commands: 

`docker build .`

> bouwt de docker container wanneer je dit in de map met de dockerfile uitvoert. 

`docker run <image_naam of hash>` 

 > runt de docker container. 

`docker run -it <image_naam of hash` 

> runt de docker container en plaatst je in de console van de container, zodat je kan rondkijken en cmds kan uitvoeren. 

`docker image list`

> laat alle docker images zien

`docker system prune -a`

> verwijdert alle containers en images, kan soms je probleem met je image oplossen
---
### dockerfile aantekeningen:  
`FROM <distro_naam>:<distro_versie>`
> de distro en versie die je wilt installeren.

`MAINTAINER <maintainer naam> < <maintainer email> >`
> hier kan je je naam neerzetten en je email.

`RUN <command>`
> hier kan je een command uitvoeren voordat de container is gebouwd.

`CMD <command>`
> hier kan je een command uitvoeren nadat de container is gebouwd

`COPY <og_path> <dest_path>`
> kopieer iets van buiten de container in de container.

meer info @ https://docs.docker.com/engine/reference/builder/

---