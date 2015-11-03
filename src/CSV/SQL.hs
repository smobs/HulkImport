module CSV.SQL 
    (toSQL) 
where

import CSV.Parse
import Text.PrettyPrint
import qualified Data.Text as T

toSQL :: CSV -> String
toSQL (CSV rows) = render $ 
                   hcat (text "VALUES " : fmap ((<> text ", ")  . toValues) rows)
                   <> text "\nGO"



toValues :: [T.Text] -> Doc
toValues  =
    parens
         . hcat
         . punctuate (text ",")
         . map (text . T.unpack)

