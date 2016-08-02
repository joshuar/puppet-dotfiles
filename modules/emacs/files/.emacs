;;
;; package.el
;;
(when (> emacs-major-version 24)
  (load "package")
  (package-initialize)
  (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			   ("marmalade" . "https://marmalade-repo.org/packages/")
			   ("melpa" . "https://melpa.org/packages/")))

  ;; use-package
  (require 'use-package)
  (setq use-package-always-ensure t)
  (require 'diminish)
  (require 'bind-key)

  ;; Derive PATH from shell
  (use-package exec-path-from-shell)

  ;; Powerline
  (use-package powerline
    :init
    (require 'powerline)
    :config
    (powerline-default-theme))

  ;; Symon - system monitor in minibuffer when idle
  (use-package symon
    :init
    (require 'symon)
    :config
    (symon-mode))

  ;; use dynamic-fonts package to pick some good
  ;; default fonts
  (use-package dynamic-fonts
    :config
    (dynamic-fonts-setup))

  ;; better minibuffer auto-complete and navigation
  (use-package smex
    :config
    (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
    (smex-initialize)
    :bind
    (("M-x" . smex)
     ("M-X" . smex-major-mode-commands)))

  ;; better large file support
  (use-package vlf
    :init
    (require 'vlf-setup))

  ;; use auto-completion
  (use-package auto-complete
    :init
    (require 'auto-complete-config)
    :config
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/ac-dict")
    (ac-config-default))

  ;; anzu - better search/replace
  (use-package anzu
    :config
    (global-anzu-mode +1)
    (global-set-key [remap query-replace] 'anzu-query-replace)
    (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

  ;; smooth-scrolling
  (use-package sublimity
    :if window-system
    :init
    (require 'sublimity)
    (require 'sublimity-scroll)
    :config
    (sublimity-mode 1))

  ;; indent guides
  (use-package indent-guide
    :init
    (require 'indent-guide)
    :config
    (indent-guide-global-mode))

  ;; use rainbow-delimiters
  (use-package rainbow-delimiters
    :config
    (progn
      (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))

  ;; use flycheck
  (use-package flycheck
    :config
    (progn
      (add-hook 'after-init-hook 'global-flycheck-mode)))

  ;; highlight current line number
  (use-package hlinum
    :config
    (hlinum-activate))

  ;; use go-mode
  (use-package go-mode
    :config
    (add-hook 'before-save-hook 'gofmt-before-save)
    (if (not (string-match "go" compile-command))
	(set (make-local-variable 'compile-command)
	     "go generate && go build -v && go test -v && go vet"))
    (use-package go-complete
      :config
      (require 'go-complete)
      (add-hook 'completion-at-point-functions 'go-complete-at-point))
    :bind
    ("M-." . godef-jump))


  ;; use php-mode
  (use-package php-mode
    :mode
    ("\\.php\\'" . php-mode))

  ;; use markdown-mode
  (use-package markdown-mode
    :config
    (progn
      (add-hook 'markdown-mode-hook 'turn-on-auto-fill))
    :mode
    ("\\.markdown\\'" . markdown-mode)
    ("\\.md\\'" . markdown-mode)
    ("README\\.md\\'" . gfm-mode))

  ;; use yaml-mode
  ;; use markdown-mode
  (use-package yaml-mode
    :mode
    ("\\.yml$" . yaml-mode)
    ("\\.yaml$" . yaml-mode))

  ;; use json-mode
  (use-package json-mode
    :mode "\\.json$")
  (use-package json-reformat)

  ;; use php-mode
  (use-package php-mode
    :mode "\\.php$")

  ;; use apache-mode
  (use-package apache-mode
    :mode
    ("\\.htaccess\\'"   . apache-mode)
    ("httpd\\.conf\\'"  . apache-mode)
    ("srm\\.conf\\'"    . apache-mode)
    ("access\\.conf\\'" . apache-mode)
    ("sites-\\(available\\|enabled\\)/" . apache-mode))

  ;; use nginx-mode
  (use-package nginx-mode)

  ;; use rspec-mode
  (use-package rspec-mode
    :config
    (progn
      (autoload 'rspec-mode "rspec-mode")))

  ;; use cperl-mode
  (use-package cperl-mode
    :init
    (defalias 'perl-mode 'cperl-mode))

  ;; use ruby modes
  (use-package ruby-mode
    :mode "\\.rb\\'"
    :interpreter "ruby")
  (use-package ruby-tools)
  (use-package ruby-additional)

  ;; use python mode
  (use-package python
    :mode ("\\.py\\'" . python-mode)
    :interpreter ("python" . python-mode))

  ;; elasticsearch/logstash
  (use-package es-mode)
  (use-package logstash-conf)

  ;; use rpm spec file mode
  (use-package rpm-spec-mode)

  ;; dockerfile mode
  (use-package dockerfile-mode
    :init
    (require 'dockerfile-mode)
    :mode
    ("Dockerfile\\'" . dockerfile-mode))

  ;; use xterm-color
  (use-package xterm-color)

  ;; themes
  (use-package hc-zenburn-theme)
  (use-package ample-zen-theme
    :config
    (load-theme 'ample-zen :no-confirm))

  ;; Disable some modes in text-mode:
  ;;  - flycheck-mode
  ;;  - ac-mode
  (remove-hook 'text-mode 'ac-mode)

  )

;;
;; GENERAL SETTINGS
;;

;; CUA Mode - "normal" copy/cut/paste
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(global-set-key (kbd "<mouse-2>") 'x-clipboard-yank) ;; paste with middle-mouse key from clipboard

;; Tweak file-name completion:
;; - make it case-insensitive
;; - make it exclude some file extensions
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(mapc (lambda (x)
	(add-to-list 'completion-ignored-extensions x))
      '(".aux" ".bbl" ".blg" ".exe"
	".log" ".meta" ".out" ".pdf"
	".synctex.gz" ".tdo" ".toc"
	"-pkg.el" "-autoloads.el"
	        "Notes.bib" "auto/"))

;; Don't display a start screen, don't add any text to scratch buffer
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; Get rid of unnecesssary toolbars
(tool-bar-mode -1)

;; Turn this off, it's slow
(global-auto-revert-mode -1)

;; No tabs!
(setq tab-width 2
      indent-tabs-mode nil)

;; Indicate empty lines
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Reduce time to echo keystrokes
;; Use echo area for all dialogs
;; Don't beep!
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)

;; Typing when the mark is active will write over the marked region
(delete-selection-mode t)

;; Default to text-mode for files that aren't
;; automatically recognised
(setq-default major-mode 'text-mode)

;; To support TERM=gnome-256color
(defun terminal-init-gnome ()
  "Terminal initialization function for screen."
  ;; Use the xterm color initialization code.
  (tty-run-terminal-initialization (selected-frame) "rxvt")
  (tty-run-terminal-initialization (selected-frame) "xterm"))

;; set frame title to display file name or buffer name
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-by-copying-when-linked t ; preserve hardlinks
 backup-by-copying-when-mismatch t ; preserve the owner and group of the file
 backup-directory-alist
 '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; the most annoying thing...
(defalias 'yes-or-no-p 'y-or-n-p)

;; delete trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; always require newline at end of file
(setq require-final-newline 't)

;; display various non-editing buffers in their own frames
(setq special-display-buffer-names
      (nconc '("*Backtrace*" "*VC-log*" "*compilation*" "*grep*")
             special-display-buffer-names))


;; this is a function that automatically add a generated ChangeLog.
(defun my-rpm-changelog-increment-version ()
  (interactive)
  (goto-char (point-min))
  (let* ((max (search-forward-regexp rpm-section-regexp))
         (version (rpm-spec-field-value "Version" max)))
    (rpm-add-change-log-entry (concat "Upgrade version to " version))
    )
  )

;; C-x k will kill a buffer when using emacsclient
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))

;;
;; MODES
;;

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; add line numbers in left margin
(global-linum-mode 1)


;; rst-mode
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.txt\\'" . rst-mode)
                ("\\.rst\\'" . rst-mode)
                ("\\.rest\\'" . rst-mode)) auto-mode-alist))

;; ini file mode
(autoload 'conf-mode "conf-mode")
(add-to-list 'auto-mode-alist '("\\.ini\\'" . conf-mode))

;; make sure duplicate file names (from different
;; directories) are uniquely displayed
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; save place in files between editing sessions
(require 'saveplace)
(setq-default save-place t
              save-place-file (concat user-emacs-directory "places"))
(setq server-visit-hook (quote (save-place-find-file-hook)))

;; save minibuffer input, among other things
(savehist-mode 1)

;; disable overwrite-mode
(put 'overwrite-mode 'disabled t)

;;
;; KEYBINDINGS
;;

(global-set-key "\C-[[1;3C" 'kill-word)
(global-set-key "\C-[[1;3D" 'backward-kill-word)
(global-set-key "\C-[[1;5C" 'forward-word)
(global-set-key "\C-[[1;5D" 'backward-word)
(global-set-key (kbd "C-c l") 'goto-line)
(global-set-key (kbd "C-c f") 'fill-region)
(global-set-key (kbd "C-c q") 'refill-mode)

;;
;; FUNCTIONS
;;

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(package-selected-packages (quote (use-package)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 102 :width normal)))))

;; Local Variables:
;; mode: lisp
;; End:
