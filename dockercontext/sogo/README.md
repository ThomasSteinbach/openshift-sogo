# thomass/sogo
Contains the latest sogo from sogo repository.

## usage
### start production

```
docker run -d --name sogo-mysql -e MYSQL_ROOT_PASSWORD=testpw mysql
sleep 20
docker run -d --name sogo --link sogo-mysql:mysql \
           -e MYSQL_ROOT_PASSWORD=testpw \
           -e SERVER_NAME=sogo.example.com \
            thomass/sogo
docker run -d --name sogo-httpd --volumes-from sogo --link sogo:sogo -p 81:80 httpd
```

### add / remove user

```
docker exec -it sogo addsogouser
docker exec -it sogo delsogouser
```

### backup /restore

```
docker exec sogo backup
docker exec sogo restore
```

## variables

variable            | default   | description
------------------- | --------- | ---------------------------------------------------
MYSQL_ROOT_PASSWORD | sogo      | the database password used in the mysql container
SERVER_PROTOCOL     | http      | http or https
SERVER_NAME         | localhost | the domain under which you server would be accessed
SERVER_PORT         | 80        | the port the server is called from outside

## Configuring SOGo
Get the untouched config file from the sogo installation:

```
docker run --rm thomass/sogo cat /etc/sogo/sogo.conf > sogo.conf
```

Edit the file and propagate it to the container (as volume or via a data volume container or via `docker cp`).

Do not overwrite folloging configuration items, otherwise the default setup won't work:
- SOGoProfileURL
- OCSFolderInfoURL
- OCSSessionsFolderURL
- SOGoUserSources
- WOPort

## Volumes
Volumes suitable for a data volume container are:
- /backups
- /var/log/sogo
- /etc/sogo

## Licence
The whole repository is licenced under BSD. Please mention following:

github.com/ThomasSteinbach (thomass at aikq.de)
