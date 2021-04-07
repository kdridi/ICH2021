module Pixel where

data ColorF = ColorF Float Float Float

showColorF :: ColorF -> String
showColorF (ColorF r g b) = "(" ++ show r ++ ", " ++ show g ++ ", " ++ show b ++ ")"

instance Show ColorF where
  show = showColorF
  
instance Eq ColorF where
  (ColorF r0 g0 b0) == (ColorF r1 g1 b1) = r0 == r1 && g0 == g1 && b0 == b1

data Color = Color Int Int Int

showColor :: Color -> String
showColor (Color r g b) = "(" ++ show r ++ ", " ++ show g ++ ", " ++ show b ++ ")"

instance Show Color where
  show = showColor
  
instance Eq Color where
  (Color r0 g0 b0) == (Color r1 g1 b1) = r0 == r1 && g0 == g1 && b0 == b1

data Position = Position Int Int

showPosition :: Position -> String
showPosition (Position x y) = "(" ++ show x ++ ", " ++ show y ++ ")"

instance Show Position where
  show = showPosition
  
instance Eq Position where
  (Position i0 j0) == (Position i1 j1) = i0 == i1 && j0 == j1
  
instance Ord Position where
  compare (Position i0 j0) (Position i1 j1) = if i0 == i1 then compare j0 j1 else compare i0 i1

data Pixel = Pixel Position Color

showPixel :: Pixel -> String
showPixel (Pixel p c) = show p ++ " " ++ show c

instance Show Pixel where
  show = showPixel
  
instance Eq Pixel where
  (Pixel p0 c0) == (Pixel p1 c1) = p0 == p1 && c0 == c1
  
instance Ord Pixel where
  compare (Pixel p0 _) (Pixel p1 _) = compare p0 p1

data Image = Image Int Int [Pixel]