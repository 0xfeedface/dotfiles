(deftheme default-dark)

(custom-theme-set-faces
 'default-dark
 '(default ((t (:inherit nil :stipple nil :background "#111111" :foreground "#eeeeee" :inverse-video nil :box nil :strike-t*hrough nil :overline nil :underline nil :slant normal :weight normal :width normal))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "#333333"))))
 '(region ((nil (:background "#464740"))))
 '(hl-line ((nil (:background "#444444"))))
 '(yas-field-highlight-face ((nil (:background "#333399"))))
 '(font-lock-warning-face ((nil (:foreground "#ff6666"))))
 '(show-paren-match ((nil (:background "#333399"))))
 '(show-paren-mismatch ((((class color)) (:background "red")))))

(provide-theme 'default-dark)
