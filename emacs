;; Setup personal macro for the electric buffer list
(global-set-key "\C-xb" 'electric-buffer-list)

;; Some things I like to make my source code not look terrible
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)
(show-paren-mode 1)

;; Hush emacs on startup
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

(global-font-lock-mode 1)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)


;; auto-fill mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq default-fill-column 80)

;;haskell
;; CC's old setup
(add-to-list 'load-path "/usr/share/emacs/site-lisp/haskell-mode/")
(add-to-list 'load-path "/home/<USERNAME>/")
(load "haskell-mode-autoloads.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(require 'hs-lint)
;;(defun my-hlint-hook ()
;;  (local-set-key "\C-cl" 'hs-lint))
;;(add-hook 'haskell-mode-hook 'my-hlint-hook)

;;ocaml
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;;(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
;;  "Configuration of imenu for tuareg" t)
;;(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))


;; useful utils

(defun comment-stamp ()
  "Inserts my Initials and a date into the active buffer"
  (interactive)
  (insert (format-time-string "[JTT %d-%m-%y]")))

(defun source-stamp ()
  "Inserts my full name and an ISO timestamp into the active buffer"
  (interactive)
  (insert
  (concat
   (format-time-string "Jordan Thayer  %Y-%m-%dT%T")
   ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
    (format-time-string "%z")))))

(defun my-completion (left right)
  "Meant to filter out completion-ignored-extensions in eshell tab completion"
  (let ((exts completion-ignored-extensions)
        (found nil))
    (while exts
      (when (string-match (concat "\\" (car exts) "$") right)
        (setq found t)
        (setq exts nil))
      (setq exts (cdr exts)))
    (if found
        nil
      (file-newer-than-file-p left right))))

(setq completion-ignored-extensions
      '("~" ".dvi" ".aux" ".o" ".hi" ".class" ".tmp"))


(setq eshell-cmpl-compare-entry-function 'my-completion)

(add-hook
 'eshell-mode-hook
 (lambda ()
     (setq pcomplete-compare-entry-function nil)
     (setq eshell-cmpl-compare-entry-function nil)
     (setenv "PAGER" "cat")))
