# purescript-naporitan

Because sometimes, you want a reflected record of proxies to make life easier.

![](https://i.imgur.com/Oy0GJqf.jpg)

## Usage

```purs
proxies = N.reflectRecordProxy ::
  { apple :: Proxy Int
  , banana :: Proxy String
  }
```

You can also create instances of the proxy creation class:

```purs
data MyThing a b c d e f g = MyThing

instance myThingReflectProxy :: N.ReflectProxy (MyThing a b c d e f g) where
  reflectProxy = MyThing

things = N.reflectRecordProxy ::
  { apple :: MyThing Int Int Int Int Int Int Int
  , banana :: MyThing Unit Unit Unit Unit Unit Unit Unit
  }
```

See [test/Main.purs](./test/Main.purs)
