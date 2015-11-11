module Gold.Tests
    (
     tests
    )
where

import qualified HulkImport        as HI
import           Test.Tasty
import           Test.Tasty.Golden

tests :: TestTree
tests = testGroup "Golden Tests" [simpleTest "simple", simpleTest "nospace"]

simpleTest :: String -> TestTree
simpleTest f =
    let output = "./dist/" ++ f ++ "_out" in
    goldenVsFile "Simple test" "./test-files/simple_gold" output (HI.importFile ("./test-files/" ++ f ++ "_in") output)
