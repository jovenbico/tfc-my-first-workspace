
### Run Postgresql
```
docker pull postgres:14.6-alpine
```

```
docker run --name my-postgres -e POSTGRES_PASSWORD=t0p-s3cr3t -p 5432:5432 -d postgres:14.6-alpine
```

#### Get container IP address
```
docker container inspect -f '{{ .NetworkSettings.IPAddress }}' my-postgres
```