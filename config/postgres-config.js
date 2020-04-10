// Postgres connection
const { Client } = require('pg');
const constants = require('./constants');

// Database configuration
const connection_string = constants.POSTGRES_CONNECTION_STRING;
const client = new Client({
  connectionString: connection_string,
})
client.connect();

module.exports = client;