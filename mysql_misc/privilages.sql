CREATE USER 'localuser'@'localhost' IDENTIFIED BY 'pw123';
GRANT ALL PRIVILEGES ON *.* TO 'localuser'@'localhost';
FLUSH PRIVILEGES;
