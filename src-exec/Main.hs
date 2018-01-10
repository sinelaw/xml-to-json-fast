module Main  where

import           Control.Monad
import           System.Console.GetOpt            (ArgOrder (Permute), OptDescr (..), getOpt,
                                                   usageInfo)
import           System.Environment               (getArgs)
import           System.Exit                      (ExitCode (ExitFailure), exitWith)
import           System.IO                        (hPutStrLn, stderr, hGetContents, IOMode(..), withBinaryFile, stdin, Handle
                                                  ,hSetEncoding, utf8)
import           Text.XML.JSON.StreamingXmlToJson (xmlStreamToJSON)

data Flag = ShowHelp
            deriving (Show, Eq, Ord)

options :: [OptDescr Flag]
options = []

parseOptions :: [String] -> IO ([Flag], [String])
parseOptions argv =
  case getOpt Permute options argv of
    (o,n,[]  ) -> return (o,n)
    (_,_,errs) -> ioError (userError (concat errs ++ usageInfo usageHeader options))

usageHeader :: String
usageHeader = "Usage: <program> files..."

processFile :: Handle -> IO ()
processFile handle = do
    hSetEncoding handle utf8
    fileData <- hGetContents handle
    forM_ (xmlStreamToJSON fileData) putStrLn

main :: IO ()
main = do
    args <- getArgs
    (_flags, inputFiles) <- parseOptions args

    case inputFiles of
        [] -> processFile stdin
        xs -> forM_ xs $ \fileName -> withBinaryFile fileName ReadMode processFile

die :: String -> IO a
die msg = do
  hPutStrLn stderr msg
  exitWith (ExitFailure 1)
