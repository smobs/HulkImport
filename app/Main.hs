module Main where

import HulkImport

main :: IO ()
main = importFile testFile "./output"

testFile :: FilePath
testFile = "/Users/toby/Downloads/Countries_v1.csv"
