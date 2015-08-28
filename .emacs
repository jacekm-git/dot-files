;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; PACKAGES MANAGMENT SETTINGS ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;; CHECK AND AUTO INSTALL PACKAGE
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
;;;;;;; PACKAGE REPOS 
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(package-initialize)
;;;;;;; PACKAGES TO INSTALL
(require-package 'evil)
(require-package 'haskell-mode)
(require-package 'linum-relative)
(require-package 'key-chord)
(require-package 'color-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; EMACS SETTINGS ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GUI
(menu-bar-mode -1)
(tool-bar-mode 1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t
      initial-scratch-message nil)
(setq column-number-mode t)
;; INDENDING
(setq tab-width 2
      indent-tabs-mode nil)
;; BACKUP FILES
(setq make-backup-files nil)
;; HIGHLIGHT PARENTHESIS
(show-paren-mode t)
;; IDO MODE
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)
;; COLOR SHELL
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; RECENT FILES
(recentf-mode 1)
(global-set-key (kbd "<f7>") 'recentf-open-files)
;; IDO MODE FIX CREATING FILES
(setq ido-auto-merge-work-directories-length -1)
;;; HIGHLIGHT 80 LINE
(defun highlight-80 ()
  (highlight-lines-matching-regexp ".\\{81\\}" 'hi-yellow))
(add-hook 'haskell-mode-hook 'highlight-80)
(add-hook 'python-mode-hook 'highlight-80)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; MODES SETTINGS ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; RELATIVE-LINE-NUMBERS
(require 'linum-relative)
(global-linum-mode)
(add-hook 'after-init-hool #'linum-relative-toggle)
(setq linum-relative-format "%2s ")

;;;; HASKELL MODE
(setq haskell-font-lock-symbols t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;;; EVIL MODE
;; ENABLE EVIL MODE
(require 'evil)
(evil-mode 1)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'dired-mode 'emacs)
;; COLOR MODES
(require 'cl)
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((minibufferp) default-color)
                                 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                 ((evil-emacs-state-p)  '("#666333" . "#ffffff"))
                                 ((evil-visual-state-p)   '("#CC6600" . "#ffffff"))
                                 ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                                 (t '("#003300" . "#ffffff")))))
                (set-face-background 'mode-line (car color))
                (set-face-foreground 'mode-line (cdr color))
                (set-face-attribute 'linum nil :background (car color))
                (set-face-attribute 'linum nil :foreground (cdr color))
		))))

  ;; CUSTOM BINDINGS 
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
  (require 'key-chord)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;;;; COLOR-THEME
(require 'color-theme)
(color-theme-initialize)
(color-theme-calm-forest)
