use newlibrary;

CREATE TABLE employee_position(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_employee INT NOT NULL,
    position TEXT NOT NULL,
	update_date DATE NOT NULL,
    FOREIGN KEY (id_employee) REFERENCES employee(id)
);

CREATE TRIGGER tg_update_employee_position
BEFORE UPDATE ON employee 
FOR EACH ROW 
INSERT INTO employee_position
SET id_employee = OLD.id,
	position = NEW.position,
    update_date = CURRENT_DATE();


UPDATE employee
SET position = 'Phó giám đốc'
WHERE id = 196156140;