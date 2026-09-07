;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom!
 :input
 ;;chinese
 ;;japanese

 :completion
 ;; company; the ultimate code completion backend
 (corfu +icons)
 ;;helm              ; the *other* search engine for love and life
 ;;ido               ; the other *other* search engine...
 ;;(ivy +icons +prescient +fuzzy)
                                        ; a search engine for love and life
 (vertico +icons)

 :ui
 ;; deft                         ; notational velocity for Emacs
 dashboard
 doom                         ; what makes DOOM look the way it does
 doom-quit                    ; DOOM quit-message prompts when you quit Emacs
 ;;fill-column       ; a `fill-column' indicator
 hl-todo                      ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
 indent-guides                ; highlighted indent columns
 ligatures
 ;;minimap           ; show a map of the code on the side
 modeline          ; snazzy, Atom-inspired modeline, plus API
 nav-flash         ; blink cursor line after big motions
 ;;neotree           ; a project drawer, like NERDTree for vim
 ophints                          ; highlight the region an operation acts on
 (popup +defaults)                ; tame sudden yet inevitable temporary windows
 smooth-scroll
 ;; tabs                   ; an tab bar for Emacs
 treemacs               ; a project drawer, like neotree but cooler
 unicode                ; extended unicode support for various languages
 ;; vc-gutter              ; vcs diff in the fringe
 vi-tilde-fringe        ; fringe tildes to mark beyond EOB
 window-select          ; visually switch windows
 workspaces             ; tab emulation, persistence & separate workspaces
 ;;zen               ; distraction-free coding or writing

 :editor
 (evil +everywhere)                     ; come to the dark side, we have cookies
 file-templates                         ; auto-snippets for empty files
 fold                                   ; (nigh) universal code folding
 (format +lsp +onsave)                  ; automated prettiness
 ;;god               ; run Emacs commands without modifier keys
 ;; lispy                ; vim for lisp, for people who don't like vim
 multiple-cursors
                                        ; editing in many places at once
 ;;objed             ; text object editing for the innocent
 parinfer    ; turn lisp into python, sort of
 ;;rotate-text       ; cycle region at point between text candidates
 snippets                               ; my elves. They type so I don't have to
 (whitespoace +guess +trim)
 word-wrap                            ; soft wrapping with language-aware indent

 :emacs
 (dired +dirvish +icons)                ; making dired pretty [functional]
 electric                               ; smarter, keyword-based electric-indent
 eww
 (ibuffer +icons)                       ; interactive buffer management
 tramp
 (undo +tree)            ; persistent, smarter undo for your inevitable mistakes
 vc                      ; version-control and Emacs, sitting in a tree

 :term
 eshell                  ; the elisp shell that works everywhere
 ;;shell             ; simple shell REPL for Emacs
 ;;term              ; basic terminal emulator for Emacs
 ;; vterm                                  ; the best terminal emulation in Emacs
 (ghostel +everywhere)
 
 :checkers
 (syntax +icons)                     ; tasing you for every semicolon you forget
 (spell +hunspell +everywhere)       ; tasing you for misspelling mispelling
 grammar                             ; tasing grammar mistake every you make

 :tools
 ;;ansible
 biblio
 debugger ;; stepping through code, to help you add bugs
 direnv
 (docker +lsp)
 editorconfig                      ; let someone else argue about tabs vs spaces
 ;; ein                               ; tame Jupyter notebooks with emacs
 (eval +overlay)
                                        ; run code, run (also, repls)
 (lookup +docsets +dictionary +offline) ; navigate your code and its documentation
 (lsp +eglot +booster)
 (magit +forge)                         ; a git porcelain for Emacs
 make                                   ; run make tasks from Emacs
 (pass +auth)                           ; password manager for nerds
 pdf                                    ; pdf enhancements
 ;;prodigy           ; FIXME managing external services & code builders
 ;;terraform         ; infrastructure as code
 tmux                                   ; an API for interacting with tmux
 tree-sitter
 upload                               ; map local to remote projects via ssh/ftp

 :lang
 ;;isabelle
 ;;agda              ; types of types of types of types...
 (cc +lsp)                              ; C/C++/Obj-C madness
 ;;clojure           ; java with a lisp
 ;; common-lisp                    ; if you've seen one lisp, you've seen them all
 ;; coq                             ; proofs-as-programs
 ;;crystal           ; ruby at the speed of c
 (csharp +dotnet +lsp)
 ;;                                        ; unity, .NET, and mono shenanigans
 data
                                        ; config/data formats
 ;;(dart +flutter)   ; paint ui and not much else
 ;;elixir            ; erlang done right
 ;;elm               ; care for a cup of TEA?
 emacs-lisp   ; drown in parentheses
 ;;erlang            ; an elegant language for a more civilized age
 ;;ess               ; emacs speaks statistics
 ;; faust      ; dsp, but you get to keep your soul
 ;;fsharp           ; ML stands for Microsoft's Language
 ;;fstar             ; (dependent) types and (monadic) effects and Z3
 ;;factor
 ;;gdscript          ; the language you waited for
 ;;(go +lsp)         ; the hipster dialect
 (graphql +lsp +tree-sitter)
 graphviz
 ;; (haskell +dante)
 ;;                                        ; a language that's lazier than I am
 ;;hy                ; readability of scheme w/ speed of python
 ;;idris             ;
                                        ; At least it ain't XML
 (java +lsp)                       ; the poster child for carpal tunnel syndrome
 (javascript +lsp +tree-sitter)                 ; all(hope(abandon(ye(who(enter(here))))))
 (json +tree-sitter)
 ;;julia             ; a better, faster MATLAB
 ;;kotlin            ; a better, slicker Java(Script)
 (latex +cdlatex +fold +lsp)     ; writing papers in Emacs has never been so fun
 ;;(lean +lsp)
 ;;ledger            ; an accounting system in Emacs
 (lua +lsp)                             ; one-based indices? one-based indices
 (markdown +grip)          ; writing docs for people to ignore
 (nix +lsp)                             ; I hereby declare "nix geht mehr!"
 ;; ocaml                                  ; an objective camel
 (org +dragndrop +gnuplot +jupyter +pandoc +present +pretty +roam)
                                        ; organize your plain life in plain text
 ;;php               ; perl's insecure younger brother
 ;;plantuml          ; diagrams for confusing people more
 ;;purescript        ; javascript, but functional
 (python +lsp +uv)      ; beautiful is better than ugly
 ;;qt                ; the 'cutest' gui framework ever
 ;;racket            ; a DSL for DSLs
 ;;raku              ; the artist formerly known as perl6
 (rest +jq)                             ; Emacs as a REST client
 ;; rst                                    ; ReST in peace
 ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
 (rust +lsp)
                                        ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
 ;;scala             ; java, but good
 ;;scheme            ; a fully conniving family of lisps
 (sh +lsp)    ; she sells {ba,z,fi}sh shells on the C xor
 ;;sml
 ;;solidity          ; do you need a blockchain? No.
 ;;swift             ; who asked for emoji variables?
 ;;terra             ; Earth and Moon in alignment for performance.
 (web +lsp +tree-sitter)                ; the tubes
 (yaml +lsp +tree-sitter)               ; JSON, but readable

 :email
 ;; (mu4e +org +gmail +offlineimap)
 ;;notmuch
 ;;(wanderlust +gmail)

 :app
 calendar
 ;; (rss +org)
                                        ; emacs as an RSS reader
 ;;everywhere
 ;;twitter           ; twitter client https://twitter.com/vnought
 ;; irc               ; how neckbeards socialize
 ;; emms     ; music player

 :config
 ;;literate
 (default +bindings +smartparens +gnupg)

 :os
 (tty +osc))


(after! doom-cli-env
  (add-to-list 'doom-env-allow "^SSH_")
  (add-to-list 'doom-env-deny "HYPRLAND_INSTANCE_SIGNATURE")
  (add-to-list 'doom-env-deny "MANAGERPID")
  (add-to-list 'doom-env-deny "INVOCATION_ID")
  (add-to-list 'doom-env-deny "MEMORY_PRESSURE_WATCH")
  (add-to-list 'doom-env-deny "SYSTEMD_EXEC_PID")
  (add-to-list 'doom-env-deny "MEMORY_PRESSURE_WRITE"))

(autoload 'define-compilation-mode "compile" nil nil 'macro)
