module ImageWriter
  ( writeImageFile
  ) where

import qualified Data.Vector.Storable as VS
import qualified Codec.Picture.Types as JP
import qualified Codec.Picture.Png as JP
import qualified Codec.Picture.Tga as JP

import Pixel ( Pixel(Pixel), Color(Color), Image(..) )

writeImageFile :: Image -> String -> IO ()
writeImageFile (Image w h pixels) = writeImage
  where
    writeImage filename
      | checkExtension "png" filename = JP.writePng filename image
      | checkExtension "tga" filename = JP.writeTga filename image
      | otherwise = fail "ERROR: output format not supported"

    image :: JP.Image JP.PixelRGB8
    image = JP.Image w h $ VS.fromList $ concatMap (\(Pixel _ (Color r g b)) -> map fromIntegral [r, g, b]) pixels

checkExtension :: String -> String -> Bool
checkExtension ext filename = reverse ('.':ext) == take (length ext + 1) (reverse filename)