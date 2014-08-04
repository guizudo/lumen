global.nexus = {};
(function () {
  nexus["lumen/runtime"] = {};
  var nil63 = function (x) {
    return(x === undefined || x === null);
  };
  nexus["lumen/runtime"]["nil?"] = nil63;
  var is63 = function (x) {
    return(!nil63(x));
  };
  nexus["lumen/runtime"]["is?"] = is63;
  var length = function (x) {
    return(x.length || 0);
  };
  nexus["lumen/runtime"].length = length;
  var none63 = function (x) {
    return(length(x) === 0);
  };
  nexus["lumen/runtime"]["none?"] = none63;
  var some63 = function (x) {
    return(length(x) > 0);
  };
  nexus["lumen/runtime"]["some?"] = some63;
  var one63 = function (x) {
    return(length(x) === 1);
  };
  nexus["lumen/runtime"]["one?"] = one63;
  var hd = function (l) {
    return(l[0]);
  };
  nexus["lumen/runtime"].hd = hd;
  var type = function (x) {
    return(typeof(x));
  };
  nexus["lumen/runtime"].type = type;
  var string63 = function (x) {
    return(type(x) === "string");
  };
  nexus["lumen/runtime"]["string?"] = string63;
  var number63 = function (x) {
    return(type(x) === "number");
  };
  nexus["lumen/runtime"]["number?"] = number63;
  var boolean63 = function (x) {
    return(type(x) === "boolean");
  };
  nexus["lumen/runtime"]["boolean?"] = boolean63;
  var function63 = function (x) {
    return(type(x) === "function");
  };
  nexus["lumen/runtime"]["function?"] = function63;
  var composite63 = function (x) {
    return(is63(x) && type(x) === "object");
  };
  nexus["lumen/runtime"]["composite?"] = composite63;
  var atom63 = function (x) {
    return(nil63(x) || !composite63(x));
  };
  nexus["lumen/runtime"]["atom?"] = atom63;
  var table63 = function (x) {
    return(composite63(x) && nil63(hd(x)));
  };
  nexus["lumen/runtime"]["table?"] = table63;
  var list63 = function (x) {
    return(composite63(x) && is63(hd(x)));
  };
  nexus["lumen/runtime"]["list?"] = list63;
  var substring = function (str, from, upto) {
    return(str.substring(from, upto));
  };
  nexus["lumen/runtime"].substring = substring;
  var sub = function (x, from, upto) {
    if (string63(x)) {
      return(substring(x, from || 0, upto));
    } else {
      var l = [];
      var j = 0;
      var _g161;
      if (nil63(from) || from < 0) {
        _g161 = 0;
      } else {
        _g161 = from;
      }
      var i = _g161;
      var n = length(x);
      var _g162;
      if (nil63(upto) || upto > n) {
        _g162 = n;
      } else {
        _g162 = upto;
      }
      var _g47 = _g162;
      while (i < _g47) {
        l[j] = x[i];
        i = i + 1;
        j = j + 1;
      }
      var _g48 = x;
      var k = undefined;
      for (k in _g48) {
        var v = _g48[k];
        var _g49 = parseInt(k);
        var _g163;
        if (isNaN(_g49)) {
          _g163 = k;
        } else {
          _g163 = _g49;
        }
        var _g50 = _g163;
        if (!number63(_g50)) {
          l[_g50] = v;
        }
      }
      return(l);
    }
  };
  nexus["lumen/runtime"].sub = sub;
  var keys = function (x) {
    var t = [];
    var _g52 = x;
    var k = undefined;
    for (k in _g52) {
      var v = _g52[k];
      var _g53 = parseInt(k);
      var _g164;
      if (isNaN(_g53)) {
        _g164 = k;
      } else {
        _g164 = _g53;
      }
      var _g54 = _g164;
      if (!number63(_g54)) {
        t[_g54] = v;
      }
    }
    return(t);
  };
  nexus["lumen/runtime"].keys = keys;
  var inner = function (x) {
    return(sub(x, 1, length(x) - 1));
  };
  nexus["lumen/runtime"].inner = inner;
  var tl = function (l) {
    return(sub(l, 1));
  };
  nexus["lumen/runtime"].tl = tl;
  var char = function (str, n) {
    return(str.charAt(n));
  };
  nexus["lumen/runtime"].char = char;
  var code = function (str, n) {
    return(str.charCodeAt(n));
  };
  nexus["lumen/runtime"].code = code;
  var string_literal63 = function (x) {
    return(string63(x) && char(x, 0) === "\"");
  };
  nexus["lumen/runtime"]["string-literal?"] = string_literal63;
  var id_literal63 = function (x) {
    return(string63(x) && char(x, 0) === "|");
  };
  nexus["lumen/runtime"]["id-literal?"] = id_literal63;
  var add = function (l, x) {
    l.push(x);
    return(undefined);
  };
  nexus["lumen/runtime"].add = add;
  var drop = function (l) {
    return(l.pop());
  };
  nexus["lumen/runtime"].drop = drop;
  var last = function (l) {
    return(l[length(l) - 1]);
  };
  nexus["lumen/runtime"].last = last;
  var reverse = function (l) {
    var l1 = sub(l, length(l));
    var i = length(l) - 1;
    while (i >= 0) {
      add(l1, l[i]);
      i = i - 1;
    }
    return(l1);
  };
  nexus["lumen/runtime"].reverse = reverse;
  var join = function (a, b) {
    if (a && b) {
      var c = [];
      var o = length(a);
      var _g66 = a;
      var k = undefined;
      for (k in _g66) {
        var v = _g66[k];
        var _g67 = parseInt(k);
        var _g165;
        if (isNaN(_g67)) {
          _g165 = k;
        } else {
          _g165 = _g67;
        }
        var _g68 = _g165;
        c[_g68] = v;
      }
      var _g69 = b;
      var k = undefined;
      for (k in _g69) {
        var v = _g69[k];
        var _g70 = parseInt(k);
        var _g166;
        if (isNaN(_g70)) {
          _g166 = k;
        } else {
          _g166 = _g70;
        }
        var _g71 = _g166;
        if (number63(_g71)) {
          _g71 = _g71 + o;
        }
        c[_g71] = v;
      }
      return(c);
    } else {
      return(a || b || []);
    }
  };
  nexus["lumen/runtime"].join = join;
  var reduce = function (f, x) {
    if (none63(x)) {
      return(x);
    } else {
      if (one63(x)) {
        return(hd(x));
      } else {
        return(f(hd(x), reduce(f, tl(x))));
      }
    }
  };
  nexus["lumen/runtime"].reduce = reduce;
  var shift = function (k, n) {
    if (number63(k)) {
      return(k - n);
    } else {
      return(k);
    }
  };
  nexus["lumen/runtime"].shift = shift;
  var keep = function (f, x) {
    var t = [];
    var o = 0;
    var _g75 = x;
    var k = undefined;
    for (k in _g75) {
      var v = _g75[k];
      var _g76 = parseInt(k);
      var _g167;
      if (isNaN(_g76)) {
        _g167 = k;
      } else {
        _g167 = _g76;
      }
      var _g77 = _g167;
      if (f(v)) {
        t[shift(_g77, o)] = v;
      } else {
        o = o + 1;
      }
    }
    return(t);
  };
  nexus["lumen/runtime"].keep = keep;
  var in63 = function (x, t) {
    var _g79 = t;
    var _g21 = undefined;
    for (_g21 in _g79) {
      var y = _g79[_g21];
      var _g80 = parseInt(_g21);
      var _g168;
      if (isNaN(_g80)) {
        _g168 = _g21;
      } else {
        _g168 = _g80;
      }
      var _g81 = _g168;
      if (x === y) {
        return(true);
      }
    }
  };
  nexus["lumen/runtime"]["in?"] = in63;
  var find = function (f, t) {
    var _g83 = t;
    var _g22 = undefined;
    for (_g22 in _g83) {
      var x = _g83[_g22];
      var _g84 = parseInt(_g22);
      var _g169;
      if (isNaN(_g84)) {
        _g169 = _g22;
      } else {
        _g169 = _g84;
      }
      var _g85 = _g169;
      var _g86 = f(x);
      if (_g86) {
        return(_g86);
      }
    }
  };
  nexus["lumen/runtime"].find = find;
  var pair = function (l) {
    var i = 0;
    var l1 = [];
    while (i < length(l)) {
      add(l1, [l[i], l[i + 1]]);
      i = i + 2;
    }
    return(l1);
  };
  nexus["lumen/runtime"].pair = pair;
  var sort = function (l, f) {
    var _g170;
    if (f) {
      _g170 = function (a, b) {
        if (f(a, b)) {
          return(-1);
        } else {
          return(1);
        }
      };
    }
    return(l.sort(_g170));
  };
  nexus["lumen/runtime"].sort = sort;
  var iterate = function (f, count) {
    var i = 0;
    while (i < count) {
      f(i);
      i = i + 1;
    }
  };
  nexus["lumen/runtime"].iterate = iterate;
  var replicate = function (n, x) {
    var l = [];
    iterate(function () {
      return(add(l, x));
    }, n);
    return(l);
  };
  nexus["lumen/runtime"].replicate = replicate;
  var series = function (f, l) {
    return(iterate(function (i) {
      return(f(l[i]));
    }, length(l)));
  };
  nexus["lumen/runtime"].series = series;
  var map = function (f, x) {
    var t = [];
    var o = 0;
    var _g96 = x;
    var k = undefined;
    for (k in _g96) {
      var v = _g96[k];
      var _g97 = parseInt(k);
      var _g171;
      if (isNaN(_g97)) {
        _g171 = k;
      } else {
        _g171 = _g97;
      }
      var _g98 = _g171;
      var y = f(v);
      if (is63(y)) {
        t[shift(_g98, o)] = y;
      } else {
        o = o + 1;
      }
    }
    return(t);
  };
  nexus["lumen/runtime"].map = map;
  var keys63 = function (t) {
    var b = false;
    var _g100 = t;
    var k = undefined;
    for (k in _g100) {
      var _g23 = _g100[k];
      var _g101 = parseInt(k);
      var _g172;
      if (isNaN(_g101)) {
        _g172 = k;
      } else {
        _g172 = _g101;
      }
      var _g102 = _g172;
      if (!number63(_g102)) {
        b = true;
        break;
      }
    }
    return(b);
  };
  nexus["lumen/runtime"]["keys?"] = keys63;
  var empty63 = function (t) {
    var b = true;
    var _g104 = t;
    var _g24 = undefined;
    for (_g24 in _g104) {
      var _g25 = _g104[_g24];
      var _g105 = parseInt(_g24);
      var _g173;
      if (isNaN(_g105)) {
        _g173 = _g24;
      } else {
        _g173 = _g105;
      }
      var _g106 = _g173;
      b = false;
      break;
    }
    return(b);
  };
  nexus["lumen/runtime"]["empty?"] = empty63;
  var stash = function (args) {
    if (keys63(args)) {
      var p = [];
      var _g108 = args;
      var k = undefined;
      for (k in _g108) {
        var v = _g108[k];
        var _g109 = parseInt(k);
        var _g174;
        if (isNaN(_g109)) {
          _g174 = k;
        } else {
          _g174 = _g109;
        }
        var _g110 = _g174;
        if (!number63(_g110)) {
          p[_g110] = v;
        }
      }
      p._stash = true;
      add(args, p);
    }
    return(args);
  };
  nexus["lumen/runtime"].stash = stash;
  var unstash = function (args) {
    if (none63(args)) {
      return([]);
    } else {
      var l = last(args);
      if (table63(l) && l._stash) {
        var args1 = sub(args, 0, length(args) - 1);
        var _g112 = l;
        var k = undefined;
        for (k in _g112) {
          var v = _g112[k];
          var _g113 = parseInt(k);
          var _g175;
          if (isNaN(_g113)) {
            _g175 = k;
          } else {
            _g175 = _g113;
          }
          var _g114 = _g175;
          if (!(_g114 === "_stash")) {
            args1[_g114] = v;
          }
        }
        return(args1);
      } else {
        return(args);
      }
    }
  };
  nexus["lumen/runtime"].unstash = unstash;
  var search = function (str, pattern, start) {
    var i = str.indexOf(pattern, start);
    if (i >= 0) {
      return(i);
    }
  };
  nexus["lumen/runtime"].search = search;
  var split = function (str, sep) {
    if (str === "" || sep === "") {
      return([]);
    } else {
      var strs = [];
      while (true) {
        var i = search(str, sep);
        if (nil63(i)) {
          break;
        } else {
          add(strs, sub(str, 0, i));
          str = sub(str, i + 1);
        }
      }
      add(strs, str);
      return(strs);
    }
  };
  nexus["lumen/runtime"].split = split;
  var cat = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    if (none63(xs)) {
      return("");
    } else {
      return(reduce(function (a, b) {
        return(a + b);
      }, xs));
    }
  };
  nexus["lumen/runtime"].cat = cat;
  var _43 = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (a, b) {
      return(a + b);
    }, xs));
  };
  nexus["lumen/runtime"]["+"] = _43;
  var _ = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (b, a) {
      return(a - b);
    }, reverse(xs)));
  };
  nexus["lumen/runtime"]["-"] = _;
  var _42 = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (a, b) {
      return(a * b);
    }, xs));
  };
  nexus["lumen/runtime"]["*"] = _42;
  var _47 = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (b, a) {
      return(a / b);
    }, reverse(xs)));
  };
  nexus["lumen/runtime"]["/"] = _47;
  var _37 = function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (b, a) {
      return(a % b);
    }, reverse(xs)));
  };
  nexus["lumen/runtime"]["%"] = _37;
  var _62 = function (a, b) {
    return(a > b);
  };
  nexus["lumen/runtime"][">"] = _62;
  var _60 = function (a, b) {
    return(a < b);
  };
  nexus["lumen/runtime"]["<"] = _60;
  var _61 = function (a, b) {
    return(a === b);
  };
  nexus["lumen/runtime"]["="] = _61;
  var _6261 = function (a, b) {
    return(a >= b);
  };
  nexus["lumen/runtime"][">="] = _6261;
  var _6061 = function (a, b) {
    return(a <= b);
  };
  nexus["lumen/runtime"]["<="] = _6061;
  global.require = require;
  var fs = require("fs");
  nexus["lumen/runtime"].fs = fs;
  var read_file = function (path) {
    return(fs.readFileSync(path, "utf8"));
  };
  nexus["lumen/runtime"]["read-file"] = read_file;
  var write_file = function (path, data) {
    return(fs.writeFileSync(path, data, "utf8"));
  };
  nexus["lumen/runtime"]["write-file"] = write_file;
  print = function (x) {
    return(console.log(x));
  };
  var type = function (x) {
    return(typeof(x));
  };
  nexus["lumen/runtime"].type = type;
  var write = function (x) {
    return(process.stdout.write(x));
  };
  nexus["lumen/runtime"].write = write;
  var exit = function (code) {
    return(process.exit(code));
  };
  nexus["lumen/runtime"].exit = exit;
  var today = function () {
    var pad = function (n) {
      if (n < 10) {
        return("0" + n);
      } else {
        return(string(n));
      }
    };
    var now = new Date();
    return(pad(now.getUTCFullYear()) + "-" + pad(now.getUTCMonth() + 1) + "-" + pad(now.getUTCDate()));
  };
  nexus["lumen/runtime"].today = today;
  var now = function () {
    return(floor(new Date().getTime() / 1000));
  };
  nexus["lumen/runtime"].now = now;
  var number = function (str) {
    var n = parseFloat(str);
    if (!isNaN(n)) {
      return(n);
    }
  };
  nexus["lumen/runtime"].number = number;
  var string = function (x) {
    if (nil63(x)) {
      return("nil");
    } else {
      if (boolean63(x)) {
        if (x) {
          return("true");
        } else {
          return("false");
        }
      } else {
        if (function63(x)) {
          return("#<function>");
        } else {
          if (atom63(x)) {
            return(x + "");
          } else {
            var str = "(";
            var sp = "";
            var xs = [];
            var ks = [];
            var _g139 = x;
            var k = undefined;
            for (k in _g139) {
              var v = _g139[k];
              var _g140 = parseInt(k);
              var _g176;
              if (isNaN(_g140)) {
                _g176 = k;
              } else {
                _g176 = _g140;
              }
              var _g141 = _g176;
              if (number63(_g141)) {
                xs[_g141] = string(v);
              } else {
                add(ks, _g141 + ":");
                add(ks, string(v));
              }
            }
            var _g142 = join(xs, ks);
            var _g26 = undefined;
            for (_g26 in _g142) {
              var v = _g142[_g26];
              var _g143 = parseInt(_g26);
              var _g177;
              if (isNaN(_g143)) {
                _g177 = _g26;
              } else {
                _g177 = _g143;
              }
              var _g144 = _g177;
              str = str + sp + v;
              sp = " ";
            }
            return(str + ")");
          }
        }
      }
    }
  };
  nexus["lumen/runtime"].string = string;
  var space = function (xs) {
    var string = function (x) {
      if (string_literal63(x) || list63(x) && hd(x) === "cat") {
        return(x);
      } else {
        return(["string", x]);
      }
    };
    if (one63(xs)) {
      return(string(hd(xs)));
    } else {
      return(reduce(function (a, b) {
        return(["cat", string(a), "\" \"", string(b)]);
      }, xs));
    }
  };
  nexus["lumen/runtime"].space = space;
  var apply = function (f, args) {
    var _g149 = stash(args);
    return(f.apply(f, _g149));
  };
  nexus["lumen/runtime"].apply = apply;
  var id_count = 0;
  nexus["lumen/runtime"]["id-count"] = id_count;
  var make_id = function () {
    id_count = id_count + 1;
    return("_g" + id_count);
  };
  nexus["lumen/runtime"]["make-id"] = make_id;
  var _37message_handler = function (msg) {
    var i = search(msg, ": ");
    return(sub(msg, i + 2));
  };
  nexus["lumen/runtime"]["%message-handler"] = _37message_handler;
  var toplevel63 = function () {
    return(one63(environment));
  };
  nexus["lumen/runtime"]["toplevel?"] = toplevel63;
  var module_key = function (spec) {
    if (atom63(spec)) {
      return(string(spec));
    } else {
      return(reduce(function (a, b) {
        return(module_key(a) + "/" + module_key(b));
      }, spec));
    }
  };
  nexus["lumen/runtime"]["module-key"] = module_key;
  var module = function (spec) {
    return(modules[module_key(spec)]);
  };
  nexus["lumen/runtime"].module = module;
  var setenv = function (k) {
    var _g156 = unstash(Array.prototype.slice.call(arguments, 1));
    var keys = sub(_g156, 0);
    if (string63(k)) {
      var frame = last(environment);
      var x = frame[k] || {};
      var _g157 = keys;
      var _g159 = undefined;
      for (_g159 in _g157) {
        var v = _g157[_g159];
        var _g158 = parseInt(_g159);
        var _g178;
        if (isNaN(_g158)) {
          _g178 = _g159;
        } else {
          _g178 = _g158;
        }
        var _g160 = _g178;
        x[_g160] = v;
      }
      if (toplevel63()) {
        var m = module(current_module);
        m.export[k] = x;
      }
      frame[k] = x;
    }
  };
  nexus["lumen/runtime"].setenv = setenv;
})();
(function () {
  nexus["lumen/lib"] = {};
  var _g182 = nexus["lumen/runtime"];
  var nil63 = _g182["nil?"];
  var is63 = _g182["is?"];
  var length = _g182.length;
  var none63 = _g182["none?"];
  var some63 = _g182["some?"];
  var one63 = _g182["one?"];
  var hd = _g182.hd;
  var string63 = _g182["string?"];
  var number63 = _g182["number?"];
  var boolean63 = _g182["boolean?"];
  var function63 = _g182["function?"];
  var composite63 = _g182["composite?"];
  var atom63 = _g182["atom?"];
  var table63 = _g182["table?"];
  var list63 = _g182["list?"];
  var substring = _g182.substring;
  var sub = _g182.sub;
  var keys = _g182.keys;
  var inner = _g182.inner;
  var tl = _g182.tl;
  var char = _g182.char;
  var code = _g182.code;
  var string_literal63 = _g182["string-literal?"];
  var id_literal63 = _g182["id-literal?"];
  var add = _g182.add;
  var drop = _g182.drop;
  var last = _g182.last;
  var reverse = _g182.reverse;
  var join = _g182.join;
  var reduce = _g182.reduce;
  var keep = _g182.keep;
  var in63 = _g182["in?"];
  var find = _g182.find;
  var pair = _g182.pair;
  var sort = _g182.sort;
  var iterate = _g182.iterate;
  var replicate = _g182.replicate;
  var series = _g182.series;
  var map = _g182.map;
  var keys63 = _g182["keys?"];
  var empty63 = _g182["empty?"];
  var stash = _g182.stash;
  var unstash = _g182.unstash;
  var search = _g182.search;
  var split = _g182.split;
  var cat = _g182.cat;
  var _43 = _g182["+"];
  var _ = _g182["-"];
  var _42 = _g182["*"];
  var _47 = _g182["/"];
  var _37 = _g182["%"];
  var _62 = _g182[">"];
  var _60 = _g182["<"];
  var _61 = _g182["="];
  var _6261 = _g182[">="];
  var _6061 = _g182["<="];
  var read_file = _g182["read-file"];
  var write_file = _g182["write-file"];
  var write = _g182.write;
  var exit = _g182.exit;
  var today = _g182.today;
  var now = _g182.now;
  var number = _g182.number;
  var string = _g182.string;
  var space = _g182.space;
  var apply = _g182.apply;
  var make_id = _g182["make-id"];
  var _37message_handler = _g182["%message-handler"];
  var toplevel63 = _g182["toplevel?"];
  var module_key = _g182["module-key"];
  var module = _g182.module;
  var setenv = _g182.setenv;
  var getenv = function (k, p) {
    if (string63(k)) {
      var b = find(function (e) {
        return(e[k]);
      }, reverse(environment));
      if (is63(b)) {
        if (p) {
          return(b[p]);
        } else {
          return(b);
        }
      }
    }
  };
  nexus["lumen/lib"].getenv = getenv;
  var macro_function = function (k) {
    return(getenv(k, "macro"));
  };
  nexus["lumen/lib"]["macro-function"] = macro_function;
  var macro63 = function (k) {
    return(is63(macro_function(k)));
  };
  nexus["lumen/lib"]["macro?"] = macro63;
  var special63 = function (k) {
    return(is63(getenv(k, "special")));
  };
  nexus["lumen/lib"]["special?"] = special63;
  var special_form63 = function (form) {
    return(list63(form) && special63(hd(form)));
  };
  nexus["lumen/lib"]["special-form?"] = special_form63;
  var statement63 = function (k) {
    return(special63(k) && getenv(k, "stmt"));
  };
  nexus["lumen/lib"]["statement?"] = statement63;
  var symbol_expansion = function (k) {
    return(getenv(k, "symbol"));
  };
  nexus["lumen/lib"]["symbol-expansion"] = symbol_expansion;
  var symbol63 = function (k) {
    return(is63(symbol_expansion(k)));
  };
  nexus["lumen/lib"]["symbol?"] = symbol63;
  var variable63 = function (k) {
    var b = find(function (frame) {
      return(frame[k] || frame._scope);
    }, reverse(environment));
    return(table63(b) && is63(b.variable));
  };
  nexus["lumen/lib"]["variable?"] = variable63;
  var global63 = function (k) {
    return(getenv(k, "global"));
  };
  nexus["lumen/lib"]["global?"] = global63;
  var bound63 = function (x) {
    return(macro63(x) || special63(x) || symbol63(x) || variable63(x) || global63(x));
  };
  nexus["lumen/lib"]["bound?"] = bound63;
  var escape = function (str) {
    var str1 = "\"";
    var i = 0;
    while (i < length(str)) {
      var c = char(str, i);
      var _g279;
      if (c === "\n") {
        _g279 = "\\n";
      } else {
        var _g280;
        if (c === "\"") {
          _g280 = "\\\"";
        } else {
          var _g281;
          if (c === "\\") {
            _g281 = "\\\\";
          } else {
            _g281 = c;
          }
          _g280 = _g281;
        }
        _g279 = _g280;
      }
      var c1 = _g279;
      str1 = str1 + c1;
      i = i + 1;
    }
    return(str1 + "\"");
  };
  nexus["lumen/lib"].escape = escape;
  var quoted = function (form) {
    if (string63(form)) {
      return(escape(form));
    } else {
      if (atom63(form)) {
        return(form);
      } else {
        return(join(["list"], map(quoted, form)));
      }
    }
  };
  nexus["lumen/lib"].quoted = quoted;
  var literal = function (s) {
    if (string_literal63(s)) {
      return(s);
    } else {
      return(quoted(s));
    }
  };
  nexus["lumen/lib"].literal = literal;
  var stash42 = function (args) {
    if (keys63(args)) {
      var l = ["%object", "\"_stash\"", true];
      var _g202 = args;
      var k = undefined;
      for (k in _g202) {
        var v = _g202[k];
        var _g203 = parseInt(k);
        var _g282;
        if (isNaN(_g203)) {
          _g282 = k;
        } else {
          _g282 = _g203;
        }
        var _g204 = _g282;
        if (!number63(_g204)) {
          add(l, literal(_g204));
          add(l, v);
        }
      }
      return(join(args, [l]));
    } else {
      return(args);
    }
  };
  nexus["lumen/lib"]["stash*"] = stash42;
  var index = function (k) {
    return(k);
  };
  nexus["lumen/lib"].index = index;
  var bias = function (k) {
    if (number63(k) && target != "js") {
      if (target === "js") {
        k = k - 1;
      } else {
        k = k + 1;
      }
    }
    return(k);
  };
  nexus["lumen/lib"].bias = bias;
  var bind = function (lh, rh) {
    if (composite63(lh) && list63(rh)) {
      var id = make_id();
      return(join([[id, rh]], bind(lh, id)));
    } else {
      if (atom63(lh)) {
        return([[lh, rh]]);
      } else {
        var bs = [];
        var _g208 = lh;
        var k = undefined;
        for (k in _g208) {
          var v = _g208[k];
          var _g209 = parseInt(k);
          var _g283;
          if (isNaN(_g209)) {
            _g283 = k;
          } else {
            _g283 = _g209;
          }
          var _g210 = _g283;
          var _g284;
          if (_g210 === "&") {
            _g284 = ["sub", rh, length(lh)];
          } else {
            _g284 = ["get", rh, ["quote", bias(_g210)]];
          }
          var x = _g284;
          var _g285;
          if (v === true) {
            _g285 = _g210;
          } else {
            _g285 = v;
          }
          var _g211 = _g285;
          bs = join(bs, bind(_g211, x));
        }
        return(bs);
      }
    }
  };
  nexus["lumen/lib"].bind = bind;
  var bind42 = function (args, body) {
    var args1 = [];
    var rest = function () {
      if (target === "js") {
        return(["unstash", [["get", ["get", ["get", "Array", ["quote", "prototype"]], ["quote", "slice"]], ["quote", "call"]], "arguments", length(args1)]]);
      } else {
        add(args1, "|...|");
        return(["unstash", ["list", "|...|"]]);
      }
    };
    if (atom63(args)) {
      return([args1, [join(["let", [args, rest()]], body)]]);
    } else {
      var bs = [];
      var k63 = keys63(args);
      var r = make_id();
      var _g214 = args;
      var k = undefined;
      for (k in _g214) {
        var v = _g214[k];
        var _g215 = parseInt(k);
        var _g286;
        if (isNaN(_g215)) {
          _g286 = k;
        } else {
          _g286 = _g215;
        }
        var _g216 = _g286;
        if (number63(_g216)) {
          if (atom63(v)) {
            add(args1, v);
          } else {
            var x = make_id();
            add(args1, x);
            bs = join(bs, [v, x]);
          }
        }
      }
      if (k63) {
        bs = join(bs, [r, rest()]);
        bs = join(bs, [keys(args), r]);
      }
      return([args1, [join(["let", bs], body)]]);
    }
  };
  nexus["lumen/lib"]["bind*"] = bind42;
  var quoting63 = function (depth) {
    return(number63(depth));
  };
  nexus["lumen/lib"]["quoting?"] = quoting63;
  var quasiquoting63 = function (depth) {
    return(quoting63(depth) && depth > 0);
  };
  nexus["lumen/lib"]["quasiquoting?"] = quasiquoting63;
  var can_unquote63 = function (depth) {
    return(quoting63(depth) && depth === 1);
  };
  nexus["lumen/lib"]["can-unquote?"] = can_unquote63;
  var quasisplice63 = function (x, depth) {
    return(list63(x) && can_unquote63(depth) && hd(x) === "unquote-splicing");
  };
  nexus["lumen/lib"]["quasisplice?"] = quasisplice63;
  var macroexpand = function (form) {
    if (symbol63(form)) {
      return(macroexpand(symbol_expansion(form)));
    } else {
      if (atom63(form)) {
        return(form);
      } else {
        var x = hd(form);
        if (x === "%local") {
          var _g179 = form[0];
          var name = form[1];
          var value = form[2];
          return(["%local", name, macroexpand(value)]);
        } else {
          if (x === "%function") {
            var _g180 = form[0];
            var args = form[1];
            var body = sub(form, 2);
            add(environment, {_scope: true});
            var _g224 = args;
            var _g225 = 0;
            while (_g225 < length(_g224)) {
              var _g222 = _g224[_g225];
              setenv(_g222, {_stash: true, variable: true});
              _g225 = _g225 + 1;
            }
            var _g223 = join(["%function", args], macroexpand(body));
            drop(environment);
            return(_g223);
          } else {
            if (x === "%local-function" || x === "%global-function") {
              var _g181 = form[0];
              var _g226 = form[1];
              var _g227 = form[2];
              var _g228 = sub(form, 3);
              add(environment, {_scope: true});
              var _g231 = _g227;
              var _g232 = 0;
              while (_g232 < length(_g231)) {
                var _g229 = _g231[_g232];
                setenv(_g229, {_stash: true, variable: true});
                _g232 = _g232 + 1;
              }
              var _g230 = join([x, _g226, _g227], macroexpand(_g228));
              drop(environment);
              return(_g230);
            } else {
              if (macro63(x)) {
                return(macroexpand(apply(macro_function(x), tl(form))));
              } else {
                return(map(macroexpand, form));
              }
            }
          }
        }
      }
    }
  };
  nexus["lumen/lib"].macroexpand = macroexpand;
  var quasiexpand;
  nexus["lumen/lib"].quasiexpand = quasiexpand;
  var quasiquote_list;
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list;
  quasiquote_list = function (form, depth) {
    var xs = [["list"]];
    var _g234 = form;
    var k = undefined;
    for (k in _g234) {
      var v = _g234[k];
      var _g235 = parseInt(k);
      var _g287;
      if (isNaN(_g235)) {
        _g287 = k;
      } else {
        _g287 = _g235;
      }
      var _g236 = _g287;
      if (!number63(_g236)) {
        var _g288;
        if (quasisplice63(v, depth)) {
          _g288 = quasiexpand(v[1]);
        } else {
          _g288 = quasiexpand(v, depth);
        }
        var _g237 = _g288;
        last(xs)[_g236] = _g237;
      }
    }
    series(function (x) {
      if (quasisplice63(x, depth)) {
        var _g239 = quasiexpand(x[1]);
        add(xs, _g239);
        return(add(xs, ["list"]));
      } else {
        return(add(last(xs), quasiexpand(x, depth)));
      }
    }, form);
    var pruned = keep(function (x) {
      return(length(x) > 1 || !(hd(x) === "list") || keys63(x));
    }, xs);
    return(join(["join*"], pruned));
  };
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list;
  quasiexpand = function (form, depth) {
    if (quasiquoting63(depth)) {
      if (atom63(form)) {
        return(["quote", form]);
      } else {
        if (can_unquote63(depth) && hd(form) === "unquote") {
          return(quasiexpand(form[1]));
        } else {
          if (hd(form) === "unquote" || hd(form) === "unquote-splicing") {
            return(quasiquote_list(form, depth - 1));
          } else {
            if (hd(form) === "quasiquote") {
              return(quasiquote_list(form, depth + 1));
            } else {
              return(quasiquote_list(form, depth));
            }
          }
        }
      }
    } else {
      if (atom63(form)) {
        return(form);
      } else {
        if (hd(form) === "quote") {
          return(form);
        } else {
          if (hd(form) === "quasiquote") {
            return(quasiexpand(form[1], 1));
          } else {
            return(map(function (x) {
              return(quasiexpand(x, depth));
            }, form));
          }
        }
      }
    }
  };
  nexus["lumen/lib"].quasiexpand = quasiexpand;
  global.indent_level = 0;
  var indentation = function () {
    return(apply(cat, replicate(indent_level, "  ")));
  };
  nexus["lumen/lib"].indentation = indentation;
  var reserved = {"=": true, "==": true, "+": true, "-": true, "%": true, "*": true, "/": true, "<": true, ">": true, "<=": true, ">=": true, "break": true, "case": true, "catch": true, "continue": true, "debugger": true, "default": true, "delete": true, "do": true, "else": true, "finally": true, "for": true, "function": true, "if": true, "in": true, "instanceof": true, "new": true, "return": true, "switch": true, "this": true, "throw": true, "try": true, "typeof": true, "var": true, "void": true, "with": true, "and": true, "end": true, "repeat": true, "while": true, "false": true, "local": true, "nil": true, "then": true, "not": true, "true": true, "elseif": true, "or": true, "until": true};
  nexus["lumen/lib"].reserved = reserved;
  var reserved63 = function (x) {
    return(reserved[x]);
  };
  nexus["lumen/lib"]["reserved?"] = reserved63;
  var numeric63 = function (n) {
    return(n > 47 && n < 58);
  };
  nexus["lumen/lib"]["numeric?"] = numeric63;
  var valid_code63 = function (n) {
    return(numeric63(n) || n > 64 && n < 91 || n > 96 && n < 123 || n === 95);
  };
  nexus["lumen/lib"]["valid-code?"] = valid_code63;
  var valid_id63 = function (id) {
    if (none63(id) || reserved63(id)) {
      return(false);
    } else {
      var i = 0;
      while (i < length(id)) {
        if (!valid_code63(code(id, i))) {
          return(false);
        }
        i = i + 1;
      }
      return(true);
    }
  };
  nexus["lumen/lib"]["valid-id?"] = valid_id63;
  var id = function (id) {
    var id1 = "";
    var i = 0;
    while (i < length(id)) {
      var c = char(id, i);
      var n = code(c);
      var _g289;
      if (c === "-") {
        _g289 = "_";
      } else {
        var _g290;
        if (valid_code63(n)) {
          _g290 = c;
        } else {
          var _g291;
          if (i === 0) {
            _g291 = "_" + n;
          } else {
            _g291 = n;
          }
          _g290 = _g291;
        }
        _g289 = _g290;
      }
      var c1 = _g289;
      id1 = id1 + c1;
      i = i + 1;
    }
    return(id1);
  };
  nexus["lumen/lib"].id = id;
  var key = function (k) {
    var wrap = function (s) {
      if (target === "lua") {
        return("[" + s + "]");
      } else {
        return(s);
      }
    };
    var i = inner(k);
    if (valid_id63(i)) {
      return(i);
    } else {
      return(wrap(k));
    }
  };
  nexus["lumen/lib"].key = key;
  var imported = function (spec) {
    var _g256 = unstash(Array.prototype.slice.call(arguments, 1));
    var private = _g256.private;
    var m = make_id();
    var k = module_key(spec);
    var imports = [];
    if (nexus[k]) {
      var _g257 = module(spec).export;
      var _g259 = undefined;
      for (_g259 in _g257) {
        var v = _g257[_g259];
        var _g258 = parseInt(_g259);
        var _g292;
        if (isNaN(_g258)) {
          _g292 = _g259;
        } else {
          _g292 = _g258;
        }
        var _g260 = _g292;
        if (v.variable && (private || v.export)) {
          add(imports, ["%local", _g260, ["get", m, ["quote", _g260]]]);
        }
      }
    }
    if (some63(imports)) {
      return(join([["%local", m, ["get", "nexus", ["quote", k]]]], imports));
    }
  };
  nexus["lumen/lib"].imported = imported;
  var link = function (name, form) {
    if (toplevel63()) {
      var k = module_key(current_module);
      return(["do", form, ["set", ["get", ["get", "nexus", ["quote", k]], ["quote", name]], name]]);
    } else {
      return(form);
    }
  };
  nexus["lumen/lib"].link = link;
  var extend = function (t) {
    var _g262 = unstash(Array.prototype.slice.call(arguments, 1));
    var xs = sub(_g262, 0);
    return(join(t, xs));
  };
  nexus["lumen/lib"].extend = extend;
  var exclude = function (t) {
    var _g263 = unstash(Array.prototype.slice.call(arguments, 1));
    var keys = sub(_g263, 0);
    var t1 = [];
    var _g264 = t;
    var k = undefined;
    for (k in _g264) {
      var v = _g264[k];
      var _g265 = parseInt(k);
      var _g293;
      if (isNaN(_g265)) {
        _g293 = k;
      } else {
        _g293 = _g265;
      }
      var _g266 = _g293;
      if (!keys[_g266]) {
        t1[_g266] = v;
      }
    }
    return(t1);
  };
  nexus["lumen/lib"].exclude = exclude;
  var quote_binding = function (b) {
    if (is63(b.symbol)) {
      return(extend(b, {_stash: true, symbol: ["quote", b.symbol]}));
    } else {
      if (b.macro && b.form) {
        return(exclude(extend(b, {_stash: true, macro: b.form}), {_stash: true, form: true}));
      } else {
        if (b.special && b.form) {
          return(exclude(extend(b, {_stash: true, special: b.form}), {_stash: true, form: true}));
        } else {
          if (is63(b.variable)) {
            return(b);
          } else {
            if (is63(b.global)) {
              return(b);
            }
          }
        }
      }
    }
  };
  nexus["lumen/lib"]["quote-binding"] = quote_binding;
  var mapo = function (f, t) {
    var o = [];
    var _g269 = t;
    var k = undefined;
    for (k in _g269) {
      var v = _g269[k];
      var _g270 = parseInt(k);
      var _g294;
      if (isNaN(_g270)) {
        _g294 = k;
      } else {
        _g294 = _g270;
      }
      var _g271 = _g294;
      var x = f(v);
      if (is63(x)) {
        add(o, literal(_g271));
        add(o, x);
      }
    }
    return(o);
  };
  nexus["lumen/lib"].mapo = mapo;
  var quote_frame = function (t) {
    return(join(["%object"], mapo(function (b) {
      return(join(["table"], quote_binding(b)));
    }, t)));
  };
  nexus["lumen/lib"]["quote-frame"] = quote_frame;
  var quote_environment = function (env) {
    return(join(["list"], map(quote_frame, env)));
  };
  nexus["lumen/lib"]["quote-environment"] = quote_environment;
  var quote_module = function (m) {
    var _g276 = ["table"];
    _g276.import = quoted(m.import);
    _g276.alias = quoted(m.alias);
    _g276.export = quote_frame(m.export);
    return(_g276);
  };
  nexus["lumen/lib"]["quote-module"] = quote_module;
  var quote_modules = function () {
    return(join(["table"], map(quote_module, modules)));
  };
  nexus["lumen/lib"]["quote-modules"] = quote_modules;
  var initial_environment = function () {
    return([{"define-module": getenv("define-module")}]);
  };
  nexus["lumen/lib"]["initial-environment"] = initial_environment;
})();
(function () {
  nexus["lumen/reader"] = {};
  var _g295 = nexus["lumen/runtime"];
  var nil63 = _g295["nil?"];
  var is63 = _g295["is?"];
  var length = _g295.length;
  var none63 = _g295["none?"];
  var some63 = _g295["some?"];
  var one63 = _g295["one?"];
  var hd = _g295.hd;
  var string63 = _g295["string?"];
  var number63 = _g295["number?"];
  var boolean63 = _g295["boolean?"];
  var function63 = _g295["function?"];
  var composite63 = _g295["composite?"];
  var atom63 = _g295["atom?"];
  var table63 = _g295["table?"];
  var list63 = _g295["list?"];
  var substring = _g295.substring;
  var sub = _g295.sub;
  var keys = _g295.keys;
  var inner = _g295.inner;
  var tl = _g295.tl;
  var char = _g295.char;
  var code = _g295.code;
  var string_literal63 = _g295["string-literal?"];
  var id_literal63 = _g295["id-literal?"];
  var add = _g295.add;
  var drop = _g295.drop;
  var last = _g295.last;
  var reverse = _g295.reverse;
  var join = _g295.join;
  var reduce = _g295.reduce;
  var keep = _g295.keep;
  var in63 = _g295["in?"];
  var find = _g295.find;
  var pair = _g295.pair;
  var sort = _g295.sort;
  var iterate = _g295.iterate;
  var replicate = _g295.replicate;
  var series = _g295.series;
  var map = _g295.map;
  var keys63 = _g295["keys?"];
  var empty63 = _g295["empty?"];
  var stash = _g295.stash;
  var unstash = _g295.unstash;
  var search = _g295.search;
  var split = _g295.split;
  var cat = _g295.cat;
  var _43 = _g295["+"];
  var _ = _g295["-"];
  var _42 = _g295["*"];
  var _47 = _g295["/"];
  var _37 = _g295["%"];
  var _62 = _g295[">"];
  var _60 = _g295["<"];
  var _61 = _g295["="];
  var _6261 = _g295[">="];
  var _6061 = _g295["<="];
  var read_file = _g295["read-file"];
  var write_file = _g295["write-file"];
  var write = _g295.write;
  var exit = _g295.exit;
  var today = _g295.today;
  var now = _g295.now;
  var number = _g295.number;
  var string = _g295.string;
  var space = _g295.space;
  var apply = _g295.apply;
  var make_id = _g295["make-id"];
  var _37message_handler = _g295["%message-handler"];
  var toplevel63 = _g295["toplevel?"];
  var module_key = _g295["module-key"];
  var module = _g295.module;
  var setenv = _g295.setenv;
  var delimiters = {"(": true, ")": true, ";": true, "\n": true};
  nexus["lumen/reader"].delimiters = delimiters;
  var whitespace = {" ": true, "\t": true, "\n": true};
  nexus["lumen/reader"].whitespace = whitespace;
  var make_stream = function (str) {
    return({pos: 0, string: str, len: length(str)});
  };
  nexus["lumen/reader"]["make-stream"] = make_stream;
  var peek_char = function (s) {
    if (s.pos < s.len) {
      return(char(s.string, s.pos));
    }
  };
  nexus["lumen/reader"]["peek-char"] = peek_char;
  var read_char = function (s) {
    var c = peek_char(s);
    if (c) {
      s.pos = s.pos + 1;
      return(c);
    }
  };
  nexus["lumen/reader"]["read-char"] = read_char;
  var skip_non_code = function (s) {
    while (true) {
      var c = peek_char(s);
      if (nil63(c)) {
        break;
      } else {
        if (whitespace[c]) {
          read_char(s);
        } else {
          if (c === ";") {
            while (c && !(c === "\n")) {
              c = read_char(s);
            }
            skip_non_code(s);
          } else {
            break;
          }
        }
      }
    }
  };
  nexus["lumen/reader"]["skip-non-code"] = skip_non_code;
  var read_table = {};
  nexus["lumen/reader"]["read-table"] = read_table;
  var eof = {};
  nexus["lumen/reader"].eof = eof;
  var read = function (s) {
    skip_non_code(s);
    var c = peek_char(s);
    if (is63(c)) {
      return((read_table[c] || read_table[""])(s));
    } else {
      return(eof);
    }
  };
  nexus["lumen/reader"].read = read;
  var read_all = function (s) {
    var l = [];
    while (true) {
      var form = read(s);
      if (form === eof) {
        break;
      }
      add(l, form);
    }
    return(l);
  };
  nexus["lumen/reader"]["read-all"] = read_all;
  var read_from_string = function (str) {
    var x = read(make_stream(str));
    if (x != eof) {
      return(x);
    }
  };
  nexus["lumen/reader"]["read-from-string"] = read_from_string;
  var key63 = function (atom) {
    return(string63(atom) && length(atom) > 1 && char(atom, length(atom) - 1) === ":");
  };
  nexus["lumen/reader"]["key?"] = key63;
  var flag63 = function (atom) {
    return(string63(atom) && length(atom) > 1 && char(atom, 0) === ":");
  };
  nexus["lumen/reader"]["flag?"] = flag63;
  read_table[""] = function (s) {
    var str = "";
    var dot63 = false;
    while (true) {
      var c = peek_char(s);
      if (c && (!whitespace[c] && !delimiters[c])) {
        if (c === ".") {
          dot63 = true;
        }
        str = str + c;
        read_char(s);
      } else {
        break;
      }
    }
    var n = number(str);
    if (is63(n)) {
      return(n);
    } else {
      if (str === "true") {
        return(true);
      } else {
        if (str === "false") {
          return(false);
        } else {
          if (str === "_") {
            return(make_id());
          } else {
            if (dot63 && !one63(str)) {
              return(reduce(function (a, b) {
                return(["get", b, ["quote", a]]);
              }, reverse(split(str, "."))));
            } else {
              return(str);
            }
          }
        }
      }
    }
  };
  read_table["("] = function (s) {
    read_char(s);
    var l = [];
    while (true) {
      skip_non_code(s);
      var c = peek_char(s);
      if (c && !(c === ")")) {
        var x = read(s);
        if (key63(x)) {
          var k = sub(x, 0, length(x) - 1);
          var v = read(s);
          l[k] = v;
        } else {
          if (flag63(x)) {
            l[sub(x, 1)] = true;
          } else {
            add(l, x);
          }
        }
      } else {
        if (c) {
          read_char(s);
          break;
        } else {
          throw new Error("Expected ) at " + s.pos);
        }
      }
    }
    return(l);
  };
  read_table[")"] = function (s) {
    throw new Error("Unexpected ) at " + s.pos);
  };
  read_table["\""] = function (s) {
    read_char(s);
    var str = "\"";
    while (true) {
      var c = peek_char(s);
      if (c && !(c === "\"")) {
        if (c === "\\") {
          str = str + read_char(s);
        }
        str = str + read_char(s);
      } else {
        if (c) {
          read_char(s);
          break;
        } else {
          throw new Error("Expected \" at " + s.pos);
        }
      }
    }
    return(str + "\"");
  };
  read_table["|"] = function (s) {
    read_char(s);
    var str = "|";
    while (true) {
      var c = peek_char(s);
      if (c && !(c === "|")) {
        str = str + read_char(s);
      } else {
        if (c) {
          read_char(s);
          break;
        } else {
          throw new Error("Expected | at " + s.pos);
        }
      }
    }
    return(str + "|");
  };
  read_table["'"] = function (s) {
    read_char(s);
    return(["quote", read(s)]);
  };
  read_table["`"] = function (s) {
    read_char(s);
    return(["quasiquote", read(s)]);
  };
  read_table[","] = function (s) {
    read_char(s);
    if (peek_char(s) === "@") {
      read_char(s);
      return(["unquote-splicing", read(s)]);
    } else {
      return(["unquote", read(s)]);
    }
  };
})();
(function () {
  nexus["lumen/compiler"] = {};
  var _g324 = nexus["lumen/runtime"];
  var nil63 = _g324["nil?"];
  var is63 = _g324["is?"];
  var length = _g324.length;
  var none63 = _g324["none?"];
  var some63 = _g324["some?"];
  var one63 = _g324["one?"];
  var hd = _g324.hd;
  var string63 = _g324["string?"];
  var number63 = _g324["number?"];
  var boolean63 = _g324["boolean?"];
  var function63 = _g324["function?"];
  var composite63 = _g324["composite?"];
  var atom63 = _g324["atom?"];
  var table63 = _g324["table?"];
  var list63 = _g324["list?"];
  var substring = _g324.substring;
  var sub = _g324.sub;
  var keys = _g324.keys;
  var inner = _g324.inner;
  var tl = _g324.tl;
  var char = _g324.char;
  var code = _g324.code;
  var string_literal63 = _g324["string-literal?"];
  var id_literal63 = _g324["id-literal?"];
  var add = _g324.add;
  var drop = _g324.drop;
  var last = _g324.last;
  var reverse = _g324.reverse;
  var join = _g324.join;
  var reduce = _g324.reduce;
  var keep = _g324.keep;
  var in63 = _g324["in?"];
  var find = _g324.find;
  var pair = _g324.pair;
  var sort = _g324.sort;
  var iterate = _g324.iterate;
  var replicate = _g324.replicate;
  var series = _g324.series;
  var map = _g324.map;
  var keys63 = _g324["keys?"];
  var empty63 = _g324["empty?"];
  var stash = _g324.stash;
  var unstash = _g324.unstash;
  var search = _g324.search;
  var split = _g324.split;
  var cat = _g324.cat;
  var _43 = _g324["+"];
  var _ = _g324["-"];
  var _42 = _g324["*"];
  var _47 = _g324["/"];
  var _37 = _g324["%"];
  var _62 = _g324[">"];
  var _60 = _g324["<"];
  var _61 = _g324["="];
  var _6261 = _g324[">="];
  var _6061 = _g324["<="];
  var read_file = _g324["read-file"];
  var write_file = _g324["write-file"];
  var write = _g324.write;
  var exit = _g324.exit;
  var today = _g324.today;
  var now = _g324.now;
  var number = _g324.number;
  var string = _g324.string;
  var space = _g324.space;
  var apply = _g324.apply;
  var make_id = _g324["make-id"];
  var _37message_handler = _g324["%message-handler"];
  var toplevel63 = _g324["toplevel?"];
  var module_key = _g324["module-key"];
  var module = _g324.module;
  var setenv = _g324.setenv;
  var _g327 = nexus["lumen/lib"];
  var getenv = _g327.getenv;
  var macro_function = _g327["macro-function"];
  var macro63 = _g327["macro?"];
  var special63 = _g327["special?"];
  var special_form63 = _g327["special-form?"];
  var statement63 = _g327["statement?"];
  var symbol_expansion = _g327["symbol-expansion"];
  var symbol63 = _g327["symbol?"];
  var variable63 = _g327["variable?"];
  var bound63 = _g327["bound?"];
  var quoted = _g327.quoted;
  var stash42 = _g327["stash*"];
  var index = _g327.index;
  var bind = _g327.bind;
  var bind42 = _g327["bind*"];
  var quasiexpand = _g327.quasiexpand;
  var macroexpand = _g327.macroexpand;
  var indentation = _g327.indentation;
  var reserved63 = _g327["reserved?"];
  var valid_id63 = _g327["valid-id?"];
  var id = _g327.id;
  var key = _g327.key;
  var imported = _g327.imported;
  var link = _g327.link;
  var mapo = _g327.mapo;
  var quote_environment = _g327["quote-environment"];
  var quote_modules = _g327["quote-modules"];
  var initial_environment = _g327["initial-environment"];
  var _g328 = nexus["lumen/reader"];
  var make_stream = _g328["make-stream"];
  var read_table = _g328["read-table"];
  var read = _g328.read;
  var read_all = _g328["read-all"];
  var read_from_string = _g328["read-from-string"];
  var _g332 = [];
  _g332.js = "!";
  _g332.lua = "not ";
  var _g330 = [];
  var _g333 = [];
  _g333.js = "!";
  _g333.lua = "not ";
  _g330["not"] = _g333;
  var _g335 = [];
  _g335["*"] = true;
  _g335["/"] = true;
  _g335["%"] = true;
  var _g337 = [];
  _g337["+"] = true;
  _g337["-"] = true;
  var _g341 = [];
  _g341.js = "+";
  _g341.lua = "..";
  var _g339 = [];
  var _g342 = [];
  _g342.js = "+";
  _g342.lua = "..";
  _g339.cat = _g342;
  var _g344 = [];
  _g344["<"] = true;
  _g344[">"] = true;
  _g344["<="] = true;
  _g344[">="] = true;
  var _g348 = [];
  _g348.js = "===";
  _g348.lua = "==";
  var _g350 = [];
  _g350.js = "!=";
  _g350.lua = "~=";
  var _g346 = [];
  var _g351 = [];
  _g351.js = "===";
  _g351.lua = "==";
  _g346["="] = _g351;
  var _g352 = [];
  _g352.js = "!=";
  _g352.lua = "~=";
  _g346["~="] = _g352;
  var _g356 = [];
  _g356.js = "&&";
  _g356.lua = "and";
  var _g354 = [];
  var _g357 = [];
  _g357.js = "&&";
  _g357.lua = "and";
  _g354["and"] = _g357;
  var _g361 = [];
  _g361.js = "||";
  _g361.lua = "or";
  var _g359 = [];
  var _g362 = [];
  _g362.js = "||";
  _g362.lua = "or";
  _g359["or"] = _g362;
  var infix = [_g330, _g335, _g337, _g339, _g344, _g346, _g354, _g359];
  nexus["lumen/compiler"].infix = infix;
  var unary63 = function (form) {
    var op = form[0];
    var args = sub(form, 1);
    return(one63(args) && in63(op, ["not", "-"]));
  };
  nexus["lumen/compiler"]["unary?"] = unary63;
  var precedence = function (form) {
    if (list63(form) && !unary63(form)) {
      var _g365 = infix;
      var k = undefined;
      for (k in _g365) {
        var v = _g365[k];
        var _g366 = parseInt(k);
        var _g441;
        if (isNaN(_g366)) {
          _g441 = k;
        } else {
          _g441 = _g366;
        }
        var _g367 = _g441;
        if (v[hd(form)]) {
          return(index(_g367));
        }
      }
    }
    return(0);
  };
  nexus["lumen/compiler"].precedence = precedence;
  var getop = function (op) {
    return(find(function (level) {
      var x = level[op];
      if (x === true) {
        return(op);
      } else {
        if (is63(x)) {
          return(x[target]);
        }
      }
    }, infix));
  };
  nexus["lumen/compiler"].getop = getop;
  var infix63 = function (x) {
    return(is63(getop(x)));
  };
  nexus["lumen/compiler"]["infix?"] = infix63;
  var compile;
  nexus["lumen/compiler"].compile = compile;
  var compile_args = function (args) {
    var str = "(";
    var comma = "";
    series(function (x) {
      str = str + comma + compile(x);
      comma = ", ";
    }, args);
    return(str + ")");
  };
  nexus["lumen/compiler"]["compile-args"] = compile_args;
  var compile_atom = function (x) {
    if (x === "nil" && target === "lua") {
      return(x);
    } else {
      if (x === "nil") {
        return("undefined");
      } else {
        if (id_literal63(x)) {
          return(inner(x));
        } else {
          if (string_literal63(x)) {
            return(x);
          } else {
            if (string63(x)) {
              return(id(x));
            } else {
              if (boolean63(x)) {
                if (x) {
                  return("true");
                } else {
                  return("false");
                }
              } else {
                if (number63(x)) {
                  return(x + "");
                } else {
                  throw new Error("Cannot compile atom: " + string(x));
                }
              }
            }
          }
        }
      }
    }
  };
  nexus["lumen/compiler"]["compile-atom"] = compile_atom;
  var terminator = function (stmt63) {
    if (!stmt63) {
      return("");
    } else {
      if (target === "js") {
        return(";\n");
      } else {
        return("\n");
      }
    }
  };
  nexus["lumen/compiler"].terminator = terminator;
  var compile_special = function (form, stmt63) {
    var x = form[0];
    var args = sub(form, 1);
    var _g376 = getenv(x);
    var special = _g376.special;
    var stmt = _g376.stmt;
    var self_tr63 = _g376.tr;
    var tr = terminator(stmt63 && !self_tr63);
    return(apply(special, args) + tr);
  };
  nexus["lumen/compiler"]["compile-special"] = compile_special;
  var parenthesize_call63 = function (x) {
    return(list63(x) && (hd(x) === "%function" || precedence(x) > 0));
  };
  nexus["lumen/compiler"]["parenthesize-call?"] = parenthesize_call63;
  var compile_call = function (form) {
    var f = hd(form);
    var f1 = compile(f);
    var args = compile_args(stash42(tl(form)));
    if (parenthesize_call63(f)) {
      return("(" + f1 + ")" + args);
    } else {
      return(f1 + args);
    }
  };
  nexus["lumen/compiler"]["compile-call"] = compile_call;
  var op_delims = function (parent, child) {
    var _g379 = unstash(Array.prototype.slice.call(arguments, 2));
    var right = _g379.right;
    var _g442;
    if (right) {
      _g442 = _6261;
    } else {
      _g442 = _62;
    }
    if (_g442(precedence(child), precedence(parent))) {
      return(["(", ")"]);
    } else {
      return(["", ""]);
    }
  };
  nexus["lumen/compiler"]["op-delims"] = op_delims;
  var compile_infix = function (form) {
    var op = form[0];
    var _g381 = sub(form, 1);
    var a = _g381[0];
    var b = _g381[1];
    var _g382 = op_delims(form, a);
    var ao = _g382[0];
    var ac = _g382[1];
    var _g383 = op_delims(form, b, {_stash: true, right: true});
    var bo = _g383[0];
    var bc = _g383[1];
    var _g384 = compile(a);
    var _g385 = compile(b);
    var _g386 = getop(op);
    if (unary63(form)) {
      return(_g386 + ao + _g384 + ac);
    } else {
      return(ao + _g384 + ac + " " + _g386 + " " + bo + _g385 + bc);
    }
  };
  nexus["lumen/compiler"]["compile-infix"] = compile_infix;
  var compile_function = function (args, body) {
    var _g387 = unstash(Array.prototype.slice.call(arguments, 2));
    var name = _g387.name;
    var prefix = _g387.prefix;
    var _g443;
    if (name) {
      _g443 = compile(name);
    } else {
      _g443 = "";
    }
    var id = _g443;
    var _g388 = prefix || "";
    var _g389 = compile_args(args);
    indent_level = indent_level + 1;
    var _g391 = compile(body, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var _g390 = _g391;
    var ind = indentation();
    var _g444;
    if (target === "js") {
      _g444 = "";
    } else {
      _g444 = "end";
    }
    var tr = _g444;
    if (name) {
      tr = tr + "\n";
    }
    if (target === "js") {
      return("function " + id + _g389 + " {\n" + _g390 + ind + "}" + tr);
    } else {
      return(_g388 + "function " + id + _g389 + "\n" + _g390 + ind + tr);
    }
  };
  nexus["lumen/compiler"]["compile-function"] = compile_function;
  var can_return63 = function (form) {
    return(is63(form) && (atom63(form) || !(hd(form) === "return") && !statement63(hd(form))));
  };
  nexus["lumen/compiler"]["can-return?"] = can_return63;
  compile = function (form) {
    var _g393 = unstash(Array.prototype.slice.call(arguments, 1));
    var stmt = _g393.stmt;
    if (nil63(form)) {
      return("");
    } else {
      if (special_form63(form)) {
        return(compile_special(form, stmt));
      } else {
        var tr = terminator(stmt);
        var _g445;
        if (stmt) {
          _g445 = indentation();
        } else {
          _g445 = "";
        }
        var ind = _g445;
        var _g446;
        if (atom63(form)) {
          _g446 = compile_atom(form);
        } else {
          var _g447;
          if (infix63(hd(form))) {
            _g447 = compile_infix(form);
          } else {
            _g447 = compile_call(form);
          }
          _g446 = _g447;
        }
        var _g394 = _g446;
        return(ind + _g394 + tr);
      }
    }
  };
  nexus["lumen/compiler"].compile = compile;
  var lower;
  nexus["lumen/compiler"].lower = lower;
  var lower_statement = function (form, tail63) {
    var hoist = [];
    var e = lower(form, hoist, true, tail63);
    if (some63(hoist) && is63(e)) {
      return(join(["do"], join(hoist, [e])));
    } else {
      if (is63(e)) {
        return(e);
      } else {
        if (length(hoist) > 1) {
          return(join(["do"], hoist));
        } else {
          return(hd(hoist));
        }
      }
    }
  };
  nexus["lumen/compiler"]["lower-statement"] = lower_statement;
  var lower_body = function (body, tail63) {
    return(lower_statement(join(["do"], body), tail63));
  };
  nexus["lumen/compiler"]["lower-body"] = lower_body;
  var lower_do = function (args, hoist, stmt63, tail63) {
    var _g398 = sub(args, 0, length(args) - 1);
    var _g399 = 0;
    while (_g399 < length(_g398)) {
      var x = _g398[_g399];
      add(hoist, lower(x, hoist, stmt63));
      _g399 = _g399 + 1;
    }
    var e = lower(last(args), hoist, stmt63, tail63);
    if (tail63 && can_return63(e)) {
      return(["return", e]);
    } else {
      return(e);
    }
  };
  nexus["lumen/compiler"]["lower-do"] = lower_do;
  var lower_if = function (args, hoist, stmt63, tail63) {
    var cond = args[0];
    var _g401 = args[1];
    var _g402 = args[2];
    if (stmt63 || tail63) {
      var _g449;
      if (_g402) {
        _g449 = [lower_body([_g402], tail63)];
      }
      return(add(hoist, join(["%if", lower(cond, hoist), lower_body([_g401], tail63)], _g449)));
    } else {
      var e = make_id();
      add(hoist, ["%local", e]);
      var _g448;
      if (_g402) {
        _g448 = [lower(["set", e, _g402])];
      }
      add(hoist, join(["%if", lower(cond, hoist), lower(["set", e, _g401])], _g448));
      return(e);
    }
  };
  nexus["lumen/compiler"]["lower-if"] = lower_if;
  var lower_short = function (x, args, hoist) {
    var a = args[0];
    var b = args[1];
    var hoist1 = [];
    var b1 = lower(b, hoist1);
    if (some63(hoist1)) {
      var id = make_id();
      var _g450;
      if (x === "and") {
        _g450 = ["%if", id, b, id];
      } else {
        _g450 = ["%if", id, id, b];
      }
      return(lower(["do", ["%local", id, a], _g450], hoist));
    } else {
      return([x, lower(a, hoist), b1]);
    }
  };
  nexus["lumen/compiler"]["lower-short"] = lower_short;
  var lower_try = function (args, hoist, tail63) {
    return(add(hoist, ["%try", lower_body(args, tail63)]));
  };
  nexus["lumen/compiler"]["lower-try"] = lower_try;
  var lower_while = function (args, hoist) {
    var c = args[0];
    var body = sub(args, 1);
    return(add(hoist, ["while", lower(c, hoist), lower_body(body)]));
  };
  nexus["lumen/compiler"]["lower-while"] = lower_while;
  var lower_for = function (args, hoist) {
    var t = args[0];
    var k = args[1];
    var body = sub(args, 2);
    return(add(hoist, ["%for", lower(t, hoist), k, lower_body(body)]));
  };
  nexus["lumen/compiler"]["lower-for"] = lower_for;
  var lower_function = function (args) {
    var a = args[0];
    var body = sub(args, 1);
    return(["%function", a, lower_body(body, true)]);
  };
  nexus["lumen/compiler"]["lower-function"] = lower_function;
  var lower_definition = function (kind, args, hoist) {
    var name = args[0];
    var _g409 = args[1];
    var body = sub(args, 2);
    return(add(hoist, [kind, name, _g409, lower_body(body, true)]));
  };
  nexus["lumen/compiler"]["lower-definition"] = lower_definition;
  var lower_call = function (form, hoist) {
    var _g411 = map(function (x) {
      return(lower(x, hoist));
    }, form);
    if (some63(_g411)) {
      return(_g411);
    }
  };
  nexus["lumen/compiler"]["lower-call"] = lower_call;
  var lower_infix63 = function (form) {
    return(infix63(hd(form)) && length(form) > 3);
  };
  nexus["lumen/compiler"]["lower-infix?"] = lower_infix63;
  var lower_infix = function (form, hoist) {
    var x = form[0];
    var args = sub(form, 1);
    return(lower(reduce(function (a, b) {
      return([x, b, a]);
    }, reverse(args)), hoist));
  };
  nexus["lumen/compiler"]["lower-infix"] = lower_infix;
  var lower_special = function (form, hoist) {
    var e = lower_call(form, hoist);
    if (e) {
      return(add(hoist, e));
    }
  };
  nexus["lumen/compiler"]["lower-special"] = lower_special;
  lower = function (form, hoist, stmt63, tail63) {
    if (atom63(form)) {
      return(form);
    } else {
      if (empty63(form)) {
        return(["%array"]);
      } else {
        if (nil63(hoist)) {
          return(lower_statement(form));
        } else {
          if (lower_infix63(form)) {
            return(lower_infix(form, hoist));
          } else {
            var x = form[0];
            var args = sub(form, 1);
            if (x === "do") {
              return(lower_do(args, hoist, stmt63, tail63));
            } else {
              if (x === "%if") {
                return(lower_if(args, hoist, stmt63, tail63));
              } else {
                if (x === "%try") {
                  return(lower_try(args, hoist, tail63));
                } else {
                  if (x === "while") {
                    return(lower_while(args, hoist));
                  } else {
                    if (x === "%for") {
                      return(lower_for(args, hoist));
                    } else {
                      if (x === "%function") {
                        return(lower_function(args));
                      } else {
                        if (in63(x, ["%local-function", "%global-function"])) {
                          return(lower_definition(x, args, hoist));
                        } else {
                          if (in63(x, ["and", "or"])) {
                            return(lower_short(x, args, hoist));
                          } else {
                            if (statement63(x)) {
                              return(lower_special(form, hoist));
                            } else {
                              return(lower_call(form, hoist));
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  };
  nexus["lumen/compiler"].lower = lower;
  var process = function (form) {
    return(lower(macroexpand(form)));
  };
  nexus["lumen/compiler"].process = process;
  global.current_module = undefined;
  var module_path = function (spec) {
    return(module_key(spec) + ".l");
  };
  nexus["lumen/compiler"]["module-path"] = module_path;
  var encapsulate = function (body) {
    return([["%function", [], process(join(["do"], body))]]);
  };
  nexus["lumen/compiler"].encapsulate = encapsulate;
  var compile_file = function (file) {
    var str = read_file(file);
    var body = read_all(make_stream(str));
    var form = encapsulate(body);
    return(compile(form) + ";\n");
  };
  nexus["lumen/compiler"]["compile-file"] = compile_file;
  var run = function (code) {
    return(global.eval(code));
  };
  nexus["lumen/compiler"].run = run;
  var compiling63 = false;
  nexus["lumen/compiler"]["compiling?"] = compiling63;
  var compiler_output = "";
  nexus["lumen/compiler"]["compiler-output"] = compiler_output;
  var conclude = function (code) {
    if (compiling63) {
      compiler_output = compiler_output + code;
    } else {
      return(run(code));
    }
  };
  nexus["lumen/compiler"].conclude = conclude;
  var _37compile_module = function (spec) {
    var path = module_path(spec);
    var mod0 = current_module;
    var env0 = environment;
    current_module = spec;
    environment = initial_environment();
    var code = compile_file(path);
    current_module = mod0;
    environment = env0;
    return(conclude(code));
  };
  nexus["lumen/compiler"]["%compile-module"] = _37compile_module;
  var open_module = function (spec) {
    var _g425 = unstash(Array.prototype.slice.call(arguments, 1));
    var _g426 = _g425.all;
    var m = module(spec);
    var frame = last(environment);
    var _g427 = m.export;
    var k = undefined;
    for (k in _g427) {
      if (isNaN(parseInt(k))) {
        var v = _g427[k];
        if (v.export || _g426) {
          frame[k] = v;
        }
      }
    }
  };
  nexus["lumen/compiler"]["open-module"] = open_module;
  var load_module = function (spec) {
    var _g428 = unstash(Array.prototype.slice.call(arguments, 1));
    var _g429 = _g428.all;
    if (!module(spec)) {
      _37compile_module(spec);
    }
    return(open_module(spec, {_stash: true, all: _g429}));
  };
  nexus["lumen/compiler"]["load-module"] = load_module;
  var in_module = function (spec) {
    load_module(spec, {_stash: true, all: true});
    var m = module(spec);
    series(open_module, m.import);
    current_module = spec;
  };
  nexus["lumen/compiler"]["in-module"] = in_module;
  var import_modules = function (specs) {
    var imports = [];
    var bindings = [];
    var _g432 = specs || [];
    var _g433 = 0;
    while (_g433 < length(_g432)) {
      var spec = _g432[_g433];
      load_module(spec);
      var m = module(spec);
      if (m.alias) {
        var _g434 = import_modules(m.alias);
        var aliased = _g434[0];
        var bs = _g434[1];
        imports = join(imports, aliased);
        bindings = join(bindings, bs);
      } else {
        var _g435 = imported(spec);
        add(imports, spec);
        bindings = join(bindings, _g435);
      }
      _g433 = _g433 + 1;
    }
    return([imports, bindings]);
  };
  nexus["lumen/compiler"]["import-modules"] = import_modules;
  var compile_module = function (spec) {
    compiling63 = true;
    _37compile_module(spec);
    return(compiler_output);
  };
  nexus["lumen/compiler"]["compile-module"] = compile_module;
  var declare = function (form) {
    return(conclude(compile(process(form), {_stash: true, stmt: true})));
  };
  nexus["lumen/compiler"].declare = declare;
  var reimported = function () {
    var imports = [];
    var m = module(current_module);
    series(function (spec) {
      imports = join(imports, imported(spec));
    }, m.import);
    return(join(imports, imported(current_module, {_stash: true, private: true})));
  };
  nexus["lumen/compiler"].reimported = reimported;
  global._37result = undefined;
  var eval = function (form) {
    var previous = target;
    target = "js";
    var body = join(reimported(), [["set", "%result", form]]);
    var code = compile(encapsulate(body));
    target = previous;
    run(code);
    return(_37result);
  };
  nexus["lumen/compiler"].eval = eval;
})();
(function () {
  nexus["lumen/special"] = {};
  var _g451 = nexus["lumen/runtime"];
  var nil63 = _g451["nil?"];
  var is63 = _g451["is?"];
  var length = _g451.length;
  var none63 = _g451["none?"];
  var some63 = _g451["some?"];
  var one63 = _g451["one?"];
  var hd = _g451.hd;
  var string63 = _g451["string?"];
  var number63 = _g451["number?"];
  var boolean63 = _g451["boolean?"];
  var function63 = _g451["function?"];
  var composite63 = _g451["composite?"];
  var atom63 = _g451["atom?"];
  var table63 = _g451["table?"];
  var list63 = _g451["list?"];
  var substring = _g451.substring;
  var sub = _g451.sub;
  var keys = _g451.keys;
  var inner = _g451.inner;
  var tl = _g451.tl;
  var char = _g451.char;
  var code = _g451.code;
  var string_literal63 = _g451["string-literal?"];
  var id_literal63 = _g451["id-literal?"];
  var add = _g451.add;
  var drop = _g451.drop;
  var last = _g451.last;
  var reverse = _g451.reverse;
  var join = _g451.join;
  var reduce = _g451.reduce;
  var keep = _g451.keep;
  var in63 = _g451["in?"];
  var find = _g451.find;
  var pair = _g451.pair;
  var sort = _g451.sort;
  var iterate = _g451.iterate;
  var replicate = _g451.replicate;
  var series = _g451.series;
  var map = _g451.map;
  var keys63 = _g451["keys?"];
  var empty63 = _g451["empty?"];
  var stash = _g451.stash;
  var unstash = _g451.unstash;
  var search = _g451.search;
  var split = _g451.split;
  var cat = _g451.cat;
  var _43 = _g451["+"];
  var _ = _g451["-"];
  var _42 = _g451["*"];
  var _47 = _g451["/"];
  var _37 = _g451["%"];
  var _62 = _g451[">"];
  var _60 = _g451["<"];
  var _61 = _g451["="];
  var _6261 = _g451[">="];
  var _6061 = _g451["<="];
  var read_file = _g451["read-file"];
  var write_file = _g451["write-file"];
  var write = _g451.write;
  var exit = _g451.exit;
  var today = _g451.today;
  var now = _g451.now;
  var number = _g451.number;
  var string = _g451.string;
  var space = _g451.space;
  var apply = _g451.apply;
  var make_id = _g451["make-id"];
  var _37message_handler = _g451["%message-handler"];
  var toplevel63 = _g451["toplevel?"];
  var module_key = _g451["module-key"];
  var module = _g451.module;
  var setenv = _g451.setenv;
  var _g454 = nexus["lumen/lib"];
  var getenv = _g454.getenv;
  var macro_function = _g454["macro-function"];
  var macro63 = _g454["macro?"];
  var special63 = _g454["special?"];
  var special_form63 = _g454["special-form?"];
  var statement63 = _g454["statement?"];
  var symbol_expansion = _g454["symbol-expansion"];
  var symbol63 = _g454["symbol?"];
  var variable63 = _g454["variable?"];
  var bound63 = _g454["bound?"];
  var quoted = _g454.quoted;
  var stash42 = _g454["stash*"];
  var index = _g454.index;
  var bind = _g454.bind;
  var bind42 = _g454["bind*"];
  var quasiexpand = _g454.quasiexpand;
  var macroexpand = _g454.macroexpand;
  var indentation = _g454.indentation;
  var reserved63 = _g454["reserved?"];
  var valid_id63 = _g454["valid-id?"];
  var id = _g454.id;
  var key = _g454.key;
  var imported = _g454.imported;
  var link = _g454.link;
  var mapo = _g454.mapo;
  var quote_environment = _g454["quote-environment"];
  var quote_modules = _g454["quote-modules"];
  var initial_environment = _g454["initial-environment"];
  var _g455 = nexus["lumen/compiler"];
  var compile_function = _g455["compile-function"];
  var compile = _g455.compile;
  var open_module = _g455["open-module"];
  var load_module = _g455["load-module"];
  var in_module = _g455["in-module"];
  var import_modules = _g455["import-modules"];
  var compile_module = _g455["compile-module"];
  var declare = _g455.declare;
  var eval = _g455.eval;
})();
(function () {
  nexus["lumen/core"] = {};
  var _g642 = nexus["lumen/runtime"];
  var nil63 = _g642["nil?"];
  var is63 = _g642["is?"];
  var length = _g642.length;
  var none63 = _g642["none?"];
  var some63 = _g642["some?"];
  var one63 = _g642["one?"];
  var hd = _g642.hd;
  var string63 = _g642["string?"];
  var number63 = _g642["number?"];
  var boolean63 = _g642["boolean?"];
  var function63 = _g642["function?"];
  var composite63 = _g642["composite?"];
  var atom63 = _g642["atom?"];
  var table63 = _g642["table?"];
  var list63 = _g642["list?"];
  var substring = _g642.substring;
  var sub = _g642.sub;
  var keys = _g642.keys;
  var inner = _g642.inner;
  var tl = _g642.tl;
  var char = _g642.char;
  var code = _g642.code;
  var string_literal63 = _g642["string-literal?"];
  var id_literal63 = _g642["id-literal?"];
  var add = _g642.add;
  var drop = _g642.drop;
  var last = _g642.last;
  var reverse = _g642.reverse;
  var join = _g642.join;
  var reduce = _g642.reduce;
  var keep = _g642.keep;
  var in63 = _g642["in?"];
  var find = _g642.find;
  var pair = _g642.pair;
  var sort = _g642.sort;
  var iterate = _g642.iterate;
  var replicate = _g642.replicate;
  var series = _g642.series;
  var map = _g642.map;
  var keys63 = _g642["keys?"];
  var empty63 = _g642["empty?"];
  var stash = _g642.stash;
  var unstash = _g642.unstash;
  var search = _g642.search;
  var split = _g642.split;
  var cat = _g642.cat;
  var _43 = _g642["+"];
  var _ = _g642["-"];
  var _42 = _g642["*"];
  var _47 = _g642["/"];
  var _37 = _g642["%"];
  var _62 = _g642[">"];
  var _60 = _g642["<"];
  var _61 = _g642["="];
  var _6261 = _g642[">="];
  var _6061 = _g642["<="];
  var read_file = _g642["read-file"];
  var write_file = _g642["write-file"];
  var write = _g642.write;
  var exit = _g642.exit;
  var today = _g642.today;
  var now = _g642.now;
  var number = _g642.number;
  var string = _g642.string;
  var space = _g642.space;
  var apply = _g642.apply;
  var make_id = _g642["make-id"];
  var _37message_handler = _g642["%message-handler"];
  var toplevel63 = _g642["toplevel?"];
  var module_key = _g642["module-key"];
  var module = _g642.module;
  var setenv = _g642.setenv;
  var _g645 = nexus["lumen/lib"];
  var getenv = _g645.getenv;
  var macro_function = _g645["macro-function"];
  var macro63 = _g645["macro?"];
  var special63 = _g645["special?"];
  var special_form63 = _g645["special-form?"];
  var statement63 = _g645["statement?"];
  var symbol_expansion = _g645["symbol-expansion"];
  var symbol63 = _g645["symbol?"];
  var variable63 = _g645["variable?"];
  var bound63 = _g645["bound?"];
  var quoted = _g645.quoted;
  var stash42 = _g645["stash*"];
  var index = _g645.index;
  var bind = _g645.bind;
  var bind42 = _g645["bind*"];
  var quasiexpand = _g645.quasiexpand;
  var macroexpand = _g645.macroexpand;
  var indentation = _g645.indentation;
  var reserved63 = _g645["reserved?"];
  var valid_id63 = _g645["valid-id?"];
  var id = _g645.id;
  var key = _g645.key;
  var imported = _g645.imported;
  var link = _g645.link;
  var mapo = _g645.mapo;
  var quote_environment = _g645["quote-environment"];
  var quote_modules = _g645["quote-modules"];
  var initial_environment = _g645["initial-environment"];
  var _g646 = nexus["lumen/compiler"];
  var compile_function = _g646["compile-function"];
  var compile = _g646.compile;
  var open_module = _g646["open-module"];
  var load_module = _g646["load-module"];
  var in_module = _g646["in-module"];
  var import_modules = _g646["import-modules"];
  var compile_module = _g646["compile-module"];
  var declare = _g646.declare;
  var eval = _g646.eval;
  global.target = "js";
})();
(function () {
  nexus["lumen/boot"] = {};
  var _g969 = nexus["lumen/runtime"];
  var nil63 = _g969["nil?"];
  var is63 = _g969["is?"];
  var length = _g969.length;
  var none63 = _g969["none?"];
  var some63 = _g969["some?"];
  var one63 = _g969["one?"];
  var hd = _g969.hd;
  var string63 = _g969["string?"];
  var number63 = _g969["number?"];
  var boolean63 = _g969["boolean?"];
  var function63 = _g969["function?"];
  var composite63 = _g969["composite?"];
  var atom63 = _g969["atom?"];
  var table63 = _g969["table?"];
  var list63 = _g969["list?"];
  var substring = _g969.substring;
  var sub = _g969.sub;
  var keys = _g969.keys;
  var inner = _g969.inner;
  var tl = _g969.tl;
  var char = _g969.char;
  var code = _g969.code;
  var string_literal63 = _g969["string-literal?"];
  var id_literal63 = _g969["id-literal?"];
  var add = _g969.add;
  var drop = _g969.drop;
  var last = _g969.last;
  var reverse = _g969.reverse;
  var join = _g969.join;
  var reduce = _g969.reduce;
  var keep = _g969.keep;
  var in63 = _g969["in?"];
  var find = _g969.find;
  var pair = _g969.pair;
  var sort = _g969.sort;
  var iterate = _g969.iterate;
  var replicate = _g969.replicate;
  var series = _g969.series;
  var map = _g969.map;
  var keys63 = _g969["keys?"];
  var empty63 = _g969["empty?"];
  var stash = _g969.stash;
  var unstash = _g969.unstash;
  var search = _g969.search;
  var split = _g969.split;
  var cat = _g969.cat;
  var _43 = _g969["+"];
  var _ = _g969["-"];
  var _42 = _g969["*"];
  var _47 = _g969["/"];
  var _37 = _g969["%"];
  var _62 = _g969[">"];
  var _60 = _g969["<"];
  var _61 = _g969["="];
  var _6261 = _g969[">="];
  var _6061 = _g969["<="];
  var read_file = _g969["read-file"];
  var write_file = _g969["write-file"];
  var write = _g969.write;
  var exit = _g969.exit;
  var today = _g969.today;
  var now = _g969.now;
  var number = _g969.number;
  var string = _g969.string;
  var space = _g969.space;
  var apply = _g969.apply;
  var make_id = _g969["make-id"];
  var _37message_handler = _g969["%message-handler"];
  var toplevel63 = _g969["toplevel?"];
  var module_key = _g969["module-key"];
  var module = _g969.module;
  var setenv = _g969.setenv;
  var _g972 = nexus["lumen/lib"];
  var getenv = _g972.getenv;
  var macro_function = _g972["macro-function"];
  var macro63 = _g972["macro?"];
  var special63 = _g972["special?"];
  var special_form63 = _g972["special-form?"];
  var statement63 = _g972["statement?"];
  var symbol_expansion = _g972["symbol-expansion"];
  var symbol63 = _g972["symbol?"];
  var variable63 = _g972["variable?"];
  var bound63 = _g972["bound?"];
  var quoted = _g972.quoted;
  var stash42 = _g972["stash*"];
  var index = _g972.index;
  var bind = _g972.bind;
  var bind42 = _g972["bind*"];
  var quasiexpand = _g972.quasiexpand;
  var macroexpand = _g972.macroexpand;
  var indentation = _g972.indentation;
  var reserved63 = _g972["reserved?"];
  var valid_id63 = _g972["valid-id?"];
  var id = _g972.id;
  var key = _g972.key;
  var imported = _g972.imported;
  var link = _g972.link;
  var mapo = _g972.mapo;
  var quote_environment = _g972["quote-environment"];
  var quote_modules = _g972["quote-modules"];
  var initial_environment = _g972["initial-environment"];
  var _g973 = nexus["lumen/compiler"];
  var compile_function = _g973["compile-function"];
  var compile = _g973.compile;
  var open_module = _g973["open-module"];
  var load_module = _g973["load-module"];
  var in_module = _g973["in-module"];
  var import_modules = _g973["import-modules"];
  var compile_module = _g973["compile-module"];
  var declare = _g973.declare;
  var eval = _g973.eval;
  global.modules = {"lumen/reader": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"]], export: {"make-stream": {export: true, variable: true}, "read-table": {export: true, variable: true}, "define-reader": {export: true, macro: function (_g989) {
    var char = _g989[0];
    var stream = _g989[1];
    var _g988 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g988, 0);
    return(["set", ["get", "read-table", char], join(["fn", [stream]], body)]);
  }}, read: {export: true, variable: true}, "read-all": {export: true, variable: true}, "read-from-string": {export: true, variable: true}, delimiters: {variable: true}, whitespace: {variable: true}, "peek-char": {variable: true}, "read-char": {variable: true}, "skip-non-code": {variable: true}, eof: {variable: true}, "key?": {variable: true}, "flag?": {variable: true}}}, "lumen/main": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"], ["lumen", "reader"], ["lumen", "compiler"]], export: {}}, "lumen/system": {import: [["lumen", "special"], ["lumen", "core"]], export: {nexus: {global: true, export: true}}}, "lumen/compiler": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"], ["lumen", "lib"], ["lumen", "reader"]], export: {"compile-function": {export: true, variable: true}, compile: {export: true, variable: true}, "open-module": {export: true, variable: true}, "load-module": {export: true, variable: true}, "in-module": {export: true, variable: true}, "import-modules": {export: true, variable: true}, "compile-module": {export: true, variable: true}, declare: {export: true, variable: true}, eval: {export: true, variable: true}, infix: {variable: true}, "unary?": {variable: true}, precedence: {variable: true}, getop: {variable: true}, "infix?": {variable: true}, "compile-args": {variable: true}, "compile-atom": {variable: true}, terminator: {variable: true}, "compile-special": {variable: true}, "parenthesize-call?": {variable: true}, "compile-call": {variable: true}, "op-delims": {variable: true}, "compile-infix": {variable: true}, "can-return?": {variable: true}, lower: {variable: true}, "lower-statement": {variable: true}, "lower-body": {variable: true}, "lower-do": {variable: true}, "lower-if": {variable: true}, "lower-short": {variable: true}, "lower-try": {variable: true}, "lower-while": {variable: true}, "lower-for": {variable: true}, "lower-function": {variable: true}, "lower-definition": {variable: true}, "lower-call": {variable: true}, "lower-infix?": {variable: true}, "lower-infix": {variable: true}, "lower-special": {variable: true}, process: {variable: true}, "current-module": {global: true, export: true}, "module-path": {variable: true}, encapsulate: {variable: true}, "compile-file": {variable: true}, run: {variable: true}, "compiling?": {variable: true}, "compiler-output": {variable: true}, conclude: {variable: true}, "%compile-module": {variable: true}, reimported: {variable: true}, "%result": {global: true, export: true}}}, user: {import: ["lumen", ["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"]], export: {}}, "lumen/special": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"], ["lumen", "lib"], ["lumen", "compiler"]], export: {"do": {foo: true, stmt: true, tr: true, export: true, special: function () {
    var forms = unstash(Array.prototype.slice.call(arguments, 0));
    var str = "";
    var _g990 = forms;
    var _g991 = 0;
    while (_g991 < length(_g990)) {
      var x = _g990[_g991];
      str = str + compile(x, {_stash: true, stmt: true});
      _g991 = _g991 + 1;
    }
    return(str);
  }}, "%if": {foo: true, stmt: true, tr: true, export: true, special: function (cond, cons, alt) {
    var _g993 = compile(cond);
    indent_level = indent_level + 1;
    var _g995 = compile(cons, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var _g994 = _g995;
    var _g1089;
    if (alt) {
      indent_level = indent_level + 1;
      var _g997 = compile(alt, {_stash: true, stmt: true});
      indent_level = indent_level - 1;
      _g1089 = _g997;
    }
    var _g996 = _g1089;
    var ind = indentation();
    var str = "";
    if (target === "js") {
      str = str + ind + "if (" + _g993 + ") {\n" + _g994 + ind + "}";
    } else {
      str = str + ind + "if " + _g993 + " then\n" + _g994;
    }
    if (_g996 && target === "js") {
      str = str + " else {\n" + _g996 + ind + "}";
    } else {
      if (_g996) {
        str = str + ind + "else\n" + _g996;
      }
    }
    if (target === "lua") {
      return(str + ind + "end\n");
    } else {
      return(str + "\n");
    }
  }}, "while": {foo: true, stmt: true, tr: true, export: true, special: function (cond, form) {
    var _g999 = compile(cond);
    indent_level = indent_level + 1;
    var _g1000 = compile(form, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var body = _g1000;
    var ind = indentation();
    if (target === "js") {
      return(ind + "while (" + _g999 + ") {\n" + body + ind + "}\n");
    } else {
      return(ind + "while " + _g999 + " do\n" + body + ind + "end\n");
    }
  }}, "%for": {foo: true, stmt: true, tr: true, export: true, special: function (t, k, form) {
    var _g1002 = compile(t);
    var ind = indentation();
    indent_level = indent_level + 1;
    var _g1003 = compile(form, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var body = _g1003;
    if (target === "lua") {
      return(ind + "for " + k + " in next, " + _g1002 + " do\n" + body + ind + "end\n");
    } else {
      return(ind + "for (" + k + " in " + _g1002 + ") {\n" + body + ind + "}\n");
    }
  }}, "%try": {foo: true, stmt: true, tr: true, export: true, special: function (form) {
    var ind = indentation();
    indent_level = indent_level + 1;
    var _g1005 = compile(form, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var body = _g1005;
    var e = make_id();
    var hf = ["return", ["%array", false, ["get", e, "\"message\""]]];
    indent_level = indent_level + 1;
    var _g1006 = compile(hf, {_stash: true, stmt: true});
    indent_level = indent_level - 1;
    var h = _g1006;
    return(ind + "try {\n" + body + ind + "}\n" + ind + "catch (" + e + ") {\n" + h + ind + "}\n");
  }}, "break": {foo: true, export: true, stmt: true, special: function () {
    return(indentation() + "break");
  }}, "%function": {foo: true, export: true, special: function (args, body) {
    return(compile_function(args, body));
  }}, "%global-function": {foo: true, stmt: true, tr: true, export: true, special: function (name, args, body) {
    if (target === "lua") {
      var x = compile_function(args, body, {_stash: true, name: name});
      return(indentation() + x);
    } else {
      return(compile(["set", name, ["%function", args, body]], {_stash: true, stmt: true}));
    }
  }}, "%local-function": {foo: true, stmt: true, tr: true, export: true, special: function (name, args, body) {
    var x = compile_function(args, body, {_stash: true, name: name, prefix: "local "});
    return(indentation() + x);
  }}, "return": {foo: true, export: true, stmt: true, special: function (x) {
    var _g1090;
    if (nil63(x)) {
      _g1090 = "return";
    } else {
      _g1090 = "return(" + compile(x) + ")";
    }
    var _g1012 = _g1090;
    return(indentation() + _g1012);
  }}, error: {foo: true, export: true, stmt: true, special: function (x) {
    var _g1091;
    if (target === "js") {
      _g1091 = "throw new " + compile(["Error", x]);
    } else {
      _g1091 = "error(" + compile(x) + ")";
    }
    var e = _g1091;
    return(indentation() + e);
  }}, "%local": {foo: true, export: true, stmt: true, special: function (name, value) {
    var id = compile(name);
    var value1 = compile(value);
    var _g1092;
    if (is63(value)) {
      _g1092 = " = " + value1;
    } else {
      _g1092 = "";
    }
    var rh = _g1092;
    var _g1093;
    if (target === "js") {
      _g1093 = "var ";
    } else {
      _g1093 = "local ";
    }
    var keyword = _g1093;
    var ind = indentation();
    return(ind + keyword + id + rh);
  }}, set: {foo: true, export: true, stmt: true, special: function (lh, rh) {
    var _g1016 = compile(lh);
    var _g1094;
    if (nil63(rh)) {
      _g1094 = "nil";
    } else {
      _g1094 = rh;
    }
    var _g1017 = compile(_g1094);
    return(indentation() + _g1016 + " = " + _g1017);
  }}, get: {foo: true, export: true, special: function (t, k) {
    var _g1019 = compile(t);
    var k1 = compile(k);
    if (target === "lua" && char(_g1019, 0) === "{") {
      _g1019 = "(" + _g1019 + ")";
    }
    if (string_literal63(k) && valid_id63(inner(k))) {
      return(_g1019 + "." + inner(k));
    } else {
      return(_g1019 + "[" + k1 + "]");
    }
  }}, "not": {}, "%array": {foo: true, export: true, special: function () {
    var forms = unstash(Array.prototype.slice.call(arguments, 0));
    var _g1095;
    if (target === "lua") {
      _g1095 = "{";
    } else {
      _g1095 = "[";
    }
    var open = _g1095;
    var _g1096;
    if (target === "lua") {
      _g1096 = "}";
    } else {
      _g1096 = "]";
    }
    var close = _g1096;
    var str = "";
    var _g1020 = forms;
    var i = 0;
    while (i < length(_g1020)) {
      var x = _g1020[i];
      str = str + compile(x);
      if (i < length(forms) - 1) {
        str = str + ", ";
      }
      i = i + 1;
    }
    return(open + str + close);
  }}, "%object": {foo: true, export: true, special: function () {
    var forms = unstash(Array.prototype.slice.call(arguments, 0));
    var str = "{";
    var _g1097;
    if (target === "lua") {
      _g1097 = " = ";
    } else {
      _g1097 = ": ";
    }
    var sep = _g1097;
    var pairs = pair(forms);
    var n_1 = length(pairs) - 1;
    var _g1021 = pairs;
    var i = 0;
    while (i < length(_g1021)) {
      var _g1022 = _g1021[i];
      var k = _g1022[0];
      var v = _g1022[1];
      if (!string63(k)) {
        throw new Error("Illegal key: " + string(k));
      }
      str = str + key(k) + sep + compile(v);
      if (i < n_1) {
        str = str + ", ";
      }
      i = i + 1;
    }
    return(str + "}");
  }}}}, "lumen/core": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"], ["lumen", "lib"], ["lumen", "compiler"]], export: {quote: {export: true, macro: function (form) {
    return(quoted(form));
  }}, quasiquote: {export: true, macro: function (form) {
    return(quasiexpand(form, 1));
  }}, at: {export: true, macro: function (l, i) {
    if (target === "lua" && number63(i)) {
      i = i + 1;
    } else {
      if (target === "lua") {
        i = ["+", i, 1];
      }
    }
    return(["get", l, i]);
  }}, list: {export: true, macro: function () {
    var body = unstash(Array.prototype.slice.call(arguments, 0));
    var l = join(["%array"], body);
    if (!keys63(body)) {
      return(l);
    } else {
      var id = make_id();
      var init = [];
      var _g1026 = body;
      var k = undefined;
      for (k in _g1026) {
        if (isNaN(parseInt(k))) {
          var v = _g1026[k];
          add(init, ["set", ["get", id, ["quote", k]], v]);
        }
      }
      return(join(["let", [id, l]], join(init, [id])));
    }
  }}, "if": {export: true, macro: function () {
    var branches = unstash(Array.prototype.slice.call(arguments, 0));
    var step = function (_g1028) {
      var a = _g1028[0];
      var b = _g1028[1];
      var c = sub(_g1028, 2);
      if (is63(b)) {
        return([join(["%if", a, b], step(c))]);
      } else {
        if (is63(a)) {
          return([a]);
        }
      }
    };
    return(hd(step(branches)));
  }}, when: {export: true, macro: function (cond) {
    var _g1029 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1029, 0);
    return(["if", cond, join(["do"], body)]);
  }}, unless: {export: true, macro: function (cond) {
    var _g1030 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1030, 0);
    return(["if", ["not", cond], join(["do"], body)]);
  }}, table: {export: true, macro: function () {
    var body = unstash(Array.prototype.slice.call(arguments, 0));
    return(join(["%object"], mapo(function (x) {
      return(x);
    }, body)));
  }}, let: {export: true, macro: function (bindings) {
    var _g1032 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1032, 0);
    if (length(bindings) < 2) {
      return(join(["do"], body));
    } else {
      var renames = [];
      var locals = [];
      var lh = bindings[0];
      var rh = bindings[1];
      var _g1033 = bind(lh, rh);
      var _g1034 = 0;
      while (_g1034 < length(_g1033)) {
        var _g1035 = _g1033[_g1034];
        var id = _g1035[0];
        var val = _g1035[1];
        if (bound63(id) || reserved63(id) || toplevel63()) {
          var id1 = make_id();
          add(renames, id);
          add(renames, id1);
          id = id1;
        } else {
          setenv(id, {_stash: true, variable: true});
        }
        add(locals, ["%local", id, val]);
        _g1034 = _g1034 + 1;
      }
      return(join(["do"], join(locals, [["let-symbol", renames, join(["let", sub(bindings, 2)], body)]])));
    }
  }}, "define-module": {export: true, macro: function (spec) {
    var _g1036 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1036, 0);
    var imp = body.import;
    var exp = body.export;
    var alias = body.alias;
    var _g1037 = import_modules(imp);
    var imports = _g1037[0];
    var bindings = _g1037[1];
    var k = module_key(spec);
    modules[k] = {import: imports, export: {}, alias: alias};
    var _g1038 = exp || [];
    var _g1039 = 0;
    while (_g1039 < length(_g1038)) {
      var x = _g1038[_g1039];
      setenv(x, {_stash: true, export: true});
      _g1039 = _g1039 + 1;
    }
    return(join(["do", ["set", ["get", "nexus", ["quote", k]], ["table"]]], bindings));
  }}, "define-macro": {export: true, macro: function (name, args) {
    var _g1040 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1040, 0);
    var form = join(["fn", args], body);
    var _g1041 = ["setenv", ["quote", name]];
    _g1041.macro = form;
    _g1041.form = ["quote", form];
    eval(_g1041);
    return(undefined);
  }}, "define-special": {export: true, macro: function (name, args) {
    var _g1042 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1042, 0);
    var form = join(["fn", args], body);
    var keys = sub(body, length(body));
    var _g1043 = ["setenv", ["quote", name]];
    _g1043.special = form;
    _g1043.form = ["quote", form];
    eval(join(_g1043, keys));
    return(undefined);
  }}, "define-symbol": {export: true, macro: function (name, expansion) {
    setenv(name, {_stash: true, symbol: expansion});
    return(undefined);
  }}, "define*": {export: true, macro: function (name, x) {
    var _g1045 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1045, 0);
    setenv(name, {_stash: true, global: true, export: true});
    if (some63(body)) {
      var _g1046 = bind42(x, body);
      var args = _g1046[0];
      var _g1047 = _g1046[1];
      return(join(["%global-function", name, args], _g1047));
    } else {
      if (target === "js") {
        return(["set", ["get", "global", ["quote", id(name)]], x]);
      } else {
        return(["set", name, x]);
      }
    }
  }}, define: {export: true, macro: function (name, x) {
    var _g1048 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1048, 0);
    setenv(name, {_stash: true, variable: true});
    if (some63(body) && target === "js") {
      return(link(name, ["%local", name, join(["fn", x], body)]));
    } else {
      if (some63(body)) {
        var _g1049 = bind42(x, body);
        var args = _g1049[0];
        var _g1050 = _g1049[1];
        return(link(name, join(["%local-function", name, args], _g1050)));
      } else {
        return(link(name, ["%local", name, x]));
      }
    }
  }}, "set*": {export: true, macro: function (name, value) {
    return(link(name, ["set", name, value]));
  }}, "with-bindings": {export: true, macro: function (_g1053) {
    var names = _g1053[0];
    var _g1052 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1052, 0);
    var x = make_id();
    var _g1055 = ["setenv", x];
    _g1055.variable = true;
    var _g1054 = ["with-frame", ["each", [x], names, _g1055]];
    _g1054.scope = true;
    return(join(_g1054, body));
  }}, "let-macro": {export: true, macro: function (definitions) {
    var _g1056 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1056, 0);
    add(environment, {});
    map(function (m) {
      return(macroexpand(join(["define-macro"], m)));
    }, definitions);
    var _g1057 = join(["do"], macroexpand(body));
    drop(environment);
    return(_g1057);
  }}, "let-symbol": {export: true, macro: function (expansions) {
    var _g1059 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1059, 0);
    add(environment, {});
    map(function (_g1062) {
      var name = _g1062[0];
      var exp = _g1062[1];
      return(macroexpand(["define-symbol", name, exp]));
    }, pair(expansions));
    var _g1060 = join(["do"], macroexpand(body));
    drop(environment);
    return(_g1060);
  }}, fn: {export: true, macro: function (args) {
    var _g1063 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1063, 0);
    var _g1064 = bind42(args, body);
    var _g1065 = _g1064[0];
    var _g1066 = _g1064[1];
    return(join(["%function", _g1065], _g1066));
  }}, guard: {export: true, macro: function (expr) {
    if (target === "js") {
      return([["fn", [], ["%try", ["list", true, expr]]]]);
    } else {
      var e = make_id();
      var x = make_id();
      var ex = "|" + e + "," + x + "|";
      return(["let", [ex, ["xpcall", ["fn", [], expr], "%message-handler"]], ["list", e, x]]);
    }
  }}, all: {export: true, macro: function (_g1069, t) {
    var k = _g1069[0];
    var v = _g1069[1];
    var _g1068 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1068, 0);
    var x = make_id();
    var n = make_id();
    var _g1098;
    if (target === "lua") {
      _g1098 = body;
    } else {
      _g1098 = [join(["let", [n, ["parseInt", k], k, ["if", ["isNaN", n], k, n]]], body)];
    }
    return(["let", [x, t, k, "nil"], ["%for", x, k, join(["let", [v, ["get", x, k]]], _g1098)]]);
  }}, each: {export: true, macro: function (b, t) {
    var _g1070 = unstash(Array.prototype.slice.call(arguments, 2));
    var body = sub(_g1070, 0);
    var k = b[0];
    var v = b[1];
    var t1 = make_id();
    var _g1099;
    if (nil63(v)) {
      var _g1100;
      if (b.i) {
        _g1100 = "i";
      } else {
        _g1100 = make_id();
      }
      var i = _g1100;
      _g1099 = ["let", [i, 0], ["while", ["<", i, ["length", t1]], join(["let", [k, ["at", t1, i]]], body), ["inc", i]]];
    } else {
      var _g1071 = ["target"];
      _g1071.js = ["isNaN", ["parseInt", k]];
      _g1071.lua = ["not", ["number?", k]];
      _g1099 = ["let", [k, "nil"], ["%for", t1, k, ["when", _g1071, join(["let", [v, ["get", t1, k]]], body)]]];
    }
    return(["let", [t1, t], _g1099]);
  }}, "set-of": {export: true, macro: function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    var l = [];
    var _g1072 = xs;
    var _g1073 = 0;
    while (_g1073 < length(_g1072)) {
      var x = _g1072[_g1073];
      l[x] = true;
      _g1073 = _g1073 + 1;
    }
    return(join(["table"], l));
  }}, language: {export: true, macro: function () {
    return(["quote", target]);
  }}, target: {macro: function () {
    var clauses = unstash(Array.prototype.slice.call(arguments, 0));
    return(clauses[target]);
  }, export: true, global: true}, "join*": {export: true, macro: function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(reduce(function (a, b) {
      return(["join", a, b]);
    }, xs));
  }}, "join!": {export: true, macro: function (a) {
    var _g1076 = unstash(Array.prototype.slice.call(arguments, 1));
    var bs = sub(_g1076, 0);
    return(["set", a, join(["join*", a], bs)]);
  }}, "cat!": {export: true, macro: function (a) {
    var _g1077 = unstash(Array.prototype.slice.call(arguments, 1));
    var bs = sub(_g1077, 0);
    return(["set", a, join(["cat", a], bs)]);
  }}, inc: {export: true, macro: function (n, by) {
    return(["set", n, ["+", n, by || 1]]);
  }}, dec: {export: true, macro: function (n, by) {
    return(["set", n, ["-", n, by || 1]]);
  }}, pr: {export: true, macro: function () {
    var xs = unstash(Array.prototype.slice.call(arguments, 0));
    return(["print", space(xs)]);
  }}, "with-frame": {export: true, macro: function () {
    var _g1080 = unstash(Array.prototype.slice.call(arguments, 0));
    var body = sub(_g1080, 0);
    var scope = _g1080.scope;
    var x = make_id();
    var _g1081 = ["table"];
    _g1081._scope = scope;
    return(["do", ["add", "environment", _g1081], ["let", [x, join(["do"], body)], ["drop", "environment"], x]]);
  }}}}, lumen: {import: [["lumen", "special"]], alias: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"]], export: {}}, "lumen/runtime": {import: [["lumen", "special"], ["lumen", "core"]], export: {"nil?": {export: true, variable: true}, "is?": {export: true, variable: true}, length: {export: true, variable: true}, "none?": {export: true, variable: true}, "some?": {export: true, variable: true}, "one?": {export: true, variable: true}, hd: {export: true, variable: true}, "string?": {export: true, variable: true}, "number?": {export: true, variable: true}, "boolean?": {export: true, variable: true}, "function?": {export: true, variable: true}, "composite?": {export: true, variable: true}, "atom?": {export: true, variable: true}, "table?": {export: true, variable: true}, "list?": {export: true, variable: true}, substring: {export: true, variable: true}, sub: {export: true, variable: true}, keys: {export: true, variable: true}, inner: {export: true, variable: true}, tl: {export: true, variable: true}, char: {export: true, variable: true}, code: {export: true, variable: true}, "string-literal?": {export: true, variable: true}, "id-literal?": {export: true, variable: true}, add: {export: true, variable: true}, drop: {export: true, variable: true}, last: {export: true, variable: true}, reverse: {export: true, variable: true}, join: {export: true, variable: true}, reduce: {export: true, variable: true}, keep: {export: true, variable: true}, "in?": {export: true, variable: true}, find: {export: true, variable: true}, pair: {export: true, variable: true}, sort: {export: true, variable: true}, iterate: {export: true, variable: true}, replicate: {export: true, variable: true}, series: {export: true, variable: true}, map: {export: true, variable: true}, "keys?": {export: true, variable: true}, "empty?": {export: true, variable: true}, stash: {export: true, variable: true}, unstash: {export: true, variable: true}, search: {export: true, variable: true}, split: {export: true, variable: true}, cat: {export: true, variable: true}, "+": {export: true, variable: true}, "-": {export: true, variable: true}, "*": {export: true, variable: true}, "/": {export: true, variable: true}, "%": {export: true, variable: true}, ">": {export: true, variable: true}, "<": {export: true, variable: true}, "=": {export: true, variable: true}, ">=": {export: true, variable: true}, "<=": {export: true, variable: true}, "read-file": {export: true, variable: true}, "write-file": {export: true, variable: true}, write: {export: true, variable: true}, exit: {export: true, variable: true}, today: {export: true, variable: true}, now: {export: true, variable: true}, number: {export: true, variable: true}, string: {export: true, variable: true}, space: {export: true, variable: true}, apply: {export: true, variable: true}, "make-id": {export: true, variable: true}, "%message-handler": {export: true, variable: true}, "toplevel?": {export: true, variable: true}, "module-key": {export: true, variable: true}, module: {export: true, variable: true}, setenv: {export: true, variable: true}, type: {variable: true}, shift: {variable: true}, require: {global: true, export: true}, fs: {variable: true}, print: {global: true, export: true}, "id-count": {variable: true}}}, "lumen/lib": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"]], export: {getenv: {export: true, variable: true}, "macro-function": {export: true, variable: true}, "macro?": {export: true, variable: true}, "special?": {export: true, variable: true}, "special-form?": {export: true, variable: true}, "statement?": {export: true, variable: true}, "symbol-expansion": {export: true, variable: true}, "symbol?": {export: true, variable: true}, "variable?": {export: true, variable: true}, "bound?": {export: true, variable: true}, quoted: {export: true, variable: true}, "stash*": {export: true, variable: true}, index: {export: true, variable: true}, bind: {export: true, variable: true}, "bind*": {export: true, variable: true}, quasiexpand: {export: true, variable: true}, macroexpand: {export: true, variable: true}, indentation: {export: true, variable: true}, "with-indent": {export: true, macro: function (form) {
    var result = make_id();
    return(["do", ["inc", "indent-level"], ["let", [result, form], ["dec", "indent-level"], result]]);
  }}, "reserved?": {export: true, variable: true}, "valid-id?": {export: true, variable: true}, id: {export: true, variable: true}, key: {export: true, variable: true}, imported: {export: true, variable: true}, link: {export: true, variable: true}, mapo: {export: true, variable: true}, "quote-environment": {export: true, variable: true}, "quote-modules": {export: true, variable: true}, "initial-environment": {export: true, variable: true}, "global?": {variable: true}, escape: {variable: true}, literal: {variable: true}, bias: {variable: true}, "quoting?": {variable: true}, "quasiquoting?": {variable: true}, "can-unquote?": {variable: true}, "quasisplice?": {variable: true}, "quasiquote-list": {variable: true}, "indent-level": {global: true, export: true}, reserved: {variable: true}, "numeric?": {variable: true}, "valid-code?": {variable: true}, extend: {variable: true}, exclude: {variable: true}, "quote-binding": {variable: true}, "quote-frame": {variable: true}, "quote-module": {variable: true}}}, "lumen/boot": {import: [["lumen", "runtime"], ["lumen", "special"], ["lumen", "core"], ["lumen", "lib"], ["lumen", "compiler"]], export: {"%initial-environment": {macro: function () {
    return(quote_environment(initial_environment()));
  }}, "%initial-modules": {macro: function () {
    return(quote_modules());
  }}, modules: {global: true, export: true}}}};
  global.environment = [{"define-module": {export: true, macro: function (spec) {
    var _g1085 = unstash(Array.prototype.slice.call(arguments, 1));
    var body = sub(_g1085, 0);
    var imp = body.import;
    var exp = body.export;
    var alias = body.alias;
    var _g1086 = import_modules(imp);
    var imports = _g1086[0];
    var bindings = _g1086[1];
    var k = module_key(spec);
    modules[k] = {import: imports, export: {}, alias: alias};
    var _g1087 = exp || [];
    var _g1088 = 0;
    while (_g1088 < length(_g1087)) {
      var x = _g1087[_g1088];
      setenv(x, {_stash: true, export: true});
      _g1088 = _g1088 + 1;
    }
    return(join(["do", ["set", ["get", "nexus", ["quote", k]], ["table"]]], bindings));
  }}}];
})();
(function () {
  nexus.user = {};
  var _g1101 = nexus["lumen/runtime"];
  var nil63 = _g1101["nil?"];
  var is63 = _g1101["is?"];
  var length = _g1101.length;
  var none63 = _g1101["none?"];
  var some63 = _g1101["some?"];
  var one63 = _g1101["one?"];
  var hd = _g1101.hd;
  var string63 = _g1101["string?"];
  var number63 = _g1101["number?"];
  var boolean63 = _g1101["boolean?"];
  var function63 = _g1101["function?"];
  var composite63 = _g1101["composite?"];
  var atom63 = _g1101["atom?"];
  var table63 = _g1101["table?"];
  var list63 = _g1101["list?"];
  var substring = _g1101.substring;
  var sub = _g1101.sub;
  var keys = _g1101.keys;
  var inner = _g1101.inner;
  var tl = _g1101.tl;
  var char = _g1101.char;
  var code = _g1101.code;
  var string_literal63 = _g1101["string-literal?"];
  var id_literal63 = _g1101["id-literal?"];
  var add = _g1101.add;
  var drop = _g1101.drop;
  var last = _g1101.last;
  var reverse = _g1101.reverse;
  var join = _g1101.join;
  var reduce = _g1101.reduce;
  var keep = _g1101.keep;
  var in63 = _g1101["in?"];
  var find = _g1101.find;
  var pair = _g1101.pair;
  var sort = _g1101.sort;
  var iterate = _g1101.iterate;
  var replicate = _g1101.replicate;
  var series = _g1101.series;
  var map = _g1101.map;
  var keys63 = _g1101["keys?"];
  var empty63 = _g1101["empty?"];
  var stash = _g1101.stash;
  var unstash = _g1101.unstash;
  var search = _g1101.search;
  var split = _g1101.split;
  var cat = _g1101.cat;
  var _43 = _g1101["+"];
  var _ = _g1101["-"];
  var _42 = _g1101["*"];
  var _47 = _g1101["/"];
  var _37 = _g1101["%"];
  var _62 = _g1101[">"];
  var _60 = _g1101["<"];
  var _61 = _g1101["="];
  var _6261 = _g1101[">="];
  var _6061 = _g1101["<="];
  var read_file = _g1101["read-file"];
  var write_file = _g1101["write-file"];
  var write = _g1101.write;
  var exit = _g1101.exit;
  var today = _g1101.today;
  var now = _g1101.now;
  var number = _g1101.number;
  var string = _g1101.string;
  var space = _g1101.space;
  var apply = _g1101.apply;
  var make_id = _g1101["make-id"];
  var _37message_handler = _g1101["%message-handler"];
  var toplevel63 = _g1101["toplevel?"];
  var module_key = _g1101["module-key"];
  var module = _g1101.module;
  var setenv = _g1101.setenv;
})();
(function () {
  nexus["lumen/main"] = {};
  var _g2 = nexus["lumen/runtime"];
  var nil63 = _g2["nil?"];
  var is63 = _g2["is?"];
  var length = _g2.length;
  var none63 = _g2["none?"];
  var some63 = _g2["some?"];
  var one63 = _g2["one?"];
  var hd = _g2.hd;
  var string63 = _g2["string?"];
  var number63 = _g2["number?"];
  var boolean63 = _g2["boolean?"];
  var function63 = _g2["function?"];
  var composite63 = _g2["composite?"];
  var atom63 = _g2["atom?"];
  var table63 = _g2["table?"];
  var list63 = _g2["list?"];
  var substring = _g2.substring;
  var sub = _g2.sub;
  var keys = _g2.keys;
  var inner = _g2.inner;
  var tl = _g2.tl;
  var char = _g2.char;
  var code = _g2.code;
  var string_literal63 = _g2["string-literal?"];
  var id_literal63 = _g2["id-literal?"];
  var add = _g2.add;
  var drop = _g2.drop;
  var last = _g2.last;
  var reverse = _g2.reverse;
  var join = _g2.join;
  var reduce = _g2.reduce;
  var keep = _g2.keep;
  var in63 = _g2["in?"];
  var find = _g2.find;
  var pair = _g2.pair;
  var sort = _g2.sort;
  var iterate = _g2.iterate;
  var replicate = _g2.replicate;
  var series = _g2.series;
  var map = _g2.map;
  var keys63 = _g2["keys?"];
  var empty63 = _g2["empty?"];
  var stash = _g2.stash;
  var unstash = _g2.unstash;
  var search = _g2.search;
  var split = _g2.split;
  var cat = _g2.cat;
  var _43 = _g2["+"];
  var _ = _g2["-"];
  var _42 = _g2["*"];
  var _47 = _g2["/"];
  var _37 = _g2["%"];
  var _62 = _g2[">"];
  var _60 = _g2["<"];
  var _61 = _g2["="];
  var _6261 = _g2[">="];
  var _6061 = _g2["<="];
  var read_file = _g2["read-file"];
  var write_file = _g2["write-file"];
  var write = _g2.write;
  var exit = _g2.exit;
  var today = _g2.today;
  var now = _g2.now;
  var number = _g2.number;
  var string = _g2.string;
  var space = _g2.space;
  var apply = _g2.apply;
  var make_id = _g2["make-id"];
  var _37message_handler = _g2["%message-handler"];
  var toplevel63 = _g2["toplevel?"];
  var module_key = _g2["module-key"];
  var module = _g2.module;
  var setenv = _g2.setenv;
  var _g5 = nexus["lumen/reader"];
  var make_stream = _g5["make-stream"];
  var read_table = _g5["read-table"];
  var read = _g5.read;
  var read_all = _g5["read-all"];
  var read_from_string = _g5["read-from-string"];
  var _g6 = nexus["lumen/compiler"];
  var compile_function = _g6["compile-function"];
  var compile = _g6.compile;
  var open_module = _g6["open-module"];
  var load_module = _g6["load-module"];
  var in_module = _g6["in-module"];
  var import_modules = _g6["import-modules"];
  var compile_module = _g6["compile-module"];
  var declare = _g6.declare;
  var eval = _g6.eval;
  var rep = function (str) {
    var _g1105 = (function () {
      try {
        return([true, eval(read_from_string(str))]);
      }
      catch (_g1112) {
        return([false, _g1112.message]);
      }
    })();
    var _g1 = _g1105[0];
    var x = _g1105[1];
    if (is63(x)) {
      return(print(string(x)));
    }
  };
  nexus["lumen/main"].rep = rep;
  var repl = function () {
    var step = function (str) {
      rep(str);
      return(write("> "));
    };
    write("> ");
    process.stdin.setEncoding("utf8");
    return(process.stdin.on("data", step));
  };
  nexus["lumen/main"].repl = repl;
  var usage = function () {
    print("usage: lumen [options] <module>");
    print("options:");
    print("  -o <output>\tOutput file");
    print("  -t <target>\tTarget language (default: lua)");
    print("  -e <expr>\tExpression to evaluate");
    return(exit());
  };
  nexus["lumen/main"].usage = usage;
  var main = function () {
    var args = sub(process.argv, 2);
    if (hd(args) === "-h" || hd(args) === "--help") {
      usage();
    }
    var spec = undefined;
    var output = undefined;
    var target1 = undefined;
    var expr = undefined;
    var _g1111 = args;
    var i = 0;
    while (i < length(_g1111)) {
      var arg = _g1111[i];
      if (arg === "-o" || arg === "-t" || arg === "-e") {
        if (i === length(args) - 1) {
          print("missing argument for" + " " + string(arg));
        } else {
          i = i + 1;
          var val = args[i];
          if (arg === "-o") {
            output = val;
          } else {
            if (arg === "-t") {
              target1 = val;
            } else {
              if (arg === "-e") {
                expr = val;
              }
            }
          }
        }
      } else {
        if (nil63(spec) && "-" != char(arg, 0)) {
          spec = arg;
        }
      }
      i = i + 1;
    }
    if (output) {
      if (target1) {
        target = target1;
      }
      return(write_file(output, compile_module(spec)));
    } else {
      in_module(spec || "user");
      if (expr) {
        return(rep(expr));
      } else {
        return(repl());
      }
    }
  };
  nexus["lumen/main"].main = main;
  main();
})();
