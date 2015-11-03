module CSV.SQL 
    (toSQL) 
where

import CSV.Parse
import qualified Text.PrettyPrint as P
import qualified Data.Text as T

toSQL :: CSV -> String
toSQL (CSV rows) = P.render $ 
                   P.hcat (P.text "VALUES " : fmap ((P.<> P.text ", ")  . toValues) rows)
                   P.<> P.text "\nGO"



toValues :: [T.Text] -> P.Doc
toValues  =
    P.parens
         . P.hcat
         . P.punctuate (P.text ",")
         . map (P.text . T.unpack)

