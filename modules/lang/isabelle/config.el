(defvar isabelle-dir "")

(use-package! isar-mode
  :mode "\\.thy\\'"
  :config
  (add-hook 'isar-mode-hook 'company-mode)
  (add-hook 'isar-mode-hook 'flycheck-mode)
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet)))))
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'ident-tabs-mode) nil)))
  (add-hook 'isar-mode-hook
            (lambda ()
              (yas-minor-mode)))
  (add-hook 'isar-mode-hook
            (lambda ()
              (unicode-tokens-mode) (unicode-tokens-mode)))
  (add-hook 'isar-mode-hook #'display-line-numbers-mode))

(use-package! lsp-isar-parse-args
  :defer t
  :custom (lsp-isar-parse-args-nollvm nil))

(use-package! lsp-isar
  :hook (isar-mode . lsp-isar-define-client-and-start)
  :defer t
  :commands lsp-isar-define-client-and-start
  :custom
  (lsp-isar-output-use-async t)
  (lsp-isar-output-time-before-printing-goal nil)
  (lsp-isar-experimental t)
  (lsp-isar-split-pattern 'lsp-isar-split-pattern-two-columns)
  (lsp-isar-decorations-delayed-printing t)
  :config
  (push (concat isabelle-dir "/src/Tools/emacs-lsp/yasnippet") yas-snippet-dirs)
  (setq  lsp-isar-path-to-isabelle isabelle-dir)
  :init
  (defun lsp-isar-open-output-and-progress-isabelle ()
    (interactive)
    (split-window-below)
    (other-window 1)
    (switch-to-buffer "*lsp-isar-state*")
    (text-scale-set -1)
    (lsp-isar-toggle-window-dedicated)
    (evil-window-set-height 12)
    (split-window-right)
    (other-window 1)
    (evil-window-set-width 80)
    (switch-to-buffer "*lsp-isar-output*")
    (text-scale-set -1)
    (lsp-isar-toggle-window-dedicated)
    (other-window -2)
    (split-window-right)
    (other-window 1)
    (switch-to-buffer "*lsp-isar-progress*")
    (evil-window-set-width 40)
    (text-scale-set -3)
    (lsp-isar-toggle-window-dedicated)
    (other-window -1))
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-isabelle))

(after! isar-mode
  (defun ~/evil-motion-range--wrapper (fn &rest args)
    "Like `evil-motion-range', but override field-beginning for performance.
        See URL `https://github.com/ProofGeneral/PG/issues/427'."
    (cl-letf (((symbol-function 'field-beginning)
               (lambda (&rest _args) 1)))
      (apply fn args)))

  (advice-add #'evil-motion-range :around #'~/evil-motion-range--wrapper))

(map! :after isar-mode :leader :map 'isar-mode-map :localleader
      (:prefix ("t" . "Try0...")
       :desc "Insert try0"           "t" #'lsp-isar-insert-try
       :desc "Insert with interface" "T" #'lsp-isar-insert-try-and-call
       :desc "Insert proof"          "i" #'lsp-isar-insert-try0-proof)
      (:prefix ("s" . "Sledgehammer...")
       :desc "Open interface"        "s" #'lsp-isar-sledgehammer-interface
       :desc "Insert with interface" "S" #'lsp-isar-insert-sledgehammer-and-call
       :desc "Insert sledgehammer"   "i" #'lsp-isar-insert-sledgehammer)
      :desc "Insert proof outline"    "P" #'lsp-isar-insert-proof-outline
      :desc "Delete windows"          "K" #'delete-other-windows ;; not quite finished
      :desc "Switch to output"        "a" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-output*"))
      :desc "Switch to state"         "i" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-state*"))
      :desc "Switch to progress"      "e" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-progress*"))
      :desc "Open panels"             "W" #'lsp-isar-open-output-and-progress-isabelle)
