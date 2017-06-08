;;; packages.el --- scysco layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Jesus Sanchez <scysco@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst scysco-packages
  '(
    color-theme-sanityinc-tomorrow
    linum
    linum-relative
    hlinum
    crosshairs
    ))

(defun scysco/init-color-theme-sanityinc-tomorrow()
  (load-theme 'sanityinc-tomorrow-bright t)
  )
(defun scysco/post-init-linum()
  (use-package linum
    :config
    (progn
    (set-face-foreground 'linum "#333333"))
    ))
(defun scysco/post-init-linum-relative()
  (use-package linum-relative
    :init
    (linum-relative-toggle)
    :config
    (progn
      (setq linum-relative-current-symbol ""))
    ))
(defun scysco/init-hlinum()
  (use-package hlinum
    :init
    (hlinum-activate)
    :config
    (progn
      (set-face-background 'linum-highlight-face "#000000")
      (set-face-foreground 'linum-highlight-face "#8E510F"))
    ))
(setq dotspacemacs-line-numbers t)
(defun scysco/init-crosshairs()
  (use-package crosshairs
    :init
    (crosshairs-mode 1)
    :config
    (progn
      (set-face-background 'hl-line "#1C1C1C")
      (set-face-background 'col-highlight "#1C1C1C"))
    ))
;;; packages.el ends here
