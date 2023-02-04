{-# language DeriveGeneric #-}
{-# language OverloadedStrings #-}
{-# options_ghc -Wno-unused-imports #-}
-- | CommittmentBank
module NLP.Data.SuperGLUE.CB where

import Data.Ord (comparing)
import GHC.Generics (Generic(..))

-- aeson
import qualified Data.Aeson as A (FromJSON(..), ToJSON(..), ToJSONKey(..), encode, eitherDecode, withText, object, withObject)
import Data.Aeson ((.:), (.=))

data CB = CB {
  premise :: String
  , hypothesis :: String
  , label :: CBLabel
  , idx :: Int
             } deriving (Eq, Show, Generic)

newtype CBLabel = CBLabel (Maybe Bool) deriving (Eq, Show)
instance A.FromJSON CBLabel where
  parseJSON = A.withText "CBLabel" $ \t -> CBLabel <$>
    case t of
      "entailment" -> pure $ Just True
      "contradiction" -> pure $ Just False
      _ -> pure Nothing


instance Ord CB where
  compare = comparing idx

-- {"premise": "It was a complex language. Not written down but handed down. One might say it was peeled down.", "hypothesis": "the language was peeled down", "label": "entailment", "idx": 0}

