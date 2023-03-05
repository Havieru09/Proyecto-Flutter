const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
  const { nombre_bloques } = req.body;
  const query = `SELECT * FROM bloques`;
  mysqlConnection.query(query, [nombre_bloques], (
    err,
    rows
  ) => {
    if (!err) {
      res.json({
        status_code: 202,
        message: "Listado",
        bloques: rows,
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
    const { nombre_bloques } = req.body;
    const query = `INSERT INTO bloques(nombre_bloque)
  VALUES(?)`;
    mysqlConnection.query(query, [nombre_bloques], (err) => {
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
    const { nombre_bloques } = req.body;
    const { id_bloques } = req.params;
    const query = `UPDATE bloques SET nombre_bloques = '${nombre_bloques}' WHERE id_bloques = '${id_bloques}'`;
    mysqlConnection.query(query, [nombre_bloques, id_bloques], (err) => {
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