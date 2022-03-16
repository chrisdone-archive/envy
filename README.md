# envy

**Works for M1 Apple only.**

Go to a terminal using direnv or nix, run:

    envy save foo

Where foo is the name of your project. Now you can run this elsewhere
(e.g. Emacs):

    envy exec foo blah

It will execute `blah` with the environment from your other terminal.

When direnv/nix changes, just re-run the save command.
