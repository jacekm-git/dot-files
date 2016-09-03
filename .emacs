;; Outline keys
(define-key emacs-lisp-mode-map (kbd "C-c C-s") 'show-subtree)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'hide-subtree)
(define-key emacs-lisp-mode-map (kbd "C-c C-t") 'hide-body)
(define-key emacs-lisp-mode-map (kbd "C-c C-a") 'show-all)
;; Outline mode settings*
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
	    (make-local-variable 'outline-regexp)
	    (setq outline-regexp "^;; ")
	    (make-local-variable 'outline-heading-end-regexp)
	    (setq outline-heading-end-regexp "*\n")
	    (outline-minor-mode 1)
	    (hide-body)
	    ))
;; Packages*
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))
; PACKAGE REPOS
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
; PACKAGES TO INSTALL
(require-package 'evil)
(require-package 'undo-tree)
(require-package 'goto-last-change)
(require-package 'haskell-mode)
(require-package 'linum-relative)
(require-package 'linum-off)
(require-package 'auto-complete)
(require-package 'atom-dark-theme)
;; GUI*
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t initial-scratch-message nil)
(setq column-number-mode t)
;; INDENTING*
(setq tab-width 4 indent-tabs-mode nil)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
;; BACKUP FILES*
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".;" "~/.emacs.d/auto-save-list/" t)))
;; HIGHLIGHT PARENTHESIS*
(show-paren-mode t)
;; IDO MODE*
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)
;; RECENT FILES*
(recentf-mode 1)
(global-set-key (kbd "<f7>") 'recentf-open-files)
;; IDO MODE FIX CREATING FILES*
(setq ido-auto-merge-work-directories-length -1)
;; HIGHLIGHT 80 LINE*
(defun highlight-80 ()
  (highlight-lines-matching-regexp ".\\{81\\}" 'hi-yellow))
(add-hook 'haskell-mode-hook 'highlight-80)
(add-hook 'python-mode-hook 'highlight-80)
;; RELATIVE-LINE-NUMBERS*
(require 'linum-off)
(require 'linum-relative)
(global-linum-mode)
(linum-relative-global-mode t)
(setq linum-relative-format "%2s ")
(add-hook 'term-mode-hook 'linum-on)
;; EVIL MODE*
(require 'evil)
(evil-mode 1)
; COLORS 
(require 'cl);;;;
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#751919" . "#ffffff"))
                                 ((evil-emacs-state-p)  default-color)
                                 ((evil-visual-state-p) '("#CC6600" . "#ffffff"))
                                 ((buffer-modified-p)   '("#006666" . "#ffffff"))
                                 (t '("#303030" . "#ffffff")))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))))))

; CUSTOM BINDINGS
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-normal-state-map "\C-a" 'evil-beginning-of-line)
(define-key evil-insert-state-map "\C-a" 'beginning-of-line)
(define-key evil-visual-state-map "\C-a" 'evil-beginning-of-line)
(define-key evil-motion-state-map "\C-a" 'evil-beginning-of-line)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
;; COLOR-THEME*
;; x-clip*
;enable x clipboard
(xclip-mode 1)
;; AUTO COMPLETE*
(require 'auto-complete)
(ac-config-default)
(global-auto-complete-mode t)
;; HASKELL MODE*
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'auto-complete-mode)
(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
(eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'interactive-haskell-mode))
;; org-mode*
; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
;; Android mode*
(require 'android-mode)
(custom-set-variables '(android-mode-sdk-dir "~/android_sdk/"))
;; Auto generated*
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (atom-dark)))
 '(custom-safe-themes
   (quote
    ("a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

