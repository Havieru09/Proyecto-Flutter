const express = require('express');
const router = express.Router();

const aulasController = require('../controllers/aulasController');
const usuariosController = require('../controllers/usuariosController');
const bloquesController = require('../controllers/bloquesController');
const solicitudesController = require('../controllers/solicitudesController');

router.get('/aulas',aulasController.list);

router.get('/bloques',bloquesController.list);

router.get('/usuarios',usuariosController.list);

router.get('/solicitudes',solicitudesController.list);

router.get('/solicitudes/:id',solicitudesController.listOne);

router.get('/solicitudes2/:id',solicitudesController.listTwo);

router.post('/solicitudes',solicitudesController.create);

router.delete('/solicitudes/:id',solicitudesController.delete);

module.exports = router;