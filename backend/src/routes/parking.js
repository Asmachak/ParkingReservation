const express = require('express');
const { body } = require('express-validator');

const router = express.Router();


const Parking = require('../models/parkingClass');
const parkingController = require('../controllers/parkingController');

router.post('/parking', parkingController.addParking);

router.get('/getParking',parkingController.showParking);

router.get('/getParkingId',parkingController.showParkingById);

module.exports = router;
