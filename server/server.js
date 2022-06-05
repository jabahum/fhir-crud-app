//express 
const express = require("express");
//.env 
const dotenv = require("dotenv");
//logger file
const logger = require("./middleware/logger");
// cors
const cors = require('cors')
// cookie parser
const cookieParser = require("cookie-parser");
//load env varriables
dotenv.config({ path: "./config/config.env" });
//load error handler
const errorHandler = require("./middleware/errorHandler");





// routes
// auth
const auth = require("./routes/auth.routes");
// fhir 
const fhir = require("./routes/fhir.routes");
// user
const user = require("./routes/user.routes");


//use express to extract requests and responses
const app = express();

app.use(cors())
app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header('Access-Control-Allow-Methods', 'DELETE, PUT, GET, POST');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});


//body parser
app.use(express.json({
    type: ["application/json", "application/fhir+json"],
    limit: "50mb"
}))
app.use(express.urlencoded({
    extended: false,
    limit: "50mb"
}))
app.use(cookieParser());

//log url requests
app.use(logger);

//initiate error handler
app.use(errorHandler);


// initiate routes
app.use("/api/v1/auth", auth);
app.use("/api/v1/fhir", fhir);
app.use("/api/v1/user", user);

// set up server ports
const PORT = process.env.PORT || 5083;

const server = app.listen(
    PORT,
    console.log(
        `🚀Server running in ${process.env.NODE_ENV} mode on Port ${PORT}`
    )
);

//handle unhandled rejections and stop the server instead of crashing the application
process.on("unhandledRejection", (err, promise) => {
    console.log(`❌ Error: ${err.message}`);
    //close server and exit process
    server.close(() => process.exit(1));
});

process.on("SIGTERM", (err, promise) => {
    server.close(() => process.exit(1));
});