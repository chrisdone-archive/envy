module Main where

import System.Directory
import System.Environment (getEnv, getEnvironment, getArgs)
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
      runProcess_ (setEnv env (proc "arch" ("-x86_64":cmd:args)))
    _ -> error "Args:\n\nsave NAME\n\nexec NAME CMD ARG1 ARG_N.."
