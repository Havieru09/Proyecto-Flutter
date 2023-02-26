const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
  const { nombre_aulas } = req.body;
  const query = `SELECT * FROM aulas`;
  mysqlConnection.query(query, (nombre_aulas), (
    err,
    rows
  ) => {
    if (!err) {
      res.json({
        status_code: 202,
        message: "Listado",
        aulas: rows,
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
    const { nombre_aulas } = req.body;
    const query = `INSERT INTO aulas(nombre_aulas)
  VALUES(?)`;
    mysqlConnection.query(query, [nombre_aulas], (err) => {
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