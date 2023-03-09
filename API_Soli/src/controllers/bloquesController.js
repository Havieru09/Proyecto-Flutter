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
    const { id } = req.params;
    const query = `UPDATE bloques SET nombre_bloque = '${nombre_bloques}' WHERE id = '${id}'`;
    mysqlConnection.query(query, [nombre_bloques, id], (err) => {
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

  controller.listOne = (req, res) => {
    const { id } = req.params;
    const query = `SELECT * FROM bloques WHERE id = ${id}`;
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
        bloques: rows,
      });
    });
  };
  controller.listOneBloque = (req, res) => {
    const { nombre_bloque } = req.params;
    const query = `SELECT * FROM bloques WHERE nombre_bloque = '${nombre_bloque}'`;
    console.log(query);
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
        bloques: rows,
      });
    });
  };

module.exports = controller;