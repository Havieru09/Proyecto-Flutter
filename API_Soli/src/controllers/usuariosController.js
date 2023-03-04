const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
    const { usuario, psw, rol } = req.body;
    const query = `SELECT * FROM usuario where rol <> "admin"`;
    mysqlConnection.query(query, [usuario, psw, rol], (
      err,
      rows
    ) => {
      if (!err) {
        res.json({
          status_code: 202,
          message: "Listado",
          usuario: rows,
          //authData
        });
        console.log(rows);
      } else {
        res.json({
          code: 500,
          error: true,
          message: err,
        });
      }
    });
  };

//Select by id
controller.listOne = (req, res) => {
    const { id } = req.params;
    const query = `SELECT * FROM usuario WHERE id = ?`;
    mysqlConnection.query(query, (err, rows) => {
      if (err) {
        return res.json({
          code: 500,
          error: true,
          message: err,
        });
      }
      res.json({
        status_code: 202,
        message: "Listado",
        usuario: rows,
      });
    });
  };

  //Insert
  controller.save = (req, res) => {
      const { usuario, psw, rol } = req.body;
      const query = `INSERT INTO usuario(usuario, psw, rol)
    VALUES(?,?,?)`;
      mysqlConnection.query(query, [usuario, psw, rol], (err) => {
        if (!err) {
          res.json({
            error: false,
            message: "Saved",
          });
        } else {
          res.json({
            error: true,
            message: err,
          });
          console.log(err);
        }
      });
    };

//update
controller.update = (req, res) => {
    const { psw, rol } = req.body;
    const { id } = req.params;
    const query = `UPDATE usuario SET psw = ?, rol = ? WHERE id = ?`;
    mysqlConnection.query(query, [psw, rol, id], (err) => {
      if (!err) {
        res.json({
          error: false,
          message: "Updated",
        });
      } else {
        res.json({
          error: true,
          message: err,
        });
        console.log(err);
      }
    });
  };


module.exports = controller;