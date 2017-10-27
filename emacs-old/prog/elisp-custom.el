;;;; Emacs lisp mode

(defun recompile-elisp ()
  "Recompile the current elisp buffer."
  (when (file-exists-p (byte-compile-dest-file buffer-file-name))
    (emacs-lisp-byte-compile)))

(defun recompile-elisp-on-save ()
  "Recompile elisp file when saving."
  (add-hook 'after-save-hook 'recompile-elisp nil t))

(defun elisp-mode-setup ()
  "Settings for elisp mode."
  (turn-on-eldoc-mode)
  (rainbow-delimiters-mode +1)
  (recompile-elisp-on-save)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook 'elisp-mode-setup)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
