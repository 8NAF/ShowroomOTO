USE master
GO
DROP DATABASE QUANLISHOWROOMXEHOI
go

CREATE DATABASE QUANLISHOWROOMXEHOI
GO

USE QUANLISHOWROOMXEHOI
GO



CREATE TABLE Account
(
	ID INT IDENTITY (0,1) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Chưa có tên.',
	UserName NVARCHAR(100) NOT NULL UNIQUE,
	PassWord NVARCHAR(500) NOT NULL DEFAULT '0',
	Type INT NOT NULL DEFAULT 0 --1 :admin , 0 :staff.
)
GO

INSERT dbo.Account(
		 DisplayName ,
          UserName ,
          PassWord ,
          Type
        )
VALUES  (
			 N'' , -- DisplayName - nvarchar(100)
          N'' , -- UserName - nvarchar(100)
          N'' , -- PassWord - nvarchar(500)
          0  -- Type - int
        )

CREATE TABLE CustomerInfo
(
	ID INT IDENTITY (0,1) PRIMARY KEY ,
	IdentityCardNumber VARCHAR(10) NOT NULL UNIQUE,--CMND
	Name NVARCHAR(50) NOT NULL,--họ ten
	Sex INT NOT NULL DEFAULT 1,--1: nam, 0 nữ
	Birthday DATE NOT NULL,
	NumberPhone VARCHAR(11),
	Address NVARCHAR(150) NOT NULL
)
GO



INSERT dbo.CustomerInfo
        ( IdentityCardNumber ,
		Name,
          Sex ,
          Birthday ,
          NumberPhone ,
          Address
        )
VALUES  ( '' , -- IdentityCardNumber - varchar(10)
          N' ' , -- Surname - varchar(20)
          1 , -- Sex - int
          '' , -- Birthday - date
          '' , -- NumberPhone - varchar(11)
          N''  -- Address - nvarchar(150)
        )

INSERT dbo.CustomerInfo
        ( IdentityCardNumber ,
		name,
          Sex ,
          Birthday ,
          NumberPhone ,
          Address
        )
VALUES  ( '281415958' , -- IdentityCardNumber - varchar(10)
          N'Biên' , -- Surname - varchar(20)
          0 , -- Sex - int
          '01/09/1995' , -- Birthday - date
          '123456789' , -- NumberPhone - varchar(11)
          N'đáqưdưq 21 21'  -- Address - nvarchar(150)
        )

INSERT dbo.CustomerInfo
        ( IdentityCardNumber ,
		name,
          Sex ,
          Birthday ,
          NumberPhone ,
          Address
        )
VALUES  ( '281415928' , -- IdentityCardNumber - varchar(10)
          N'Biên 2' , -- Surname - varchar(20)
          0 , -- Sex - int
          '01/09/2010' , -- Birthday - date
          '123456789' , -- NumberPhone - varchar(11)
          N'đáqưdưq 21 21'  -- Address - nvarchar(150)
        )

INSERT dbo.CustomerInfo
        ( IdentityCardNumber ,
		name,
          Sex ,
          Birthday ,
          NumberPhone ,
          Address
        )
VALUES  ( '281115928' , -- IdentityCardNumber - varchar(10)
          N'Biên 3' , -- Surname - varchar(20)
          0 , -- Sex - int
          '01/09/2002' , -- Birthday - date
          '123456789' , -- NumberPhone - varchar(11)
          N'đáqưdưq 21 21'  -- Address - nvarchar(150)
        )

INSERT dbo.CustomerInfo
        ( IdentityCardNumber ,
		name,
          Sex ,
          Birthday ,
          NumberPhone ,
          Address
        )
VALUES  ( '281111928' , -- IdentityCardNumber - varchar(10)
          N'quang dũng' , -- Surname - varchar(20)
          1 , -- Sex - int
          '01/09/2000' , -- Birthday - date
          '123456789' , -- NumberPhone - varchar(11)
          N'đáqưdưq 21 21'  -- Address - nvarchar(150)
        )

go

CREATE TABLE Producer
(
	ID INT IDENTITY PRIMARY KEY ,
	ProducerName NVARCHAR( 30) NOT NULL DEFAULT N'Chưa có tên.',
	Logo VARCHAR(100) NOT NULL

)
GO
--car
CREATE TABLE Car(
	ID INT IDENTITY PRIMARY KEY ,
	CarName nVARCHAR(100) NOT NULL DEFAULT N'Chưa có tên.',
	IDProducer INT NOT NULL ,
	ImageOfCar VARCHAR(100) NOT NULL

	FOREIGN KEY (IDProducer) REFERENCES dbo.Producer(ID)
)
GO 





CREATE TABLE InstanceOfCar
(
	ID INT IDENTITY PRIMARY KEY,
	IDCar INT NOT NULL,
	WarehousingDate DATETIME NOT NULL DEFAULT GETDATE(),
	Color NVARCHAR(20) NOT NULL,
	ImageOfInstance  VARCHAR(100) NOT NULL ,
	ChassisNumber VARCHAR(15) NOT NULL UNIQUE,
	MachineNumber VARCHAR(15) NOT NULL UNIQUE,
	EntryPrice DECIMAL NOT NULL DEFAULT 0,
	Price DECIMAL NOT NULL DEFAULT 0,
	Status INT NOT NULL DEFAULT 1 ,-- 1 : chưa bán, 0 : Đã bán
	IDOwnedCustomer INT DEFAULT 0

	FOREIGN KEY (IDCar) REFERENCES dbo.Car(ID),
	FOREIGN KEY (IDOwnedCustomer) REFERENCES dbo.CustomerInfo(ID)
)
go


