///IMPORT
const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');


const PORT = 3000;
const DB = "mongodb+srv://22010101128:bhavesh@cluster0.ycs1hur.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const app = express();

///MIDDLEWERE  
app.use(express.json())
app.use(authRouter);

///connections
mongoose.connect(DB).then(()=>{
    console.log("Connected to Database");
}).catch((e)=>{
    console.log(`ERROR : ${e}`);
})
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Conneted to port ${PORT}`)
})