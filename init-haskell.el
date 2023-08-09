(unless (featurep 'haskell)
  (use-package haskell-mode
    :ensure t))

(use-package haskell-mode
  :init (progn
          (require 'haskell)
          (require 'lsp)
          (require 'flyspell)
          (require 'lsp-ui)
          (require 'which-key)
          (defun my-haskell-mode-hook ()
            (add-hook 'before-save-hook 'haskell-align-imports nil t)
            (add-hook 'after-save-hook 'haskell-mode-generate-tags nil t)))
  :config (progn
            (cl-pushnew "[/\\\\]\\.devenv\\'" lsp-file-watch-ignored-directories)
            (cl-pushnew "[/\\\\]\\.direnv\\'" lsp-file-watch-ignored-directories))
  :hook ((haskell-mode . interactive-haskell-mode)
         (interactive-haskell-mode . subword-mode)
         (interactive-haskell-mode . company-mode)
         (interactive-haskell-mode . company-quickhelp-mode)
         (interactive-haskell-mode . smartparens-strict-mode)
         (interactive-haskell-mode . lsp-deferred)
         (lsp-mode . lsp-ui-mode)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-after-initialize . haskell-hoogle-start-server)
         (interactive-haskell-mode . my-haskell-mode-hook))
  :bind (:map interactive-haskell-mode-map
              ("M-." . lsp-ui-peek-find-definitions)
              ("M-?" . lsp-ui-peek-find-references)
              ("C-c i" . lsp-ui-imenu)
              :map lsp-ui-mode-map
              ("C-c h" . lsp-ui-doc-show))
  :custom
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-max-height 50)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-sideline-enable t)
  (lsp-ui-flycheck-list-position 'top)
  (lsp-ui-flycheck-live-reporting t)
  (lsp-ui-peek-enable t)
  (read-process-output-max 16384)
  (gc-cons-trashold 10000000)
  (haskell-process-suggest-hoogle-imports nil)
  (haskell-hoogle-server-command (lambda (port) (list "stack" "hoogle" "--" "server" "--local" "--port" (number-to-string port))))
  (haskell-interactive-popup-errors nil)
  :ensure t
  :ensure haskell-mode
  :ensure company
  :ensure company-ghci
  :ensure company-cabal
  :ensure company-quickhelp
  :ensure treemacs
  :ensure treemacs-all-the-icons
  :ensure lsp-mode
  :ensure lsp-ui
  :ensure lsp-haskell
  :ensure which-key)

(provide 'init-haskell)
