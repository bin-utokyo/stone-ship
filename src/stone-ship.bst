%%
%% stone-ship.bst
%% BibTeX style file for stone-ship project
%%
%% Reference format:
%%   @article:       Author: Title, Journal, Vol. X, No. Y, pp. Z--W, Year.
%%   @book:          Author: Title, Publisher, Year.
%%   @inproceedings: Author: Title, Booktitle, [Publisher,] pp. Z--W, Year.
%%   @phdthesis:     Author: Title, [type,] School, Year.
%%   @mastersthesis: Author: Title, [type,] School, Year.
%%   @techreport:    Author: Title, [type No. X,] Institution, Year.
%%   @misc:          Author: Title, Howpublished, Year.
%%
%% Usage:
%%   \bibliographystyle{stone-ship}
%%   \bibliography{refs}
%%

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence last.extra.num }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
}

STRINGS { s t last.label next.extra }

%% ------------------------------------------------------------------
%% Label computation for natbib (author-year citations)
%% ------------------------------------------------------------------

%% format.lab.names: short author name (last name only, or "et al.")
FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 >
    { s #1 "{vv~}{ll}" format.name$ " et~al." * }
    { s #1 "{vv~}{ll}" format.name$ }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

%% calc.label: sets label = "AuthorShort(year" (closing paren added in output.bibitem)
FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label
        'author.key.label
      if$
    }
  if$
  "(" *
  year field.or.null *
  'label :=
}

%% ------------------------------------------------------------------
%% Output functions
%% ------------------------------------------------------------------

%% output.nonnull: called with stack = [prev_str, new_str]
%%   writes prev_str (with ", " prefix if mid.sentence),
%%   leaves new_str on stack.
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { write$ }
  if$
  mid.sentence 'output.state :=
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

%% ------------------------------------------------------------------
%% Logical helpers
%% ------------------------------------------------------------------

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

%% ------------------------------------------------------------------
%% Name formatting
%% ------------------------------------------------------------------

INTEGERS { nameptr namesleft numnames }

%% format.names: formats a name field as "Last, F., Last2, F2., ..."
FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{vv~}{ll}{, f.}" format.name$ 't :=
      nameptr #1 >
        { ", " * t * }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", eds." * }
        { ", ed." * }
      if$
    }
  if$
}

%% ------------------------------------------------------------------
%% Field format functions
%% ------------------------------------------------------------------

FUNCTION {format.title}
{ title empty$
    { "" }
    { title }
  if$
}

%% Combine authors (or editors) with title, separated by ": "
FUNCTION {format.author.title}
{ format.authors empty$
    { format.title }
    { format.authors ": " * format.title * }
  if$
}

FUNCTION {format.editor.title}
{ format.editors empty$
    { format.title }
    { format.editors ": " * format.title * }
  if$
}

%% n.dashify: convert single hyphens to double (en-dash) in page ranges
FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        'year
        { month " " * year * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "pp.~" pages n.dashify * }
        { "p.~" pages * }
      if$
    }
  if$
}

%% format.vol.num: "Vol. X, No. Y" (pages excluded)
FUNCTION {format.vol.num}
{ volume empty$
    { number empty$
        { "" }
        { "No.~" number * }
      if$
    }
    { "Vol.~" volume *
      number empty$
        'skip$
        { ", No.~" * number * }
      if$
    }
  if$
}

%% format.vol.num.pages: "Vol. X, No. Y, pp. Z--W"
FUNCTION {format.vol.num.pages}
{ volume empty$
    { number empty$
        { format.pages }
        { "No.~" number *
          pages empty$
            'skip$
            { ", " * format.pages * }
          if$
        }
      if$
    }
    { "Vol.~" volume *
      number empty$
        'skip$
        { ", No.~" * number * }
      if$
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { address empty$
        { "" }
        { address }
      if$
    }
    { publisher
      address empty$
        'skip$
        { ", " * address * }
      if$
    }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition " edition" * }
  if$
}

FUNCTION {format.type.number}
{ type empty$
    { "Technical Report" }
    { type }
  if$
  number empty$
    'skip$
    { " " * number * }
  if$
}

%% ------------------------------------------------------------------
%% Entry type handlers
%% ------------------------------------------------------------------

