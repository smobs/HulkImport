{-# LANGUAGE OverloadedStrings #-}
module CSV.Parse
    ( parse
    ) where

import           Control.Applicative
import qualified Data.Attoparsec.Text as A
import qualified Data.Text            as Text

import           CSV.Types

-- | 'parse' parses text in the CSV format.  Delimiters are ',' and new lines.
-- Quotation is performed with '"'.
-- TODO: Files in the wrong format throw an error :(
parse :: Text.Text -> CSV ParseVal
parse text =
    case A.parseOnly csvParser text of
      Left  s  -> error s
      Right c -> c

csvParser :: A.Parser (CSV ParseVal)
csvParser = do
  rows <- A.sepBy1 rowParser A.endOfLine
  A.skipSpace
  A.endOfInput
  return (CSV rows)

rowParser :: A.Parser [ParseVal]
rowParser = A.sepBy1 elementParser $ A.string ","

elementParser :: A.Parser ParseVal
elementParser = A.skipSpace >>
   I <$> intParser <|>
   N <$> A.double  <|>
   do
     text <- A.many1 $ textParser <|> quotationParser
     return (T $ Text.concat text)

intParser :: A.Parser Int
intParser = do
          i <- A.decimal
          mnext <- A.peekChar
          case mnext of
            Just '.' -> fail "Not an int"
            _ -> return i

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