CREATE TABLE AccessoryOfCar
(
	ID INT IDENTITY PRIMARY KEY,
	IDCar INT NOT NULL,
	AccessoryName nVARCHAR(50) NOT NULL,
	Image VARCHAR(50) NOT NULL,
	UnitPrice DECIMAL NOT NULL DEFAULT 0,
	Amount INT NOT NULL DEFAULT 0

	FOREIGN KEY (IDCar) REFERENCES dbo.Car(ID)
)
GO



CREATE TABLE InventoryOfAccessory
(
	ID INT IDENTITY PRIMARY KEY ,
	IDAccessory INT NOT NULL,
	WarehousingDate DATETIME NOT NULL DEFAULT GETDATE(),
	EntryUnitPrice DECIMAL NOT NULL,
	Amount INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (IDAccessory) REFERENCES dbo.AccessoryOfCar(ID)
)
 


CREATE TABLE SpecificDescriptionOfCar
(
	ID INT PRIMARY KEY IDENTITY,
	IDCar INT NOT NULL,
	TypeOfCar NVARCHAR(25) NOT NULL,
	NumberOfSeat INT NOT NULL DEFAULT 0,
	TypeOfEngine NVARCHAR(50),
	Gear NVARCHAR(50),
	CylinderCapacity VARCHAR(15),
	MaxPower VARCHAR(30),
	MaxMomen VARCHAR(30),
	FuelSystem NVARCHAR(30),
	PetrolTankCapacity VARCHAR(10),
	UrbanConsumption VARCHAR(20),
	NonurbanConsumption VARCHAR(20),
	CombinationConsumption VARCHAR(20),
	FrontBrake NVARCHAR(25),
	RearBrake NVARCHAR(25),
	Length NVARCHAR(20),
	Height NVARCHAR(20),
	Width NVARCHAR(20),
	Weight NVARCHAR(20)

	FOREIGN KEY (IDCar) REFERENCES dbo.Car(ID)
)
go

--bill:
CREATE TABLE Bill
(
	ID INT IDENTITY PRIMARY KEY ,
	CreateDate DATETIME NOT NULL DEFAULT GETDATE(),
	IDCustomer INT NOT NULL,
	IDStaff INT DEFAULT 0,--ID nhân viên bán hàng
	ValueOfBill DECIMAL NOT NULL,
	Status INT NOT NULL DEFAULT 1 -- 0: da thanh toan , 1 : chua thanh toan

	FOREIGN KEY (IDCustomer) REFERENCES dbo.CustomerInfo(ID),
	FOREIGN KEY (IDStaff) REFERENCES dbo.Account(ID)
)
GO



CREATE TABLE BillInfoDetails
(
	ID INT IDENTITY PRIMARY KEY,
	IDBill INT NOT NULL,
	IDInstanceOfCar INT DEFAULT NULL,
	CarName nVARCHAR(100) ,
	IDAccessoryOfCar INT DEFAULT NULL,
	AccessoryName nVARCHAR(50)  ,
	UnitPrice DECIMAL NOT NULL DEFAULT 0,
	Amount INT NOT NULL DEFAULT 1,
	ValueOfPrice DECIMAL NOT NULL

	FOREIGN KEY (IDInstanceOfCar) REFERENCES dbo.InstanceOfCar(ID),
	FOREIGN KEY (IDAccessoryOfCar) REFERENCES dbo.AccessoryOfCar(ID),
	FOREIGN KEY (IDBill) REFERENCES dbo.Bill(ID)
)
--Guarantee
CREATE TABLE Guarantee
(
	ID INT IDENTITY PRIMARY KEY,
	IDCustomer INT NOT NULL,
	IDInstanceOfCar INT NOT NULL,
	GuaranteeDate DATETIME NOT NULL DEFAULT GETDATE(),
	ContentOfGuarantee NVARCHAR(200) NOT NULL DEFAULT N''

	FOREIGN KEY (IDCustomer)REFERENCES dbo.CustomerInfo(ID),
	FOREIGN KEY (IDInstanceOfCar)REFERENCES dbo.InstanceOfCar(ID)
)
--Order
CREATE TABLE OrderList
(
	ID INT IDENTITY PRIMARY KEY,
	CreateDate DATETIME NOT NULL DEFAULT GETDATE(),
	DeliveryDate DATETIME NOT NULL DEFAULT GETDATE(),
	IDCustomer INT NOT NULL,
	IDInstanceOfCar INT DEFAULT NULL,
	IDAccessoryOfCar INT DEFAULT NULL,
	Status INT NOT NULL DEFAULT 0,--0: Chưa giao hàng,1: Đã giao hàng,-1: Quá hạn.
	
	FOREIGN KEY (IDInstanceOfCar)REFERENCES dbo.InstanceOfCar(ID),
	FOREIGN KEY (IDAccessoryOfCar)REFERENCES dbo.AccessoryOfCar(ID),
	FOREIGN KEY (IDCustomer)REFERENCES dbo.CustomerInfo(ID)
)

