const Note = require("../models/Note");

exports.getNotes = async (req, res) => {

    const notes = await Note.getByUser(
        req.user.id
    );

    res.json(notes);
};

exports.createNote = async (req, res) => {

    const { title, content } = req.body;

    if (!title || title.trim() === "") {

        return res.status(400).json({
            success: false,
            message: "Title wajib diisi"
        });
    }

    await Note.create(
        title,
        content,
        req.user.id
    );

    res.status(201).json({
        success: true,
        message: "Note berhasil dibuat"
    });
};

exports.updateNote = async (req, res) => {

    const { title, content } = req.body;

    if (!title || title.trim() === "") {

        return res.status(400).json({
            success: false,
            message: "Title wajib diisi"
        });
    }

    await Note.update(
        req.params.id,
        title,
        content
    );

    res.json({
        success: true,
        message: "Note berhasil diubah"
    });
};

exports.deleteNote = async (req, res) => {

    const noteId = req.params.id;

    if (!noteId) {

        return res.status(400).json({
            success: false,
            message: "ID tidak valid"
        });
    }

    await Note.delete(noteId);

    res.json({
        success: true,
        message: "Note berhasil dihapus"
    });
};