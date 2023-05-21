;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))

;; Disable splash screen
(setq inhibit-startup-message t)

;; Store lisp files and thems in subdirs
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
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
(set-face-attribute 'default nil :font "Iosevka Custom Fixed Slab")

;; Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)
;; Set up display-line-numbers-mode
(setq-default display-line-numbers-width 4)
(setq display-line-numbers-type 'relative
      display-line-numbers-current-absolute t)
(global-display-line-numbers-mode)

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

(if (eq system-type 'darwin)
    (set-face-attribute 'default nil :height 170)
  (set-face-attribute 'default nil :height 140))

;; Make shebang (#!) files executable when saved
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))

;; Ad-hoc theme
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "#8f8f8f"))))
 '(font-lock-comment-delimiter-face ((t (:inherit 'font-lock-comment-face))))
 '(font-lock-string-face ((t (:foreground "ForestGreen")))) ;VioletRed4
 '(font-lock-builtin-face ((t (:foreground "sienna"))))
 '(font-lock-type-face ((t (:foreground "dark slate blue"))))
 '(font-lock-variable-name-face ((t (:inherit 'default))))
 '(font-lock-operator-face ((t (:inherit 'font-lock-keyword-face))))
 '(font-lock-negation-char-face ((t (:inherit 'font-lock-keyword-face))))
 '(font-lock-escape-face ((t (:inherit 'warning :bold nil))))
 '(font-lock-number-face ((t (:inherit 'font-lock-constant-face))))
 ;; '(font-lock--face ((t (:foreground ))))
 '(org-default ((t (:inherit 'default :font "Iosevka Custom Fixed Sans"))))
 )

(require 'whitespace)
;; (setq whitespace-style '(face empty tabs lines-trail trailing))
(setq whitespace-style '(facs tabs spaces tab-mark newline-mark))
(setq whitespace-line-column 80)
(setq whitespace-display-mappings
      '((tab-mark ?\t [?▸ ?\t])
        (newline-mark ?\n [?¬ ?\n])))
;; (global-whitespace-mode t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; Smartparens
(use-package smartparens-config
  :ensure smartparens
  :hook
  (prog-mode . smartparens-mode)
  :bind (:map smartparens-mode-map
              ("C-f" . sp-forward-symbol)
              ("C-b" . sp-backward-symbol)
              ("C-M-f" . sp-forward-sexp)
              ("C-M-b" . sp-backward-sexp)
              ("C-<down>" . sp-backward-down-sexp)
              ("C-<up>" . sp-backward-up-sexp)
              ("M-<down>" . sp-down-sexp)
              ("M-<up>" . sp-up-sexp))
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
  :config (smooth-scrolling-mode 1))

;; Represent undo-history as an actual tree (visualize with C-x u)
(use-package undo-tree
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
(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1))

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
  (completion-category-overrides '((file (styles . (basic partial-completion flex initials)))))
  )

(use-package embark
  :disabled
  :config
  (global-set-key [remap describe-bindings] #'embark-bindings)
  (global-set-key (kbd "C-.") 'embark-act)
  (with-eval-after-load 'embark-consult
  (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))

  :ensure t)

(use-package embark-consult
  :disabled
  :after embark
  :ensure t
  :bind
  ("C-s" . consult-line)
  (:map minibuffer-local-map ("C-r" . 'consult-history)))

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
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
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
(add-hook 'org-mode-hook (lambda ()
                           (setq org-format-latex-options
                                 (plist-put org-format-latex-options :scale 1.7))))
(add-hook 'org-mode-hook 'buffer-face-mode)
(setq org-latex-create-formula-image-program 'dvisvgm)
(setq org-hide-leading-stars t)
(setq org-todo-keywords '((sequence "TODO" "PENDING" "|" "DONE")))
(require 'ox-md) ;; Markdown exporter

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
  :config
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'c++-ts-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'python-ts-mode-hook 'eglot-ensure))

;; Magit
(use-package magit
  :ensure t)

;; Yasnippets
(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode))
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package emacs
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
  :ensure t)

(require 'treesit)
(setq treesit-extra-load-path '("/Users/norman/Code/tree-sitter-module/dist"))
;; (add-to-list 'treesit-language-source-alist '(c "https://github.com/tree-sitter/tree-sitter-c"))
;; (add-to-list 'treesit-language-source-alist '(cpp "https://github.com/tree-sitter/tree-sitter-cpp"))

;; C/C++
(setq c-basic-offset 4)
(setq c-default-style "stroustrup")
(setq treesit-font-lock-level 4)
(add-hook 'c++-ts-mode-hook
          (lambda () (define-key
                      c++-ts-mode-map
                      (kbd "M-[")
                      (sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))))
(add-hook 'emacs-lisp-mode-hook
          (lambda () (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)))

;; (add-hook 'prog-mode-hook 'electric-pair-mode)
;; TODO: superflous w/ rainbow-delimiters?
;; (show-paren-mode 1)

(require 'sane-defaults)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
