module Main where

import System.Environment (getArgs)

import ImageParser
import ImageReader
import ImageWriter

import Pixel
import Transformer

main :: IO ()
main = do
  args <- getArgs
  case args of
    pngFilePath:[] -> do
      pixels <- readImageFile pngFilePath
      mapM_ (putStrLn . show) pixels
    txtFilePath:pngFilePath:[] -> do
      cluster <- parseFile txtFilePath
      let pixels = transformPixels cluster
      mapM_ (putStrLn . show) pixels
      writeImageFile pixels pngFilePath
    _ -> error "Command not found"

