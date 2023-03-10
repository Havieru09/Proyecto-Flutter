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

controller.listAll2 = (req, res) => {
  const { nombre_aulas } = req.body;
  const query = `SELECT a.id, a.nombre_aulas, b.nombre_bloque, b.id id_bloque FROM aulas as a, bloques as b where a.bloque_id = b.id`;
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
    const { nombre_aulas, bloque_id } = req.body;
    const query = `INSERT INTO aulas(nombre_aulas,bloque_id)
  VALUES(?,?)`;
    mysqlConnection.query(query, [nombre_aulas, bloque_id], (err) => {
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
    const { nombre_aulas, bloque_id } = req.body;
    const { id } = req.params;
    const query = `UPDATE aulas SET nombre_aulas = '${nombre_aulas}', bloque_id ='${bloque_id}' WHERE id = '${id}'`;
    mysqlConnection.query(query, [nombre_aulas, bloque_id, id], (err) => {
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
    const query = `SELECT a.id,a.nombre_aulas, b.nombre_bloque FROM aulas as a, bloques as b WHERE a.id = ${id} and a.bloque_id = b.id`;
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
    // const { parametros } = req.params;
    // console.log(parametros);
    const [aulas, bloque_id] = nombre_aulas.split('&');
    console.log(aulas,bloque_id);
    const query = `select a.id, a.nombre_aulas, b.nombre_bloque FROM aulas a INNER JOIN bloques b on a.bloque_id = b.id WHERE a.nombre_aulas = '${aulas}'  and  a.bloque_id = ${bloque_id};`;
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