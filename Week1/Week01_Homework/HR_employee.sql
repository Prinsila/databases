use hr;
create table locations (
location_id int auto_increment primary key,
city varchar(50) not null,
postal_code varchar(10),
state_province varchar(20),
country varchar(10)
);
insert into locations (city, postal_code, state_province, country) values
('Stockholm', '11012', 'Stockholm Country', 'Sweden'),
('Malmö', '31237', 'Skåne Country', 'Sweden'),
('Kristianstad', '15012', 'Skane Country', 'Sweden'),
('Uppsala', '75106', 'Uppsala County', 'Sweden'),
('Västerås', '72212', 'Västmanland County', 'Sweden'),
('Örebro', '70210', 'Örebro County', 'Sweden'),
('Linköping', '58222', 'Östergötland County', 'Sweden'),
('Helsingborg', '25222', 'Skåne County', 'Sweden'),
('Jönköping', '55305', 'Jönköping County', 'Sweden'),
('Norrköping', '60223', 'Östergötland County', 'Sweden');
SELECT* FROM locations;
select city from locations;


CREATE TABLE employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
INSERT INTO employee (first_name, last_name, email, phone_number, hire_date, job_title, salary, location_id) VALUES
('Anna', 'peterson', 'anna@gmail.com', '0721234578', '2020-01-15', 'Manager', 80000, 1),
('sara', 'samuelson', 'sara@gmail.com', '0762357412', '2019-03-22', 'Developer', 60000, 2),
('per', 'Johnson', 'per@gmail.com', '0723986515', '2021-07-19', 'Analyst', 50000, 3),
('Emily', 'Davidson', 'emily@gmail.com', '07661236985', '2018-11-05', 'Designer', 55000, 4),
('peter', 'franson', 'peter@gmail.com', '07891597412', '2017-05-30', 'Administrator', 45000, 5),
('Anna', 'Willson', 'anna.willson@gmail.com', '07765421364', '2020-09-12', 'HR', 48000, 6),
('David', 'halby', 'david@gmail.com', '07458956314', '2021-01-18', 'Consultant', 53000, 7),
('Laura', 'Anderson', 'laura.anderson@gmail.com', '07234523697', '2019-02-14', 'Developer', 62000, 8),
('Robert', 'peterson', 'robert@gmail.com', '0705168874', '2020-04-21', 'Manager', 78000, 9),
('Sarah', 'Jackson', 'sarah@gmail.com', '0734567899', '2018-08-11', 'Support', 40000, 10);
desc locations;
desc employee;
select * from locations;