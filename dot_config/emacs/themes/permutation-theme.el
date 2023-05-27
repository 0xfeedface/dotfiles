(deftheme permutation)
(custom-theme-set-faces
 'permutation
 '(default ((t (:foreground "#111111" :background "#f8f8f8"))))
 '(font-lock-comment-face ((t (:foreground "#909090"))))
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
 '(org-block ((t (:font "Iosevka Custom Fixed Slab"))))
 )
(provide-theme 'permutation)
