echo "Running apt-get"
sudo apt-get install libxml2 libxml2-dev python-dev libxslt1-dev python-virtualenv python-pip postgresql postgresql-server-dev-9.1 rabbitmq-server libldap2-dev
echo "Copying celery scripts"
sudo cp django-mantis/quickstart_files/celery/celeryd_config /etc/default/celeryd
sudo cp django-mantis/quickstart_files/celery/celeryd_initscript /etc/init.d/celeryd
sudo chmod uoa+x /etc/init.d/celeryd
echo "Configuring postgres"
sudo -i -u postgres
/etc/init.d/postgresql start 
psql --command "CREATE USER mantis WITH PASSWORD 'mantis';"
psql --command "ALTER USER mantis CREATEDB;"
psql --command "CREATE DATABASE django OWNER mantis ENCODING 'UTF-8';"
echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.1/main/pg_hba.conf
echo "Switching back to mantis user"
exit
cd /home/mantis/ti

#echo "listen_addresses='*'" >> /etc/postgresql/9.1/main/postgresql.conf
