;; Setup package sources.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'.
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
(add-to-list 'default-frame-alist '(height . 32))
(add-to-list 'default-frame-alist '(width . 90))

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
   (quote
	(rustic lsp-ui autopair cargo rust-playground toml-mode company magit use-package typescript-mode racer python-mode markdown-mode htmlize go-mode flycheck-rust exec-path-from-shell auto-complete))))

;; Setup font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 102 :width normal)))))

;; Features for all programming modes.
(defun all-code-hooks ()
  ;; Max line length.
  (turn-on-auto-fill)
  ;; Add matching paren/bracket automatically.
  (autopair-mode)
  ;; Draw line at max line length.
  (fci-mode 1))

;; Register the mode hook.
(add-hook 'go-mode-hook 'all-code-hooks)
(add-hook 'python-mode-hook 'all-code-hooks)
(add-hook 'rust-mode-hook 'all-code-hooks)

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; Rust config
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
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
