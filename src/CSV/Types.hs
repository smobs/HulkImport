module CSV.Types ( CSV (..)) where 


data CSV a = CSV [[a]] deriving Show
