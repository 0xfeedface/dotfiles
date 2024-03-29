(require 'autothemer)

(autothemer-deftheme
 solarized "Solarized"

 ((((class color) (min-colors #xffffff)))

  ;; Define Solarized colors
(solarized-base03 "#002b36")
(solarized-base02 "#073642")
(solarized-base01 "#657b83")
(solarized-base00 "#71888f")
(solarized-base0 "#90a1a3")
(solarized-base1 "#a0aeae")
(solarized-base2 "#fdf6e3")
(solarized-base3 "#fffff1")
(solarized-yellow "#c39616")
(solarized-orange "#db5923")
(solarized-red "#ec433b")
(solarized-magenta "#e2468f")
(solarized-violet "#797dd2")
(solarized-blue "#3b98e0")
(solarized-cyan "#3cafa5")
(solarized-green "#93a707")
)

 ((default                       (:foreground solarized-base0 :background solarized-base03))
  (cursor                        (:foreground solarized-base02 :background solarized-base1))
  (mode-line                     (:foreground solarized-base03 :background solarized-base0))
  (mode-line-inactive            (:foreground solarized-base02 :background solarized-base1))
  (fringe                        (:foreground solarized-base0 :background solarized-base02))
  (highlight                     (:foreground solarized-base03 :background solarized-base01))
  (hl-line                       (:foreground nil :background solarized-base02))
  (region                        (:background solarized-base01 :distant-foreground nil))
  (minibuffer-prompt             (:foreground solarized-base1))
  (link                          (:foreground solarized-blue))
  (line-number                   (:foreground solarized-base01))
  (line-number-current-line      (:foreground solarized-base1))

  (error   (:foreground solarized-red))
  (success (:foreground solarized-green))
  (warning (:foreground solarized-yellow))

  (match (:background solarized-violet))
  (shadow (:foreground solarized-base01))

  ;; (completions-highlight (:background solarized-base01 :distant-foreground solarized-base2))
  (completions-highlight (:foreground solarized-orange))
  (completions-common-part (:foreground solarized-cyan))
  (completions-first-difference (:foreground solarized-magenta))
  (completions-annotations (:inherit  ('italic 'shadow)))
  (completions-group-title (:slant 'italic :inherit 'shadow))
  (completions-group-separator (:strike-through t :inherit 'shadow))

  ;; Isearch
  (isearch (:foreground solarized-base03 :background solarized-magenta))
  (isearch-fail (:foreground solarized-base02 :background solarized-red))
  (lazy-highlight (:foreground nil :background solarized-base01 :distant-foreground solarized-base03))
  (isearch-group-1 (:foreground solarized-green :background solarized-magenta))
  (isearch-group-2 (:foreground solarized-cyan :background solarized-magenta))

  ;; Font-lock
  (font-lock-keyword-face        (:foreground solarized-magenta))
  (font-lock-constant-face       (:foreground solarized-violet))
  (font-lock-string-face         (:foreground solarized-green))
  (font-lock-comment-face        (:foreground solarized-base01))
  (font-lock-comment-delimiter-face (:inherit font-lock-comment-face))
  (font-lock-builtin-face        (:foreground solarized-cyan))
  (font-lock-preprocessor-face   (:foreground solarized-yellow))
  (font-lock-type-face           (:foreground solarized-blue))
  (font-lock-function-name-face  (:foreground solarized-cyan))
  (font-lock-variable-name-face  (:foreground solarized-cyan))
  (font-lock-doc-face ())
  (font-lock-escape-face ())
  (font-lock-number-face ())
  (font-lock-regexp-face ())
  (font-lock-bracket-face ())
  (font-lock-warning-face ())
  (font-lock-constant-face ())
  (font-lock-operator-face (:foreground solarized-magenta))
  (font-lock-delimiter-face ())
  (font-lock-doc-markup-face ())
  (font-lock-punctuation-face ())
  (font-lock-property-use-face ())
  (font-lock-variable-use-face ())
  (font-lock-function-call-face ())
  (font-lock-function-name-face ())
  (font-lock-negation-char-face (:foreground solarized-magenta))
  (font-lock-property-name-face ())
  (font-lock-misc-punctuation-face ())
  (font-lock-regexp-grouping-backslash ())
  (font-lock-regexp-grouping-construct ())

  ;; Dired
  (dired-directory (:inherit 'font-lock-type-face))
  (dired-symlink (:inherit 'font-lock-keyword-face))
  (dired-broken-symlink (:foreground solarized-base03 :background solarized-magenta))
  (dired-special (:foreground solarized-yellow))
  (dired-warning (:inherit 'font-lock-warning-face))
  (dired-flagged (:inherit 'error))
  (dired-perm-write (:foreground solarized-green))
  (dired-ignored (:inherit 'font-lock-comment-face))
  (dired-marked (:foreground solarized-base03 :background solarized-violet))
  (dired-mark (:foreground solarized-violet))
  (dired-header (:foreground solarized-base03 :background solarized-base0))
  (dired-set-id (:foreground solarized-red))

  ;; Vertico
  (vertico-current (:extend t :background solarized-base01 :distant-foreground solarized-base2))
  (vertico-multiline (:inherit 'shadow))
  (vertico-group-title (:slant 'italic :inherit 'shadow))
  (vertico-group-separator (:strike-through t :inherit 'shadow))

  (tree-sitter-hl-face:type.builtin         (:foreground solarized-blue))
  (tree-sitter-hl-face:property.definition  (:foreground solarized-base0 :slant 'normal))
  (tree-sitter-hl-face:method.call          (:foreground solarized-base0 :slant 'normal))
  (tree-sitter-hl-face:function.call        (:foreground solarized-base0 :slant 'normal))
  (tree-sitter-hl-face:property             (:foreground solarized-base0 :slant 'normal))
  (tree-sitter-hl-face:variable             (:foreground solarized-base0 :slant 'normal))
  (tree-sitter-hl-face:function             (:foreground solarized-base0 :slant 'normal))

  ;; (tree-sitter-hl-face:punctuation.bracket  (:foreground solarized-base02 :slant 'normal))
  (tree-sitter-hl-face:punctuation.delimiter  (:foreground solarized-magenta :slant 'normal))

  (whitespace-space    (:foreground solarized-base02 :background nil))
  (whitespace-hspace   (:foreground solarized-base02 :background nil))
  (whitespace-tab      (:foreground solarized-base02 :background nil))
  (whitespace-newline  (:foreground solarized-base02 :background nil))
  (whitespace-trailing  (:foreground solarized-base02 :background solarized-red))
  (whitespace-line  (:foreground nil :background nil))
  (Whitespace-space-before-tab  (:foreground solarized-base02 :background nil))
  (whitespace-indentation  (:foreground solarized-base02 :background nil))
  (whitespace-empty  (:foreground nil :background nil))
  (whitespace-space-after-tab  (:foreground solarized-base02 :background nil))

  (flymake-error (:foreground nil :background nil))
  (flymake-warning (:foreground nil :background nil))
  (flymake-note (:foreground nil :background nil))

  (eglot-type-hint-face (:inherit font-lock-comment-face :height 150))
  (eglot-inlay-hint-face (:inherit font-lock-comment-face :height 150))
  (eglot-parameter-hint-face (:inherit font-lock-comment-face :height 150))
  (eglot-highlight-symbol-face (:foreground nil :background nil))
  (eglot-diagnostic-tag-deprecated-face (:foreground nil :background nil))
  (eglot-diagnostic-tag-unnecessary-face (:foreground nil :background nil))

  ;; (magit-section-highlight (:foreground nil :background solarized-base02))
  ;; (magit-branch-local (:foreground solarized-blue))
  ;; (magit-branch-current (:inherit 'magit-branch-local :box 1))
  ;; (magit-branch-remote (:foreground solarized-magenta))
  ;; (magit-branch-remote-head (:inherit 'magit-branch-remote :box 1))
  ;; (magit-tag (:foreground solarized-yellow))
  ;; (magit-section-heading (:inherit 'magit-tag))
  ;; (magit-hash (:inherit font-lock-comment-face))
  ;; (magit-log-author (:inherit 'default))
  ;; (magit-log-date (:inherit 'default))
  ;; (magit-diff-added (:foreground solarized-green))
  ;; (magit-diff-added-highlight (:foreground solarized-base03 :background solarized-green))
  ;; (magit-diff-removed (:foreground solarized-red))
  ;; (magit-diff-removed-highlight (:foreground solarized-base03 :background solarized-red))
  ;; (magit-diff-context ())
  ;; (magit-diff-context-highlight (:foreground solarized-base03 :background solarized-base01))
  ;; (magit-diffstat-added (:inherit 'magit-diff-added))
  ;; (magit-diffstat-removed (:inherit 'magit-diff-removed))

  ))

(provide-theme 'solarized)