INSERT INTO dbo.Account
        ( DisplayName ,
          UserName ,
          PassWord ,
          Type
        )
VALUES  ( N'Nguyễn Đức Biên' , -- DisplayName - nvarchar(100)
          N'biennguyen13' , -- UserName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(500)
          1  -- Type - int
        )

INSERT INTO dbo.Account
        ( DisplayName ,
          UserName ,
          PassWord ,
          Type
        )
VALUES  ( N'Nguyễn Đức Biên' , -- DisplayName - nvarchar(100)
          N'biennguyen' , -- UserName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(500)
          0  -- Type - int
        )
--------Producer
INSERT INTO dbo.Producer
        ( ProducerName, Logo )
VALUES  ( N'Honda', -- ProducerName - nvarchar(30)
          'Honda-logo.png'  -- Logo - varchar(100)
          )

INSERT INTO dbo.Producer
        ( ProducerName, Logo )
VALUES  ( N'Suzuki', -- ProducerName - nvarchar(30)
          'suzuki-logo.png'  -- Logo - varchar(100)
          )

INSERT INTO dbo.Producer
        ( ProducerName, Logo )
VALUES  ( N'Toyota', -- ProducerName - nvarchar(30)
          'logo-toyota.png'  -- Logo - varchar(100)
          )

INSERT INTO dbo.Producer
        ( ProducerName, Logo )
VALUES  ( N'Ford', -- ProducerName - nvarchar(30)
          'ford-logo.png'  -- Logo - varchar(100)
          )

INSERT INTO dbo.Producer
        ( ProducerName, Logo )
VALUES  ( N'Chevrolet', -- ProducerName - nvarchar(30)
          'Chevrolet-logo.png'  -- Logo - varchar(100)
          )
---------------Car
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Chevrolet Orlando', -- CarName - nvarchar(100)
          5, -- IDProducer - int
          'chevrolet_orlando_black.jpg'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 1 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          5 , -- NumberOfSeat - int
          N'1.8L SOHC i-VTEC, 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Vô cấp CVT , ứng dụng EARTH DREAM TECHNOLOGY' , -- Gear - nvarchar(50)
          '1799 cm3' , -- CylinderCapacity - varchar(15)
          '140 hp/6000 rpm' , -- MaxPower - varchar(30)
          ' 175 NM/4300 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '47 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4630 mm' , -- Length - nvarchar(20)
          N'1416 mm' , -- Height - nvarchar(20)
          N'1799 mm' , -- Width - nvarchar(20)
          N'1261 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 1 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đen' , -- Color - nvarchar(20)
          'chevrolet_orlando_black.jpg' , -- ImageOfInstance - varchar(100)
          'CN1332' , -- ChassisNumber - varchar(15)
          'MN1332' , -- MachineNumber - varchar(15)
          500000000 , -- EntryPrice - decimal
          550000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 1 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Trắng' , -- Color - nvarchar(20)
          'chevrolet-orlando-white.jpg' , -- ImageOfInstance - varchar(100)
          'CN1333' , -- ChassisNumber - varchar(15)
          'MN1333' , -- MachineNumber - varchar(15)
          505000000 , -- EntryPrice - decimal
          555000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )


---------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Chevrolet Trailblazer', -- CarName - nvarchar(100)
          5, -- IDProducer - int
          'chevrolet-trailblazer-white.jpg'  -- ImageOfCar - varchar(100)
          )

--

INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 2 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          6 , -- NumberOfSeat - int
          N'2.5L SOHC i-VTEC, 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Vô cấp CVT , ứng dụng EARTH DREAM TECHNOLOGY' , -- Gear - nvarchar(50)
          '2499 cm3' , -- CylinderCapacity - varchar(15)
          '210 hp/6000 rpm' , -- MaxPower - varchar(30)
          ' 500 NM/4300 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '80 lit' , -- PetrolTankCapacity - varchar(10)
          '10.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '5.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '8.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'5000 mm' , -- Length - nvarchar(20)
          N'1916 mm' , -- Height - nvarchar(20)
          N'2199 mm' , -- Width - nvarchar(20)
          N'2261 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 2 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đỏ' , -- Color - nvarchar(20)
          'chevrolet-trailblazer-red.JPG' , -- ImageOfInstance - varchar(100)
          'CN1334' , -- ChassisNumber - varchar(15)
          'MN1334' , -- MachineNumber - varchar(15)
          605000000 , -- EntryPrice - decimal
          655000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 2 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Trắng' , -- Color - nvarchar(20)
          'chevrolet-trailblazer-white.jpg' , -- ImageOfInstance - varchar(100)
          'CN1335' , -- ChassisNumber - varchar(15)
          'MN1335' , -- MachineNumber - varchar(15)
          610000000 , -- EntryPrice - decimal
          665000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
-----------------------

INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Ford Everest', -- CarName - nvarchar(100)
          4, -- IDProducer - int
          'ford-everest-white.jpg'  -- ImageOfCar - varchar(100)
          )
--

INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 3 , -- IDCar - int
          N'SUV' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'2.0L SOHC i-VTEC, 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1999 cm3' , -- CylinderCapacity - varchar(15)
          '190 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 250 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '60 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4500 mm' , -- Length - nvarchar(20)
          N'1700 mm' , -- Height - nvarchar(20)
          N'1800 mm' , -- Width - nvarchar(20)
          N'1890 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 3 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đen' , -- Color - nvarchar(20)
          'ford-everest-black.jpg' , -- ImageOfInstance - varchar(100)
          'CN1336' , -- ChassisNumber - varchar(15)
          'MN1336' , -- MachineNumber - varchar(15)
          1005000000 , -- EntryPrice - decimal
          1155000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 3 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Trắng' , -- Color - nvarchar(20)
          'ford-everest-white.jpg' , -- ImageOfInstance - varchar(100)
          'CN1337' , -- ChassisNumber - varchar(15)
          'MN1337' , -- MachineNumber - varchar(15)
          1005000000 , -- EntryPrice - decimal
          1155000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
----------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Ford Newfocus', -- CarName - nvarchar(100)
          4, -- IDProducer - int
          'ford-newfocus-blue.jpeg'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 4 , -- IDCar - int
          N'SUV' , -- TypeOfCar - nvarchar(25)
          6 , -- NumberOfSeat - int
          N'2.0L SOHC i-VTEC, 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1999 cm3' , -- CylinderCapacity - varchar(15)
          '190 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 250 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '60 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4500 mm' , -- Length - nvarchar(20)
          N'1700 mm' , -- Height - nvarchar(20)
          N'1800 mm' , -- Width - nvarchar(20)
          N'1890 kg'  -- Weight - nvarchar(20)
        )


INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 4 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Xanh Dương' , -- Color - nvarchar(20)
          'ford-newfocus-blue.jpeg' , -- ImageOfInstance - varchar(100)
          'CN1338' , -- ChassisNumber - varchar(15)
          'MN1338' , -- MachineNumber - varchar(15)
          705000000 , -- EntryPrice - decimal
          755000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 4 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Nâu' , -- Color - nvarchar(20)
          'ford-newfocus-brown.jpg' , -- ImageOfInstance - varchar(100)
          'CN1339' , -- ChassisNumber - varchar(15)
          'MN1339' , -- MachineNumber - varchar(15)
          705000000 , -- EntryPrice - decimal
          755000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
-------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Honda City', -- CarName - nvarchar(100)
          1, -- IDProducer - int
          'honda-city-black.png'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 5 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 5 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đen' , -- Color - nvarchar(20)
          'honda-city-black.png' , -- ImageOfInstance - varchar(100)
          'CN1355' , -- ChassisNumber - varchar(15)
          'MN1355' , -- MachineNumber - varchar(15)
          405000000 , -- EntryPrice - decimal
          445000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 5, -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Nâu' , -- Color - nvarchar(20)
          'honda-city-brown.png' , -- ImageOfInstance - varchar(100)
          'CN1340' , -- ChassisNumber - varchar(15)
          'MN1340' , -- MachineNumber - varchar(15)
          405000000 , -- EntryPrice - decimal
          445000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 5, -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Trắng' , -- Color - nvarchar(20)
          'honda-city-white.png' , -- ImageOfInstance - varchar(100)
          'CN1341' , -- ChassisNumber - varchar(15)
          'MN1341' , -- MachineNumber - varchar(15)
          405000000 , -- EntryPrice - decimal
          445000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
-------------------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Honda Civic', -- CarName - nvarchar(100)
          1, -- IDProducer - int
          'honda-civic-darkblue.jpg'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 6 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 6 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Xanh Đen' , -- Color - nvarchar(20)
          'honda-civic-darkblue.jpg' , -- ImageOfInstance - varchar(100)
          'CN1342' , -- ChassisNumber - varchar(15)
          'MN1342' , -- MachineNumber - varchar(15)
          655000000 , -- EntryPrice - decimal
          695000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 6 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Xám' , -- Color - nvarchar(20)
          'honda-civic-gray.jpg' , -- ImageOfInstance - varchar(100)
          'CN1343' , -- ChassisNumber - varchar(15)
          'MN1343' , -- MachineNumber - varchar(15)
          655000000 , -- EntryPrice - decimal
          694000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 6 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đỏ' , -- Color - nvarchar(20)
          'honda-civic-red.jpg' , -- ImageOfInstance - varchar(100)
          'CN1344' , -- ChassisNumber - varchar(15)
          'MN1344' , -- MachineNumber - varchar(15)
          655000000 , -- EntryPrice - decimal
          695000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
