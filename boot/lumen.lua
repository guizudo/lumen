(function ()
  exports = {}
  function setenv(k, ...)
    local keys = unstash({...})
    local _g6 = sub(keys, 0)
    if string63(k) then
      local frame = last(environment)
      local x = (frame[k] or {})
      local k1 = nil
      local _g7 = _g6
      for k1 in next, _g7 do
        if (not number63(k1)) then
          local v = _g7[k1]
          x[k1] = v
        end
      end
      x.module = current_module
      frame[k] = x
    end
  end
  function getenv(k)
    if string63(k) then
      return(find(function (e)
        return(e[k])
      end, reverse(environment)))
    end
  end
  function macro_function(k)
    local b = getenv(k)
    return((b and b.macro))
  end
  function macro63(k)
    return(is63(macro_function(k)))
  end
  function special63(k)
    local b = getenv(k)
    return((b and is63(b.special)))
  end
  function special_form63(form)
    return((list63(form) and special63(hd(form))))
  end
  function symbol_expansion(k)
    local b = getenv(k)
    return((b and b.symbol))
  end
  function symbol63(k)
    return(is63(symbol_expansion(k)))
  end
  function variable63(k)
    local b = last(environment)[k]
    return((b and is63(b.variable)))
  end
  function bound63(x)
    return((macro63(x) or special63(x) or symbol63(x) or variable63(x)))
  end
  local function escape(str)
    local str1 = "\""
    local i = 0
    while (i < length(str)) do
      local c = char(str, i)
      local c1 = (function ()
        if (c == "\n") then
          return("\\n")
        elseif (c == "\"") then
          return("\\\"")
        elseif (c == "\\") then
          return("\\\\")
        else
          return(c)
        end
      end)()
      str1 = (str1 .. c1)
      i = (i + 1)
    end
    return((str1 .. "\""))
  end
  function quoted(form)
    if string63(form) then
      return(escape(form))
    elseif atom63(form) then
      return(form)
    else
      return(join({"list"}, map42(quoted, form)))
    end
  end
  function stash42(args)
    if keys63(args) then
      local l = {"%object", "_stash", true}
      local k = nil
      local _g8 = args
      for k in next, _g8 do
        if (not number63(k)) then
          local v = _g8[k]
          add(l, k)
          add(l, v)
        end
      end
      return(join(args, {l}))
    else
      return(args)
    end
  end
  local function rest(args)
    if (target == "js") then
      return({"unstash", {"sublist", "arguments", length(args)}})
    else
      add(args, "|...|")
      return({"unstash", {"list", "|...|"}})
    end
  end
  local id_count = 0
  function make_id()
    id_count = (id_count + 1)
    return(("_g" .. id_count))
  end
  function bind(lh, rh)
    if (composite63(lh) and list63(rh)) then
      local id = make_id()
      return(join({{id, rh}}, bind(lh, id)))
    elseif atom63(lh) then
      return({{lh, rh}})
    else
      local bs = {}
      local r = lh.rest
      local i = 0
      local _g9 = lh
      while (i < length(_g9)) do
        local x = _g9[(i + 1)]
        bs = join(bs, bind(x, {"at", rh, i}))
        i = (i + 1)
      end
      if r then
        bs = join(bs, bind(r, {"sub", rh, length(lh)}))
      end
      local k = nil
      local _g10 = lh
      for k in next, _g10 do
        if (not number63(k)) then
          local v = _g10[k]
          if (v == true) then
            v = k
          end
          if (k ~= "rest") then
            bs = join(bs, bind(v, {"get", rh, {"quote", k}}))
          end
        end
      end
      return(bs)
    end
  end
  function bind42(args, body)
    local args1 = {}
    if atom63(args) then
      return({args1, {join({"let", {args, rest(args1)}}, body)}})
    else
      local bs = {}
      local r = (args.rest or (keys63(args) and make_id()))
      local _g12 = 0
      local _g11 = args
      while (_g12 < length(_g11)) do
        local arg = _g11[(_g12 + 1)]
        if atom63(arg) then
          add(args1, arg)
        elseif (list63(arg) or keys63(arg)) then
          local v = make_id()
          add(args1, v)
          bs = join(bs, {arg, v})
        end
        _g12 = (_g12 + 1)
      end
      if r then
        bs = join(bs, {r, rest(args1)})
      end
      if keys63(args) then
        bs = join(bs, {sub(args, length(args)), r})
      end
      if empty63(bs) then
        return({args1, body})
      else
        return({args1, {join({"let", bs}, body)}})
      end
    end
  end
  local function quoting63(depth)
    return(number63(depth))
  end
  local function quasiquoting63(depth)
    return((quoting63(depth) and (depth > 0)))
  end
  local function can_unquote63(depth)
    return((quoting63(depth) and (depth == 1)))
  end
  local function quasisplice63(x, depth)
    return((list63(x) and can_unquote63(depth) and (hd(x) == "unquote-splicing")))
  end
  function macroexpand(form)
    if symbol63(form) then
      return(macroexpand(symbol_expansion(form)))
    elseif atom63(form) then
      return(form)
    else
      local x = hd(form)
      if (x == "%for") then
        local _g2 = form[1]
        local _g13 = form[2]
        local t = _g13[1]
        local k = _g13[2]
        local body = sub(form, 2)
        return(join({"%for", {macroexpand(t), macroexpand(k)}}, macroexpand(body)))
      elseif (x == "%function") then
        local _g3 = form[1]
        local args = form[2]
        local _g14 = sub(form, 2)
        add(environment, {})
        local _g16 = (function ()
          local _g18 = 0
          local _g17 = args
          while (_g18 < length(_g17)) do
            local _g15 = _g17[(_g18 + 1)]
            setenv(_g15, {_stash = true, variable = true})
            _g18 = (_g18 + 1)
          end
          return(join({"%function", map42(macroexpand, args)}, macroexpand(_g14)))
        end)()
        drop(environment)
        return(_g16)
      elseif ((x == "%local-function") or (x == "%global-function")) then
        local _g4 = form[1]
        local name = form[2]
        local _g19 = form[3]
        local _g20 = sub(form, 3)
        add(environment, {})
        local _g22 = (function ()
          local _g24 = 0
          local _g23 = _g19
          while (_g24 < length(_g23)) do
            local _g21 = _g23[(_g24 + 1)]
            setenv(_g21, {_stash = true, variable = true})
            _g24 = (_g24 + 1)
          end
          return(join({x, name, map42(macroexpand, _g19)}, macroexpand(_g20)))
        end)()
        drop(environment)
        return(_g22)
      elseif macro63(x) then
        return(macroexpand(apply(macro_function(x), tl(form))))
      else
        return(map42(macroexpand, form))
      end
    end
  end
  local function quasiquote_list(form, depth)
    local xs = {{"list"}}
    local k = nil
    local _g25 = form
    for k in next, _g25 do
      if (not number63(k)) then
        local v = _g25[k]
        local v = (function ()
          if quasisplice63(v, depth) then
            return(quasiexpand(v[2]))
          else
            return(quasiexpand(v, depth))
          end
        end)()
        last(xs)[k] = v
      end
    end
    local _g27 = 0
    local _g26 = form
    while (_g27 < length(_g26)) do
      local x = _g26[(_g27 + 1)]
      if quasisplice63(x, depth) then
        local x = quasiexpand(x[2])
        add(xs, x)
        add(xs, {"list"})
      else
        add(last(xs), quasiexpand(x, depth))
      end
      _g27 = (_g27 + 1)
    end
    if (length(xs) == 1) then
      return(hd(xs))
    else
      return(reduce(function (a, b)
        return({"join", a, b})
      end, keep(function (x)
        return(((length(x) > 1) or (not (hd(x) == "list")) or keys63(x)))
      end, xs)))
    end
  end
  function quasiexpand(form, depth)
    if quasiquoting63(depth) then
      if atom63(form) then
        return({"quote", form})
      elseif (can_unquote63(depth) and (hd(form) == "unquote")) then
        return(quasiexpand(form[2]))
      elseif ((hd(form) == "unquote") or (hd(form) == "unquote-splicing")) then
        return(quasiquote_list(form, (depth - 1)))
      elseif (hd(form) == "quasiquote") then
        return(quasiquote_list(form, (depth + 1)))
      else
        return(quasiquote_list(form, depth))
      end
    elseif atom63(form) then
      return(form)
    elseif (hd(form) == "quote") then
      return(form)
    elseif (hd(form) == "quasiquote") then
      return(quasiexpand(form[2], 1))
    else
      return(map42(function (x)
        return(quasiexpand(x, depth))
      end, form))
    end
  end
  target = "lua"
  indent_level = 0
  function indentation()
    return(apply(cat, replicate(indent_level, "  ")))
  end
  function module_key(spec)
    if atom63(spec) then
      return(to_string(spec))
    else
      error("Unsupported module specification")
    end
  end
  local function quote_binding(b)
    b = extend(b, {_stash = true, module = {"quote", b.module}})
    if is63(b.symbol) then
      return(extend(b, {_stash = true, symbol = {"quote", b.symbol}}))
    elseif (b.macro and b.form) then
      return(exclude(extend(b, {_stash = true, macro = b.form}), {_stash = true, form = true}))
    elseif (b.special and b.form) then
      return(exclude(extend(b, {_stash = true, special = b.form}), {_stash = true, form = true}))
    elseif is63(b.variable) then
      return(b)
    end
  end
  local function quote_frame(t)
    return(join({"%object"}, mapo(function (_g5, b)
      return(join({"table"}, quote_binding(b)))
    end, t)))
  end
  function quote_environment(env)
    return(join({"list"}, map(quote_frame, env)))
  end
  local function quote_module(m)
    local _g28 = {"table"}
    _g28.import = quoted(m.import)
    _g28.export = quote_frame(m.export)
    return(_g28)
  end
  function quote_modules()
    return(join({"table"}, map42(quote_module, modules)))
  end
  function initial_environment()
    return({{["define-module"] = getenv("define-module")}})
  end
  _g29 = {}
  exports.utilities = _g29
  _g29.target = target
  _g29.setenv = setenv
  _g29.getenv = getenv
  _g29["macro-function"] = macro_function
  _g29["macro?"] = macro63
  _g29["special?"] = special63
  _g29["special-form?"] = special_form63
  _g29["symbol-expansion"] = symbol_expansion
  _g29["symbol?"] = symbol63
  _g29["variable?"] = variable63
  _g29["bound?"] = bound63
  _g29.quoted = quoted
  _g29["stash*"] = stash42
  _g29.bind = bind
  _g29["bind*"] = bind42
  _g29.quasiexpand = quasiexpand
  _g29.macroexpand = macroexpand
  _g29.indentation = indentation
  _g29["module-key"] = module_key
  _g29["quote-environment"] = quote_environment
  _g29["quote-modules"] = quote_modules
  _g29["initial-environment"] = initial_environment
end)();
(function ()
  function length(x)
    return(#x)
  end
  function empty63(x)
    return((length(x) == 0))
  end
  function substring(str, from, upto)
    return((string.sub)(str, (from + 1), upto))
  end
  function sublist(l, from, upto)
    local i = (from or 0)
    local j = 0
    local _g30 = (upto or length(l))
    local l2 = {}
    while (i < _g30) do
      l2[(j + 1)] = l[(i + 1)]
      i = (i + 1)
      j = (j + 1)
    end
    return(l2)
  end
  function sub(x, from, upto)
    local _g31 = (from or 0)
    if string63(x) then
      return(substring(x, _g31, upto))
    else
      local l = sublist(x, _g31, upto)
      local k = nil
      local _g32 = x
      for k in next, _g32 do
        if (not number63(k)) then
          local v = _g32[k]
          l[k] = v
        end
      end
      return(l)
    end
  end
  function inner(x)
    return(sub(x, 1, (length(x) - 1)))
  end
  function hd(l)
    return(l[1])
  end
  function tl(l)
    return(sub(l, 1))
  end
  function add(l, x)
    return((table.insert)(l, x))
  end
  function drop(l)
    return((table.remove)(l))
  end
  function last(l)
    return(l[((length(l) - 1) + 1)])
  end
  function reverse(l)
    local l1 = {}
    local i = (length(l) - 1)
    while (i >= 0) do
      add(l1, l[(i + 1)])
      i = (i - 1)
    end
    return(l1)
  end
  function join(l1, l2)
    if nil63(l1) then
      return(l2)
    elseif nil63(l2) then
      return(l1)
    else
      local l = {}
      local skip63 = false
      if (not skip63) then
        local i = 0
        local len = length(l1)
        while (i < len) do
          l[(i + 1)] = l1[(i + 1)]
          i = (i + 1)
        end
        while (i < (len + length(l2))) do
          l[(i + 1)] = l2[((i - len) + 1)]
          i = (i + 1)
        end
      end
      local k = nil
      local _g33 = l1
      for k in next, _g33 do
        if (not number63(k)) then
          local v = _g33[k]
          l[k] = v
        end
      end
      local _g35 = nil
      local _g34 = l2
      for _g35 in next, _g34 do
        if (not number63(_g35)) then
          local v = _g34[_g35]
          l[_g35] = v
        end
      end
      return(l)
    end
  end
  function reduce(f, x)
    if empty63(x) then
      return(x)
    elseif (length(x) == 1) then
      return(hd(x))
    else
      return(f(hd(x), reduce(f, tl(x))))
    end
  end
  function keep(f, l)
    local l1 = {}
    local _g37 = 0
    local _g36 = l
    while (_g37 < length(_g36)) do
      local x = _g36[(_g37 + 1)]
      if f(x) then
        add(l1, x)
      end
      _g37 = (_g37 + 1)
    end
    return(l1)
  end
  function find(f, l)
    local _g39 = 0
    local _g38 = l
    while (_g39 < length(_g38)) do
      local x = _g38[(_g39 + 1)]
      local x = f(x)
      if x then
        return(x)
      end
      _g39 = (_g39 + 1)
    end
  end
  function pairwise(l)
    local i = 0
    local l1 = {}
    while (i < length(l)) do
      add(l1, {l[(i + 1)], l[((i + 1) + 1)]})
      i = (i + 2)
    end
    return(l1)
  end
  function iterate(f, count)
    local i = 0
    while (i < count) do
      f(i)
      i = (i + 1)
    end
  end
  function replicate(n, x)
    local l = {}
    iterate(function ()
      return(add(l, x))
    end, n)
    return(l)
  end
  function splice(x)
    return({_splice = x})
  end
  local function splice63(x)
    if table63(x) then
      return(x._splice)
    end
  end
  function map(f, l)
    local l1 = {}
    local _g41 = 0
    local _g40 = l
    while (_g41 < length(_g40)) do
      local x = _g40[(_g41 + 1)]
      local x1 = f(x)
      local s = splice63(x1)
      if list63(s) then
        l1 = join(l1, s)
      elseif is63(s) then
        add(l1, s)
      elseif is63(x1) then
        add(l1, x1)
      end
      _g41 = (_g41 + 1)
    end
    return(l1)
  end
  function map42(f, t)
    local l = map(f, t)
    local k = nil
    local _g42 = t
    for k in next, _g42 do
      if (not number63(k)) then
        local v = _g42[k]
        local x = f(v)
        if is63(x) then
          l[k] = x
        end
      end
    end
    return(l)
  end
  function mapt(f, t)
    local t1 = {}
    local k = nil
    local _g43 = t
    for k in next, _g43 do
      if (not number63(k)) then
        local v = _g43[k]
        local x = f(k, v)
        if is63(x) then
          t1[k] = x
        end
      end
    end
    return(t1)
  end
  function mapo(f, t)
    local o = {}
    local k = nil
    local _g44 = t
    for k in next, _g44 do
      if (not number63(k)) then
        local v = _g44[k]
        local x = f(k, v)
        if is63(x) then
          add(o, k)
          add(o, x)
        end
      end
    end
    return(o)
  end
  function keys63(t)
    local k63 = false
    local k = nil
    local _g45 = t
    for k in next, _g45 do
      if (not number63(k)) then
        local v = _g45[k]
        k63 = true
        break
      end
    end
    return(k63)
  end
  function extend(t, ...)
    local xs = unstash({...})
    local _g46 = sub(xs, 0)
    return(join(t, _g46))
  end
  function exclude(t, ...)
    local keys = unstash({...})
    local _g47 = sub(keys, 0)
    local t1 = sublist(t)
    local k = nil
    local _g48 = t
    for k in next, _g48 do
      if (not number63(k)) then
        local v = _g48[k]
        if (not _g47[k]) then
          t1[k] = v
        end
      end
    end
    return(t1)
  end
  function char(str, n)
    return(sub(str, n, (n + 1)))
  end
  function code(str, n)
    return((string.byte)(str, (function ()
      if n then
        return((n + 1))
      end
    end)()))
  end
  function search(str, pattern, start)
    local _g49 = (function ()
      if start then
        return((start + 1))
      end
    end)()
    local i = (string.find)(str, pattern, start, true)
    return((i and (i - 1)))
  end
  function split(str, sep)
    if ((str == "") or (sep == "")) then
      return({})
    else
      local strs = {}
      while true do
        local i = search(str, sep)
        if nil63(i) then
          break
        else
          add(strs, sub(str, 0, i))
          str = sub(str, (i + 1))
        end
      end
      add(strs, str)
      return(strs)
    end
  end
  function cat(...)
    local xs = unstash({...})
    local _g50 = sub(xs, 0)
    if empty63(_g50) then
      return("")
    else
      return(reduce(function (a, b)
        return((a .. b))
      end, _g50))
    end
  end
  function _43(...)
    local xs = unstash({...})
    local _g51 = sub(xs, 0)
    return(reduce(function (a, b)
      return((a + b))
    end, _g51))
  end
  function _(...)
    local xs = unstash({...})
    local _g52 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b - a))
    end, reverse(_g52)))
  end
  function _42(...)
    local xs = unstash({...})
    local _g53 = sub(xs, 0)
    return(reduce(function (a, b)
      return((a * b))
    end, _g53))
  end
  function _47(...)
    local xs = unstash({...})
    local _g54 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b / a))
    end, reverse(_g54)))
  end
  function _37(...)
    local xs = unstash({...})
    local _g55 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b % a))
    end, reverse(_g55)))
  end
  function _62(a, b)
    return((a > b))
  end
  function _60(a, b)
    return((a < b))
  end
  function _61(a, b)
    return((a == b))
  end
  function _6261(a, b)
    return((a >= b))
  end
  function _6061(a, b)
    return((a <= b))
  end
  function read_file(path)
    local f = (io.open)(path)
    return((f.read)(f, "*a"))
  end
  function write_file(path, data)
    local f = (io.open)(path, "w")
    return((f.write)(f, data))
  end
  function write(x)
    return((io.write)(x))
  end
  function exit(code)
    return((os.exit)(code))
  end
  function nil63(x)
    return((x == nil))
  end
  function is63(x)
    return((not nil63(x)))
  end
  function string63(x)
    return((type(x) == "string"))
  end
  function string_literal63(x)
    return((string63(x) and (char(x, 0) == "\"")))
  end
  function id_literal63(x)
    return((string63(x) and (char(x, 0) == "|")))
  end
  function number63(x)
    return((type(x) == "number"))
  end
  function boolean63(x)
    return((type(x) == "boolean"))
  end
  function function63(x)
    return((type(x) == "function"))
  end
  function composite63(x)
    return((type(x) == "table"))
  end
  function atom63(x)
    return((not composite63(x)))
  end
  function table63(x)
    return((composite63(x) and nil63(hd(x))))
  end
  function list63(x)
    return((composite63(x) and is63(hd(x))))
  end
  function parse_number(str)
    return(tonumber(str))
  end
  function to_string(x)
    if nil63(x) then
      return("nil")
    elseif boolean63(x) then
      if x then
        return("true")
      else
        return("false")
      end
    elseif function63(x) then
      return("#<function>")
    elseif atom63(x) then
      return((x .. ""))
    else
      local str = "("
      local x1 = sub(x)
      local k = nil
      local _g56 = x
      for k in next, _g56 do
        if (not number63(k)) then
          local v = _g56[k]
          add(x1, (k .. ":"))
          add(x1, v)
        end
      end
      local i = 0
      local _g57 = x1
      while (i < length(_g57)) do
        local y = _g57[(i + 1)]
        str = (str .. to_string(y))
        if (i < (length(x1) - 1)) then
          str = (str .. " ")
        end
        i = (i + 1)
      end
      return((str .. ")"))
    end
  end
  function apply(f, args)
    local _g58 = stash(args)
    return(f(unpack(_g58)))
  end
  function stash(args)
    if keys63(args) then
      local p = {_stash = true}
      local k = nil
      local _g59 = args
      for k in next, _g59 do
        if (not number63(k)) then
          local v = _g59[k]
          p[k] = v
        end
      end
      return(join(args, {p}))
    else
      return(args)
    end
  end
  function unstash(args)
    if empty63(args) then
      return({})
    else
      local l = last(args)
      if (table63(l) and l._stash) then
        local args1 = sub(args, 0, (length(args) - 1))
        local k = nil
        local _g60 = l
        for k in next, _g60 do
          if (not number63(k)) then
            local v = _g60[k]
            if (k ~= "_stash") then
              args1[k] = v
            end
          end
        end
        return(args1)
      else
        return(args)
      end
    end
  end
  function _37message_handler(msg)
    local i = search(msg, ": ")
    return(sub(msg, (i + 2)))
  end
  _g61 = {}
  exports.runtime = _g61
  _g61["parse-number"] = parse_number
  _g61["boolean?"] = boolean63
  _g61["is?"] = is63
  _g61["table?"] = table63
  _g61["nil?"] = nil63
  _g61["atom?"] = atom63
  _g61["id-literal?"] = id_literal63
  _g61["composite?"] = composite63
  _g61["string-literal?"] = string_literal63
  _g61["list?"] = list63
  _g61["function?"] = function63
  _g61["number?"] = number63
  _g61["string?"] = string63
  _g61.length = length
  _g61["empty?"] = empty63
  _g61.substring = substring
  _g61.sublist = sublist
  _g61.sub = sub
  _g61.inner = inner
  _g61.hd = hd
  _g61.tl = tl
  _g61.add = add
  _g61.drop = drop
  _g61.last = last
  _g61.reverse = reverse
  _g61.join = join
  _g61.reduce = reduce
  _g61.keep = keep
  _g61.find = find
  _g61.pairwise = pairwise
  _g61.iterate = iterate
  _g61.replicate = replicate
  _g61.splice = splice
  _g61.map = map
  _g61["map*"] = map42
  _g61.mapt = mapt
  _g61.mapo = mapo
  _g61["keys?"] = keys63
  _g61.extend = extend
  _g61.exclude = exclude
  _g61.char = char
  _g61.code = code
  _g61.search = search
  _g61.split = split
  _g61["cat"] = cat
  _g61["+"] = _43
  _g61["-"] = _
  _g61["*"] = _42
  _g61["/"] = _47
  _g61["%"] = _37
  _g61[">"] = _62
  _g61["<"] = _60
  _g61["="] = _61
  _g61[">="] = _6261
  _g61["<="] = _6061
  _g61["read-file"] = read_file
  _g61["write-file"] = write_file
  _g61.write = write
  _g61.exit = exit
  _g61["to-string"] = to_string
  _g61.apply = apply
  _g61.stash = stash
  _g61.unstash = unstash
  _g61["%message-handler"] = _37message_handler
