// nodemailer
const nodemailer = require('nodemailer');
// handlebars
const handlebars = require("handlebars");
// google apis
const { google } = require('googleapis');
// path
const path = require('path');
// file system
const fs = require("fs");
//env
const config = require("nconf");


const CLIENT_EMAIL = process.env.CLIENT_EMAIL || config.get("client:email");
const CLIENT_ID = process.env.CLIENT_ID || config.get("client:id");
const CLIENT_SECRET = process.env.CLIENT_SECRET || config.get("client:secret");
const REDIRECT_URI = process.env.REDIRECT_URI || config.get("client:redirectUri");
const REFRESH_TOKEN = process.env.REFRESH_TOKEN || config.get("client:refreshToken");


const sendMail = async (email, subject, payload, template) => {

  const OAuth2Client = new google.auth.OAuth2(
    CLIENT_ID,
    CLIENT_SECRET,
    REDIRECT_URI,
  );

  OAuth2Client.setCredentials({ refresh_token: REFRESH_TOKEN });

  const accessToken = await OAuth2Client.getAccessToken();


  const transporter = nodemailer.createTransport({
    service: 'gmail',
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth: {
      type: 'OAuth2',
      user: CLIENT_EMAIL,
      clientId: CLIENT_ID,
      clientSecret: CLIENT_SECRET,
      refreshToken: REFRESH_TOKEN,
      accessToken: accessToken,
    },

  });


  const source = fs.readFileSync(path.join(__dirname, template), "utf8");

  const compiledTemplate = handlebars.compile(source);

  // mail options 
  var mailOptions = {
    from: CLIENT_EMAIL,
    to: email,
    subject: subject,
    html: compiledTemplate(payload)
  };

  // trigger the sending of the E-mail
  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      return next(new ErrorResponse(error, 500));
    }

    return info
  });

  return transporter

};

module.exports = sendMail;