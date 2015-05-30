/* scrip.pegjs
 * (c) Pranav Ravichandran <me@onloop.net>
 */

// Initializers and grammar for scrip functions and persistence.


// -------------------------------------------------
// Initializers.

{
  var scrip = {};

  function isEmptyObj (obj) {
    return Object.keys(obj).length == 0;
  }

  function makeInteger (num) {
    return parseInt(num.join(""), 10);
  }

  function parseSponsorship (sponsor, expense, sponsees) {
    var sponsorship = {};

    for (var each in sponsees) {
      var sponsee = sponsees[each];
      if (sponsee === sponsor) {
        continue;
      }
      sponsorship[sponsee] = {};
      sponsorship[sponsee][sponsor] = expense;
    }

    return sponsorship;
  }

  function updateScrip (debtor, debts) {
    for (debtee in debts) {
      if (scrip[debtee] && scrip[debtee][debtor]) {
        scrip[debtee][debtor] -= debts[debtee];
      } else if (scrip[debtor] && scrip[debtor][debtee]) {
        scrip[debtor][debtee] += debts[debtee];
      } else if (scrip[debtor]) {
        scrip[debtor][debtee] = debts[debtee];
      } else {
        scrip[debtor] = {};
        scrip[debtor][debtee] = debts[debtee];
      }
    }

    return scrip;
  }

  function processDebts (debtors) {
    if (!isEmptyObj(scrip)) {
      for (var debtor in debtors) {
        scrip = updateScrip(debtor, debtors[debtor]);
      }
    } else {
      scrip = debtors;
    }

    return scrip;
  }
}

// -------------------------------------------------
// Grammar and rules.

start
  = sponsorships

sponsorships
  = left:sponsorship _ "and" _ right:sponsorships { return processDebts(left); }
  / left:sponsorship { return processDebts(left); }

sponsorship
  = left:sponsor _ "paid" _ middle:expense _ "on behalf of" _ right:sponsees { return parseSponsorship(left, middle, right); }

sponsor
  = person

expense
  = numbers: [0-9]+ { return makeInteger(numbers); }

sponsees
  = left:sponsee __ "," __ right:sponsees { return [left].concat(right); }
  / left:sponsee { return [left]; }

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

// -------------------------------------------------


