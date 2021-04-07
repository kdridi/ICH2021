module Transformer
  ( transformPixels
  )where
    
import Data.List (sort)

import Pixel ( Pixel(..), Position(Position), ColorF, Image(..) )

transformPixels :: [(ColorF, [Pixel])] -> Image
transformPixels arr = Image w h p
  where
    w = let Pixel (Position _ j) _ = last p in j + 1
    h = let Pixel (Position i _) _ = last p in i + 1
    p = sort $ concatMap snd arr