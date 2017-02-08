# MantisbtDocker

The Mantis BugTracker installed on CentOS 7.

### Pull image

```
docker pull openmedicus/mantisbt
```

### Using config file on host

```
mkdir -p /www/mantisbt/config
mkdir -p /www/mantisbt/plugins
```

Copy "config_inc.php" to "/www/mantisbt/config/" and make changes

Copy all plugins from the source to "/www/mantisbt/plugins"

### SELinux

```
chcon -Rt svirt_sandbox_file_t /www/
```

```
semanage port -m -t http_port_t -p tcp 8080
```


### Run

```
docker run --name=mantisbt -p 8080:80 -v /www/mantisbt/config:/var/www/html/config:rw -v /www/mantisbt/plugins:/var/www/html/plugins:rw -d openmedicus/mantisbt
```

### Systemd

/etc/systemd/system/docker-mantisbt.service

```
[Unit]
Description=PHPList container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker run --name=mantisbt -p 8080:80 -v /www/mantisbt/config:/var/www/html/config:rw -v /www/mantisbt/plugins:/var/www/html/plugins:rw openmedicus/mantisbt
ExecStop=/usr/bin/docker stop -t 2 mantisbt
ExecStopPost=/usr/bin/docker rm -f mantisbt

[Install]
WantedBy=default.target
```

Now reload systemd, enable and start
```
# systemctl daemon-reload
# systemctl enable docker-mantisbt
# systemctl start docker-mantisbt
```

### Nginx

```
upstream mantisbt.local {
    server 172.17.0.1:8080;
}

server {
        listen 80;
        server_name mantisbt.test.com;
        access_log /var/log/nginx/mantisbt.test.com.log;

        location / {
                proxy_pass       http://mantisbt.local;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto https;
                proxy_redirect   off;
        }
}

```

### Cronjob

Running cronjob in conatiner. This will run the command inside the running container.

```
docker exec -i mantisbt /bin/bash -c "/usr/bin/php /var/www/html/scripts/send_emails.php"
```
