CREATE DATABASE netflix
GO
USE netflix
GO
-- ************************************** "Title"
    CREATE TABLE "Title"
    (
     "id"            int NOT NULL IDENTITY(1,1) ,
     "imdb_id"       int NOT NULL ,
     "genre"         varchar(200) NOT NULL ,
     "primaryTitle"  varchar(200) NULL ,
     "originalTitle" varchar(200) NULL ,
     "isAdult"       bit NULL ,
     "startYear"     int NULL ,
     "endYear"       int NULL ,
     "runtime"       int NULL ,
     "created_at"    datetime DEFAULT CURRENT_TIMESTAMP
    
     CONSTRAINT "PK_Title" PRIMARY KEY CLUSTERED ("id" ASC),
    );
    GO

-- ************************************** "Temp"
    CREATE TABLE "Temp"
    (
     "id"            int NOT NULL IDENTITY(1,1) ,
     "primaryTitle"  varchar(200) NULL , 
     CONSTRAINT "PK_Temp" PRIMARY KEY CLUSTERED ("id" ASC),
    );
    GO