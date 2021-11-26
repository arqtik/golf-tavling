DROP DATABASE IF EXISTS GolfTävling;
CREATE DATABASE GolfTävling;
USE GolfTävling;

create table spelare(
	pnr char(13),
	namn varchar(20),
    ålder smallint,
    primary key(pnr)
)engine=innodb;

create table jacka(
	initialer char(2),
    storlek varchar(10),
    material varchar(100),
    pnr char(13),
    primary key(pnr, material),
    foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table konstruktion(
	serialNr varchar(100),
    hårdhet tinyint,
    primary key(serialNr)
)engine=innodb;

create table klubba(
	nr smallint,
    material varchar(80),
    konstruktionNr varchar(100),
    pnr char(13),
    primary key(pnr, nr),
    foreign key(pnr) references spelare(pnr)
)engine=innodb;

create table tävling(
	namn varchar(255),
    datum date,
    primary key(namn)
)engine=innodb;

create table regn(
	typ varchar(100),
    vindstyrka decimal(10, 2),
    primary key(typ)
)engine=innodb;

create table väder(
	tidpunkt time,
    tävlingsnamn varchar(255),
    regntyp varchar(100),
    primary key(tävlingsnamn, regntyp),
    foreign key(tävlingsnamn) references tävling(namn),
    foreign key(regntyp) references regn(typ)
)engine=innodb;

create table deltagare(
	pnr char(13),
    tävlingsnamn varchar(255),
    primary key (pnr, tävlingsnamn),
    foreign key(pnr) references spelare(pnr),
    foreign key(tävlingsnamn) references tävling(namn)
)engine=innodb;

insert into spelare values
	("19941122-6386", "Johan Andersson", 25),
	("20010505-8123", "Nicklas Jansson", 19),
    ("19950721-6034", "Annika Persson", 26);
insert into tävling values ("Big Golf Cup Skövde", '2021-06-10');
insert into deltagare values
	("19941122-6386", "Big Golf Cup Skövde"),
	("20010505-8123", "Big Golf Cup Skövde"),
    ("19950721-6034", "Big Golf Cup Skövde");
insert into regn values ("hagel", 10);
insert into väder values ('15:00:00', "Big Golf Cup Skövde", "hagel");
insert into jacka values ("JA", "L", "fleece", "19941122-6386"), ("JA", "L", "goretex", "19941122-6386");
insert into konstruktion values ("H10", 10), ("H5", 5);
insert into klubba values
	("17", "trä", "H10", "20010505-8123"),
	("51", "trä", "H5", "19950721-6034"),
	("12", "metall", "H10", "19941122-6386");

#Operationer
#select ålder from spelare where pnr = "19941122-6386"
#select datum from tävling where namn = "Big Golf Cup Skövde";
#select material from klubba where pnr = "19941122-6386";
#select initialer, storlek, material from jacka where pnr = "19941122-6386";
#select pnr from deltagare where tävlingsnamn = "Big Golf Cup Skövde";
#select vindstyrka from regn where typ in (select regntyp from väder where tävlingsnamn = "Big Golf Cup Skövde");
#select * from spelare where ålder < 30;
#delete from jacka where pnr = "19941122-6386";
#select avg(ålder) from spelare;
