//const sequelize = require('../server.js');
//const DataTypes = require('sequelize');
const { Sequelize, DataTypes } = require("sequelize");
const sequelize = new Sequelize(
    'proj1',
    'root',
    'root',
     {
       host: 'localhost',
       dialect: 'mysql'
     }
   );

const order = sequelize.define("order", {
	restaurant_name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	restaurant_address: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	client_id: {
		type: DataTypes.INTEGER,
		allowNull: false,
	},
	client_name: {
		type: DataTypes.STRING,
		allowNull: false,
	},
    client_address: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	rider_name: {
		type: DataTypes.STRING,
	},
	rider_lat: {
		type: DataTypes.DECIMAL
	},
	rider_lng: {
		type: DataTypes.DECIMAL
	}

	/* rider_location: {
		type: DataTypes.GEOMETRY
	} */
});

module.exports = sequelize.model("order", order)