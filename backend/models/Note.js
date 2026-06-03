const db = require("../config/db");

class Note {

    static async getByUser(userId) {

        const [rows] = await db.query(
            "SELECT * FROM notes WHERE user_id=?",
            [userId]
        );

        return rows;
    }

    static async create(
        title,
        content,
        userId
    ){

        return db.query(
            "INSERT INTO notes(title,content,user_id) VALUES (?,?,?)",
            [title,content,userId]
        );
    }

    static async update(
        id,
        title,
        content
    ){

        return db.query(
            "UPDATE notes SET title=?, content=? WHERE id=?",
            [title,content,id]
        );
    }

    static async delete(id){

        return db.query(
            "DELETE FROM notes WHERE id=?",
            [id]
        );
    }
}

module.exports = Note;