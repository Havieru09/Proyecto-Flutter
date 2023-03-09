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

controller.listAll = (req, res) => {
  const query = `SELECT a.id, a.nombre_aulas, b.id as 'bloque_id', b.nombre_bloque
  FROM aulas as a
  INNER JOIN bloques as b ON a.bloque_id = b.id`;
  mysqlConnection.query(query, (err, solicitud) => {
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
          data: solicitud,
      });
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

  //Update
  controller.update = (req, res) => {
    const { nombre_aulas } = req.body;
    const { id } = req.params;
    const query = `UPDATE aulas SET nombre_aulas = '${nombre_aulas}' WHERE id = '${id}'`;
    mysqlConnection.query(query, [nombre_aulas, id], (err) => {
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
    const query = `SELECT * FROM aulas WHERE id = ${id}`;
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
        aulas: rows,
      });
    });
  };
  controller.listOneSalon = (req, res) => {
    const { nombre_aulas } = req.params;
    const query = `SELECT * FROM aulas WHERE nombre_aulas = '${nombre_aulas}'`;
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
        aulas: rows,
      });
    });
  };

module.exports = controller;