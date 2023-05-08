;; Increase the gc threshold for faster startup (in bytes)
(setq gc-cons-threshold (* 20 1024 1024))

;; Prefer loading newest compiled Emacs lisp file
(customize-set-variable 'load-prefer-newer noninteractive)

;; Native compilation settings
(when (featurep 'native-compile)
  ;; Silence compiler warnings
  (setq native-comp-async-report-warnings-errors nil)

  ;; Set the directory for storing native compilation cache
  (when (fboundp 'startup-redirect-eln-cache)
    (startup-redirect-eln-cache (convert-standard-filename
                                (expand-file-name "~/.cache/emacs/eln-cache/"))))
  (add-to-list 'native-comp-eln-load-path
               (expand-file-name "~/.cache/emacs/eln-cache/")))

;; Set up UI
(setq default-frame-alist '((height . 55)
                            (width . 116)
                            ;; (width . 232)
                            ;; (background-mode . dark)
                            (background-mode . light)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)))
