;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(when (not (eq system-type 'darwin))
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; Disable splash screen
(setq inhibit-startup-message t)

;; Store lisp files and thems in subdirs
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "setup" user-emacs-directory))
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; Keep Emacs Custom-settings in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Write backup files to separate directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name (concat user-emacs-directory "backups")))))

;; Write all autosave files to temp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Don't write lock files, I'm the only one here
(setq create-lockfiles nil)

;; Create backup files, even for files under version control
(setq vc-make-backup-files t)

(setq visible-bell t)
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))
(setq set-fringe-mode 30)

;; Set default face
(setq fixed-pitch-font "Iosevka Custom Fixed Sans"
      variable-pitch-font "Iosevka Custom Quasiproportional"
      fixed-pitch-serif-font "Iosevka Custom Fixed Slab"
      font-height 170)
(when (eq system-type 'gnu/linux)
  (setq fixed-pitch-font (format "%s Medium" fixed-pitch-font)
        fixed-pitch-serif-font (format "%s Medium" fixed-pitch-serif-font)
	font-height 140))
(set-face-attribute 'fixed-pitch nil :font fixed-pitch-font :height font-height)
(set-face-attribute 'variable-pitch nil :font fixed-pitch-font :height font-height)
(set-face-attribute 'fixed-pitch-serif nil :font fixed-pitch-serif-font :height font-height)
(set-face-attribute 'default nil :font fixed-pitch-serif-font :height font-height)

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)
;; Set up display-line-numbers-mode
(setq-default display-line-numbers-width 4)
(setq display-line-numbers-type 'relative
      display-line-numbers-current-absolute t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers automatically
(setq global-auto-revert-non-file-buffers t)

(add-hook 'after-init-hook #'recentf-mode)
(setq recentf-max-saved-items 100)
;; (customize-set-variable 'recentf-save-file (expand-file-name "recentf" ttt))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super
        mac-option-modifier 'meta
        mac-right-option-modifier 'none)
  (add-to-list 'exec-path "/opt/homebrew/bin")
  (add-to-list 'exec-path "/opt/homebrew/opt/llvm/bin")
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

;; Make shebang (#!) files executable when saved
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(cmake-mode . cmake-ts-mode))
(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(load-theme 'permutation t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(use-package mood-line
  :ensure t
  :custom
  (mood-line-show-eol-style t)
  (mood-line-show-encoding-information t)
  (mood-line-glyph-alist mood-line-glyphs-unicode)
  (mood-line-evil-state-alist nil)
  :config (mood-line-mode))

;; FIXME: this is very slow in C++ w/ Eglot enabled
(use-package which-func
  :disabled
  :ensure nil
  :hook (prog-mode . which-function-mode))

(use-package whitespace
  :ensure nil
  :config
  ;; (setq whitespace-style '(face empty tabs lines-trail trailing))
  (setq whitespace-style '(facs tabs spaces tab-mark newline-mark))
  (setq whitespace-line-column 80)
  (setq whitespace-display-mappings
        '((tab-mark ?\t [?▸ ?\t])
          (newline-mark ?\n [?¬ ?\n])))
  ;; (global-whitespace-mode t)
)

;; Smartparens
(use-package smartparens-config
  :ensure smartparens
  :hook
  (prog-mode . smartparens-mode)
  (emacs-lisp-mode . (lambda () (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)))
  :bind (:map smartparens-mode-map
              ;; Movement
              ("C-f" . sp-forward-symbol)
              ("C-b" . sp-backward-symbol)
              ("C-M-f" . sp-forward-sexp)
              ("C-M-b" . sp-backward-sexp)
              ("C-M-S-f" . sp-beginning-of-next-sexp)
              ("C-M-S-b" . sp-end-of-previous-sexp)
              ("C-M-d" . sp-down-sexp)
              ("C-M-u" . sp-up-sexp)
              ("C-M-S-d" . sp-backward-down-sexp)
              ("C-M-S-u" . sp-backward-up-sexp)
              ("C-M-n" . sp-next-sexp)
              ("C-M-e" . sp-previous-sexp)
              ("C-M-a" . sp-beginning-of-sexp)
              ("C-M-p" . sp-end-of-sexp)
              ;; Manipulation
              ("C-M-k" . sp-kill-sexp)
              ("C-- C-M-k" . sp-backward-kill-sexp)
              ("C-M-t" . sp-transpose-sexp)
              ("C-<right>" . sp-forward-slurp-sexp)
              ("C-<left>" . sp-forward-barf-sexp)
              ("C-M-<left>" . sp-backward-slurp-sexp)
              ("C-M-<right>" . sp-backward-barf-sexp)
              ;; Wrapping
              ("C-c s u" . sp-unwrap-sexp)
              ("C-c s r" . sp-rewrap-sexp)
              ("C-c s {" . sp-wrap-curly)
              ("C-c s (" . sp-wrap-round)
              ("C-c s [" . sp-wrap-square)
              ;; ("" . )
              ;; ("" . )
              ;; ("C-<down>" . sp-backward-down-sexp)
              ;; ("C-<up>" . sp-backward-up-sexp)
              ;; ("M-<down>" . sp-down-sexp)
              ;; ("M-<up>" . sp-up-sexp)
              )
  ;; ("M-[" . '(sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))
  :custom
  (sp-navigate-reindent-after-up nil)
  (sp-navigate-reindent-after-up-in-string nil)
  (sp-c-modes '(c-mode c++-mode c-ts-mode c++-ts-mode))
  (sp-navigate-close-if-unbalanced nil)
  :config
  (sp-local-pair 'c++-ts-mode "<" ">"))


;; Keep cursor away from edges when scrolling up/down
(use-package smooth-scrolling
  :ensure t
  :custom
  (smooth-scroll-margin 3)
  :config
  (smooth-scrolling-mode 1))

;; Represent undo-history as an actual tree (visualize with C-x u)
(use-package undo-tree
  :disabled
  :ensure t
  :custom
  (undo-tree-auto-save-history nil)
  :config
  (global-undo-tree-mode))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; Vertical minibuffer completion UI
(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; Save history across Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure t
  :config
  (savehist-mode))

;; Show num matches for Isearch
(use-package isearch
  :ensure nil
  :custom
  (isearch-lazy-count t)
  (isearch-wrap-pause 'no-ding)
  (isearch-repeat-on-direction-change t)
  :bind (:map isearch-mode-map
              ("M-<up>" . isearch-ring-retreat)
              ("M-<down>" . isearch-ring-advance)))

;; Prefix key help
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;; Completion style w/o order
(use-package orderless
  :ensure t
  :custom
  ;; (orderless-matching-styles '(orderless-literal orderless-regexp))
  (orderless-matching-styles '(orderless-literal orderless-flex))
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles . (basic partial-completion flex initials))))))

(use-package consult
  :ensure t
  :config
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package embark
  :disabled
  :ensure t
  :config
  (global-set-key [remap describe-bindings] #'embark-bindings)
  (keymap-global-set "C-." 'embark-act)
  (with-eval-after-load 'embark-consult
    (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)))

(use-package embark-consult
  :disabled
  :after embark
  :ensure t)

;; In-buffer completion UI
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match t)        ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  (corfu-on-exact-match 'quit)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  :init
  (global-corfu-mode)
  (eldoc-add-command #'corfu-insert))

(use-package cape
  :ensure t
  :config
  ;; Add useful default completion sources from cape
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  ;; Silence the pcomplete capf, no errors or messages!
  ;; Important for corfu
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; Silence the pcomplete capf, no errors or messages!
  ;; Important for corfu.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
  (add-hook 'eshell-mode-hook (lambda () (setq-local corfu-quit-at-boundary t
                                                     corfu-quit-no-match t
                                                     corfu-auto nil))))

;; Org
(use-package org
  :ensure nil
  :hook
  (org-mode . buffer-face-mode)
  (org-mode . (lambda ()
                (setq org-format-latex-options
                      (plist-put org-format-latex-options :scale 1.7))))
  :config
  ;; TODO: consider `org-startup-indented` and `org-adapt-indentation`
  (setq org-hide-leading-stars t
        org-startup-folded t
        org-startup-indented t
        org-todo-keywords '((sequence "TODO" "PENDING" "|" "DONE"))
        org-latex-create-formula-image-program 'dvisvgm))
;; Org Markdown exporter
(use-package ox-md
  :after org
  :ensure nil)

;; Org-Roam
(use-package org-roam
  :ensure t
  :config
  (setq org-roam-directory (file-truename "~/Roam/"))
  (org-roam-db-autosync-mode))

;; Eglot
(use-package eglot
  :ensure nil
  :init
  (setq xref-auto-jump-to-first-xref 'show)
  ;; (setq eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit)
  (setq eldoc-echo-area-use-multiline-p nil)
  (setq eldoc-echo-area-display-truncation-message nil)
  (setq eldoc-minor-mode-string nil)
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (eldoc-add-command 'c-electric-paren)
  (setq max-mini-window-height 3)
  :bind (:map eglot-mode-map
              (("M-q" . eglot-format)
               ("M-Q" . eglot-format-buffer)
               ("C-." . eglot-find-implementation)
               ("C-M-." . eglot-find-declaration)))
  :config
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'c++-ts-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'python-ts-mode-hook 'eglot-ensure))

(use-package project
  :ensure nil)

;; Magit
(use-package magit
  :ensure t
  :demand t
  :after project
  :bind (:map magit-mode-map (("e" . magit-section-backward)
                              ("p" . magit-ediff-dwim)
                              ("M-e" . magit-section-backward-sibling)))
  :config
  (add-to-list 'project-switch-commands '(magit-project-status "Magit" ?m))
  (magit-save-repository-buffers nil))

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package emacs
  :ensure nil
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package markdown-mode
  :ensure t
  :config
  (setq markdown-asymmetric-header t)
  (setq markdown-header-scaling t))

(use-package rainbow-delimiters
  :disabled
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rg
  :ensure t
  :custom
  (rg-command-line-flags '("--hidden")))

(use-package treesit
  :ensure nil
  :config
  (setq treesit-extra-load-path '("/Users/norman/Code/tree-sitter-module/dist"))
  (setq treesit-font-lock-level 4))

;; C/C++
(use-package cc-mode
  :ensure nil
  :config
  (setq c-basic-offset 4)
  (setq c-default-style "stroustrup"))

(use-package c-ts-mode
  :after cc-mode
  :ensure nil
  :bind (:map c++-ts-mode-map (("M-Q" . eglot-format-buffer)))
  :hook
  (c++-ts-mode . (lambda() (keymap-set c++-ts-mode-map
                                       "M-["
                                       (sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))))
  (c++-ts-mode . (lambda() (keymap-set c++-ts-mode-map
                                       "M-]"
                                       (sp-restrict-to-pairs-interactive "{" 'sp-backward-up-sexp))))
  (c++-ts-mode . (lambda() (keymap-set c++-ts-mode-map
                                       "M-("
                                       (sp-restrict-to-pairs-interactive "(" 'sp-down-sexp))))
  (c++-ts-mode . (lambda() (keymap-set c++-ts-mode-map
                                       "M-)"
                                       (sp-restrict-to-pairs-interactive ")" 'sp-backward-up-sexp))))
  :config
  (setq c-ts-mode-indent-offset c-basic-offset
        c-ts-mode-indent-style 'bsd))

(use-package find-file
  :ensure nil
  :bind (("C-c I" . (lambda () (interactive) (find-file user-init-file)))
         :map c++-ts-mode-map
         ("C-c o" . ff-find-other-file)))

(use-package avy
  :ensure t
  :custom
  (avy-keys '(?a ?r ?s ?t ?n ?e ?i ?o))
  ;; (avy-style 'de-bruijn)
  (avy-background t)
  (avy-timeout-seconds 0.25)
  (avy-orders-alist '((avy-goto-char-timer . avy-order-closest)))
  (avy-all-windows nil)
  :bind (([remap goto-line] . avy-goto-line)
         ("C-'" . avy-goto-char-timer)))

(use-package crux
  :ensure t
  :bind (("C-k" . crux-smart-kill-line)
         ("C-S-k" . kill-line)
         ("C-o" . crux-smart-open-line)
         ("C-S-o" . crux-smart-open-line-above)
         ("C-x 4 t" . crux-transpose-windows)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c ," . crux-find-user-custom-file)
         ("C-^" . crux-top-join-line)
         ("M-o" . crux-other-window-or-switch-buffer)))

(use-package cmake-mode
  :ensure t)

(use-package deadgrep
  :ensure t
  :bind (:map deadgrep-mode-map
              ("e" . deadgrep-backward-match)
              ("M-e" . deadgrep-backward-filename)))

(use-package wgrep-deadgrep
  :ensure t
  :hook (deadgrep-finished . wgrep-deadgrep-setup))

(use-package visual-regexp
  :ensure t
  :bind (([remap query-replace-regexp] . vr/query-replace)))

(use-package zop-to-char
  :ensure t
  :bind ("C-M-S-z" . 'zop-to-char))

(use-package zzz-to-char
  :ensure t
  :bind ("C-M-z" . 'zzz-up-to-char))

(use-package help-mode
  :ensure nil
  :bind (:map help-mode-map ("e" . help-goto-previous-page)))

(use-package autoinsert
  :ensure nil
  :hook
  (find-file . auto-insert)
  :config
  (setq auto-insert-query nil
        auto-insert-directory (expand-file-name "auto-insert" user-emacs-directory)
        auto-insert-alist '((("\\.org\\'" . "Org-Mode file") . "template.org")))
  (auto-insert-mode))

(use-package dired
  :ensure nil
  :config
  (setf dired-kill-when-opening-new-dired-buffer t))

(use-package projectile
  :ensure t
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode))

(use-package autoinsert
  :ensure nil
  :hook
  (find-file . auto-insert)
  :config
  (setq auto-insert-query nil
        auto-insert-directory (expand-file-name "auto-insert" user-emacs-directory)
        auto-insert-alist '((("\\.org\\'" . "Org-Mode file") . "template.org")))
  (auto-insert-mode))

(use-package dired
  :ensure nil
  :config
  (setf dired-kill-when-opening-new-dired-buffer t))
  ;; :bind (:map dired-mode-map
  ;;             ("RET" . dired-find-alternate-file)
  ;;             ("^" . (lambda () (interactive) (find-alternate-file "..")))))

(require 'sane-defaults)
(require 'setup-evil)

;; Swap -p and -e bindings for Colemak
(define-key key-translation-map (kbd "C-e") (kbd "C-p"))
(define-key key-translation-map (kbd "C-p") (kbd "C-e"))
(define-key key-translation-map (kbd "M-e") (kbd "M-p"))
(define-key key-translation-map (kbd "M-p") (kbd "M-e"))
(define-key key-translation-map (kbd "C-M-e") (kbd "C-M-p"))
(define-key key-translation-map (kbd "C-M-p") (kbd "C-M-e"))

(keymap-global-set "M-F" 'forward-to-word)
(keymap-global-set "M-B" 'backward-to-word)
(keymap-global-set "C-x K" 'kill-this-buffer)
;; (keymap-global-set "M-<delete>" 'kill-word)
;; (keymap-global-set "C-<delete>" 'sp-kill-symbol)
(keymap-global-set "M-z" 'zap-up-to-char)
(keymap-global-set "M-Z" 'zap-to-char)
(keymap-global-set "C-<" 'beginning-of-defun)
(keymap-global-set "C->" 'end-of-defun)
(keymap-global-set "C-M-<" 'beginning-of-defun-comments)
(keymap-global-set "M-n" 'forward-to-indentation)
(keymap-global-set "M-p" 'backward-to-indentation)
(keymap-global-set "C-v" 'scroll-up-command)
(keymap-global-set "C-S-v" 'scroll-down-command)
;; (keymap-global-set "C-M->" 'end-of-)
(global-set-key  [remap list-buffers] 'ibuffer)

(keymap-set dired-mode-map "p" 'dired-find-file)
(keymap-set dired-mode-map "e" 'dired-previous-line)

(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
