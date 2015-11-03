module CSV.SQL 
    (toSQL) 
where

import CSV.Parse
import Text.PrettyPrint
import qualified Data.Text as T

toSQL :: CSV -> String
toSQL  = render . csvDoc

csvDoc :: CSV -> Doc
csvDoc (CSV rows) = hcat (text "VALUES " : fmap rowDoc rows)
                   <> text "\nGO"

rowDoc :: [T.Text] -> Doc
rowDoc  =
    (<> text ", ") .
    parens
         . hcat
         . punctuate (text ",")
         . map (text . T.unpack)

