# 你写的命令将在linux的命令行运行
# 对数据库residents作海量备份,备份至文件residents_bak.sql:

mysqldump -h127.0.0.1 -uroot --databases residents > residents_bak.sql