nexus = {}
(function ()
  nexus["lumen/runtime"] = {}
  local function nil63(x)
    return(x == nil)
  end
  nexus["lumen/runtime"]["nil?"] = nil63
  local function is63(x)
    return(not nil63(x))
  end
  nexus["lumen/runtime"]["is?"] = is63
  local function length(x)
    return(#x)
  end
  nexus["lumen/runtime"].length = length
  local function none63(x)
    return(length(x) == 0)
  end
  nexus["lumen/runtime"]["none?"] = none63
  local function some63(x)
    return(length(x) > 0)
  end
  nexus["lumen/runtime"]["some?"] = some63
  local function one63(x)
    return(length(x) == 1)
  end
  nexus["lumen/runtime"]["one?"] = one63
  local function hd(l)
    return(l[1])
  end
  nexus["lumen/runtime"].hd = hd
  local function string63(x)
    return(type(x) == "string")
  end
  nexus["lumen/runtime"]["string?"] = string63
  local function number63(x)
    return(type(x) == "number")
  end
  nexus["lumen/runtime"]["number?"] = number63
  local function boolean63(x)
    return(type(x) == "boolean")
  end
  nexus["lumen/runtime"]["boolean?"] = boolean63
  local function function63(x)
    return(type(x) == "function")
  end
  nexus["lumen/runtime"]["function?"] = function63
  local function composite63(x)
    return(is63(x) and type(x) == "table")
  end
  nexus["lumen/runtime"]["composite?"] = composite63
  local function atom63(x)
    return(nil63(x) or not composite63(x))
  end
  nexus["lumen/runtime"]["atom?"] = atom63
  local function table63(x)
    return(composite63(x) and nil63(hd(x)))
  end
  nexus["lumen/runtime"]["table?"] = table63
  local function list63(x)
    return(composite63(x) and is63(hd(x)))
  end
  nexus["lumen/runtime"]["list?"] = list63
  local function substring(str, from, upto)
    return(string.sub(str, from + 1, upto))
  end
  nexus["lumen/runtime"].substring = substring
  local function sub(x, from, upto)
    if string63(x) then
      return(substring(x, from or 0, upto))
    else
      local l = {}
      local j = 0
      local _g60
      if nil63(from) or from < 0 then
        _g60 = 0
      else
        _g60 = from
      end
      local i = _g60
      local n = length(x)
      local _g61
      if nil63(upto) or upto > n then
        _g61 = n
      else
        _g61 = upto
      end
      local _g26 = _g61
      while i < _g26 do
        l[j + 1] = x[i + 1]
        i = i + 1
        j = j + 1
      end
      local _g27 = x
      local k = nil
      for k in next, _g27 do
        local v = _g27[k]
        if not number63(k) then
          l[k] = v
        end
      end
      return(l)
    end
  end
  nexus["lumen/runtime"].sub = sub
  local function inner(x)
    return(sub(x, 1, length(x) - 1))
  end
  nexus["lumen/runtime"].inner = inner
  local function tl(l)
    return(sub(l, 1))
  end
  nexus["lumen/runtime"].tl = tl
  local function char(str, n)
    return(sub(str, n, n + 1))
  end
  nexus["lumen/runtime"].char = char
  local function code(str, n)
    local _g62
    if n then
      _g62 = n + 1
    end
    return(string.byte(str, _g62))
  end
  nexus["lumen/runtime"].code = code
  local function string_literal63(x)
    return(string63(x) and char(x, 0) == "\"")
  end
  nexus["lumen/runtime"]["string-literal?"] = string_literal63
  local function id_literal63(x)
    return(string63(x) and char(x, 0) == "|")
  end
  nexus["lumen/runtime"]["id-literal?"] = id_literal63
  local function add(l, x)
    return(table.insert(l, x))
  end
  nexus["lumen/runtime"].add = add
  local function drop(l)
    return(table.remove(l))
  end
  nexus["lumen/runtime"].drop = drop
  local function last(l)
    return(l[length(l) - 1 + 1])
  end
  nexus["lumen/runtime"].last = last
  local function reverse(l)
    local l1 = sub(l, length(l))
    local i = length(l) - 1
    while i >= 0 do
      add(l1, l[i + 1])
      i = i - 1
    end
    return(l1)
  end
  nexus["lumen/runtime"].reverse = reverse
  local function join(a, b)
    if a and b then
      local c = {}
      local o = length(a)
      local _g29 = a
      local k = nil
      for k in next, _g29 do
        local v = _g29[k]
        c[k] = v
      end
      local _g31 = b
      local k = nil
      for k in next, _g31 do
        local v = _g31[k]
        if number63(k) then
          k = k + o
        end
        c[k] = v
      end
      return(c)
    else
      return(a or b or {})
    end
  end
  nexus["lumen/runtime"].join = join
  local function reduce(f, x)
    if none63(x) then
      return(x)
    else
      if one63(x) then
        return(hd(x))
      else
        return(f(hd(x), reduce(f, tl(x))))
      end
    end
  end
  nexus["lumen/runtime"].reduce = reduce
  local function shift(k, n)
    if number63(k) then
      return(k - n)
    else
      return(k)
    end
  end
  nexus["lumen/runtime"].shift = shift
  local function keep(f, x)
    local t = {}
    local o = 0
    local _g33 = x
    local k = nil
    for k in next, _g33 do
      local v = _g33[k]
      if f(v) then
        t[shift(k, o)] = v
      else
        o = o + 1
      end
    end
    return(t)
  end
  nexus["lumen/runtime"].keep = keep
  local function in63(x, t)
    local _g35 = t
    local _g19 = nil
    for _g19 in next, _g35 do
      local y = _g35[_g19]
      if x == y then
        return(true)
      end
    end
  end
  nexus["lumen/runtime"]["in?"] = in63
  local function find(f, t)
    local _g37 = t
    local _g20 = nil
    for _g20 in next, _g37 do
      local x = _g37[_g20]
      local _g39 = f(x)
      if _g39 then
        return(_g39)
      end
    end
  end
  nexus["lumen/runtime"].find = find
  local function pair(l)
    local i = 0
    local l1 = {}
    while i < length(l) do
      add(l1, {l[i + 1], l[i + 1 + 1]})
      i = i + 2
    end
    return(l1)
  end
  nexus["lumen/runtime"].pair = pair
  local function sort(l, f)
    table.sort(l, f)
    return(l)
  end
  nexus["lumen/runtime"].sort = sort
  local function iterate(f, count)
    local i = 0
    while i < count do
      f(i)
      i = i + 1
    end
  end
  nexus["lumen/runtime"].iterate = iterate
  local function replicate(n, x)
    local l = {}
    iterate(function ()
      return(add(l, x))
    end, n)
    return(l)
  end
  nexus["lumen/runtime"].replicate = replicate
  local function series(f, l)
    return(iterate(function (i)
      return(f(l[i + 1]))
    end, length(l)))
  end
  nexus["lumen/runtime"].series = series
  local function map(f, x)
    local t = {}
    local o = 0
    local _g40 = x
    local k = nil
    for k in next, _g40 do
      local v = _g40[k]
      local y = f(v)
      if is63(y) then
        t[shift(k, o)] = y
      else
        o = o + 1
      end
    end
    return(t)
  end
  nexus["lumen/runtime"].map = map
  local function keys63(t)
    local k63 = false
    local _g42 = t
    local k = nil
    for k in next, _g42 do
      local _g21 = _g42[k]
      if not number63(k) then
        k63 = true
        break
      end
    end
    return(k63)
  end
  nexus["lumen/runtime"]["keys?"] = keys63
  local function empty63(t)
    local e63 = true
    local _g44 = t
    local _g22 = nil
    for _g22 in next, _g44 do
      local _g23 = _g44[_g22]
      e63 = false
      break
    end
    return(e63)
  end
  nexus["lumen/runtime"]["empty?"] = empty63
  local function stash(args)
    if keys63(args) then
      local p = {_stash = true}
      local _g46 = args
      local k = nil
      for k in next, _g46 do
        if not number63(k) then
          local v = _g46[k]
          p[k] = v
        end
      end
      return(join(args, {p}))
    else
      return(args)
    end
  end
  nexus["lumen/runtime"].stash = stash
  local function unstash(args)
    if none63(args) then
      return({})
    else
      local l = last(args)
      if table63(l) and l._stash then
        local args1 = sub(args, 0, length(args) - 1)
        local _g47 = l
        local k = nil
        for k in next, _g47 do
          if not number63(k) then
            local v = _g47[k]
            if not (k == "_stash") then
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
  nexus["lumen/runtime"].unstash = unstash
  local function search(str, pattern, start)
    local _g63
    if start then
      _g63 = start + 1
    end
    local _g48 = _g63
    local i = string.find(str, pattern, _g48, true)
    return(i and i - 1)
  end
  nexus["lumen/runtime"].search = search
  local function split(str, sep)
    if str == "" or sep == "" then
      return({})
    else
      local strs = {}
      while true do
        local i = search(str, sep)
        if nil63(i) then
          break
        else
          add(strs, sub(str, 0, i))
          str = sub(str, i + 1)
        end
      end
      add(strs, str)
      return(strs)
    end
  end
  nexus["lumen/runtime"].split = split
  local function cat(...)
    local xs = unstash({...})
    local _g49 = sub(xs, 0)
    if none63(_g49) then
      return("")
    else
      return(reduce(function (a, b)
        return(a .. b)
      end, _g49))
    end
  end
  nexus["lumen/runtime"].cat = cat
  local function _43(...)
    local xs = unstash({...})
    local _g50 = sub(xs, 0)
    return(reduce(function (a, b)
      return(a + b)
    end, _g50))
  end
  nexus["lumen/runtime"]["+"] = _43
  local function _(...)
    local xs = unstash({...})
    local _g51 = sub(xs, 0)
    return(reduce(function (b, a)
      return(a - b)
    end, reverse(_g51)))
  end
  nexus["lumen/runtime"]["-"] = _
  local function _42(...)
    local xs = unstash({...})
    local _g52 = sub(xs, 0)
    return(reduce(function (a, b)
      return(a * b)
    end, _g52))
  end
  nexus["lumen/runtime"]["*"] = _42
  local function _47(...)
    local xs = unstash({...})
    local _g53 = sub(xs, 0)
    return(reduce(function (b, a)
      return(a / b)
    end, reverse(_g53)))
  end
  nexus["lumen/runtime"]["/"] = _47
  local function _37(...)
    local xs = unstash({...})
    local _g54 = sub(xs, 0)
    return(reduce(function (b, a)
      return(a % b)
    end, reverse(_g54)))
  end
  nexus["lumen/runtime"]["%"] = _37
  local function _62(a, b)
    return(a > b)
  end
  nexus["lumen/runtime"][">"] = _62
  local function _60(a, b)
    return(a < b)
  end
  nexus["lumen/runtime"]["<"] = _60
  local function _61(a, b)
    return(a == b)
  end
  nexus["lumen/runtime"]["="] = _61
  local function _6261(a, b)
    return(a >= b)
  end
  nexus["lumen/runtime"][">="] = _6261
  local function _6061(a, b)
    return(a <= b)
  end
  nexus["lumen/runtime"]["<="] = _6061
  local function read_file(path)
    local f = io.open(path)
    return(f.read(f, "*a"))
  end
  nexus["lumen/runtime"]["read-file"] = read_file
  local function write_file(path, data)
    local f = io.open(path, "w")
    return(f.write(f, data))
  end
  nexus["lumen/runtime"]["write-file"] = write_file
  local function write(x)
    return(io.write(x))
  end
  nexus["lumen/runtime"].write = write
  local function exit(code)
    return(os.exit(code))
  end
  nexus["lumen/runtime"].exit = exit
  local function today()
    return(os.date("!%F"))
  end
  nexus["lumen/runtime"].today = today
  local function now()
    return(os.time())
  end
  nexus["lumen/runtime"].now = now
  local function number(str)
    return(tonumber(str))
  end
  nexus["lumen/runtime"].number = number
  local function string(x)
    if nil63(x) then
      return("nil")
    else
      if boolean63(x) then
        if x then
          return("true")
        else
          return("false")
        end
      else
        if function63(x) then
          return("#<function>")
        else
          if atom63(x) then
            return(x .. "")
          else
            local str = "("
            local x1 = sub(x)
            local _g55 = x
            local k = nil
            for k in next, _g55 do
              if not number63(k) then
                local v = _g55[k]
                add(x1, k .. ":")
                add(x1, v)
              end
            end
            local _g56 = x1
            local i = 0
            while i < length(_g56) do
              local y = _g56[i + 1]
              str = str .. string(y)
              if i < length(x1) - 1 then
                str = str .. " "
              end
              i = i + 1
            end
            return(str .. ")")
          end
        end
      end
    end
  end
  nexus["lumen/runtime"].string = string
  local function space(xs)
    local function string(x)
      if string_literal63(x) or list63(x) and hd(x) == "cat" then
        return(x)
      else
        return({"string", x})
      end
    end
    if one63(xs) then
      return(string(hd(xs)))
    else
      return(reduce(function (a, b)
        return({"cat", string(a), "\" \"", string(b)})
      end, xs))
    end
  end
  nexus["lumen/runtime"].space = space
  local function apply(f, args)
    local _g57 = stash(args)
    return(f(unpack(_g57)))
  end
  nexus["lumen/runtime"].apply = apply
  local id_count = 0
  nexus["lumen/runtime"]["id-count"] = id_count
  local function make_id()
    id_count = id_count + 1
    return("_g" .. id_count)
  end
  nexus["lumen/runtime"]["make-id"] = make_id
  local function _37message_handler(msg)
    local i = search(msg, ": ")
    return(sub(msg, i + 2))
  end
  nexus["lumen/runtime"]["%message-handler"] = _37message_handler
  local function toplevel63()
    return(one63(environment))
  end
  nexus["lumen/runtime"]["toplevel?"] = toplevel63
  local function module_key(spec)
    if atom63(spec) then
      return(string(spec))
    else
      return(reduce(function (a, b)
        return(module_key(a) .. "/" .. module_key(b))
      end, spec))
    end
  end
  nexus["lumen/runtime"]["module-key"] = module_key
  local function module(spec)
    return(modules[module_key(spec)])
  end
  nexus["lumen/runtime"].module = module
  local function setenv(k, ...)
    local keys = unstash({...})
    local _g58 = sub(keys, 0)
    if string63(k) then
      local frame = last(environment)
      local x = frame[k] or {}
      local _g59 = _g58
      local k1 = nil
      for k1 in next, _g59 do
        if not number63(k1) then
          local v = _g59[k1]
          x[k1] = v
        end
      end
      if toplevel63() then
        local m = module(current_module)
        m.export[k] = x
      end
      frame[k] = x
    end
  end
  nexus["lumen/runtime"].setenv = setenv
end)();
(function ()
  nexus["lumen/lib"] = {}
  local _g67 = nexus["lumen/runtime"]
  local nil63 = _g67["nil?"]
  local is63 = _g67["is?"]
  local length = _g67.length
  local none63 = _g67["none?"]
  local some63 = _g67["some?"]
  local one63 = _g67["one?"]
  local hd = _g67.hd
  local string63 = _g67["string?"]
  local number63 = _g67["number?"]
  local boolean63 = _g67["boolean?"]
  local function63 = _g67["function?"]
  local composite63 = _g67["composite?"]
  local atom63 = _g67["atom?"]
  local table63 = _g67["table?"]
  local list63 = _g67["list?"]
  local substring = _g67.substring
  local sub = _g67.sub
  local inner = _g67.inner
  local tl = _g67.tl
  local char = _g67.char
  local code = _g67.code
  local string_literal63 = _g67["string-literal?"]
  local id_literal63 = _g67["id-literal?"]
  local add = _g67.add
  local drop = _g67.drop
  local last = _g67.last
  local reverse = _g67.reverse
  local join = _g67.join
  local reduce = _g67.reduce
  local keep = _g67.keep
  local in63 = _g67["in?"]
  local find = _g67.find
  local pair = _g67.pair
  local sort = _g67.sort
  local iterate = _g67.iterate
  local replicate = _g67.replicate
  local series = _g67.series
  local map = _g67.map
  local keys63 = _g67["keys?"]
  local empty63 = _g67["empty?"]
  local stash = _g67.stash
  local unstash = _g67.unstash
  local search = _g67.search
  local split = _g67.split
  local cat = _g67.cat
  local _43 = _g67["+"]
  local _ = _g67["-"]
  local _42 = _g67["*"]
  local _47 = _g67["/"]
  local _37 = _g67["%"]
  local _62 = _g67[">"]
  local _60 = _g67["<"]
  local _61 = _g67["="]
  local _6261 = _g67[">="]
  local _6061 = _g67["<="]
  local read_file = _g67["read-file"]
  local write_file = _g67["write-file"]
  local write = _g67.write
  local exit = _g67.exit
  local today = _g67.today
  local now = _g67.now
  local number = _g67.number
  local string = _g67.string
  local space = _g67.space
  local apply = _g67.apply
  local make_id = _g67["make-id"]
  local _37message_handler = _g67["%message-handler"]
  local toplevel63 = _g67["toplevel?"]
  local module_key = _g67["module-key"]
  local module = _g67.module
  local setenv = _g67.setenv
  local function getenv(k, p)
    if string63(k) then
      local b = find(function (e)
        return(e[k])
      end, reverse(environment))
      if is63(b) then
        if p then
          return(b[p])
        else
          return(b)
        end
      end
    end
  end
  nexus["lumen/lib"].getenv = getenv
  local function macro_function(k)
    return(getenv(k, "macro"))
  end
  nexus["lumen/lib"]["macro-function"] = macro_function
  local function macro63(k)
    return(is63(macro_function(k)))
  end
  nexus["lumen/lib"]["macro?"] = macro63
  local function special63(k)
    return(is63(getenv(k, "special")))
  end
  nexus["lumen/lib"]["special?"] = special63
  local function special_form63(form)
    return(list63(form) and special63(hd(form)))
  end
  nexus["lumen/lib"]["special-form?"] = special_form63
  local function statement63(k)
    return(special63(k) and getenv(k, "stmt"))
  end
  nexus["lumen/lib"]["statement?"] = statement63
  local function symbol_expansion(k)
    return(getenv(k, "symbol"))
  end
  nexus["lumen/lib"]["symbol-expansion"] = symbol_expansion
  local function symbol63(k)
    return(is63(symbol_expansion(k)))
  end
  nexus["lumen/lib"]["symbol?"] = symbol63
  local function variable63(k)
    local b = find(function (frame)
      return(frame[k] or frame._scope)
    end, reverse(environment))
    return(table63(b) and is63(b.variable))
  end
  nexus["lumen/lib"]["variable?"] = variable63
  local function global63(k)
    return(getenv(k, "global"))
  end
  nexus["lumen/lib"]["global?"] = global63
  local function bound63(x)
    return(macro63(x) or special63(x) or symbol63(x) or variable63(x) or global63(x))
  end
  nexus["lumen/lib"]["bound?"] = bound63
  local function escape(str)
    local str1 = "\""
    local i = 0
    while i < length(str) do
      local c = char(str, i)
      local _g105
      if c == "\n" then
        _g105 = "\\n"
      else
        local _g106
        if c == "\"" then
          _g106 = "\\\""
        else
          local _g107
          if c == "\\" then
            _g107 = "\\\\"
          else
            _g107 = c
          end
          _g106 = _g107
        end
        _g105 = _g106
      end
      local c1 = _g105
      str1 = str1 .. c1
      i = i + 1
    end
    return(str1 .. "\"")
  end
  nexus["lumen/lib"].escape = escape
  local function quoted(form)
    if string63(form) then
      return(escape(form))
    else
      if atom63(form) then
        return(form)
      else
        return(join({"list"}, map(quoted, form)))
      end
    end
  end
  nexus["lumen/lib"].quoted = quoted
  local function literal(s)
    if string_literal63(s) then
      return(s)
    else
      return(quoted(s))
    end
  end
  nexus["lumen/lib"].literal = literal
  local function stash42(args)
    if keys63(args) then
      local l = {"%object", "\"_stash\"", true}
      local _g70 = args
      local k = nil
      for k in next, _g70 do
        if not number63(k) then
          local v = _g70[k]
          add(l, literal(k))
          add(l, v)
        end
      end
      return(join(args, {l}))
    else
      return(args)
    end
  end
  nexus["lumen/lib"]["stash*"] = stash42
  local function bind(lh, rh)
    if composite63(lh) and list63(rh) then
      local id = make_id()
      return(join({{id, rh}}, bind(lh, id)))
    else
      if atom63(lh) then
        return({{lh, rh}})
      else
        local bs = {}
        local r = lh.rest
        local _g71 = lh
        local i = 0
        while i < length(_g71) do
          local x = _g71[i + 1]
          bs = join(bs, bind(x, {"at", rh, i}))
          i = i + 1
        end
        if r then
          bs = join(bs, bind(r, {"sub", rh, length(lh)}))
        end
        local _g72 = lh
        local k = nil
        for k in next, _g72 do
          if not number63(k) then
            local v = _g72[k]
            if v == true then
              v = k
            end
            if not (k == "rest") then
              bs = join(bs, bind(v, {"get", rh, {"quote", k}}))
            end
          end
        end
        return(bs)
      end
    end
  end
  nexus["lumen/lib"].bind = bind
  local function bind42(args, body)
    local args1 = {}
    local function rest()
      if target == "js" then
        return({"unstash", {{"get", {"get", {"get", "Array", {"quote", "prototype"}}, {"quote", "slice"}}, {"quote", "call"}}, "arguments", length(args1)}})
      else
        add(args1, "|...|")
        return({"unstash", {"list", "|...|"}})
      end
    end
    if atom63(args) then
      return({args1, {join({"let", {args, rest()}}, body)}})
    else
      local bs = {}
      local r = args.rest or keys63(args) and make_id()
      local _g73 = args
      local _g74 = 0
      while _g74 < length(_g73) do
        local arg = _g73[_g74 + 1]
        if atom63(arg) then
          add(args1, arg)
        else
          if list63(arg) or keys63(arg) then
            local v = make_id()
            add(args1, v)
            bs = join(bs, {arg, v})
          end
        end
        _g74 = _g74 + 1
      end
      if r then
        bs = join(bs, {r, rest()})
      end
      if keys63(args) then
        bs = join(bs, {sub(args, length(args)), r})
      end
      if none63(bs) then
        return({args1, body})
      else
        return({args1, {join({"let", bs}, body)}})
      end
    end
  end
  nexus["lumen/lib"]["bind*"] = bind42
  local function quoting63(depth)
    return(number63(depth))
  end
  nexus["lumen/lib"]["quoting?"] = quoting63
  local function quasiquoting63(depth)
    return(quoting63(depth) and depth > 0)
  end
  nexus["lumen/lib"]["quasiquoting?"] = quasiquoting63
  local function can_unquote63(depth)
    return(quoting63(depth) and depth == 1)
  end
  nexus["lumen/lib"]["can-unquote?"] = can_unquote63
  local function quasisplice63(x, depth)
    return(list63(x) and can_unquote63(depth) and hd(x) == "unquote-splicing")
  end
  nexus["lumen/lib"]["quasisplice?"] = quasisplice63
  local function macroexpand(form)
    if symbol63(form) then
      return(macroexpand(symbol_expansion(form)))
    else
      if atom63(form) then
        return(form)
      else
        local x = hd(form)
        if x == "%local" then
          local _g64 = form[1]
          local name = form[2]
          local value = form[3]
          return({"%local", name, macroexpand(value)})
        else
          if x == "%function" then
            local _g65 = form[1]
            local args = form[2]
            local body = sub(form, 2)
            add(environment, {_scope = true})
            local _g77 = args
            local _g78 = 0
            while _g78 < length(_g77) do
              local _g75 = _g77[_g78 + 1]
              setenv(_g75, {_stash = true, variable = true})
              _g78 = _g78 + 1
            end
            local _g76 = join({"%function", args}, macroexpand(body))
            drop(environment)
            return(_g76)
          else
            if x == "%local-function" or x == "%global-function" then
              local _g66 = form[1]
              local _g79 = form[2]
              local _g80 = form[3]
              local _g81 = sub(form, 3)
              add(environment, {_scope = true})
              local _g84 = _g80
              local _g85 = 0
              while _g85 < length(_g84) do
                local _g82 = _g84[_g85 + 1]
                setenv(_g82, {_stash = true, variable = true})
                _g85 = _g85 + 1
              end
              local _g83 = join({x, _g79, _g80}, macroexpand(_g81))
              drop(environment)
              return(_g83)
            else
              if macro63(x) then
                return(macroexpand(apply(macro_function(x), tl(form))))
              else
                return(map(macroexpand, form))
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/lib"].macroexpand = macroexpand
  local quasiexpand
  nexus["lumen/lib"].quasiexpand = quasiexpand
  local quasiquote_list
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list
  quasiquote_list = function (form, depth)
    local xs = {{"list"}}
    local _g86 = form
    local k = nil
    for k in next, _g86 do
      if not number63(k) then
        local v = _g86[k]
        local _g108
        if quasisplice63(v, depth) then
          _g108 = quasiexpand(v[2])
        else
          _g108 = quasiexpand(v, depth)
        end
        local _g87 = _g108
        last(xs)[k] = _g87
      end
    end
    local _g88 = form
    local _g89 = 0
    while _g89 < length(_g88) do
      local x = _g88[_g89 + 1]
      if quasisplice63(x, depth) then
        local _g90 = quasiexpand(x[2])
        add(xs, _g90)
        add(xs, {"list"})
      else
        add(last(xs), quasiexpand(x, depth))
      end
      _g89 = _g89 + 1
    end
    local pruned = keep(function (x)
      return(length(x) > 1 or not (hd(x) == "list") or keys63(x))
    end, xs)
    return(join({"join*"}, pruned))
  end
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list
  quasiexpand = function (form, depth)
    if quasiquoting63(depth) then
      if atom63(form) then
        return({"quote", form})
      else
        if can_unquote63(depth) and hd(form) == "unquote" then
          return(quasiexpand(form[2]))
        else
          if hd(form) == "unquote" or hd(form) == "unquote-splicing" then
            return(quasiquote_list(form, depth - 1))
          else
            if hd(form) == "quasiquote" then
              return(quasiquote_list(form, depth + 1))
            else
              return(quasiquote_list(form, depth))
            end
          end
        end
      end
    else
      if atom63(form) then
        return(form)
      else
        if hd(form) == "quote" then
          return(form)
        else
          if hd(form) == "quasiquote" then
            return(quasiexpand(form[2], 1))
          else
            return(map(function (x)
              return(quasiexpand(x, depth))
            end, form))
          end
        end
      end
    end
  end
  nexus["lumen/lib"].quasiexpand = quasiexpand
  indent_level = 0
  local function indentation()
    return(apply(cat, replicate(indent_level, "  ")))
  end
  nexus["lumen/lib"].indentation = indentation
  local reserved = {["="] = true, ["=="] = true, ["+"] = true, ["-"] = true, ["%"] = true, ["*"] = true, ["/"] = true, ["<"] = true, [">"] = true, ["<="] = true, [">="] = true, ["break"] = true, ["case"] = true, ["catch"] = true, ["continue"] = true, ["debugger"] = true, ["default"] = true, ["delete"] = true, ["do"] = true, ["else"] = true, ["finally"] = true, ["for"] = true, ["function"] = true, ["if"] = true, ["in"] = true, ["instanceof"] = true, ["new"] = true, ["return"] = true, ["switch"] = true, ["this"] = true, ["throw"] = true, ["try"] = true, ["typeof"] = true, ["var"] = true, ["void"] = true, ["with"] = true, ["and"] = true, ["end"] = true, ["repeat"] = true, ["while"] = true, ["false"] = true, ["local"] = true, ["nil"] = true, ["then"] = true, ["not"] = true, ["true"] = true, ["elseif"] = true, ["or"] = true, ["until"] = true}
  nexus["lumen/lib"].reserved = reserved
  local function reserved63(x)
    return(reserved[x])
  end
  nexus["lumen/lib"]["reserved?"] = reserved63
  local function numeric63(n)
    return(n > 47 and n < 58)
  end
  nexus["lumen/lib"]["numeric?"] = numeric63
  local function valid_code63(n)
    return(numeric63(n) or n > 64 and n < 91 or n > 96 and n < 123 or n == 95)
  end
  nexus["lumen/lib"]["valid-code?"] = valid_code63
  local function valid_id63(id)
    if none63(id) or reserved63(id) then
      return(false)
    else
      local i = 0
      while i < length(id) do
        if not valid_code63(code(id, i)) then
          return(false)
        end
        i = i + 1
      end
      return(true)
    end
  end
  nexus["lumen/lib"]["valid-id?"] = valid_id63
  local function id(id)
    local id1 = ""
    local i = 0
    while i < length(id) do
      local c = char(id, i)
      local n = code(c)
      local _g109
      if c == "-" then
        _g109 = "_"
      else
        local _g110
        if valid_code63(n) then
          _g110 = c
        else
          local _g111
          if i == 0 then
            _g111 = "_" .. n
          else
            _g111 = n
          end
          _g110 = _g111
        end
        _g109 = _g110
      end
      local c1 = _g109
      id1 = id1 .. c1
      i = i + 1
    end
    return(id1)
  end
  nexus["lumen/lib"].id = id
  local function key(k)
    local function wrap(s)
      if target == "lua" then
        return("[" .. s .. "]")
      else
        return(s)
      end
    end
    local i = inner(k)
    if valid_id63(i) then
      return(i)
    else
      return(wrap(k))
    end
  end
  nexus["lumen/lib"].key = key
  local function imported(spec, ...)
    local _g95 = unstash({...})
    local _g96 = _g95.all
    local m = make_id()
    local k = module_key(spec)
    local imports = {}
    if nexus[k] then
      local _g97 = module(spec).export
      local n = nil
      for n in next, _g97 do
        if not number63(n) then
          local b = _g97[n]
          if b.variable and (_g96 or b.export) then
            add(imports, {"%local", n, {"get", m, {"quote", n}}})
          end
        end
      end
    end
    if some63(imports) then
      return(join({{"%local", m, {"get", "nexus", {"quote", k}}}}, imports))
    end
  end
  nexus["lumen/lib"].imported = imported
  local function link(name, form)
    if toplevel63() then
      local k = module_key(current_module)
      return({"do", form, {"set", {"get", {"get", "nexus", {"quote", k}}, {"quote", name}}, name}})
    else
      return(form)
    end
  end
  nexus["lumen/lib"].link = link
  local function extend(t, ...)
    local xs = unstash({...})
    local _g98 = sub(xs, 0)
    return(join(t, _g98))
  end
  nexus["lumen/lib"].extend = extend
  local function exclude(t, ...)
    local keys = unstash({...})
    local _g99 = sub(keys, 0)
    local t1 = {}
    local _g100 = t
    local _g101 = 0
    while _g101 < length(_g100) do
      local x = _g100[_g101 + 1]
      add(t1, x)
      _g101 = _g101 + 1
    end
    local _g102 = t
    local k = nil
    for k in next, _g102 do
      if not number63(k) then
        local v = _g102[k]
        if not _g99[k] then
          t1[k] = v
        end
      end
    end
    return(t1)
  end
  nexus["lumen/lib"].exclude = exclude
  local function quote_binding(b)
    if is63(b.symbol) then
      return(extend(b, {_stash = true, symbol = {"quote", b.symbol}}))
    else
      if b.macro and b.form then
        return(exclude(extend(b, {_stash = true, macro = b.form}), {_stash = true, form = true}))
      else
        if b.special and b.form then
          return(exclude(extend(b, {_stash = true, special = b.form}), {_stash = true, form = true}))
        else
          if is63(b.variable) then
            return(b)
          else
            if is63(b.global) then
              return(b)
            end
          end
        end
      end
    end
  end
  nexus["lumen/lib"]["quote-binding"] = quote_binding
  local function mapo(f, t)
    local o = {}
    local _g103 = t
    local k = nil
    for k in next, _g103 do
      if not number63(k) then
        local v = _g103[k]
        local x = f(v)
        if is63(x) then
          add(o, literal(k))
          add(o, x)
        end
      end
    end
    return(o)
  end
  nexus["lumen/lib"].mapo = mapo
  local function quote_frame(t)
    return(join({"%object"}, mapo(function (b)
      return(join({"table"}, quote_binding(b)))
    end, t)))
  end
  nexus["lumen/lib"]["quote-frame"] = quote_frame
  local function quote_environment(env)
    return(join({"list"}, map(quote_frame, env)))
  end
  nexus["lumen/lib"]["quote-environment"] = quote_environment
  local function quote_module(m)
    local _g104 = {"table"}
    _g104.import = quoted(m.import)
    _g104.alias = quoted(m.alias)
    _g104.export = quote_frame(m.export)
    return(_g104)
  end
  nexus["lumen/lib"]["quote-module"] = quote_module
  local function quote_modules()
    return(join({"table"}, map(quote_module, modules)))
  end
  nexus["lumen/lib"]["quote-modules"] = quote_modules
  local function initial_environment()
    return({{["define-module"] = getenv("define-module")}})
  end
  nexus["lumen/lib"]["initial-environment"] = initial_environment
end)();
(function ()
  nexus["lumen/reader"] = {}
  local _g112 = nexus["lumen/runtime"]
  local nil63 = _g112["nil?"]
  local is63 = _g112["is?"]
  local length = _g112.length
  local none63 = _g112["none?"]
  local some63 = _g112["some?"]
  local one63 = _g112["one?"]
  local hd = _g112.hd
  local string63 = _g112["string?"]
  local number63 = _g112["number?"]
  local boolean63 = _g112["boolean?"]
  local function63 = _g112["function?"]
  local composite63 = _g112["composite?"]
  local atom63 = _g112["atom?"]
  local table63 = _g112["table?"]
  local list63 = _g112["list?"]
  local substring = _g112.substring
  local sub = _g112.sub
  local inner = _g112.inner
  local tl = _g112.tl
  local char = _g112.char
  local code = _g112.code
  local string_literal63 = _g112["string-literal?"]
  local id_literal63 = _g112["id-literal?"]
  local add = _g112.add
  local drop = _g112.drop
  local last = _g112.last
  local reverse = _g112.reverse
  local join = _g112.join
  local reduce = _g112.reduce
  local keep = _g112.keep
  local in63 = _g112["in?"]
  local find = _g112.find
  local pair = _g112.pair
  local sort = _g112.sort
  local iterate = _g112.iterate
  local replicate = _g112.replicate
  local series = _g112.series
  local map = _g112.map
  local keys63 = _g112["keys?"]
  local empty63 = _g112["empty?"]
  local stash = _g112.stash
  local unstash = _g112.unstash
  local search = _g112.search
  local split = _g112.split
  local cat = _g112.cat
  local _43 = _g112["+"]
  local _ = _g112["-"]
  local _42 = _g112["*"]
  local _47 = _g112["/"]
  local _37 = _g112["%"]
  local _62 = _g112[">"]
  local _60 = _g112["<"]
  local _61 = _g112["="]
  local _6261 = _g112[">="]
  local _6061 = _g112["<="]
  local read_file = _g112["read-file"]
  local write_file = _g112["write-file"]
  local write = _g112.write
  local exit = _g112.exit
  local today = _g112.today
  local now = _g112.now
  local number = _g112.number
  local string = _g112.string
  local space = _g112.space
  local apply = _g112.apply
  local make_id = _g112["make-id"]
  local _37message_handler = _g112["%message-handler"]
  local toplevel63 = _g112["toplevel?"]
  local module_key = _g112["module-key"]
  local module = _g112.module
  local setenv = _g112.setenv
  local delimiters = {["("] = true, [")"] = true, [";"] = true, ["\n"] = true}
  nexus["lumen/reader"].delimiters = delimiters
  local whitespace = {[" "] = true, ["\t"] = true, ["\n"] = true}
  nexus["lumen/reader"].whitespace = whitespace
  local function make_stream(str)
    return({pos = 0, string = str, len = length(str)})
  end
  nexus["lumen/reader"]["make-stream"] = make_stream
  local function peek_char(s)
    if s.pos < s.len then
      return(char(s.string, s.pos))
    end
  end
  nexus["lumen/reader"]["peek-char"] = peek_char
  local function read_char(s)
    local c = peek_char(s)
    if c then
      s.pos = s.pos + 1
      return(c)
    end
  end
  nexus["lumen/reader"]["read-char"] = read_char
  local function skip_non_code(s)
    while true do
      local c = peek_char(s)
      if nil63(c) then
        break
      else
        if whitespace[c] then
          read_char(s)
        else
          if c == ";" then
            while c and not (c == "\n") do
              c = read_char(s)
            end
            skip_non_code(s)
          else
            break
          end
        end
      end
    end
  end
  nexus["lumen/reader"]["skip-non-code"] = skip_non_code
  local read_table = {}
  nexus["lumen/reader"]["read-table"] = read_table
  local eof = {}
  nexus["lumen/reader"].eof = eof
  local function read(s)
    skip_non_code(s)
    local c = peek_char(s)
    if is63(c) then
      return((read_table[c] or read_table[""])(s))
    else
      return(eof)
    end
  end
  nexus["lumen/reader"].read = read
  local function read_all(s)
    local l = {}
    while true do
      local form = read(s)
      if form == eof then
        break
      end
      add(l, form)
    end
    return(l)
  end
  nexus["lumen/reader"]["read-all"] = read_all
  local function read_from_string(str)
    local x = read(make_stream(str))
    if x ~= eof then
      return(x)
    end
  end
  nexus["lumen/reader"]["read-from-string"] = read_from_string
  local function key63(atom)
    return(string63(atom) and length(atom) > 1 and char(atom, length(atom) - 1) == ":")
  end
  nexus["lumen/reader"]["key?"] = key63
  local function flag63(atom)
    return(string63(atom) and length(atom) > 1 and char(atom, 0) == ":")
  end
  nexus["lumen/reader"]["flag?"] = flag63
  read_table[""] = function (s)
    local str = ""
    local dot63 = false
    while true do
      local c = peek_char(s)
      if c and (not whitespace[c] and not delimiters[c]) then
        if c == "." then
          dot63 = true
        end
        str = str .. c
        read_char(s)
      else
        break
      end
    end
    local n = number(str)
    if is63(n) then
      return(n)
    else
      if str == "true" then
        return(true)
      else
        if str == "false" then
          return(false)
        else
          if str == "_" then
            return(make_id())
          else
            if dot63 and not one63(str) then
              return(reduce(function (a, b)
                return({"get", b, {"quote", a}})
              end, reverse(split(str, "."))))
            else
              return(str)
            end
          end
        end
      end
    end
  end
  read_table["("] = function (s)
    read_char(s)
    local l = {}
    while true do
      skip_non_code(s)
      local c = peek_char(s)
      if c and not (c == ")") then
        local x = read(s)
        if key63(x) then
          local k = sub(x, 0, length(x) - 1)
          local v = read(s)
          l[k] = v
        else
          if flag63(x) then
            l[sub(x, 1)] = true
          else
            add(l, x)
          end
        end
      else
        if c then
          read_char(s)
          break
        else
          error("Expected ) at " .. s.pos)
        end
      end
    end
    return(l)
  end
  read_table[")"] = function (s)
    error("Unexpected ) at " .. s.pos)
  end
  read_table["\""] = function (s)
    read_char(s)
    local str = "\""
    while true do
      local c = peek_char(s)
      if c and not (c == "\"") then
        if c == "\\" then
          str = str .. read_char(s)
        end
        str = str .. read_char(s)
      else
        if c then
          read_char(s)
          break
        else
          error("Expected \" at " .. s.pos)
        end
      end
    end
    return(str .. "\"")
  end
  read_table["|"] = function (s)
    read_char(s)
    local str = "|"
    while true do
      local c = peek_char(s)
      if c and not (c == "|") then
        str = str .. read_char(s)
      else
        if c then
          read_char(s)
          break
        else
          error("Expected | at " .. s.pos)
        end
      end
    end
    return(str .. "|")
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
    if peek_char(s) == "@" then
      read_char(s)
      return({"unquote-splicing", read(s)})
    else
      return({"unquote", read(s)})
    end
  end
end)();
(function ()
  nexus["lumen/compiler"] = {}
  local _g123 = nexus["lumen/runtime"]
  local nil63 = _g123["nil?"]
  local is63 = _g123["is?"]
  local length = _g123.length
  local none63 = _g123["none?"]
  local some63 = _g123["some?"]
  local one63 = _g123["one?"]
  local hd = _g123.hd
  local string63 = _g123["string?"]
  local number63 = _g123["number?"]
  local boolean63 = _g123["boolean?"]
  local function63 = _g123["function?"]
  local composite63 = _g123["composite?"]
  local atom63 = _g123["atom?"]
  local table63 = _g123["table?"]
  local list63 = _g123["list?"]
  local substring = _g123.substring
  local sub = _g123.sub
  local inner = _g123.inner
  local tl = _g123.tl
  local char = _g123.char
  local code = _g123.code
  local string_literal63 = _g123["string-literal?"]
  local id_literal63 = _g123["id-literal?"]
  local add = _g123.add
  local drop = _g123.drop
  local last = _g123.last
  local reverse = _g123.reverse
  local join = _g123.join
  local reduce = _g123.reduce
  local keep = _g123.keep
  local in63 = _g123["in?"]
  local find = _g123.find
  local pair = _g123.pair
  local sort = _g123.sort
  local iterate = _g123.iterate
  local replicate = _g123.replicate
  local series = _g123.series
  local map = _g123.map
  local keys63 = _g123["keys?"]
  local empty63 = _g123["empty?"]
  local stash = _g123.stash
  local unstash = _g123.unstash
  local search = _g123.search
  local split = _g123.split
  local cat = _g123.cat
  local _43 = _g123["+"]
  local _ = _g123["-"]
  local _42 = _g123["*"]
  local _47 = _g123["/"]
  local _37 = _g123["%"]
  local _62 = _g123[">"]
  local _60 = _g123["<"]
  local _61 = _g123["="]
  local _6261 = _g123[">="]
  local _6061 = _g123["<="]
  local read_file = _g123["read-file"]
  local write_file = _g123["write-file"]
  local write = _g123.write
  local exit = _g123.exit
  local today = _g123.today
  local now = _g123.now
  local number = _g123.number
  local string = _g123.string
  local space = _g123.space
  local apply = _g123.apply
  local make_id = _g123["make-id"]
  local _37message_handler = _g123["%message-handler"]
  local toplevel63 = _g123["toplevel?"]
  local module_key = _g123["module-key"]
  local module = _g123.module
  local setenv = _g123.setenv
  local _g126 = nexus["lumen/lib"]
  local getenv = _g126.getenv
  local macro_function = _g126["macro-function"]
  local macro63 = _g126["macro?"]
  local special63 = _g126["special?"]
  local special_form63 = _g126["special-form?"]
  local statement63 = _g126["statement?"]
  local symbol_expansion = _g126["symbol-expansion"]
  local symbol63 = _g126["symbol?"]
  local variable63 = _g126["variable?"]
  local bound63 = _g126["bound?"]
  local quoted = _g126.quoted
  local stash42 = _g126["stash*"]
  local bind = _g126.bind
  local bind42 = _g126["bind*"]
  local quasiexpand = _g126.quasiexpand
  local macroexpand = _g126.macroexpand
  local indentation = _g126.indentation
  local reserved63 = _g126["reserved?"]
  local valid_id63 = _g126["valid-id?"]
  local id = _g126.id
  local key = _g126.key
  local imported = _g126.imported
  local link = _g126.link
  local mapo = _g126.mapo
  local quote_environment = _g126["quote-environment"]
  local quote_modules = _g126["quote-modules"]
  local initial_environment = _g126["initial-environment"]
  local _g127 = nexus["lumen/reader"]
  local make_stream = _g127["make-stream"]
  local read_table = _g127["read-table"]
  local read = _g127.read
  local read_all = _g127["read-all"]
  local read_from_string = _g127["read-from-string"]
  local _g131 = {}
  _g131.js = "!"
  _g131.lua = "not "
  local _g129 = {}
  local _g132 = {}
  _g132.js = "!"
  _g132.lua = "not "
  _g129["not"] = _g132
  local _g134 = {}
  _g134["*"] = true
  _g134["/"] = true
  _g134["%"] = true
  local _g136 = {}
  _g136["+"] = true
  _g136["-"] = true
  local _g140 = {}
  _g140.js = "+"
  _g140.lua = ".."
  local _g138 = {}
  local _g141 = {}
  _g141.js = "+"
  _g141.lua = ".."
  _g138.cat = _g141
  local _g143 = {}
  _g143["<"] = true
  _g143[">"] = true
  _g143["<="] = true
  _g143[">="] = true
  local _g147 = {}
  _g147.js = "==="
  _g147.lua = "=="
  local _g149 = {}
  _g149.js = "!="
  _g149.lua = "~="
  local _g145 = {}
  local _g150 = {}
  _g150.js = "==="
  _g150.lua = "=="
  _g145["="] = _g150
  local _g151 = {}
  _g151.js = "!="
  _g151.lua = "~="
  _g145["~="] = _g151
  local _g155 = {}
  _g155.js = "&&"
  _g155.lua = "and"
  local _g153 = {}
  local _g156 = {}
  _g156.js = "&&"
  _g156.lua = "and"
  _g153["and"] = _g156
  local _g160 = {}
  _g160.js = "||"
  _g160.lua = "or"
  local _g158 = {}
  local _g161 = {}
  _g161.js = "||"
  _g161.lua = "or"
  _g158["or"] = _g161
  local infix = {_g129, _g134, _g136, _g138, _g143, _g145, _g153, _g158}
  nexus["lumen/compiler"].infix = infix
  local function unary63(form)
    local op = form[1]
    local args = sub(form, 1)
    return(one63(args) and in63(op, {"not", "-"}))
  end
  nexus["lumen/compiler"]["unary?"] = unary63
  local function precedence(form)
    if list63(form) and not unary63(form) then
      local _g162 = infix
      local i = 0
      while i < length(_g162) do
        local level = _g162[i + 1]
        if level[hd(form)] then
          return(i)
        end
        i = i + 1
      end
    end
    return(0)
  end
  nexus["lumen/compiler"].precedence = precedence
  local function getop(op)
    return(find(function (level)
      local x = level[op]
      if x == true then
        return(op)
      else
        if is63(x) then
          return(x[target])
        end
      end
    end, infix))
  end
  nexus["lumen/compiler"].getop = getop
  local function infix63(x)
    return(is63(getop(x)))
  end
  nexus["lumen/compiler"]["infix?"] = infix63
  local compile
  nexus["lumen/compiler"].compile = compile
  local function compile_args(args)
    local str = "("
    local _g163 = args
    local i = 0
    while i < length(_g163) do
      local arg = _g163[i + 1]
      str = str .. compile(arg)
      if i < length(args) - 1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(str .. ")")
  end
  nexus["lumen/compiler"]["compile-args"] = compile_args
  local function compile_atom(x)
    if x == "nil" and target == "lua" then
      return(x)
    else
      if x == "nil" then
        return("undefined")
      else
        if id_literal63(x) then
          return(inner(x))
        else
          if string_literal63(x) then
            return(x)
          else
            if string63(x) then
              return(id(x))
            else
              if boolean63(x) then
                if x then
                  return("true")
                else
                  return("false")
                end
              else
                if number63(x) then
                  return(x .. "")
                else
                  error("Cannot compile atom: " .. string(x))
                end
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/compiler"]["compile-atom"] = compile_atom
  local function terminator(stmt63)
    if not stmt63 then
      return("")
    else
      if target == "js" then
        return(";\n")
      else
        return("\n")
      end
    end
  end
  nexus["lumen/compiler"].terminator = terminator
  local function compile_special(form, stmt63)
    local x = form[1]
    local args = sub(form, 1)
    local _g164 = getenv(x)
    local special = _g164.special
    local stmt = _g164.stmt
    local self_tr63 = _g164.tr
    local tr = terminator(stmt63 and not self_tr63)
    return(apply(special, args) .. tr)
  end
  nexus["lumen/compiler"]["compile-special"] = compile_special
  local function parenthesize_call63(x)
    return(list63(x) and (hd(x) == "%function" or precedence(x) > 0))
  end
  nexus["lumen/compiler"]["parenthesize-call?"] = parenthesize_call63
  local function compile_call(form)
    local f = hd(form)
    local f1 = compile(f)
    local args = compile_args(stash42(tl(form)))
    if parenthesize_call63(f) then
      return("(" .. f1 .. ")" .. args)
    else
      return(f1 .. args)
    end
  end
  nexus["lumen/compiler"]["compile-call"] = compile_call
  local function op_delims(parent, child, ...)
    local _g165 = unstash({...})
    local right = _g165.right
    local _g194
    if right then
      _g194 = _6261
    else
      _g194 = _62
    end
    if _g194(precedence(child), precedence(parent)) then
      return({"(", ")"})
    else
      return({"", ""})
    end
  end
  nexus["lumen/compiler"]["op-delims"] = op_delims
  local function compile_infix(form)
    local op = form[1]
    local _g166 = sub(form, 1)
    local a = _g166[1]
    local b = _g166[2]
    local _g167 = op_delims(form, a)
    local ao = _g167[1]
    local ac = _g167[2]
    local _g168 = op_delims(form, b, {_stash = true, right = true})
    local bo = _g168[1]
    local bc = _g168[2]
    local _g169 = compile(a)
    local _g170 = compile(b)
    local _g171 = getop(op)
    if unary63(form) then
      return(_g171 .. ao .. _g169 .. ac)
    else
      return(ao .. _g169 .. ac .. " " .. _g171 .. " " .. bo .. _g170 .. bc)
    end
  end
  nexus["lumen/compiler"]["compile-infix"] = compile_infix
  local function compile_function(args, body, ...)
    local _g172 = unstash({...})
    local name = _g172.name
    local prefix = _g172.prefix
    local _g195
    if name then
      _g195 = compile(name)
    else
      _g195 = ""
    end
    local id = _g195
    local _g173 = prefix or ""
    local _g174 = compile_args(args)
    indent_level = indent_level + 1
    local _g176 = compile(body, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local _g175 = _g176
    local ind = indentation()
    local _g196
    if target == "js" then
      _g196 = ""
    else
      _g196 = "end"
    end
    local tr = _g196
    if name then
      tr = tr .. "\n"
    end
    if target == "js" then
      return("function " .. id .. _g174 .. " {\n" .. _g175 .. ind .. "}" .. tr)
    else
      return(_g173 .. "function " .. id .. _g174 .. "\n" .. _g175 .. ind .. tr)
    end
  end
  nexus["lumen/compiler"]["compile-function"] = compile_function
  local function can_return63(form)
    return(is63(form) and (atom63(form) or not (hd(form) == "return") and not statement63(hd(form))))
  end
  nexus["lumen/compiler"]["can-return?"] = can_return63
  compile = function (form, ...)
    local _g177 = unstash({...})
    local stmt = _g177.stmt
    if nil63(form) then
      return("")
    else
      if special_form63(form) then
        return(compile_special(form, stmt))
      else
        local tr = terminator(stmt)
        local _g197
        if stmt then
          _g197 = indentation()
        else
          _g197 = ""
        end
        local ind = _g197
        local _g198
        if atom63(form) then
          _g198 = compile_atom(form)
        else
          local _g199
          if infix63(hd(form)) then
            _g199 = compile_infix(form)
          else
            _g199 = compile_call(form)
          end
          _g198 = _g199
        end
        local _g178 = _g198
        return(ind .. _g178 .. tr)
      end
    end
  end
  nexus["lumen/compiler"].compile = compile
  local lower
  nexus["lumen/compiler"].lower = lower
  local function lower_statement(form, tail63)
    local hoist = {}
    local e = lower(form, hoist, true, tail63)
    if some63(hoist) and is63(e) then
      return(join({"do"}, join(hoist, {e})))
    else
      if is63(e) then
        return(e)
      else
        if length(hoist) > 1 then
          return(join({"do"}, hoist))
        else
          return(hd(hoist))
        end
      end
    end
  end
  nexus["lumen/compiler"]["lower-statement"] = lower_statement
  local function lower_body(body, tail63)
    return(lower_statement(join({"do"}, body), tail63))
  end
  nexus["lumen/compiler"]["lower-body"] = lower_body
  local function lower_do(args, hoist, stmt63, tail63)
    local _g179 = sub(args, 0, length(args) - 1)
    local _g180 = 0
    while _g180 < length(_g179) do
      local x = _g179[_g180 + 1]
      add(hoist, lower(x, hoist, stmt63))
      _g180 = _g180 + 1
    end
    local e = lower(last(args), hoist, stmt63, tail63)
    if tail63 and can_return63(e) then
      return({"return", e})
    else
      return(e)
    end
  end
  nexus["lumen/compiler"]["lower-do"] = lower_do
  local function lower_if(args, hoist, stmt63, tail63)
    local cond = args[1]
    local _g181 = args[2]
    local _g182 = args[3]
    if stmt63 or tail63 then
      local _g201
      if _g182 then
        _g201 = {lower_body({_g182}, tail63)}
      end
      return(add(hoist, join({"%if", lower(cond, hoist), lower_body({_g181}, tail63)}, _g201)))
    else
      local e = make_id()
      add(hoist, {"%local", e})
      local _g200
      if _g182 then
        _g200 = {lower({"set", e, _g182})}
      end
      add(hoist, join({"%if", lower(cond, hoist), lower({"set", e, _g181})}, _g200))
      return(e)
    end
  end
  nexus["lumen/compiler"]["lower-if"] = lower_if
  local function lower_short(x, args, hoist)
    local a = args[1]
    local b = args[2]
    local hoist1 = {}
    local b1 = lower(b, hoist1)
    if some63(hoist1) then
      local id = make_id()
      local _g202
      if x == "and" then
        _g202 = {"%if", id, b, id}
      else
        _g202 = {"%if", id, id, b}
      end
      return(lower({"do", {"%local", id, a}, _g202}, hoist))
    else
      return({x, lower(a, hoist), b1})
    end
  end
  nexus["lumen/compiler"]["lower-short"] = lower_short
  local function lower_try(args, hoist, tail63)
    return(add(hoist, {"%try", lower_body(args, tail63)}))
  end
  nexus["lumen/compiler"]["lower-try"] = lower_try
  local function lower_while(args, hoist)
    local c = args[1]
    local body = sub(args, 1)
    return(add(hoist, {"while", lower(c, hoist), lower_body(body)}))
  end
  nexus["lumen/compiler"]["lower-while"] = lower_while
  local function lower_for(args, hoist)
    local t = args[1]
    local k = args[2]
    local body = sub(args, 2)
    return(add(hoist, {"%for", lower(t, hoist), k, lower_body(body)}))
  end
  nexus["lumen/compiler"]["lower-for"] = lower_for
  local function lower_function(args)
    local a = args[1]
    local body = sub(args, 1)
    return({"%function", a, lower_body(body, true)})
  end
  nexus["lumen/compiler"]["lower-function"] = lower_function
  local function lower_definition(kind, args, hoist)
    local name = args[1]
    local _g183 = args[2]
    local body = sub(args, 2)
    return(add(hoist, {kind, name, _g183, lower_body(body, true)}))
  end
  nexus["lumen/compiler"]["lower-definition"] = lower_definition
  local function lower_call(form, hoist)
    local _g184 = map(function (x)
      return(lower(x, hoist))
    end, form)
    if some63(_g184) then
      return(_g184)
    end
  end
  nexus["lumen/compiler"]["lower-call"] = lower_call
  local function lower_infix63(form)
    return(infix63(hd(form)) and length(form) > 3)
  end
  nexus["lumen/compiler"]["lower-infix?"] = lower_infix63
  local function lower_infix(form, hoist)
    local x = form[1]
    local args = sub(form, 1)
    return(lower(reduce(function (a, b)
      return({x, b, a})
    end, reverse(args)), hoist))
  end
  nexus["lumen/compiler"]["lower-infix"] = lower_infix
  local function lower_special(form, hoist)
    local e = lower_call(form, hoist)
    if e then
      return(add(hoist, e))
    end
  end
  nexus["lumen/compiler"]["lower-special"] = lower_special
  lower = function (form, hoist, stmt63, tail63)
    if atom63(form) then
      return(form)
    else
      if empty63(form) then
        return({"%array"})
      else
        if nil63(hoist) then
          return(lower_statement(form))
        else
          if lower_infix63(form) then
            return(lower_infix(form, hoist))
          else
            local x = form[1]
            local args = sub(form, 1)
            if x == "do" then
              return(lower_do(args, hoist, stmt63, tail63))
            else
              if x == "%if" then
                return(lower_if(args, hoist, stmt63, tail63))
              else
                if x == "%try" then
                  return(lower_try(args, hoist, tail63))
                else
                  if x == "while" then
                    return(lower_while(args, hoist))
                  else
                    if x == "%for" then
                      return(lower_for(args, hoist))
                    else
                      if x == "%function" then
                        return(lower_function(args))
                      else
                        if in63(x, {"%local-function", "%global-function"}) then
                          return(lower_definition(x, args, hoist))
                        else
                          if in63(x, {"and", "or"}) then
                            return(lower_short(x, args, hoist))
                          else
                            if statement63(x) then
                              return(lower_special(form, hoist))
                            else
                              return(lower_call(form, hoist))
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/compiler"].lower = lower
  local function process(form)
    return(lower(macroexpand(form)))
  end
  nexus["lumen/compiler"].process = process
  current_module = nil
  local function module_path(spec)
    return(module_key(spec) .. ".l")
  end
  nexus["lumen/compiler"]["module-path"] = module_path
  local function encapsulate(body)
    return({{"%function", {}, process(join({"do"}, body))}})
  end
  nexus["lumen/compiler"].encapsulate = encapsulate
  local function compile_file(file)
    local str = read_file(file)
    local body = read_all(make_stream(str))
    local form = encapsulate(body)
    return(compile(form) .. ";\n")
  end
  nexus["lumen/compiler"]["compile-file"] = compile_file
  local function run(code)
    local f,e = load(code)
    if f then
      return(f())
    else
      error(e .. " in " .. code)
    end
  end
  nexus["lumen/compiler"].run = run
  local compiling63 = false
  nexus["lumen/compiler"]["compiling?"] = compiling63
  local compiler_output = ""
  nexus["lumen/compiler"]["compiler-output"] = compiler_output
  local function conclude(code)
    if compiling63 then
      compiler_output = compiler_output .. code
    else
      return(run(code))
    end
  end
  nexus["lumen/compiler"].conclude = conclude
  local function _37compile_module(spec)
    local path = module_path(spec)
    local mod0 = current_module
    local env0 = environment
    current_module = spec
    environment = initial_environment()
    local code = compile_file(path)
    current_module = mod0
    environment = env0
    return(conclude(code))
  end
  nexus["lumen/compiler"]["%compile-module"] = _37compile_module
  local function open_module(spec, ...)
    local _g185 = unstash({...})
    local _g186 = _g185.all
    local m = module(spec)
    local frame = last(environment)
    local _g187 = m.export
    local k = nil
    for k in next, _g187 do
      if not number63(k) then
        local v = _g187[k]
        if v.export or _g186 then
          frame[k] = v
        end
      end
    end
  end
  nexus["lumen/compiler"]["open-module"] = open_module
  local function load_module(spec, ...)
    local _g188 = unstash({...})
    local _g189 = _g188.all
    if not module(spec) then
      _37compile_module(spec)
    end
    return(open_module(spec, {_stash = true, all = _g189}))
  end
  nexus["lumen/compiler"]["load-module"] = load_module
  local function in_module(spec)
    load_module(spec, {_stash = true, all = true})
    local m = module(spec)
    series(open_module, m.import)
    current_module = spec
  end
  nexus["lumen/compiler"]["in-module"] = in_module
  local function import_modules(specs)
    local imports = {}
    local bindings = {}
    local _g190 = specs or {}
    local _g191 = 0
    while _g191 < length(_g190) do
      local spec = _g190[_g191 + 1]
      load_module(spec)
      local m = module(spec)
      if m.alias then
        local _g192 = import_modules(m.alias)
        local aliased = _g192[1]
        local bs = _g192[2]
        imports = join(imports, aliased)
        bindings = join(bindings, bs)
      else
        local _g193 = imported(spec)
        add(imports, spec)
        bindings = join(bindings, _g193)
      end
      _g191 = _g191 + 1
    end
    return({imports, bindings})
  end
  nexus["lumen/compiler"]["import-modules"] = import_modules
  local function compile_module(spec)
    compiling63 = true
    _37compile_module(spec)
    return(compiler_output)
  end
  nexus["lumen/compiler"]["compile-module"] = compile_module
  local function declare(form)
    return(conclude(compile(process(form), {_stash = true, stmt = true})))
  end
  nexus["lumen/compiler"].declare = declare
  local function reimported()
    local imports = {}
    local m = module(current_module)
    series(function (spec)
      imports = join(imports, imported(spec))
    end, m.import)
    return(join(imports, imported(current_module, {_stash = true, all = true})))
  end
  nexus["lumen/compiler"].reimported = reimported
  _37result = nil
  local function eval(form)
    local previous = target
    target = "lua"
    local body = join(reimported(), {{"set", "%result", form}})
    local code = compile(encapsulate(body))
    target = previous
    run(code)
    return(_37result)
  end
  nexus["lumen/compiler"].eval = eval
end)();
(function ()
  nexus["lumen/special"] = {}
  local _g203 = nexus["lumen/runtime"]
  local nil63 = _g203["nil?"]
  local is63 = _g203["is?"]
  local length = _g203.length
  local none63 = _g203["none?"]
  local some63 = _g203["some?"]
  local one63 = _g203["one?"]
  local hd = _g203.hd
  local string63 = _g203["string?"]
  local number63 = _g203["number?"]
  local boolean63 = _g203["boolean?"]
  local function63 = _g203["function?"]
  local composite63 = _g203["composite?"]
  local atom63 = _g203["atom?"]
  local table63 = _g203["table?"]
  local list63 = _g203["list?"]
  local substring = _g203.substring
  local sub = _g203.sub
  local inner = _g203.inner
  local tl = _g203.tl
  local char = _g203.char
  local code = _g203.code
  local string_literal63 = _g203["string-literal?"]
  local id_literal63 = _g203["id-literal?"]
  local add = _g203.add
  local drop = _g203.drop
  local last = _g203.last
  local reverse = _g203.reverse
  local join = _g203.join
  local reduce = _g203.reduce
  local keep = _g203.keep
  local in63 = _g203["in?"]
  local find = _g203.find
  local pair = _g203.pair
  local sort = _g203.sort
  local iterate = _g203.iterate
  local replicate = _g203.replicate
  local series = _g203.series
  local map = _g203.map
  local keys63 = _g203["keys?"]
  local empty63 = _g203["empty?"]
  local stash = _g203.stash
  local unstash = _g203.unstash
  local search = _g203.search
  local split = _g203.split
  local cat = _g203.cat
  local _43 = _g203["+"]
  local _ = _g203["-"]
  local _42 = _g203["*"]
  local _47 = _g203["/"]
  local _37 = _g203["%"]
  local _62 = _g203[">"]
  local _60 = _g203["<"]
  local _61 = _g203["="]
  local _6261 = _g203[">="]
  local _6061 = _g203["<="]
  local read_file = _g203["read-file"]
  local write_file = _g203["write-file"]
  local write = _g203.write
  local exit = _g203.exit
  local today = _g203.today
  local now = _g203.now
  local number = _g203.number
  local string = _g203.string
  local space = _g203.space
  local apply = _g203.apply
  local make_id = _g203["make-id"]
  local _37message_handler = _g203["%message-handler"]
  local toplevel63 = _g203["toplevel?"]
  local module_key = _g203["module-key"]
  local module = _g203.module
  local setenv = _g203.setenv
  local _g206 = nexus["lumen/lib"]
  local getenv = _g206.getenv
  local macro_function = _g206["macro-function"]
  local macro63 = _g206["macro?"]
  local special63 = _g206["special?"]
  local special_form63 = _g206["special-form?"]
  local statement63 = _g206["statement?"]
  local symbol_expansion = _g206["symbol-expansion"]
  local symbol63 = _g206["symbol?"]
  local variable63 = _g206["variable?"]
  local bound63 = _g206["bound?"]
  local quoted = _g206.quoted
  local stash42 = _g206["stash*"]
  local bind = _g206.bind
  local bind42 = _g206["bind*"]
  local quasiexpand = _g206.quasiexpand
  local macroexpand = _g206.macroexpand
  local indentation = _g206.indentation
  local reserved63 = _g206["reserved?"]
  local valid_id63 = _g206["valid-id?"]
  local id = _g206.id
  local key = _g206.key
  local imported = _g206.imported
  local link = _g206.link
  local mapo = _g206.mapo
  local quote_environment = _g206["quote-environment"]
  local quote_modules = _g206["quote-modules"]
  local initial_environment = _g206["initial-environment"]
  local _g207 = nexus["lumen/compiler"]
  local compile_function = _g207["compile-function"]
  local compile = _g207.compile
  local open_module = _g207["open-module"]
  local load_module = _g207["load-module"]
  local in_module = _g207["in-module"]
  local import_modules = _g207["import-modules"]
  local compile_module = _g207["compile-module"]
  local declare = _g207.declare
  local eval = _g207.eval
end)();
(function ()
  nexus["lumen/core"] = {}
  local _g381 = nexus["lumen/runtime"]
  local nil63 = _g381["nil?"]
  local is63 = _g381["is?"]
  local length = _g381.length
  local none63 = _g381["none?"]
  local some63 = _g381["some?"]
  local one63 = _g381["one?"]
  local hd = _g381.hd
  local string63 = _g381["string?"]
  local number63 = _g381["number?"]
  local boolean63 = _g381["boolean?"]
  local function63 = _g381["function?"]
  local composite63 = _g381["composite?"]
  local atom63 = _g381["atom?"]
  local table63 = _g381["table?"]
  local list63 = _g381["list?"]
  local substring = _g381.substring
  local sub = _g381.sub
  local inner = _g381.inner
  local tl = _g381.tl
  local char = _g381.char
  local code = _g381.code
  local string_literal63 = _g381["string-literal?"]
  local id_literal63 = _g381["id-literal?"]
  local add = _g381.add
  local drop = _g381.drop
  local last = _g381.last
  local reverse = _g381.reverse
  local join = _g381.join
  local reduce = _g381.reduce
  local keep = _g381.keep
  local in63 = _g381["in?"]
  local find = _g381.find
  local pair = _g381.pair
  local sort = _g381.sort
  local iterate = _g381.iterate
  local replicate = _g381.replicate
  local series = _g381.series
  local map = _g381.map
  local keys63 = _g381["keys?"]
  local empty63 = _g381["empty?"]
  local stash = _g381.stash
  local unstash = _g381.unstash
  local search = _g381.search
  local split = _g381.split
  local cat = _g381.cat
  local _43 = _g381["+"]
  local _ = _g381["-"]
  local _42 = _g381["*"]
  local _47 = _g381["/"]
  local _37 = _g381["%"]
  local _62 = _g381[">"]
  local _60 = _g381["<"]
  local _61 = _g381["="]
  local _6261 = _g381[">="]
  local _6061 = _g381["<="]
  local read_file = _g381["read-file"]
  local write_file = _g381["write-file"]
  local write = _g381.write
  local exit = _g381.exit
  local today = _g381.today
  local now = _g381.now
  local number = _g381.number
  local string = _g381.string
  local space = _g381.space
  local apply = _g381.apply
  local make_id = _g381["make-id"]
  local _37message_handler = _g381["%message-handler"]
  local toplevel63 = _g381["toplevel?"]
  local module_key = _g381["module-key"]
  local module = _g381.module
  local setenv = _g381.setenv
  local _g384 = nexus["lumen/lib"]
  local getenv = _g384.getenv
  local macro_function = _g384["macro-function"]
  local macro63 = _g384["macro?"]
  local special63 = _g384["special?"]
  local special_form63 = _g384["special-form?"]
  local statement63 = _g384["statement?"]
  local symbol_expansion = _g384["symbol-expansion"]
  local symbol63 = _g384["symbol?"]
  local variable63 = _g384["variable?"]
  local bound63 = _g384["bound?"]
  local quoted = _g384.quoted
  local stash42 = _g384["stash*"]
  local bind = _g384.bind
  local bind42 = _g384["bind*"]
  local quasiexpand = _g384.quasiexpand
  local macroexpand = _g384.macroexpand
  local indentation = _g384.indentation
  local reserved63 = _g384["reserved?"]
  local valid_id63 = _g384["valid-id?"]
  local id = _g384.id
  local key = _g384.key
  local imported = _g384.imported
  local link = _g384.link
  local mapo = _g384.mapo
  local quote_environment = _g384["quote-environment"]
  local quote_modules = _g384["quote-modules"]
  local initial_environment = _g384["initial-environment"]
  local _g385 = nexus["lumen/compiler"]
  local compile_function = _g385["compile-function"]
  local compile = _g385.compile
  local open_module = _g385["open-module"]
  local load_module = _g385["load-module"]
  local in_module = _g385["in-module"]
  local import_modules = _g385["import-modules"]
  local compile_module = _g385["compile-module"]
  local declare = _g385.declare
  local eval = _g385.eval
  target = "lua"
end)();
(function ()
  nexus["lumen/boot"] = {}
  local _g694 = nexus["lumen/runtime"]
  local nil63 = _g694["nil?"]
  local is63 = _g694["is?"]
  local length = _g694.length
  local none63 = _g694["none?"]
  local some63 = _g694["some?"]
  local one63 = _g694["one?"]
  local hd = _g694.hd
  local string63 = _g694["string?"]
  local number63 = _g694["number?"]
  local boolean63 = _g694["boolean?"]
  local function63 = _g694["function?"]
  local composite63 = _g694["composite?"]
  local atom63 = _g694["atom?"]
  local table63 = _g694["table?"]
  local list63 = _g694["list?"]
  local substring = _g694.substring
  local sub = _g694.sub
  local inner = _g694.inner
  local tl = _g694.tl
  local char = _g694.char
  local code = _g694.code
  local string_literal63 = _g694["string-literal?"]
  local id_literal63 = _g694["id-literal?"]
  local add = _g694.add
  local drop = _g694.drop
  local last = _g694.last
  local reverse = _g694.reverse
  local join = _g694.join
  local reduce = _g694.reduce
  local keep = _g694.keep
  local in63 = _g694["in?"]
  local find = _g694.find
  local pair = _g694.pair
  local sort = _g694.sort
  local iterate = _g694.iterate
  local replicate = _g694.replicate
  local series = _g694.series
  local map = _g694.map
  local keys63 = _g694["keys?"]
  local empty63 = _g694["empty?"]
  local stash = _g694.stash
  local unstash = _g694.unstash
  local search = _g694.search
  local split = _g694.split
  local cat = _g694.cat
  local _43 = _g694["+"]
  local _ = _g694["-"]
  local _42 = _g694["*"]
  local _47 = _g694["/"]
  local _37 = _g694["%"]
  local _62 = _g694[">"]
  local _60 = _g694["<"]
  local _61 = _g694["="]
  local _6261 = _g694[">="]
  local _6061 = _g694["<="]
  local read_file = _g694["read-file"]
  local write_file = _g694["write-file"]
  local write = _g694.write
  local exit = _g694.exit
  local today = _g694.today
  local now = _g694.now
  local number = _g694.number
  local string = _g694.string
  local space = _g694.space
  local apply = _g694.apply
  local make_id = _g694["make-id"]
  local _37message_handler = _g694["%message-handler"]
  local toplevel63 = _g694["toplevel?"]
  local module_key = _g694["module-key"]
  local module = _g694.module
  local setenv = _g694.setenv
  local _g697 = nexus["lumen/lib"]
  local getenv = _g697.getenv
  local macro_function = _g697["macro-function"]
  local macro63 = _g697["macro?"]
  local special63 = _g697["special?"]
  local special_form63 = _g697["special-form?"]
  local statement63 = _g697["statement?"]
  local symbol_expansion = _g697["symbol-expansion"]
  local symbol63 = _g697["symbol?"]
  local variable63 = _g697["variable?"]
  local bound63 = _g697["bound?"]
  local quoted = _g697.quoted
  local stash42 = _g697["stash*"]
  local bind = _g697.bind
  local bind42 = _g697["bind*"]
  local quasiexpand = _g697.quasiexpand
  local macroexpand = _g697.macroexpand
  local indentation = _g697.indentation
  local reserved63 = _g697["reserved?"]
  local valid_id63 = _g697["valid-id?"]
  local id = _g697.id
  local key = _g697.key
  local imported = _g697.imported
  local link = _g697.link
  local mapo = _g697.mapo
  local quote_environment = _g697["quote-environment"]
  local quote_modules = _g697["quote-modules"]
  local initial_environment = _g697["initial-environment"]
  local _g698 = nexus["lumen/compiler"]
  local compile_function = _g698["compile-function"]
  local compile = _g698.compile
  local open_module = _g698["open-module"]
  local load_module = _g698["load-module"]
  local in_module = _g698["in-module"]
  local import_modules = _g698["import-modules"]
  local compile_module = _g698["compile-module"]
  local declare = _g698.declare
  local eval = _g698.eval
  modules = {["lumen/boot"] = {export = {["%initial-environment"] = {macro = function ()
    return(quote_environment(initial_environment()))
  end}, ["%initial-modules"] = {macro = function ()
    return(quote_modules())
  end}, modules = {global = true, export = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, ["lumen/special"] = {export = {["do"] = {stmt = true, foo = true, tr = true, export = true, special = function (...)
    local forms = unstash({...})
    local str = ""
    local _g711 = forms
    local _g712 = 0
    while _g712 < length(_g711) do
      local x = _g711[_g712 + 1]
      str = str .. compile(x, {_stash = true, stmt = true})
      _g712 = _g712 + 1
    end
    return(str)
  end}, ["%if"] = {stmt = true, foo = true, tr = true, export = true, special = function (cond, cons, alt)
    local _g713 = compile(cond)
    indent_level = indent_level + 1
    local _g715 = compile(cons, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local _g714 = _g715
    local _g782
    if alt then
      indent_level = indent_level + 1
      local _g717 = compile(alt, {_stash = true, stmt = true})
      indent_level = indent_level - 1
      _g782 = _g717
    end
    local _g716 = _g782
    local ind = indentation()
    local str = ""
    if target == "js" then
      str = str .. ind .. "if (" .. _g713 .. ") {\n" .. _g714 .. ind .. "}"
    else
      str = str .. ind .. "if " .. _g713 .. " then\n" .. _g714
    end
    if _g716 and target == "js" then
      str = str .. " else {\n" .. _g716 .. ind .. "}"
    else
      if _g716 then
        str = str .. ind .. "else\n" .. _g716
      end
    end
    if target == "lua" then
      return(str .. ind .. "end\n")
    else
      return(str .. "\n")
    end
  end}, ["while"] = {stmt = true, foo = true, tr = true, export = true, special = function (cond, form)
    local _g718 = compile(cond)
    indent_level = indent_level + 1
    local _g719 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g719
    local ind = indentation()
    if target == "js" then
      return(ind .. "while (" .. _g718 .. ") {\n" .. body .. ind .. "}\n")
    else
      return(ind .. "while " .. _g718 .. " do\n" .. body .. ind .. "end\n")
    end
  end}, ["%for"] = {stmt = true, foo = true, tr = true, export = true, special = function (t, k, form)
    local _g720 = compile(t)
    local ind = indentation()
    indent_level = indent_level + 1
    local _g721 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g721
    if target == "lua" then
      return(ind .. "for " .. k .. " in next, " .. _g720 .. " do\n" .. body .. ind .. "end\n")
    else
      return(ind .. "for (" .. k .. " in " .. _g720 .. ") {\n" .. body .. ind .. "}\n")
    end
  end}, ["%try"] = {stmt = true, foo = true, tr = true, export = true, special = function (form)
    local ind = indentation()
    indent_level = indent_level + 1
    local _g722 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g722
    local e = make_id()
    local hf = {"return", {"%array", false, {"get", e, "\"message\""}}}
    indent_level = indent_level + 1
    local _g723 = compile(hf, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local h = _g723
    return(ind .. "try {\n" .. body .. ind .. "}\n" .. ind .. "catch (" .. e .. ") {\n" .. h .. ind .. "}\n")
  end}, ["break"] = {stmt = true, export = true, special = function ()
    return(indentation() .. "break")
  end, foo = true}, ["%function"] = {export = true, foo = true, special = function (args, body)
    return(compile_function(args, body))
  end}, ["%global-function"] = {stmt = true, foo = true, tr = true, export = true, special = function (name, args, body)
    if target == "lua" then
      local x = compile_function(args, body, {_stash = true, name = name})
      return(indentation() .. x)
    else
      return(compile({"set", name, {"%function", args, body}}, {_stash = true, stmt = true}))
    end
  end}, ["%local-function"] = {stmt = true, foo = true, tr = true, export = true, special = function (name, args, body)
    local x = compile_function(args, body, {_stash = true, name = name, prefix = "local "})
    return(indentation() .. x)
  end}, ["return"] = {stmt = true, export = true, special = function (x)
    local _g783
    if nil63(x) then
      _g783 = "return"
    else
      _g783 = "return(" .. compile(x) .. ")"
    end
    local _g724 = _g783
    return(indentation() .. _g724)
  end, foo = true}, error = {stmt = true, export = true, special = function (x)
    local _g784
    if target == "js" then
      _g784 = "throw new " .. compile({"Error", x})
    else
      _g784 = "error(" .. compile(x) .. ")"
    end
    local e = _g784
    return(indentation() .. e)
  end, foo = true}, ["%local"] = {stmt = true, export = true, special = function (name, value)
    local id = compile(name)
    local value1 = compile(value)
    local _g785
    if is63(value) then
      _g785 = " = " .. value1
    else
      _g785 = ""
    end
    local rh = _g785
    local _g786
    if target == "js" then
      _g786 = "var "
    else
      _g786 = "local "
    end
    local keyword = _g786
    local ind = indentation()
    return(ind .. keyword .. id .. rh)
  end, foo = true}, set = {stmt = true, export = true, special = function (lh, rh)
    local _g725 = compile(lh)
    local _g787
    if nil63(rh) then
      _g787 = "nil"
    else
      _g787 = rh
    end
    local _g726 = compile(_g787)
    return(indentation() .. _g725 .. " = " .. _g726)
  end, foo = true}, get = {export = true, foo = true, special = function (t, k)
    local _g727 = compile(t)
    local k1 = compile(k)
    if target == "lua" and char(_g727, 0) == "{" then
      _g727 = "(" .. _g727 .. ")"
    end
    if string_literal63(k) and valid_id63(inner(k)) then
      return(_g727 .. "." .. inner(k))
    else
      return(_g727 .. "[" .. k1 .. "]")
    end
  end}, ["not"] = {}, ["%array"] = {export = true, foo = true, special = function (...)
    local forms = unstash({...})
    local _g788
    if target == "lua" then
      _g788 = "{"
    else
      _g788 = "["
    end
    local open = _g788
    local _g789
    if target == "lua" then
      _g789 = "}"
    else
      _g789 = "]"
    end
    local close = _g789
    local str = ""
    local _g728 = forms
    local i = 0
    while i < length(_g728) do
      local x = _g728[i + 1]
      str = str .. compile(x)
      if i < length(forms) - 1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(open .. str .. close)
  end}, ["%object"] = {export = true, foo = true, special = function (...)
    local forms = unstash({...})
    local str = "{"
    local _g790
    if target == "lua" then
      _g790 = " = "
    else
      _g790 = ": "
    end
    local sep = _g790
    local pairs = pair(forms)
    local n_1 = length(pairs) - 1
    local _g729 = pairs
    local i = 0
    while i < length(_g729) do
      local _g730 = _g729[i + 1]
      local k = _g730[1]
      local v = _g730[2]
      if not string63(k) then
        error("Illegal key: " .. string(k))
      end
      str = str .. key(k) .. sep .. compile(v)
      if i < n_1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(str .. "}")
  end}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, ["lumen/lib"] = {export = {getenv = {export = true, variable = true}, ["macro-function"] = {export = true, variable = true}, ["macro?"] = {export = true, variable = true}, ["special?"] = {export = true, variable = true}, ["special-form?"] = {export = true, variable = true}, ["statement?"] = {export = true, variable = true}, ["symbol-expansion"] = {export = true, variable = true}, ["symbol?"] = {export = true, variable = true}, ["variable?"] = {export = true, variable = true}, ["bound?"] = {export = true, variable = true}, quoted = {export = true, variable = true}, ["stash*"] = {export = true, variable = true}, bind = {export = true, variable = true}, ["bind*"] = {export = true, variable = true}, quasiexpand = {export = true, variable = true}, macroexpand = {export = true, variable = true}, indentation = {export = true, variable = true}, ["with-indent"] = {export = true, macro = function (form)
    local result = make_id()
    return({"do", {"inc", "indent-level"}, {"let", {result, form}, {"dec", "indent-level"}, result}})
  end}, ["reserved?"] = {export = true, variable = true}, ["valid-id?"] = {export = true, variable = true}, id = {export = true, variable = true}, key = {export = true, variable = true}, imported = {export = true, variable = true}, link = {export = true, variable = true}, mapo = {export = true, variable = true}, ["quote-environment"] = {export = true, variable = true}, ["quote-modules"] = {export = true, variable = true}, ["initial-environment"] = {export = true, variable = true}, ["global?"] = {variable = true}, escape = {variable = true}, literal = {variable = true}, ["quoting?"] = {variable = true}, ["quasiquoting?"] = {variable = true}, ["can-unquote?"] = {variable = true}, ["quasisplice?"] = {variable = true}, ["quasiquote-list"] = {variable = true}, ["indent-level"] = {export = true, global = true}, reserved = {variable = true}, ["numeric?"] = {variable = true}, ["valid-code?"] = {variable = true}, extend = {variable = true}, exclude = {variable = true}, ["quote-binding"] = {variable = true}, ["quote-frame"] = {variable = true}, ["quote-module"] = {variable = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, ["lumen/runtime"] = {export = {["nil?"] = {export = true, variable = true}, ["is?"] = {export = true, variable = true}, length = {export = true, variable = true}, ["none?"] = {export = true, variable = true}, ["some?"] = {export = true, variable = true}, ["one?"] = {export = true, variable = true}, hd = {export = true, variable = true}, ["string?"] = {export = true, variable = true}, ["number?"] = {export = true, variable = true}, ["boolean?"] = {export = true, variable = true}, ["function?"] = {export = true, variable = true}, ["composite?"] = {export = true, variable = true}, ["atom?"] = {export = true, variable = true}, ["table?"] = {export = true, variable = true}, ["list?"] = {export = true, variable = true}, substring = {export = true, variable = true}, sub = {export = true, variable = true}, inner = {export = true, variable = true}, tl = {export = true, variable = true}, char = {export = true, variable = true}, code = {export = true, variable = true}, ["string-literal?"] = {export = true, variable = true}, ["id-literal?"] = {export = true, variable = true}, add = {export = true, variable = true}, drop = {export = true, variable = true}, last = {export = true, variable = true}, reverse = {export = true, variable = true}, join = {export = true, variable = true}, reduce = {export = true, variable = true}, keep = {export = true, variable = true}, ["in?"] = {export = true, variable = true}, find = {export = true, variable = true}, pair = {export = true, variable = true}, sort = {export = true, variable = true}, iterate = {export = true, variable = true}, replicate = {export = true, variable = true}, series = {export = true, variable = true}, map = {export = true, variable = true}, ["keys?"] = {export = true, variable = true}, ["empty?"] = {export = true, variable = true}, stash = {export = true, variable = true}, unstash = {export = true, variable = true}, search = {export = true, variable = true}, split = {export = true, variable = true}, cat = {export = true, variable = true}, ["+"] = {export = true, variable = true}, ["-"] = {export = true, variable = true}, ["*"] = {export = true, variable = true}, ["/"] = {export = true, variable = true}, ["%"] = {export = true, variable = true}, [">"] = {export = true, variable = true}, ["<"] = {export = true, variable = true}, ["="] = {export = true, variable = true}, [">="] = {export = true, variable = true}, ["<="] = {export = true, variable = true}, ["read-file"] = {export = true, variable = true}, ["write-file"] = {export = true, variable = true}, write = {export = true, variable = true}, exit = {export = true, variable = true}, today = {export = true, variable = true}, now = {export = true, variable = true}, number = {export = true, variable = true}, string = {export = true, variable = true}, space = {export = true, variable = true}, apply = {export = true, variable = true}, ["make-id"] = {export = true, variable = true}, ["%message-handler"] = {export = true, variable = true}, ["toplevel?"] = {export = true, variable = true}, ["module-key"] = {export = true, variable = true}, module = {export = true, variable = true}, setenv = {export = true, variable = true}, shift = {variable = true}, ["id-count"] = {variable = true}}, import = {{"lumen", "special"}, {"lumen", "core"}}}, ["lumen/reader"] = {export = {["make-stream"] = {export = true, variable = true}, ["read-table"] = {export = true, variable = true}, ["define-reader"] = {export = true, macro = function (_g731, ...)
    local char = _g731[1]
    local stream = _g731[2]
    local body = unstash({...})
    local _g732 = sub(body, 0)
    return({"set", {"get", "read-table", char}, join({"fn", {stream}}, _g732)})
  end}, read = {export = true, variable = true}, ["read-all"] = {export = true, variable = true}, ["read-from-string"] = {export = true, variable = true}, delimiters = {variable = true}, whitespace = {variable = true}, ["peek-char"] = {variable = true}, ["read-char"] = {variable = true}, ["skip-non-code"] = {variable = true}, eof = {variable = true}, ["key?"] = {variable = true}, ["flag?"] = {variable = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, ["lumen/core"] = {export = {quote = {macro = function (form)
    return(quoted(form))
  end, export = true}, quasiquote = {macro = function (form)
    return(quasiexpand(form, 1))
  end, export = true}, at = {macro = function (l, i)
    if target == "lua" and number63(i) then
      i = i + 1
    else
      if target == "lua" then
        i = {"+", i, 1}
      end
    end
    return({"get", l, i})
  end, export = true}, list = {macro = function (...)
    local body = unstash({...})
    local l = join({"%array"}, body)
    if not keys63(body) then
      return(l)
    else
      local id = make_id()
      local init = {}
      local _g733 = body
      local k = nil
      for k in next, _g733 do
        if not number63(k) then
          local v = _g733[k]
          add(init, {"set", {"get", id, {"quote", k}}, v})
        end
      end
      return(join({"let", {id, l}}, join(init, {id})))
    end
  end, export = true}, ["if"] = {macro = function (...)
    local branches = unstash({...})
    local function step(_g734)
      local a = _g734[1]
      local b = _g734[2]
      local c = sub(_g734, 2)
      if is63(b) then
        return({join({"%if", a, b}, step(c))})
      else
        if is63(a) then
          return({a})
        end
      end
    end
    return(hd(step(branches)))
  end, export = true}, when = {macro = function (cond, ...)
    local body = unstash({...})
    local _g735 = sub(body, 0)
    return({"if", cond, join({"do"}, _g735)})
  end, export = true}, unless = {macro = function (cond, ...)
    local body = unstash({...})
    local _g736 = sub(body, 0)
    return({"if", {"not", cond}, join({"do"}, _g736)})
  end, export = true}, table = {macro = function (...)
    local body = unstash({...})
    return(join({"%object"}, mapo(function (x)
      return(x)
    end, body)))
  end, export = true}, let = {macro = function (bindings, ...)
    local body = unstash({...})
    local _g737 = sub(body, 0)
    if length(bindings) < 2 then
      return(join({"do"}, _g737))
    else
      local renames = {}
      local locals = {}
      local lh = bindings[1]
      local rh = bindings[2]
      local _g738 = bind(lh, rh)
      local _g739 = 0
      while _g739 < length(_g738) do
        local _g740 = _g738[_g739 + 1]
        local id = _g740[1]
        local val = _g740[2]
        if bound63(id) or reserved63(id) or toplevel63() then
          local id1 = make_id()
          add(renames, id)
          add(renames, id1)
          id = id1
        else
          setenv(id, {_stash = true, variable = true})
        end
        add(locals, {"%local", id, val})
        _g739 = _g739 + 1
      end
      return(join({"do"}, join(locals, {{"let-symbol", renames, join({"let", sub(bindings, 2)}, _g737)}})))
    end
  end, export = true}, ["define-module"] = {macro = function (spec, ...)
    local body = unstash({...})
    local _g741 = sub(body, 0)
    local imp = _g741.import
    local exp = _g741.export
    local alias = _g741.alias
    local _g742 = import_modules(imp)
    local imports = _g742[1]
    local bindings = _g742[2]
    local k = module_key(spec)
    modules[k] = {import = imports, export = {}, alias = alias}
    local _g743 = exp or {}
    local _g744 = 0
    while _g744 < length(_g743) do
      local x = _g743[_g744 + 1]
      setenv(x, {_stash = true, export = true})
      _g744 = _g744 + 1
    end
    return(join({"do", {"set", {"get", "nexus", {"quote", k}}, {"table"}}}, bindings))
  end, export = true}, ["define-macro"] = {macro = function (name, args, ...)
    local body = unstash({...})
    local _g745 = sub(body, 0)
    local form = join({"fn", args}, _g745)
    local _g746 = {"setenv", {"quote", name}}
    _g746.macro = form
    _g746.form = {"quote", form}
    eval(_g746)
    return(nil)
  end, export = true}, ["define-special"] = {macro = function (name, args, ...)
    local body = unstash({...})
    local _g747 = sub(body, 0)
    local form = join({"fn", args}, _g747)
    local keys = sub(_g747, length(_g747))
    local _g748 = {"setenv", {"quote", name}}
    _g748.special = form
    _g748.form = {"quote", form}
    eval(join(_g748, keys))
    return(nil)
  end, export = true}, ["define-symbol"] = {macro = function (name, expansion)
    setenv(name, {_stash = true, symbol = expansion})
    return(nil)
  end, export = true}, ["define*"] = {macro = function (name, x, ...)
    local body = unstash({...})
    local _g749 = sub(body, 0)
    setenv(name, {_stash = true, global = true, export = true})
    if some63(_g749) then
      local _g750 = bind42(x, _g749)
      local args = _g750[1]
      local _g751 = _g750[2]
      return(join({"%global-function", name, args}, _g751))
    else
      if target == "js" then
        return({"set", {"get", "global", {"quote", id(name)}}, x})
      else
        return({"set", name, x})
      end
    end
  end, export = true}, define = {macro = function (name, x, ...)
    local body = unstash({...})
    local _g752 = sub(body, 0)
    setenv(name, {_stash = true, variable = true})
    if some63(_g752) and target == "js" then
      return(link(name, {"%local", name, join({"fn", x}, _g752)}))
    else
      if some63(_g752) then
        local _g753 = bind42(x, _g752)
        local args = _g753[1]
        local _g754 = _g753[2]
        return(link(name, join({"%local-function", name, args}, _g754)))
      else
        return(link(name, {"%local", name, x}))
      end
    end
  end, export = true}, ["set*"] = {macro = function (name, value)
    return(link(name, {"set", name, value}))
  end, export = true}, ["with-bindings"] = {macro = function (_g755, ...)
    local names = _g755[1]
    local body = unstash({...})
    local _g756 = sub(body, 0)
    local x = make_id()
    local _g758 = {"setenv", x}
    _g758.variable = true
    local _g757 = {"with-frame", {"each", {x}, names, _g758}}
    _g757.scope = true
    return(join(_g757, _g756))
  end, export = true}, ["let-macro"] = {macro = function (definitions, ...)
    local body = unstash({...})
    local _g759 = sub(body, 0)
    add(environment, {})
    map(function (m)
      return(macroexpand(join({"define-macro"}, m)))
    end, definitions)
    local _g760 = join({"do"}, macroexpand(_g759))
    drop(environment)
    return(_g760)
  end, export = true}, ["let-symbol"] = {macro = function (expansions, ...)
    local body = unstash({...})
    local _g761 = sub(body, 0)
    add(environment, {})
    map(function (_g763)
      local name = _g763[1]
      local exp = _g763[2]
      return(macroexpand({"define-symbol", name, exp}))
    end, pair(expansions))
    local _g762 = join({"do"}, macroexpand(_g761))
    drop(environment)
    return(_g762)
  end, export = true}, fn = {macro = function (args, ...)
    local body = unstash({...})
    local _g764 = sub(body, 0)
    local _g765 = bind42(args, _g764)
    local _g766 = _g765[1]
    local _g767 = _g765[2]
    return(join({"%function", _g766}, _g767))
  end, export = true}, guard = {macro = function (expr)
    if target == "js" then
      return({{"fn", {}, {"%try", {"list", true, expr}}}})
    else
      local e = make_id()
      local x = make_id()
      local ex = "|" .. e .. "," .. x .. "|"
      return({"let", {ex, {"xpcall", {"fn", {}, expr}, "%message-handler"}}, {"list", e, x}})
    end
  end, export = true}, all = {macro = function (_g768, t, ...)
    local k = _g768[1]
    local v = _g768[2]
    local body = unstash({...})
    local _g769 = sub(body, 0)
    local x = make_id()
    local n = make_id()
    local _g791
    if target == "lua" then
      _g791 = _g769
    else
      _g791 = {join({"let", {n, {"parseInt", k}, k, {"if", {"isNaN", n}, k, n}}}, _g769)}
    end
    return({"let", {x, t, k, "nil"}, {"%for", x, k, join({"let", {v, {"get", x, k}}}, _g791)}})
  end, export = true}, each = {macro = function (b, t, ...)
    local body = unstash({...})
    local _g770 = sub(body, 0)
    local k = b[1]
    local v = b[2]
    local t1 = make_id()
    local _g792
    if nil63(v) then
      local _g793
      if b.i then
        _g793 = "i"
      else
        _g793 = make_id()
      end
      local i = _g793
      _g792 = {"let", {i, 0}, {"while", {"<", i, {"length", t1}}, join({"let", {k, {"at", t1, i}}}, _g770), {"inc", i}}}
    else
      local _g771 = {"target"}
      _g771.js = {"isNaN", {"parseInt", k}}
      _g771.lua = {"not", {"number?", k}}
      _g792 = {"let", {k, "nil"}, {"%for", t1, k, {"when", _g771, join({"let", {v, {"get", t1, k}}}, _g770)}}}
    end
    return({"let", {t1, t}, _g792})
  end, export = true}, ["set-of"] = {macro = function (...)
    local xs = unstash({...})
    local l = {}
    local _g772 = xs
    local _g773 = 0
    while _g773 < length(_g772) do
      local x = _g772[_g773 + 1]
      l[x] = true
      _g773 = _g773 + 1
    end
    return(join({"table"}, l))
  end, export = true}, language = {macro = function ()
    return({"quote", target})
  end, export = true}, target = {macro = function (...)
    local clauses = unstash({...})
    return(clauses[target])
  end, export = true, global = true}, ["join*"] = {macro = function (...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return({"join", a, b})
    end, xs))
  end, export = true}, ["join!"] = {macro = function (a, ...)
    local bs = unstash({...})
    local _g774 = sub(bs, 0)
    return({"set", a, join({"join*", a}, _g774)})
  end, export = true}, ["cat!"] = {macro = function (a, ...)
    local bs = unstash({...})
    local _g775 = sub(bs, 0)
    return({"set", a, join({"cat", a}, _g775)})
  end, export = true}, inc = {macro = function (n, by)
    return({"set", n, {"+", n, by or 1}})
  end, export = true}, dec = {macro = function (n, by)
    return({"set", n, {"-", n, by or 1}})
  end, export = true}, pr = {macro = function (...)
    local xs = unstash({...})
    return({"print", space(xs)})
  end, export = true}, ["with-frame"] = {macro = function (...)
    local body = unstash({...})
    local _g776 = sub(body, 0)
    local scope = body.scope
    local x = make_id()
    local _g777 = {"table"}
    _g777._scope = scope
    return({"do", {"add", "environment", _g777}, {"let", {x, join({"do"}, _g776)}, {"drop", "environment"}, x}})
  end, export = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, ["lumen/compiler"] = {export = {["compile-function"] = {export = true, variable = true}, compile = {export = true, variable = true}, ["open-module"] = {export = true, variable = true}, ["load-module"] = {export = true, variable = true}, ["in-module"] = {export = true, variable = true}, ["import-modules"] = {export = true, variable = true}, ["compile-module"] = {export = true, variable = true}, declare = {export = true, variable = true}, eval = {export = true, variable = true}, infix = {variable = true}, ["unary?"] = {variable = true}, precedence = {variable = true}, getop = {variable = true}, ["infix?"] = {variable = true}, ["compile-args"] = {variable = true}, ["compile-atom"] = {variable = true}, terminator = {variable = true}, ["compile-special"] = {variable = true}, ["parenthesize-call?"] = {variable = true}, ["compile-call"] = {variable = true}, ["op-delims"] = {variable = true}, ["compile-infix"] = {variable = true}, ["can-return?"] = {variable = true}, lower = {variable = true}, ["lower-statement"] = {variable = true}, ["lower-body"] = {variable = true}, ["lower-do"] = {variable = true}, ["lower-if"] = {variable = true}, ["lower-short"] = {variable = true}, ["lower-try"] = {variable = true}, ["lower-while"] = {variable = true}, ["lower-for"] = {variable = true}, ["lower-function"] = {variable = true}, ["lower-definition"] = {variable = true}, ["lower-call"] = {variable = true}, ["lower-infix?"] = {variable = true}, ["lower-infix"] = {variable = true}, ["lower-special"] = {variable = true}, process = {variable = true}, ["current-module"] = {export = true, global = true}, ["module-path"] = {variable = true}, encapsulate = {variable = true}, ["compile-file"] = {variable = true}, run = {variable = true}, ["compiling?"] = {variable = true}, ["compiler-output"] = {variable = true}, conclude = {variable = true}, ["%compile-module"] = {variable = true}, reimported = {variable = true}, ["%result"] = {export = true, global = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "reader"}}}, ["lumen/main"] = {export = {}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "reader"}, {"lumen", "compiler"}}}, ["lumen/system"] = {export = {nexus = {export = true, global = true}}, import = {{"lumen", "special"}, {"lumen", "core"}}}, lumen = {alias = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}, export = {}, import = {{"lumen", "special"}}}, user = {export = {}, import = {"lumen", {"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}}
  environment = {{["define-module"] = {macro = function (spec, ...)
    local body = unstash({...})
    local _g778 = sub(body, 0)
    local imp = _g778.import
    local exp = _g778.export
    local alias = _g778.alias
    local _g779 = import_modules(imp)
    local imports = _g779[1]
    local bindings = _g779[2]
    local k = module_key(spec)
    modules[k] = {import = imports, export = {}, alias = alias}
    local _g780 = exp or {}
    local _g781 = 0
    while _g781 < length(_g780) do
      local x = _g780[_g781 + 1]
      setenv(x, {_stash = true, export = true})
      _g781 = _g781 + 1
    end
    return(join({"do", {"set", {"get", "nexus", {"quote", k}}, {"table"}}}, bindings))
  end, export = true}}}
end)();
(function ()
  nexus.user = {}
  local _g794 = nexus["lumen/runtime"]
  local nil63 = _g794["nil?"]
  local is63 = _g794["is?"]
  local length = _g794.length
  local none63 = _g794["none?"]
  local some63 = _g794["some?"]
  local one63 = _g794["one?"]
  local hd = _g794.hd
  local string63 = _g794["string?"]
  local number63 = _g794["number?"]
  local boolean63 = _g794["boolean?"]
  local function63 = _g794["function?"]
  local composite63 = _g794["composite?"]
  local atom63 = _g794["atom?"]
  local table63 = _g794["table?"]
  local list63 = _g794["list?"]
  local substring = _g794.substring
  local sub = _g794.sub
  local inner = _g794.inner
  local tl = _g794.tl
  local char = _g794.char
  local code = _g794.code
  local string_literal63 = _g794["string-literal?"]
  local id_literal63 = _g794["id-literal?"]
  local add = _g794.add
  local drop = _g794.drop
  local last = _g794.last
  local reverse = _g794.reverse
  local join = _g794.join
  local reduce = _g794.reduce
  local keep = _g794.keep
  local in63 = _g794["in?"]
  local find = _g794.find
  local pair = _g794.pair
  local sort = _g794.sort
  local iterate = _g794.iterate
  local replicate = _g794.replicate
  local series = _g794.series
  local map = _g794.map
  local keys63 = _g794["keys?"]
  local empty63 = _g794["empty?"]
  local stash = _g794.stash
  local unstash = _g794.unstash
  local search = _g794.search
  local split = _g794.split
  local cat = _g794.cat
  local _43 = _g794["+"]
  local _ = _g794["-"]
  local _42 = _g794["*"]
  local _47 = _g794["/"]
  local _37 = _g794["%"]
  local _62 = _g794[">"]
  local _60 = _g794["<"]
  local _61 = _g794["="]
  local _6261 = _g794[">="]
  local _6061 = _g794["<="]
  local read_file = _g794["read-file"]
  local write_file = _g794["write-file"]
  local write = _g794.write
  local exit = _g794.exit
  local today = _g794.today
  local now = _g794.now
  local number = _g794.number
  local string = _g794.string
  local space = _g794.space
  local apply = _g794.apply
  local make_id = _g794["make-id"]
  local _37message_handler = _g794["%message-handler"]
  local toplevel63 = _g794["toplevel?"]
  local module_key = _g794["module-key"]
  local module = _g794.module
  local setenv = _g794.setenv
end)();
(function ()
  nexus["lumen/main"] = {}
  local _g2 = nexus["lumen/runtime"]
  local replicate = _g2.replicate
  local search = _g2.search
  local iterate = _g2.iterate
  local _6261 = _g2[">="]
  local table63 = _g2["table?"]
  local pair = _g2.pair
  local nil63 = _g2["nil?"]
  local toplevel63 = _g2["toplevel?"]
  local cat = _g2.cat
  local none63 = _g2["none?"]
  local space = _g2.space
  local write_file = _g2["write-file"]
  local module_key = _g2["module-key"]
  local tl = _g2.tl
  local function63 = _g2["function?"]
  local length = _g2.length
  local number = _g2.number
  local _47 = _g2["/"]
  local hd = _g2.hd
  local join = _g2.join
  local today = _g2.today
  local _42 = _g2["*"]
  local some63 = _g2["some?"]
  local empty63 = _g2["empty?"]
  local write = _g2.write
  local sub = _g2.sub
  local string = _g2.string
  local substring = _g2.substring
  local find = _g2.find
  local _61 = _g2["="]
  local char = _g2.char
  local _60 = _g2["<"]
  local keep = _g2.keep
  local one63 = _g2["one?"]
  local is63 = _g2["is?"]
  local in63 = _g2["in?"]
  local atom63 = _g2["atom?"]
  local apply = _g2.apply
  local _37message_handler = _g2["%message-handler"]
  local reverse = _g2.reverse
  local keys63 = _g2["keys?"]
  local split = _g2.split
  local now = _g2.now
  local composite63 = _g2["composite?"]
  local stash = _g2.stash
  local map = _g2.map
  local list63 = _g2["list?"]
  local sort = _g2.sort
  local setenv = _g2.setenv
  local series = _g2.series
  local last = _g2.last
  local string63 = _g2["string?"]
  local make_id = _g2["make-id"]
  local _6061 = _g2["<="]
  local _43 = _g2["+"]
  local _ = _g2["-"]
  local module = _g2.module
  local exit = _g2.exit
  local add = _g2.add
  local _37 = _g2["%"]
  local string_literal63 = _g2["string-literal?"]
  local read_file = _g2["read-file"]
  local number63 = _g2["number?"]
  local _62 = _g2[">"]
  local reduce = _g2.reduce
  local code = _g2.code
  local inner = _g2.inner
  local drop = _g2.drop
  local unstash = _g2.unstash
  local boolean63 = _g2["boolean?"]
  local id_literal63 = _g2["id-literal?"]
  local _g5 = nexus["lumen/reader"]
  local read = _g5.read
  local read_all = _g5["read-all"]
  local read_table = _g5["read-table"]
  local make_stream = _g5["make-stream"]
  local read_from_string = _g5["read-from-string"]
  local _g6 = nexus["lumen/compiler"]
  local in_module = _g6["in-module"]
  local declare = _g6.declare
  local eval = _g6.eval
  local import_modules = _g6["import-modules"]
  local compile_function = _g6["compile-function"]
  local compile = _g6.compile
  local open_module = _g6["open-module"]
  local compile_module = _g6["compile-module"]
  local load_module = _g6["load-module"]
  local function rep(str)
    local _g798,_g799 = xpcall(function ()
      return(eval(read_from_string(str)))
    end, _37message_handler)
    local _g797 = {_g798, _g799}
    local _g1 = _g797[1]
    local x = _g797[2]
    if is63(x) then
      return(print(string(x)))
    end
  end
  nexus["lumen/main"].rep = rep
  local function repl()
    local function step(str)
      rep(str)
      return(write("> "))
    end
    write("> ")
    while true do
      local str = io.read()
      if str then
        step(str)
      else
        break
      end
    end
  end
  nexus["lumen/main"].repl = repl
  local function usage()
    print("usage: lumen [options] <module>")
    print("options:")
    print("  -o <output>\tOutput file")
    print("  -t <target>\tTarget language (default: lua)")
    print("  -e <expr>\tExpression to evaluate")
    return(exit())
  end
  nexus["lumen/main"].usage = usage
  local function main()
    local args = arg
    if hd(args) == "-h" or hd(args) == "--help" then
      usage()
    end
    local spec = nil
    local output = nil
    local target1 = nil
    local expr = nil
    local _g800 = args
    local i = 0
    while i < length(_g800) do
      local arg = _g800[i + 1]
      if arg == "-o" or arg == "-t" or arg == "-e" then
        if i == length(args) - 1 then
          print("missing argument for" .. " " .. string(arg))
        else
          i = i + 1
          local val = args[i + 1]
          if arg == "-o" then
            output = val
          else
            if arg == "-t" then
              target1 = val
            else
              if arg == "-e" then
                expr = val
              end
            end
          end
        end
      else
        if nil63(spec) and "-" ~= char(arg, 0) then
          spec = arg
        end
      end
      i = i + 1
    end
    if output then
      if target1 then
        target = target1
      end
      return(write_file(output, compile_module(spec)))
    else
      in_module(spec or "user")
      if expr then
        return(rep(expr))
      else
        return(repl())
      end
    end
  end
  nexus["lumen/main"].main = main
  main()
end)();