%% @article
%% Format: Author: Title, Journal, Vol. X, No. Y, pp. Z--W, Year.
FUNCTION {article}
{ output.bibitem
  format.author.title "title" output.check
  journal empty$
    'skip$
    { journal output }
  if$
  format.vol.num.pages output
  note output
  format.date "year" output.check
  fin.entry
}

%% @book
%% Format: Author: Title, Publisher, [note,] Year.
%%      or Editor, ed.: Title, Publisher, [note,] Year.
FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editor.title "author and editor" output.check }
    { format.author.title "title" output.check }
  if$
  format.edition output
  format.publisher output
  note output
  format.date "year" output.check
  fin.entry
}

%% @booklet
FUNCTION {booklet}
{ output.bibitem
  format.author.title "title" output.check
  howpublished output
  format.date output
  note output
  fin.entry
}

%% @inproceedings (= @conference)
%% Format: Author: Title, Booktitle, Vol. X, [Publisher,] pp. Z--W, [note,] Year.
FUNCTION {inproceedings}
{ output.bibitem
  format.author.title "title" output.check
  booktitle empty$
    'skip$
    { booktitle output }
  if$
  format.vol.num output
  organization output
  publisher output
  format.pages output
  note output
  format.date "year" output.check
  fin.entry
}

FUNCTION {conference} { inproceedings }

%% @incollection
%% Format: Author: Title, In Editor, ed.: Booktitle, Publisher, pp. Z--W, [note,] Year.
FUNCTION {incollection}
{ output.bibitem
  format.author.title "title" output.check
  booktitle empty$
    'skip$
    { editor empty$
        { "In " booktitle * }
        { "In " format.editors * ": " * booktitle * }
      if$
      output
    }
  if$
  format.edition output
  format.publisher output
  format.pages output
  note output
  format.date "year" output.check
  fin.entry
}

%% @manual
FUNCTION {manual}
{ output.bibitem
  format.author.title "title" output.check
  organization output
  address output
  format.edition output
  format.date output
  note output
  fin.entry
}

%% @mastersthesis
%% Format: Author: Title, [type,] School, [note,] Year.
FUNCTION {mastersthesis}
{ output.bibitem
  format.author.title "title" output.check
  type empty$
    { "Master's thesis" output }
    { type output }
  if$
  school "school" output.check
  note output
  format.date "year" output.check
  fin.entry
}

%% @misc
%% Format: Author: Title, Howpublished, Year.
FUNCTION {misc}
{ output.bibitem
  format.author.title output
  howpublished output
  format.date output
  note output
  fin.entry
}

%% @phdthesis
%% Format: Author: Title, [type,] School, [note,] Year.
FUNCTION {phdthesis}
{ output.bibitem
  format.author.title "title" output.check
  type empty$
    { "PhD thesis" output }
    { type output }
  if$
  school "school" output.check
  note output
  format.date "year" output.check
  fin.entry
}

%% @proceedings
FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { format.title "title" output.check }
    { format.editor.title "title" output.check }
  if$
  organization output
  format.publisher output
  note output
  format.date "year" output.check
  fin.entry
}

%% @techreport
%% Format: Author: Title, type No. X, Institution, [note,] Year.
FUNCTION {techreport}
{ output.bibitem
  format.author.title "title" output.check
  format.type.number output
  institution "institution" output.check
  note output
  format.date "year" output.check
  fin.entry
}

%% @unpublished
FUNCTION {unpublished}
{ output.bibitem
  format.author.title "title" output.check
  note "note" output.check
  format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

%% ------------------------------------------------------------------
%% Macro definitions (month abbreviations, journal abbreviations)
%% ------------------------------------------------------------------

MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}

%% ------------------------------------------------------------------
%% Sort key calculation (for alphabetical ordering by author+year+title)
%% ------------------------------------------------------------------

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      t sortify *
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "a " #2
    "an " #3
      "the " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.sort
        'author.sort
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

READ

ITERATE {calc.label}

ITERATE {presort}

SORT

%% ------------------------------------------------------------------
%% Disambiguation for same-author same-year entries
%% ------------------------------------------------------------------

FUNCTION {initialize.extra.label.stuff}
{ "" 'last.label :=
  "" 'next.extra :=
  "a" chr.to.int$ 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.str$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}
ITERATE {forward.pass}
REVERSE {reverse.pass}

%% ------------------------------------------------------------------
%% Initialize and produce output
%% ------------------------------------------------------------------

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{999}" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
