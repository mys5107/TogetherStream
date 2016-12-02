/**
 * Created by danielfirsht on 12/2/16.
 */
'use strict';

var express = require('express');
var passport = require('passport');
var authService = require('../../auth.service');

var router = express.Router();

router.get('/login', passport.authenticate('facebook-token'), passport.authenticate(
    'facebook-token',
    {
        successRedirect: '/auth/success',
        failureRedirect: '/auth/failure?provider=facebook'
    })
);

router.get('/connect', authService.isAuthenticated(), passport.authorize('facebook-token'));


module.exports = router;