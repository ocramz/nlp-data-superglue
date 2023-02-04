{-# language DeriveGeneric #-}
{-# language OverloadedStrings #-}
{-# options_ghc -Wno-unused-imports #-}
-- | Winograd Schema Challenge
module NLP.Data.SuperGLUE.WSC where

import Data.Ord (comparing)
import GHC.Generics (Generic(..))

-- aeson
import qualified Data.Aeson as A (FromJSON(..), ToJSON(..), ToJSONKey(..), encode, eitherDecode, withText, object, withObject)
import Data.Aeson ((.:), (.=))

data WSC = WSC {
  text :: String
  , label :: Bool
  , target :: WSCTarget
  , idx :: Int
             } deriving (Eq, Show, Generic)
instance A.FromJSON WSC

data WSCTarget = WSCTarget {
  span1_index :: Int
  , span2_index :: Int
  , span1_text :: String
  , span2_text :: String
                           } deriving (Eq, Show, Generic)
instance A.FromJSON WSCTarget

instance Ord WSC where
  compare = comparing idx