end)();
(function ()
  _g106 = {}
  exports.special = _g106
end)();
(function ()
  function nil63(x)
    return((x == nil))
  end
  function is63(x)
    return((not nil63(x)))
  end
  function string63(x)
    return((type(x) == "string"))
  end
  function string_literal63(x)
    return((string63(x) and (char(x, 0) == "\"")))
  end
  function id_literal63(x)
    return((string63(x) and (char(x, 0) == "|")))
  end
  function number63(x)
    return((type(x) == "number"))
  end
  function boolean63(x)
    return((type(x) == "boolean"))
  end
  function function63(x)
    return((type(x) == "function"))
  end
  function composite63(x)
    return((type(x) == "table"))
  end
  function atom63(x)
    return((not composite63(x)))
  end
  function table63(x)
    return((composite63(x) and nil63(hd(x))))
  end
  function list63(x)
    return((composite63(x) and is63(hd(x))))
  end
  function parse_number(str)
    return(tonumber(str))
  end
  _g169 = {}
  exports.core = _g169
  _g169.target = target
  _g169["parse-number"] = parse_number
  _g169["boolean?"] = boolean63
  _g169["is?"] = is63
  _g169["table?"] = table63
  _g169["nil?"] = nil63
  _g169["atom?"] = atom63
  _g169["id-literal?"] = id_literal63
  _g169["composite?"] = composite63
  _g169["string-literal?"] = string_literal63
  _g169["list?"] = list63
  _g169["function?"] = function63
  _g169["number?"] = number63
  _g169["string?"] = string63
end)();
(function ()
  local delimiters = {["("] = true, [")"] = true, [";"] = true, ["\n"] = true}
  local whitespace = {[" "] = true, ["\t"] = true, ["\n"] = true}
  function make_stream(str)
    return({pos = 0, string = str, len = length(str)})
  end
  local function peek_char(s)
    if (s.pos < s.len) then
      return(char(s.string, s.pos))
    end
  end
  local function read_char(s)
    local c = peek_char(s)
    if c then
      s.pos = (s.pos + 1)
      return(c)
    end
  end
  local function skip_non_code(s)
    while true do
      local c = peek_char(s)
      if nil63(c) then
        break
      elseif whitespace[c] then
        read_char(s)
      elseif (c == ";") then
        while (c and (not (c == "\n"))) do
          c = read_char(s)
        end
        skip_non_code(s)
      else
        break
      end
    end
  end
  read_table = {}
  local eof = {}
  local function key63(atom)
    return((string63(atom) and (length(atom) > 1) and (char(atom, (length(atom) - 1)) == ":")))
  end
  local function flag63(atom)
    return((string63(atom) and (length(atom) > 1) and (char(atom, 0) == ":")))
  end
  read_table[""] = function (s)
    local str = ""
    local dot63 = false
    while true do
      local c = peek_char(s)
      if (c and ((not whitespace[c]) and (not delimiters[c]))) then
        if (c == ".") then
          dot63 = true
        end
        str = (str .. c)
        read_char(s)
      else
        break
      end
    end
    local n = parse_number(str)
    if is63(n) then
      return(n)
    elseif (str == "true") then
      return(true)
    elseif (str == "false") then
      return(false)
    elseif (str == "_") then
      return(make_id())
    elseif dot63 then
      return(reduce(function (a, b)
        return({"get", b, {"quote", a}})
      end, reverse(split(str, "."))))
    else
      return(str)
    end
  end
  read_table["("] = function (s)
    read_char(s)
    local l = {}
    while true do
      skip_non_code(s)
      local c = peek_char(s)
      if (c and (not (c == ")"))) then
        local x = read(s)
        if key63(x) then
          local k = sub(x, 0, (length(x) - 1))
          local v = read(s)
          l[k] = v
        elseif flag63(x) then
          l[sub(x, 1)] = true
        else
          add(l, x)
        end
      elseif c then
        read_char(s)
        break
      else
        error(("Expected ) at " .. s.pos))
      end
    end
    return(l)
  end
  read_table[")"] = function (s)
    error(("Unexpected ) at " .. s.pos))
  end
  read_table["\""] = function (s)
    read_char(s)
    local str = "\""
    while true do
      local c = peek_char(s)
      if (c and (not (c == "\""))) then
        if (c == "\\") then
          str = (str .. read_char(s))
        end
        str = (str .. read_char(s))
      elseif c then
        read_char(s)
        break
      else
        error(("Expected \" at " .. s.pos))
      end
    end
    return((str .. "\""))
  end
  read_table["|"] = function (s)
    read_char(s)
    local str = "|"
    while true do
      local c = peek_char(s)
      if (c and (not (c == "|"))) then
        str = (str .. read_char(s))
      elseif c then
        read_char(s)
        break
      else
        error(("Expected | at " .. s.pos))
      end
    end
    return((str .. "|"))
  end
  read_table["'"] = function (s)
    read_char(s)
    return({"quote", read(s)})
  end
  read_table["`"] = function (s)
    read_char(s)
    return({"quasiquote", read(s)})
  end
  read_table[","] = function (s)
    read_char(s)
    if (peek_char(s) == "@") then
      read_char(s)
      return({"unquote-splicing", read(s)})
    else
      return({"unquote", read(s)})
    end
  end
  function read(s)
    skip_non_code(s)
    local c = peek_char(s)
    if is63(c) then
      return(((read_table[c] or read_table[""]))(s))
    else
      return(eof)
    end
  end
  function read_all(s)
    local l = {}
    while true do
      local form = read(s)
      if (form == eof) then
        break
      end
      add(l, form)
    end
    return(l)
  end
  function read_from_string(str)
    return(read(make_stream(str)))
  end
  _g173 = {}
  exports.reader = _g173
  _g173["make-stream"] = make_stream
  _g173["read-table"] = read_table
  _g173.read = read
  _g173["read-all"] = read_all
  _g173["read-from-string"] = read_from_string
end)();
(function ()
  local infix = {common = {["+"] = true, ["-"] = true, ["%"] = true, ["*"] = true, ["/"] = true, ["<"] = true, [">"] = true, ["<="] = true, [">="] = true}, js = {["="] = "===", ["~="] = "!=", ["and"] = "&&", ["or"] = "||", ["cat"] = "+"}, lua = {["="] = "==", ["cat"] = "..", ["~="] = true, ["and"] = true, ["or"] = true}}
  local function getop(op)
    local op1 = (infix.common[op] or infix[target][op])
    if (op1 == true) then
      return(op)
    else
      return(op1)
    end
  end
  local function infix63(form)
    return((list63(form) and is63(getop(hd(form)))))
  end
  local function numeric63(n)
    return(((n > 47) and (n < 58)))
  end
  local function valid_char63(n)
    return((numeric63(n) or ((n > 64) and (n < 91)) or ((n > 96) and (n < 123)) or (n == 95)))
  end
  function valid_id63(id)
    if empty63(id) then
      return(false)
    elseif special63(id) then
      return(false)
    elseif getop(id) then
      return(false)
    else
      local i = 0
      while (i < length(id)) do
        local n = code(id, i)
        local valid63 = valid_char63(n)
        if ((not valid63) or ((i == 0) and numeric63(n))) then
          return(false)
        end
        i = (i + 1)
      end
      return(true)
    end
  end
  local function compile_id(id)
    local id1 = ""
    local i = 0
    while (i < length(id)) do
      local c = char(id, i)
      local n = code(c)
      local c1 = (function ()
        if (c == "-") then
          return("_")
        elseif valid_char63(n) then
          return(c)
        elseif (i == 0) then
          return(("_" .. n))
        else
          return(n)
        end
      end)()
      id1 = (id1 .. c1)
      i = (i + 1)
    end
    return(id1)
  end
  local function compile_args(args)
    local str = "("
    local i = 0
    local _g174 = args
    while (i < length(_g174)) do
      local arg = _g174[(i + 1)]
      str = (str .. compile(arg))
      if (i < (length(args) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((str .. ")"))
  end
  local function compile_atom(x)
    if ((x == "nil") and (target == "lua")) then
      return(x)
    elseif (x == "nil") then
      return("undefined")
    elseif id_literal63(x) then
      return(inner(x))
    elseif string_literal63(x) then
      return(x)
    elseif string63(x) then
      return(compile_id(x))
    elseif boolean63(x) then
      if x then
        return("true")
      else
        return("false")
      end
    elseif number63(x) then
      return((x .. ""))
    else
      error("Unrecognized atom")
    end
  end
  function compile_body(forms, ...)
    local _g175 = unstash({...})
    local tail63 = _g175["tail?"]
    local str = ""
    local i = 0
    local _g176 = forms
    while (i < length(_g176)) do
      local x = _g176[(i + 1)]
      local t63 = (tail63 and (i == (length(forms) - 1)))
      str = (str .. compile(x, {_stash = true, ["stmt?"] = true, ["tail?"] = t63}))
      i = (i + 1)
    end
    return(str)
  end
  function compile_call(form)
    if empty63(form) then
      return(compile_special({"%array"}))
    else
      local f = hd(form)
      local f1 = compile(f)
      local args = compile_args(stash42(tl(form)))
      if list63(f) then
        return(("(" .. f1 .. ")" .. args))
      elseif string63(f) then
        return((f1 .. args))
      else
        error("Invalid function call")
      end
    end
  end
  local function compile_infix(_g177)
    local op = _g177[1]
    local args = sub(_g177, 1)
    local str = "("
    local op = getop(op)
    local i = 0
    local _g178 = args
    while (i < length(_g178)) do
      local arg = _g178[(i + 1)]
      if ((op == "-") and (length(args) == 1)) then
        str = (str .. op .. compile(arg))
      else
        str = (str .. compile(arg))
        if (i < (length(args) - 1)) then
          str = (str .. " " .. op .. " ")
        end
      end
      i = (i + 1)
    end
    return((str .. ")"))
  end
  function compile_branch(condition, body, first63, last63, tail63)
    local cond1 = compile(condition)
    local _g179 = (function ()
      indent_level = (indent_level + 1)
      local _g180 = compile(body, {_stash = true, ["stmt?"] = true, ["tail?"] = tail63})
      indent_level = (indent_level - 1)
      return(_g180)
    end)()
    local ind = indentation()
    local tr = (function ()
      if (last63 and (target == "lua")) then
        return((ind .. "end\n"))
      elseif last63 then
        return("\n")
      else
        return("")
      end
    end)()
    if (first63 and (target == "js")) then
      return((ind .. "if (" .. cond1 .. ") {\n" .. _g179 .. ind .. "}" .. tr))
    elseif first63 then
      return((ind .. "if " .. cond1 .. " then\n" .. _g179 .. tr))
    elseif (nil63(condition) and (target == "js")) then
      return((" else {\n" .. _g179 .. ind .. "}\n"))
    elseif nil63(condition) then
      return((ind .. "else\n" .. _g179 .. tr))
    elseif (target == "js") then
      return((" else if (" .. cond1 .. ") {\n" .. _g179 .. ind .. "}" .. tr))
    else
      return((ind .. "elseif " .. cond1 .. " then\n" .. _g179 .. tr))
    end
  end
  function compile_function(args, body, ...)
    local _g181 = unstash({...})
    local name = _g181.name
    local prefix = _g181.prefix
    local id = (function ()
      if name then
        return(compile(name))
      else
        return("")
      end
    end)()
    local prefix = (prefix or "")
    local args = compile_args(args)
    local body = (function ()
      indent_level = (indent_level + 1)
      local _g182 = compile_body(body, {_stash = true, ["tail?"] = true})
      indent_level = (indent_level - 1)
      return(_g182)
    end)()
    local ind = indentation()
    local tr = (function ()
      if (target == "js") then
        return("")
      else
        return("end")
      end
    end)()
    if name then
      tr = (tr .. "\n")
    end
    if (target == "js") then
      return(("function " .. id .. args .. " {\n" .. body .. ind .. "}" .. tr))
    else
      return((prefix .. "function " .. id .. args .. "\n" .. body .. ind .. tr))
    end
  end
  local function terminator(stmt63)
    if (not stmt63) then
      return("")
    elseif (target == "js") then
      return(";\n")
    else
      return("\n")
    end
  end
  function compile_special(form, stmt63, tail63)
    local _g183 = getenv(hd(form))
    local special = _g183.special
    local stmt = _g183.stmt
    local self_tr63 = _g183.tr
    if ((not stmt63) and stmt) then
      return(compile({{"%function", {}, form}}, {_stash = true, ["tail?"] = tail63}))
    else
      local tr = terminator((stmt63 and (not self_tr63)))
      return((special(tl(form), tail63) .. tr))
    end
  end
  local function can_return63(form)
    return(((not special_form63(form)) or (not getenv(hd(form)).stmt)))
  end
  function compile(form, ...)
    local _g184 = unstash({...})
    local stmt63 = _g184["stmt?"]
    local tail63 = _g184["tail?"]
    if (tail63 and can_return63(form)) then
      form = {"return", form}
    end
    if nil63(form) then
      return("")
    elseif special_form63(form) then
      return(compile_special(form, stmt63, tail63))
    else
      local tr = terminator(stmt63)
      local ind = (function ()
        if stmt63 then
          return(indentation())
        else
          return("")
        end
      end)()
      local form = (function ()
        if atom63(form) then
          return(compile_atom(form))
        elseif infix63(form) then
          return(compile_infix(form))
        else
          return(compile_call(form))
        end
      end)()
      return((ind .. form .. tr))
    end
  end
  _37result = nil
  local function run(x)
    local f = load((compile("%result") .. "=" .. x))
    if f then
      f()
      return(_37result)
    else
      local f,e = load(x)
      if f then
        return(f())
      else
        error((e .. " in " .. x))
      end
    end
  end
  function eval(form)
    local previous = target
    target = "lua"
    local str = compile(macroexpand(form))
    target = previous
    return(run(str))
  end
  current_module = nil
  local function module(spec)
    return(modules[module_key(spec)])
  end
  local function module_path(spec)
    return((module_key(spec) .. ".l"))
  end
  local function exported()
    local toplevel = hd(environment)
    local m = make_id()
    local k = module_key(current_module)
    local form = {"do", {"define", m, {"table"}}, {"set", {"get", "exports", {"quote", k}}, m}}
    local k = nil
    local _g185 = toplevel
    for k in next, _g185 do
      if (not number63(k)) then
        local v = _g185[k]
        if (v.variable and v.export and (v.module == current_module)) then
          add(form, {"set", {"get", m, {"quote", k}}, k})
        end
      end
    end
    return(form)
  end
  local function encapsulate(body)
    local _g186 = macroexpand(body)
    local epilog = macroexpand(exported())
    return({join({"%function", {}}, join(_g186, {epilog}))})
  end
  local function compile_file(file)
    local str = read_file(file)
    local body = read_all(make_stream(str))
    local form = encapsulate(body)
    return((compile(form) .. ";\n"))
  end
  local compiler_output = nil
  local compilation_level = nil
  function compile_module(spec)
    compilation_level = 0
    compiler_output = ""
    load_module(spec)
    return(compiler_output)
  end
  local function _37compile_module(spec)
    local path = module_path(spec)
    local mod0 = current_module
    local env0 = environment
    local k = module_key(spec)
    if number63(compilation_level) then
      compilation_level = (compilation_level + 1)
    end
    current_module = spec
    environment = initial_environment()
    local compiled = compile_file(path)
    local m = module(spec)
    local toplevel = hd(environment)
    current_module = mod0
    environment = env0
    local name = nil
    local _g194 = toplevel
    for name in next, _g194 do
      if (not number63(name)) then
        local binding = _g194[name]
        if (binding.export and (binding.module == k)) then
          m.export[name] = binding
        end
      end
    end
    if number63(compilation_level) then
      compilation_level = (compilation_level - 1)
      compiler_output = (compiler_output .. compiled)
    else
      return(run(compiled))
    end
  end
  function load_module(spec)
    if (nil63(module(spec)) or (compilation_level == 1)) then
      _37compile_module(spec)
    end
    return(open_module(spec))
  end
  function open_module(spec)
    local m = module(spec)
    local frame = last(environment)
    local k = nil
    local _g195 = m.export
    for k in next, _g195 do
      if (not number63(k)) then
        local v = _g195[k]
        frame[k] = v
      end
    end
  end
  function in_module(spec)
    load_module(spec)
    local m = module(spec)
    return(map(open_module, m.import))
  end
  _g196 = {}
  exports.compiler = _g196
  _g196["valid-id?"] = valid_id63
  _g196["compile-body"] = compile_body
  _g196["compile-call"] = compile_call
  _g196["compile-branch"] = compile_branch
  _g196["compile-function"] = compile_function
  _g196["compile-special"] = compile_special
  _g196.compile = compile
  _g196.eval = eval
  _g196["load-module"] = load_module
  _g196["open-module"] = open_module
  _g196["in-module"] = in_module
end)();
(function ()
  modules = {special = {import = {"utilities", "special", "core", "compiler"}, export = {["%local"] = {special = function (_g197)
    local name = _g197[1]
    local value = _g197[2]
    local id = compile(name)
    local value = compile(value)
    local keyword = (function ()
      if (target == "js") then
        return("var ")
      else
        return("local ")
      end
    end)()
    local ind = indentation()
    return((ind .. keyword .. id .. " = " .. value))
  end, export = true, stmt = true, module = "special"}, ["%global-function"] = {special = function (_g198)
    local name = _g198[1]
    local args = _g198[2]
    local body = sub(_g198, 2)
    if (target == "lua") then
      local x = compile_function(args, body, {_stash = true, name = name})
      return((indentation() .. x))
    else
      return(compile({"set", name, join({"%function", args}, body)}, {_stash = true, ["stmt?"] = true}))
    end
  end, export = true, module = "special", stmt = true, tr = true}, ["%for"] = {special = function (_g199)
    local _g200 = _g199[1]
    local t = _g200[1]
    local k = _g200[2]
    local body = sub(_g199, 1)
    local t = compile(t)
    local ind = indentation()
    local body = (function ()
      indent_level = (indent_level + 1)
      local _g201 = compile_body(body)
      indent_level = (indent_level - 1)
      return(_g201)
    end)()
    if (target == "lua") then
      return((ind .. "for " .. k .. " in next, " .. t .. " do\n" .. body .. ind .. "end\n"))
    else
      return((ind .. "for (" .. k .. " in " .. t .. ") {\n" .. body .. ind .. "}\n"))
    end
  end, export = true, module = "special", stmt = true, tr = true}, ["return"] = {special = function (_g202)
    local x = _g202[1]
    local x = (function ()
      if nil63(x) then
        return("return")
      else
        return(compile_call({"return", x}))
      end
    end)()
    return((indentation() .. x))
  end, export = true, stmt = true, module = "special"}, ["%try"] = {special = function (forms)
    local ind = indentation()
    local body = (function ()
      indent_level = (indent_level + 1)
      local _g203 = compile_body(forms, {_stash = true, ["tail?"] = true})
      indent_level = (indent_level - 1)
      return(_g203)
    end)()
    local e = make_id()
    local handler = {"return", {"%array", false, e}}
    local h = (function ()
      indent_level = (indent_level + 1)
      local _g204 = compile(handler, {_stash = true, ["stmt?"] = true})
      indent_level = (indent_level - 1)
      return(_g204)
    end)()
    return((ind .. "try {\n" .. body .. ind .. "}\n" .. ind .. "catch (" .. e .. ") {\n" .. h .. ind .. "}\n"))
  end, export = true, module = "special", stmt = true, tr = true}, ["set"] = {special = function (_g205)
    local lh = _g205[1]
    local rh = _g205[2]
    if nil63(rh) then
      error("Missing right-hand side in assignment")
    end
    return((indentation() .. compile(lh) .. " = " .. compile(rh)))
  end, export = true, stmt = true, module = "special"}, ["while"] = {special = function (_g206)
    local condition = _g206[1]
    local body = sub(_g206, 1)
    local condition = compile(condition)
    local body = (function ()
      indent_level = (indent_level + 1)
      local _g207 = compile_body(body)
      indent_level = (indent_level - 1)
      return(_g207)
    end)()
    local ind = indentation()
    if (target == "js") then
      return((ind .. "while (" .. condition .. ") {\n" .. body .. ind .. "}\n"))
    else
      return((ind .. "while " .. condition .. " do\n" .. body .. ind .. "end\n"))
    end
  end, export = true, module = "special", stmt = true, tr = true}, ["if"] = {special = function (form, tail63)
    local str = ""
    local i = 0
    local _g208 = form
    while (i < length(_g208)) do
      local condition = _g208[(i + 1)]
      local last63 = (i >= (length(form) - 2))
      local else63 = (i == (length(form) - 1))
      local first63 = (i == 0)
      local body = form[((i + 1) + 1)]
      if else63 then
        body = condition
        condition = nil
      end
      str = (str .. compile_branch(condition, body, first63, last63, tail63))
      i = (i + 1)
      i = (i + 1)
    end
    return(str)
  end, export = true, module = "special", stmt = true, tr = true}, ["get"] = {special = function (_g209)
    local t = _g209[1]
    local k = _g209[2]
    local t = compile(t)
    local k1 = compile(k)
    if ((target == "lua") and (char(t, 0) == "{")) then
      t = ("(" .. t .. ")")
    end
    if (string_literal63(k) and valid_id63(inner(k))) then
      return((t .. "." .. inner(k)))
    else
      return((t .. "[" .. k1 .. "]"))
    end
  end, export = true, module = "special"}, ["do"] = {special = function (forms, tail63)
    return(compile_body(forms, {_stash = true, ["tail?"] = tail63}))
  end, export = true, module = "special", stmt = true, tr = true}, ["%object"] = {special = function (forms)
    local str = "{"
    local sep = (function ()
      if (target == "lua") then
        return(" = ")
      else
        return(": ")
      end
    end)()
    local pairs = pairwise(forms)
    local i = 0
    local _g210 = pairs
    while (i < length(_g210)) do
      local _g211 = _g210[(i + 1)]
      local k = _g211[1]
      local v = _g211[2]
      if (not string63(k)) then
        error(("Illegal key: " .. to_string(k)))
      end
      local v = compile(v)
      local k = (function ()
        if valid_id63(k) then
          return(k)
        elseif ((target == "js") and string_literal63(k)) then
          return(k)
        elseif (target == "js") then
          return(quoted(k))
        elseif string_literal63(k) then
          return(("[" .. k .. "]"))
        else
          return(("[" .. quoted(k) .. "]"))
        end
      end)()
      str = (str .. k .. sep .. v)
      if (i < (length(pairs) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((str .. "}"))
  end, export = true, module = "special"}, ["not"] = {special = function (_g212)
    local x = _g212[1]
    local x = compile(x)
    local open = (function ()
      if (target == "js") then
        return("!(")
      else
        return("(not ")
      end
    end)()
    return((open .. x .. ")"))
  end, export = true, module = "special"}, ["%local-function"] = {special = function (_g213)
    local name = _g213[1]
    local args = _g213[2]
    local body = sub(_g213, 2)
    local x = compile_function(args, body, {_stash = true, name = name, prefix = "local "})
    return((indentation() .. x))
  end, export = true, module = "special", stmt = true, tr = true}, ["break"] = {special = function (_g62)
    return((indentation() .. "break"))
  end, export = true, stmt = true, module = "special"}, ["error"] = {special = function (_g214)
    local x = _g214[1]
    local e = (function ()
      if (target == "js") then
        return(("throw " .. compile(x)))
      else
        return(compile_call({"error", x}))
      end
    end)()
    return((indentation() .. e))
  end, export = true, stmt = true, module = "special"}, ["%function"] = {special = function (_g215)
    local args = _g215[1]
    local body = sub(_g215, 1)
    return(compile_function(args, body))
  end, export = true, module = "special"}, ["%array"] = {special = function (forms)
    local open = (function ()
      if (target == "lua") then
        return("{")
      else
        return("[")
      end
    end)()
    local close = (function ()
      if (target == "lua") then
        return("}")
      else
        return("]")
      end
    end)()
    local str = ""
    local i = 0
    local _g216 = forms
    while (i < length(_g216)) do
      local x = _g216[(i + 1)]
      str = (str .. compile(x))
      if (i < (length(forms) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((open .. str .. close))
  end, export = true, module = "special"}}}, boot = {import = {"utilities", "special", "core"}, export = {}}, compiler = {import = {"utilities", "runtime", "special", "core", "reader"}, export = {["define-module"] = {export = true, module = "compiler", macro = function (spec, ...)
    local body = unstash({...})
    local _g217 = sub(body, 0)
    local imp = _g217.import
    local exp = _g217.export
    map(load_module, imp)
    modules[module_key(spec)] = {import = imp, export = {}}
    local _g219 = 0
    local _g218 = (exp or {})
    while (_g219 < length(_g218)) do
      local k = _g218[(_g219 + 1)]
      setenv(k, {_stash = true, export = true})
      _g219 = (_g219 + 1)
    end
  end}, ["valid-id?"] = {export = true, module = "compiler", variable = true}, ["compile-body"] = {export = true, module = "compiler", variable = true}, ["compile-call"] = {export = true, module = "compiler", variable = true}, ["compile-branch"] = {export = true, module = "compiler", variable = true}, ["compile-function"] = {export = true, module = "compiler", variable = true}, ["compile-special"] = {export = true, module = "compiler", variable = true}, compile = {export = true, module = "compiler", variable = true}, eval = {export = true, module = "compiler", variable = true}, ["load-module"] = {export = true, module = "compiler", variable = true}, ["open-module"] = {export = true, module = "compiler", variable = true}, ["in-module"] = {export = true, module = "compiler", variable = true}}}, reader = {import = {"special", "core"}, export = {["make-stream"] = {export = true, module = "reader", variable = true}, ["read-table"] = {export = true, module = "reader", variable = true}, ["define-reader"] = {export = true, module = "reader", macro = function (_g220, ...)
    local char = _g220[1]
    local stream = _g220[2]
    local body = unstash({...})
    local _g221 = sub(body, 0)
    return({"set", {"get", "read-table", char}, join({"fn", {stream}}, _g221)})
  end}, read = {export = true, module = "reader", variable = true}, ["read-all"] = {export = true, module = "reader", variable = true}, ["read-from-string"] = {export = true, module = "reader", variable = true}}}, core = {import = {"utilities", "runtime", "special", "core"}, export = {target = {variable = true, export = true, macro = function (...)
    local clauses = unstash({...})
    return(clauses[target])
  end, module = "core"}, ["parse-number"] = {variable = true, export = true, module = "core"}, ["boolean?"] = {variable = true, export = true, module = "core"}, ["is?"] = {variable = true, export = true, module = "core"}, ["table?"] = {variable = true, export = true, module = "core"}, ["nil?"] = {variable = true, export = true, module = "core"}, ["atom?"] = {variable = true, export = true, module = "core"}, ["id-literal?"] = {variable = true, export = true, module = "core"}, ["composite?"] = {variable = true, export = true, module = "core"}, ["string-literal?"] = {variable = true, export = true, module = "core"}, ["list?"] = {variable = true, export = true, module = "core"}, ["function?"] = {variable = true, export = true, module = "core"}, ["number?"] = {variable = true, export = true, module = "core"}, ["string?"] = {variable = true, export = true, module = "core"}, ["set-of"] = {export = true, module = "core", macro = function (...)
    local elements = unstash({...})
    local l = {}
    local _g223 = 0
    local _g222 = elements
    while (_g223 < length(_g222)) do
      local e = _g222[(_g223 + 1)]
      l[e] = true
      _g223 = (_g223 + 1)
    end
    return(join({"table"}, l))
  end}, ["join*"] = {export = true, module = "core", macro = function (...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return({"join", a, b})
    end, xs))
  end}, ["with-bindings"] = {export = true, module = "core", macro = function (_g224, ...)
    local names = _g224[1]
    local body = unstash({...})
    local _g225 = sub(body, 0)
    local x = make_id()
    return(join({"with-frame", {"across", {names, x}, (function ()
      local _g226 = {"setenv", x}
      _g226.variable = true
      return(_g226)
    end)()}}, _g225))
  end}, ["define-symbol"] = {export = true, module = "core", macro = function (name, expansion)
    setenv(name, {_stash = true, symbol = expansion})
    return(nil)
  end}, across = {export = true, module = "core", macro = function (_g227, ...)
    local l = _g227[1]
    local v = _g227[2]
    local i = _g227[3]
    local start = _g227[4]
    local body = unstash({...})
    local _g228 = sub(body, 0)
    local l1 = make_id()
    i = (i or make_id())
    start = (start or 0)
    return({"let", {i, start, l1, l}, {"while", {"<", i, {"length", l1}}, join({"let", {v, {"at", l1, i}}}, join(_g228, {{"inc", i}}))}})
  end}, ["define-global"] = {export = true, module = "core", macro = function (name, x, ...)
    local body = unstash({...})
    local _g229 = sub(body, 0)
    setenv(name, {_stash = true, variable = true})
    if (not empty63(_g229)) then
      local _g230 = bind42(x, _g229)
      local args = _g230[1]
      local _g231 = _g230[2]
      return(join({"%global-function", name, args}, _g231))
    else
      return({"set", name, x})
    end
  end}, quote = {export = true, module = "core", macro = function (form)
    return(quoted(form))
  end}, fn = {export = true, module = "core", macro = function (args, ...)
    local body = unstash({...})
    local _g232 = sub(body, 0)
    local _g233 = bind42(args, _g232)
    local args = _g233[1]
    local _g234 = _g233[2]
    return(join({"%function", args}, _g234))
  end}, ["join!"] = {export = true, module = "core", macro = function (a, ...)
    local bs = unstash({...})
    local _g235 = sub(bs, 0)
    return({"set", a, join({"join*", a}, _g235)})
  end}, at = {export = true, module = "core", macro = function (l, i)
    if ((target == "lua") and number63(i)) then
      i = (i + 1)
    elseif (target == "lua") then
      i = {"+", i, 1}
    end
    return({"get", l, i})
  end}, quasiquote = {export = true, module = "core", macro = function (form)
    return(quasiexpand(form, 1))
  end}, list = {export = true, module = "core", macro = function (...)
    local body = unstash({...})
    local l = join({"%array"}, body)
    if (not keys63(body)) then
      return(l)
    else
      local id = make_id()
      local init = {}
      local k = nil
      local _g236 = body
      for k in next, _g236 do
        if (not number63(k)) then
          local v = _g236[k]
          add(init, {"set", {"get", id, {"quote", k}}, v})
        end
      end
      return(join({"let", {id, l}}, join(init, {id})))
    end
  end}, dec = {export = true, module = "core", macro = function (n, by)
    return({"set", n, {"-", n, (by or 1)}})
  end}, ["cat!"] = {export = true, module = "core", macro = function (a, ...)
    local bs = unstash({...})
    local _g237 = sub(bs, 0)
    return({"set", a, join({"cat", a}, _g237)})
  end}, ["define-local"] = {export = true, module = "core", macro = function (name, x, ...)
    local body = unstash({...})
    local _g238 = sub(body, 0)
    setenv(name, {_stash = true, variable = true})
    if (not empty63(_g238)) then
      local _g239 = bind42(x, _g238)
      local args = _g239[1]
      local _g240 = _g239[2]
      return(join({"%local-function", name, args}, _g240))
    else
      return({"%local", name, x})
    end
  end}, pr = {export = true, module = "core", macro = function (...)
    local xs = unstash({...})
    local xs = map(function (x)
      return(splice({{"to-string", x}, "\" \""}))
    end, xs)
    return({"print", join({"cat"}, xs)})
  end}, guard = {export = true, module = "core", macro = function (expr)
    if (target == "js") then
      return({{"fn", {}, {"%try", {"list", true, expr}}}})
    else
      local e = make_id()
      local x = make_id()
      local ex = ("|" .. e .. "," .. x .. "|")
      return({"let", {ex, {"xpcall", {"fn", {}, expr}, "%message-handler"}}, {"list", e, x}})
    end
  end}, language = {export = true, module = "core", macro = function ()
    return({"quote", target})
  end}, table = {export = true, module = "core", macro = function (...)
    local body = unstash({...})
    return(join({"%object"}, mapo(function (_g107, x)
      return(x)
    end, body)))
  end}, ["let-macro"] = {export = true, module = "core", macro = function (definitions, ...)
    local body = unstash({...})
    local _g241 = sub(body, 0)
    add(environment, {})
    local _g242 = (function ()
      map(function (m)
        return(macroexpand(join({"define-macro"}, m)))
      end, definitions)
      return(join({"do"}, macroexpand(_g241)))
    end)()
    drop(environment)
    return(_g242)
  end}, ["with-frame"] = {export = true, module = "core", macro = function (...)
    local body = unstash({...})
    local x = make_id()
    return({"do", {"add", "environment", {"table"}}, {"let", {x, join({"do"}, body)}, {"drop", "environment"}, x}})
  end}, ["list*"] = {export = true, module = "core", macro = function (...)
    local xs = unstash({...})
    if empty63(xs) then
      return({})
    else
      local l = {}
      local i = 0
      local _g243 = xs
      while (i < length(_g243)) do
        local x = _g243[(i + 1)]
        if (i == (length(xs) - 1)) then
          l = {"join", join({"list"}, l), x}
        else
          add(l, x)
        end
        i = (i + 1)
      end
      return(l)
    end
  end}, each = {export = true, module = "core", macro = function (_g244, ...)
    local t = _g244[1]
    local k = _g244[2]
    local v = _g244[3]
    local body = unstash({...})
    local _g245 = sub(body, 0)
    local t1 = make_id()
    return({"let", {k, "nil", t1, t}, {"%for", {t1, k}, {"if", (function ()
      local _g246 = {"target"}
      _g246.js = {"isNaN", {"parseInt", k}}
      _g246.lua = {"not", {"number?", k}}
      return(_g246)
    end)(), join({"let", {v, {"get", t1, k}}}, _g245)}}})
  end}, inc = {export = true, module = "core", macro = function (n, by)
    return({"set", n, {"+", n, (by or 1)}})
  end}, define = {export = true, module = "core", macro = function (name, x, ...)
    local body = unstash({...})
    local _g247 = sub(body, 0)
    setenv(name, {_stash = true, variable = true})
    return(join({"define-global", name, x}, _g247))
  end}, let = {export = true, module = "core", macro = function (bindings, ...)
    local body = unstash({...})
    local _g248 = sub(body, 0)
    local i = 0
    local renames = {}
    local locals = {}
    map(function (_g249)
      local lh = _g249[1]
      local rh = _g249[2]
      local _g251 = 0
      local _g250 = bind(lh, rh)
      while (_g251 < length(_g250)) do
        local _g252 = _g250[(_g251 + 1)]
        local id = _g252[1]
        local val = _g252[2]
        if bound63(id) then
          local rename = make_id()
          add(renames, id)
          add(renames, rename)
          id = rename
        else
          setenv(id, {_stash = true, variable = true})
        end
        add(locals, {"%local", id, val})
        _g251 = (_g251 + 1)
      end
    end, pairwise(bindings))
    return(join({"do"}, join(locals, {join({"let-symbol", renames}, _g248)})))
  end}, ["define-special"] = {export = true, module = "core", macro = function (name, args, ...)
    local body = unstash({...})
    local _g253 = sub(body, 0)
    local form = join({"fn", args}, _g253)
    local keys = sub(_g253, length(_g253))
    eval(join((function ()
      local _g254 = {"setenv", {"quote", name}}
      _g254.special = form
      _g254.form = {"quote", form}
      return(_g254)
    end)(), keys))
    return(nil)
  end}, ["let-symbol"] = {export = true, module = "core", macro = function (expansions, ...)
    local body = unstash({...})
    local _g255 = sub(body, 0)
    add(environment, {})
    local _g256 = (function ()
      map(function (_g257)
        local name = _g257[1]
        local exp = _g257[2]
        return(macroexpand({"define-symbol", name, exp}))
      end, pairwise(expansions))
      return(join({"do"}, macroexpand(_g255)))
    end)()
    drop(environment)
    return(_g256)
  end}, ["define-macro"] = {export = true, module = "core", macro = function (name, args, ...)
    local body = unstash({...})
    local _g258 = sub(body, 0)
    local form = join({"fn", args}, _g258)
    eval((function ()
      local _g259 = {"setenv", {"quote", name}}
      _g259.macro = form
      _g259.form = {"quote", form}
      return(_g259)
    end)())
    return(nil)
  end}}}, runtime = {import = {"special", "core"}, export = {["parse-number"] = {variable = true, export = true, module = "core"}, ["boolean?"] = {variable = true, export = true, module = "core"}, ["is?"] = {variable = true, export = true, module = "core"}, ["table?"] = {variable = true, export = true, module = "core"}, ["nil?"] = {variable = true, export = true, module = "core"}, ["atom?"] = {variable = true, export = true, module = "core"}, ["id-literal?"] = {variable = true, export = true, module = "core"}, ["composite?"] = {variable = true, export = true, module = "core"}, ["string-literal?"] = {variable = true, export = true, module = "core"}, ["list?"] = {variable = true, export = true, module = "core"}, ["function?"] = {variable = true, export = true, module = "core"}, ["number?"] = {variable = true, export = true, module = "core"}, ["string?"] = {variable = true, export = true, module = "core"}, length = {export = true, module = "runtime", variable = true}, ["empty?"] = {export = true, module = "runtime", variable = true}, substring = {export = true, module = "runtime", variable = true}, sublist = {export = true, module = "runtime", variable = true}, sub = {export = true, module = "runtime", variable = true}, inner = {export = true, module = "runtime", variable = true}, hd = {export = true, module = "runtime", variable = true}, tl = {export = true, module = "runtime", variable = true}, add = {export = true, module = "runtime", variable = true}, drop = {export = true, module = "runtime", variable = true}, last = {export = true, module = "runtime", variable = true}, reverse = {export = true, module = "runtime", variable = true}, join = {export = true, module = "runtime", variable = true}, reduce = {export = true, module = "runtime", variable = true}, keep = {export = true, module = "runtime", variable = true}, find = {export = true, module = "runtime", variable = true}, pairwise = {export = true, module = "runtime", variable = true}, iterate = {export = true, module = "runtime", variable = true}, replicate = {export = true, module = "runtime", variable = true}, splice = {export = true, module = "runtime", variable = true}, map = {export = true, module = "runtime", variable = true}, ["map*"] = {export = true, module = "runtime", variable = true}, mapt = {export = true, module = "runtime", variable = true}, mapo = {export = true, module = "runtime", variable = true}, ["keys?"] = {export = true, module = "runtime", variable = true}, extend = {export = true, module = "runtime", variable = true}, exclude = {export = true, module = "runtime", variable = true}, char = {export = true, module = "runtime", variable = true}, code = {export = true, module = "runtime", variable = true}, search = {export = true, module = "runtime", variable = true}, split = {export = true, module = "runtime", variable = true}, ["cat"] = {export = true, module = "runtime", variable = true}, ["+"] = {export = true, module = "runtime", variable = true}, ["-"] = {export = true, module = "runtime", variable = true}, ["*"] = {export = true, module = "runtime", variable = true}, ["/"] = {export = true, module = "runtime", variable = true}, ["%"] = {export = true, module = "runtime", variable = true}, [">"] = {export = true, module = "runtime", variable = true}, ["<"] = {export = true, module = "runtime", variable = true}, ["="] = {export = true, module = "runtime", variable = true}, [">="] = {export = true, module = "runtime", variable = true}, ["<="] = {export = true, module = "runtime", variable = true}, ["read-file"] = {export = true, module = "runtime", variable = true}, ["write-file"] = {export = true, module = "runtime", variable = true}, print = {}, write = {export = true, module = "runtime", variable = true}, exit = {export = true, module = "runtime", variable = true}, type = {}, ["to-string"] = {export = true, module = "runtime", variable = true}, apply = {export = true, module = "runtime", variable = true}, stash = {export = true, module = "runtime", variable = true}, unstash = {export = true, module = "runtime", variable = true}, ["%message-handler"] = {export = true, module = "runtime", variable = true}}}, utilities = {import = {"special", "core"}, export = {target = {variable = true, export = true, macro = function (...)
    local clauses = unstash({...})
    return(clauses[target])
  end, module = "core"}, setenv = {export = true, module = "utilities", variable = true}, getenv = {export = true, module = "utilities", variable = true}, ["macro-function"] = {export = true, module = "utilities", variable = true}, ["macro?"] = {export = true, module = "utilities", variable = true}, ["special?"] = {export = true, module = "utilities", variable = true}, ["special-form?"] = {export = true, module = "utilities", variable = true}, ["symbol-expansion"] = {export = true, module = "utilities", variable = true}, ["symbol?"] = {export = true, module = "utilities", variable = true}, ["variable?"] = {export = true, module = "utilities", variable = true}, ["bound?"] = {export = true, module = "utilities", variable = true}, quoted = {export = true, module = "utilities", variable = true}, ["stash*"] = {export = true, module = "utilities", variable = true}, ["make-id"] = {}, bind = {export = true, module = "utilities", variable = true}, ["bind*"] = {export = true, module = "utilities", variable = true}, quasiexpand = {export = true, module = "utilities", variable = true}, macroexpand = {export = true, module = "utilities", variable = true}, indentation = {export = true, module = "utilities", variable = true}, ["with-indent"] = {export = true, module = "utilities", macro = function (form)
    local result = make_id()
    return({"do", {"inc", "indent-level"}, {"let", {result, form}, {"dec", "indent-level"}, result}})
  end}, ["module-key"] = {export = true, module = "utilities", variable = true}, ["quote-environment"] = {export = true, module = "utilities", variable = true}, ["quote-modules"] = {export = true, module = "utilities", variable = true}, ["initial-environment"] = {export = true, module = "utilities", variable = true}}}, lib = {import = {"core", "special"}, export = {}}}
  environment = {{["define-module"] = {export = true, module = "compiler", macro = function (spec, ...)
    local body = unstash({...})
    local _g260 = sub(body, 0)
    local imp = _g260.import
    local exp = _g260.export
    map(load_module, imp)
    modules[module_key(spec)] = {import = imp, export = {}}
    local _g262 = 0
    local _g261 = (exp or {})
    while (_g262 < length(_g261)) do
      local k = _g261[(_g262 + 1)]
      setenv(k, {_stash = true, export = true})
      _g262 = (_g262 + 1)
    end
  end}}}
  _g263 = {}
  exports.boot = _g263
  _g263.environment = environment
  _g263.modules = modules
end)();
(function ()
  local function rep(str)
    local _g264 = (function ()
      local _g265,_g266 = xpcall(function ()
        return(eval(read_from_string(str)))
      end, _37message_handler)
      return({_g265, _g266})
    end)()
    local _g1 = _g264[1]
    local x = _g264[2]
    if is63(x) then
      return(print((to_string(x) .. " ")))
    end
  end
  local function repl()
    local step = function (str)
      rep(str)
      return(write("> "))
    end
    write("> ")
    while true do
      local str = (io.read)()
      if str then
        step(str)
      else
        break
      end
    end
  end
  local function usage()
    print((to_string("usage: lumen [options] <module>") .. " "))
    print((to_string("options:") .. " "))
    print((to_string("  -o <output>\tOutput file") .. " "))
    print((to_string("  -t <target>\tTarget language (default: lua)") .. " "))
    print((to_string("  -e <expr>\tExpression to evaluate") .. " "))
    return(exit())
  end
  local function main()
    local args = arg
    if ((hd(args) == "-h") or (hd(args) == "--help")) then
      usage()
    end
    local spec = nil
    local output = nil
    local target1 = nil
    local expr = nil
    local i = 0
    local _g267 = args
    while (i < length(_g267)) do
      local arg = _g267[(i + 1)]
      if ((arg == "-o") or (arg == "-t") or (arg == "-e")) then
        if (i == (length(args) - 1)) then
          print((to_string("missing argument for") .. " " .. to_string(arg) .. " "))
        else
          i = (i + 1)
          local val = args[(i + 1)]
          if (arg == "-o") then
            output = val
          elseif (arg == "-t") then
            target1 = val
          elseif (arg == "-e") then
            expr = val
          end
        end
      elseif (nil63(spec) and ("-" ~= char(arg, 0))) then
        spec = arg
      end
      i = (i + 1)
    end
    if output then
      if target1 then
        target = target1
      end
      return(write_file(output, compile_module(spec)))
    else
      local spec = (spec or "main")
      in_module(spec)
      if expr then
        return(rep(expr))
      else
        return(repl())
      end
    end
  end
  main()
  _g268 = {}
  exports.main = _g268
end)();