-------------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Suzuki Celerio', -- CarName - nvarchar(100)
          2, -- IDProducer - int
          'suzuki-celerio-blue.jpg'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 7 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 7 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Xanh' , -- Color - nvarchar(20)
          'suzuki-celerio-blue.jpg' , -- ImageOfInstance - varchar(100)
          'CN1345' , -- ChassisNumber - varchar(15)
          'MN1345' , -- MachineNumber - varchar(15)
          355000000 , -- EntryPrice - decimal
          395000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 7 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đỏ' , -- Color - nvarchar(20)
          'suzuki-celerio-red.png' , -- ImageOfInstance - varchar(100)
          'CN1346' , -- ChassisNumber - varchar(15)
          'MN1346' , -- MachineNumber - varchar(15)
          355000000 , -- EntryPrice - decimal
          395000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 7 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Trắng' , -- Color - nvarchar(20)
          'suzuki-celerio-white.jpg' , -- ImageOfInstance - varchar(100)
          'CN1347' , -- ChassisNumber - varchar(15)
          'MN1347' , -- MachineNumber - varchar(15)
          355000000 , -- EntryPrice - decimal
          395000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
--------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Suzuki Ciaz', -- CarName - nvarchar(100)
          2, -- IDProducer - int
          'Suzuki-ciaz-brown.jpg'  -- ImageOfCar - varchar(100)
          )
--
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 8 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 8 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đỏ' , -- Color - nvarchar(20)
          'suzuki-ciaz-red.jpg' , -- ImageOfInstance - varchar(100)
          'CN1348' , -- ChassisNumber - varchar(15)
          'MN1348' , -- MachineNumber - varchar(15)
          445000000 , -- EntryPrice - decimal
          495000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 8 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Nâu' , -- Color - nvarchar(20)
          'suzuki-ciaz-brown.jpg' , -- ImageOfInstance - varchar(100)
          'CN1349' , -- ChassisNumber - varchar(15)
          'MN1349' , -- MachineNumber - varchar(15)
          445000000 , -- EntryPrice - decimal
          495000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
--------------------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Toyota Fortuner', -- CarName - nvarchar(100)
          3, -- IDProducer - int
          'toyota-fortuner-black.png'  -- ImageOfCar - varchar(100)
          )
INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 9 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 9 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đen' , -- Color - nvarchar(20)
          'toyota-fortuner-black.png' , -- ImageOfInstance - varchar(100)
          'CN1350' , -- ChassisNumber - varchar(15)
          'MN1350' , -- MachineNumber - varchar(15)
          885000000 , -- EntryPrice - decimal
          945000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 9 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Nâu' , -- Color - nvarchar(20)
          'toyota-fortuner-brown.png' , -- ImageOfInstance - varchar(100)
          'CN1351' , -- ChassisNumber - varchar(15)
          'MN1351' , -- MachineNumber - varchar(15)
          885000000 , -- EntryPrice - decimal
          945000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 9 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Bạc' , -- Color - nvarchar(20)
          'toyota-fortuner-silver.png' , -- ImageOfInstance - varchar(100)
          'CN1352' , -- ChassisNumber - varchar(15)
          'MN1352' , -- MachineNumber - varchar(15)
          885000000 , -- EntryPrice - decimal
          945000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
----------------------
INSERT INTO dbo.Car
        ( CarName, IDProducer, ImageOfCar )
VALUES  ( N'Toyota Innova Ventuner', -- CarName - nvarchar(100)
          3, -- IDProducer - int
          'toyota-innova-ventuner-black.png'  -- ImageOfCar - varchar(100)
          )

INSERT dbo.SpecificDescriptionOfCar
        ( IDCar ,
          TypeOfCar ,
          NumberOfSeat ,
          TypeOfEngine ,
          Gear ,
          CylinderCapacity ,
          MaxPower ,
          MaxMomen ,
          FuelSystem ,
          PetrolTankCapacity ,
          UrbanConsumption ,
          NonurbanConsumption ,
          CombinationConsumption ,
          FrontBrake ,
          RearBrake ,
          Length ,
          Height ,
          Width ,
          Weight
        )
VALUES  ( 10 , -- IDCar - int
          N'Xe Con' , -- TypeOfCar - nvarchar(25)
          7 , -- NumberOfSeat - int
          N'1.5L DOHC , 4 xi-lanh thẳng hàng, 16 van' , -- TypeOfEngine - nvarchar(50)
          N'Số sàn 6 cấp' , -- Gear - nvarchar(50)
          '1489 cm3' , -- CylinderCapacity - varchar(15)
          '170 hp/6500 rpm' , -- MaxPower - varchar(30)
          ' 200 NM/4500 rpm' , -- MaxMomen - varchar(30)
          N'Phun xăng điện tử' , -- FuelSystem - nvarchar(30)
          '50 lit' , -- PetrolTankCapacity - varchar(10)
          '8.5 lit/ 100km' , -- UrbanConsumption - varchar(20)
          '4.8 lit/ 100km' , -- NonurbanConsumption - varchar(20)
          '6.2 lit/ 100km' , -- CombinationConsumption - varchar(20)
          N'Thắng Đĩa' , -- FrontBrake - nvarchar(25)
          N'Thắng Đĩa' , -- RearBrake - nvarchar(25)
          N'4200 mm' , -- Length - nvarchar(20)
          N'1400 mm' , -- Height - nvarchar(20)
          N'1500 mm' , -- Width - nvarchar(20)
          N'1290 kg'  -- Weight - nvarchar(20)
        )


INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 10 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đen' , -- Color - nvarchar(20)
          'toyota-innova-ventuner-black.png' , -- ImageOfInstance - varchar(100)
          'CN1353' , -- ChassisNumber - varchar(15)
          'MN1353' , -- MachineNumber - varchar(15)
          785000000 , -- EntryPrice - decimal
          845000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )

INSERT dbo.InstanceOfCar
        ( IDCar ,
          WarehousingDate ,
          Color ,
          ImageOfInstance ,
          ChassisNumber ,
          MachineNumber ,
          EntryPrice ,
          Price ,
          Status ,
          IDOwnedCustomer
        )
VALUES  ( 10 , -- IDCar - int
          GETDATE() , -- WarehousingDate - datetime
          N'Đỏ' , -- Color - nvarchar(20)
          'toyota-innova-ventuner-red.png' , -- ImageOfInstance - varchar(100)
          'CN1354' , -- ChassisNumber - varchar(15)
          'MN1354' , -- MachineNumber - varchar(15)
          785000000 , -- EntryPrice - decimal
          845000000 , -- Price - decimal
          1 , -- Status - int
          0 -- IDOwnedCustomer - int
        )
---------------
INSERT dbo.AccessoryOfCar
        ( IDCar ,
          AccessoryName ,
          Image ,
          UnitPrice
        )
VALUES  ( 1, -- IDCar - int
          N'Vành bánh trước' , -- AccessoryName - nvarchar(50)
          'mam xe.JPG' , -- Image - varchar(50)
          1000000  -- UnitPrice - decimal
        )

INSERT dbo.AccessoryOfCar
        ( IDCar ,
          AccessoryName ,
          Image ,
          UnitPrice
        )
VALUES  ( 1, -- IDCar - int
          N'Hộp số' , -- AccessoryName - nvarchar(50)
          'linh kien.jpg' , -- Image - varchar(50)
          12500000  -- UnitPrice - decimal
        )
go

CREATE TRIGGER Trigger_InsertInventoryAccessory
ON dbo.InventoryOfAccessory FOR INSERT
AS
BEGIN

	DECLARE @amount INT
	DECLARE @idAccessory int

	SELECT @amount = inserted.amount , @idAccessory = inserted.idaccessory FROM inserted

	UPDATE dbo.AccessoryOfCar SET amount += @amount WHERE ID = @idAccessory

END
go

INSERT dbo.InventoryOfAccessory
        ( IDAccessory ,
          WarehousingDate ,
          EntryUnitPrice ,
          Amount
        )
VALUES  ( 1 , -- IDAccessory - int
          GETDATE() , -- WarehousingDate - datetime
          800000 , -- EntryUnitPrice - decimal
          10  -- Amount - int
        )

INSERT dbo.InventoryOfAccessory
        ( IDAccessory ,
          WarehousingDate ,
          EntryUnitPrice ,
          Amount
        )
VALUES  ( 2 , -- IDAccessory - int
          GETDATE() , -- WarehousingDate - datetime
          10000000 , -- EntryUnitPrice - decimal
          10  -- Amount - int
        )

INSERT dbo.InventoryOfAccessory
        ( IDAccessory ,
          WarehousingDate ,
          EntryUnitPrice ,
          Amount
        )
VALUES  ( 2 , -- IDAccessory - int
          GETDATE() , -- WarehousingDate - datetime
          10000000 , -- EntryUnitPrice - decimal
          10  -- Amount - int
        )
go
---------------------
CREATE PROC StoreProc_UpdateInstanceOfCarById @iD int,  @iDCar int, @warehousingDate datetime,@color nvarchar(20),
	          @imageOfInstance varchar(100),@chassisNumber  varchar(15), @machineNumber varchar(15), @entryPrice decimal, @price  decimal
	          , @status  int,  @iDOwnedCustomer  int
AS
BEGIN
	UPDATE dbo.InstanceOfCar
	SET IDCar = @idCar, WarehousingDate = @warehousingDate, Color = @color, ImageOfInstance = @imageOfInstance, ChassisNumber = @chassisNumber,
	MachineNumber = @machineNumber, EntryPrice = @entryPrice, Price = @price, Status =@status, IDOwnedCustomer = @iDOwnedCustomer
	WHERE id = @id
END

go


---------------
CREATE PROC StoreProc_GetInfoDetailsOfCarById @idCar int 
AS
BEGIN
	SELECT *
	FROM dbo.SpecificDescriptionOfCar
	WHERE IDCar = @idCar
 END
GO

---------------
CREATE PROC StoreProc_UpdateSpecificDescriptionOfCarById 
			  @idSpec INT , 
			  @TypeOfCar nvarchar(25),
	          @NumberOfSeat  int,
	          @TypeOfEngine nvarchar(50),
	          @Gear nvarchar(50),
	          @CylinderCapacity varchar(15),
	          @MaxPower varchar(30),
	          @MaxMomen varchar(30),
	          @FuelSystem nvarchar(30),
	          @PetrolTankCapacity  varchar(10),
	          @UrbanConsumption  varchar(20),
	          @NonurbanConsumption  varchar(20),
	          @CombinationConsumption  varchar(20),
	          @FrontBrake  nvarchar(25),
	          @RearBrake  nvarchar(25),
	          @Length  nvarchar(20),
	          @Height  nvarchar(20),
	          @Width nvarchar(20),
	          @Weight  nvarchar(20)
