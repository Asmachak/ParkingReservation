const express = require('express');
const { body } = require('express-validator');

const router = express.Router();

const User = require('../models/userClass');
const authController = require('../controllers/authController');


router.post(
  '/signup',
  [
    body('nom').trim().notEmpty(),
    body('imageUrl').trim().notEmpty(),
    body('adresse').isEmail().normalizeEmail().custom(async (adresse) => {
      const user = await User.find(adresse);
      if (user && user.length > 0) {
        return Promise.reject('Adresse email déjà existante!!');
      }
    }),
    body('mdps').trim().isLength({ min: 8 }),
  ],
  authController.signup
);

router.post('/login', authController.login);
router.get('/find', authController.showUserById);

module.exports = router;
