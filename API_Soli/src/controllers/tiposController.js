const mysqlConnection = require("../database");
const controller = {};

controller.list = (req, res) => {
  const { nombre_tipo } = req.body;
  const query = `SELECT * FROM tipo`;
  mysqlConnection.query(query, (nombre_tipo), (
    err,
    rows
  ) => {
    if (!err) {
      res.json({
        status_code: 202,
        message: "Listado",
        tipos: rows,
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
    const { nombre_tipo } = req.body;
    const query = `INSERT INTO tipo(nombre_tipo)
  VALUES(?)`;
mysqlConnection.query(query, [nombre_tipo], (err) => {
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

  //Update
  controller.update = (req, res) => {
    const { nombre_tipo } = req.body;
    const { id_tipo } = req.params;
    const query = `UPDATE tipo SET nombre_tipo = '${nombre_tipo}' WHERE id_tipo = '${id_tipo}'`;
mysqlConnection.query(query, [nombre_tipo, id_tipo], (err) => {
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
      }
    });
  };

  //Delete
  controller.delete = (req, res) => {
    const { id_tipo } = req.params;
    const query = `DELETE FROM tipo WHERE id_tipo = '${id_tipo}'`;
mysqlConnection.query(query, [id_tipo], (err) => {
      if (!err) {
        res.json({
          error: false,
          message: "Deleted",
        });
      } else {
        res.json({
          error: true,
          message: err,
        });
      }
    });
  };

  module.exports = controller;