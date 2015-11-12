module HulkImport (
                   importFile
                  )
where

import           CSV.Parse
import           CSV.SQL
import           CSV.Types
import qualified Data.Text    as T
import qualified Data.Text.IO as TIO

-- | 'importFile' reads in a CSV file and writes out the corresponsing fragment of the insert statement to another file
importFile :: FilePath -- ^Location of the input file
           -> FilePath -- ^Desired output file.  Will be created if it doesn't exist
           -> IO ()
importFile input output = do
  contents <- TIO.readFile input
  TIO.writeFile output $ T.pack $ toSQL $ parse contents

textify :: SQLVal -> T.Text
textify v = case v of
               (I i) -> T.pack $ show i
               (D d) -> T.pack $ show d
               (NVar n) ->  n

applySchema :: [Bool] -> [SQLVal] -> [SQLVal]
applySchema = zipWith (\b v -> if b
                                  then NVar $ textify v
                                  else v)
