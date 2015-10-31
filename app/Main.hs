module Main where

import Lib
import qualified Data.Text.IO as TIO

main :: IO ()
main = do
  contents <- TIO.readFile testFile
  return $ parseFile contents
  return ()


testFile :: FilePath
testFile = "/Users/toby/Downloads/Countries_v1.csv"
