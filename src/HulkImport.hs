module HulkImport (
                   importFile
                  )
where

import CSV.Parse
import CSV.SQL
import qualified Data.Text.IO as TIO
import qualified Data.Text as T 

-- | 'importFile' reads in a CSV file and writes out the corresponsing fragment of the insert statement to another file
importFile :: FilePath -- ^Location of the input file
           -> FilePath -- ^Desired output file.  Will be created if it doesn't exist
           -> IO ()
importFile input output = do
  contents <- TIO.readFile input
  TIO.writeFile output $ T.pack $ toSQL $ parse contents


