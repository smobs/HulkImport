module CSV.SQL 
    (toSQL) 
where

import CSV.Parse
import Text.PrettyPrint
import qualified Data.Text as T

toSQL :: CSV -> String
toSQL  = render . csvDoc

csvDoc :: CSV -> Doc
csvDoc (CSV rows) = hcat (text "VALUES " : fmap toValues rows)
                   <> text "\nGO"

toValues :: [T.Text] -> Doc
toValues  =
    (<> text ", ") .
    parens
         . hcat
         . punctuate (text ",")
         . map (text . T.unpack)

