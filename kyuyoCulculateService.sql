-- create database kyuyoCulculateService;

use kyuyoCulculateService;

drop table if exists Kyuyo_details;
drop table if exists Syain;
drop table if exists Zangyo;
drop table if exists Yakusyoku;
drop table if exists Bumon;


create table Kyuyo_details(
    id INT UNSIGNED,
    kihonkyu INT,
    yakusyokuTeate INT,
    tukinTeate INT,
    zangyoId INT UNSIGNED,
    zyuminzei INT,
    syakaihoken INT,
    syotokuzei INT,
    syainId INT UNSIGNED,
    siharaibi DATE,
    createdAt DATE,
    updatedAt DATE,
    deletedAt DATE
);

create table Syain(
    id INT UNSIGNED,
    name VARCHAR(50),
    bumonId INT UNSIGNED,
    yakusyokuId INT UNSIGNED,
    kihonkyu INT,
    nyusyabi DATE,
    taisyabi DATE,
    updatedAt DATE
);

create table Zangyo(
    id INT UNSIGNED,
    tuzyo INT,
    kyuzitu INT,
    sinya INT,
    syainId INT,
    nengetu DATE
);

create table Yakusyoku(
    id INT UNSIGNED,
    name VARCHAR(50),
    teate INT
);

create table Bumon(
    id INT UNSIGNED,
    name VARCHAR(50)
);

INSERT INTO Kyuyo_details(id,kihonkyu,yakusyokuTeate,tukinTeate,zangyoId,zyuminzei,syakaihoken,syotokuzei,syainId,siharaibi,createdAt,updatedAt,deletedAt)
VALUES
(1, 250000, 50000, 20000, 1, 10000, 30000, 20000, 1, '2022-04-01', NOW(), NOW(), NULL),
(2, 200000, 40000, 15000, 2, 8000, 25000, 15000, 2, '2022-04-01', NOW(), NOW(), NULL),
(3, 180000, 30000, 12000, NULL, 7000, 20000, 12000, 3, '2022-04-01', NOW(), NOW(), NULL),
(4, 300000, 60000, 25000, 3, 15000, 40000, 25000, 4, '2022-04-01', NOW(), NOW(), NULL),
(5, 250000, 50000, 20000, 1, 10000, 30000, 20000, 1, '2022-05-01', NOW(), NOW(), NULL),
(6, 200000, 40000, 15000, 2, 8000, 25000, 15000, 2, '2022-05-01', NOW(), NOW(), NULL),
(7, 180000, 30000, 12000, NULL, 7000, 20000, 12000, 3, '2022-05-01', NOW(), NOW(), NULL),
(8, 300000, 60000, 25000, 3, 15000, 40000, 25000, 4, '2022-05-01', NOW(), NOW(), NULL),
(9, 250000, 50000, 20000, 1, 10000, 30000, 20000, 1, '2022-06-01', NOW(), NOW(), NULL),
(10, 200000, 40000, 15000, 2, 8000, 25000, 15000, 2, '2022-06-01', NOW(), NOW(), NULL),
(11, 180000, 30000, 12000, NULL, 7000, 20000, 12000, 3, '2022-06-01', NOW(), NOW(), NULL),
(12, 300000, 60000, 25000, 3, 15000, 40000, 25000, 4, '2022-06-01', NOW(), NOW(), NULL),
(13, 250000, 50000, 20000, 1, 10000, 30000, 20000, 1, '2022-07-01', NOW(), NOW(), NULL),
(14, 200000, 40000, 15000, 2, 8000, 25000, 15000, 2, '2022-07-01', NOW(), NOW(), NULL);

INSERT INTO Syain(id,name,bumonId,yakusyokuId,kihonkyu,nyusyabi,taisyabi,updatedAt)
VALUES
(1, '山田 太郎', 1, 1, 250000, '2015-04-01', NULL, NOW()),
(2, '田中 次郎', 1, 2, 200000, '2016-04-01', NULL, NOW()),
(3, '佐藤 三郎', 2, 3, 180000, '2017-04-01', NULL, NOW()),
(4, '鈴木 四郎', 2, 4, 300000, '2018-04-01', NULL, NOW()),
(5, '高橋 五郎', 1, 1, 250000, '2019-04-01', NULL, NOW()),
(6, '渡辺 六郎', 1, 2, 200000, '2020-04-01', NULL, NOW()),
(7, '伊藤 七郎', 2, 3, 180000, '2021-04-01', NULL, NOW()),
(8, '加藤 八郎', 2, 4, 300000, '2022-04-01', NULL, NOW()),
(9, '木村 九郎', 3, 1, 250000, '2023-04-01', NULL, NOW()),
(10, '山本 十郎', 3, 2, 200000, '2024-04-01', NULL, NOW());


INSERT INTO Zangyo (id, tuzyo, kyuzitu, sinya, syainId, nengetu)
VALUES
(1, 2, 4, 8, 1, '2022-03-01'),
(2, 3, 6, 12, 2, '2022-03-01'),
(3, 1, 2, 4, 4, '2022-03-01'),
(4, 4, 8, 16, 1, '2022-02-01');

INSERT INTO Yakusyoku(id, name, teate)
VALUES
(1, '部長', 50000),
(2, '課長', 40000),
(3, '主任', 30000),
(4, '一般', 0);

INSERT INTO Bumon(id, name)
VALUES
(1, '営業部'),
(2, 'システム部'),
(3, '総務部');