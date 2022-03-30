module Main where

import System.Directory
import System.Environment (getEnv, getEnvironment, getArgs)
import qualified System.Environment as Env
import System.Process.Typed

main :: IO ()
main = do
  args <- getArgs
  home <- getEnv "HOME"
  case args of
    ["save", name] -> do
      createDirectoryIfMissing True (home <> "/.envy/")
      putStrLn ("Saving environment to ~/.envy/" <> name)
      env <- getEnvironment
      writeFile (home <> "/.envy/" <> name) (show env)
    ("exec":name:cmd:args) -> do
      env <- fmap read (readFile (home <> "/.envy/" <> name))
      maybe (pure ()) (Env.setEnv "PATH") (lookup "PATH" env)
      runProcess_ (setEnv env (proc cmd args))
    _ -> error "Args:\n\nsave NAME\n\nexec NAME CMD ARG1 ARG_N.."
