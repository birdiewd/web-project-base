#!/bin/bash

echo "=> Granting database permissions to 'root'"
mysql -uroot -psuperAdmin -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION"

echo "=> Creating database user 'admin'"
mysql -uroot -psuperAdmin -e "DROP USER IF EXISTS 'admin'@'%'"
mysql -uroot -psuperAdmin -e "DROP USER IF EXISTS 'admin'@'localhost'"
mysql -uroot -psuperAdmin -e "FLUSH PRIVILEGES"
mysql -uroot -psuperAdmin -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin'"

echo "=> Granting database permissions to 'admin'"
mysql -uroot -psuperAdmin -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

# corrects issue with clients not connecting correctly
mysql -uroot -psuperAdmin -e "ALTER USER 'admin'@'%' IDENTIFIED WITH mysql_native_password BY 'admin'"

echo ""
echo ""
echo "=============================="
echo ""
echo ""
echo "Server is up and ready to use."
echo ""
echo ""
echo "=============================="
echo ""
