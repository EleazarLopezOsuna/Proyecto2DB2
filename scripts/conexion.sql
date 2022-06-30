-- Llamada al procedimiento para agregar un servidor
EXEC sp_addlinkedserver
      @server= 'IMDB', 
      @srvproduct='',
      @provider='SQLNCLI',
      @datasrc='34.67.89.1',
      @catalog ='imdb',
      @provstr='Integrated Security=SSPI'

-- Llamada al procedimiento para loggearnos al servidor
EXEC sp_addlinkedsrvlogin 'IMDB', 'false', NULL, 'sa', 'Myp4ssword'

-- Creacion del procedimiento que consume los datos IMDB y los inserta en NETFLIX
DROP PROCEDURE IF EXISTS InsertTitle
GO
CREATE PROCEDURE InsertTitle @primary varchar(200), @original varchar(200)
AS
BEGIN
      DECLARE @imdb_id        int
      DECLARE @genre          varchar(200)
      DECLARE @primaryTitle   varchar(200)
      DECLARE @originalTitle  varchar(200)
      DECLARE @isAdult        bit
      DECLARE @startYear      int
      DECLARE @endYear        int
      DECLARE @runtime        int
      SELECT 
            @imdb_id          = title.id,
            @genre            = genre.name,
            @primaryTitle     = title.primaryTitle,
            @originalTitle    = title.originalTitle,
            @isAdult          = title.isAdult,
            @startYear        = title.startYear,
            @endYear          = title.endYear,
            @runtime          = title.runtime
      FROM 
            [IMDB].[imdb].[dbo].Title           AS title,
            [IMDB].[imdb].[dbo].Genre           AS genre,
            [IMDB].[imdb].[dbo].TitleGenre      AS titleGenre
      WHERE
            title.primaryTitle      = @primary AND
            title.originalTitle     = @original AND
            titleGenre.titleId      = title.id AND
            titleGenre.genreId      = genre.id

      INSERT INTO Title
            (
                  imdb_id,
                  genre,
                  primaryTitle,
                  originalTitle,
                  isAdult,
                  startYear,
                  endYear,
                  runtime
            )
      VALUES
            (
                  @imdb_id,
                  @genre,
                  @primaryTitle,
                  @originalTitle,
                  @isAdult,
                  @startYear,
                  @endYear,
                  @runtime
            )

      INSERT INTO Temp
            (
                  primaryTitle
            )
      VALUES
            (
                  @primaryTitle
            )
END



