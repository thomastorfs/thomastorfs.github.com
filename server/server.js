// Generated by CoffeeScript 1.10.0
(function() {
  var allowCrossDomain, app, bodyParser, express, nodeMailer, port, router, sanitizer, validator;

  express = require('express');

  validator = require('express-validator');

  sanitizer = require('express-sanitizer');

  nodeMailer = require('nodemailer');

  bodyParser = require('body-parser');

  app = express();

  allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', 'http://localhost:1111');
    res.header('Access-Control-Allow-Methods', 'GET, POST');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    return next();
  };

  app.use(allowCrossDomain);

  app.use(bodyParser.urlencoded({
    extended: false
  }));

  app.use(bodyParser.json());

  app.use(validator());

  app.use(sanitizer());

  port = process.env.PORT || 8080;

  router = express.Router();

  router.get('/', function(req, res, next) {
    return res.json({});
  });

  router.route('/contact-form').post(function(req, res, next) {
    var errors, mailOptions, smtpTransport;
    req.checkBody({
      'name': {
        notEmpty: true,
        errorMessage: 'Please enter your name.'
      },
      'email': {
        isEmail: {
          errorMessage: 'Please enter a valid email address.'
        }
      },
      'message': {
        notEmpty: true,
        errorMessage: 'Please enter a message.'
      }
    });
    errors = req.validationErrors();
    if (errors) {
      res.json({
        errors: errors
      });
      return;
    }
    req.body.name = req.sanitize(req.body.name);
    req.body.email = req.sanitize(req.body.email);
    req.body.message = req.sanitize(req.body.message);
    smtpTransport = nodeMailer.createTransport('smtps://thomas.torfs@gmail.com:egkyqfljsgalqpmf@smtp.gmail.commmm');
    mailOptions = {
      from: req.body.name + ' <' + req.body.email + '>',
      to: 'thomas.torfs@gmail.com',
      subject: 'thomastorfs.com: ' + req.body.name + ' sends you a message',
      text: req.body.message
    };
    return smtpTransport.sendMail(mailOptions, function(error, info) {
      if (error) {
        return res.json({
          errors: error
        });
      } else {
        return res.json({
          success: true
        });
      }
    });
  });

  app.use('/api', router);

  app.listen(port);

  console.log('Magic happens on port ' + port);

}).call(this);
