const Note = require("../models/Note");

exports.getNotes = async(req,res)=>{

    const notes = await Note.getByUser(
        req.user.id
    );

    res.json(notes);
};

exports.createNote = async(req,res)=>{

    await Note.create(
        req.body.title,
        req.body.content,
        req.user.id
    );

    res.json({
        success:true
    });
};

exports.updateNote = async(req,res)=>{

    await Note.update(
        req.params.id,
        req.body.title,
        req.body.content
    );

    res.json({
        success:true
    });
};

exports.deleteNote = async(req,res)=>{

    await Note.delete(
        req.params.id
    );

    res.json({
        success:true
    });
};