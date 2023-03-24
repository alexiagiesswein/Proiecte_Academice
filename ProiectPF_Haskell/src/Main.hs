module Main where

import Args
  ( AddOptions (..),
    Args (..),
    GetOptions (..),
    SearchOptions (..),
    parseArgs,
  )
import qualified Data.List as L
import qualified Entry.DB as DB
import Entry.Entry
  ( Entry (..),
    FmtEntry (FmtEntry),
    matchedByAllQueries,
    matchedByQuery,
  )
import Result
import System.Environment (getArgs)
import Test.SimpleTest.Mock
import Prelude hiding (print, putStrLn, readFile)
import qualified Prelude

usageMsg :: String
usageMsg =
  L.intercalate
    "\n"
    [ "snip - code snippet manager",
      "Usage: ",
      "snip add <filename> lang [description] [..tags]",
      "snip search [code:term] [desc:term] [tag:term] [lang:term]",
      "snip get <id>",
      "snip init"
    ]

-- | Handle the init command
handleInit :: TestableMonadIO m => m ()
handleInit = do
    DB.save DB.empty
    return ()

-- | Handle the get command
handleGet :: TestableMonadIO m => GetOptions -> m ()
handleGet getOpts = do
    database <- DB.load
    case database of
        Success entry ->
            let
                id = getOptId getOpts
                entryOne = DB.findFirst (\x -> entryId x == id) entry
            in
                case entryOne of
                  Just e -> putStrLn (entrySnippet e)
                  Nothing -> putStrLn "Failed to load DB"
        Error err -> putStrLn "Failed to load DB"
    return ()

-- | Handle the search command
handleSearch :: TestableMonadIO m => SearchOptions -> m ()
handleSearch searchOpts = do
    database <- DB.load
    case database of
        Success entry ->
            let
                terms = searchOptTerms searchOpts
                found = DB.findAll (matchedByAllQueries terms) entry
            in
                case found of
                    [] -> putStrLn "No entries found"
                    _ -> do
                        allEntries <- sequence [putStrLn(show (FmtEntry entry)) | entry <- found]
                        print allEntries
        Error err -> putStrLn "Failed to load DB"
    return ()

-- | Handle the add command
handleAdd :: TestableMonadIO m => AddOptions -> m ()
handleAdd addOpts = do
    database <- DB.load
    snippet <- readFile (addOptFilename addOpts)
    case database of
        Success entry ->
            case entryOne of
                Just entry -> do
                    putStrLn "Entry with this content already exists: "
                    putStrLn (show (FmtEntry entry))
                    return ()
                Nothing -> do
                    DB.save db''
                    return ()
            where
                db' = getSuccess database DB.empty
                db'' = DB.insertWith (\id -> makeEntry id snippet addOpts) db'
                entryOne = DB.findFirst (\snip -> entrySnippet snip == snippet) db'
        Error err -> do
            putStrLn "Failed to load DB"
            return ()
  where
    makeEntry :: Int -> String -> AddOptions -> Entry
    makeEntry id snippet addOpts =
      Entry
        { entryId = id,
          entrySnippet = snippet,
          entryFilename = addOptFilename addOpts,
          entryLanguage = addOptLanguage addOpts,
          entryDescription = addOptDescription addOpts,
          entryTags = addOptTags addOpts
        }

-- | Dispatch the handler for each command
run :: TestableMonadIO m => Args -> m ()
run (Add addOpts) = handleAdd addOpts
run (Search searchOpts) = handleSearch searchOpts
run (Get getOpts) = handleGet getOpts
run Init = handleInit
run Help = putStrLn usageMsg

main :: IO ()
main = do
  args <- getArgs
  let parsed = parseArgs args
  case parsed of
    (Error err) -> Prelude.putStrLn usageMsg
    (Success args) -> run args
