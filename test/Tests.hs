
import Test.Tasty
import qualified Gold.Tests

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [
         Gold.Tests.tests
        ]
