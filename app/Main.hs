module Main where

import Lib

main :: IO ()
main = do 
  parseFile "/Users/toby/Downloads/Countries_v1.csv"
  return ()
