const mysqlConnection = require("../database");
const controller = {};

//Select
controller.list = (req, res) => {
    const { usuario_id, bloque_id, aula_id, tipo, detalle, estado } = req.body;
    const query1 = `SELECT s.id, b.nombre_bloque as 'nombre_bloque', a.nombre_aulas as 'nombre_aulas', u.usuario as 'usuario', 
    tipo, detalle, estado FROM solicitud as s 
    INNER JOIN bloques as b on s.bloque_id = b.id
    INNER JOIN aulas as a on s.aula_id = a.id
    INNER JOIN usuario as u on s.usuario_id = u.id`;

    mysqlConnection.query(query1, (usuario_id, bloque_id, aula_id, tipo, detalle, estado), (
        err,
        rows
    ) => {
        if (!err) {
            res.json({
                status_code: 202,
                message: "Listado",
                solicitud: rows,
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
}

//Select by id
controller.listOne = (req, res) => {
    const { id } = req.params;
    const query = `SELECT s.id, b.nombre_bloque as 'nombre_bloque', a.nombre_aulas as 'nombre_aulas', u.usuario as 'usuario', 
    tipo, detalle, estado FROM solicitud as s 
    INNER JOIN bloques as b on s.bloque_id = b.id
    INNER JOIN aulas as a on s.aula_id = a.id
    INNER JOIN usuario as u on s.usuario_id = u.id WHERE s.id = ${id}`;
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

controller.listTwo = (req, res) => {
    const { id } = req.params;
    const query = `SELECT s.id, b.nombre_bloque as 'nombre_bloque', a.nombre_aulas as 'nombre_aulas', u.usuario as 'usuario', usuario_id,
  tipo, detalle, estado FROM solicitud as s 
  INNER JOIN bloques as b on s.bloque_id = b.id
  INNER JOIN aulas as a on s.aula_id = a.id
  INNER JOIN usuario as u on s.usuario_id = u.id WHERE u.id = ${id} ORDER BY CASE estado
  WHEN 'pendiente' THEN 0
  WHEN 'en_camino' THEN 1
  ELSE 2
END asc`;
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


//Update
controller.update = (req, res) => {
    const { estado } = req.body;
    const { id } = req.params;
    const query = `UPDATE solicitud SET estado = '${estado}' WHERE id = ${id}`;

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
            message: "Solicitud actualizada",
            data: solicitud,
        });
    });
};


//Insert
controller.create = (req, res) => {
    const { usuario_id, bloque_id, aula_id, tipo, detalle, estado } = req.body;
    const query = `INSERT INTO solicitud (usuario_id, bloque_id, aula_id, tipo, detalle, estado) VALUES ('${usuario_id}', '${bloque_id}', '${aula_id}', '${tipo}', '${detalle}', '${estado}')`;
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
            message: "Solicitud creada",
            data: solicitud,
        });
    });
};

//delete
controller.delete = (req, res) => {
    const { id } = req.params;
    const query = `DELETE FROM solicitud WHERE id = ${id}`;
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
            message: "Solicitud eliminada",
            data: solicitud,
        });
    });
};

module.exports = controller;