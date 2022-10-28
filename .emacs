;; Setup package sources.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Word wrap
(global-visual-line-mode 1)

;; Always show line number
;; (global-linum-mode 1)

;; Personal information
(setq user-full-name "tiennv"
      user-mail-address "tien.nv291997@gmail.com")

;; Turn on bracket match highlight
(show-paren-mode 1)

;; Auto insert closing bracket
(electric-pair-mode 1)

;; Turn off make backup file
(setq make-backup-files nil)

(setq create-lockfiles nil)

;; Tab width
(setq-default tab-width 4)

;; Hide scrollbar
(scroll-bar-mode -1)

;; Hide toolbar
(tool-bar-mode -1)

;; Load theme
(load-theme 'tango-dark-jeff t)

;; Disable sound
(setq ring-bell-function 'ignore)

;; Window size
(add-to-list 'default-frame-alist '(height . 33))
(add-to-list 'default-frame-alist '(width . 97))

;; Highlight matching parens with no delay.
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Highlight current line.
;; (global-hl-line-mode +1)

;; Hide startup screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(go-mode cargo flycheck-rust yaml-mode protobuf-mode dockerfile-mode docker autopair toml-mode yasnippet lsp-ui company lsp-mode orderless marginalia vertico consult selectrum which-key flycheck use-package)))
;; Setup font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 109 :width normal)))))

(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
;; Highlight entire line for errors.
(set-face-attribute 'flycheck-error nil :background "red")
(set-face-attribute 'flycheck-error nil :foreground "white")

(use-package which-key
  :ensure
  :init
  (which-key-mode))

(use-package selectrum
  :ensure
  :init
  (selectrum-mode)
  :custom
  (completion-styles '(flex substring partial-completion)))

(use-package consult
  :ensure t)

;; (use-package evil
;;   :ensure t
;;   :config
;;   (evil-mode)
;;   (evil-set-undo-system 'undo-redo))

(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; This controls the overlays that display type and other hints inline. Enable
  ;; / disable as you prefer. Well require a `lsp-workspace-restart' to have an
  ;; effect on open projects.
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(use-package toml-mode
  :ensure t)

(use-package protobuf-mode
  :ensure t)

(use-package docker
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package flycheck-rust
  :ensure t)

(use-package cargo
  :ensure t
	:init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

(use-package rust-mode
  :ensure t)

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


;; Go
(use-package go-mode
  :ensure t)
