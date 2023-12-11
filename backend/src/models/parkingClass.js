const mysqlConnection = require('../database/database');

module.exports = class Parking {
  constructor(nom_parking, adresse_parking,image_parking,description , heure_ouverture , tarif_place) {
    this.nom_parking = nom_parking;
    this.adresse_parking = adresse_parking;
    this.image_parking = image_parking;
    this.description = description ,
    this.heure_ouverture=heure_ouverture , 
    this.tarif_place=tarif_place
  }

  static findParkingById(id_parking) {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM parking WHERE id_parking = ?';
      mysqlConnection.query(query, id_parking, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }
  

  static findParkingById(id_parking) {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM parking WHERE id_parking = ?';
      mysqlConnection.query(query, id_parking, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }
  
  

  static findParkingByAdresse(adresse_parking) {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM parking WHERE adresse_parking = ?';
      mysqlConnection.query(query, [adresse_parking], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }

  static saveParking(parking) {
    return new Promise((resolve, reject) => {
      mysqlConnection.query(
        'INSERT INTO parking (nom_parking, adresse_parking,image_parking,description , heure_ouverture , tarif_place) VALUES (?, ?, ?, ?,?,?)',
        [parking.nom_parking, parking.adresse_parking,parking.image_parking,parking.description,parking.heure_ouverture,parking.tarif_place],
        (error, results) => {
          if (error) {
            reject(error);
          } else {
            resolve(results);
          }
        }
      );
    });
  }

  static DeleteParking(id_parking) {
    return new Promise((resolve, reject) => {
      mysqlConnection.query(
        'DELETE FROM parking WHERE id_parking = ?;',
        [id_parking],
        (error, results) => {
          if (error) {
            reject(error);
          } else {
            resolve(results);
          }
        }
      );
    });
  }

  static findParkings() {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM parking ';
      mysqlConnection.query(query, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }



}