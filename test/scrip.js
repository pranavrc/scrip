var should = require('chai').should(),
    parser = require('../src/scrip').parse;

var testScrip = "A paid 200 on behalf of B,C and \
                 B paid 300 on behalf of A,C and \
                 C paid 1000 on behalf of A,B";

var result = parser(testScrip);

result.A.C.should.eql(800);
result.A.B.should.eql(100);
result.B.C.should.eql(700);

console.log("All tests passed. Here's the result: \n");
console.log(result);
