(require 'org)
(org-babel-load-file
 (expand-file-name "initialization.org"
                   user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (doom-vibrant)))
 '(custom-safe-themes
   (quote
    ("1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" default)))
 '(package-selected-packages
   (quote
    (w3m w3 poly-org sesman clojure-mode slime highlight-symbol company company-racer flycheck flycheck-rust ob-rust racer rust-mode org-ac use-package tagedit smex scheme-complete rainbow-delimiters projectile pretty-symbols pretty-mode prettify-greek pomodoro poly-R paredit ox-gfm org-pdfview org-notebook org-download org-bullets org-attach-screenshot nyan-mode material-theme magit load-dir immaterial-theme ido-completing-read+ htmlize gh-md geiser exec-path-from-shell ess elpy doom-themes dbus-codegen clojure-mode-extra-font-locking cider blacken babel auto-org-md))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Hack" :slant normal :weight normal :height 1.0 :width normal))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-info ((t (:foreground "MediumPurple1"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight normal :foreground "black" :font "Hack" :height 1.025 :underline nil :foreground "MediumSpringGreen"))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :height 1.0 :weight bold :foreground "white"))))
 '(org-level-2 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :height 1.0 :foreground "white"))))
 '(org-level-3 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :height 1.0 :foreground "white"))))
 '(org-level-4 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :height 1.0 :foreground "white"))))
 '(org-level-5 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :foreground "white"))))
 '(org-level-6 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :foreground "white"))))
 '(org-level-7 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :foreground "white"))))
 '(org-level-8 ((t (:inherit default :weight normal :foreground "black" :font "Hack" :foreground "white"))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.6))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "Hack" :height 180 :weight light)))))
