module Bindings
       ( ParseResult(..)
       , parseQuery
       , initParser
       )
       where
{-# LANGUAGE ForeignFunctionInterface #-}
import Foreign
import Foreign.C.Types
import Control.Monad (liftM)

#include "parser.h"

data ParseResult = ParseResult { success :: Int }

{#pointer *ParseResult as ParseResultPtr -> ParseResult #}

instance Storable ParseResult where
  sizeOf _ = {#sizeof ParseResult #}
  alignment _ = {#alignof ParseResult #}
  peek p = ParseResult <$> liftM fromIntegral ({#get ParseResult->success #} p)
  poke p x = {#set ParseResult.success #} p (fromIntegral (success x))

initParser = {#call init_parser #}
{#fun parse_query as ^ { `String', alloca- `ParseResult' peek* } -> `()' #}
