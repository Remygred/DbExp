请给出ER图文件存放的URL:
https://github.com/Remygred/Graphs/blob/main/DataBase/ersolution.jpg

以下给出关系模式：
movie(movie_ID, title, type, runtime, release_date, director, starring), primary key:(movie_ID);
customer(c_ID, name, type, phone), primary key:(c_ID);
hall(hall_ID, mode, capacity, location), primary key:(hall_ID);
schedule(schedule_ID, date, time, price, number, movie_ID, hall_ID), primary key:(schedule_ID), foreign key(movie_ID, hall_ID);
ticket(ticket_ID, seat_num, schedule_ID), primary key(ticket_ID), foreign key(schedule_ID);