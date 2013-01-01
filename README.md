speaker
=======

Work-in-progress thing to read stories out loud.

Usage:

`bundle exec bin/speak.rb something.pdf`

Uses the `pdftotext` command line utility from poppler-utils or xpdf
or whatever, `mplayer` to play the sound, as well as `espeak` and
`lame` for the `espeak-ruby` gem. Splitting into sentences is done
with the aid of the `tactful_tokenizer` gem.

Features that would be cool in the future:
*   Pausing/resuming
*   Saving current place, so we can resume later
*   Better handling of weirdnesses of the output from pdftotext, such as
    the typographic ligatures that LaTeX uses (eg, "fi" gets combined
    into one unicode character and it confuses the text to speech
    sometimes).  There's also the issue of, for example, page breaks
    breaking the flow of text as well as the problem of page numbers.
*   Making sound-playing more cross-platform and remove the mplayer
    dependency, though I don't know what libraries to use for ruby.
*   Making the mp3 files not sit around after ctrl-c?
