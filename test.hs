{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}

import PGParseCheck.Bindings as B
import PGParseCheck.QQ
import Control.Exception (assert)

main = do
    B.initParser
    o <- parseQuery "select * from hello"
    let r = assert ((success o) == 1) "unexpected parse error for OK query."
    print ("OK", r)
    o <- parseQuery "select * wrong"
    let r = assert ((success o) == 0) "unexpected parse OK for broken query."
    print ("OK", r)

    -- The following must be valid:
    print ([psql|select * from hello|])

    -- multiline
    print ([psql|
        select a, b, c
        from hello, hello2
        where hello.a = hello.b
    |])
