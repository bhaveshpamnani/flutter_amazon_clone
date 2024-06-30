const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name : {
        required : true,
        type: String,
        trim:true,
    },
    email : {
        required : true,
        type: String,
        trim:true,
        validate : {
            validator: (value)=>{
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message:'Please Enter Valid email address'
        },
    },
    password : {
        required : true,
        type: String,
        
        // validate : {
        //     validator: (value)=>{
        //         const re = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        //         return value.match(re)
        //     },
        //     message:'Password should be Minimum eight characters, at least one letter and one number '
        // },
    },
    address : {
        type: String,
        default: '',
    },
    type : {
        type: String,
        default : 'user',
    }
});



const User = mongoose.model("User",userSchema);

module.exports = User;