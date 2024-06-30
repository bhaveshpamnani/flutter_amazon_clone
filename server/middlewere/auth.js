const jwt = require("jsonwebtoken");


const auth = async (req,res,next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg:"No token, authorization denied"});
        }
        const verified = jwt.verify(token,"passwordKey");
        if(!verified){
            return res.status(401).json({msg:"Token is not valid"});
        }
        req.user = verified.id;
        req.token = token;
        next();
    }catch(e){
        res.status(500).send({error:e.message});
    }
}
module.exports = auth;