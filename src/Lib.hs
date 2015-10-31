module Lib
    ( parseFile,
      CSV (..)
    ) where

import qualified Data.Attoparsec.Text as A
import qualified Data.Text as Text


data CSV = CSV [[Text.Text]] deriving Show

parseFile :: Text.Text -> CSV
parseFile text =
    case A.parseOnly someParser text of
      Left  s  -> error s
      Right c -> c

someParser :: A.Parser CSV
someParser = do
  rows <- A.sepBy1 rowParser (A.char '\n') 
  return (CSV rows)


rowParser :: A.Parser [Text.Text]
rowParser = A.sepBy1 elementParser $ A.char ','

elementParser :: A.Parser Text.Text
elementParser = do 
  text <- A.many1 $ A.choice
          [ textParser
          , quotationParser ]
  return (Text.concat text)

textParser :: A.Parser Text.Text
textParser = A.takeWhile1 (A.notInClass [',','\n', '"'])

quotationParser :: A.Parser Text.Text
quotationParser = 
    let quote = '"' in
    let f q1 t q2 = Text.cons q1 (Text.snoc t q2) in
    f <$> A.char quote <*> 
    quotedString [quote] <*>
    A.char quote

quotedString :: String ->  A.Parser Text.Text
quotedString quote = A.takeWhile (A.notInClass quote)

