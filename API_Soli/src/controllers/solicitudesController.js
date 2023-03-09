const mysqlConnection = require("../database");
const controller = {};

controller.list = (req, res) => {
    const { usuario_id, bloque_id, aula_id, tipo, detalle, estado } = req.body;
    const query1 = `SELECT s.id,  b.nombre_bloque as 'nombre_bloque', a.nombre_aulas as 'nombre_aulas', u.usuario as 'usuario', 
    t.nombre_tipo as 'tipo', detalle, estado 
    FROM solicitud as s
    INNER JOIN aulas as a on s.aula_id = a.id
    INNER JOIN bloques as b on a.bloque_id = b.id
    INNER JOIN tipo as t on s.tipo_id = t.id
    INNER JOIN usuario as u on s.usuario_id = u.id  
    ORDER BY CASE estado
        WHEN 'pendiente' THEN 0
        WHEN 'en_camino' THEN 1
        ELSE 2
    END asc, id asc`;

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
    t.nombre_tipo as 'tipo', detalle, estado FROM solicitud as s 
    INNER JOIN bloques as b on s.bloque_id = b.id
    INNER JOIN aulas as a on s.aula_id = a.id
    INNER JOIN tipo as t on s.tipo_id = t.id
    INNER JOIN usuario as u on s.usuario_id = u.id WHERE s.id = ${id} ORDER BY CASE estado
    WHEN 'pendiente' THEN 0
    WHEN 'en_camino' THEN 1
    ELSE 2
  END asc, 
  id asc`;
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
    const query = `SELECT  s.id, b.nombre_bloque as 'nombre_bloque', a.nombre_aulas as 'nombre_aulas', u.usuario as 'usuario', 
    t.nombre_tipo as 'tipo', detalle, estado 
    FROM solicitud as s 
    INNER JOIN aulas as a on s.aula_id = a.id
    INNER JOIN bloques as b on a.bloque_id = b.id
    INNER JOIN tipo as t on s.tipo_id = t.id
    INNER JOIN usuario as u on s.usuario_id = u.id 
    WHERE s.usuario_id = ${id}
    ORDER BY CASE estado
        WHEN 'pendiente' THEN 0
        WHEN 'en_camino' THEN 1
        ELSE 2
    END asc, id desc`;
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

//Select by id
controller.listByDate = (req, res) => {
    const { fecha_inicial, fecha_final, tipo="" } = req.body;
    if (tipo!="") {
        var query = `SELECT b.nombre_tipo,count(a.id) num, fecha_inicial FROM solicitud a,tipo b where fecha_inicial BETWEEN '${fecha_inicial}' and '${fecha_final}' and b.nombre_tipo='${tipo}' GROUP by b.nombre_tipo, a.fecha_inicial;`;
    }else{
        var query = `SELECT b.nombre_tipo,count(a.id) num, fecha_inicial FROM solicitud a,tipo b where fecha_inicial BETWEEN '${fecha_inicial}' and '${fecha_final}' GROUP by b.nombre_tipo, a.fecha_inicial;`;
    }
    // const query = `SELECT b.nombre_tipo,count(a.id) num FROM solicitud a,tipo b where fecha_inicial 
    // BETWEEN '${fecha_inicial}' and '${fecha_final}' and b.id=a.tipo_id GROUP by b.nombre_tipo`;
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
    const { estado, fecha_final } = req.body;

    const { id } = req.params;
    const query = `UPDATE solicitud SET estado = '${estado}', fecha_final = '${fecha_final}'  WHERE id = ${id}`;

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
    const { usuario_id, aula_id, tipo_id, detalle, estado, fecha_inicial, fecha_final } = req.body;
    const query = `INSERT INTO solicitud (usuario_id, aula_id, tipo_id, detalle, estado, fecha_inicial, fecha_final)
    VALUES ('${usuario_id}', '${aula_id}', '${tipo_id}', '${detalle}', '${estado}', '${fecha_inicial}', '${fecha_final}')`;
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



	
	