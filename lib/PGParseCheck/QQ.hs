module PGParseCheck.QQ (psql) where

import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Quote
import qualified PGParseCheck.Bindings as B

psql :: QuasiQuoter
psql = QuasiQuoter
    { quoteExp = quoteExpParser
    , quotePat = undefined
    , quoteDec = undefined
    , quoteType = undefined
    }

quoteExpParser :: String -> TH.ExpQ
quoteExpParser s = do
    TH.runIO B.initParser
    r <- TH.runIO (B.parseQuery s)
    case B.success r of
     1 -> (TH.litE . TH.stringL) s
     _ -> error "no parse"
