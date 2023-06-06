(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-i-jump nil
        evil-want-C-u-delete nil
        evil-want-C-u-scroll nil
        evil-want-C-d-scroll t
        evil-want-C-w-delete t
        evil-want-C-w-in-emacs-state nil
        evil-want-Y-yank-to-eol t
        evil-disable-insert-state-bindings t
        evil-want-fine-undo t
        evil-undo-system 'undo-tree)
  :bind (:map evil-normal-state-map (("U" . 'evil-redo)
                                     ("gq" . 'eglot-format)
                                     ("gQ" . 'eglot-format-buffer)
                                     ("gr" . 'eglot-find-references)
                                     ("gl" . 'eglot-inlay-hints-mode)))
  :custom
  (evil-overriding-maps '())
  :config
  (evil-select-search-module 'evil-search-module 'isearch)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :custom
  (evil-collection-magit-state 'emacs)
  :config
  (evil-collection-init))

(use-package evil-textobj-tree-sitter
  :disabled
  :vc (evil-textobj-tree-sitter :url "https://github.com/meain/evil-textobj-tree-sitter"
                                :branch "treesit"
                                :lisp-dir "queries"
                                :lisp-dir "treesit-queries")
  :config
  (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
  (define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer")))

(use-package evil-nerd-commenter
  :after evil
  :ensure t
  :config
  (evilnc-default-hotkeys nil nil))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(provide 'setup-evil)
