module CSV.SQL 
    (toSQL) 
where

import CSV.Types
import Text.PrettyPrint
import qualified Data.Text as T

-- | Converts CSV data to the Values clause of an insert statement
toSQL :: RenderSqlType a => CSV a -> String
toSQL  = render . csvDoc

csvDoc :: RenderSqlType a => CSV a -> Doc
csvDoc (CSV rows) = hcat (text "VALUES " : fmap rowDoc rows)
                   <> text "\nGO"

rowDoc :: RenderSqlType a => [a] -> Doc
rowDoc  =
    (<> text ", ") .
    parens
         . hcat
         . punctuate (text ", ")
         . map elemDoc

elemDoc :: RenderSqlType a => a -> Doc
elemDoc = renderSQL


class RenderSqlType a where
    renderSQL :: a -> Doc

instance RenderSqlType T.Text  where
    renderSQL = (char  'N' <> ) . quotes .  text . T.unpack . T.strip 
