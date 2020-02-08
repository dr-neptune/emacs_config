(require 'package)

(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(paredit
    ido-completing-read+
    smex
    rainbow-delimiters
    projectile))

; if not installed, install
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROG" "READING" 
              "DEPTH" "IMPLEMENT" "HOMEWORK" 
              "WAITING" "DONE")))

(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 
 'org-mode
 '(("^ *\\([-]\\) "
    (0 (prog1 () (compose-region (match-beginning 1)
                                 (match-end 1) "λ"))))))

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
   `(org-level-8 ((t (,@headline ,@variable-tuple :foreground "white"))))
   `(org-level-7 ((t (,@headline ,@variable-tuple :foreground "white"))))
   `(org-level-6 ((t (,@headline ,@variable-tuple :foreground "white"))))
   `(org-level-5 ((t (,@headline ,@variable-tuple :foreground "white"))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "white"))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "white"))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "white"))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.0 :weight bold :foreground "white"))))
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
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) 
                                           :weight bold :height 0.6))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent                ((t (:inherit (org-hide fixed-pitch))))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (shell . t)
   (scheme . t)))

(setq org-confirm-babel-evaluate nil)

(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-preserve-indentation t)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)

(require 'org-download)

(defun org-insert-screenshot () 
  "Insert a gnome screenshot snippet into org mode"
  (interactive)
  (org-download-screenshot))

(global-set-key (kbd "C-M-g") 'org-insert-screenshot)

;; deal with multiple buffers sharing names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; turn on recent file mode to easily switch to them when starting emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)

;; smart completion
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)
(ido-ubiquitous-mode t)
(ido-everywhere t)

;; show list of buffers 
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(projectile-global-mode)

(toggle-frame-fullscreen)

(menu-bar-mode -1)

(tool-bar-mode -1)

(global-linum-mode)
(pdf-tools-install)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")

(set-face-attribute 'default nil :height 120)

(setq
 ;; make killing yanking interact with clipboard
 x-select-enable-clipboard t
 x-select-enable-primary t
 save-interprogram-paste-before-kill t)

(blink-cursor-mode 0)

(global-visual-line-mode t)

;; full path in title bar
;; (setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
;; (global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)

(setq prettify-symbols-alist 
      '(
        ("lambda" . 955)
        ("<-" . 8668)
        ("->" . 8669)
        ("<<-" . 10557)
        ("%>%" . 8692)
        ("%<>%" . 10568)
        ("#+BEGIN_SRC" . 119070)
        ("#+END_SRC" . 119074)
        ("#+RESULTS:")
        ))


(when (boundp 'global-prettify-symbols-mode)
  ;; R 
  (add-hook 'ess-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)
              (push '("%>%" . 8620) prettify-symbols-alist)
              (push '("%<>%" . 8619) prettify-symbols-alist)
              (push '("<<-" . 10557) prettify-symbols-alist)))
  ;; Org 
  (add-hook 'org-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)
              (push '("%>%" . 8620) prettify-symbols-alist)
              (push '("%<>%" . 8619) prettify-symbols-alist)
              (push '("<<-" . 10557) prettify-symbols-alist)
              (push '("#+BEGIN_SRC" . 119070) prettify-symbols-alist)
              (push '("#+END_SRC" . 119074) prettify-symbols-alist)
              (push '("#+RESULTS:" . 8889) prettify-symbols-alist)))

  (global-prettify-symbols-mode +1))

(add-hook 'org-mode-hook #'rainbow-delimiters-mode)
(add-hook 'ess-mode-hook #'rainbow-delimiters-mode)

(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(show-paren-mode 1)

;; (global-hl-line-mode 1)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(setq-default indent-tabs-mode nil)

(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-z") 'undo)

(electric-pair-mode 1)

;; set pomodoro to on
(require 'pomodoro)
(pomodoro-add-to-mode-line)
;; set pomodoro key binding
(define-key global-map "\C-cp" 'pomodoro-start)
(define-key global-map "\C-co" 'pomodoro-stop)

(nyan-mode t)

(require 'poly-R)
(require 'poly-markdown)

;; recognize Rmd files
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(defun tws-insert-r-chunk ()
  (interactive) 
  (insert (concat "```{r" "}\n\n```")) 
  (forward-line -1))

(global-set-key (kbd "C-c i") 'tws-insert-r-chunk)

(defun tws-insert-function ()
  (interactive) 
  (insert (concat "f <- function(...) {\n\t\n}")) 
  (forward-line -1))

(global-set-key (kbd "C-c f") 'tws-insert-function)

(defun tws-insert-r-pipe ()
  (interactive) 
  (insert "%>% "))

(global-set-key (kbd "C-M-<SPC>") 'tws-insert-r-pipe)

(defun tws-insert-r-pipe-assign ()  
  (interactive) 
  (insert "%<>% "))

(global-set-key (kbd "C-c C-m") 'tws-insert-r-pipe-assign)

(defun tws-insert-r-assign () 
  (interactive) 
  (insert "<- "))

(global-set-key (kbd "C-c C-<SPC>") 'tws-insert-r-assign)

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
(global-set-key (kbd "<backtab>") 'company-complete)

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

(setq ess-smart-S-assign nil)

(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; scheme 
(defun tws-insert-scheme-chunk () 
  (interactive) 
  (insert (concat "#+BEGIN_SRC scheme" "\n\n#+END_SRC")) 
  (forward-line -1))

(global-set-key (kbd "C-c d") 'tws-insert-scheme-chunk)

(add-hook 'scheme-mode-hook 'geiser-mode)
(require 'scheme)
(setq geiser-active-implementations '(mit))

;; Automatically load paredit when editing a lisp file
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

(defun tws-insert-src-chunk ()
  (interactive) 
  (insert (concat "#+BEGIN_SRC sh" "\n\n#+END_SRC")) 
  (forward-line -1))

(global-set-key (kbd "C-c s") 'tws-insert-src-chunk)

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ronn?" . markdown-mode) auto-mode-alist))
