{-# language DeriveGeneric #-}
{-# language OverloadedStrings #-}
{-# options_ghc -Wno-unused-imports #-}
-- | Recognizing Textual Entailment
module NLP.Data.SuperGLUE.RTE where

import Data.Ord (comparing)
import GHC.Generics (Generic(..))

-- aeson
import qualified Data.Aeson as A (FromJSON(..), ToJSON(..), ToJSONKey(..), encode, eitherDecode, withText, object, withObject)
import Data.Aeson ((.:), (.=))

data RTE = RTE {
  premise :: String
  , hypothesis :: String
  , label :: RTELabel
  , idx :: Int
             } deriving (Eq, Show, Generic)

newtype RTELabel = RTELabel (Maybe Bool) deriving (Eq, Show)
instance A.FromJSON RTELabel where
  parseJSON = A.withText "RTELabel" $ \t -> RTELabel <$>
    case t of
      "entailment" -> pure $ Just True
      "not_entailment" -> pure $ Just False
      _ -> pure Nothing


instance Ord RTE where
  compare = comparing idx

-- {"premise": "No Weapons of Mass Destruction Found in Iraq Yet.", "hypothesis": "Weapons of Mass Destruction Found in Iraq.", "label": "not_entailment", "idx": 0}
