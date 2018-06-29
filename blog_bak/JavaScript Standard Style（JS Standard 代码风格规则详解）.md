title: JavaScript Standard Style（JS Standard 代码风格规则详解）
date: 2018-06-29 00:00:00 +0800
update: 2018-06-29 00:00:00 +0800
author: fungleo
tags:
    -javascript
    -Standard
    -Standard代码
    -Standard风格
    -Standard规则
---

# JavaScript Standard Style

翻译： [Português](https://standardjs.com/rules-ptbr.html), [Spanish](https://standardjs.com/rules-esla.html), [繁體中文](https://standardjs.com/rules-zhtw.html), [简体中文](https://standardjs.com/rules-zhcn.html)

[![js-standard-style](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/feross/standard)

[standard](https://github.com/feross/standard) 规则列表，太多不必阅读。

了解 `standard` 的最好方式是安装它，然后写代码尝试。

## 规则

*   缩进使用两个空格。

    eslint: [`indent`](http://eslint.org/docs/rules/indent)
    ```
    function hello (name) {
      console.log('hi', name)
    }
    ```

*   字符串使用单引号，除非是为了避免转义。

    eslint: [`quotes`](http://eslint.org/docs/rules/quotes)

    ```
    console.log('hello there')
    $("<div class='box'>")
    ```

*   无未使用的变量。

    eslint: [`no-unused-vars`](http://eslint.org/docs/rules/no-unused-vars)

    ```
    function myFunction () {
      var result = something()   // ✗ avoid
    }
    ```

*   关键字后面要有一个空格。

    eslint: [`keyword-spacing`](http://eslint.org/docs/rules/keyword-spacing)

    ```
    if (condition) { ... }   // ✓ ok
    if(condition) { ... }    // ✗ avoid
    ```

*   函数参数列表括号前面要有一个空格。

    eslint: [`space-before-function-paren`](http://eslint.org/docs/rules/space-before-function-paren)

    ```
    function name (arg) { ... }   // ✓ ok
    function name(arg) { ... }    // ✗ avoid

    run(function () { ... })      // ✓ ok
    run(function() { ... })       // ✗ avoid
    ```

    

*   始终使用 `===` 不使用 `==`。
    例外：可以使用 `obj == null` 检测 `null || undefined`。

    eslint: [`eqeqeq`](http://eslint.org/docs/rules/eqeqeq)

    

    ```
    if (name === 'John')   // ✓ ok
    if (name == 'John')    // ✗ avoid
    ```

    

    

    ```
    if (name !== 'John')   // ✓ ok
    if (name != 'John')    // ✗ avoid
    ```

    

*   中缀操作符（infix operators）前后要有一个空格。

    eslint: [`space-infix-ops`](http://eslint.org/docs/rules/space-infix-ops)

    

    ```
    // ✓ ok
    var x = 2
    var message = 'hello, ' + name + '!'
    ```

    

    

    ```
    // ✗ avoid
    var x=2
    var message = 'hello, '+name+'!'
    ```

    

*   逗号后面有一个空格。

    eslint: [`comma-spacing`](http://eslint.org/docs/rules/comma-spacing)

    

    ```
    // ✓ ok
    var list = [1, 2, 3, 4]
    function greet (name, options) { ... }
    ```

    

    

    ```
    // ✗ avoid
    var list = [1,2,3,4]
    function greet (name,options) { ... }
    ```

    

*   `else` 与它的大括号同行。

    eslint: [`brace-style`](http://eslint.org/docs/rules/brace-style)

    

    ```
    // ✓ ok
    if (condition) {
      // ...
    } else {
      // ...
    }
    ```

    

    

    ```
    // ✗ avoid
    if (condition) {
      // ...
    }
    else {
      // ...
    }
    ```

    

*   `if` 语句如果包含多个语句则使用大括号。

    eslint: [`curly`](http://eslint.org/docs/rules/curly)

    

    ```
    // ✓ ok
    if (options.quiet !== true) console.log('done')
    ```

    

    

    ```
    // ✓ ok
    if (options.quiet !== true) {
      console.log('done')
    }
    ```

    

    

    ```
    // ✗ avoid
    if (options.quiet !== true)
      console.log('done')
    ```

    

*   始终处理函数的 `err` 参数。

    eslint: [`handle-callback-err`](http://eslint.org/docs/rules/handle-callback-err)

    

    ```
    // ✓ ok
    run(function (err) {
      if (err) throw err
      window.alert('done')
    })
    ```

    

    

    ```
    // ✗ avoid
    run(function (err) {
      window.alert('done')
    })
    ```

    

*   浏览器全局变量始终添加前缀 `window.`。
    例外： `document`, `console` 和 `navigator`。

    eslint: [`no-undef`](http://eslint.org/docs/rules/no-undef)

    

    ```
    window.alert('hi')   // ✓ ok
    ```

    

*   不要有多个连续空行。

    eslint: [`no-multiple-empty-lines`](http://eslint.org/docs/rules/no-multiple-empty-lines)

    

    ```
    // ✓ ok
    var value = 'hello world'
    console.log(value)
    ```

    

    

    ```
    // ✗ avoid
    var value = 'hello world'

    console.log(value)
    ```

    

*   三元表达式如果是多行，则 `?` 和 `:` 放在各自的行上。

    eslint: [`operator-linebreak`](http://eslint.org/docs/rules/operator-linebreak)

    

    ```
    // ✓ ok
    var location = env.development ? 'localhost' : 'www.api.com'

    // ✓ ok
    var location = env.development
      ? 'localhost'
      : 'www.api.com'

    // ✗ avoid
    var location = env.development ?
      'localhost' :
      'www.api.com'
    ```

    

*   `var` 声明，每个声明占一行。

    eslint: [`one-var`](http://eslint.org/docs/rules/one-var)

    

    ```
    // ✓ ok
    var silent = true
    var verbose = true

    // ✗ avoid
    var silent = true, verbose = true

    // ✗ avoid
    var silent = true,
        verbose = true
    ```

    

*   用括号包裹条件中的赋值表达式。这是为了清楚的表明它是一个赋值表达式 (`=`)，而不是一个等式 (`===`) 的误写。

    eslint: [`no-cond-assign`](http://eslint.org/docs/rules/no-cond-assign)

    

    ```
    // ✓ ok
    while ((m = text.match(expr))) {
      // ...
    }

    // ✗ avoid
    while (m = text.match(expr)) {
      // ...
    }
    ```

    

*   单行语句块的内侧要有空格。

    eslint: [`block-spacing`](http://eslint.org/docs/rules/block-spacing)

    

    ```
      function foo () {return true}    // ✗ avoid
      function foo () { return true }  // ✓ ok
    ```

    

*   变量和函数的名字使用 camelCase 格式。

    eslint: [`camelcase`](http://eslint.org/docs/rules/camelcase)

    

    ```
      function my_function () { }    // ✗ avoid
      function myFunction () { }     // ✓ ok

      var my_var = 'hello'           // ✗ avoid
      var myVar = 'hello'            // ✓ ok
    ```

    

*   无多余逗号。

    eslint: [`comma-dangle`](http://eslint.org/docs/rules/comma-dangle)

    

    ```
      var obj = {
        message: 'hello',   // ✗ avoid
      }
    ```

    

*   逗号必须放在当前行的末尾。

    eslint: [`comma-style`](http://eslint.org/docs/rules/comma-style)

    

    ```
      var obj = {
        foo: 'foo'
        ,bar: 'bar'   // ✗ avoid
      }

      var obj = {
        foo: 'foo',
        bar: 'bar'   // ✓ ok
      }
    ```

    

*   `.` 应当与属性同行。

    eslint: [`dot-location`](http://eslint.org/docs/rules/dot-location)

    

    ```
      console.
        log('hello')  // ✗ avoid

      console
        .log('hello') // ✓ ok
    ```

    

*   文件以空行结尾。

    elint: [`eol-last`](http://eslint.org/docs/rules/eol-last)

*   函数名字和调用括号之间没有空格。

    eslint: [`func-call-spacing`](http://eslint.org/docs/rules/func-call-spacing)

    

    ```
    console.log ('hello') // ✗ avoid
    console.log('hello')  // ✓ ok
    ```

    

*   键名和键值之间要有空格。

    eslint: [`key-spacing`](http://eslint.org/docs/rules/key-spacing)

    

    ```
    var obj = { 'key' : 'value' }    // ✗ avoid
    var obj = { 'key' :'value' }     // ✗ avoid
    var obj = { 'key':'value' }      // ✗ avoid
    var obj = { 'key': 'value' }     // ✓ ok
    ```

    

*   构造函数的名字以大写字母开始。

    eslint: [`new-cap`](http://eslint.org/docs/rules/new-cap)

    

    ```
    function animal () {}
    var dog = new animal()    // ✗ avoid

    function Animal () {}
    var dog = new Animal()    // ✓ ok
    ```

    

*   没有参数的构造函数在调用时必须有括号。

    eslint: [`new-parens`](http://eslint.org/docs/rules/new-parens)

    

    ```
    function Animal () {}
    var dog = new Animal    // ✗ avoid
    var dog = new Animal()  // ✓ ok
    ```

    

*   对象若定义了 setter 则必须定义相应的 getter。

    eslint: [`accessor-pairs`](http://eslint.org/docs/rules/accessor-pairs)

    

    ```
    var person = {
      set name (value) {    // ✗ avoid
        this.name = value
      }
    }

    var person = {
      set name (value) {
        this.name = value
      },
      get name () {         // ✓ ok
        return this.name
      }
    }
    ```

    

*   子类的构造器必须调用 `super`。

    eslint: [`constructor-super`](http://eslint.org/docs/rules/constructor-super)

    

    ```
    class Dog {
      constructor () {
        super()   // ✗ avoid
      }
    }

    class Dog extends Mammal {
      constructor () {
        super()   // ✓ ok
      }
    }
    ```

    

*   使用对象字面量，不使用对象构造函数。

    eslint: [`no-array-constructor`](http://eslint.org/docs/rules/no-array-constructor)

    

    ```
    var nums = new Array(1, 2, 3)   // ✗ avoid
    var nums = [1, 2, 3]            // ✓ ok
    ```

    

*   不使用 `arguments.callee` 和 `arguments.caller`。

    eslint: [`no-caller`](http://eslint.org/docs/rules/no-caller)

    

    ```
    function foo (n) {
      if (n <= 0) return

      arguments.callee(n - 1)   // ✗ avoid
    }

    function foo (n) {
      if (n <= 0) return

      foo(n - 1)
    }
    ```

    

*   不要给 class 赋值。

    eslint: [`no-class-assign`](http://eslint.org/docs/rules/no-class-assign)

    

    ```
    class Dog {}
    Dog = 'Fido'    // ✗ avoid
    ```

    

*   不要修改由 `const` 声明的变量。

    eslint: [`no-const-assign`](http://eslint.org/docs/rules/no-const-assign)

    

    ```
    const score = 100
    score = 125       // ✗ avoid
    ```

    

*   在条件句中不要使用常量，循环语句除外。

    eslint: [`no-constant-condition`](http://eslint.org/docs/rules/no-constant-condition)

    

    ```
    if (false) {    // ✗ avoid
      // ...
    }

    if (x === 0) {  // ✓ ok
      // ...
    }

    while (true) {  // ✓ ok
      // ...
    }
    ```

    

*   正则表达式不要使用控制字符。

    eslint: [`no-control-regex`](http://eslint.org/docs/rules/no-control-regex)

    

    ```
    var pattern = /\x1f/    // ✗ avoid
    var pattern = /\x20/    // ✓ ok
    ```

    

*   不使用 `debugger` 语句。

    eslint: [`no-debugger`](http://eslint.org/docs/rules/no-debugger)

    

    ```
    function sum (a, b) {
      debugger      // ✗ avoid
      return a + b
    }
    ```

    

*   不要对变量使用 `delete` 操作符。

    eslint: [`no-delete-var`](http://eslint.org/docs/rules/no-delete-var)

    

    ```
    var name
    delete name     // ✗ avoid
    ```

    

*   函数定义无重复参数。

    eslint: [`no-dupe-args`](http://eslint.org/docs/rules/no-dupe-args)

    

    ```
    function sum (a, b, a) {  // ✗ avoid
      // ...
    }

    function sum (a, b, c) {  // ✓ ok
      // ...
    }
    ```

    

*   class 定义无重复成员。

    eslint: [`no-dupe-class-members`](http://eslint.org/docs/rules/no-dupe-class-members)

    

    ```
    class Dog {
      bark () {}
      bark () {}    // ✗ avoid
    }
    ```

    

*   对象字面量无重复键名。

    eslint: [`no-dupe-keys`](http://eslint.org/docs/rules/no-dupe-keys)

    

    ```
    var user = {
      name: 'Jane Doe',
      name: 'John Doe'    // ✗ avoid
    }
    ```

    

*   `switch` 语句无重复 `case` 从句。

    eslint: [`no-duplicate-case`](http://eslint.org/docs/rules/no-duplicate-case)

    

    ```
    switch (id) {
      case 1:
        // ...
      case 1:     // ✗ avoid
    }
    ```

    

*   每个模块只使用一个 import 语句。

    eslint: [`no-duplicate-imports`](http://eslint.org/docs/rules/no-duplicate-imports)

    

    ```
    import { myFunc1 } from 'module'
    import { myFunc2 } from 'module'          // ✗ avoid

    import { myFunc1, myFunc2 } from 'module' // ✓ ok
    ```

    

*   正则表达式无空的字符组。

    eslint: [`no-empty-character-class`](http://eslint.org/docs/rules/no-empty-character-class)

    

    ```
    const myRegex = /^abc[]/      // ✗ avoid
    const myRegex = /^abc[a-z]/   // ✓ ok
    ```

    

*   解构赋值不使用空的 pattern。

    eslint: [`no-empty-pattern`](http://eslint.org/docs/rules/no-empty-pattern)

    

    ```
    const { a: {} } = foo         // ✗ avoid
    const { a: { b } } = foo      // ✓ ok
    ```

    

*   不使用 `eval()`。

    eslint: [`no-eval`](http://eslint.org/docs/rules/no-eval)

    

    ```
    eval( "var result = user." + propName ) // ✗ avoid
    var result = user[propName]             // ✓ ok
    ```

    

*   `catch` 语句中不要对错误对象重新赋值。

    eslint: [`no-ex-assign`](http://eslint.org/docs/rules/no-ex-assign)

    

    ```
    try {
      // ...
    } catch (e) {
      e = 'new value'             // ✗ avoid
    }

    try {
      // ...
    } catch (e) {
      const newVal = 'new value'  // ✓ ok
    }
    ```

    

*   不要扩展原生对象。

    eslint: [`no-extend-native`](http://eslint.org/docs/rules/no-extend-native)

    

    ```
    Object.prototype.age = 21     // ✗ avoid
    ```

    

*   不使用非必要的 `.bind()`。

    eslint: [`no-extra-bind`](http://eslint.org/docs/rules/no-extra-bind)

    

    ```
    const name = function () {
      getName()
    }.bind(user)    // ✗ avoid

    const name = function () {
      this.getName()
    }.bind(user)    // ✓ ok
    ```

    

*   不使用非必要的布尔值转换。

    eslint: [`no-extra-boolean-cast`](http://eslint.org/docs/rules/no-extra-boolean-cast)

    

    ```
    const result = true
    if (!!result) {   // ✗ avoid
      // ...
    }

    const result = true
    if (result) {     // ✓ ok
      // ...
    }
    ```

    

*   函数表达式不使用非必要的包裹括号。

    eslint: [`no-extra-parens`](http://eslint.org/docs/rules/no-extra-parens)

    

    ```
    const myFunc = (function () { })   // ✗ avoid
    const myFunc = function () { }     // ✓ ok
    ```

    

*   `switch` 语句使用 `break`，避免运行到下一个 `case`。

    eslint: [`no-fallthrough`](http://eslint.org/docs/rules/no-fallthrough)

    

    ```
    switch (filter) {
      case 1:
        doSomething()    // ✗ avoid
      case 2:
        doSomethingElse()
    }

    switch (filter) {
      case 1:
        doSomething()
        break           // ✓ ok
      case 2:
        doSomethingElse()
    }

    switch (filter) {
      case 1:
        doSomething()
        // fallthrough  // ✓ ok
      case 2:
        doSomethingElse()
    }
    ```

    

*   浮点数应包含整数和小数。

    eslint: [`no-floating-decimal`](http://eslint.org/docs/rules/no-floating-decimal)

    

    ```
    const discount = .5      // ✗ avoid
    const discount = 0.5     // ✓ ok
    ```

    

*   不给声明过的函数重新赋值。

    eslint: [`no-func-assign`](http://eslint.org/docs/rules/no-func-assign)

    

    ```
    function myFunc () { }
    myFunc = myOtherFunc    // ✗ avoid
    ```

    

*   不给只读的全局变量重新赋值。

    eslint: [`no-global-assign`](http://eslint.org/docs/rules/no-global-assign)

    

    ```
    window = {}     // ✗ avoid
    ```

    

*   不使用隐式 `eval()`。

    eslint: [`no-implied-eval`](http://eslint.org/docs/rules/no-implied-eval)

    

    ```
    setTimeout("alert('Hello world')")                   // ✗ avoid
    setTimeout(function () { alert('Hello world') })     // ✓ ok
    ```

    

*   不在嵌套语句中使用函数声明。

    eslint: [`no-inner-declarations`](http://eslint.org/docs/rules/no-inner-declarations)

    

    ```
    if (authenticated) {
      function setAuthUser () {}    // ✗ avoid
    }
    ```

    

*   `RegExp` 构造器不使用非法的正则表达式字符串。

    eslint: [`no-invalid-regexp`](http://eslint.org/docs/rules/no-invalid-regexp)

    

    ```
    RegExp('[a-z')    // ✗ avoid
    RegExp('[a-z]')   // ✓ ok
    ```

    

*   不使用非法空白。

    eslint: [`no-irregular-whitespace`](http://eslint.org/docs/rules/no-irregular-whitespace)

    

    ```
    function myFunc () /*<NBSP>*/{}   // ✗ avoid
    ```

    

*   不使用 `__iterator__`。

    eslint: [`no-iterator`](http://eslint.org/docs/rules/no-iterator)

    

    ```
    Foo.prototype.__iterator__ = function () {}   // ✗ avoid
    ```

    

*   label 不使用作用域内变量的名字。

    eslint: [`no-label-var`](http://eslint.org/docs/rules/no-label-var)

    

    ```
    var score = 100
    function game () {
      score: 50         // ✗ avoid
    }
    ```

    

*   不使用 label 语句。

    eslint: [`no-labels`](http://eslint.org/docs/rules/no-labels)

    

    ```
    label:
      while (true) {
        break label     // ✗ avoid
      }
    ```

    

*   不使用非必要的嵌套语句块。

    eslint: [`no-lone-blocks`](http://eslint.org/docs/rules/no-lone-blocks)

    

    ```
    function myFunc () {
      {                   // ✗ avoid
        myOtherFunc()
      }
    }

    function myFunc () {
      myOtherFunc()       // ✓ ok
    }
    ```

    

*   缩进不混用空格和制表符。

    eslint: [`no-mixed-spaces-and-tabs`](http://eslint.org/docs/rules/no-mixed-spaces-and-tabs)

*   不使用多个连续空格，缩进除外。

    eslint: [`no-multi-spaces`](http://eslint.org/docs/rules/no-multi-spaces)

    

    ```
    const id =    1234    // ✗ avoid
    const id = 1234       // ✓ ok
    ```

    

*   不使用多行字符串。

    eslint: [`no-multi-str`](http://eslint.org/docs/rules/no-multi-str)

    

    ```
    const message = 'Hello \
                     world'     // ✗ avoid
    ```

    

*   如果不是赋值则不使用 `new`。

    eslint: [`no-new`](http://eslint.org/docs/rules/no-new)

    

    ```
    new Character()                     // ✗ avoid
    const character = new Character()   // ✓ ok
    ```

    

*   不使用 `Function` 构造器。

    eslint: [`no-new-func`](http://eslint.org/docs/rules/no-new-func)

    

    ```
    var sum = new Function('a', 'b', 'return a + b')    // ✗ avoid
    ```

    

*   不使用 `Object` 构造器。

    eslint: [`no-new-object`](http://eslint.org/docs/rules/no-new-object)

    

    ```
    let config = new Object()   // ✗ avoid
    ```

    

*   不使用 `new require`。

    eslint: [`no-new-require`](http://eslint.org/docs/rules/no-new-require)

    

    ```
    const myModule = new require('my-module')    // ✗ avoid
    ```

    

*   不使用 `Symbol` 构造器。

    eslint: [`no-new-symbol`](http://eslint.org/docs/rules/no-new-symbol)

    

    ```
    const foo = new Symbol('foo')   // ✗ avoid
    ```

    

*   不使用原始类型的包装对象。

    eslint: [`no-new-wrappers`](http://eslint.org/docs/rules/no-new-wrappers)

    

    ```
    const message = new String('hello')   // ✗ avoid
    ```

    

*   全局对象的属性不用于函数调用。

    eslint: [`no-obj-calls`](http://eslint.org/docs/rules/no-obj-calls)

    

    ```
    const math = Math()   // ✗ avoid
    ```

    

*   不使用八进制字面量。

    eslint: [`no-octal`](http://eslint.org/docs/rules/no-octal)

    

    ```
    const num = 042     // ✗ avoid
    const num = '042'   // ✓ ok
    ```

    

*   字符串不使用八进制转义。

    eslint: [`no-octal-escape`](http://eslint.org/docs/rules/no-octal-escape)

    

    ```
    const copyright = 'Copyright \251'  // ✗ avoid
    ```

    

*   `__dirname` 和 `__filename` 不用于字符串拼接。

    eslint: [`no-path-concat`](http://eslint.org/docs/rules/no-path-concat)

    

    ```
    const pathToFile = __dirname + '/app.js'            // ✗ avoid
    const pathToFile = path.join(__dirname, 'app.js')   // ✓ ok
    ```

    

*   不使用 `__proto__`，应使用 `getPrototypeOf`。

    eslint: [`no-proto`](http://eslint.org/docs/rules/no-proto)

    

    ```
    const foo = obj.__proto__               // ✗ avoid
    const foo = Object.getPrototypeOf(obj)  // ✓ ok
    ```

    

*   不重复声明变量。

    eslint: [`no-redeclare`](http://eslint.org/docs/rules/no-redeclare)

    

    ```
    let name = 'John'
    let name = 'Jane'     // ✗ avoid

    let name = 'John'
    name = 'Jane'         // ✓ ok
    ```

    

*   正则表达式中不使用多个连续空白。

    eslint: [`no-regex-spaces`](http://eslint.org/docs/rules/no-regex-spaces)

    

    ```
    const regexp = /test   value/   // ✗ avoid

    const regexp = /test {3}value/  // ✓ ok
    const regexp = /test value/     // ✓ ok
    ```

    

*   在 return 语句中赋值表达式要用括号包裹。

    eslint: [`no-return-assign`](http://eslint.org/docs/rules/no-return-assign)

    

    ```
    function sum (a, b) {
      return result = a + b     // ✗ avoid
    }

    function sum (a, b) {
      return (result = a + b)   // ✓ ok
    }
    ```

    

*   不将变量赋值给它自身。

    eslint: [`no-self-assign`](http://eslint.org/docs/rules/no-self-assign)

    

    ```
    name = name   // ✗ avoid
    ```

    

*   不将变量跟它自身相比。

    esint: [`no-self-compare`](http://eslint.org/docs/rules/no-self-compare)

    

    ```
    if (score === score) {}   // ✗ avoid
    ```

    

*   不使用逗号操作符。

    eslint: [`no-sequences`](http://eslint.org/docs/rules/no-sequences)

    

    ```
    if (doSomething(), !!test) {}   // ✗ avoid
    ```

    

*   不修改关键字的值。

    eslint: [`no-shadow-restricted-names`](http://eslint.org/docs/rules/no-shadow-restricted-names)

    

    ```
    let undefined = 'value'     // ✗ avoid
    ```

    

*   不使用稀疏数组（Sparse arrays）。

    eslint: [`no-sparse-arrays`](http://eslint.org/docs/rules/no-sparse-arrays)

    

    ```
    let fruits = ['apple',, 'orange']       // ✗ avoid
    ```

    

*   不使用制表符。

    eslint: [`no-tabs`](http://eslint.org/docs/rules/no-tabs)

*   普通字符串不要包含模板字符串占位符。

    eslint: [`no-template-curly-in-string`](http://eslint.org/docs/rules/no-template-curly-in-string)

    

    ```
    const message = 'Hello ${name}'   // ✗ avoid
    const message = `Hello ${name}`   // ✓ ok
    ```

    

*   `super()` 必须在访问 `this` 之前调用。

    eslint: [`no-this-before-super`](http://eslint.org/docs/rules/no-this-before-super)

    

    ```
    class Dog extends Animal {
      constructor () {
        this.legs = 4     // ✗ avoid
        super()
      }
    }
    ```

    

*   `throw` 应当抛出一个 `Error` 对象。

    eslint: [`no-throw-literal`](http://eslint.org/docs/rules/no-throw-literal)

    

    ```
    throw 'error'               // ✗ avoid
    throw new Error('error')    // ✓ ok
    ```

    

*   行末不要有空白。

    eslint: [`no-trailing-spaces`](http://eslint.org/docs/rules/no-trailing-spaces)

*   变量不初始化为 `undefined`。

    eslint: [`no-undef-init`](http://eslint.org/docs/rules/no-undef-init)

    

    ```
    let name = undefined    // ✗ avoid

    let name
    name = 'value'          // ✓ ok
    ```

    

*   循环语句要更新循环变量。

    eslint: [`no-unmodified-loop-condition`](http://eslint.org/docs/rules/no-unmodified-loop-condition)

    

    ```
    for (let i = 0; i < items.length; j++) {...}    // ✗ avoid
    for (let i = 0; i < items.length; i++) {...}    // ✓ ok
    ```

    

*   简单的存在赋值不使用三元操作符。

    eslint: [`no-unneeded-ternary`](http://eslint.org/docs/rules/no-unneeded-ternary)

    

    ```
    let score = val ? val : 0     // ✗ avoid
    let score = val || 0          // ✓ ok
    ```

    

*   `return`, `throw`, `continue`, `break` 语句后面不要有代码。

    eslint: [`no-unreachable`](http://eslint.org/docs/rules/no-unreachable)

    

    ```
    function doSomething () {
      return true
      console.log('never called')     // ✗ avoid
    }
    ```

    

*   `finally` 语句块无流程控制语句。

    eslint: [`no-unsafe-finally`](http://eslint.org/docs/rules/no-unsafe-finally)

    

    ```
    try {
      // ...
    } catch (e) {
      // ...
    } finally {
      return 42     // ✗ avoid
    }
    ```

    

*   `in` 操作符的左操作数不要使用 `!`。

    eslint: [`no-unsafe-negation`](http://eslint.org/docs/rules/no-unsafe-negation)

    

    ```
    if (!key in obj) {}       // ✗ avoid
    ```

    

*   无非必要的 `.call()` 和 `.apply()`。

    eslint: [`no-useless-call`](http://eslint.org/docs/rules/no-useless-call)

    

    ```
    sum.call(null, 1, 2, 3)   // ✗ avoid
    ```

    

*   无非必要的计算属性。

    eslint: [`no-useless-computed-key`](http://eslint.org/docs/rules/no-useless-computed-key)

    

    ```
    const user = { ['name']: 'John Doe' }   // ✗ avoid
    const user = { name: 'John Doe' }       // ✓ ok
    ```

    

*   无非必要的构造器。

    eslint: [`no-useless-constructor`](http://eslint.org/docs/rules/no-useless-constructor)

    

    ```
    class Car {
      constructor () {      // ✗ avoid
      }
    }
    ```

    

*   无非必要的转义。

    eslint: [`no-useless-escape`](http://eslint.org/docs/rules/no-useless-escape)

    

    ```
    let message = 'Hell\o'  // ✗ avoid
    ```

    

*   import, export, 解构赋值不可重命名为同名变量。

    eslint: [`no-useless-rename`](http://eslint.org/docs/rules/no-useless-rename)

    

    ```
    import { config as config } from './config'     // ✗ avoid
    import { config } from './config'               // ✓ ok
    ```

    

*   属性前面无空白。

    eslint: [`no-whitespace-before-property`](http://eslint.org/docs/rules/no-whitespace-before-property)

    

    ```
    user .name      // ✗ avoid
    user.name       // ✓ ok
    ```

    

*   不使用 `with` 语句。

    eslint: [`no-with`](http://eslint.org/docs/rules/no-with)

    

    ```
    with (val) {...}    // ✗ avoid
    ```

    

*   对象属性的换行应一致。

    eslint: [`object-property-newline`](http://eslint.org/docs/rules/object-property-newline)

    

    ```
    const user = {
      name: 'Jane Doe', age: 30,
      username: 'jdoe86'            // ✗ avoid
    }

    const user = { name: 'Jane Doe', age: 30, username: 'jdoe86' }    // ✓ ok

    const user = {
      name: 'Jane Doe',
      age: 30,
      username: 'jdoe86'
    }                                                                 // ✓ ok
    ```

    

*   语句块内部首尾无空行。

    eslint: [`padded-blocks`](http://eslint.org/docs/rules/padded-blocks)

    

    ```
    if (user) {
                                // ✗ avoid
      const name = getName()

    }

    if (user) {
      const name = getName()    // ✓ ok
    }
    ```

    

*   展开操作符后面无空格。

    eslint: [`rest-spread-spacing`](http://eslint.org/docs/rules/rest-spread-spacing)

    

    ```
    fn(... args)    // ✗ avoid
    fn(...args)     // ✓ ok
    ```

    

*   分号后面要有一个空格，前面无空格。

    eslint: [`semi-spacing`](http://eslint.org/docs/rules/semi-spacing)

    

    ```
    for (let i = 0 ;i < items.length ;i++) {...}    // ✗ avoid
    for (let i = 0; i < items.length; i++) {...}    // ✓ ok
    ```

    

*   语句块前面要有一个空格。

    eslint: [`space-before-blocks`](http://eslint.org/docs/rules/space-before-blocks)

    

    ```
    if (admin){...}     // ✗ avoid
    if (admin) {...}    // ✓ ok
    ```

    

*   函数参数列表括号内侧无空格。

    eslint: [`space-in-parens`](http://eslint.org/docs/rules/space-in-parens)

    

    ```
    getName( name )     // ✗ avoid
    getName(name)       // ✓ ok
    ```

    

*   一元操作符后面要有一个空格。

    eslint: [`space-unary-ops`](http://eslint.org/docs/rules/space-unary-ops)

    

    ```
    typeof!admin        // ✗ avoid
    typeof !admin        // ✓ ok
    ```

    

*   注释符号后面要有空白。

    eslint: [`spaced-comment`](http://eslint.org/docs/rules/spaced-comment)

    

    ```
    //comment           // ✗ avoid
    // comment          // ✓ ok

    /*comment*/         // ✗ avoid
    /* comment */       // ✓ ok
    ```

    

*   模板字符串大括号内侧无空格。

    eslint: [`template-curly-spacing`](http://eslint.org/docs/rules/template-curly-spacing)

    

    ```
    const message = `Hello, ${ name }`    // ✗ avoid
    const message = `Hello, ${name}`      // ✓ ok
    ```

    

*   使用 `isNaN()` 检查 `NaN`。

    eslint: [`use-isnan`](http://eslint.org/docs/rules/use-isnan)

    

    ```
    if (price === NaN) { }      // ✗ avoid
    if (isNaN(price)) { }       // ✓ ok
    ```

    

*   `typeof` 必须跟合法的字符串比较。

    eslint: [`valid-typeof`](http://eslint.org/docs/rules/valid-typeof)

    

    ```
    typeof name === 'undefimed'     // ✗ avoid
    typeof name === 'undefined'     // ✓ ok
    ```

    

*   立即调用函数 (IIFEs) 必须用括号包裹。

    eslint: [`wrap-iife`](http://eslint.org/docs/rules/wrap-iife)

    

    ```
    const getName = function () { }()     // ✗ avoid

    const getName = (function () { }())   // ✓ ok
    const getName = (function () { })()   // ✓ ok
    ```

    

*   `yield*` 的 `*` 前后要有一个空格。

    eslint: [`yield-star-spacing`](http://eslint.org/docs/rules/yield-star-spacing)

    

    ```
    yield* increment()    // ✗ avoid
    yield * increment()   // ✓ ok
    ```

    

*   不使用 Yoda 式条件句比较。

    eslint: [`yoda`](http://eslint.org/docs/rules/yoda)

    

    ```
    if (42 === age) { }    // ✗ avoid
    if (age === 42) { }    // ✓ ok
    ```

    

## 分号

*   不使用分号。 (查看： [1](http://blog.izs.me/post/2353458699/an-open-letter-to-javascript-leaders-regarding), [2](http://inimino.org/%7Einimino/blog/javascript_semicolons), [3](https://www.youtube.com/watch?v=gsfbh17Ax9I))

    eslint: [`semi`](http://eslint.org/docs/rules/semi)

    

    ```
    window.alert('hi')   // ✓ ok
    window.alert('hi');  // ✗ avoid
    ```

    

*   不以 `(`, `[`, ``` 开始行。这是省略分号时唯一的陷阱。standard 会保护你不落入陷阱。

    eslint: [`no-unexpected-multiline`](http://eslint.org/docs/rules/no-unexpected-multiline)

    

    ```
    // ✓ ok
    ;(function () {
      window.alert('ok')
    }())

    // ✗ avoid
    (function () {
      window.alert('ok')
    }())
    ```

    

    

    ```
    // ✓ ok
    ;[1, 2, 3].forEach(bar)

    // ✗ avoid
    [1, 2, 3].forEach(bar)
    ```

    

    

    ```
    // ✓ ok
    ;`hello`.indexOf('o')

    // ✗ avoid
    `hello`.indexOf('o')
    ```

    

    提示：如果你经常这样写代码，你可能是过于聪明了。

    不鼓励过于聪明的简写，表达式应尽可能清晰且容易阅读：

    不要这样：

    

    ```
    ;[1, 2, 3].forEach(bar)
    ```

    

    这样更好：

    

    ```
    var nums = [1, 2, 3]
    nums.forEach(bar)
    ```

    

## 拓展阅读

*   [An Open Letter to JavaScript Leaders Regarding Semicolons](http://blog.izs.me/post/2353458699/an-open-letter-to-javascript-leaders-regarding)
*   [JavaScript Semicolon Insertion – Everything you need to know](http://inimino.org/~inimino/blog/javascript_semicolons)

##### 一个有用的视频

*   [Are Semicolons Necessary in JavaScript? - YouTube](https://www.youtube.com/watch?v=gsfbh17Ax9I)

现在所有流行的代码压缩器都是通过 AST 压缩，因此它们在处理没有分号的 JavaScript 代码时没有问题（因为 JavaScript 不是必须使用分号）。

##### _开始引用 [“An Open Letter to JavaScript Leaders Regarding Semicolons”](http://blog.izs.me/post/2353458699/an-open-letter-to-javascript-leaders-regarding)_

[依赖自动插入分号机制]的代码是非常安全的，是完全合法的 JavaScript 代码，各浏览器都能正确解析；Closure compiler、yuicompressor、packer 及 jsmin 都能正确压缩。没有任何性能影响。

抱歉，我不是向你说教，这个语言的社区领导者在撒谎，并且害怕告诉你真相。真是羞耻。我建议，先了解 JavaScript 语句是如何结束的以及什么情况不会结束，之后你可以写出漂亮的代码。

一般来说，`\n` 结束语句，除非：

1.  语句没有关闭括号、数组字面量、对象字面量，或者以其它不合法的方式结束，比如以 `.` 或 `,` 结束。
2.  当前行是 `--` 或 `++`，这时它将递减或递增下一个 token。
3.  当前行是 `for()`, `while()`, `do`, `if()`, 或 `else`，并且没有 `<span class="p">{</span>`。
4.  下一行行首是 `[`, `(`, `+`, `*`, `/`, `-`, `,`, `.` ，或者是二进制操作符——它们只能出现在一个表达式的两个操作数之间。

第一条显而易见。像这些情况：JSON 或括号内有 `\n` 字符；一个 `var` 多行声明，每行以 `,` 结束，即使是 JSLint 都没问题。

第二条很怪。我从没有看到这种写法 `i\n++\nj`。事实上，它被解析为 `i; ++j`，而不是 `i++; j`。

第三条很好理解。`if (x)\ny()` 等于 `if (x) { y() }`。这个语句直到遇到一个语句块或语句才结束。

`;` 是一个合法的 JavaScript 语句，所以 `if(x);` 等于 `if(x){}` 或 “If x, do nothing.” 。这更多用于循环，这时循环测试同时也是更新函数。不常见，但不是没听过。

第四条通常是那些因循守旧的人提到的情况：“不，你需要分号！”。但是，事实证明，如果你的意思是这些行不是上一行的连续行，那么在这些行之前加上分号非常容易。例如



```
foo();
[1,2,3].forEach(bar);
```



可以这么写：



```
foo()
;[1,2,3].forEach(bar)
```



这么做的好处是，一旦你习惯了以 `(` 或 `[` 开始的行没有分号，你会很容易注意到行首的分号。

_结束引用 “An Open Letter to JavaScript Leaders Regarding Semicolons”_

## 版权

由 [Ivan Yan](http://yanxyz.net) 翻译，译文采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](http://creativecommons.org/licenses/by-nc-sa/4.0/)，意见[反馈](https://github.com/hongfanqie/standardjs)。

更多关于分号的讨论：

*   [JavaScript 语句后应该加分号么？](http://www.zhihu.com/question/20298345)
*   [自动分号补齐，ASI](http://www.zhihu.com/question/21076930#answer-1988408)

