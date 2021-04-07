module ImageParser
  ( parseFile
  ) where
    
import System.Directory (doesFileExist)
    
import Pixel ( Pixel(..), Position(..), Color(..), ColorF(..) )

import Text.Parsec.String ( parseFromFile, Parser )

import Text.ParserCombinators.Parsec.Char (char, digit, string, spaces)
import Text.ParserCombinators.Parsec.Combinator (many1, between)
import Text.ParserCombinators.Parsec.Prim (many)

parseFile :: String -> IO [(ColorF, [Pixel])]
parseFile f = do
  e <- doesFileExist f
  if e then do
    e <- parseFromFile pOUT f
    case e of
      Left msg -> fail $ "ERROR: " ++ show msg
      Right img -> return img
  else
    fail $ "ERROR: " ++ f ++ " doesn't exists"

pOUT :: Parser [(ColorF, [Pixel])]
pOUT = many pCLUSTER

pCLUSTER :: Parser (ColorF, [Pixel])
pCLUSTER = do
  _ <- string "--\n"
  c <- pCOLORF
  _ <- string "\n-\n"
  ps <- pPIXELS
  return (c, ps)
  where
    pPIXELS :: Parser [Pixel]
    pPIXELS = many1 $ do
      p <- pPOINT
      _ <- spaces
      c <- pCOLOR
      char '\n'
      return $ Pixel p c

pPOINT :: Parser Position
pPOINT = do
  char '('
  x <- pINT
  char ','
  y <- pINT
  char ')'
  return $ Position x y

pINT :: Parser Int
pINT = do
  s <- between spaces spaces $ many1 digit
  return $ read s

pCOLOR :: Parser Color
pCOLOR = do
  char '('
  r <- pSHORT
  char ','
  g <- pSHORT
  char ','
  b <- pSHORT
  char ')'
  return $ Color r g b

pCOLORF :: Parser ColorF
pCOLORF = do
  char '('
  r <- pFLOAT
  char ','
  g <- pFLOAT
  char ','
  b <- pFLOAT
  char ')'
  return $ ColorF r g b

pSHORT :: Parser Int
pSHORT = do
  s <- between spaces spaces $ many1 digit
  return $ read s

pFLOAT :: Parser Float
pFLOAT = do
  s <- between spaces spaces $ float
  return $ read s
  where
    float = do
      s1 <- many1 digit
      char '.'
      s2 <- many1 digit
      return $ s1 ++ "." ++ s2