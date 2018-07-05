'use strict';

exports.handler = function (event, context, callback) {
    var response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html; charset=utf-8',
        },
        body: `<p>Hello world!, from ${process.env.CTS_CUSTOM_PROPERTY}</p>`,
    };
    callback(null, response);
};