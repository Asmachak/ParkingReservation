const { validationResult } = require("express-validator");
const bcrypt = require("bcrypt");
const User = require("../models/userClass");
const jwt = require("jsonwebtoken");
const Reservation = require('../models/reservationClass'); 


exports.signup = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() });
  }

  const { nom, adresse, mdps, imageUrl } = req.body;

  try {
    // Check if the email address already exists in the database
    const existingUser = await User.find(adresse);
    if (existingUser[0] && existingUser[0].length > 0) {
      return res
        .status(422)
        .json({ message: "Adresse email déjà existante!!" });
    }
    console.log("mdps===>", mdps);
  
    const hashedPassword = await bcrypt.hash(mdps, 10);

    console.log("hashedPass=>>>",hashedPassword)

    const userDetails = {
      nom: nom,
      adresse: adresse,
      mdps: hashedPassword,
      imageUrl: imageUrl,
    };

    const result = await User.save(userDetails);
    console.log("result==>",userDetails);
    res.status(201).json({ message: "User registered!" });
  } catch (err) {
    if (err.code === "ER_DUP_ENTRY") {
      // Duplicate entry error
      return res
        .status(422)
        .json({ message: "Adresse email déjà existante!!" });
    }

    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.login = async (req, res, next) => {
  const { adresse, mdps } = req.body;

  try {
    console.log("req.body =>", req.body);
    const user = await User.find(adresse);
    console.log("user==>", user);

    if (!user[0] || user[0].length === 0) {
      return res.status(404).json({
        success: false,
        description: "User not found",
      });
    }

    const storedUser = user[0]; // Assuming user[0] is an array with user data
    const userId = storedUser.id;

    const isMatch = await bcrypt.compare(mdps, storedUser.mdps);
    console.log("isMatch =>", isMatch);

    if (!isMatch) {
      return res.status(401).json({
        success: false,
        description: "Wrong password",
      });
    }

    // Fetch user's reservations from the database
    const reservations = await Reservation.findReservationsByUserId(userId);

    
    const formattedReservations = reservations.map((reservation) => {
      return {
        id_reservation: reservation.id_reservation,
        start_date: reservation.start_date,
        end_date: reservation.end_date,
        parking: {
          id_parking: reservation.id_parking,
          adresse_parking:reservation.adresse_parking,
          image_parking:reservation.image_parking,
          description:reservation.description ,
          heure_ouverture:reservation.heure_ouverture , 
          tarif_place:reservation.tarif_place,
          nom_parking:reservation.nom_parking
        },
          user: {
            id: reservation.id_user,
            imageUrl: reservation.imageUrl,
            adresse:reservation.adresse,
            mdps:reservation.mdps,
            nom : reservation.nom
          }
      };});

    // Include user's reservations in the token payload
    const tokenPayload = {
      userId:storedUser.userId,
      adresse: storedUser.adresse,
      nom: storedUser.nom,
      imageUrl: storedUser.imageUrl,
      mdps: storedUser.mdps,
      reservations: formattedReservations,
    };

    console.log("token==>",tokenPayload);

    const token = jwt.sign(
      tokenPayload,
      "secretfortoken",
      { expiresIn: "1h" }
    );

    res.status(200).json({ token: token, userId: userId });
  } catch (err) {
    return res.status(500).json({
      success: false,
      description: `Server side error ==> ${err}`,
    });
  }
};

exports.showUserById = async (req, res, next) => {

  
  const { id} = req.body;

  console.log("body==>",req.body);
  try {
    
    const existingUser = await User.findById(id);

    console.log("existing user===>", existingUser );

    return res
    .status(200)
    .json({ liste_des_users: existingUser });
  
  } catch (err) {
      if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }

}
