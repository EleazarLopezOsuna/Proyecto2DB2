let express = require("express");
let cors = require('cors');
let app = express();
let sql = require("mssql");
var MongoClient = require('mongodb').MongoClient;

app.use(
    express.urlencoded({
      extended: true,
    })
  );
  
app.use(express.json());

app.use(cors({
    origin: '*',
    methods: '*'
}));

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

const config = {
    user: 'sa',
    password: 'Myp4ssword',
    server: '35.239.103.61', 
    database: 'netflix' ,
    trustServerCertificate: true,
};

const url = "mongodb://root:root@35.239.103.61:27017/";

const updateDatabases = (body) => {
    let query = 'DELETE FROM Temp'
    if(body.length > 0) {
        sql.connect(config, function (err) {
    
            if (err) console.log(err);
    
            let request = new sql.Request();
            request.query(query, function (err, recordset) {
                
            });
        });

        MongoClient.connect(url, function(err, db) {
            if (err) throw err;
            var dbo = db.db("proyectoDB2");
            dbo.collection("titleRating").insertMany(body, function(err, res) {
                if (err) throw err;
                db.close();
            });
        });
    }
}

app.get("/", (req, res) => {
    let query = `SELECT
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
                    Rating.titleId = Title.imdb_id`

    sql.connect(config, function (err) {
    
        if (err) console.log(err);

        let request = new sql.Request();
        request.query(query, function (err, recordset) {
            console.log(recordset['recordset'])
            if(recordset['recordset'].length > 0){
                updateDatabases(recordset['recordset'])
            }
            res.send(recordset['recordset']);
        });
    });
});

app.listen(5000, () => {
 console.log("Server running on port 5000");
});