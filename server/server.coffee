express             = require 'express'
validator           = require 'express-validator'
sanitizer           = require 'express-sanitizer'
nodeMailer          = require 'nodemailer'
bodyParser          = require 'body-parser'

# Initialize the app
app = express()

allowCrossDomain = (req, res, next) ->
    res.header('Access-Control-Allow-Origin', 'http://localhost:1111');
    res.header('Access-Control-Allow-Methods', 'GET, POST');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next()

# Configure app to use bodyParser and port 8080
app.use allowCrossDomain
app.use bodyParser.urlencoded { extended: false }
app.use bodyParser.json()
app.use validator()
app.use sanitizer()

port = process.env.PORT || 8080

# Routes for the API
router = express.Router()

# Testroute
router.get '/', (req, res, next) ->
    res.json({})

# Send an email
router.route '/contact-form'
    .post (req, res, next) ->
        # Check for errors within the form submission
        req.checkBody(
            'name':
                notEmpty: true
                errorMessage: 'Please enter your name.'
            'email':
                notEmpty: true
                isEmail:
                    errorMessage: 'Please enter a valid email address.'
            'message':
                notEmpty: true
                errorMessage: 'Please enter a message.'
        )

        errors = req.validationErrors()

        # Return the form submission errors, if any
        if errors
            res.json { errors: errors }
            return

        # Sanitize the values using Caja's HTML Sanitizer
        req.body.name = req.sanitize req.body.name
        req.body.email = req.sanitize req.body.email
        req.body.message = req.sanitize req.body.message

        # Send the email
        smtpTransport = nodeMailer.createTransport 'smtps://thomas.torfs@gmail.com:egkyqfljsgalqpmf@smtp.gmail.commmm'

        mailOptions =
            from: req.body.name + ' <' + req.body.email + '>'
            to: 'thomas.torfs@gmail.com'
            subject: 'thomastorfs.com: ' + req.body.name + ' sends you a message'
            text: req.body.message

        smtpTransport.sendMail mailOptions, (error, info) ->
            if error
                res.json { errors: error }
            else
                res.json { success: true }


# Prefix the routes with /api
app.use '/api', router

# Start the server
app.listen port
console.log 'Magic happens on port ' + port
