module HulkImport (
                   importFile
                  )
where

import Lib
import qualified Data.Text.IO as TIO
import qualified Data.Text as T 

importFile :: FilePath -> FilePath  -> IO ()
importFile input output = do
  contents <- TIO.readFile input
  TIO.writeFile output $ toSQL $ parseFile contents


toSQL :: CSV -> T.Text
toSQL (CSV rows) = T.pack $ "VALUES " ++ (rows >>= toValues) ++ "\nGO"


toValues :: [T.Text] -> String
toValues elems = "(" ++ 
                 (T.unpack . T.intercalate (T.pack ",")) elems
                 ++ "), "
