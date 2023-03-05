const cors = require('cors');
const express = require('express');
const router = express.Router();
router.use(cors());
const aulasController = require('../controllers/aulasController');
const usuariosController = require('../controllers/usuariosController');
const bloquesController = require('../controllers/bloquesController');
const solicitudesController = require('../controllers/solicitudesController');
//aulas
router.get('/aulas',aulasController.list);
//bloques
router.get('/bloques',bloquesController.list);
//solicitudes
router.get('/solicitudes',solicitudesController.list);

router.get('/solicitudes/:id',solicitudesController.listOne);

router.get('/solicitudes2/:id',solicitudesController.listTwo);

router.post('/solicitudes',solicitudesController.create);
//usuarios
router.get('/usuarios',usuariosController.list);
router.get('/usuarios/:id',usuariosController.listOne);
router.post('/usuarios',usuariosController.save);
router.put('/usuarios/:id',usuariosController.update);

module.exports = router;
