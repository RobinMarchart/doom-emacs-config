;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Robin Marchart"
      user-mail-address "robin.marchart@tum.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/")
(setq org-roam-directory "~/notes/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default
 tab-width 4)

(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      truncate-string-ellipsis "…"
      doom-theme 'doom-horizon)

(setq +lookup-open-url-fn #'eww)

(setq +latex-viewers '(pdf-tools))

(add-hook! meson-mode 'company-mode)

(add-hook! org-mode 'org-fragtog-mode)

(display-time-mode 1)
(display-battery-mode 1)
;;(elcord-mode)
(setq elcord-use-major-mode-as-main-icon t)

(map! :map text-mode-map
      :leader
      :desc "recover current file from autosave"
      :n "f C-r" 'recover-this-file)

;;(add-to-list 'elcord-boring-buffers-regexp-list '"doom")

(setq org-icalendar-store-UID t
      org-icalendar-include-todo "all"
      org-icalendar-combined-agenda-file "~/.org-calendar.ics")

(defun export-org-icalendar ()
  "Export org-agenda to icalendar file"
  (org-icalendar-combine-agenda-files)
  (message "Exported org-agenda to %s" org-icalendar-combined-agenda-file))

;; (run-at-time "1 sec" 1800 'export-org-icalendar)

(after! elfeed
  (setq elfeed-search-filter "@2-month-ago"))

(map! :leader
      :desc "Open rss feed"
      :n "o C-r" 'elfeed)
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)



(setq lsp-clients-clangd-args '("-j=4"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(setq lsp-rust-analyzer-cargo-auto-reload t)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")

;;(setq eglot-rust-server 'rust-analyzer)
;; (add-to-list 'lsp-file-watch-ignored ' "\\.clangd")
;; (add-to-list 'lsp-file-watch-ignored ' "\\.ccls-cache")
(setq lsp-enabled-clients nil)

(map! :after org
      :map org-mode-map
      :localleader
      :nv "C-t" #'org-toggle-inline-images)

;; (setq org-latex-inputenc-alist '(("utf8" . "utf8x")))
(setq doom-font (font-spec :family "Fira Mono"))

(eval-after-load "org-roam"
  '(setq org-roam-capture-templates
         '(("l" "render latex on open" plain "%?" :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
#+STARTUP: latexpreview
") :unnarrowed t))))

(map!
 :leader
 :prefix "h"
 :desc "Run evil tutor"
 :n "C-T" #'evil-tutor-start)

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda () (org-present-big)))
     (add-hook 'org-present-mode-quit-hook
               (lambda () (org-present-small)))
     (define-key org-present-mode-keymap [left] ())
     (define-key org-present-mode-keymap [right] ())
     (advice-add 'org-present :before
                 (lambda (&rest _r)
                   (flycheck-mode -1)
                   (org-latex-preview '(64))
                   (disable-theme doom-theme)
                   (load-theme 'doom-one-light t)
                   (org-latex-preview '(16))
                   (org-display-inline-images)))
     (advice-add 'org-present-quit :after
                 (lambda (&rest _r)
                   (org-latex-preview '(64))
                   (disable-theme 'doom-one-light)
                   (load-theme 'doom-horizon t)
                   (org-latex-preview '(16))))))

(setq ws-butler-trim-predicate (lambda (_beg _end)
                                 (named-let check-modes ((index ws-butler-global-exempt-modes))
                                   (if index
                                       (if (derived-mode-p (car index))
                                           nil
                                         (check-modes (cdr index)))
                                     t))))

(set-email-account! "fs"
                    '())
