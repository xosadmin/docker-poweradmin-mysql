## Docker-poweradmin-mysql  
A docker container for Poweradmin and MySQL
  
Usage:  
- Run from Dockerhub:  
``docker run -d --restart=always -p 8080:80 xosadmin/docker-poweradmin-mysql``

Notes:   
- Online installation is required after container is running. For installation, open the browser and access ``http://<server-address>:8080``.  
- After installation, use ``docker exec -it <container-name> rm -rf /var/www/html/install`` to remove install folder.
- If the existing ``config.inc.php`` available, the parameter ``-v /path/to/config:/var/www/html/inc/config.inc.php`` can be used to adopt current config.  
- Or, ``vim`` is available for create this file in container.
  
For other instructions and issues, please refer to https://github.com/poweradmin/poweradmin.  
  