-- Insertando los datos en netflix
EXEC InsertTitle @primary = 'Lord of the Rings', @original ='Lord of the Rings'
EXEC InsertTitle @primary = 'The Hobbit', @original ='The Hobbit'
EXEC InsertTitle @primary = 'About Time', @original ='About Time'
EXEC InsertTitle @primary = 'Frozen', @original ='Frozen'
EXEC InsertTitle @primary = 'How I Met Your Mother', @original ='How I Met Your Mother'
EXEC InsertTitle @primary = 'Pilot', @original ='Pilot'
EXEC InsertTitle @primary = 'Finding Nemo', @original = 'Finding Nemo'
EXEC InsertTitle @primary = 'Lucky Number Slevin', @original = 'Lucky Number Slevin'
EXEC InsertTitle @primary = 'Star Trek', @original = 'Star Trek'
EXEC InsertTitle @primary = 'The Godfather', @original = 'The Godfather'
EXEC InsertTitle @primary = 'True Romance', @original = 'True Romance'
EXEC InsertTitle @primary = 'The Blues Brothers', @original = 'The Blues Brothers'
EXEC InsertTitle @primary = 'The Poseidon Adventure', @original = 'The Poseidon Adventure'
EXEC InsertTitle @primary = 'The Matrix', @original = 'The Matrix'
EXEC InsertTitle @primary = 'The Bodyguard', @original = 'The Bodyguard'
EXEC InsertTitle @primary = 'Silent Running', @original = 'Silent Running'
EXEC InsertTitle @primary = 'Gattaca', @original = 'Gattaca'
EXEC InsertTitle @primary = 'War of the Worlds', @original = 'War of the Worlds'
EXEC InsertTitle @primary = 'The Big Lebowski', @original = 'The Big Lebowski'
EXEC InsertTitle @primary = 'Braveheart', @original = 'Braveheart'
EXEC InsertTitle @primary = 'Arsenic and Old Lace', @original = 'Arsenic and Old Lace'
EXEC InsertTitle @primary = 'Broken Flowers', @original = 'Broken Flowers'
EXEC InsertTitle @primary = 'The Ring', @original = 'The Ring'
EXEC InsertTitle @primary = 'Stalag 17', @original = 'Stalag 17'
EXEC InsertTitle @primary = 'Manhattan', @original = 'Manhattan'
EXEC InsertTitle @primary = 'Cool Runnings', @original = 'Cool Runnings'
EXEC InsertTitle @primary = 'Halloween', @original = 'Halloween'
EXEC InsertTitle @primary = 'Heat', @original = 'Heat'
EXEC InsertTitle @primary = 'Rope', @original = 'Rope'
EXEC InsertTitle @primary = 'Next', @original = 'Next'
EXEC InsertTitle @primary = 'Stuck on You', @original = 'Stuck on You'
EXEC InsertTitle @primary = 'Lord of War', @original = 'Lord of War'
EXEC InsertTitle @primary = 'Superman', @original = 'Superman'
EXEC InsertTitle @primary = 'Hostage', @original = 'Hostage'
EXEC InsertTitle @primary = 'Birthday Girl', @original = 'Birthday Girl'
EXEC InsertTitle @primary = 'Romeo Must Die', @original = 'Romeo Must Die'
EXEC InsertTitle @primary = 'Lost in Space', @original = 'Lost in Space'
EXEC InsertTitle @primary = 'Stardust', @original = 'Stardust'
EXEC InsertTitle @primary = 'Cold Mountain', @original = 'Cold Mountain'
EXEC InsertTitle @primary = 'The Bounty', @original = 'The Bounty'
EXEC InsertTitle @primary = 'Backdraft', @original = 'Backdraft'
EXEC InsertTitle @primary = 'What Women Want', @original = 'What Women Want'
EXEC InsertTitle @primary = 'Sense and Sensibility', @original = 'Sense and Sensibility'
EXEC InsertTitle @primary = 'Across the Universe', @original = 'Across the Universe'
EXEC InsertTitle @primary = 'August Rush', @original = 'August Rush'
EXEC InsertTitle @primary = 'Rendition', @original = 'Rendition'
EXEC InsertTitle @primary = 'Three Kings', @original = 'Three Kings'
EXEC InsertTitle @primary = 'Practical Magic', @original = 'Practical Magic'
EXEC InsertTitle @primary = 'Idle Hands', @original = 'Idle Hands'
EXEC InsertTitle @primary = 'Sleeping with the Enemy', @original = 'Sleeping with the Enemy'
EXEC InsertTitle @primary = 'Shooter', @original = 'Shooter'
EXEC InsertTitle @primary = 'Cocktail', @original = 'Cocktail'


-- Query para obtener los datos todos los id de la tabla temporal
SELECT
      Title.id AS id,
      Title.imdb_id AS imdb_id,
      Title.genre AS genre,
      Title.primaryTitle AS primaryTitle,
      Title.originalTitle AS originalTitle,
      Title.isAdult AS isAdult,
      Title.startYear AS startYear,
      Title.endYear AS endYear,
      Title.runtime AS runtime,
      Rating.averageRating AS rating,
      Rating.numVotes AS numVotes
FROM 
      Title,
      [IMDB].[imdb].[dbo].Rating AS Rating
WHERE
      Title.id IN
      (
            SELECT
                  id
            FROM
                  Temp
      ) AND
      Rating.titleId = Title.imdb_id

-- Query para eliminar todos los datos de la tabla temporal
DELETE FROM Temp