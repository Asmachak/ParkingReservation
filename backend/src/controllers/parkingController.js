const Parking = require("../models/parkingClass");

exports.addParking = async (req, res, next) => {

    const { nom_parking, adresse_parking,image_parking, description , heure_ouverture , tarif_place} = req.body;

    console.log("body==>",req.body);
  
    try {
      // Check if the nom_parking already exists in the database
      const existingParking = await Parking.findParkingByName(nom_parking);

      console.log("existing parking===>", existingParking && existingParking.length > 0);
      if (existingParking && existingParking.length > 0) {
        return res
          .status(422)
          .json({ message: "Parking déjà existant!!" });
      }
      
      const parkingDetails = {
        nom_parking: nom_parking,
        adresse_parking: adresse_parking,
        image_parking: image_parking,
        description: description,
        heure_ouverture :heure_ouverture,
        tarif_place : tarif_place,

      };

      const result = await Parking.saveParking(parkingDetails);
      console.log("result==>",result);
      res.status(201).json({ message: "Parking registered!" });
    } catch (err) {
      if (err.code === "ER_DUP_ENTRY") {
        // Duplicate entry error
        return res
          .status(422)
          .json({ message: "parking déjà existant!!" });
      }
  
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
    }
  };

exports.showParking = async (req, res, next) => {
  try {
    // Check if the nom_parking already exists in the database
    const existingParking = await Parking.findParkings();

    console.log("existing parking===>", existingParking );

    return res
    .status(200)
    .json({ liste_des_parking: existingParking });
  
  } catch (err) {
      if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }

}

exports.showParkingById = async (req, res, next) => {

  
  const { id_parking} = req.body;

  console.log("body==>",req.body);
  try {
    // Check if the nom_parking already exists in the database
    const existingParking = await Parking.findParkingById(id_parking);

    console.log("existing parking===>", existingParking );

    return res
    .status(200)
    .json({ liste_des_parking: existingParking });
  
  } catch (err) {
      if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }

}