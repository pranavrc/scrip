var should = require('chai').should(),
    app = require('../server'),
    request = require('supertest');

describe("GET /", function () {
  it("Should return valid result data", function(done) {
    request(app)
      .get('/')
      .query({'scrip': 'A paid 100 on behalf of B'})
      .expect(200)
      .end(function (err, res) {
        if (err) throw err;
        res.body.B.A.should.eql(100);
        console.log("All server tests passed.");
        done();
      });
  });
});
