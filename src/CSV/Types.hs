module CSV.Types ( CSV (..), SQLVal(..), ParseVal(..)) where

import           Data.Text (Text)

data CSV a = CSV [[a]] deriving Show

data ParseVal = T Text | N Double | I Int

data SQLVal = SQLInt Int | NVar Text | SQLFloat Float  | Null
