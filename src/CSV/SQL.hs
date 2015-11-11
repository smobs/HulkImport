{-# LANGUAGE OverloadedStrings #-}
module CSV.SQL
    (toSQL)
where

import           CSV.Types
import qualified Data.Text        as T
import           Text.PrettyPrint

-- | Converts CSV data to the Values clause of an insert statement
toSQL :: RenderSqlType a => CSV a -> String
toSQL  = render . csvDoc

csvDoc :: RenderSqlType a => CSV a -> Doc
csvDoc (CSV rows) = hcat (text "VALUES " :  punctuate (text ", ") (fmap rowDoc rows))
                   <> text "\nGO"

rowDoc :: RenderSqlType a => [a] -> Doc
rowDoc  =
    parens
         . hcat
         . punctuate (text ", ")
         . map elemDoc

elemDoc :: RenderSqlType a => a -> Doc
elemDoc = renderSQL

wrapQuotes :: T.Text -> T.Text
wrapQuotes = T.replace "'" "''"

class RenderSqlType a where
    renderSQL :: a -> Doc

instance RenderSqlType T.Text  where
    renderSQL = (char  'N' <> ) . quotes . text . T.unpack . wrapQuotes . T.strip

instance RenderSqlType Int where
    renderSQL = int

instance RenderSqlType Double where
    renderSQL = double

instance RenderSqlType SQLVal where
    renderSQL (I i) = renderSQL i
    renderSQL (NVar t) = renderSQL t
    renderSQL (D d) = renderSQL d
