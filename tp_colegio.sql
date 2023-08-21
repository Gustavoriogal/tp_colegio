CREATE TABLE Alumnos (
    ID_alumno INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(100)
);

CREATE TABLE Profesores (
    ID_profesor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(100),
    especialidad VARCHAR(50)
);

CREATE TABLE Aulas (
    ID_aula INT PRIMARY KEY,
    capacidad INT,
    descripcion VARCHAR(100)
);

CREATE TABLE Materias (
    ID_materia INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);

CREATE TABLE Clases (
    ID_clase INT PRIMARY KEY,
    ID_aula INT,
    ID_profesor INT,
    ID_materia INT,
    horario VARCHAR(50),
    FOREIGN KEY (ID_aula) REFERENCES Aulas(ID_aula),
    FOREIGN KEY (ID_profesor) REFERENCES Profesores(ID_profesor),
    FOREIGN KEY (ID_materia) REFERENCES Materias(ID_materia)
);

CREATE TABLE Inscripciones (
    ID_inscripcion INT PRIMARY KEY,
    ID_alumno INT,
    ID_clase INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (ID_alumno) REFERENCES Alumnos(ID_alumno),
    FOREIGN KEY (ID_clase) REFERENCES Clases(ID_clase)
);

CREATE TABLE Pagos (
    ID_pago INT PRIMARY KEY,
    ID_alumno INT,
    monto DECIMAL(10, 2),
    fecha_pago DATE,
    FOREIGN KEY (ID_alumno) REFERENCES Alumnos(ID_alumno)
);



INSERT INTO Alumnos (ID_alumno, nombre, apellido, fecha_nacimiento, direccion, telefono, correo_electronico)
VALUES
    (1, 'Juan', 'Pérez', '2000-05-15', 'Calle 123, Ciudad', '123456789', 'juan@example.com'),
    (2, 'María', 'Gómez', '2001-09-20', 'Avenida 456, Pueblo', '987654321', 'maria@example.com');


INSERT INTO Profesores (ID_profesor, nombre, apellido, fecha_nacimiento, direccion, telefono, correo_electronico, especialidad)
VALUES
    (1, 'Luis', 'Martínez', '1985-02-10', 'Otra Calle 789, Ciudad', '456789123', 'luis@example.com', 'Matemáticas'),
    (2, 'Ana', 'López', '1980-12-03', 'Otro Lugar 10, Pueblo', '987123456', 'ana@example.com', 'Historia');


INSERT INTO Aulas (ID_aula, capacidad, descripcion)
VALUES
    (1, 30, 'Aula para clases teóricas'),
    (2, 25, 'Aula de laboratorio');


INSERT INTO Materias (ID_materia, nombre, descripcion)
VALUES
    (1, 'Matemáticas', 'Matemáticas básicas'),
    (2, 'Historia', 'Historia del mundo antiguo');


INSERT INTO Clases (ID_clase, ID_aula, ID_profesor, ID_materia, horario)
VALUES
    (1, 1, 1, 1, 'Lunes 10:00 - 12:00'),
    (2, 2, 2, 2, 'Miércoles 14:00 - 16:00');


INSERT INTO Inscripciones (ID_inscripcion, ID_alumno, ID_clase, fecha_inscripcion)
VALUES
    (1, 1, 1, '2023-08-10'),
    (2, 2, 2, '2023-08-11');


INSERT INTO Pagos (ID_pago, ID_alumno, monto, fecha_pago)
VALUES
    (1, 1, 150.00, '2023-08-15'),
    (2, 2, 180.00, '2023-08-16');


SELECT * FROM Alumnos;

SELECT * FROM Profesores WHERE especialidad = 'Matemáticas';

SELECT * FROM Aulas WHERE capacidad > 25;

SELECT m.nombre AS materia, p.nombre AS profesor
FROM Materias m
JOIN Clases c ON m.ID_materia = c.ID_materia
JOIN Profesores p ON c.ID_profesor = p.ID_profesor;

SELECT c.ID_clase, COUNT(i.ID_alumno) AS cantidad_alumnos
FROM Clases c
LEFT JOIN Inscripciones i ON c.ID_clase = i.ID_clase
GROUP BY c.ID_clase;

SELECT SUM(monto) AS total_ingresos
FROM Pagos;
