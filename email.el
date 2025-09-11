;;; email.el -*- lexical-binding: t; -*-

(set-email-account! "fs"
                    '((mu4e-sent-folder . "fs/Sent")
                      (mu4e-drafts-folder . "fs/Drafts")
                      (mu4e-trash-folder . "fs/Trash")
                      (mu4e-refile-folder . "fs/INBOX"))
                    t)

(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)
