module Main where

import HulkImport

data Options = Options {
      optInput :: FilePath,
      optOutput :: FilePath
    }

main :: IO ()
main = do
  opt <- defaultOptions
  importFile (optInput opt) (optOutput opt)

testFile :: FilePath
testFile = "/Users/toby/Downloads/Countries_v1.csv"

defaultOptions :: IO Options
defaultOptions = Options 
                 <$> (putStrLn "Please provide an input file:" >> getLine) 
                 <*> return "./output"

