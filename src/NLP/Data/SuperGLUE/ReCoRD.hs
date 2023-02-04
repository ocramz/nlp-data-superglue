{-# language DeriveGeneric #-}
{-# language OverloadedStrings #-}
{-# options_ghc -Wno-unused-imports #-}
-- | Reading Comprehension with Commonsense Reasoning
module NLP.Data.SuperGLUE.ReCoRD where

import Data.Ord (comparing)
import GHC.Generics (Generic(..))

-- aeson
import qualified Data.Aeson as A (FromJSON(..), ToJSON(..), ToJSONKey(..), encode, eitherDecode, withText, object, withObject)
import Data.Aeson ((.:), (.=))

data ReCoRD = ReCoRD {
  source :: String
  , passage :: ReCoRDPassage
  , qas :: [ReCoRDQuery]
  , idx :: Int
                     } deriving (Eq, Show, Generic)
instance A.FromJSON ReCoRD

instance Ord ReCoRD where
  compare = comparing idx

data ReCoRDPassage = ReCoRDPassage {
  text :: String
  , entities :: [ReCoRDEntity]
                                   } deriving (Eq, Show, Generic)
instance A.FromJSON ReCoRDPassage


data ReCoRDQuery = ReCoRDQuery {
  query :: String
  , qIdx :: !Int
                               } deriving (Eq, Show)
instance A.FromJSON ReCoRDQuery where
  parseJSON = A.withObject "ReCoRDQuery" $ \o -> ReCoRDQuery <$>
    o .: "query" <*>
    o .: "idx"

data ReCoRDEntity = ReCoRDEntity {
  start :: !Int
  , end :: !Int
                                 } deriving (Eq, Show, Generic)
instance A.FromJSON ReCoRDEntity


--

