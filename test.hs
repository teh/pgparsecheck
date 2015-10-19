import Bindings
import Control.Exception (assert)

main = do
    Bindings.initParser
    o <- parseQuery "select * from hello"
    let r = assert ((success o) == 1) "unexpected parse error for OK query."
    print ("OK", r)
    o <- parseQuery "select * wrong"
    let r = assert ((success o) == 0) "unexpected parse OK for broken query."
    print ("OK", r)
