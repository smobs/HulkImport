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
  TIO.writeFile output $ T.pack $ toSQL $ defaultSchema $ parse contents

textify :: SQLVal -> SQLVal
textify v = case v of
               (SQLInt i) -> NVar $ T.pack $ show i
               (SQLFloat d) -> NVar $ T.pack $ show d
               (NVar n) -> NVar n
               Null -> Null

defaultSchema :: CSV ParseVal -> CSV SQLVal
defaultSchema (CSV vs) = CSV (map (map defaultSQL) vs)

defaultSQL :: ParseVal -> SQLVal
defaultSQL v =
  case v of
  (N d) -> SQLFloat (realToFrac d)
  (I i) -> SQLInt i
  (T t) -> NVar t

applySchema :: [Bool] -> [SQLVal] -> [SQLVal]
applySchema = zipWith (\b v -> if b
                                  then textify v
                                  else v)
