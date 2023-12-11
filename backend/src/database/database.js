const mysql = require('mysql');

const mysqlConnection = mysql.createConnection(
    {
        host : 'localhost',
        user : 'root',
        password :'',
        database :'my_db'
    }
);

mysqlConnection.connect((error)=>{
    if(error){
        console.log(error);
        return;
    } else {
        console.log("DB connected");    }
});

module.exports = mysqlConnection ;