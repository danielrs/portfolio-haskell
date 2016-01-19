{-# LANGUAGE TemplateHaskell #-}

module Main where

import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.Setup
import Distribution.PackageDescription

import System.Process (runCommand, waitForProcess)

main :: IO ()
main = defaultMainWithHooks $ simpleUserHooks { preBuild = compileClay }

compileClay :: Args -> BuildFlags -> IO HookedBuildInfo
compileClay _ _ = do
  putStrLn "Compiling clay"
  waitForProcess =<< runCommand "runhaskell -i. -package-db=./.cabal-sandbox/x86_64-linux-ghc-7.10.3-packages.conf.d/ ./Style/Main.hs"
  return emptyHookedBuildInfo
