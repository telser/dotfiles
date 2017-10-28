;;; Package --- Summary:
;;; Emacs lisp mode

;;; Commentary:
;;; Code:

(defun recompile-elisp ()
  "Recompile the current elisp buffer."
  (when (file-exists-p (byte-compile-dest-file buffer-file-name))
    (emacs-lisp-byte-compile)))

(defun recompile-elisp-on-save ()
  "Recompile elisp file when saving."
  (add-hook 'after-save-hook 'recompile-elisp nil t))

(defun elisp-mode-setup ()
  "Settings for elisp mode."
  (diminish 'eldoc-mode)
  (eldoc-mode 1)
  (diminish 'paredit-mode)
  (enable-paredit-mode)
  (recompile-elisp-on-save)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook 'elisp-mode-setup)
;;; elisp-custom.el ends here
