module Main where

import System.Environment
import System.Console.GetOpt

import HulkImport

data Options = Options {
      optInput :: FilePath,
      optOutput :: FilePath
    }

main :: IO ()
main = do
  args <- getArgs
  let opt = buildOptions options args defaultOptions
  importFile (optInput opt) (optOutput opt)

testFile :: FilePath
testFile = "/Users/toby/Downloads/Countries_v1.csv"

defaultOptions :: Options
defaultOptions = Options "./input"  "./output"


buildOptions :: [OptDescr (Options -> Options)] -> [String] -> Options -> Options
buildOptions o =
    let f (x, _, _) = x in
    applyOptions . f  . getOpt Permute o

applyOptions :: [Options -> Options] -> Options -> Options
applyOptions fs o = foldr id o fs

options :: [OptDescr (Options -> Options)]
options = [ Option ['i'] ["input"]
                       (ReqArg (\f opt -> opt {optInput = f}) "FILE") "input file"
          , Option ['o'] ["output"]
                (ReqArg (\f opt -> opt {optOutput = f}) "FILE") "output file" ]
