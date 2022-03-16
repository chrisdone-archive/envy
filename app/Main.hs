module Main where

import System.Environment (getEnv, getEnvironment, getArgs)
import System.Process.Typed

main :: IO ()
main = do
  args <- getArgs
  home <- getEnv "HOME"
  case args of
    [] -> do
      putStrLn "Writing environment to ~/.envy"
      env <- getEnvironment
      writeFile (home <> "/.envy") (show env)
    cmd:args -> do
      env <- fmap read (readFile (home <> "/.envy"))
      runProcess_ (setEnv env (proc "arch" ("-x86_64":cmd:args)))
