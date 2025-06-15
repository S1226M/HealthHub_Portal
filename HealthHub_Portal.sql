-- Country Table
CREATE TABLE H_Country (
    CountryID           INT PRIMARY KEY IDENTITY(1,1),
    CountryName         NVARCHAR(100) NOT NULL
);

-- State Table
CREATE TABLE H_State (
    StateID             INT PRIMARY KEY IDENTITY(1,1),
    StateName           NVARCHAR(100) NOT NULL,
    CountryID           INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES H_Country(CountryID)
);

-- City Table
CREATE TABLE H_City (
    CityID              INT PRIMARY KEY IDENTITY(1,1),
    CityName            NVARCHAR(100) NOT NULL,
    StateID             INT NOT NULL,
    FOREIGN KEY (StateID) REFERENCES H_State(StateID)
);

-- Hospital Table
CREATE TABLE H_Hospital (
    HospitalID          INT PRIMARY KEY IDENTITY(1,1),
    HospitalName        NVARCHAR(100) NOT NULL,
    HospitalType        NVARCHAR(50),
    HospitalAddress     NVARCHAR(200),
    CityID              INT NOT NULL,
    HospitalContactNo   NVARCHAR(20),
    HospitalEmail       NVARCHAR(100),
    EstablishedDate     DATE,
    WebsiteURL          NVARCHAR(200),
    FOREIGN KEY (CityID) REFERENCES H_City(CityID)
);

-- Department Table
CREATE TABLE H_Department (
    DepartmentID        INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName      NVARCHAR(100) NOT NULL,
    HospitalID          INT NOT NULL,
    FOREIGN KEY (HospitalID) REFERENCES H_Hospital(HospitalID)
);

-- Doctor Table
CREATE TABLE H_Doctor (
    DoctorID                INT PRIMARY KEY IDENTITY(1,1),
    DoctorName              NVARCHAR(100) NOT NULL,
    DoctorPhotoURL          NVARCHAR(200),
    ConsultationFee         DECIMAL(10, 2),
    DoctorEmail             NVARCHAR(100),
    DoctorContactNo         NVARCHAR(20),
    DoctorGender            NVARCHAR(10),
    DepartmentID            INT NOT NULL,
    HospitalID              INT NOT NULL,
    DoctorSpecialization    NVARCHAR(100),
    DoctorExperienceYears   INT,
    AvailableTimeSlots      NVARCHAR(200),
    Rating                  FLOAT DEFAULT 0.0,
    FOREIGN KEY (DepartmentID) REFERENCES H_Department(DepartmentID),
    FOREIGN KEY (HospitalID) REFERENCES H_Hospital(HospitalID)
);

-- Medicine Table
CREATE TABLE H_Medicine (
    MedicineID             INT PRIMARY KEY IDENTITY(1,1),
    MedicineName           NVARCHAR(100) NOT NULL,
    MedicineGenericName    NVARCHAR(100),
    MedicineBrand          NVARCHAR(100),
    MedicineCategory       NVARCHAR(100),
    MedicinePrice          DECIMAL(10, 2),
    MedicineDescription    NVARCHAR(MAX),
    MedicineDosage         NVARCHAR(50),
    MedicineUnit           NVARCHAR(50)
);

-- User Table
CREATE TABLE H_User (
    UserID             INT PRIMARY KEY IDENTITY(1,1),
    UserName           NVARCHAR(100) NOT NULL,
    UserEmail          NVARCHAR(100),
    UserContactNo      NVARCHAR(20),
    UserRole           NVARCHAR(20) CHECK (UserRole IN ('Admin', 'Staff', 'Patient')),
    UserPassword       NVARCHAR(100),
    IsAdmin            BIT DEFAULT 0,
    IsStaff            BIT DEFAULT 0
);

-- Appointment Table
CREATE TABLE H_Appointment (
    AppointmentID            INT PRIMARY KEY IDENTITY(1,1),
    UserID                   INT NOT NULL,
    DoctorID                 INT NOT NULL,
    HospitalID               INT NOT NULL,
    AppointmentDateTime      DATETIME NOT NULL,
    AppointmentStatus        NVARCHAR(20) DEFAULT 'Scheduled',
    Symptoms                 NVARCHAR(MAX),
    AppointmentCreatedDate   DATETIME DEFAULT GETDATE(),
    AppointmentExpireDate    DATETIME,
    FOREIGN KEY (UserID) REFERENCES H_User(UserID),
    FOREIGN KEY (DoctorID) REFERENCES H_Doctor(DoctorID),
    FOREIGN KEY (HospitalID) REFERENCES H_Hospital(HospitalID)
);

-- Payment Table
CREATE TABLE H_Payment (
    PaymentID         INT PRIMARY KEY IDENTITY(1,1),
    UserID            INT NOT NULL,
    DoctorID          INT NOT NULL,
    AppointmentID     INT NOT NULL,
    PaymentUPI_ID     NVARCHAR(100),
    PaymentAmount     DECIMAL(10, 2),
    PaymentDate       DATETIME DEFAULT GETDATE(),
    PaymentStatus     NVARCHAR(20) DEFAULT 'Pending',
    PaymentMethod     NVARCHAR(50),
    PaymentCurrency   NVARCHAR(10),
    FOREIGN KEY (UserID) REFERENCES H_User(UserID),
    FOREIGN KEY (DoctorID) REFERENCES H_Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES H_Appointment(AppointmentID)
);

-- Review Table
CREATE TABLE H_Review (
    ReviewID         INT PRIMARY KEY IDENTITY(1,1),
    UserID           INT NOT NULL,
    DoctorID         INT NULL,
    HospitalID       INT NULL,
    Rating           INT DEFAULT 0,
    ReviewText       NVARCHAR(MAX),
    ReviewDate       DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES H_User(UserID),
    FOREIGN KEY (DoctorID) REFERENCES H_Doctor(DoctorID),
    FOREIGN KEY (HospitalID) REFERENCES H_Hospital(HospitalID)
);

-- Prescription Table
CREATE TABLE H_Prescription (
    PrescriptionID     INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID      INT NOT NULL,
    DoctorID           INT NOT NULL,
    UserID             INT NOT NULL,
    DatePrescribed     DATETIME DEFAULT GETDATE(),
    Notes              NVARCHAR(MAX),
    FOREIGN KEY (AppointmentID) REFERENCES H_Appointment(AppointmentID),
    FOREIGN KEY (DoctorID) REFERENCES H_Doctor(DoctorID),
    FOREIGN KEY (UserID) REFERENCES H_User(UserID)
);

-- Appointment Cancellation Log
CREATE TABLE H_AppointmentCancellationLog (
    LogID              INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID      INT NOT NULL,
    CanceledBy         NVARCHAR(20) CHECK (CanceledBy IN ('User', 'Doctor', 'Admin')),
    CancellationReason NVARCHAR(MAX),
    CancellationDate   DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AppointmentID) REFERENCES H_Appointment(AppointmentID)
);

-- Emergency Table
CREATE TABLE H_Emergency (
    EmergencyID      INT PRIMARY KEY IDENTITY(1,1),
    UserID           INT NOT NULL,
    HospitalID       INT NOT NULL,
    EmergencyType    NVARCHAR(100),
    Description      NVARCHAR(MAX),
    EmergencyStatus  NVARCHAR(20) DEFAULT 'Pending',
    RequestTime      DATETIME DEFAULT GETDATE(),
    ResponseTime     DATETIME NULL,
    FOREIGN KEY (UserID) REFERENCES H_User(UserID),
    FOREIGN KEY (HospitalID) REFERENCES H_Hospital(HospitalID)
);
