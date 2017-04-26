;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package material-theme
  :ensure t)

(use-package linum-relative
  :ensure t)
(setq linum-relative-current-symbol "")

(use-package evil
  :ensure t)
(require 'evil)
(evil-mode t)

(use-package helm
  :ensure t)
(require 'helm-config)

(use-package org
  :ensure t)
(require 'org)

(use-package elpy
  :ensure t)
(elpy-enable)

(use-package company-quickhelp
  :ensure t)
(company-quickhelp-mode 1)

(use-package flycheck
  :ensure t)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(use-package py-autopep8
  :ensure t)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(use-package pyenv-mode
  :ensure t)
(pyenv-mode)

;; BASIC CONFIGURATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(tool-bar-mode -1)


;; PYTHON CONFIGURATION
;; --------------------------------------
;;(add-hook 'python-mode-hook
 ;;         (lambda () (add-hook 'before-save-hook elpy-yapf-fix-code nil 'local)))

;; ELPY CONFIGURATION
;; --------------------------------------
(setq elpy-rpc-python-command "python3")
(elpy-use-ipython "ipython3")
(setq python-shell-interpreter "ipython3" python-shell-interpreter-args "--simple-prompt --pprint")

;; ELPY company-yasnippet confilcts
;; (defun company-yasnippet-or-completion ()
;;   "Solve company yasnippet conflicts."
;;   (interactive)
;;   (let ((yas-fallback-behavior
;;          (apply 'company-complete-common nil)))
;;     (yas-expand)))

;;(add-hook 'company-mode-hook 
;;          (lambda ()
;;           (substitute-key-definition
;;             'company-complete-common
;;            'company-yasnippet-or-completion
;;             company-active-map)))

;; HELM CONFIGURATION
;; --------------------------------------
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