AS
BEGIN
	
	UPDATE dbo.SpecificDescriptionOfCar 
	SET TypeOfCar = @TypeOfCar, NumberOfSeat =@NumberOfSeat,TypeOfEngine =@TypeOfEngine,Gear =@Gear,CylinderCapacity=@CylinderCapacity,
		MaxPower=@MaxPower,MaxMomen=@MaxMomen,FuelSystem=@FuelSystem,PetrolTankCapacity=@PetrolTankCapacity,UrbanConsumption=@UrbanConsumption,
		NonurbanConsumption=@NonurbanConsumption,CombinationConsumption=@CombinationConsumption,FrontBrake=@FrontBrake,RearBrake=@RearBrake,
        Length=@Length,Height=@Height,Width=@Width,Weight=@Weight
	WHERE ID = @idSpec
END


go
---------------

CREATE PROC StoreProc_Login @username nvarchar(100), @password nvarchar(500)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username AND PassWord = @password
END
GO
---------------
CREATE PROC StoreProc_UpdateCarById @iD INT , @carName nvarchar(100) , @iDProducer  INT, @imageOfCar varchar(100)
AS
BEGIN
	
	UPDATE dbo.Car
	SET CarName = @carName, IDProducer = @iDProducer, ImageOfCar = @imageOfCar
	WHERE ID = @iD

END

EXEC dbo.StoreProc_UpdateCarById @iD , @carName , @iDProducer , @imageOfCar
go

---------------
CREATE PROC StoreProc_GetAccountByUsername @userName Nvarchar(100)
AS
begin
	SELECT * FROM dbo.Account WHERE UserName = @username
END
GO
---------------
CREATE PROC StoreProc_GetAccessoryByCarId @idCar INT
AS
BEGIN

	SELECT AccessoryOfCar.ID,AccessoryName,Image,UnitPrice,Amount AS sumamount
	FROM dbo.AccessoryOfCar 
	WHERE IDCar = @idCar
END
go
------------------
CREATE PROC Store_ProcDeleteCarById @idCar int
AS
BEGIN

	IF NOT EXISTS (SELECT * FROM dbo.InstanceOfCar WHERE IDCar = @idCar)
		BEGIN
			DELETE dbo.SpecificDescriptionOfCar WHERE IDCar = @idCar
			DELETE dbo.Car WHERE id = @idCar
		END	
END
go

------------------
CREATE PROC StoreProc_InsertInstanceOfCar @iDCar int , @color nvarchar(20) , @imageOfInstance varchar(100) , @chassisNumber varchar(15) , @machineNumber varchar(15) , @entryPrice decimal , @price decimal
AS
BEGIN

	INSERT dbo.InstanceOfCar
	        ( IDCar ,
	          WarehousingDate ,
	          Color ,
	          ImageOfInstance ,
	          ChassisNumber ,
	          MachineNumber ,
	          EntryPrice ,
	          Price ,
	          Status ,
	          IDOwnedCustomer
	        )
	VALUES  ( @idCar , -- IDCar - int
	          GETDATE() , -- WarehousingDate - datetime
	          @color , -- Color - nvarchar(20)
	          @imageOfInstance , -- ImageOfInstance - varchar(100)
	          @chassisNumber , -- ChassisNumber - varchar(15)
	          @machineNumber , -- MachineNumber - varchar(15)
	          @entryPrice , -- EntryPrice - decimal
	          @price , -- Price - decimal
	          1 , -- Status - int
	          0  -- IDOwnedCustomer - int
	        )

END
go

---------------
CREATE PROC Store_ProcInsertNewSpec @idCar int
AS
BEGIN
	INSERT dbo.SpecificDescriptionOfCar
	        ( IDCar ,
	          TypeOfCar ,
	          NumberOfSeat ,
	          TypeOfEngine ,
	          Gear ,
	          CylinderCapacity ,
	          MaxPower ,
	          MaxMomen ,
	          FuelSystem ,
	          PetrolTankCapacity ,
	          UrbanConsumption ,
	          NonurbanConsumption ,
	          CombinationConsumption ,
	          FrontBrake ,
	          RearBrake ,
	          Length ,
	          Height ,
	          Width ,
	          Weight
	        )
	VALUES  ( @idCar , -- IDCar - int
	          N'' , -- TypeOfCar - nvarchar(25)
	          0 , -- NumberOfSeat - int
	          N'' , -- TypeOfEngine - nvarchar(50)
	          N'' , -- Gear - nvarchar(50)
	          '' , -- CylinderCapacity - varchar(15)
	          '' , -- MaxPower - varchar(30)
	          '' , -- MaxMomen - varchar(30)
	          N'' , -- FuelSystem - nvarchar(30)
	          '' , -- PetrolTankCapacity - varchar(10)
	          '' , -- UrbanConsumption - varchar(20)
	          '' , -- NonurbanConsumption - varchar(20)
	          '' , -- CombinationConsumption - varchar(20)
	          N'' , -- FrontBrake - nvarchar(25)
	          N'' , -- RearBrake - nvarchar(25)
	          N'' , -- Length - nvarchar(20)
	          N'' , -- Height - nvarchar(20)
	          N'' , -- Width - nvarchar(20)
	          N''  -- Weight - nvarchar(20)
	        )
