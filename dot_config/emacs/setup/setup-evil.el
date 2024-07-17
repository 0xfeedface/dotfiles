(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-disable-insert-state-bindings t
        evil-want-C-i-jump nil
        evil-want-C-u-delete nil
        evil-want-C-u-scroll nil
        evil-want-C-d-scroll t
        evil-want-C-w-delete t
        evil-want-C-w-in-emacs-state nil
        evil-want-Y-yank-to-eol t
        evil-want-fine-undo t
        evil-undo-system 'undo-redo
        evil-emacs-state-cursor 'bar)
  :bind (:map evil-normal-state-map (("U" . 'evil-redo)
                                     ("gq" . 'eglot-format)
                                     ("gQ" . 'eglot-format-buffer)
                                     ("gr" . 'eglot-find-references)
                                     ("gl" . 'eglot-inlay-hints-mode)
                                     ("gs" . 'subword-mode)))
  :custom
  (evil-overriding-maps '())
  ;; (evil-mode-line-format nil)
  :config
  (evil-global-set-key 'motion "/" nil)
  (evil-global-set-key 'motion "?" nil)
  (evil-global-set-key 'motion "j" nil)
  (evil-global-set-key 'motion "h" nil)
  (evil-global-set-key 'normal "q" nil)
  (evil-global-set-key 'normal "m" nil)
  (evil-global-set-key 'normal "e" nil)
  (evil-global-set-key 'normal "i" nil)
  (evil-global-set-key 'visual "i" nil)
  (evil-global-set-key 'normal (kbd "C-r") nil)
  (evil-global-set-key 'normal (kbd "C-.") nil)
  (evil-global-set-key 'normal (kbd "M-.") nil)
  (evil-global-set-key 'motion "m" 'evil-backward-char)
  (evil-global-set-key 'motion "n" 'evil-next-line)
  (evil-global-set-key 'motion "e" 'evil-previous-line)
  (evil-global-set-key 'motion "i" 'evil-forward-char)
  (evil-global-set-key 'normal "l" 'evil-insert)
  (evil-global-set-key 'normal "j" 'er/expand-region)
  (evil-global-set-key 'normal "k" 'avy-goto-char-timer)
  (evil-global-set-key 'normal "h" 'evil-forward-word-end)
  (evil-global-set-key 'normal "H" 'evil-forward-WORD-end)
  (evil-global-set-key 'visual "i" 'evil-forward-char)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-select-search-module 'evil-search-module 'isearch)
  (evil-mode 1))

(use-package evil-snipe
  :ensure t
  :after evil
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

(use-package evil-collection
  :disabled
  :after evil
  :ensure t
  :custom
  (evil-collection-magit-state 'emacs)
  (evil-collection-state-denylist '(emacs))
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
  (evil-global-set-key 'normal "gc" 'evilnc-comment-or-uncomment-lines))

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(provide 'setup-evil)
