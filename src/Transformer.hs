module Transformer
  ( transformPixels
  )where
    
import Data.List (sort)

import Pixel
    ( Pixel(..),
      Position(Position),
      Color(Color),
      ColorF(..),
      Image(..) )

transformPixels :: [(ColorF, [Pixel])] -> Image
transformPixels arr = Image w h p
  where
    w = let Pixel (Position _ j) _ = last p in j + 1
    h = let Pixel (Position i _) _ = last p in i + 1
    p = sort $ concatMap transform arr
    transform (ColorF r g b, pixels) = map tr pixels
      where
        tr (Pixel position _) = Pixel position (Color (round r) (round g) (round b))
