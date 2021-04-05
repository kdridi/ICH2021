module Transformer
  ( transformPixels
  )where
    
import Data.List (sort)

import Pixel

transformPixels :: [(ColorF, [Pixel])] -> [Pixel]
transformPixels = sort . foldl tr []
  where
    tr :: [Pixel] -> (ColorF, [Pixel]) -> [Pixel]
    tr ps1 (c, ps2) = (ps1 ++ ps2)