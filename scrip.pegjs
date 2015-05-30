{
 var scrip = {};

 function makeInteger (num) {
  return parseInt(num.join(""), 10);
 }

 function parseSponsorship (sponsor, expense, sponsees) {
  var sponsorship = {};

  for (var eachSponsee in sponsees) {
   var sponsee = sponsees[eachSponsee];
   sponsorship[sponsee] = {};
   sponsorship[sponsee][sponsor] = expense;
  }

  return sponsorship;
 }
}

start
 = sponsorships

sponsorships
 = left:sponsorship _ "and" _ right:sponsorships { return [left, right]; }
 / sponsorship

sponsorship
 = left:sponsor _ "paid" _ middle:expense _ "for" _ right:sponsees { return parseSponsorship(left, middle, right); }

sponsor
 = person

expense
 = numbers: [0-9]+ { return makeInteger(numbers); }

sponsees
 = left:sponsee __ "," __ right:sponsees { return [left].concat(right); }
 / sponsee

sponsee
 = person

person
 = name: [a-zA-Z]+ { return name.join(""); }

// mandatory whitespace
_ 
 = [ \t\r\n]+

// optional whitespace
__
 = [ \t\r\n]*
