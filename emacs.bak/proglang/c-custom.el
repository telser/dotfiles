;;; Package --- Summary:
;;; C Mode
;;;

;;; Commentary:

;;; Code:

(defun clang-and-irony-flycheck ()
  "Turn on clang analyzer and irony in flycheck."
  (with-eval-after-load 'flycheck
    (require 'flycheck-clang-analyzer)
    (flycheck-clang-analyzer-setup)
    '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(defun company-irony-setup ()
  "Setup company-mode with irony"
  (require 'company-irony-c-headers)
   ;; Load with `irony-mode` as a grouped backend
  (eval-after-load 'company
    '(add-to-list
      'company-backends '(company-irony-c-headers company-irony))))

(defun c-mode-setup ()
  "Configuration for 'c-mode'."
  (add-to-list 'company-backends 'company-c-headers)
  (company-irony-setup)
  (irony-mode +1)
  (cmake-ide-setup)
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(defun c++-mode-setup ()
  "Configuration for c++-mode."
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
  (company-irony-setup)
  (irony-mode +1)
  (cmake-ide-setup)
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(defun cmake-mode-setup ()
  "Configuration for cmake-mode."
  (require 'cmake-mode)
  (require 'company-mode)
  (cmake-ide-setup)
  (autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

;; Customization

(add-hook 'c-mode-hook 'c-mode-setup)
(add-hook 'c++-mode-hook 'c++-mode-setup)
(add-hook 'cmake-mode-hook 'cmake-mode-setup)

;;; c-custom.el ends here
