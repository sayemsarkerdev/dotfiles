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
(setq doom-font (font-spec :size 14))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~/org/")
(setq org-default-notes-file (expand-file-name "refile.org" org-directory))
(after! org
        (setq org-capture-templates
              `(("r" "refile" plain
                 (file ,(expand-file-name "refile.org" org-directory))
                 "%?"))))
(after! org
        (setq org-id-locations-file (expand-file-name ".orgids" "~/.config/emacs/.local/etc/org/")))
(global-set-key (kbd "C-c n o") #'org-capture)

(setq org-agenda-files (directory-files-recursively org-directory "\\org$"))
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-timestamp-if-done t)

(setq org-roam-capture-templates
      '(("d" "defualt" plain "%?"
         :if-new (file+head "%<%Y$m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new (file+head "reference/%<%Y$m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+author: \n#+type: \n#+link: \n")
         :immediate-finish t
         :unnarrowed t)))
(use-package! org-roam
              :ensure t
              :custom
              (org-roam-directory (file-truename "~/org/roam/"))
              :bind (("C-c n l" . org-roam-buffer-toggle)
                     ("C-c n f" . org-roam-node-find)
                     ("C-c n g" . org-roam-ui-mode)
                     ("C-c n i" . org-roam-node-insert)
                     ("C-c n c" . org-roam-capture))
              :config
              (org-roam-db-autosync-mode))
(use-package! org-roam-ui
              :after org-roam
              :hook (org-roam-mode . org-roam-ui-mode)
              :config
              (setq org-roam-ui-sync-theme t
                    org-roam-ui-follow t
                    org-roam-ui-update-on-save t
                    org-roam-ui-open-on-start t))

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
