module Gold.Tests 
    (
     tests
    )
where

import Test.Tasty
import Test.Tasty.Golden
import qualified HulkImport as HI

tests :: TestTree
tests = testGroup "Golden Tests" [simpleTest]

simpleTest :: TestTree
simpleTest = 
    let output = "./dist/simple_out" in
    goldenVsFile "Simple test" "./test-files/simple_gold" output (HI.importFile "./test-files/simple_in" output)
