---
inclusion: always
---
<!------------------------------------------------------------------------------------
   Add rules to this file or a short description and have Kiro refine them for you.
   
   Learn about inclusion modes: https://kiro.dev/docs/steering/#inclusion-modes
-------------------------------------------------------------------------------------> 

Directory structure:
└── doc/
    ├── README.md
    ├── BOOK.md
    ├── differences.md
    ├── FAQ.md
    ├── flutter-helpers.md
    ├── flutter-quick-start.md
    ├── GENERICS.md
    ├── quick-start.md
    ├── TESTING.md
    └── internals/
        └── MUNGING.md


Files Content:

================================================
FILE: doc/README.md
================================================
# ClojureDart

- [The language](#the-language)
  - [Word of warning](#word-of-warning)
  - [CLI](#cli)
  - [Using Dart packages](#using-dart-packages)
  - [Types and aliases](#types-and-aliases)
  - [Types and nullability](#types-and-nullability)
  - [Parametrized types](#parametrized-types)
  - [Property access](#property-access)
  - [`:flds`, Object destructuring](#flds-object-destructuring)
  - [Constructors](#constructors)
  - [Understanding Dart signatures](#understanding-dart-signatures)
  - [Named arguments](#named-arguments)
  - [Optional params (named or not)](#optional-params-named-or-not)
  - [Enums](#enums)
  - [Consts and const opt-out](#consts-and-const-opt-out)
  - [Creating classes](#creating-classes)
     - [`:extends`](#extends)
     - [mixins](#mixins)
     - [operators](#operators)
  - [Getters/Setters](#getterssetters)
- [`cljd.flutter`: more Flutter, less clutter!](#cljdflutter-more-flutter-less-clutter)
  - [Require this! It’s dangerous to go alone...](#require-this-its-dangerous-to-go-alone)
  - [`f/run [& widget-body]`](#frun--widget-body)
  - [`f/widget [& widget-body]`](#fwidget--widget-body)
  - [`.child-threading`](#child-threading)
  - [`:let` directive](#let-directive)
  - [`:key` directive](#key-directive)
  - [`:watch` directive — or how to react to IO and state](#watch-directive--or-how-to-react-to-io-and-state)
    - [`:watch` + `:default` option](#watch--default-option)
    - [`:watch` + `:as` option](#watch--as-option)
    - [`:watch` + `:dispose` option](#watch--dispose-option)
    - [`:watch` + `:refresh-on`](#watch--refresh-on)
    - [`:watch` + `:>` option](#watch---option)
    - [Deduplication](#deduplication)
    - [Watchables](#watchables)
    - [Cells](#cells)
  - [`:managed` directive](#managed-directive)
    - [`:managed` + `:dispose` option](#managed--dispose-option)
    - [`:managed` + `:refresh-on` option](#managed--refresh-on-option)
  - [`:bind` directive](#bind-directive)
  - [`:get` directive](#get-directive)
  - [`:context` directive — when Flutter lacks context](#context-directive--when-flutter-lacks-context)
  - [`:vsync` directive — chasing the electron beam across a phosphor screen](#vsync-directive--chasing-the-electron-beam-across-a-phosphor-screen)
  - [`:height`, `:width` and `:color`](#height-width-and-color)
  - [`:padding`](#padding)
  - [`:when`](#when)

## The language

This documentation assumes basic knowledge of [another Clojure dialect](https://clojure.org/guides/getting_started).

### Word of warning
Interop is a core part of Clojure and differs from host to host. Dart is both more strongly typed and less dynamic than Java.
This lack of dynamism is the price for excellent tree-shaking and fast startups.

### CLI

```sh
clj -M:cljd init
clj -M:cljd flutter # automatically compile and hot reload; press RETURN to force restart
clj -M:cljd compile # AOT compilation (eg for deploying)
clj -M:cljd clean   # to exit the twilight zone
clj -M:cljd upgrade # stay current w/ CLJD
clj -M:cljd test
```

### Using Dart packages
In the ns form use `:require` as usual but with a string instead of a symbol when importing Dart packages:
```clj
(ns my.project (:require  ["package:flutter/material.dart" :as m]))
```

### Types and aliases
Unlike JVM-Clojure, types can be prefixed by an alias. `m/ElevatedButton` refers to `ElevatedButton` in the package aliased by `m`.

### Types and nullability
In ClojureDart, `^String x` implies `x` can’t be `nil`.

Use `^String? x` to allow for `nil`.

### Parametrized types
Unlike Clojure/JVM, generics do exist at runtime so ClojureDart has to deal with them. Dart's `List<Map>` becomes `#/(List Map)`

`#/(List Map)` is just read as the `List` symbol with some metadata! Thus you can write `^#/(List Map) x`.


### Property access
Instance properties:
* get `(.-prop obj)`,
* set `(.-prop! obj x)` or `(set! (.-prop obj) x)`

Static properties: m/Colors.purple, this can even be chained m/Colors.purple.shade900 or even terminated with a method call(m/Colors.purple.shade900.withAlpha 128).

### `:flds`, Object destructuring
`:keys`, `:strs` and `:syms` are proud to introduce `:flds` their object-destructuring counterpart.

```clj
(let [{:flds [height width]} size] …) is equivalent to:
(let [height (.-height size)
      width (.-width size)]
  …)
```

### Constructors
In Dart, constructors do not always allocate, they can return existing instances. That’s why there’s no `new` nor trailing `.` (dot) in ClojureDart.Default constructors are called with classes in function position:

```clj
(StringBuffer "hello")
```

Named constructors are called like static methods.

```clj
(List/empty .growable true)
```

### Understanding Dart signatures
```dart
writeAll(Iterable objects,[String separator = ""])
```

One (positional) parameter `objects` of type `Iterable`, one optional positional parameter `separator` of type `String` whose default value is `""`.

```dart
RegExp(String source,
       {bool multiLine = false,
       bool caseSensitive = true})
```
One (positional) parameter `source` of type `String`, two optional named `bool` parameters `multiLine` (defaults to `false`) and `caseSensitive` (defaults to `true`).

```dart
any(bool test(E element))
```

One (positional) parameter: `test`, a function of one parameter `element` of type `E` (itself a type parameter) returning a `bool`.

### Named arguments
Some Dart functions and methods expect named arguments (`argname: 42` in Dart), in ClojureDart it’s `.argname 42`.

```clj
(m/Text "Hello world"  .maxLines 2  .softWrap true  .overflow m/TextOverflow.fade)
```

### Optional params (named or not)
Sometimes interop requires implementing a function or method taking Dart optional parameters.

* `[a b c .d .e]` means three positional parameters and two (optional) named ones: `d` and `e`.

* `[a b c ... d e]` five positional parameters, three fixed and two optional.

* `[.a 42 .e]` two named parameters `a` and `b` where `a` defaults to `42`.
* `[... a 42 b]` two optional positional parameters `a` and `b` where `a` defaults to `42`.

### Enums
Enums values are just static properties on types.e.g. `m/TextAlign.left`

### Consts and const opt-out
Dart has `const`s: deduplicated compile-time constant expressions in which `const` constructors may participate. It’s an opt-in mechanism.

Consts instances are really constrained because they are not instanciated at runtime: they are part of a memory snapshot created during compilation and restored at startup. It's fast.

ClojureDart maximally infers const expressions. In some rare occasion (like creating a sentinel or a token) you have to tag the expression as `:unique`: `^:unique (Object)`; otherwise you always get the same instance.

### Creating classes
`reify`, `deftype` and `defrecord` gets new powers.

#### `:extends`
Extending classes, even abstract ones!

The `:extends` option specifies a class or a constructor call (the super constructor call).

#### mixins
Mixin types must be tagged with `^:mixin`.

#### operators
Dart supports operators overloading but not all operators make valid Clojure symbol (`[]=` for example). That’s why it’s valid ClojureDart to have strings as methods names.

```clj
(. list "[]=" i 42) ; list[i] = 42
```

It’s also valid to use strings-as-names when implementing operator overloads as part of a class definition.

### Getters/Setters
Dart properties are not all fields: most are getters/setters. However they behave like fields, you get them `(.-prop obj)` and you set them `(set! (.-prop obj) 42)` or `(.-prop! obj 42)`.

Getters and setters are defined as regular methods in the body of a `reify`/`deftype`/`defrecord`. A getter expects one parameters (`[this]`) while a setter expects two (`[this v]`).

If the property is defined in a parent class or interface, you don’t need anything more. If the property is newly introduced by the type you need to tag the method name with `^:getter` or `^:setter`.

## `cljd.flutter`: more Flutter, less clutter!
`cljd.flutter` does not aspire to be a framework. It’s an utility lib to cut down on the boilerplate and thus to make Flutter more pleasing to Clojurists palates. Bon Appétit!

### Require this! It’s dangerous to go alone...
Add the following like to your `ns`'s `:require`:
```clj
[cljd.flutter :as f]
[“package:flutter/material.dart” :as m]
```

### `f/run [& widget-body]`
Called from main, it's the starting point a Flutter application. Its body is interpreted as per `f/widget`.

Additionally it helps making the app more reload-friendly.

### `f/widget [& widget-body]`
Mother of all macros. Evaluates to a `Widget`.Its body is made of interleaved expressions and directives.
Directives are always keywords followed by another form. Directives range from the mundane `:let` to the specific `:vsync`.
Expressions are `.child-threaded`.

### `.child-threading`
Inside a `widget-body`, expressions are threaded through the named param `.child`:

```clj
(f/widget
  m/Center
  (m/Text "hello"))
```

is equivalent to:

```clj
(m/Center .child (m/Text "hello"))
```

When the two expressions are separated by a dotted symbol, this symbol is used to thread them:

```clj
(f/widget
  m/MaterialApp
  .home
  m/Scaffold
  .body
  m/Center
  (m/ColoredBox .color m/Colors.pink.shade500)
  (m/Text "Don't stop it now!”))
```

expands into:

```clj
(m/MaterialApp
  .home
  (m/Scaffold
    .body
    (m/Center
      .child
      (m/ColoredBox
        .color m/Colors.pink.shade500
        .child
        (m/Text "Don't stop it now!”)))))
```

### `:let` directive

`(f/widget :let [some bindings] …)` expands to `(let [some bindings] (f/widget …))`.

### `:key` directive
Keys are primordial for recognizing sibling widgets in a list (or anywhere a .children argument is expected) updates after updates without losing or mixing state.
It will wrap its value inside a ValueKey so that you don’t have to.

### `:watch` directive — or how to react to IO and state
`:watch` takes a bindings vector. Unlike `:let`, expressions must be watchable and binding forms will be successively bound to values produced by their watchable.

```clj
(f/widget
  :watch [v an-atom]
  (m/Text (str v)))
```

When `an-atom` changes, everything after `:watch` will update with `v` bound to the current value of `an-atom`.

`:watch` bindings can take options:

#### `:watch` + `:default` option
Some watchables can't provide a current value (like `Future`s, `Stream`s, `Listenable`s...).

In the following example the future will only yield a value 3 seconds after the widget is built for the first time. In the meantime, `v` is bound to `nil`.

```clj
(f/widget
  :watch [v (Future/delayed (Duration .seconds 3) (fn [] "Surprise! 🎉"))]
  (m/Text (or v "Nothing yet...")))
```

The `nil` interim value can be overrided using the `:default` option:

```clj
(f/widget
  :watch [v (Future/delayed (Duration .seconds 3) (fn [] "Surprise! 🎉"))
          :default "Nothing yet..."]
  (m/Text v))
```

#### `:watch` + `:as` option
`:as local-name` gives a local name to the watchable.

This is especially useful for local state where the watchable is an expression:

```clj
(f/widget
  :watch [n (atom 0) :as counter]
  (m/TextButton .onPressed (fn [] (swap! counter inc) nil))
  (m/Text (str "Clicked " n "time(s)")))
```

This is functionally equivalent to:

```clj
(f/widget
  :managed [counter (atom 0)
            :dispose nil]
  :watch [n counter]
  (m/TextButton .onPressed (fn [] (swap! counter inc) nil))
  (m/Text (str "Clicked " n "time(s)")))
```

#### `:watch` + `:dispose` option
`:dispose disposing-expr` (defaults to `nil`) allows to specify how to dispose of the watched resource (see `:managed`).
It's generally used in conjuction with `:as`.

The resource will be threaded through `disposing-expr` as per `->`: `(-> resource disposing-expr)`.

Beware: `:watch`'s `:dispose` defaults to `nil` but `:managed`'s `:dispose` defaults to `.dispose`.

#### `:watch` + `:refresh-on`

The watchable will be recomputed every time a local involved in its expression is modified.

The following example illustrates the default (and sensible) behavior: each time you click the top button, the bottom button is reset to the current value of the top one.

```clj
(f/widget
  :watch [ntop (atom 0) :as top-counter
          nbottom (atom ntop) :as bottom-counter]
  m/Column
  .children
  [(f/widget
     (m/TextButton .onPressed (fn [] (swap! top-counter + 10) nil))
     (m/Text (str "Clicked " (quot ntop 10) "time(s)")))
   (f/widget
     (m/TextButton .onPressed (fn [] (swap! bottom-counter inc) nil))
     (m/Text (str "Clicked " nbottom "time(s)")))]
```

By specifying `:refresh-on refresh-expr` the watchable will be recomputed only when `refresh-expr` changes. Usually `refresh-expr` will be `nil`, a local or a vector of locals.


```clj
(f/widget
  :watch [ntop (atom 0) :as top-counter
          nbottom (atom ntop) :as bottom-counter :refresh-on nil]
  m/Column
  .children
  [(f/widget
     (m/TextButton .onPressed (fn [] (swap! top-counter + 10) nil))
     (m/Text (str "Clicked " (quot ntop 10) "time(s)")))
   (f/widget
     (m/TextButton .onPressed (fn [] (swap! bottom-counter inc) nil))
     (m/Text (str "Clicked " nbottom "time(s)")))]
```

In the above example clicking on the top button doesn't cause the bottom counter to be reset.

To test your understanding, replace `:refresh nil` by `:refresh-on (quot ntop 20)`. This will cause the bottom counter to be reset every two clicks on the top button.

#### `:watch` + `:>` option

Some watchables (like `Listenable`s) don't provide a value, they just notify they have changed with no standard way of getting the value. (By default the values successively bound by `:watch` would be successive integers, which isn't very useful.)

This leads to code like:
```clj
(f/widget
  :watch [_ some-notifier]
  :let [v (.-adHocProperty some-notifier)]
  ...)
```

This is better written as:
```clj
(f/widget
  :watch [v some-notifier :> .-adHocProperty]
  ...)
```

This change is more than cosmetic: values will be automatically deduplicated, while you would get extraneous rebuild by using the `:let`.

#### Deduplication
`:watch` triggers a rebuild only when its bound values change (according to `=`).

It means that if you have `:watch [x big-atom]` it will trigger every time the atom change. But if you have `:watch [{:keys [some-prop]} big-atom]` it will trigger only when `some-prop` changes!

So if you see spurious rebuilds maybe you have a unused bindings like in `:watch [{:keys [some-prop] :as unused-big-value} big-atom]`.

#### Watchables
`nil`, atoms, cells, `Stream`s, `Future`s, `Listenable`s and `ValueListenable`s and any extension of the `Subscribable` protocol.

#### Cells
Great for maintaining and reusing derived state; tip: try to share them via inherited bindings (see `:bind`) rather than function arguments.
`f/$` (“cache”) creates a cell.

`(f/$ expr)`, like a spreadsheet cell, updates its value each time a dependency changes.

Dependencies can be any watchable including other cells. Dependencies are read using `f/<!` (“take”). `f/<!` can be used in any function called directly or indirectly from a cell.

### `:managed` directive
Automatic lifecycle management for `*Controllers` and the like.

`:managed` takes a bindings vector like `:let` but expressions must produce objects in need of being disposed (using the `.dispose` method by default).

#### `:managed` + `:dispose` option

See [`:watch` + `:dispose`](#watch--dispose-option).

#### `:managed` + `:refresh-on` option

See [`:watch` + `:refresh-on`](#watch--refresh-on).

### `:bind` directive
Dynamic binding but along the widgets tree, not the call tree. Inherited bindings in Flutter speak.

`:bind {:k v}` establishes an inherited binding from `:k` to `v` visible from all descendants.

### `:get` directive
`:get [:k1 :k2]` retrieves values bound to `:k1` and `:k2` via `:bind` and binds these values to `k1` and `k2` in the lexical scope (the following forms).

    `:get [m/Navigator]` retrieves instance returned by `(m/Navigator.of context)` and lexically binds it to `navigator` -- implicit kebab-casing of teh Dart name.

### `:context` directive — when Flutter lacks context
`:context ctx` binds ctx to a `BuildContext` instance.

This comes handy when you have to pass a `BuildContext` to a Flutter call. However many usages of contexts in Flutter code are better served by `:get`.

### `:vsync` directive — chasing the electron beam across a phosphor screen

`:vsync clock` binds `clock` to a `TickerProvider`, generally required by animations.

### `:height`, `:width` and `:color`

Utilities directives to cut on SizedBox, ColoredBox or Container usage.

`:height` and `:width` expect a numeric value.

`:color` expects an instance of `Color` as value.

### `:padding`

Utility directive to simplify setting padding.

`:padding padding-expr` where `padding-expr` may evaluate to:
* an `EdgeInsetsGeometry` instance
* a number -- in which case it's passed to `EdgeInsets.all` to specify that it's the padding in all directions
* a map with keys amongst `:top` `:bottom` `:left` `:right` `:start` `:end` `:horizontal` `:vertical` (and numeric values)

### `:when`

`:when test` will show the rest of the widget only when test is truthy (not `nil` or `false`).



================================================
FILE: doc/BOOK.md
================================================
# The Book of ClojureDart

## Introduction

### Why ClojureDart?

Because Baptiste Dupuch wanted to do mobile development in Clojure, and Christophe Grand was foolish enough to follow.

More seriously, ClojureDart exists because we love Clojure: its simplicity, its power, its data-first mindset. We don't want to give that up just because we're building apps for phones, tablets, or the web.

Flutter provides an impressive cross-platform UI framework. With a single codebase, you can target Android, iOS, desktop, and even the web (yes, SPAs too). But for Clojure developers, Dart is not exactly a dream language.

ClojureDart bridges this gap. It lets you write idiomatic Clojure code while building high-performance Flutter apps. You get to keep your functional programming model, immutable data structures, and macros, while taking advantage of Flutter's rich widget ecosystem and smooth rendering.

This isn't about rewriting Flutter or replacing Dart. It's about giving Clojure developers a way to build modern apps *without switching mental models*. If you’ve ever dreamed of calling `(map inc xs)` inside your UI logic, or threading state updates with `->` instead of managing callbacks and setState, this is for you.

ClojureDart is both pragmatic and expressive. It's a way to stay in the language you love while building apps that run anywhere.

### Who this book is for

This book is for Clojure or ClojureScript developers who want to build mobile (desktop, web...) apps without leaving their Clojure reasoning and modeling skills behind.

You’ve probably looked at Flutter and thought: “Looks not bad, but Dart?” Or maybe you’ve written native apps before and missed Lisp.

This book doesn’t teach Clojure or Flutter from scratch. It shows how to use what you already know to build real apps with ClojureDart, in a way that stays true to the core Clojure mindset.

### What you’ll build and learn

TODO Provide a brief overview of the types of apps readers will build (e.g. task managers, multi-screen apps with data fetching) and the skills they’ll develop, such as using interop, managing state, structuring UIs, and compiling for release.

## Getting Started

### Project structure overview

A typical ClojureDart project is both a Clojure project (with a `deps.edn` file and everything where you’d expect it) and a Dart project (with a `pubspec.yaml` file and standard Flutter layout).

In Dart projects, source files live under `lib/`, with `lib/src/`  used for internal modules.

The ClojureDart compiler generates `.dart` files under `lib/cljd-out/`. This is where your Clojure code gets compiled to Dart. The directory is added to `.gitignore` by default when initializing a project, as it’s considered generated code.

### Setup and Tooling

TODO

### Hello Flutter World

TODO

## Interop with the Dart world

### Dart is more static than Java

Java, by virtue of the JVM, is more dynamic than it lets on. It has powerful reflection, supports dynamic bytecode injection, and erases generics at runtime — meaning there's no real distinction between, say, a `List<String>` and a `List<Object>` at the JVM level.

Dart, in contrast, leans heavily into static typing. It offers only limited reflection (and only in dev mode), doesn’t support dynamic code loading (outside of hot reload in dev mode), and its generics are reified: a list of strings at compile time is still a list of strings at runtime.

So you might wonder: how can ClojureDart still offer typeless interop in such a static world?

Fortunately, Dart has some dynamic roots, and a few features remain from that era — some useful, some less so:

- The special `dynamic` type tells the compiler to emit method calls even when the receiver’s type is unknown.
- The `runtimeType` field (think Java’s `.getClass()`) exists, but it can be overridden and can't be fully trusted. Combined with Dart’s limited reflection, it makes type comparison unreliable. The only reliable test is `instance?`.
- There's a `noSuchMethod` hook that lets a class catch calls to undefined methods — sort of like `method_missing` in Ruby.

ClojureDart leans heavily on `dynamic` by default. You can think of it as similar to how Clojure uses reflective calls when type information isn’t available. But because Dart is stricter, dynamic calls may sometimes pick the wrong method or behave in surprising ways.

That’s why, unlike `*warn-on-reflection*` in Clojure — which is optional — dynamic warnings in ClojureDart are always on, and you should take them seriously.

If something behaves weirdly, check for dynamic warnings. Don’t ignore them — fix them.

In fact, it’s best not to ship production builds with any dynamic warnings at all.

To enforce that, you can add `:no-dynamic true` to your namespace metadata. This will turn dynamic warnings into hard errors:

```clojure
(ns my.namespace
  "Wonderful core namespace where no dynamic calls are allowed."
  {:no-dynamic true}
  ...)
```

### Squashing "dynamic warnings"

Like reflection warnings in Clojure, dynamic warnings in ClojureDart should not be ignored — and like with reflection, you should *always fix the first one first*.

Why? Because dynamic calls often stem from type inference failures, and those tend to cascade. One missing type hint at the source can cause a whole chain of warnings downstream. Adding a single hint in the right spot might clean up several warnings at once.

So don’t go whack-a-moling from the bottom of the stack. Start at the top, add hints as needed, and you’ll often see multiple warnings disappear together.

### Requiring a Dart lib

Requiring Dart packages in ClojureDart looks just like requiring Clojure namespaces — with one small twist.

Instead of a namespace symbol, you pass a string that represents the Dart import path:

```clojure
(ns my.app
  (:require ["package:flutter/material.dart" :as m]))
```

### Collections

Just like Clojure collections are also Java collections, ClojureDart collections are also Dart collections.

And it goes both ways: Dart collections can be used (in a read-only way) with functions like `get`, `nth`, `seq`, and friends. So you can treat a Dart list much like a Clojure sequence — at least when reading from it.

Now, since Dart generics are not erased (unlike on the JVM), you might wonder: how can a Clojure vector — which can hold values of any type — be used in a place where Dart expects a `List<String>` or `List<Widget>`?

That’s where ClojureDart’s “magicast” kicks in. When the compiler sees that you’re passing a dynamically-typed value to a Dart method expecting a specific type, it automatically inserts checks and type conversions behind the scenes.

Let’s say you’re using Flutter’s `m/Column`, which expects a `.children` argument of type `List<Widget>`. But you have a Clojure vector of widgets — which is a Dart list, yes, but it defaults to being a `List<dynamic>`.

So what happens?

The compiler will check that what you’re passing is indeed a `List`. If it’s not already a `List<Widget>`, it will insert a `.cast<Widget>()` call on it — just like you might do manually in Dart. That way, Dart gets what it expects, and you don’t have to manually cast anything.

Here’s the clever bit: ClojureDart collections can be *cast* to any type. The root object changes, but the underlying structure is preserved and shared. In other words, the collection lies about its element types — and it works, *as long as you’re not lying too hard*.

If the collection claims to be a `List<Widget>`, but actually contains something that’s not a widget, Dart will throw a runtime exception when it tries to access that element.

So back to our `m/Column`: you can safely pass a Clojure vector of widgets as `children`, and it’ll Just Work™ — but only if it’s *really* a list of widgets.

```clojure
(m/Column
  .children
  [(m/Text "Hello")
   (m/Text "Magicast")])
```

### Functions

Simple ClojureDart functions — meaning: no multiple arities, no varargs — are also Dart functions.

That means you can pass them directly to Dart APIs expecting a function, without wrapping or conversion. It just works.

Functions are one of the areas where we’d really like to extend **magicast** in the future. Right now, interop works well with straightforward cases, but adding support for more complex Clojure function shapes (like multi-arity or rest args) would make things a lot smoother.

### Optional parameters (named or positional)

Sometimes interop means you need to implement a Dart function or method that takes optional parameters. Dart has two kinds: named and positional — and ClojureDart has syntax for both.

Here's how it works:

- `[a b c .d .e]`
  → Three required positional parameters (`a b c`) and two *named* optional parameters: `d` and `e`.

- `[a b c ... d e]`
  → Three required positional parameters, followed by two *optional positional* ones: `d` and `e`.

You can also specify default values:

- `[.a 42 .e]`
  → Two named parameters. `a` has a default value of `42`, `e` has no default.

- `[... a 42 b]`
  → Two optional positional parameters. `a` defaults to `42`, `b` has no default.

The dot (`.`) means “named” and the ellipsis (`...`) means “optional positional.” You’ll get used to it.


### Calling instance methods

Calling instance methods in ClojureDart is almost one-to-one with Dart — just with Clojure syntax.

```
obj.methodName(arg1, arg2, ...) // Dart
(.methodName obj arg1 arg2 ...) ; ClojureDart
```

Straightforward, right?

But Dart also has named arguments, and ClojureDart supports them too. The only catch: they have to come after all positional arguments, just like in Dart. You use dotted symbols to specify them:

```
obj.methodName(p1, p2, name3: p3, name4: p4) // Dart
(.methodName obj p1 p2 .name3 p3 .name4 p4) ; ClojureDart
```

It reads cleanly once you know the trick: dots introduce named argument keys.

For those wondering “why not keywords?” — the compiler needs to syntactically tell apart calls with named arguments from calls that happen to pass keywords as regular values. And the dot is already associated with anything interop.

### Accessing instance fields

Getting a property is simple:

```
obj.prop // Dart
(.-prop obj) ; ClojureDart
```

Setting one? Also easy:

```
obj.prop = x // Dart
(.-prop! obj x) ; ClojureDart sugar
(set! (.-prop obj) x) ; classic Clojure style
```

In Dart, properties are more than just fields — they often come with getters and setters behind the scenes. So while Java fields tend to be private and accessed through methods, Dart APIs commonly expose public properties directly.

That’s why (.-prop! obj x) is the preferred idiom in ClojureDart: it’s concise, idiomatic, and plays nicely with doto.

```clojure
(doto (m/Paint)
  (.-color! m/Colors.green)
  (.-style! m/PaintingStyle.stroke))
```

It keeps the code clean and expressive, especially when setting up objects with several properties in a row.

### Object destructuring

As we’ve seen, accessing properties is a big part of working with Dart APIs. So ClojureDart extends Clojure’s usual destructuring forms to support object property access too.

In addition to `:keys`, `:syms`, and `:strs`, you can use `:flds` to destructure fields:

```clojure
(let [{:flds [year month day]} (DateTime.now)]
  ...)
```

In this example, the compiler can infer the type of the object (`DateTime`) from context, so it knows which fields to pull out.

In more dynamic situations — say, if the type isn't obvious — you can give the compiler a hint, either directly on the destructuting map:

```clojure
^DateTime {:flds [year month day]}
```

Or as a hint on the alias within the binding map:

```clojure
{:flds [year month day] :as ^DateTime dt}
```

Either way, this helps the compiler insert the right property lookups safely and efficiently.

In addition to `:flds` you can also write :

```clojure
{y .-year m .-month d .-day}
```

### Tear-off methods

Surprisingly enough, in Dart you can access a method like a field — and what you get is a function that behaves just like the method, except it already knows its receiver (the object it belongs to). This is called a *tear-off*.

That means method calls can be treated like any other function call, which plays very nicely with Clojure’s functional style.

A common example is with the `Completer` class from `dart:async`, which is used to create promise-like futures.

Here's the typical approach:

```clojure
(let [completer (da/Completer)]
  (do something async and call (.complete completer v))
  (await (.-future completer)))
```

But thanks to tear-offs and object destructuring, you can make this cleaner:

```clojure
(let [{:flds [complete future] (da/Completer)]
  (do something async and call (complete v))
  (await future))
```

Much nicer, right? Tear-offs let you treat methods as first-class functions — just another thing to pass around.

### Constructors

In ClojureDart, there's no need to write `(new Object)` or `(Object.)`. Calling the default constructor is as simple as `(ClassName)`.

But wait — what *is* the default constructor? Here's something important to know about Dart: unlike Java or Clojure, Dart doesn't support method overloading. That means no multiple arities — not for regular methods, not for constructors. One method name, one signature.

To work around that, Dart uses *named constructors*. For example, the `DateTime` class has several: the default one, plus named constructors like `now`, `utc`, `fromMillisecondsSinceEpoch`, and `fromMicrosecondsSinceEpoch`.

Here’s how that looks in ClojureDart:

```clojure
(DateTime)
(DateTime.now) ;; or (DateTime/now)
(DateTime.fromMillisecondsSinceEpoch 1234567)
```

In Dart (and ClojureDart), constructor calls are syntactically indistinguishable from static method calls. And to make things more interesting, constructors don't even guarantee to return a new instance — they can be const or factory constructors.

That's why there's no new in ClojureDart: it wouldn’t really mean what you'd expect it to.

And yes, just like methods, constructors can be torn off and used as first-class functions:

```clojure
DateTime.fromMillisecondsSinceEpoch
DateTime.new ;; tear-off for the default constructor
```

### `const` Constructors

Dart has a notion of `const` values — and it's not just about making things immutable. A `const` value in Dart is a *compile-time constant*: it gets fully computed during compilation and is then memory-mapped into your app at runtime. This means no allocation, no instantiation — just reusing a shared value. It's efficient, but it has consequences.

In ClojureDart, `const` is used by default whenever possible. Most of the time, that’s exactly what you want. But sometimes it leads to surprising behavior.

For instance, suppose you're creating sentinel values using `(Object)`. In Dart, `Object`'s default constructor is marked as `const`. So if you write that expression multiple times, you’ll actually get *the same exact instance* every time. Not because of interning or caching, but because the compiler literally snapshots the value and reuses it.

If you're relying on object identity — say, for sentinel values or markers — this can break your logic. To force a fresh instance every time, use the `^:unique` metadata:

```clojure
^:unique (Object)
This tells the compiler: don’t treat this like a compile-time constant; I want a new instance each time.
```

Use ^:unique whenever identity matters.


### Calling static methods

There are two main ways to call a static method in ClojureDart:

```clojure
(ClassName/methodName ...)   ; old-school style
(ClassName.methodName ...)   ; modern style
```

The slash form (ClassName/methodName) is a bit of a legacy carryover — it only works if the class is local or explicitly imported. If you're using an alias, it won’t work.

That’s where the dot form comes in handy. It plays nice with aliases:

```clojure
(alias/ClassName.methodName ...)
```

Also worth knowing: Dart doesn't have fully qualified class names like Java does. Once imported, class names are just identifiers under an import prefix — no package-style nesting. This explains why the slash form while prevalent in Clojure feels old-school in ClojureDart.

### Static property access

Static properties in Dart — like `Colors.purple` — are straightforward to use in ClojureDart too.

Just write:

```clojure
m/Colors.purple
```

And yes, you can chain them just like in Dart:

```clojure
m/Colors.purple.shade900
```

Even method calls at the end of the chain work:

```clojure
(m/Colors.purple.shade900.withAlpha 128)
```

Of course you can also write `(.-purple m/Colors)` -- this can be easier when generating code in macros.

### Calling extension methods

[Extension methods](https://dart.dev/language/extension-methods) in Dart are a bit of syntactic sugar — and ClojureDart doesn’t have a great equivalent yet, mostly because they rely heavily on static typing.

Take `DateTime` for example. It has an extension called `DateTimeCopyWith`, which adds a `copyWith` method.

But here’s the trick: extension methods aren’t real instance methods. They’re just static methods dressed up to *look* like instance methods.

In ClojureDart, you can still call them — you just have to be a bit more explicit:

```clojure
;; assuming `dt` is a DateTime
(-> dt dart:core/DateTimeCopyWith (.copyWith .day 1))
```

One important caveat: the `(-> dt dart:core/DateTimeCopyWith)` part is not a value by itself. It only makes sense when followed by a method call. We’re piggybacking on Dart’s sugar here, not working with actual objects.

### `instance?`

In Clojure, `(instance? (identity String) "a")` works just fine — the class can be passed as a value, unwrapped, etc. But in ClojureDart, things are a bit stricter.

That’s because in Dart, the type used in an `is` check must be statically known — it has to appear *literally* in the code. So in ClojureDart, only something like `(instance? String "a")` is valid. You can’t sneak the class in through a variable or a function call.

In short: `instance?` exists, but it’s not a real function — it’s special syntax that must be fed a class name directly.


### Non-nullable types

Here’s another key difference with Java — and one to watch for when writing shared `cljc` code: Dart types are *not* nullable by default.

So if you write `^String x` in Clojure, `x` can still be `nil`. But in ClojureDart, that same type hint means `x` is *not allowed* to be `nil`.

If you want to allow `nil`, you need to say so explicitly with `^String? x`.

In short: nullable types must be marked with a `?`. No question mark, no `nil`.

### Generics

In Java, generics are erased at runtime, which is why Clojure doesn’t need to care about them.

But Dart *does* preserve generics at runtime, so ClojureDart has to deal with them — and the solution is a bit of a hack (a clever one?).

We piggyback on tagged literals: `#/(Map String Future)` is a tagged literal where the tag is `/`. It reads as `^{:type-params [String Future]} Map`. The key thing to note is that it’s parsed as a *symbol*, which means you can use this syntax *anywhere a symbol is valid* — method names, constructors, wherever.

For nested generics, no need to repeat the tag:

```clojure
#/(List (Map String Future)) ; equivalent to List<Map<String, Future>> in Dart
```

Simple and flexible, if a bit quirky.

We are considering leveraging the `^[]` shorthand  introduced in Clojure 1.12 as an alternative way to denote generics: `^[String Future] Map`, `^[^[String Future] Map] List`.

## UI with Flutter and `cljd.flutter`

### Flutter architecture: the three trees

When working with Flutter, you mostly think in terms of *widgets*—but under the hood, there are actually **three** distinct trees at play: the **widget tree**, the **element tree**, and the **render object tree**.

Let’s break them down:

**The Widget Tree**
This is the tree you write. It’s immutable—a pure description of what the UI *should* look like. Think of it as a blueprint or configuration.
Even `StatefulWidget`s are immutable! How is that possible?

Well, `StatefulWidget` only *describes* how to create and manage state—it doesn't actually hold the state. It's like a reducing function in `transduce`: the function is pure and stateless, but its different arities create, update and dispose state. Same idea here.

**The Element Tree**
This is where the state lives. Each widget in the widget tree is paired with an element in the element tree—there’s a 1:1 mapping.
When Flutter "updates" a widget (e.g. after a `setState` call), it creates a new widget instance and gives it to the existing element. The element then updates *itself* to reflect the new widget configuration.

**The Render Object Tree**
Some elements—those that actually take up space on screen—create **render objects**.
These are the heavy lifters: they handle layout, painting, and hit testing (i.e., touch input). This is the lowest layer of the UI system, and the one that talks directly to the screen or the screen reader.

### `cljd.flutter`

ClojureDart includes the `cljd.flutter` library — a small set of helpers to simplify interop with Flutter and reduce boilerplate.
It’s not a framework or an abstraction layer: just some utilities to make things smoother.

Flutter in Dart tends to be verbose.
In Clojure, we lean on macros instead of IDE autocompletion.

### `f/widget` the ultimate flattener

The main macro provided by `cljd.flutter` is `f/widget` (assuming you use the alias `f`).
`f/run` and `f/build` follow the same structure.

**`f/widget` is a threading macro tailored for building Flutter UIs.**

Flutter uses fine-grained widgets, which often leads to deep nesting.
Most of these widgets take a single child, usually via the named `.child` argument. For example:

```clojure
(m/DefaultTextStyle.merge
  .style (m/TextStyle .fontSize 36)
  .child
  (m/DecoratedBox
    .decoration (m/BoxDecoration .color m/Colors.pink)
    .child
    (m/Center
      .child
      (m/Text "Hello ?"))))
```

With `f/widget`, you can flatten this code into a more readable sequence:

```clojure
(f/widget
  (m/DefaultTextStyle.merge
    .style (m/TextStyle .fontSize 36))
  .child
  (m/DecoratedBox
    .decoration (m/BoxDecoration .color m/Colors.pink))
  .child
  (m/Center)
  .child
  (m/Text "Hello ?"))
```

It works by threading each form into the one above it, using the preceding named argument.

Since `.child` is by far the most common, you can omit it:

```clojure
(f/widget
  (m/DefaultTextStyle.merge
    .style (m/TextStyle .fontSize 36))
  (m/DecoratedBox
    .decoration (m/BoxDecoration .color m/Colors.pink))
  (m/Center) ; these parens could be omitted
  (m/Text "Hello ?"))
```

This keeps the structure flat and easier to follow — with no magic and no abstraction over Flutter itself.

### `f/widget` directives

`f/widget` supports a few extra forms known as **directives**.
Each top-level keyword is treated as a directive, and the form that follows it defines how the directive behaves.

If that sounds abstract, here’s a simple example using the `:let` directive:

```clojure
(f/widget
  (m/DefaultTextStyle.merge
    .style (m/TextStyle .fontSize 36))
  (m/DecoratedBox
    .decoration (m/BoxDecoration .color m/Colors.pink))
  (m/Center)
  :let [msg "Hello ?"]
  (m/Text msg))
```

In this case, `:let` just introduces a local binding without needing to wrap the whole expression in a separate `let`.

Simple keywords without a namespace are reserved for `cljd.flutter` itself.
**Namespaced keywords can be used for custom or third-party directives** — we’ll cover those later on.

### Managing state: the `:watch` directive

The `:watch` directive causes widgets below it to rebuild when watched objects change.

The `:watch` directive works a lot like `:let`: it takes a binding vector.
But there’s one key difference — it doesn’t bind the left-hand symbol to the value you give it. Instead, it binds it to whatever value comes *out of* the right-hand expression.

Here’s a simple example:
`:watch [x (atom 42)]` will bind `x` to `42`, not the atom.
That’s because `:watch` automatically derefs the right-hand value.

But that’s just the beginning. `:watch` works with anything that implements the `cljd.flutter/Subscribable` protocol. That includes:

- `nil` — surprisingly useful,
- Atoms,
- Streams — no need for `StreamBuilder`,
- Futures — no need for `FutureBuilder`,
- `ValueListenable` — no need for `ValueListenableBuilder`,
- `Listenable` — no need for `ListenableBuilder`.

And since it’s a protocol, you can extend it for your own types.

Sometimes you want more than just the dereferenced value.
`:watch` lets you attach options right after the binding pair.

Let’s say you need access to the atom itself, not just its value. You can do this:

```clojure
:watch [x (atom 42) :as my-atom]
```

Now x holds the value, and my-atom holds the atom.

Here are the available options:

- `:as name` — gives you the original value (e.g., the atom or stream),
- `:default val` — used if the value isn’t immediately available (like with streams or futures),
- `:> expr` — applies `(-> watched-object expr)` to extract the actual value (useful for Listenable),
- `:dispose expr` — used to clean up when the watchable is no longer needed (applied as `(-> value expr)`),
- `:value> expr` — applies `(-> watched-object expr)` to transform the actual value before deduping/destructuring,
- `:dispose-value expr` — used to clean up manageable values when a new value is produced or the watchable is no longer needed (applied as `(-> value expr)`),
- `:refresh-on expr` — forces the right-hand expression to be re-evaluated when `expr` changes.
By default, it re-evaluates if any local used in the right-hand side changes.
Use `:refresh-on nil` (or any constant) to turn reevaluation off completely.

> A quick note: `:refresh-on` is there when you really need it, but it might be a sign your design could use a rethink.

**Destructuring support**

Last but not least, :watch is destructuring-aware:

```clojure
:watch [{:keys [the-key]} busy-atom]
```

> Even if the atom holds a large map, this `:watch` will only trigger a rebuild when `:the-key` actually changes. Handy when you want to stay efficient and avoid unnecessary UI updates.

**`:value>`**

Normally, `:watch` binds you directly to the values produced by its source expression. With `:value>`, you can transform those values before binding, deduplication and destructuring will apply on the transformed value.

```clojure
:watch [binding expr :value> form]
```

Each time `expr` produces a new value, `form` is applied to it (via `->`) and the result is what gets bound.

Example:

```clojure
:watch [{:keys [username]} app-state
        :value> clojure.string/lower-case]
```

Here, whenever `app-state` changes, the `username` field is automatically lower-cased before being made available to the widget.

This avoids boilerplate “post-processing” in the body of the widget and potentiually unneeded rebuilds — the watch itself delivers the transformed values.

**`:dispose-value`**

Sometimes, values produced by a watch hold resources, most of the time it's because you are watching on Future for some initialization. When a new value replaces the old one, you may want to clean up the old resource. `:dispose-value` lets you do that.

```clojure
:watch [binding expr :dispose-value form]
```

Each time `expr` produces a new value, the previous value (if non-nil) is passed through `form` (again via `->`) before being discarded.

Example:

```clojure
:watch [controller (make-controller opts)
        :dispose-value .dispose]
```

Now, whenever the controller is replaced, the previous one is properly disposed.

If you don’t need customization, `:dispose-value true` is shorthand for `:dispose-value .dispose`.


### Managing state: the `:managed` directive

The `:managed` directive is for resources that need to live and die with the widget — things like controllers or other stateful/expensive objects.

It looks a lot like `:watch`: same binding vector, same optional keyword-based options.
But it behaves more like `:let`: it binds the left-hand symbol to the right-hand value.
The key difference is that `:managed` keeps that value around — it doesn’t re-evaluate it on every rebuild.

Just like `:watch`, `:managed` will re-evaluate its value when any of the locals it depends on change. You can control that behavior with options:

- `:dispose expr` — used to clean up the resource when it's no longer needed. Applied as `(-> value expr)`.
  By default, it calls `.dispose`. Use `nil` or `false` to disable cleanup.
- `:refresh-on expr` — forces the right-hand side to be re-evaluated when `expr` changes.
  Defaults to tracking any dependent locals. Use `:refresh-on nil` (or a constant) to turn it off completely.

There’s a bit of overlap between `:managed` and `:watch` — that’s by design. Some patterns become simpler this way:

```clojure
(f/widget
  :watch [n (atom 0) :as counter]
  ...)
```
Is just shorthand for:

```clojure
(f/widget
  :managed [counter (atom 0) :dispose nil]
  :watch [n counter]
  ...)
```

**Example**

Flutter has a lot of `*Controller` classes. These are a great use case for :managed because they’re stateful and need to be disposed cleanly.

Here’s a function that returns a text input widget, initialized with a string and calling `update!`` when the user submits:

```clojure
(defn text-input [init update!]
  (f/widget
    :managed [ctrl (m/TextEditingController .text init)]
    (m/TextField
      .controller ctrl
      .onSubmitted (fn [s] (update! s) nil))))
```

A common gotcha is calling `update!` on every change. That often leads to triggering a rebuild, which in turn disposes and recreates the controller — and you lose caret position and IME state.

There are two main ways to avoid this:

You can use `:refresh-on` to prevent rebuilds when `init` changes — but that might create other headaches.
Or you accept that not everything needs to live in global state. Some transient state is fine.
And that’s totally reasonable here. `TextEditingController` implements `ValueListenable`, which means it’s `:watch`-compatible.
**So other parts of the UI can react to text field changes without wiring up callbacks.** Clean and efficient.

### Telling siblings apart: the `:key` directive

In its eagerness to be fast, Flutter may conclude too hastily that two *stateful* objects are the same if they are of the same class. Two `TextField` next to each other in a `Row`? Swap them and... nothing happens because they have compatible states!

The rule is simple: when you have siblings (usually introduced by `.children` or `.slivers` but they can be created on demand too by constructors such as `ListView.builder`) you'd better put a `:key` on them!

In `:key k`, `k` can be any value, it just has to be unique amongst siblings, not globally (see `:global-key` for that).

You can skip keys if your siblings’ number and order never change, like in most simple `Column`s and `Row`s.

If you want to conditionally show or hide an item in a column, consider using `:when` instead of removing or adding items to the siblings list.

### Reacting to changes without rebuilding `::f/with-notifier`

Sometimes you need a widget to react not by rebuilding, but by nudging a `CustomPainter` or some other object living outside the widget tree. Flutter has `ValueNotifier` for that; ClojureDart has `::f/with-notifier`.

```clojure
::f/with-notifier ([name init] widget-directives... expr)
```

This directive binds `name` to a `ValueNotifier` initialized with `init`. The notifier is then updated with the value of `expr` each time it changes. From the widget’s point of view, `name` is just another binding — but it lives beyond the tree, ticking away with new values.

Example:

```clojure
::f/with-notifier ([progress-notifier 0]
                   :watch [{:keys [progress]} app-state]
                   :animate [progress progress]
                   progress)
```

Here, `progress-notifier` receives interpolated (animated) values of `progress`. You can pass it down to a `CustomPainter` to trigger repaints without forcing the whole widget tree to rebuild. It’s a simple way to decouple “data changes” from “widget rebuilds.”

## Data, I/O and Side Effects

## Drawing

## `doto-layer`

Drawing on a canvas is often scoped: you want to apply a transform, clipping, filter or blend mode to a group of operations as a whole.

Flutter gives you two main tools: `Canvas.save`/`restore` (for transforms and clipping) and `Canvas.saveLayer`/`restore` (which adds full offscreen compositing with a `Paint`).

In ClojureDart, you don’t need to remember which one to use: just call `doto-layer`.

```clojure
(doto-layer canvas [paint rect?]? & body)
```

It works like `(doto canvas ...)`, but with an implicit scope.

* If `[paint rect?]` is provided, the body runs inside a `saveLayer`/`restore`.
  The offscreen result is then composited back onto the canvas with the given `paint`.
* If no arguments are provided, the body runs inside a plain `save`/`restore`.

In both cases, on exit, transforms and clipping are restored to their initial values.

**Example**

```clojure
(doto-layer canvas [blend-paint nil]
  (.translate 50 50)
  (.drawRect (f/Rect.fromLTWH 0 0 40 40) red-paint)
  (.drawRect (f/Rect.fromLTWH 20 20 40 40) blue-paint))
```

Here the two overlapping rectangles are drawn offscreen and then blended back onto the canvas according to `blend-paint`.

If you just wanted to scop the transform it could have been:

```clojure
(doto-layer canvas ; no vector
  (.translate 50 50)
  (.drawRect (f/Rect.fromLTWH 0 0 40 40) red-paint)
  (.drawRect (f/Rect.fromLTWH 20 20 40 40) blue-paint))
```

See [`Canvas.save`](https://api.flutter.dev/flutter/dart-ui/Canvas/save.html) and [`Canvas.saveLayer`](https://api.flutter.dev/flutter/dart-ui/Canvas/saveLayer.html) for the fine details of `rect` and `paint`.

## `doto-image-canvas`

Sometimes you don’t want to draw directly to the screen. You want an offscreen buffer, an `Image`, that you can later paint anywhere, reuse, or cache. Enter `doto-image-canvas`.

```clojure
(doto-image-canvas [w h] & body)
```

It creates an offscreen canvas of size `w × h`, runs the body as a `(doto canvas ...)`, and returns the resulting `Image`.

Example:

```clojure
(def star-image
  (doto-image-canvas [100 100]
    (.drawPath star-shape star-paint)))
```

Here `star-image` is just a regular Flutter `Image`, built offscreen. You can paint it on a canvas later with `.drawImage`, or wrap it in an `Image` widget if you prefer.

Note: returned images are lazy at a low level — they may not be rendered by the GPU immediately. The Clojure code runs eagerly and produces a list of GPU operations, but the actual rendering can be deferred until later.


## Advanced Topics

### FFI to C/ObjC/Java/Swift

### Testing

### Deploying Apps

### Performance and Debugging



================================================
FILE: doc/differences.md
================================================
# Differences with Clojure

## Dart

ClojureDart targets [Dart](https://dart.dev/) (surprise!) and, through Dart, [Flutter](https://flutter.dev/) a GUI framework for mobile, desktop and web.

Dart has three compilation targets:
 * its own VM which is mostly used at dev time because it allows for more tooling,
 * native code,
 * javascript.

## Missing features
 * [REPL](https://github.com/Tensegritics/ClojureDart/issues/6)
 * [multimethods](https://github.com/Tensegritics/ClojureDart/issues/3)

## Divergent features
### ns, :require, :use and :import
In ClojureDart `:require` and `:use` supersedes `:import` and thus `:import` is rarely used.

To use a Dart library, just put its URI as a string in lieu of the symbol referring to a namespace. Then you can use `:as`, `:refer`, `:rename` as with a regular Clojure(Dart) namespace.

```clj
(ns acme.main
  (:require ["package:flutter/material.dart" :as m :refer [Colors]]))
```

Like in Clojurescript "Naked `:use`" is not supported: you must always provide a `:only` list.

### no `instance?`
Instead there is a special `dart/is?` where the type must be a literal `(dart/is? x SomeType)`. We have a [workaround planned](https://github.com/Tensegritics/ClojureDart/issues/11) to allow for good old `instance?` despite the platform limitations.

### Protocols
Unlike Clojure and like Clojurescript, ClojureDart is extensively based on protocols.

Like Clojure default extensions are provided by extending to `Object` and/or `Null`.

However instead of extending to `Object` or `Null`, it's often preferable to extend to the `fallback` pseudotype which has two distinctive qualities:
 * it has a lower priority than other extensions,
 * `satisfies?` returns `false` for objects which use a fallback implementation.

### `new` and `.` can be omitted
The usage of `new` and `.` for constructors are optional. You can write `(List)` instead of `(List.)` or `(new List)`.

### Records

For now record creation requires 3 additional arguments: meta, extmap and hash, like: `nil {} -1`:
```clj
(defrecord R [a])
(R. "arg" nil {} -1)
(new R "arg" nil {} -1)
```

## try/catch

In Dart, when one catch an exception, the stacktrace isn't attached to the exception. Thus in ClojureDart if you want to capture the stacktrace you have to specify an extra name after the exception name in catch:

```clj
(try
  ...
  (catch io/HttpException e ; no stack trace binding
    ...)
  (catch Exception e st ; stack trace binding
    ...))
```

When porting some Dart code you may encounter "catch-alls": `catch` clauses with no type. They are syntactic sugar for the `dynamic` type, so in ClojureDart you would write:

```clj
(try
  ...
  (catch dynamic e
    ...))
```

## Macros
Until ClojureDart is self-hosted macros will be a bit special: they are evaluated on the JVM so if they need some support functions from your namespace then these functions must be tagged with `^:macro-support` to also be available to macros.

To be clear we are talking about cases like this:

```clj
(defn ^:macro-support do-expand [expr] ...)
(defmacro my-macro [expr]
  (do-expand expr)) ; do-expand declaration must be tagged as :macro-support
```

Code like this is fine:
```clj
(defmacro my-macro [& body]
  `(my-fn (fn [] ~@body))) ; it's ok, nothing special to do
```

## Lazy defs
`def`s are not initialized in order but lazily on a by-need basis. This is a consequence of Dart tree-shaking and fast startup goals.

## Interop
### Member names as strings
Dart considers operators calls to be syntactically sweetened methods calls (`a+b` is going to call the `+` method on the object `a` with argument `b`).

It follows that `(.+ a b)` or `(. a + b)` are valid ClojureDart expresions.

However while Dart is very conservative in which characters can appear in an identifier (`a-zA-Z0-9$_`) its operators names are not all valid Clojure symbols, for example: `^`, `[]`, `[]=`, `~/` ...

To work around this issue, **member names are allowed to be strings**: `(. a "[]=" i v)` is the ClojureDart equivalent of `a[i]=v`.

This also applies when implementing operators in `reify`, `deftype` or `defrecord`.

### Static members and libs aliases

When it comes to referring to classes **in Clojure** either you have imported the class and you can refer to it by its unqualified name (e.g. `Thread`) or you refer to it using its fully qualified name (e.g. `java.io.File`).

**In ClojureDart** since lib names are URIs they usually don't make for legal symbols thus to refer to a class (or any toplevel of a lib) you either `:refer` it and use its unqualified name (e.g. `Future`) or you refer to it with the lib alias (e.g. `io/HttpException`).

However when you want to access a static member **in Clojure** you would write `(Thread/currentThread)` for a static method or `java.nio.charset.StandardCharsets/UTF_8` for a static field.

**In ClojureDart** you write `(painting.EdgeInsets/only :left 16)` for a static method and `material.InputBorder/none` for a static property. Note that in thes cases the alias and the class name are concatenated to make the namespace of the symbol.

### reify/deftype
#### `^:abstract`
**`deftype`**
A type name can have the `:abstract` metadata to indicate the generated class to be abstract.

#### `:extends`
**`reify` and `deftype`**
One can derive from a super class by specifying a class (with a no-arg constructor) or a constructor expression. For `deftype` only fields can be used in the constructor expression.

```clj
(reify
  :extends material/StatelesWidget
  (build [_ ctx] ...))
```

#### `:type-only`
**deftype**
The `:type-only` option instructs `deftype` to not create factory function (`->MyType`).

#### `^:mixin`
**`reify`, `defrecord` and `deftype`**
This metadata on implemented classes specify these classes should be considered [mixins](https://dart.dev/guides/language/language-tour#adding-features-to-a-class-mixins) and not [interfaces](https://dart.dev/guides/language/language-tour#implicit-interfaces).

#### `^:getter`/`^:setter`
**`reify`, `defrecord` and `deftype`**
Method names can be tagged with `:getter` and/or `:setter` if the method is in fact a [property](https://dart.dev/guides/language/language-tour#getters-and-setters).

For a getter you must provide a 1-arg arity of the method (`[this]`) and for a setter a 2-arg arity (`[this new-value]`).

#### `^:mutable`
**deftype**
`deftype` parameters can be tagged as mutable. Once mutable the field can be modified with `set!`.

Below an example with 3 equivalent methods setting the val field.

``` clj
(deftype Example [^:mutable ^int val]
  (method [this new-val]
    (set! val new-val))
  (method2 [this new-val]
    (.-val! this new-val))
  (method3 [this new-val]
    (set! (.-val this) this new-val)))
```


#### Calling `super`
When you must call the `super` implementation (since one can now extend a super type) you have to add metadata on the "this" at the super call site. For example when implementing a [State](https://api.flutter.dev/flutter/widgets/State/initState.html) one can write:

```clj
(initState [self]
  (.initState ^super self)
  ...
  nil)
```

### Tests
Tests written with `cljd.test` can be run with `dart test` (or `flutter test`).

## Specific features
### [Named parameters](https://dart.dev/guides/language/language-tour#named-parameters)
Dart methods may take named parameters, to call them in ClojureDart just use a keyword as the parameter name.

```clj
(widgets/IndexedStack.
  :sizing rendering.StackFit/expand
  :index 1
  :children [...])
```

### Generics
Unlike Java, Dart generics are not erased — it means that on the JVM at runtime a `List<String>` is just a `List` but that in Dart at runtime it's still a `List<String>`. This creates two problems: expressing parametrized types and dealing with the mismatch between strong typing of collections items and Clojure's collections.

#### Parametrized types

`#/(List String)` is the ClojureDart pendant of Dart `List<String>` and is in fact a tagged literal producing `^{:type-params [String]} List`. Thus parametrized types are symbols as usual.

#### Typed collections

ClojureDart's own persistent collection are parametrized: you can have a `#(PersistentVector String)` but it's just there to placate Dart type checker. A vector can always hold values of any type irrespective of its type parameter.

Its type parameter will only be enforced at runtime when used as a Dart collection of this type.

Two vectors containing the same items but with different type parameters are still equal.

When a `List` of a given type is expected the [`cast`](https://api.dart.dev/stable/2.9.3/dart-core/List/cast.html) method can be used to get a vector of the expected type. It's really a lightweight operation as only the root object is changed.

Furthermore, ClojureDart will automatically emit such `cast` calls. This means that in practice you can pass a Clojure vector (or a set or a map) where a typed List (resp. a Set or a Map) is expected and it will just work — as long as the items are of the right type, or at least those that will be looked up.


### Dart literals

#### Dart lists

```clj
#dart [1 2 3] ; a growable List<dynamic>
#dart ^:fixed [1 2 3] ; a fixed List<dynamic>
#dart ^int [1 2 3] ; a growable List<int>
#dart ^:fixed ^int [1 2 3] ; a fixed List<int>
```

Fixed [Dart lists](https://api.dart.dev/stable/2.9.3/dart-core/List-class.html) are the closest you can get to arrays in Dart — well, except for [typed_data](https://api.dart.dev/stable/2.16.1/dart-typed_data/dart-typed_data-library.html) when you deal with arrays of scalar values.

#### Dart Records (only in <3.0.0)

``` clj
;; creating records
#dart (1 2) ; a Record of type (int, int)
#dart (1 2 .bar "hey") ; a Record of type (int, int, {String hey})
#dart () ; the empty Record

;; type hinting records
(defn ^#/[int int .bar String] returns-record [] #dart (1 1 .bar "hey"))

;; consumings records
(-> #dart (1 2) .-$1) ;; returns 1
(-> #dart (1 2) .-$2) ;; returns 2
(-> #dart (.hey "ho") .-hey) ;; returns "ho"
```

[Dart records](https://dart.dev/language/records) are a tuple like structure perfect for holding heterogeneous data.

### Nullability and `^some`

Nowadays in Dart, types are not nullable by default. It means that if you type something as `String` then it can't hold `nil`. You have to type it as `String?`.

On a related topic if you want to type-hint a function as returning "`nil` or something but definitely not a boolean" then use the pseudotype `some`. that's the typehint for example of `seq`. This allows to only test for `nil` in boolean contexts.

### async/await

This is a more low-level solution than what a `core.async` port could bring.

Put the metadata `^:async` on a function or method to make it [asynchronous](https://dart.dev/guides/language/language-tour#asynchrony-support) but most of the time you don't need to because **if a function uses `await` it will be implicitely considered async**.

`await` is a macro on top of the special `dart/await`. The difference between the two is that `await` will convey dynamic bindings.



================================================
FILE: doc/FAQ.md
================================================
# FAQ
## Dynamic Warnings
"Dynamic warnings" are similar to "reflection warnings" in Clojure but more serious and should be dealt with as soon as possible (starting by the first one, as they tend to cascade).

"Dynamic warnings" and "reflection warnings" are similar because they have the same cause: the compiler is not able to infer the type of the object upon which a method is called.

However Dart, by design, doesn't offer the relective features the JVM has. That's why the code emitted by ClojureDart in case of a dynamic warning has more chances to fail than the code emitted by Clojure in case of a reflective call.

So dynamic calls:
* are slower
* can fail at runtime because their arguments weren't properly casted to the correct type.
## Extension Methods
> Extension methods add functionality to existing libraries... Extensions can define not just methods, but also other members such as getter, setters, and operators. Also, extensions can have names, which can be helpful if an API conflict arises.

We currently do not correctly infer extension methods as methods, but you can still use them with our custom syntax.
Let's take the example of `DateTimeCopyWith` from `dart:core`, which can be found at https://api.flutter.dev/flutter/dart-core/DateTimeCopyWith.html .

This class exposes a new extension method called `copyWith`, which allows you to create a copy of a DateTime object and override its properties according to your needs.

In pure Dart, you would write the following code:
``` dart
var now = DateTime.now();
var nowPrecedentYear = now.copyWith(year: now.year - 1);
```
In ClojureDart for extensions methods you would write:

``` clojure
(let [now (DateTime/now)]
    (-> now dart:core/DateTimeCopyWith (.copyWith .year (dec (.-year now)))))
```
⚠️ Please note that we understand that being able to call extensions as regular method calls would be ideal, but we have not reached that point yet.

## Conditional reading, CLJC
Currently CLJD uses the Clojure reader so the `:clj` features in conditional is always on so **you have to put `:clj` last in your conditionals**.

Second, when you need a macro (which is currently compiled by Clojure) to use some Clojure path, it's better to use `:cljd/clj-host` so as to not confuse "clj-for-clj" and "clj-for-cljd-macros".



================================================
FILE: doc/flutter-helpers.md
================================================
# `cljd.flutter.alpha`

`cljd.flutter.alpha` strives to unclutter Flutter code 😜.

Its two goals are to cut on Flutter boilerplate and make it more Clojure-like.

## `nest` macro

In Flutter code, it's very common to have medium to long chains of widgets chained through `:child`.

For example, this Dart

```dart
IgnorePointer(
  ignoring: _open,
  child: AnimatedContainer(
    transformAlignment: Alignment.center,
    transform: Matrix4.diagonal3Values(
      _open ? 0.7 : 1.0,
      _open ? 0.7 : 1.0,
      1.0,
    ),
    duration: const Duration(milliseconds: 250),
    curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    child: AnimatedOpacity(
      opacity: _open ? 0.0 : 1.0,
      curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
      duration: const Duration(milliseconds: 250),
      child: FloatingActionButton(
        onPressed: _toggle,
        child: const Icon(Icons.create),
      ),
    ),
  ),
);
```

which translates directly to
```clj
(m/IgnorePointer.
  :ignoring (boolean @open)
  :child
  (m/AnimatedContainer.
    :transformAlignment m.Alignment/center
    :transform (m.Matrix4/diagonal3Values
                 (if @open 0.7 1.0)
                 (if @open 0.7 1.0)
                 1.0)
    :duration ^:const (m/Duration. :milliseconds 250)
    :curve ^:const (m/Interval. 0.0 0.5 :curve m.Curves/easeOut)
    :child
    (m/AnimatedOpacity.
      :opacity (if @open 0.0 1.0)
      :curve ^:const (m/Interval. 0.25 1.0 :curve m.Curves/easeInOut)
      :duration ^:const (m/Duration. :milliseconds 250)
      :child
      (m/FloatingActionButton.
        :onPressed toggle
        :child
        (m/Icon. m.Icons/create)))))
```

can be flattened with `nest` into:

```clj
(f/nest
  (m/IgnorePointer. :ignoring (boolean @open))
  (m/AnimatedContainer.
    :transformAlignment m.Alignment/center
    :transform (m.Matrix4/diagonal3Values
                 (if @open 0.7 1.0)
                 (if @open 0.7 1.0)
                 1.0)
    :duration ^:const (m/Duration. :milliseconds 250)
    :curve ^:const (m/Interval. 0.0 0.5 :curve m.Curves/easeOut))
  (m/AnimatedOpacity.
    :opacity (if @open 0.0 1.0)
    :curve ^:const (m/Interval. 0.25 1.0 :curve m.Curves/easeInOut)
    :duration ^:const (m/Duration. :milliseconds 250))
  (m/FloatingActionButton. :onPressed toggle)
  (m/Icon. m.Icons/create))
  ```

## `widget` macro

It's the Swiss army knife of Flutter in ClojureDart: it replaces instances of `StatelessWidget`, `StatefulWidget`, `State`, `Builder` and `StatefulBuilder`.

The general structure of `widget` is a body preceded by inlined `:option value` pairs.

The body always evaluates to a `Widget` and the whole `widget` form itself evaluates to a `Widget` too.

Supported options are `:key`, `:context`, `:state`, `:watch`, `:with`, `:ticker` and `:tickers`.

### `:key k`

Specifiy the local key (a plain non-nil value) for this widget.

`nil` (default) means no key.

Local keys are used to identify siblings across reordering and updates.

### `:context ctx`

Will bind `ctx` to the `BuildContext` of this widget.

### `:state [my-state init]`

`:state [my-state init]` creates an atom as per `(let [my-state (atom init)] ...)`. Any change to this atom will trigger an update of the widget.

### `:watch pre-existing-atom`

Any change to the atom named `pre-existing-atom` will trigger an update of the widget.

### `:with [resource init ...]`

This one is about resources management. For example if you need a `ScrollController` you can simply use `:with [controller (m/ScrollController.)]`, it will be initialized in [`initState`](https://api.flutter.dev/flutter/widgets/State/initState.html) and discarded in [`dispose`](https://api.flutter.dev/flutter/widgets/State/dispose.html).

By default a resource is disposed by calling its `.dispose` method. However if the resource must be freed differently you have to specify it like this:

```clj
:with [file (.openSync (io/File "log"))
       :dispose .closeSync]
```

The resource name is threaded (as per `->`) through the `:dispose` form. Most of the time it will be simply a method or a function.

Lastly, you can introduce intermediate values to use in resource initialization via `:let`:

```clj
:with [res1 init1
       :dispose .cancel
       :let [v expr]
       res2 (init2 v)]
```

### `:ticker name` or `:tickers name`

This will bind `name` to a [`TickerProvider`](https://api.flutter.dev/flutter/scheduler/TickerProvider-class.html) to use in `AnimationController`s. Use `:ticker` if you have a single `AnimationController` (the common case).



================================================
FILE: doc/flutter-quick-start.md
================================================
# ClojureDart+Flutter Quick Start

> Even if Flutter bundles its own Dart it's better to first try [ClojureDart](quick-start.md) alone first.

## System requirements

ClojureDart needs at least Java 8.

## 1. [Install the latest stable Flutter](https://flutter.dev/docs/get-started/install)

It's a tad laborious as you have to install dependencies.

## 2. [Install Clojure CLI Tools](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)

If you already have the `clj` command installed make sure to upgrade to at least the [1.10.3.814](https://clojure.org/releases/tools#v1.10.3.814). This release allows to easily use private git deps.

## 3. Create your first ClojureDart/Flutter project

Creates a directory for the project with the following deps.edn:

``` shell
mkdir hello
cd hello
cat << EOF > deps.edn
{:paths ["src"] ; where your cljd files are
 :deps {tensegritics/clojuredart
        {:git/url "https://github.com/tensegritics/ClojureDart.git"
         :sha "9385be3c88ab6593350fdda50d86af985224971b"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:kind :flutter
             :main acme.main}}
EOF
```

`acme.main` is the root namespace of the project where the `main` function is defined.

(To update an existing project to the latest ClojureDart, just do `clj -M:cljd upgrade`)

## 4. Initialize the project

``` shell
clj -M:cljd init
```

## 5. Create a ClojureDart file with a main entry-point

First create a directory where clojure files live

``` shell
mkdir -p src/acme
cat << EOF > src/acme/main.cljd
(ns acme.main
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    (m/MaterialApp
      .title "Welcome to Flutter"
      .theme (m/ThemeData .primarySwatch m.Colors/pink))
    .home
    (m/Scaffold
      .appBar (m/AppBar
                .title (m/Text "Welcome to ClojureDart")))
    .body
    m/Center
    (m/Text "Let's get coding!"
       .style (m/TextStyle
                .color m.Colors/red
                .fontSize 32.0))))
EOF
```

## 7. Start a simulator

### iOS and iPadOS

Install XCode if you don't have it yet. Starts it once to accept licenses.

In another terminal:

iOS:
``` shell
open -a Simulator
```
### Android
You can either use Android Studio or Genymotion.

#### Android Studio
Download Android Studio from https://developer.android.com/studio

:bulb: There's currently a small incompatibility between the latest Studio (Eels) and Flutter: Android Studio renamed the directory containing its JRE from `jre` to `jbr`. Go to where Android Studio is installed (eg for a typical MacOS install: `/Applications/Android Studio.app/Contents/`) and do `ln -s jbr jre` (you may need to `sudo` this command).

Now run `flutter doctor`. Android Studio shoud be fully green. Good job! However you still certainly have a warning about using a command-line tool name `sdkmanager` to install other command line tools. Something like this.

```
 ✗ cmdline-tools component is missing
      Run path/to/sdkmanager --install "cmdline-tools;latest"
      See https://developer.android.com/studio/command-line for more details.
```

The trick is that the SDK manager is a GUI in Android Studio:

<img src="AndroidStudioSdkManager.png">

Once everything is downloaded, run `flutter doctor` again, it will instruct you on how to accept licenses.

Now we are almost done, we only have to create the virtual device. This is done in Android Studio Virtual Device Manager which can be found from a buried on the welcome dialogs (plural):

<img src="AndroidStudioDeviceManagerAccess.png">
<img src="AndroidStudioDeviceManagerAccess2.png">

Once in the device manager, you pick the device and then an Android version and you'll get your virtual device listed:

<img src="AndroidStudioDeviceManager.png">

Now, `flutter emulators` lists:
```
2 available emulators:

apple_ios_simulator • iOS Simulator  • Apple  • ios
Pixel_5_API_33      • Pixel 5 API 33 • Google • android`
```

And `flutter emulators --launch Pixel_5_API_33` will start the emulator (maybe asking for some OS permissions the first time)!

#### Genymotion
Please follow [those guidelines](https://docs.genymotion.com/desktop/Get_started/Requirements/) to install and setup Genymotion.

* Configure the SDK **within Genymotion** (`Genymotion > Preferences > ADB > Use custom Android SDK tools`) then use the path `/$HOME/Android/sdk` (default location after installing Android Studio)

    * Create a new device within Genymotion

* In **Android Studio**

    * `Select Tools > SDK Manager > Plugins > Genymotion`, and restart Android Studio
    * Then, select `Files > Settings`
    * On the sidebar, select `Tools > Genymotion plugin`
    * Select the path to your Genymotion folder

* within your **flutter project**, run `flutter devices`: Genymotion should appear among connected devices. (make sure your genymotion device is still on)

## 8. Start the ClojureDart watcher

``` shell
clj -M:cljd flutter
```

## 9. Enjoy!

 When you edit your cljd file, the watcher recompiles cljd files and, on success, hot reloads the application. **Sometimes the application may not pick up your change so hit the return key to get the watcher to restart the application.**



================================================
FILE: doc/GENERICS.md
================================================
# All you never wanted to know about Dart generics

## Preamble
In Java, generics exist only at the language level, not at the JVM level (the loss of this information is known as type erasure).
Interop happening at the JVM level we Clojure people don't have to care for Generics.

However in Dart, generics are not erased so we ClojureDart people have to deal with them.

## Notation transcription
Every time you see `foo<bar,baz>` you can write `#/(foo bar baz)`, it's irrelevant to whether the `foo` symbol is a type, a method or whatever.

`#/(foo bar baz)` reads as a symbol with metadata: it's just a shorthand for `^{:type-params [bar baz]} foo`.

## Covariance and contravariance
Let's not talk about function return types for now and consider all other cases.

A `List<String>` is a subtype of `List<Object>` because `String` is a subtype of `Object`. Dart generics are said to be covariant.

It's a common design choice even if it brings funny behaviors:

```dart
List<String> strings = [];
List<Object> objects = strings;
 // I must be able to add any object to objects since it's a list of Object, right?
objects.add(Object()); // right?
// ka💥boom! because objects points to strings which accepts only strings as items.
```

## `.cast<R>()` is a lie
It's a common pattern found for example on collections and streams to have a `.cast` method to change the type of the object.

This pattern is a runtime bandaid. For example when you have a string of objects which happens to only hold strings, you can't pass it as list of strings. See:

```dart
acceptOnlyStrings(List<String> strings) {
  // intentionally left blank
}

List<Object> objects = [];
acceptOnlyStrings(objects); // 👈 compilation error
```

However if you `.cast. it works:

```dart
acceptOnlyStrings(List<String> strings) {
  // intentionally left blank
}

List<Object> objects = [];
acceptOnlyStrings(objects.cast()); // 👌
```

You may wonder why we only typed `.cast()` and not `.cast<String>()`: it's because the compiler expects a `List<String>` and thus is able to infer the omitted `<String>`.

Let's try something not too different but more surprising:
```dart
acceptOnlyStrings(List<String> strings) {
  // intentionally left blank
}

List<Object> objects = [42];
acceptOnlyStrings(objects.cast()); // still 👌 despite 42 being obviously not a string!
```

`.cast` methods create wrappers whose purpose is only to lie on their static type. The lie will hold as long as we don't do anything that could betray it:

```dart
List<Object> objects = ["I'm a string", 42];
List<String> strings = objects.cast();
print(33); // print accepts any object
print(strings.first); // strings.first is 👌 because the first item is effectively a string 
print(strings[1]); // ka💥boom! because our lie can't be held any more 
```

Objects returned by `.cast` methods are only runtime type-enforcing views on the original object:

```dart
List<Object> objects = ["I'm a string", 42];
List<String> strings = objects.cast();
print(33); // print accepts any object
print(strings.first); // strings.first is 👌 because the first item is effectively a string 
objects[1]="Wait, I'm a string too!";
print(strings[1]); //  it's 👌 this time because the original object has been modified
```

## ClojureDart and magicast
### Magicast
Every time the CLJD compiler sees a value whose type is "not right but not completely wrong" it emits additional code to hopefuly make it right.

For example, let's suppose a method expecting a `List<Widget>` as argument and we pass it a local whose type is totally unknown then ClojureDart will do something a bit like that:

```dart
List<Widget> children;
if (myVar is List<Widget>)
  children=(List<Widget>) myVar;
else if (myVar is List)
  children=((List) myVar).cast();
else
  throw "ka💥boom!";
```

If the local had statically (type hint or inference) been known to be a `List` the compiler would have emitted:
```dart
List<Widget> children;
if (myVar is List<Widget>)
  children=(List<Widget>) myVar;
else
  children=((List) myVar).cast();
```

If the local has been known to be a `List<Widget>` nothing would have been emitted.

This is this behavior that we call "magicast" and this is what allows you to pass dynamic Clojure vectors where typed lists are expected.

And we magicast all types which happen to have a `.cast()` method.

### The Dart side of the colls
Unlike what has been described for Dart collections, ClojureDart collections returned by `.cast` are not views. It doesn't matter much because these are immutable collections.

Specifically a persistent collection is usually a wrapper object containing a tree of nodes (the wrapper holding information such as the element count, hash value etc.). When we call `.cast` on it we just create a new wrapper object matching the expected type but sharing the original tree node.

Thus `.cast` is cheap and the value returned by it is still a persistent collection and can still be used with no additional constraints on items types. It's only the Dart side which is typed.



================================================
FILE: doc/quick-start.md
================================================
# ClojureDart Quick Start

> This document is about creating a CLI app written in Dart; for a mobile app follow our [Flutter Quick Start](flutter-quick-start.md). However it's recommended to first give a try to the current document.

## System requirements

ClojureDart needs at least Java 9.

## 1. [Install the Dart SDK](https://dart.dev/get-dart#install)

If you already have Dart installed, make sure your version of the sdk is at least 2.12 -- this version introduced a big change (types are not nullable by default) to the language, use `dart --version` to check. Code produced by ClojureDart wouldn't be compatible with previous versions of Dart.

## 2. [Install Clojure CLI Tools](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)

If you already have the `clj` command installed make sure to upgrade to at least the [1.10.3.814](https://clojure.org/releases/tools#v1.10.3.814). This release allows to easily use private git deps.

## 3. Create a new project

First, create a Clojure project, you need to specify it's a pure Dart (not Flutter) project and where is the `main` function (here `quickstart.helloworld`):

```shell
mkdir helloworld
cd helloworld
cat << EOF > deps.edn
{:paths ["src"] ; where your cljd files will live
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart
        {:git/url "git@github.com:tensegritics/ClojureDart.git"
         ; or  "https://github.com/tensegritics/ClojureDart.git"
         :sha "9385be3c88ab6593350fdda50d86af985224971b"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:kind :dart
             :main quickstart.helloworld}}
EOF
```

Then, you need to prepare this project to also be a Dart project:
```shell
clj -M:cljd init
```

And add the main namespace:

```shell
mkdir -p src/quickstart
cat << EOF > src/quickstart/helloworld.cljd
(ns quickstart.helloworld)

(defn main []
  (print "hello, world\n"))
EOF
```

The `src` directory isn't special, you are free to layout your project as you like, as long as you don't
interfere with [Dart's project layout](https://dart.dev/tools/pub/package-layout) (`bin` and `lib` especially).

## 4. Compiles to Dart

By default compilation starts from the main namespace (here `quickstart.helloworld`) and transitively compiles dependencies.

``` shell
clj -M:cljd compile
```

The above command compiles the project only once and exits. When you are actively working on a piece of code we recommend you use `watch` instead of `compile`:

``` shell
clj -M:cljd watch
```

## 5. Run your program

Compiled Dart files are found under `lib/cljd-out`; to execute the program, just type:

``` shell
dart run
```

By doing so you have run your program on the Dart VM. To get an actual executable, enter:

``` shell
dart compile exe -o helloworld bin/helloworld.dart
```

Without the `-o helloworld` option it would have created a `helloworld.exe` alongside `helloworld.dart`.

## 6. Enjoy!

Write more clojure code, new namespaces, have fun. The watcher will pick up your changes.
Then execute your dart file again.



================================================
FILE: doc/TESTING.md
================================================
# Testing

# Writing tests
`cljd.test` is a `clojure.test` port built on `dart test` to leverage existing tooling.

By default, tests are compiled to the `test` directory (to match `dart test` defaults). This can be overriden on a namespace basis by putting the `:dart.test/dir` metadata in the `ns` form:

```clojure
(ns some.testing.namespace
  "Let's test!"
  {:dart.test/dir "integration_test"}
  (:require ...))
```

`deftest` supports inline options, specifically `:tags` and `:runner`:

```
(deftest whatever
  :tags [:widget]
  :runner (ft/testWidgets [tester])
  (let [^ft/WidgetTester {:flds [pumpWidget]} tester
        _ (await (pumpWidget (sw/my-widget "T" "M")))
        title-finder (ft/find.text "T")
        message-finder (ft/find.text "M")]
    (ft/expect title-finder ft/findsOneWidget)
    (ft/expect message-finder ft/findsOneWidget)))
```

`:tags` allows tests selection using `dart test` `-t` and `-x` flags (selecting by name is also possible).

```bash
$ clj -M:cljd test -- -t widget
```

Everything after `--` will be passed to `dart test`.

`:runner` allows to specify a specialized test runner, `[tester]` here is the binding vector for arguments provided by the runner.

# Running tests
Tests are run with `clj -M:cljd test`: it compiles all namespaces on the classpath and runs all tests found.

You can narrow the namespaces searched for tests by specifiying them after after `test`: `clj -M:cljd test ns.to.test1 ns.to.test2`.

If your tests live in extra source directories, you can use aliases as usual to include them like in `clj -M:test:cljd test` to enable the `:test` alias.

Tests selection using `dart test` flags can be controlled at the alias level. See this excerpt from a `deps.edn`:
```clojure
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}
           :test-widgets
           {:extra-paths ["test"]
            :cljd/opts {:dart-test-args ["-t" "widget"]}}}
```

When you combine several aliases, `:dart-test-args` are concatenated. However if you use `--` on the commande line, it will discard the computed `:dart-test-args`. Replace `--` by `++` to append instead.



================================================
FILE: doc/internals/MUNGING.md
================================================
# Generated names by CLJD

This document describes how dart names are generated.

We want name generation to be injective (no clash) and to support composite names.

## Munging
In Dart, names are very conservative: all characters must belong to `[a-zA-Z0-9_$]` and an identifier can't start by a number.
Plus if it starts by an underscore, it becomes private to the lib. Also some words are reserved or built-in identifiers (better to avoid both rather than being clever in the gray zone.)

When munging a clojure name the strategy is:
 * leave `[a-zA-Z0-9]` untouched
 * replace `-` by `_` -- unless if it's the first character in which case replace it by `$_`
 * escapes everything else (including `$` and `_`).

### Escape Sequences
Escape sequences starts by a dollar `$` and end with a `_`.

Common punctuation is escaped as `$ALLCAPS_` (e.g. `$COLON_`).

Reserved words are escaped as `$themselves_` (e.g. `$Function_`).

Other characters are escaped as a sequence of `$uXXXX_` (where `XXXX` is 1 to 4 uppercase hexadecimal digits) representing UTF-16 code units.

Once munged autogensyms tend bo very verbose (`x#` becomes `x__18920__auto__` which would be `x$UNDERSCORE_$UNDERSCORE_18920$UNDERSCORE_$UNDERSCORE_auto$UNDERSCORE_$UNDERSCORE_`) so there are two escape sequences for them: `$AUTO_` for `__auto__` and `$18920_` for `__18920`. Thus `x__18920__auto__` is actually munged to `x$18920_$AUTO_`.

### Type quoting
It's sometimes necessary to include a dart type in another name (eg for extensions). A dart type may contain characters outside of the identifiers characters: `.()<>[]{},` and space (before `Function`).

Type quoting should be injective (as munging in general). So it's escape sequences must not be mistaken for other escape sequences (especially the ALLCAPS one -- especially for all characters which are valid in clojure symbols too: `.<>`) and for `Function` itself.

If the type is foreign to CLJD it may contain a `$` which will mess up with our munging. But if the type is from CLJD it's safe.

Having two mechanisms is not great. So we should escape `$` and `_` too.

If we are set to escape everything then we should just re-munge the whole type.

With the notable exception we don't have to escape underscores since dashes are not valid in dart names.

### Invariant
A munged named must match this regexep: `([a-zA-Z0-9]|\$[a-zA-Z0-9]*_)([a-zA-Z0-9_]|\$[a-zA-Z0-9]*_)*`.

No leading underscore, all dollar signs are followed by alnums and closed by an underscore.

### Suffixes

In some contexts, suffixes may be appended to the munged name of a symbol. A suffixe matches `$[a-zA-Z0-9]`.

`$C` and `$D` are reserved suffixes (to not clash with composite names)

`$[0-9]+(tmp)?` is for locals: in the generated Dart code there's no shadowing. Those ending in `tmp` are used in recurs.

`$iface` is for the vdirect-implementation interface of a protocol.

`$iext` is for the extension implementation of a protocol.

`$iproto` is for the class implementing the IProtocol for a given protocol.

`$cext` is for a class implementing a class extension.

`$extension` is for the actual singleton of a `$cext`.

`$root` is for the root value of a dyn

`$reserved` is for when the name is reserved by some lib (eg main for test)

## Composite names

A list of already munged names can be munged into a single unique identifier: the new composite name starts with `$C$` and ends with `$D$` (C and D look a bit like parenthesis) and its components are separated by `$$` when needed (that is when two adjacent components are not composite).

## Locals
To avoid shadowing locals are uniquely suffixed by `$nnn` where `nnn` is a decimal number.
Locals are guaranteed to be unique inside a top-level form.