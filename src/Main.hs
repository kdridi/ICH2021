module Main where

import System.Environment ( getArgs )

import ImageParser ( parseFile )
import ImageReader ( readImageFile )
import ImageWriter ( writeImageFile )
import Transformer ( transformPixels )

main :: IO ()
main = do
  args <- getArgs
  case args of
    [pngFilePath] -> do
      pixels <- readImageFile pngFilePath
      mapM_ print pixels
    [txtFilePath,pngFilePath] -> do
      cluster <- parseFile txtFilePath
      let image = transformPixels cluster
      writeImageFile image pngFilePath
    _ -> error "Command not found"

