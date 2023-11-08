drop schema if exists rooms2go;
create database rooms2go;
use rooms2go;

create table person(
	ssn int,
    full_name varchar(100),
    student_flag boolean,
    staff_flag boolean,
    technician_flag boolean,
    admin_flag boolean,
    janitor_flag boolean,
    major varchar(80),
    class varchar(80),
    skeleton_card boolean,
    cleaning_materials varchar(80),
    student_id int,
    primary key (ssn),
    foreign key (student_id) references person(ssn),
    check ((student_flag is true and technician_flag is false and janitor_flag is false and cleaning_materials is null)
		OR (student_flag is false and class is null and major is null and student_id is null)),
	check ((technician_flag is true and janitor_flag is false and cleaning_materials is null)
		AND (janitor_flag is true and technician_flag is false and cleaning_materials is true))
);

create table building(
	address varchar(200),
    building_name varchar(100),
	floor int,
    primary key (address)
);

create table room(
	room_id int,
    room_name varchar(100),
    max_capaciy int,
    is_avail boolean,
    b_address varchar(200),
    primary key (room_id),
    foreign key (b_address) references building(address)
);

create table supplier(
	supplier_id int,
    supplier_name varchar(50),
    primary key (supplier_id)
);

create table room_resource(
	resource_id int,
    resource_type varchar(30),
    quantity int,
    primary key (resource_id)
);

create table card(
	card_type varchar(20),
    card_id int,
    s_no int,
    primary key (card_id),
    foreign key (s_no) references person(ssn)
);

create table scanner(
	serial_no int,
    r_id int,
    primary key (serial_no),
    foreign key (r_id) references room(room_id)
);

create table assigns_type(
	a_no int,
    r_id int,
    room_type varchar(30),
    meeting_room boolean,
    lab_room boolean,
    study_room boolean,
    foreign key (a_no) references person(ssn),
    foreign key (r_id) references room(room_id)
);

create table goes_into(
	c_id int,
    s_no int,
    foreign key (c_id) references card(card_id),
    foreign key (s_no) references scanner(serial_no)
);

create table utilized_by(
	res_id int,
    r_id int,
    foreign key (res_id) references room_resource(resource_id),
    foreign key (r_id) references room(room_id)
);

create table fixes(
	t_ssn int,
    s_no int,
    fix_time int,
    foreign key (t_ssn) references person(ssn),
    foreign key (s_no) references scanner(serial_no)
);

create table cleans(
	j_ssn int,
    r_id int,
    foreign key (j_ssn) references person(ssn),
    foreign key (r_id) references room(room_id)
);

create table supplies(
	sup_id int,
    res_id int,
    foreign key (sup_id) references supplier(supplier_id),
    foreign key (res_id) references room_resource(resource_id)
);