{-# LANGUAGE OverloadedStrings #-}
module CSV.Parse
    ( parse
    ) where

import qualified Data.Attoparsec.Text as A
import qualified Data.Text as Text
import Control.Applicative

import CSV.Types

-- | 'parse' parses text in the CSV format.  Delimiters are ',' and new lines.
-- Quotation is performed with '"'.
-- TODO: Files in the wrong format throw an error :(   
parse :: Text.Text -> CSV SQLVal
parse text =
    case A.parseOnly csvParser text of
      Left  s  -> error s
      Right c -> c

csvParser :: A.Parser (CSV SQLVal)
csvParser = do
  rows <- A.sepBy1 rowParser (A.skip A.isEndOfLine) 
  return (CSV rows)


rowParser :: A.Parser [SQLVal]
rowParser = A.sepBy1 elementParser $ A.string ", "

elementParser :: A.Parser SQLVal
elementParser =
    I <$> A.decimal
    <|>  do
      text <- A.many1 $
              textParser
              <|> quotationParser
      return (NVar $ Text.concat text)

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

