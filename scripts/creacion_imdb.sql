CREATE DATABASE imdb
GO
USE imdb
-- ************************************** "Category"
    CREATE TABLE "Category"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_Category" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "TitleType"
    CREATE TABLE "TitleType"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_TitleType" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "Genre"
    CREATE TABLE "Genre"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_Genre" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "Region"
    CREATE TABLE "Region"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_Region" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "Language"
    CREATE TABLE "Language"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_Language" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "AlternativeType"
    CREATE TABLE "AlternativeType"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_AlternativeType" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "AlternativeAttribute"
    CREATE TABLE "AlternativeAttribute"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_AlternativeAttribute" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "Profession"
    CREATE TABLE "Profession"
    (
     "id"   int NOT NULL IDENTITY(1,1) ,
     "name" varchar(200) NULL ,
    
     CONSTRAINT "PK_Profession" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "Name"
    CREATE TABLE "Name"
    (
     "id"          int NOT NULL IDENTITY(1,1) ,
     "primaryName" varchar(200) NULL ,
     "birthYear"   int NULL ,
     "deathYear"   int NULL ,
    
     CONSTRAINT "PK_Name" PRIMARY KEY CLUSTERED ("id" ASC)
    );
    GO

-- ************************************** "NameProfession"
    CREATE TABLE "NameProfession"
    (
     "nameId"       int NOT NULL ,
     "professionId" int NOT NULL ,
    
     CONSTRAINT "FK_NameProfession_Profession" FOREIGN KEY ("professionId")  REFERENCES "Profession"("id"),
     CONSTRAINT "FK_NameProfession_Name" FOREIGN KEY ("nameId")  REFERENCES "Name"("id")
    );
    GO

-- ************************************** "Title"
    CREATE TABLE "Title"
    (
     "id"            int NOT NULL IDENTITY(1,1) ,
     "titleTypeId"   int NOT NULL ,
     "primaryTitle"  varchar(200) NULL ,
     "originalTitle" varchar(200) NULL ,
     "isAdult"       bit NULL ,
     "startYear"     int NULL ,
     "endYear"       int NULL ,
     "runtime"       int NULL ,
    
     CONSTRAINT "PK_Title" PRIMARY KEY CLUSTERED ("id" ASC),
     CONSTRAINT "FK_Title_TitleType" FOREIGN KEY ("titleTypeId")  REFERENCES "TitleType"("id")
    );
    GO

-- ************************************** "TitleGenre"
    CREATE TABLE "TitleGenre"
    (
     "titleId" int NOT NULL ,
     "genreId" int NOT NULL ,
    
     CONSTRAINT "FK_TitleGenre_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id"),
     CONSTRAINT "FK_TitleGenre_Genre" FOREIGN KEY ("genreId")  REFERENCES "Genre"("id")
    );
    GO

-- ************************************** "AlternativeTitle"
    CREATE TABLE "AlternativeTitle"
    (
     "id"                     int NOT NULL IDENTITY(1,1) ,
     "titleId"                int NOT NULL ,
     "regionId"               int NOT NULL ,
     "languageId"             int NOT NULL ,
     "alternativeTypeId"      int NOT NULL ,
     "alternativeAttributeId" int NOT NULL ,
    
     CONSTRAINT "PK_AlternativeTitle" PRIMARY KEY CLUSTERED ("id" ASC),
     CONSTRAINT "FK_AlternativeTitle_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id"),
     CONSTRAINT "FK_AlternativeTitle_Region" FOREIGN KEY ("regionId")  REFERENCES "Region"("id"),
     CONSTRAINT "FK_AlternativeTitle_Language" FOREIGN KEY ("languageId")  REFERENCES "Language"("id"),
     CONSTRAINT "FK_AlternativeTitle_AlternativeType" FOREIGN KEY ("alternativeTypeId")  REFERENCES "AlternativeType"("id"),
     CONSTRAINT "FK_AlternativeTitle_AlternativeAttribute" FOREIGN KEY ("alternativeAttributeId")  REFERENCES "AlternativeAttribute"("id")
    );
    GO

-- ************************************** "Rating"
    CREATE TABLE "Rating"
    (
     "id"            int NOT NULL IDENTITY(1,1) ,
     "titleId"       int NOT NULL ,
     "averageRating" float NULL ,
     "numVotes"      int NULL ,
    
     CONSTRAINT "PK_Rating" PRIMARY KEY CLUSTERED ("id" ASC),
     CONSTRAINT "FK_Rating_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id")
    );
    GO
    
-- ************************************** "Episode"
    CREATE TABLE "Episode"
    (
     "id"       int NOT NULL IDENTITY(1,1) ,
     "titleId"  int NOT NULL ,
     "parentId" int NOT NULL ,
     "season"   int NULL ,
     "episode"  int NULL ,
    
     CONSTRAINT "PK_Episode" PRIMARY KEY CLUSTERED ("id" ASC),
     CONSTRAINT "FK_Episode_Title1" FOREIGN KEY ("titleId")  REFERENCES "Title"("id"),
     CONSTRAINT "FK_Episode_Title2" FOREIGN KEY ("parentId")  REFERENCES "Title"("id")
    );
    GO

-- ************************************** "Writer"
    CREATE TABLE "Writer"
    (
     "nameId"  int NOT NULL ,
     "titleId" int NOT NULL ,
    
     CONSTRAINT "FK_Writer_Name" FOREIGN KEY ("nameId")  REFERENCES "Name"("id"),
     CONSTRAINT "FK_Writer_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id")
    );
    GO

-- ************************************** "Director"
    CREATE TABLE "Director"
    (
     "nameId"  int NOT NULL ,
     "titleId" int NOT NULL ,
    
     CONSTRAINT "FK_Director_Name" FOREIGN KEY ("nameId")  REFERENCES "Name"("id"),
     CONSTRAINT "FK_Director_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id")
    );
    GO

-- ************************************** "Principal"
    CREATE TABLE "Principal"
    (
     "id"         int NOT NULL IDENTITY(1,1) ,
     "nameId"     int NOT NULL ,
     "titleId"    int NOT NULL ,
     "categoryId" int NOT NULL ,
     "jobId"      int NULL ,
     "order"      int NULL ,
     "character"  varchar(200) NULL ,
    
     CONSTRAINT "PK_Principal" PRIMARY KEY CLUSTERED ("id" ASC),
     CONSTRAINT "FK_Principal_Name" FOREIGN KEY ("nameId")  REFERENCES "Name"("id"),
     CONSTRAINT "FK_Principal_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id"),
     CONSTRAINT "FK_Principal_Category" FOREIGN KEY ("categoryId")  REFERENCES "Category"("id")
    );
    GO

-- ************************************** "KnowForTitle"
    CREATE TABLE "KnowForTitle"
    (
     "nameId"  int NOT NULL ,
     "titleId" int NOT NULL ,
    
     CONSTRAINT "FK_KnowForTitle_Name" FOREIGN KEY ("nameId")  REFERENCES "Name"("id"),
     CONSTRAINT "FK_KnowForTitle_Title" FOREIGN KEY ("titleId")  REFERENCES "Title"("id")
    );
    GO
