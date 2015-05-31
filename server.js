var app = require('express')();
var parser = require('./src/scrip').parse;

app.get('/', function (req, res) {
  var scrip = req.query.scrip;
  if (scrip) {
    var result = parser(scrip);
    res.status(200).json(result);
  } else {
    res.status(422).json({'error': 'Invalid data'});
  }
});

app.listen('8000');

module.exports = app;
