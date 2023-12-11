const mysqlConnection = require('../database/database');

module.exports = class User {
  constructor(nom, imageUrl, adresse, mdps) {
    this.nom = nom;
    this.imageUrl = imageUrl;
    this.adresse = adresse;
    this.mdps = mdps;
  }

  static find(adresse) {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM user WHERE adresse = ?';
      mysqlConnection.query(query, [adresse], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }

  static findById(id) {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM user WHERE id = ?';
      mysqlConnection.query(query, [id], (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
    });
  }

static save(user) {
    return new Promise((resolve, reject) => {
      mysqlConnection.query(
        'INSERT INTO user (nom, imageUrl, adresse, mdps) VALUES (?, ?, ?, ?)',
        [user.nom, user.imageUrl, user.adresse, user.mdps],
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
  
};
