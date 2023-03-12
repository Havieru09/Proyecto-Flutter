const cors = require('cors');
const express = require('express');
const router = express.Router();
router.use(cors());
const aulasController = require('../controllers/aulasController');
const usuariosController = require('../controllers/usuariosController');
const bloquesController = require('../controllers/bloquesController');
const solicitudesController = require('../controllers/solicitudesController');
const tiposController = require('../controllers/tiposController');
//aulas
router.get('/aulas',aulasController.list);
router.post('/aulas',aulasController.save);
router.put('/aulas/:id',aulasController.update);
router.get('/aulas/:id',aulasController.listOne);
router.get('/aulas_nombre/:nombre_aulas',aulasController.listOneSalon);
router.get('/aulas_bloque',aulasController.listAll);
router.get('/aulasAll',aulasController.listAll2);
//bloques
router.get('/bloques',bloquesController.list);
router.post('/bloques',bloquesController.save);
router.put('/bloques/:id',bloquesController.update);
router.get('/bloques/:id',bloquesController.listOne);
router.get('/bloque_nombre/:nombre_bloque',bloquesController.listOneBloque);
//tipos
router.get('/tipos', tiposController.list);
//solicitudes
router.get('/solicitudes',solicitudesController.list);
router.get('/solicitudes/:id',solicitudesController.listOne);
router.get('/solicitudes2/:id',solicitudesController.listTwo);
router.get('/solicitudes3/:id',solicitudesController.listThree);
router.post('/solicitudesDate',solicitudesController.listByDate);
router.get('/solicitudesAll',solicitudesController.listByAll);
router.post('/solicitudes',solicitudesController.create);
router.put('/solicitudes/:id',solicitudesController.update);
//usuarios
router.get('/usuarios',usuariosController.list);
router.get('/usuarios2/:parametro', usuariosController.listOneCorreo);
router.get('/usuarios/:id',usuariosController.listOne);
router.post('/usuarios',usuariosController.save);
router.put('/usuarios/:id',usuariosController.update);
router.get('/usuarios_rol',usuariosController.listRol);

module.exports = router;
