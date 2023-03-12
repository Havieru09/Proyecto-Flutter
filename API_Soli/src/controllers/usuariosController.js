const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
  const { usuario, psw, rol } = req.body;
  const query = `SELECT a.*, b.nombre_rol from usuario a INNER join rol b on a.rol_id=b.id where a.rol_id <> '1';`;
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

controller.listRol = (req, res) => {
  const { usuario, psw, rol } = req.body;
  const query = `SELECT * from rol where id <> '1';`;
  mysqlConnection.query(query, [usuario, psw, rol], (
    err,
    rows
  ) => {
    if (!err) {
      res.json({
        status_code: 202,
        message: "Listado",
        rol: rows,
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
  const query = `SELECT * FROM usuario WHERE id = ${id}`;
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

//Select user by correo
controller.listOneCorreo = (req, res) => {
  const { parametro } = req.params;
  const [correo, cedula] = parametro.split('&');
  const query = `SELECT usuario FROM usuario WHERE correo = '${correo}' or cedula = '${cedula}'`;
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
  const { nombre, apellido, cedula, direccion, usuario, correo, psw, rol_id } = req.body;
  const query = `INSERT INTO usuario(nombre, apellido, cedula, direccion, usuario, correo, psw, rol_id)
    VALUES(?,?,?,?,?,?,?,?)`;
  mysqlConnection.query(query, [nombre, apellido, cedula, direccion, usuario, correo, psw, rol_id], (err) => {
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
  const { usuario, psw, rol_id } = req.body;
  const { id } = req.params;
  const query = `UPDATE usuario SET usuario = '${usuario}', psw = '${psw}', rol_id = '${rol_id}' WHERE id = '${id}'`;
  mysqlConnection.query(query, [usuario, psw, rol_id, id], (err) => {
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