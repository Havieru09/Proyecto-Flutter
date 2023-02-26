const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
    const { usuario, contraseña, rol } = req.body;
    const query = `SELECT * FROM usuario`;
    mysqlConnection.query(query, [usuario, contraseña, rol], (
      err,
      rows
    ) => {
      if (!err) {
        res.json({
          status_code: 202,
          message: "Listado",
          usuarios: rows,
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

  //Insert
  controller.save = (req, res) => {
      const { usuario, contraseña, rol } = req.body;
      const query = `INSERT INTO usuario(usuario, contraseña, rol)
    VALUES(?,?,?)`;
      mysqlConnection.query(query, [usuario, contraseña, rol], (err) => {
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

module.exports = controller;