require("dotenv").config();
const { exec } = require("child_process");
const path = require("path");

const migrationDir = path.join(__dirname, "./migration");
// support multiple arguments
const cmdArg = process.argv.slice(2).join(" ");

const command = `goose -dir ${migrationDir} postgres "host=${process.env.POSTGRES_HOST} port=${process.env.POSTGRES_PORT} user=${process.env.POSTGRES_USER} password=${process.env.POSTGRES_PASSWORD} dbname=${process.env.POSTGRES_DB} sslmode=${process.env.POSTGRES_SSLMODE}" ${cmdArg}`;

exec(command, (error, stdout, stderr) => {
  if (error) {
    console.log(`error: ${error.message}`);
    return;
  }
  if (stderr) {
    console.log(`stderr: ${stderr}`);
    return;
  }
  console.log(`stdout: ${stdout}`);
});
