module HulkImport (
                   importFile
                  )
where

import CSV.Parse
import CSV.SQL
import qualified Data.Text.IO as TIO
import qualified Data.Text as T 


importFile :: FilePath -> FilePath  -> IO ()
importFile input output = do
  contents <- TIO.readFile input
  TIO.writeFile output $ T.pack $ toSQL $ parseFile contents


