
# Скрипт создания и наполнения БД.
DROP DATABASE IF EXISTS katatest;
CREATE DATABASE katatest;
use katatest;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id         bigint not null auto_increment,
    email      varchar(255),
    name       varchar(255),
    password   varchar(255),
    surname    varchar(255),
    username   varchar(255) unique,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    is_deleted bit(1),
    primary key (id)

) COMMENT 'юзеры';

CREATE TABLE roles
(
    id   bigint not null auto_increment,
    name varchar(255),
    primary key (id)
) COMMENT 'роли'
;
CREATE TABLE users_roles
(
    user_id bigint not null,
    role_id bigint not null,
    primary key (user_id, role_id),
    FOREIGN KEY (role_id) REFERENCES roles (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
) COMMENT 'роли'
;
-- admin pass - admin, user pass - user. Ниже можно инжектить и все заработает.
INSERT INTO katatest.users (email, name, surname, password, username)
VALUES ('admin@mail.ru', 'admin', 'admin', '$2a$12$.gObBTZqFhlr27.lSrc/DuOmC7zqE5WS2V9nA0EP52xx/8/O/5JFC', 'admin');

INSERT INTO katatest.users (email, name, surname, password, username)
VALUES ('user@mail.ru', 'user', 'user', '$2a$12$dUfbnKzTLjoPmsHFl99smuPUsWiuXYn3o1l7HrELsnEQpgZJbcfty', 'user');

INSERT INTO katatest.roles (id, name) VALUE (1,'ROLE_ADMIN');
INSERT INTO katatest.roles (id, name) VALUE (2,'ROLE_USER');

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (1, 1);

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (1, 2);

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (2, 1);