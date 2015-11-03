module CSV.SQL 
    (toSQL) 
where

import CSV.Types
import Text.PrettyPrint
import qualified Data.Text as T

-- | Converts CSV data to the Values clause of an insert statement
toSQL :: CSV T.Text -> String
toSQL  = render . csvDoc

csvDoc :: CSV T.Text -> Doc
csvDoc (CSV rows) = hcat (text "VALUES " : fmap rowDoc rows)
                   <> text "\nGO"

rowDoc :: [T.Text] -> Doc
rowDoc  =
    (<> text ", ") .
    parens
         . hcat
         . punctuate (text ",")
         . map (text . T.unpack)

