const express = require('express');
const { body } = require('express-validator');

const router = express.Router();


const reservation = require('../models/reservationClass');
const reservationController = require('../controllers/reservationController');

router.post('/reservation',reservationController.addReservation);

router.get('/reservation',reservationController.showReservation);

module.exports = router;
