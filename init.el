;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-completing-read+

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")
(add-to-list 'load-path "~/.emacs.d/elpa")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#000000"))
 '(coffee-tab-width 2)
 '(custom-enabled-themes (quote (doom-dracula)))
 '(custom-safe-themes
   (quote
    ("b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "356e5cbe0874b444263f3e1f9fffd4ae4c82c1b07fe085ba26e2a6d332db34dd" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(fci-rule-color "#2a2a2a")
 '(org-agenda-files (quote ("~/Desktop/exp/org/intro_org.org")))
 '(package-selected-packages
   (quote
    (org-download org-attach-screenshot dbus-codegen load-dir org-notebook auto-org-md gh-md ox-gfm org-pdfview pdf-tools htmlize babel prettify-greek ample-theme doom-themes material-theme color-theme-sanityinc-tomorrow pretty-mode pretty-symbols sudo-edit company-math drag-stuff move-text org-bullets magit-annex ess-smart-equals yasnippet alarm-clock nyan-mode org-pomodoro gtk-pomodoro-indicator company ess-view auto-auto-indent pandoc auctex poly-R poly-markdown poly-org auto-complete ess ess-R-data-view ess-smart-underscore org org-ref dracula-theme ## magit tagedit rainbow-delimiters projectile smex ido-completing-read+ cider clojure-mode-extra-font-locking clojure-mode paredit exec-path-from-shell))))

;;; Markdown mode
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ronn?" . markdown-mode) auto-mode-alist))

;; ;;; Polymode
;; (setq load-path (append '("/home/sbonner/.emacs.d/polymode/" "/home/sbonner/.emacs.d/polymode/modes") load-path))

(require 'poly-R)
(require 'poly-markdown)

(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;;;Insert new chunk for Rmarkdown
(defun tws-insert-r-chunk () 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive) 
  (insert (concat "```{r" "}\n\n```")) 
  (forward-line -1))

(global-set-key (kbd "C-c i") 'tws-insert-r-chunk)

;;;Insert new function in R
(defun tws-insert-function ()
  (interactive) 
  (insert (concat "f <- function(...) {\n\t\n}")) 
  (forward-line -1))

(global-set-key (kbd "C-c f") 'tws-insert-function)


;;;Insert pipe operator for Rmarkdown
(defun tws-insert-r-pipe () 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive) 
  (insert "%>% "))

(global-set-key (kbd "C-M-<SPC>") 'tws-insert-r-pipe)

;;;Insert pipe assignment operator
(defun tws-insert-r-pipe-assign () 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive) 
  (insert "%<>% "))

(global-set-key (kbd "C-c C-m") 'tws-insert-r-pipe-assign)

;;;Insert assignment operator for Rmarkdown
(defun tws-insert-r-assign () 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive) 
  (insert "<- "))

(global-set-key (kbd "C-c C-<SPC>") 'tws-insert-r-assign)


;; change undo from C-x u to C-z
(global-set-key (kbd "C-z") 'undo)

;; auto complete

;; (defun my-auto-hook ()
;;   (auto-complete-mode 1)
;;   ;; colors
;;   (set-face-attribute 'popup-tip-face nil :background "#bfbaac" :foreground "black")
;;   (define-key ac-completing-map [return] nil)
;;   (define-key ac-completing-map "\r" nil))

;; (add-hook 'ess-mode-hook 'my-auto-hook)
;; (add-hook 'inferior-ess-mode-hook 'my-auto-hook)

;; (ac-config-default)
;; (setq ess-use-auto-complete t)

;; company autocomplete
(require 'company)
(setq tab-always-indent 'complete)
(setq company-idle-delay 0.5
      company-show-numbers t
      company-minimum-prefix-length 2
      company-tooltip-flip-when-above t)

(global-company-mode)
(add-hook 'after-init-hook 'global-company-mode)

(define-key company-active-map [return] nil)
(define-key company-active-map [tab] 'company-complete-common)
;;(define-key company-active-map (kbd "TAB") 'company-complete)
;; (define-key company-active-map (kbd "C-tab") 'company-complete-selection)
(global-set-key (kbd "<backtab>") 'company-complete)

;;; ESS
(defun my-ess-hook ()
  ;; ensure company-R-library is in ESS backends
  (make-local-variable 'company-backends)
  (cl-delete-if (lambda (x) (and (eq (car-safe x) 'company-R-args))) company-backends)
  (push (list 'company-R-args 'company-R-objects 'company-R-library :separate)
        company-backends))

(add-hook 'ess-mode-hook 'my-ess-hook)

(with-eval-after-load 'ess
  (setq ess-use-company t))

(add-hook 'ess-mode-hook
          (lambda () 
            (ess-toggle-underscore nil)))

;; add auto completion of parentheses, quotes, brackets, etc
(electric-pair-mode 1)

;; set global word wrap
(global-visual-line-mode t)

;; set up org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; set TODO workflow for org mode
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROG" "READING" "DEPTH" "IMPLEMENT" "HOMEWORK" "WAITING" "DONE")))

(setq org-tag-alist '(("@DEPTH" . ?d) ("@READING" . ?r) ("IMPLEMENTATION" . ?i) ("HOMEWORK" . ?h)))

;; set pomodoro to on
(require 'pomodoro)
(pomodoro-add-to-mode-line)
;; set pomodoro key binding
(define-key global-map "\C-cp" 'pomodoro-start)
(define-key global-map "\C-co" 'pomodoro-stop)

;; set confirm run code block to auto run
(setq org-confirm-babel-evaluate nil)

;; nyan-mode
(nyan-mode t)

;; org mode beautify
(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "λ"))))))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(let* ((variable-tuple
        (cond ((x-list-fonts "Hack") '(:font "Hack"))
              ((x-list-fonts "Hack")   '(:font "Hack"))
              ((x-list-fonts "Hack")         '(:font "Hack"))
              ((x-family-fonts "Hack")    '(:family "Hack"))
              (nil (warn "ya done set everything to Hack."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight normal :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.0))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.0))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.0 :weight bold))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 1.025 :underline nil :foreground "MediumSpringGreen"))))))

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Hack" :height 180 :weight light))))
 '(fixed-pitch ((t ( :family "Hack" :slant normal :weight normal :height 1.0 :width normal)))))

(add-hook 'org-mode-hook 'variable-pitch-mode)

(add-hook 'org-mode-hook 'visual-line-mode)

(custom-theme-set-faces
 'user
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info         ((t (:foreground "MediumPurple1"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-link                  ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.6))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent                ((t (:inherit (org-hide fixed-pitch))))))


;; emacs hide toolbar 
(tool-bar-mode -1)

;; prettify symbols 
(global-prettify-symbols-mode +1)

(setq prettify-symbols-alist 
      '(
        ("lambda" . 955)
        ("<-" . 8668)
        ("->" . 8669)
        ("<<-" . 10557)
        ("%>%" . 8692)
        ("%<>%" . 10568)
        ))

(setq ess-smart-S-assign nil)

;;(require 'pretty-mode)
;;(global-pretty-mode t)

;; prettify R operators 
(when (boundp 'global-prettify-symbols-mode)
  (add-hook 'ess-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)
              (push '("%>%" . 8620) prettify-symbols-alist)
              (push '("%<>%" . 8619) prettify-symbols-alist)
              (push '("<<-" . 10557) prettify-symbols-alist)))
  (global-prettify-symbols-mode +1))

;; rainbow delimiters mode 
;; (add-hook 'org-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ess-mode-hook #'rainbow-delimiters-mode)

;; disable flycheck 
(flymake-mode -1)
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Hack" :slant normal :weight normal :height 1.0 :width normal))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-info ((t (:foreground "MediumPurple1"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack" :height 1.025 :underline nil :foreground "MediumSpringGreen"))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack" :height 1.0 :weight bold))))
 '(org-level-2 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack" :height 1.0))))
 '(org-level-3 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack" :height 1.0))))
 '(org-level-4 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack" :height 1.0))))
 '(org-level-5 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack"))))
 '(org-level-6 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack"))))
 '(org-level-7 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack"))))
 '(org-level-8 ((t (:inherit default :weight normal :foreground "#f8f8f2" :font "Hack"))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.6))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "Hack" :height 180 :weight light)))))

;; Org Babel for R
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (shell . t)))

;; inline images
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)

;; insert src chunk
(defun tws-insert-src-chunk () 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive) 
  (insert (concat "#+BEGIN_SRC sh" "\n\n#+END_SRC")) 
  (forward-line -1))

(global-set-key (kbd "C-c s") 'tws-insert-src-chunk)

;; toggle full screen mode 
(toggle-frame-fullscreen)

;; org screenshot
(require 'org-download)

(defun org-insert-screenshot () 
  "Insert a gnome screenshot snippet into org mode"
  (interactive)
  (org-download-screenshot))

(global-set-key (kbd "C-M-g") 'org-insert-screenshot)
