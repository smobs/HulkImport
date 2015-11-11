module CSV.Types ( CSV (..), SQLVal(..)) where

import           Data.Text (Text)

data CSV a = CSV [[a]] deriving Show

data SQLVal = I Int | NVar Text | D Double
