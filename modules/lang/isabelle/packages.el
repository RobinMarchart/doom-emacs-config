
(package! isar-mode :recipe (:type git :host github :repo "m-fleury/isar-mode"))
(package! isar-goal-mode :recipe (:type git :host github :repo "m-fleury/simp-isar-mode"))
(if (modulep! :tools lsp +eglot)
    (package! lsp-isar :recipe (:type git :host github :repo "RobinMarchart/isabelle-emacs" :branch "Isabelle2023-eglot" :files ("src/Tools/emacs-lsp/lsp-isar/*.el")))
  (package! lsp-isar :recipe (:type git :host github :repo "RobinMarchart/isabelle-emacs" :branch "Isabelle2023-vsce" :files ("src/Tools/emacs-lsp/lsp-isar/*.el"))))
(package! session-async)
