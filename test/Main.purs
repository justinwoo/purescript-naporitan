module Test.Main where

import Prelude

import Effect (Effect)
import Naporitan as N
import Type.Prelude (Proxy)

proxies = N.reflectRecordProxy ::
  { apple :: Proxy Int
  , banana :: Proxy String
  }

data MyThing a b c d e f g = MyThing

instance myThingReflectProxy :: N.ReflectProxy (MyThing a b c d e f g) where
  reflectProxy = MyThing

things = N.reflectRecordProxy ::
  { apple :: MyThing Int Int Int Int Int Int Int
  , banana :: MyThing Unit Unit Unit Unit Unit Unit Unit
  }

main :: Effect Unit
main = do
  pure unit
