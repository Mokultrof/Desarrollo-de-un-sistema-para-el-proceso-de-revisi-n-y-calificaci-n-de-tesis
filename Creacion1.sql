


CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellidos NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(100) NOT NULL UNIQUE,
    Contraseña NVARCHAR(255) NOT NULL,
    TipoUsuario NVARCHAR(50) NOT NULL CHECK (TipoUsuario IN ('Estudiante', 'Secretario', 'Asesor', 'Jurado', 'Director'))
);

CREATE TABLE SolicitudAsesor (
    SolicitudID INT IDENTITY(1,1) PRIMARY KEY,
    EstudianteID INT NOT NULL,
    FechaSolicitud DATE NOT NULL,
    Estado NVARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Aprobada', 'Rechazada')),
    FOREIGN KEY (EstudianteID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE AsignacionAsesor (
    AsignacionID INT IDENTITY(1,1) PRIMARY KEY,
    SolicitudID INT NOT NULL,
    AsesorID INT NOT NULL,
    FechaAsignacion DATE NOT NULL,
    Estado NVARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Aceptada', 'Rechazada')),
    FOREIGN KEY (SolicitudID) REFERENCES SolicitudAsesor(SolicitudID),
    FOREIGN KEY (AsesorID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE Tesis (
    TesisID INT IDENTITY(1,1) PRIMARY KEY,
    EstudianteID INT NOT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    Resumen NVARCHAR(MAX) NOT NULL,
    AreaInvestigacion NVARCHAR(100) NOT NULL,
    DocumentoPDF VARBINARY(MAX) NOT NULL, 
    Estado NVARCHAR(50) NOT NULL CHECK (Estado IN ('Subida', 'En Revisión', 'Aprobada', 'Rechazada')),
    FOREIGN KEY (EstudianteID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE JuradoTesis (
    JuradoTesisID INT IDENTITY(1,1) PRIMARY KEY,
    TesisID INT NOT NULL,
    JuradoID INT NOT NULL,
    FechaAsignacion DATE NOT NULL,
    FOREIGN KEY (TesisID) REFERENCES Tesis(TesisID),
    FOREIGN KEY (JuradoID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE InformeRevision (
    InformeID INT IDENTITY(1,1) PRIMARY KEY,
    TesisID INT NOT NULL,
    JuradoID INT NOT NULL,
    FechaRevision DATE NOT NULL,
    Comentarios NVARCHAR(MAX) NOT NULL,
    Estado NVARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Aprobada', 'Rechazada')),
    FOREIGN KEY (TesisID) REFERENCES Tesis(TesisID),
    FOREIGN KEY (JuradoID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE Notificaciones (
    NotificacionID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    Mensaje NVARCHAR(255) NOT NULL,
    FechaEnvio DATE NOT NULL,
    Leida BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
