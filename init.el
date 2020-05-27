;; melpa

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows mand-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support ssl and be safe.
2. Remove this warning from your init file so you won't see it again."))

  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (package-refresh-contents))

(package-initialize)

;; font

(set-face-attribute 'default nil :family "Fira Code")
(set-face-attribute 'default nil :height 155)

;; cursor
(setq-default cursor-type 'hbar) 

;; zenburn

(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))

(load-theme 'zenburn t)

;; undo-tree

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(global-undo-tree-mode)

;; ivy

(unless (package-installed-p 'ivy)
  (package-install 'ivy))

(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d ")

;; smex

(unless (package-installed-p 'smex)
  (package-install 'smex))

(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; projectile

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)
(projectile-mode +1)

;; magit

(unless (package-installed-p 'magit)
  (package-install 'magit))

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;; exec-path-from-shell

(unless (package-installed-p 'exec-path-from-shell)
  (package-install 'exec-path-from-shell))

(exec-path-from-shell-initialize)

;; flycheck

(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))

(global-flycheck-mode)

;; company-mode

(unless (package-installed-p 'company)
  (package-install 'company))

(global-company-mode)
(setq company-idle-delay nil)
(global-set-key (kbd "M-TAB") #'company-complete)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

;; clojure-mode

(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode)
  (package-install 'clojure-mode-extra-font-locking))

(require 'clojure-mode-extra-font-locking)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)

;; cider

(unless (package-installed-p 'cider)
  (package-install 'cider))

(add-hook 'cider-repl-mode-hook #'subword-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'aggressive-indent-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(setq cider-repl-wrap-history t)
(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-save-file-on-load t)
(setq cider-font-lock-dynamically '(macro core function var))

;; clj-refactor

(unless (package-installed-p 'clj-refactor)
  (package-install 'clj-refactor))

(require 'clj-refactor)

(defun clj-ref-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1))

(add-hook 'clojure-mode-hook #'clj-ref-clojure-mode-hook)

;; flycheck-clj-kondo

(unless (package-installed-p 'flycheck-clj-kondo)
  (package-install 'flycheck-clj-kondo))

(require 'flycheck-clj-kondo)

;; which-key

(unless (package-installed-p 'which-key)
  (package-install 'which-key))

(which-key-mode)

;; editing

(show-paren-mode 1)
(global-hl-line-mode 1)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(setq-default indent-tabs-mode nil)

;; ui

(menu-bar-mode -1)
(global-linum-mode)
(scroll-bar-mode -1)
(setq-default frame-title-format "%b (%f)")
(setq ring-bell-function 'ignore)

;; misc

(fset 'yes-or-no-p 'y-or-n-p)
(setq create-lockfiles nil)

;; do not touch

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ivy-mode t)
 '(package-selected-packages
   (quote
    (company company-mode undo-tree flycheck-clj-kondo clojure-mode-extra-font-locking clojure-mode flycheck exec-path-from-shell magit projectile smex ivy aggressive-indent smartparens rainbow-delimiters zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; User customizations
;; Add your customizations to `init-user.el`
(when (file-exists-p "~/.emacs.d/init-user.el")
  (setq user-custom-file "~/.emacs.d/init-user.el")
  (load user-custom-file))
