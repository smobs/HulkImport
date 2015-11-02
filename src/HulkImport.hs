module HulkImport (
                   importFile
                  )
where

import CSVParser
import qualified Data.Text.IO as TIO
import qualified Data.Text as T 
import qualified Text.PrettyPrint as P

importFile :: FilePath -> FilePath  -> IO ()
importFile input output = do
  contents <- TIO.readFile input
  TIO.writeFile output $ T.pack $ P.render $ toSQL $ parseFile contents


toSQL :: CSV -> P.Doc
toSQL (CSV rows) = P.hcat (P.text "VALUES " : fmap ((P.<> P.text ", ")  . toValues) rows)
                   P.<> P.text "\nGO"


toValues :: [T.Text] -> P.Doc
toValues  =
    P.parens
         . P.hcat
         . P.punctuate (P.text ",")
         . map (P.text . T.unpack)
