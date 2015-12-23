{-# LANGUAGE OverloadedStrings #-}

import System.Environment (getArgs)
import Text.XML.Cursor
import qualified Data.Text as T
import qualified Text.HTML.DOM as H (readFile)
{{_cursor_}}

main = do
  fn:_ <- getArgs
  doc <- readFile fn

