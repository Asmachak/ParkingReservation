const express = require('express');
const app=express();
const bodyParser = require('body-parser');

//settings
app.set('port',process.env.PORT || 8000);
app.use(bodyParser.urlencoded({extended:true}));
app.use((req,res,next)=>{
    res.setHeader('Access-Control-Allow-Origin','*');
    res.setHeader('Access-Control-Allow-Methods','GET , POST , PUT , DELETE');
    res.setHeader('Access-Control-Allow-Headers','Content-Type , Authorization');
    next();
});

//Middleware
app.use(express.json());

//Routes
app.use( require('./routes/auth')); 
app.use( require('./routes/parking')); 
app.use( require('./routes/reservation')); 


//starting the server
app.listen(app.get('port'), ()=>{
    console.log('server on port' , app.get('port'));
})

