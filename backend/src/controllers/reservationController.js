const Reservation = require('../models/reservationClass');
const Parking = require('../models/parkingClass');
const User = require('../models/userClass');

exports.addReservation = async (req, res, next) => {
    const { start_date, end_date, id_parking_res,id_user_res } = req.body;
  
    console.log('body==>', req.body);
  
    try {
      const parkingExists = await Parking.findParkingById(id_parking_res);
  
      if (!parkingExists || parkingExists.length === 0) {
        return res.status(404).json({ message: 'Parking not found' });
      }
        
      const userExists = await User.findById(id_user_res);
      console.log(userExists);

      if (!userExists || userExists.length === 0) {
        return res.status(404).json({ message: 'user not found' });
      }
  
      const newReservation = {
        start_date: start_date,
        end_date: end_date,
        id_parking_res: id_parking_res,
        id_user_res:id_user_res
      };
  
      const result = await Reservation.saveReservation(newReservation);
      console.log('result==>', result);
  
      res.status(201).json({ message: 'Réservation créée avec succès', reservation: newReservation });
    } catch (error) {
      console.error('Erreur lors de la création de la réservation :', error);
      res.status(500).json({ message: "Une erreur s'est produite lors de la création de la réservation" });
    }
  };

  

  exports.showReservation = async (req, res, next) => {
    try {
      const reservationsWithDetails = await Reservation.findReservations();
  
      const formattedReservations = reservationsWithDetails.map((reservation) => {
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
          }
        };
      });
  
      return res.status(200).json({ liste_des_reservations: formattedReservations });
    } catch (err) {
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
    }
  }
  