const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.register = async(req,res)=>{

    try{

        const {username,password} = req.body;

        if(username.length < 3){
            return res.status(400).json({
                success:false,
                message:"Username minimal 3 karakter"
            });
        }

        if(password.length < 8){
            return res.status(400).json({
                success:false,
                message:"Password minimal 8 karakter"
            });
        }

        const existingUser = await User.findByUsername(username);

        if(existingUser){
            return res.status(400).json({
                success:false,
                message:"Username sudah digunakan"
            });
        }

        const hash = await bcrypt.hash(password,10);

        await User.create(username,hash);

        res.json({
            success:true,
            message:"Register berhasil"
        });

    }catch(error){

        res.status(500).json({
            success:false,
            message:error.message
        });
    }
};

exports.login = async(req,res)=>{

    try{

        const {username,password} = req.body;

        const user = await User.findByUsername(username);

        if(!user){

            return res.status(401).json({
                success:false,
                message:"User tidak ditemukan"
            });
        }

        const valid = await bcrypt.compare(
            password,
            user.password
        );

        if(!valid){

            return res.status(401).json({
                success:false,
                message:"Password salah"
            });
        }

        const token = jwt.sign(
            {
                id:user.id
            },
            process.env.JWT_SECRET,
            {
                expiresIn:"1d"
            }
        );

        res.json({
            success:true,
            token
        });

    }catch(error){

        res.status(500).json({
            success:false,
            message:error.message
        });
    }
};