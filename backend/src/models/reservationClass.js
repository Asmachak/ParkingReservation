const mysqlConnection = require('../database/database');

module.exports = class Reservation {
  constructor(start_date, end_date, id_parking_res, id_user_res) {
    this.start_date = start_date;
    this.end_date = end_date;
    this.id_parking_res = id_parking_res;
    this.id_user_res = id_user_res;
  }

  static saveReservation(newReservation) {
    return new Promise((resolve, reject) => {
      mysqlConnection.query(
        'INSERT INTO reservation (start_date, end_date, id_parking_res, id_user_res) VALUES (?, ?, ?, ?)',
        [newReservation.start_date, newReservation.end_date, newReservation.id_parking_res, newReservation.id_user_res],
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

  static findReservations() {
    return new Promise((resolve, reject) => {
      const query = "SELECT * FROM reservation r, user u, parking p WHERE r.id_parking_res = p.id_parking AND r.id_user_res = u.id";
      mysqlConnection.query(query, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }

    
  static findReservationsByUserId(id_user) {
    return new Promise((resolve, reject) => {
      const query = "SELECT * FROM reservation , parking where id_parking_res = id_parking and id_user_res = ?";
      mysqlConnection.query(query,[id_user], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }
}
