// Postgres connection
const { Client } = require('pg');
const constants = require('./constants');

// Database configuration
const client = new Client({
  connectionString: process.env.DATABASE_URL || constants.POSTGRES_CONNECTION_STRING,
  ssl: {
    rejectUnauthorized: false
  }
})
client.connect();

module.exports = client;
