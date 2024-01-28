DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS step;
DROP TABLE IF EXISTS project_category;
DROP TABLE IF EXISTS unit;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS project;

CREATE TABLE project (
	project_id INT AUTO_INCREMENT NOT NULL,
	notes TEXT,
	project_name VARCHAR(128) NOT NULL,
    pestimated_hours DECIMAL(7,2),
    actual_hours DECIMAL(7,2),
    difficulty INT,
    PRIMARY KEY (project_id),
  
  
    num_servings INT,
    prep_time TIME,
    cook_time TIME,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  

);

CREATE TABLE category (
  category_id INT AUTO_INCREMENT NOT NULL,
  category_name VARCHAR(64) NOT NULL,
  PRIMARY KEY (category_id)f
);

CREATE TABLE unit (
  unit_id INT AUTO_INCREMENT NOT NULL,
  unit_name_singular VARCHAR(32) NOT NULL,
  unit_name_plural VARCHAR(34) NOT NULL,
  PRIMARY KEY (unit_id)
);

CREATE TABLE project_category (
  project_id INT NOT NULL,
  category_id INT NOT NULL,
  FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE CASCADE,
  UNIQUE KEY (project_id, category_id)
);

CREATE TABLE step (
  step_id INT AUTO_INCREMENT NOT NULL,
  project_id INT NOT NULL,
  step_order INT NOT NULL,
  step_text TEXT NOT NULL,
  PRIMARY KEY (step_id),
  FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE
);

CREATE TABLE ingredient (
  ingredient_id INT AUTO_INCREMENT NOT NULL,
  project_id INT NOT NULL,
  unit_id INT NOT NULL,
  ingredient_name VARCHAR(64) NOT NULL,
  instruction VARCHAR(64),
  ingredient_order INT NOT NULL,
  amount DECIMAL(7, 2),
  PRIMARY KEY (ingredient_id),
  FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE,
  FOREIGN KEY (unit_id) REFERENCES unit (unit_id)
);





