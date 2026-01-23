;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big

;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Ubuntu Mono" :size 14))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-default-notes-file (expand-file-name "inbox.org" org-directory))
(setq org-id-locations-file (expand-file-name ".orgids" "~/.config/emacs/.local/etc/org/"))
(map! :leader
      (:prefix ("o" . nil)
       :desc "Org capture" "o" #'org-capture))
(after! org
        (setq org-capture-templates
              `(
                ("n" "notes" entry
                 (file+headline "~/org/inbox.org" "Notes")
                 "* %U %?")
                ("d" "ideas" plain
                 (file+headline "~/org/inbox.org" "Ideas")
                 "- *%U* %?")
                ("t" "tasks" entry
                 (file "~/org/tasks.org")
                 "* TODO %?")
              )))

(after! org
        (setq org-agenda-files '("~/org/projects.org" "~/org/todos.org"))
        (setq org-agenda-skip-scheduled-if-done t
              org-agenda-skip-deadline-if-done t
              org-agenda-skip-timestamp-if-done t))

(setq org-roam-capture-templates
      '(("d" "ideas" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)
        ("r" "references" plain "%?"
         :if-new (file+head "reference/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+author: \n#+type: \n#+source: \n")
         :unnarrowed t)))
(use-package! org-roam
              :ensure t
              :custom
              (org-roam-directory (file-truename "~/org/roam/"))
              (org-roam-dailies-directory "dailies/")
              :config
              (org-roam-db-autosync-mode)
              (map! :leader
                   (:prefix ("n" . nil)
                    :desc "Org-roam capture"       "c" #'org-roam-capture
                    :desc "Org-roam insert node"   "i" #'org-roam-node-insert
                    :desc "Org-roam find node"     "f" #'org-roam-node-find
                    :desc "Org-roam buffer toggle" "l" #'org-roam-buffer-toggle
                    :desc "Org-roam UI"            "g" #'org-roam-ui-mode
                    :desc "Today"                  "t" #'org-roam-dailies-goto-today
                    :desc "Yesterday"              "y" #'org-roam-dailies-goto-yesterday
                    :desc "Tomorrow"               "m" #'org-roam-dailies-goto-tomorrow)))
(use-package! org-roam-ui
              :after org-roam
              :hook (org-roam-mode . org-roam-ui-mode)
              :config
              (setq org-roam-ui-sync-theme t
                    org-roam-ui-follow t
                    org-roam-ui-update-on-save t
                    org-roam-ui-open-on-start t))

(setq evil-escape-key-sequence "jk")
(setq evil-escape-delay 0.2)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