END
GO
----

CREATE PROC Store_ProcInsertAccessoryAndInventoryOfAccessory @iDCar int , @accessoryName nvarchar(50) , @image varchar(50) , @unitPrice DECIMAL , @entryUnitPrice DECIMAL , @amount INT
AS
BEGIN

	INSERT dbo.AccessoryOfCar
	        ( IDCar ,
	          AccessoryName ,
	          Image ,
	          UnitPrice
	        )
	VALUES  ( @idCar , -- IDCar - int
	          @accessoryName , -- AccessoryName - nvarchar(50)
	         @image, -- Image - varchar(50)
	          @unitPrice  -- UnitPrice - decimal
	        )

	DECLARE @maxId INT

	SELECT @maxId = MAX(ID) FROM dbo.AccessoryOfCar
	
	INSERT dbo.InventoryOfAccessory
	        ( IDAccessory ,
	          WarehousingDate ,
	          EntryUnitPrice ,
	          Amount
	        )
	VALUES  ( @maxId , -- IDAccessory - int
	          GETDATE() , -- WarehousingDate - datetime
	          @entryUnitPrice , -- EntryUnitPrice - decimal
	          @amount  -- Amount - int
	        )
END
go

------------------
CREATE PROC StoreProc_DeleteAccessoryById @id int
AS
BEGIN

	DELETE dbo.InventoryOfAccessory WHERE IDAccessory = @id
	DELETE dbo.AccessoryOfCar WHERE ID =@id

END
EXEC dbo.StoreProc_GetAccessoryByCarId @idCar = 1 -- int
GO

-----------------
create PROC StoreProc_AddCarForBill @idCar int , @carName NVARCHAR(50) , @price DECIMAL , @idBill INT , @idCustomer int
AS
BEGIN

	IF not EXISTS ( SELECT * FROM dbo.InstanceOfCar WHERE ID = @idCar AND ( Status = 0 OR IDOwnedCustomer != 0))
	begin
	INSERT dbo.BillInfoDetails
	        ( IDBill ,
	          IDInstanceOfCar ,
			  CarName,
	          IDAccessoryOfCar ,
			  AccessoryName,
	          UnitPrice ,
			  Amount,
	          ValueOfPrice
	        )
	VALUES  ( @idBill , -- IDBill - int
	          @idCar , -- IDInstanceOfCar - int
			  @carName,
	          NULL , -- IDAccessoryOfCar - int
			  NULL,
	          @price , -- UnitPrice - decimal
			  1,
	          @price  -- ValueOfPrice - decimal
	        )

	UPDATE dbo.InstanceOfCar SET IDOwnedCustomer = @idCustomer WHERE ID = @idCar

	UPDATE dbo.Bill SET ValueOfBill += @price WHERE ID = @idbill

	end
END
GO

-----------------
create PROC StoreProc_AddAccessoryForBill @idAccessory int , @accessoryName NVARCHAR(50) , @unitprice DECIMAL , @amount INT , @idBill INT
AS
BEGIN
	
	IF NOT EXISTS ( SELECT * FROM dbo.BillInfoDetails WHERE IDBill = @idBill AND IDAccessoryOfCar = @idAccessory)
		BEGIN
			INSERT dbo.BillInfoDetails
	        ( IDBill ,
	          IDInstanceOfCar ,
			  CarName,
	          IDAccessoryOfCar ,
			  AccessoryName,
	          UnitPrice ,
	          Amount ,
	          ValueOfPrice
	        )
			VALUES  ( @idBill , -- IDBill - int
	          null , -- IDInstanceOfCar - int
			  NULL,
	          @idAccessory , -- IDAccessoryOfCar - int
			  @accessoryName,
	          @unitprice , -- UnitPrice - decimal
	          @amount , -- Amount - int
	          @amount * @unitprice  -- ValueOfPrice - decimal
	        )
		END
            
	ELSE
		BEGIN
            UPDATE dbo.BillInfoDetails SET Amount += @amount  , ValueOfPrice += @amount * UnitPrice WHERE IDBill = @idBill AND IDAccessoryOfCar  = @idAccessory
		END
            
	UPDATE dbo.AccessoryOfCar SET Amount -= @amount WHERE ID = @idAccessory

	UPDATE dbo.Bill SET ValueOfBill += @amount*@unitprice  WHERE ID = @idbill

END
GO

----------------
CREATE PROC StoreProc_PayTheBill @idBill int , @idStaff int
AS BEGIN
		
	update bill set status = 0 , IDStaff = @idStaff where id = @idBill

	UPDATE dbo.InstanceOfCar 
	SET Status = 0 
	WHERE ID IN (
				SELECT IDInstanceOfCar 
				FROM dbo.BillInfoDetails 
				WHERE IDBill = @idBill 
				AND IDInstanceOfCar IS NOT NULL
				)

end



SELECT * 
FROM dbo.AccessoryOfCar

SELECT * 
FROM dbo.InventoryOfAccessory
