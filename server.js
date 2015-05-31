var app = require('express')();
var parser = require('./scrip').parse;

app.get('/', function (req, res) {
  var scrip = req.query.scrip;
  var result = parser(scrip);

  res.send(result);
});

app.listen('8000');

