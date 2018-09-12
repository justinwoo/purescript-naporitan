module Naporitan where

import Prelude

import Prim.Row as Row
import Prim.RowList as RL
import Record.Builder (Builder)
import Record.Builder as Builder
import Type.Prelude (class IsSymbol, Proxy(..), RLProxy(..), SProxy(..))

class ReflectRecordProxy a where
  reflectRecordProxy :: a

instance reflectRecordProxyInst ::
  ( RL.RowToList r rl
  , ReflectRecordProxyBuilder rl () r
  ) => ReflectRecordProxy { | r } where
  reflectRecordProxy = Builder.build builder {}
    where
      builder = reflectRecordProxyBuilder (RLProxy :: RLProxy rl)

class ReflectRecordProxyBuilder (rl :: RL.RowList) (i :: # Type) (o :: # Type)
  | rl -> i o where
  reflectRecordProxyBuilder :: RLProxy rl -> Builder { | i } { | o }

instance reflectRecordProxyBuilderNil :: ReflectRecordProxyBuilder RL.Nil () () where
  reflectRecordProxyBuilder _ = identity

instance reflectRecordProxyBuilderConsRoute ::
  ( ReflectRecordProxyBuilder tail from from'
  , Row.Lacks name from'
  , Row.Cons name a from' to
  , ReflectProxy a
  , IsSymbol name
  ) => ReflectRecordProxyBuilder (RL.Cons name a tail) from to where
  reflectRecordProxyBuilder _ = first <<< rest
    where
      first = Builder.insert (SProxy :: SProxy name) reflectProxy
      rest = reflectRecordProxyBuilder (RLProxy :: RLProxy tail)

-- | Various proxies that can be created
class ReflectProxy a where
  reflectProxy :: a

instance reflectProxyProxy :: ReflectProxy (Proxy a) where
  reflectProxy = Proxy

instance reflectProxySProxy :: ReflectProxy (SProxy s) where
  reflectProxy = SProxy

